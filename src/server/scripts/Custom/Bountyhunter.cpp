#include "ScriptPCH.h"
#include <cstring>
#include <string.h>

#define SELECT_BOUNTY "I would like to place a bounty!"
#define NVM "Goodbye."
#define WIPE_BOUNTY "[GM] Truncate bounties table!!"

#define EXPIRE_TIME_SECS 3600 // 1 hour expire time
#define MONEY_TAX 0.90
#define BOUNTY_LIMIT 64
#define BOUNTY_MARKER 62374

// list of bounty prices.
uint32 bountyPrices[] = {10, 20, 40, 100, 200, 500, 1000};

uint32 bountyPriceOptions = sizeof(bountyPrices) / sizeof(uint32);

enum BountyGossipText
{
    BOUNTY_TEXT_HELLO = 11100,
    BOUNTY_TEXT_FULL = 11101,
    BOUNTY_TEXT_PRICES = 11102,
    BOUNTY_TEXT_NO_BOUNTIES = 11103, 
    BOUNTY_TEXT_JUST_RAN_OUT = 11104,
    BOUNTY_TEXT_BOUNTY_LIST = 11105, 
    BOUNTY_TEXT_BOUNTY_INFO = 11106,
    BOUNTY_TEXT_ERROR_HAPPENED = 11107,
};

enum BountyGossipMenuOptions
{
    OPTION_SELECT_BOUNTY = GOSSIP_ACTION_INFO_DEF + 1,
    OPTION_SHOW_BOUNTIES = GOSSIP_ACTION_INFO_DEF + 2,
    OPTION_GOODBYE = GOSSIP_ACTION_INFO_DEF + 3,
    OPTION_TRUNCATE = GOSSIP_ACTION_INFO_DEF + 4,
    GOSSIP_PRICE_START = GOSSIP_ACTION_INFO_DEF + 5,
};

uint32 GOSSIP_PRICE_MAX = GOSSIP_ACTION_INFO_DEF + 5 + bountyPriceOptions;
uint32 GOSSIP_AFTER_PRICES = GOSSIP_ACTION_INFO_DEF + 6 + bountyPriceOptions;

struct BountyData
{
    uint32 guid;
    uint32 posterguid;
    uint32 money;
    time_t expiretime;
    uint32 index;
};


static std::map<uint32, BountyData> bountyMap;

uint32 bountyIndex[BOUNTY_LIMIT] = {0};


uint32 findUnusedIndex() {
    for(uint32 i = 0; i < BOUNTY_LIMIT; i++) {
        if(bountyIndex[i] == 0) {
            return i;
        }
    }
    return BOUNTY_LIMIT;
}


BountyData* getBountyByGuid(uint32 guid)
{
    std::map<uint32, BountyData>::iterator itr = bountyMap.find(guid);
    return (itr != bountyMap.end()) ? &itr->second : NULL;
}

BountyData* FindBountyByIndex(uint32 index) {
    std::map<uint32, BountyData>::iterator itr = bountyMap.begin();
    uint32 pos = 0;
    for(; itr != bountyMap.end(); ++itr, pos++) {
        if (pos == index) {
            return &itr->second;
        }
    }
    return NULL;
}


std::string UInt32ToString(uint32 integer) {
    std::stringstream out;
    out << integer;
    return out.str();
}

class BountyHunter : public CreatureScript
{
    private:
        void LoadBounties() 
        {
            uint32 oldMSTime = getMSTime();
            time_t currentTime = time(NULL);
            
            QueryResult result = CharacterDatabase.Query("SELECT * FROM bounties");
            if(!result)
            {
                sLog->outString(">> Loaded 0 bounties.");
                sLog->outString();
                return;
            }
            
            Field *fields;
            uint32 count = 0;
            do
            {
                fields = result->Fetch();
                BountyData bounty;
                bounty.guid = fields[0].GetUInt32();
                bounty.posterguid = fields[1].GetUInt32();
                bounty.money = fields[2].GetUInt32();
                bounty.expiretime = fields[3].GetUInt64();
                
                if(bounty.expiretime < currentTime) 
                {
                    sLog->outError("Bounty on %u from %u has expired! Deleting from DB...", bounty.guid, bounty.posterguid);
                    ExpireBounty(&bounty, true);
                } 
                else 
                {
                    bounty.index = count;
                    bountyIndex[bounty.index] = bounty.guid;
                    bountyMap[bounty.guid] = bounty;
                    
                    count++;
                }
            } while(result->NextRow());
            
            sLog->outString(">> Loaded %u bounties in %u ms!", count, GetMSTimeDiffToNow(oldMSTime));
            sLog->outString();
        }
        
        void SaveAllBounties() {
            if(bountyMap.size() == 0) {
                CharacterDatabase.Execute("TRUNCATE TABLE bounties");
                return;
            }
            time_t currentTime = time(NULL);
            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            trans->Append("TRUNCATE TABLE bounties");
            
            std::map<uint32, BountyData>::iterator iter;
            std::map<uint32, BountyData>::iterator end;
            for(iter = bountyMap.begin(), end = bountyMap.end(); iter != end; ++iter) {
                BountyData *bounty = &iter->second;
                if(bounty->expiretime < currentTime) 
                {
                    ExpireBounty(bounty);
                    bountyMap.erase(iter);
                } 
                else 
                {
                    trans->PAppend("INSERT INTO bounties VALUES('%u', '%u', '%u', '%u')", bounty->guid, bounty->posterguid, bounty->money, bounty->expiretime);
                }
            }
            CharacterDatabase.CommitTransaction(trans);
        }
        
        void SaveBounty(BountyData *bounty) 
        {
            time_t currentTime = time(NULL);
            if(bounty->expiretime < currentTime)
            {
                ExpireBounty(bounty, true, true);
            }
            else
            {
                CharacterDatabase.PExecute("INSERT INTO bounties VALUES('%u', '%u', '%u', '%u')", bounty->guid, bounty->posterguid, bounty->money, bounty->expiretime);
            }
        }
        
        void DeleteAllBounties(Player *player) 
        {
            uint32 bountyCount = bountyMap.size();
            for(std::map<uint32, BountyData>::iterator iter = bountyMap.begin(), end = bountyMap.end(); iter != end; ++iter) 
            {
                ExpireBounty(&iter->second, true);
                bountyMap.erase(iter);
            }
            player->GetSession()->SendNotification("%i bounties have been deleted!", bountyCount);
        }
        
        bool isPlayerOnline(uint32 guid) 
        {
            // a player is online when we can find them.
            return sObjectAccessor->FindPlayer(guid) != NULL;
        }
        
        void SendMoneyToCharacter(uint32 guid, std::string subject, std::string text, uint32 copper) 
        {
            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            
            MailDraft(subject, text)
                .AddMoney(copper)
                .SendMailTo(trans, MailReceiver(guid), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_AUCTION));
            
            CharacterDatabase.CommitTransaction(trans);
        }
        
        void SendMessageToCharacter(uint32 guid, std::string subject, std::string text)
        {
            SQLTransaction trans = CharacterDatabase.BeginTransaction();
            MailDraft(subject, text)
                .SendMailTo(trans, MailReceiver(guid), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_DEFAULT));
            CharacterDatabase.CommitTransaction(trans);
        }
        
        void AlertBountyExpire(BountyData *bounty) 
        {
            // Find the victim, and tell him that he no longer has a bounty posted on him.
            Player *player = sObjectAccessor->FindPlayer(bounty->guid);
            if(player) {
                player->GetSession()->SendAreaTriggerMessage("|cff00ff00The bounty on you has expired!|r");
                
                // get rid of the arrow on his head too.
                if(player->HasAura(BOUNTY_MARKER)) {
                    player->RemoveAura(BOUNTY_MARKER);
                }
            }
            
            // find the bounty poster and alert him that his bounty has expired.
            Player *pPoster = sObjectAccessor->FindPlayer(bounty->posterguid);
            if(pPoster) {
                pPoster->GetSession()->SendAreaTriggerMessage("Your bounty on |cffff0000%s|r has expired!", GetCharacterNameByGuid(bounty->guid).c_str());
            }
        }
        
        bool MoreInfoForPlayer(Player *player, uint32 uiAction) {
            if(uiAction == 1) {
                return false;
            }
            
            if (uiAction < GOSSIP_AFTER_PRICES) {
                player->PlayerTalkClass->SendCloseGossip();
            }
            
            uint32 index = uiAction - GOSSIP_AFTER_PRICES;
            if(index >= BOUNTY_LIMIT) {
                player->GetSession()->SendNotification("An error has occurred.");
                player->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            uint32 guid = bountyIndex[index];
            if(guid == 0) {
                player->GetSession()->SendNotification("That bounty no longer exists.");
                player->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            BountyData *bounty = getBountyByGuid(guid);
            if(!bounty) {
                player->GetSession()->SendNotification("That bounty no longer exists.");
                player->PlayerTalkClass->SendCloseGossip();
                return false;
            }
            
            
            // populate field
            uint32 level;
            uint8 race;
            uint8 Class;
            uint32 mapId;
            uint32 areaId;
            std::string name;
            bool offline;
            
            Player * pBounty = sObjectAccessor->FindPlayer(bounty->guid);
            if(pBounty) {
                level = pBounty->getLevel();
                race = pBounty->getRace();
                Class = pBounty->getClass();
                mapId = pBounty->GetMapId();
                areaId = pBounty->GetAreaId();
                name = pBounty->GetName();
                offline = false;
            } else {
                //                                                     0       1     2     3     4    5
                offline = true;
                QueryResult result = CharacterDatabase.PQuery("SELECT level, race, class, map, zone, name FROM characters WHERE guid = '%u'",
                        bounty->guid);
                if(!result) {
                    player->GetSession()->SendNotification("I could not find any info for that player.");
                    player->PlayerTalkClass->SendCloseGossip();
                    return false;
                }
                
                Field *fields = result->Fetch();
                level = fields[0].GetUInt32();
                race = fields[1].GetUInt8();
                Class = fields[2].GetUInt8();
                mapId = fields[3].GetUInt32();
                areaId = fields[4].GetUInt32();
                name = fields[5].GetString();
                
            }
            std::string race_s, Class_s;
            switch (race)
            {
                case RACE_HUMAN:            race_s = "Human";       break;
                case RACE_ORC:              race_s = "Orc";         break;
                case RACE_DWARF:            race_s = "Dwarf";       break;
                case RACE_NIGHTELF:         race_s = "Night Elf";   break;
                case RACE_UNDEAD_PLAYER:    race_s = "Undead";      break;
                case RACE_TAUREN:           race_s = "Tauren";      break;
                case RACE_GNOME:            race_s = "Gnome";       break;
                case RACE_TROLL:            race_s = "Troll";       break;
                case RACE_BLOODELF:         race_s = "Blood Elf";   break;
                case RACE_DRAENEI:          race_s = "Draenei";     break;
            }
            switch (Class)
            {
                case CLASS_WARRIOR:         Class_s = "Warrior";        break;
                case CLASS_PALADIN:         Class_s = "Paladin";        break;
                case CLASS_HUNTER:          Class_s = "Hunter";         break;
                case CLASS_ROGUE:           Class_s = "Rogue";          break;
                case CLASS_PRIEST:          Class_s = "Priest";         break;
                case CLASS_DEATH_KNIGHT:    Class_s = "Death Knight";   break;
                case CLASS_SHAMAN:          Class_s = "Shaman";         break;
                case CLASS_MAGE:            Class_s = "Mage";           break;
                case CLASS_WARLOCK:         Class_s = "Warlock";        break;
                case CLASS_DRUID:           Class_s = "Druid";          break;
            }
            
            std::string timeLeft = secsToTimeString(bounty->expiretime - time(NULL));
            
            int locale = player->GetSession()->GetSessionDbcLocale();
            std::string areaName = "<unknown>";
            std::string zoneName = "";
            
            MapEntry const* map = sMapStore.LookupEntry(mapId);
            std::string mapName = map->name[locale];
            
            AreaTableEntry const* area = GetAreaEntryByAreaID(areaId);
            if (area)
            {
                areaName = area->area_name[locale];

                AreaTableEntry const* zone = GetAreaEntryByAreaID(area->zone);
                if (zone)
                    zoneName = zone->area_name[locale];
            }
            std::string status;
            if(offline) {
                status = "Offline";
            } else {
                status = "Online";
            }
            if(pBounty) {
                if(pBounty->isAFK()) {
                    status += ", <AFK> "+ pBounty->afkMsg;
                } else if (pBounty->isDND()) {
                    status += ", <Busy> "+ pBounty->dndMsg;
                }
            }
            
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "General Information:", GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, " Name: "+name, GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, " Status: "+status, GOSSIP_SENDER_MAIN, 1);
            std::stringstream level_t;
            level_t << "  Level: " << level;
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, level_t.str(), GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "  Race: " + race_s, GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "  Class: " + Class_s, GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "  Time Remaining: " + timeLeft, GOSSIP_SENDER_MAIN, 1);
            
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Location Information:", GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "  Map: " + mapName, GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "  Area: " + areaName, GOSSIP_SENDER_MAIN, 1);
            if(!offline) {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "  Zone: " + zoneName, GOSSIP_SENDER_MAIN, 1);
            }
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "Back to Bounty Listings", GOSSIP_SENDER_MAIN, OPTION_SHOW_BOUNTIES);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Goodbye", GOSSIP_SENDER_MAIN, OPTION_GOODBYE);
            return true;
            //player->SEND_GOSSIP_MENU(BOUNTY_TEXT_BOUNTY_INFO, Creature->GetGUID());
        }
        
        inline bool closeGossipNotify(Player *pPlayer, std::string message) {
            pPlayer->PlayerTalkClass->SendCloseGossip();
            pPlayer->GetSession().SendNotification(message.c_str());
            return true;
        }
    
    public:
        BountyHunter() : CreatureScript("BountyHunter")
        {
            LoadBounties();
        }
        
        std::string GetCharacterNameByGuid(uint32 guid) 
        {   
            // try to find the player name by guid if they're online, else find in the DB, or return a default.
            Player *player = sObjectAccessor->FindPlayer(guid);
            if(player)
                return player->GetName();
            QueryResult result = CharacterDatabase.PQuery("SELECT name FROM characters WHERE guid = '%u'", guid);
            if(result)
                return result->Fetch()[0].GetString();
            return "<non-existant character>";
            
        }
        
        void ClaimBounty(BountyData *bounty, Player *killer, Player *victim) {
            if (bounty->expiretime < time(NULL) || victim->InArena()) {
                // bounty expired, take no action.
                return;
            }
            
            uint32 gold = bounty->money/10000;
            
            // alert the bounty poster that his bounty has been claimed.
            std::stringstream temp;
            temp << "Your " << gold << "g bounty on " << victim->GetName();
            temp << " has been collected by " << killer->GetName() << "!";
            
            Player *bountyposter = sObjectAccessor->FindPlayer(bounty->posterguid);
            if (bountyposter) {
                bountyposter->GetSession()->SendAreaTriggerMessage(temp.str().c_str());
            } else {
                SendMessageToCharacter(bounty->posterguid, temp.str(), "");
            }
            
            // alert the killer that he has collected the bounty
            killer->GetSession()->SendAreaTriggerMessage("You have collected a %ug bounty on %s!", gold, victim->GetName());
            
            // compose message
            std::string posterName = GetCharacterNameByGuid(bounty->posterguid);
            std::stringstream title;
            title << "Your reward for killing " << victim->GetName() << "!";
            std::stringstream body;
            body << "Congratulations on collecting the bounty for " << victim->GetName()  << "!\n";
            body << "Enclosed is a " << gold << "g reward for your efforts, minus expenses of course.\n\n";
            body << "Bounty Posted By: " << posterName;
            // send message & money - tax.
            SendMoneyToCharacter(killer->GetGUIDLow(), title.str(), body.str(), bounty->money * MONEY_TAX);
           
            // alert the victim that they were prey to a bounty killing.
            victim->GetSession()->SendAreaTriggerMessage("%s has collected a %ug bounty on you that was posted by %s!", killer->GetName(), gold, posterName.c_str());
            
            // announce it to the world!
            std::stringstream announce;
            announce << "|cffff00ff[BountyHunter]|r ";
            announce << "|cff00ff00|Hplayer:" << killer->GetName() << "|h[" << killer->GetName() << "]|h|r";
            announce << " has claimed ";
            announce << "|cffffa500|Hplayer:" << posterName << "|h[" << posterName << "]|h|r";
            announce << "'s bounty on ";
            announce << "|cffff0000|Hplayer:" << victim->GetName() << "|h[" <<  victim->GetName() << "]|h|r";
            announce << ", earning " << gold << "g!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, announce.str().c_str(), 0);
            
            // delete the bounty after it has been claimed.
            CharacterDatabase.PExecute("DELETE FROM bounties WHERE guid = '%u'", bounty->guid);
            bountyMap.erase(bounty->guid);
            bountyIndex[bounty->index] = 0;
        }
        
        void ClaimReverseBounty(BountyData *bounty, Player *pBounty, Player *pBountyPoster) {
            if (bounty->expiretime < time(NULL) || pBountyPoster->InArena()) {
                // bounty expired, take no action.
                return;
            }
            
            uint32 gold = bounty->money/10000;
            
            // notify involved parties about what happened.
            pBountyPoster->GetSession()->SendAreaTriggerMessage("%s has on you, claiming your %ug bounty!", pBounty->GetName(), gold);
            pBounty->GetSession()->SendAreaTriggerMessage("You have taken revenge on %s, claming their %ug bounty on you!", pBountyPoster->GetName(), gold);
            
            // compose message.
            std::stringstream title;
            title << "Your reward for exacting your revenge on " << pBountyPoster->GetName() << "!";
            
            std::stringstream body;
            body << "You've killed the person who put a bounty on your head!\n";
            body << "Enclosed is a " << gold << "g reward for your efforts & revenge, minus expenses of course.\n\n";
            body << "Bounty Posted By: " << pBountyPoster->GetName();
            
            // send message & money - tax.
            SendMoneyToCharacter(pBounty->GetGUIDLow(), title.str(), body.str(), bounty->money * MONEY_TAX);
            
            // announce it to the world
            std::stringstream announce;
            announce << "|cffff00ff[BountyHunter]|r ";
            announce << "|cff00ff00|Hplayer:" << pBounty->GetName() << "|h[" << pBounty->GetName() << "]|h|r";
            announce << " has exacted revenge upon ";
            announce << "|cffff0000|Hplayer:" << pBountyPoster->GetName() << "|h[" << pBountyPoster->GetName() << "]|h|r";
            announce << " and claimed the "  << gold << "g bounty!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, announce.str().c_str(), 0);
             
            // delete the bounty, it's been claimed.
            CharacterDatabase.PExecute("DELETE FROM bounties WHERE guid = '%u'", bounty->guid);
            bountyMap.erase(bounty->guid);
            bountyIndex[bounty->index] = 0;
        }
        
        void ExpireBounty(BountyData *bounty, bool deleteFromDb = false, bool deleteFromMap = false) 
        {
            uint32 gold = bounty->money/10000;
            
            // compose title
            std::stringstream title;
            title << "Your " << gold << "g bounty on " << GetCharacterNameByGuid(bounty->guid) << " has expired!";
            
            // send refund.
            SendMoneyToCharacter(bounty->posterguid, title.str(), "Here is a refund of your bounty, minus expenses.", bounty->money * MONEY_TAX);
            
            // alert the parties that the bounty is done
            AlertBountyExpire(bounty);
            
            // free up the bounty id
            bountyIndex[bounty->index] = 0;
            
            // delete if we are supposed to
            if(deleteFromDb)
                CharacterDatabase.PExecute("DELETE FROM bounties WHERE guid = '%u'", bounty->guid);
            if(deleteFromMap)
                bountyMap.erase(bounty->guid);
        }
        
        bool OnGossipHello(Player * player, Creature * Creature)
        {
            uint32 bountyCount = bountyMap.size();
            uint32 titleTextId = BOUNTY_TEXT_HELLO;

            if(bountyCount == BOUNTY_LIMIT) {
                // we are not excepting any more bounties.
                titleTextId = BOUNTY_TEXT_FULL;
            } else {
                // display the select bounty menu.
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, SELECT_BOUNTY, GOSSIP_SENDER_MAIN, OPTION_SELECT_BOUNTY);
            }

            if (bountyCount > 0) {
                // show the bounty count and ask if they want to see em.
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "There are "+UInt32ToString(bountyCount)+" open bounties, would you like to see them?",
                        GOSSIP_SENDER_MAIN, OPTION_SHOW_BOUNTIES
                        );
            } else {
                // set the menu text to no bounties.
                titleTextId = BOUNTY_TEXT_NO_BOUNTIES;
            }

            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, NVM, GOSSIP_SENDER_MAIN, OPTION_GOODBYE);

            if (player->isGameMaster() && bountyCount > 0)
            {
                // if the player is a GM and there are bounties active, display this option
                player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_TALK, WIPE_BOUNTY, GOSSIP_SENDER_MAIN, OPTION_TRUNCATE, "Are you sure you wish to delete all bounties?", 0, false);
            }

            player->PlayerTalkClass->SendGossipMenu(titleTextId, Creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus();
            switch(uiAction)
            {
                case OPTION_SELECT_BOUNTY:
                {
                    if(bountyMap.size() == BOUNTY_LIMIT) {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "I'll check back later, goodbye!", GOSSIP_SENDER_MAIN, OPTION_GOODBYE);
                        player->PlayerTalkClass->SendGossipMenu(BOUNTY_TEXT_JUST_RAN_OUT, creature->GetGUID());
                        return true;
                    }
                    for(uint32 i = 0, len = bountyPriceOptions; i < len; i++) {
                        uint32 bountyPrice = bountyPrices[i];
                        std::string message = "I would like to place a "+ UInt32ToString(bountyPrice) + "g bounty.";
                        player->ADD_GOSSIP_ITEM_EXTENDED(
                                GOSSIP_ICON_MONEY_BAG,
                                message,
                                GOSSIP_SENDER_MAIN,
                                GOSSIP_PRICE_START + i,
                                "", 0,
                                true // I'm not sure if coded will work with a money confirm, we'll see :O!
                                );
                    }
                    // I should probably choose a better textId.
                    player->PlayerTalkClass->SendGossipMenu(BOUNTY_TEXT_PRICES, creature->GetGUID());
                    break;
                }
                case OPTION_SHOW_BOUNTIES:
                {
                    if(bountyMap.size() == 0) {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Goodbye!", GOSSIP_SENDER_MAIN, OPTION_GOODBYE);
                        player->PlayerTalkClass->SendGossipMenu(BOUNTY_TEXT_JUST_RAN_OUT, creature->GetGUID());
                        return true;
                    }
                    time_t now = time(NULL);
                    
                    for(std::map<uint32, BountyData>::iterator iter = bountyMap.begin(), end = bountyMap.end(); iter != end; ++iter) {
                        BountyData *bounty = &iter->second;
                        if(bounty->expiretime >= now) { // only list active bounties. they will auto expire after 30s.
                            uint32 gold = bounty->money/10000;
                            std::stringstream temp;
                            temp << GetCharacterNameByGuid(bounty->guid);
                            temp << " " << gold << "g, expires in ";
                            temp << secsToTimeString(bounty->expiretime - now, true);
                            
                            player->ADD_GOSSIP_ITEM(
                                    isPlayerOnline(bounty->guid) ? GOSSIP_ICON_BATTLE : GOSSIP_ICON_TAXI,
                                    temp.str(),
                                    GOSSIP_SENDER_MAIN,
                                    GOSSIP_AFTER_PRICES + bounty->index
                            );
                        }
                    }
                    player->PlayerTalkClass->SendGossipMenu(BOUNTY_TEXT_BOUNTY_LIST, creature->GetGUID());
                    break;
                }
                case OPTION_GOODBYE:
                {
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                }
                case OPTION_TRUNCATE:
                {
                    DeleteAllBounties(player);
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                }
                default:
                {
                    player->PlayerTalkClass->ClearMenus();
                    bool show = MoreInfoForPlayer(player, uiAction);
                    if(show)
                        player->PlayerTalkClass->SendGossipMenu(BOUNTY_TEXT_BOUNTY_INFO, creature->GetGUID());
                }
            }
            return true;
        }

        bool OnGossipSelectCode(Player *pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction, const char * ccode)
        {
            pPlayer->PlayerTalkClass->ClearMenus();
            if ( uiSender == GOSSIP_SENDER_MAIN )
            {
            if (uiAction < GOSSIP_PRICE_START || uiAction >= GOSSIP_PRICE_MAX) {
                sLog->outString("Invalid action passed to bounty code.");
                return true;
            }
            // find out the corresponding bounty price
            uint32 index = uiAction - GOSSIP_PRICE_START;
            uint32 bountyPrice = bountyPrices[index] * 10000;
            
            
            // copy the string so we can edit it...
            
            std::string code = ccode;
            std::transform(code.begin(), code.end(), code.begin(), ::tolower);
            code[0] = toupper(code[0]);
            
            if(bountyMap.size() == BOUNTY_LIMIT) {
                // no more bounties can be posted.
                return closeGossipNotify(pPlayer, "Bounty list is currently full.");
            }
            
            Player *pBounty = sObjectAccessor->FindPlayerByName(code.c_str());
            if(!pBounty) {
                // we cannot add bounties to offline players.
                return closeGossipNotify(pPlayer, "That player is offline.");
            }
            if(pBounty->isGameMaster()) {
                // we cannot set bounties on game masters!
                return closeGossipNotify(pPlayer, "That player is a Game Master.");
            }
            if(pBounty->InArena()) {
                // we cannot set bounties on game masters!
                return closeGossipNotify(pPlayer, "That player is currently in an Arena Match.");
            }
            uint32 guid = pBounty->GetGUIDLow();
            BountyData *oldBounty = getBountyByGuid(guid);
            if(oldBounty) {
                // bounty was found.
                std::string gold = UInt32ToString(oldBounty->money / 10000);
                return closeGossipNotify(pPlayer, "That player already has a "+gold+"g bounty on them!");
            }
            if(pPlayer->GetGUIDLow() == guid) {
                // player is trying to hunt himself?
                return closeGossipNotify(pPlayer, "You can't set a bounty on yourself.");
            }
            
            if(pPlayer->GetMoney() < bountyPrice)
            {
                // too damn poor.
                return closeGossipNotify(pPlayer, "You don't have enough money to do that!");
            }
            
            BountyData bounty;
            bounty.guid = guid;
            bounty.expiretime = time(NULL) + EXPIRE_TIME_SECS;
            bounty.money = bountyPrice;
            bounty.posterguid = pPlayer->GetGUIDLow();
            
            AddBounty(pPlayer, pBounty, bounty);
            pPlayer->PlayerTalkClass->SendCloseGossip();
            
            }
            return true;
        }
        void AddBounty(Player *player, Player *pBounty, BountyData bounty) {
            uint32 index = findUnusedIndex();
            // we could not find an open bounty, this is very weird.
            if (index == BOUNTY_LIMIT) {
                player->GetSession()->SendNotification("An error has occurred.");
                sLog->outError("Could not find available index, even when all checks passed.");
                return;
            }
            
            // withdraw cash.
            player->SetMoney(player->GetMoney() - bounty.money);
            
            // alert world of new bounty. 
            uint32 gold = bounty.money/10000;
            
            std::stringstream announce;
            announce << "|cffff00ff[BountyHunter]|r A " << gold << "g bounty has been placed on ";
            announce << "|cffff0000|Hplayer:" << pBounty->GetName() << "|h[" << pBounty->GetName() << "]|h|r";
            announce << " by ";
            announce << "|cff00ff00|Hplayer:" << player->GetName() << "|h[" << player->GetName() << "]|h|r!";

            sWorld->SendServerMessage(SERVER_MSG_STRING, announce.str().c_str(), 0);
            
            // alert victim of bounty on his head.
            pBounty->GetSession()->SendAreaTriggerMessage("A %ug bounty has been placed on |cffff0000YOU|r by |cff00ff00%s|r! Kill the person who placed the bounty on you to clear your name.", gold, player->GetName());
            pBounty->GetSession()->SendAreaTriggerMessage("<--- |cffff0000INCOMING BOUNTY!|r --->");
            pBounty->AddAura(BOUNTY_MARKER, pBounty);
            
            player->GetSession()->SendAreaTriggerMessage("Your bounty has been successfully placed! If the player you set a bounty on kills you, he will claim your money!");
            
            // save bounty.
            bounty.index = index;
            bountyMap[bounty.guid] = bounty;
            bountyIndex[bounty.index] = bounty.guid;
            SaveBounty(&bounty);
        }
};

class BountyTimer : public WorldScript
{
    private:
        IntervalTimer m_bountyTimer;
        BountyHunter *m_bountyHunter;
    public:
        BountyTimer(BountyHunter *bountyHunter): WorldScript("BountyTimer"), m_bountyHunter(bountyHunter) {
            m_bountyTimer.SetCurrent(0);
            m_bountyTimer.SetInterval(15000);
        }
        
        void OnUpdate(uint32 diff) {
            m_bountyTimer.Update(diff);
            if(m_bountyTimer.Passed()) {
                m_bountyTimer.Reset();
                pruneBounty();
            }
            
        }
        void pruneBounty() {
            time_t currentTime = time(NULL);
            for(std::map<uint32, BountyData>::iterator iter = bountyMap.begin(), end = bountyMap.end(); iter != end; ++iter) 
            {
                BountyData *bounty = &iter->second;
                if(bounty->expiretime < currentTime) {
                    m_bountyHunter->ExpireBounty(bounty, true);
                    bountyMap.erase(iter);
                } else {
                    Player *player = sObjectAccessor->FindPlayer(bounty->guid);
                    if(player) {
                        if(player->isAlive() && !player->InArena()) { // keep refreshing the aura. 
                            player->AddAura(BOUNTY_MARKER, player);
                        }
                    }
                }
            }
        }

};

class BountyKills : public PlayerScript
{
    private:
        BountyHunter *m_bountyHunter;
    public:
        BountyKills(BountyHunter *bountyHunter) : PlayerScript("BountyKills"), m_bountyHunter(bountyHunter) {}

        void OnPVPKill(Player * killer, Player * victim)
        {
            BountyData *bounty = getBountyByGuid(victim->GetGUIDLow());
            if (bounty) {
                if(victim->GetGUIDLow() != killer->GetGUIDLow())
                    m_bountyHunter->ClaimBounty(bounty, killer, victim);
            }
                
            bounty = getBountyByGuid(killer->GetGUIDLow());
            if(!bounty)
                return;
            if (bounty && victim->GetGUIDLow() == bounty->posterguid) {
                m_bountyHunter->ClaimReverseBounty(bounty, killer, victim);
            
            }
        }
        
        void OnLogin(Player* player) 
        {
            BountyData *bounty = getBountyByGuid(player->GetGUIDLow());
            if(!bounty) {
                if(player->HasAura(BOUNTY_MARKER)) 
                    player->RemoveAura(BOUNTY_MARKER);
            } 
            else if(bounty->expiretime >= time(NULL))
            {
                if(player->isAlive() && !player->InArena())
                        player->AddAura(BOUNTY_MARKER, player);
                uint32 gold = bounty->money / 10000;
                
                player->GetSession()->SendAreaTriggerMessage(
                "A %ug bounty has been placed on |cffff0000YOU|r by |cff00ff00%s|r! Kill the person who placed the bounty on you to clear your name.", 
                        gold, m_bountyHunter->GetCharacterNameByGuid(bounty->posterguid).c_str());
            } else {
                m_bountyHunter->ExpireBounty(bounty, true, true);
            }
            
        }
};

void AddSC_BountyHunter()
{
    BountyHunter *bountyHunter = new BountyHunter();
    new BountyKills(bountyHunter);
    new BountyTimer(bountyHunter);
}


/*
 * SQL (run on WDB):
 * INSERT INTO `nefarian2_wdb`.`npc_text` (`ID`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `WDBVerified`) VALUES ('11100', 'Greetings traveler, do you wish to place a bounty on someone''s head? Well, if so, you''ve traveled to the right place, or check the available bounties? Just browse my menu options below!', NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', '1'), ('11101', 'Greetings traveler! Unfortunately, I am unable to post any new bounties at this time. However, you can browse the bounties that I have open! ', NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', NULL, NULL, '0', '0', '0', '0', '0', '0', '0', '0', '1');
 */