
#include "ScriptPCH.h"
#include <cstring>

#define REWARD_SIZE 4
enum RewardType
{
	REWARD_TYPE_SINGLEITEM = 0,
	REWARD_TYPE_MULTIITEM,
	REWARD_TYPE_GOLD,
	REWARD_TYPE_LEVEL,
	REWARD_TYPE_SKILL,
	REWARD_TYPE_SPELL,
	REWARD_TYPE_TITLE,
	REWARD_TYPE_REPUTATION,
	REWARD_TYPE_ITEMSET,
	REWARD_TYPE_RENAME,
	REWARD_TYPE_CUSTOMIZE,
	REWARD_TYPE_RACECHANGE,
	REWARD_TYPE_FACTIONCHANGE,
	NUM_DONATION_TYPES,
};

class DonationScript : public WorldScript {
    private:
        IntervalTimer m_rewardTimer;
        
        void sendRewards() {
            QueryResult res = CharacterDatabase.PQuery("SELECT id,receiver,type,miscA,miscB,miscC,miscD FROM donations LEFT JOIN characters ON receiver=guid WHERE online=1");
            if(res)
            {
                do
                {
                    Field * field = res->Fetch();
                    uint32 id = field[0].GetUInt32();
                    uint32 receiver = field[1].GetUInt32();
                    uint32 type = field[2].GetUInt32();
                    uint32 misc[REWARD_SIZE];
                    misc[0] = field[3].GetUInt32();
                    misc[1] = field[4].GetUInt32();
                    misc[2] = field[5].GetUInt32();
                    misc[3] = field[6].GetUInt32();

                    Player * plr = sObjectAccessor->FindPlayer(receiver);

                    if(!plr || !plr->IsInWorld())
                        continue;

                    uint8 code = 0;
                    SQLTransaction trans = CharacterDatabase.BeginTransaction();
                    switch(type)
                    {
                    case REWARD_TYPE_GOLD:
                        plr->SetMoney(plr->GetMoney() + misc[0]);
                        break;
                                case REWARD_TYPE_RENAME:
                                        plr->SetAtLoginFlag(AT_LOGIN_RENAME);
                                        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '1' WHERE guid = '%u'", plr->GetGUIDLow());
                        break;
                                case REWARD_TYPE_CUSTOMIZE:
                                        plr->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
                                        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '8' WHERE guid = '%u'", plr->GetGUIDLow());
                        break;
                                case REWARD_TYPE_RACECHANGE:
                                        plr->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
                                        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '128' WHERE guid = '%u'", plr->GetGUIDLow());
                        break;
                                case REWARD_TYPE_FACTIONCHANGE:
                                        plr->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                                        CharacterDatabase.PExecute("UPDATE characters SET at_login = at_login | '64' WHERE guid = '%u'", plr->GetGUIDLow());
                        break;
                    case REWARD_TYPE_SINGLEITEM:
                        {
                            for(int i = 0; i < REWARD_SIZE; i++)
                            {
                                if(misc[i] == 0) continue;

                                ItemTemplate const* proto = sObjectMgr->GetItemTemplate(misc[i]);
                                if(!proto)
                                {
                                    code = 3;
                                    break;
                                }

                                ItemPosCountVec pos;
                                uint32 extra = 0;
                                uint8 r = plr->CanStoreNewItem(NULL_BAG, NULL_SLOT, pos, misc[i], 1, &extra);
                                if(r != EQUIP_ERR_OK)
                                {
                                    code = 4;
                                    MailSender sender(MAIL_NORMAL,plr->GetGUIDLow(),MAIL_STATIONERY_VAL);
                                    MailReceiver mailrecv(plr);
                                    MailDraft draft("Reward Delivery","Here is your reward.");
                                    Item * item = Item::CreateItem(misc[i],1);
                                    item->SaveToDB(trans);
                                    draft.AddItem(item);
                                    draft.SendMailTo(trans,mailrecv,sender);
                                }
                                else
                                {
                                    Item * item = plr->StoreNewItem(pos,misc[i],true);
                                    plr->SendNewItem(item,1,true,false);
                                }
                            }
                        }
                        break;
                    case REWARD_TYPE_MULTIITEM:
                        {
                            for(int i = 0; i < REWARD_SIZE; i = i + 2)
                            {
                                uint32 itemid = misc[i];
                                uint32 itemcount = misc[i+1];

                                if(itemid == 0 || itemcount == 0)
                                    continue;

                                ItemTemplate const * proto = sObjectMgr->GetItemTemplate(itemid);
                                if(!proto)
                                {
                                    code = 3;
                                    break;
                                }

                                ItemPosCountVec pos;
                                uint32 extra = 0;
                                uint32 addcount = itemcount;
                                uint8 r = plr->CanStoreNewItem(NULL_BAG,NULL_SLOT,pos,itemid,itemcount,&extra);
                                if(r != EQUIP_ERR_OK)
                                    addcount = itemcount - extra;

                                if(addcount == 0 || pos.empty())
                                {
                                    MailSender sender(MAIL_NORMAL,plr->GetGUIDLow(),MAIL_STATIONERY_VAL);
                                    MailReceiver mailrecv(plr);
                                    MailDraft draft("Reward Delivery","Here is your reward.");
                                    Item * item = Item::CreateItem(itemid,itemcount);
                                    item->SaveToDB(trans);
                                    draft.AddItem(item);
                                    draft.SendMailTo(trans,mailrecv,sender);

                                    item = plr->StoreNewItem(pos,itemid,true);
                                    plr->SendNewItem(item,addcount,true,false);
                                    code = 1;
                                }
                                else if(addcount != itemcount)
                                {
                                    //some can't be sent, send the rest by mail
                                    MailSender sender(MAIL_NORMAL,plr->GetGUIDLow(),MAIL_STATIONERY_VAL);
                                    MailReceiver mailrecv(plr);
                                    MailDraft draft("Reward Delivery","Here is your reward.");
                                    Item * item = Item::CreateItem(itemid,itemcount - addcount);
                                    item->SaveToDB(trans);
                                    draft.AddItem(item);
                                    draft.SendMailTo(trans,mailrecv,sender);

                                    item = plr->StoreNewItem(pos,itemid,true);
                                    plr->SendNewItem(item,addcount,true,false);
                                    code = 4;
                                }
                                else if(addcount == itemcount)
                                {
                                    //dont need to do anything but add
                                    plr->StoreNewItem(pos,itemid,true);
                                }
                            }
                        }
                        break;
                   // case REWARD_TYPE_ITEMSET:
                       // {
                           // uint32 set = misc[0];
                           // if(set == 0)
                           // {
                               // code = 2;
                               // break;
                           // }

                           // for(int i = 0; i < sItemSetStore.GetNumRows; i++)
                           // {
                                //ItemTemplate const* proto = sObjectMgr->GetItemTemplate(id);
                                //if(!proto)
                                    //continue;
                                //if(proto->ItemSet == set)
                                //{
                                    //ItemPosCountVec pos;
                                    //uint8 r = plr->CanStoreNewItem(NULL_BAG,NULL_SLOT,pos,proto->ItemId,1);
                                    //if(r != EQUIP_ERR_OK)
                                    //{
                                        //code = 1;
                                        //MailSender sender(MAIL_NORMAL,plr->GetGUIDLow(),MAIL_STATIONERY_VAL);
                                        //MailReceiver mailrecv(plr);
                                        //MailDraft draft("Reward Delivery","Here is your reward.");
                                        //Item * item = Item::CreateItem(i,1);
                                        //item->SaveToDB(trans);
                                        //draft.AddItem(item);
                                        //draft.SendMailTo(trans,mailrecv,sender);
                                    //}
                                    //else
                                    //{
                                        //Item * item = plr->StoreNewItem(pos,proto->ItemId,true);
                                        //plr->SendNewItem(item,1,true,false);
                                    //}
                               // }
                           // }
                       // }
                        break;
                    case REWARD_TYPE_LEVEL:
                        plr->SetLevel( plr->getLevel() + misc[0] > 80 ? 80 : plr->getLevel() + misc[0] );
                        break;
                    case REWARD_TYPE_TITLE:
                        {
                            CharTitlesEntry const* entry = sCharTitlesStore.LookupEntry(misc[0]);
                            if(!entry)
                            {
                                code = 2;
                                break;
                            }

                            plr->SetTitle(entry);
                        }
                        break;
                    case REWARD_TYPE_SPELL:
                        plr->learnSpell(misc[0],false);
                        break;
                    case REWARD_TYPE_SKILL:
                        {
                            //SkillLineEntry const* entry = sSkillLineStore.LookupEntry(misc[0]);
                            //if(!entry)
                            //{
                                code = 2;
                            //    break;
                            //}
                            //plr->SetSkill(misc[0],misc[1],400);
                        }
                        break;
                    case REWARD_TYPE_REPUTATION:
                        {
                            FactionEntry const* entry = sFactionStore.LookupEntry(misc[0]);
                            if(!entry)
                            {
                                code = 2;
                                break;
                            }
                            plr->SetReputation(entry->ID,misc[1]);
                        }
                        break;
                    }

                    WorldPacket data;
                    switch(code)
                    {
                    default:
                        ChatHandler::FillMessageData(&data, plr->GetSession(), CHAT_MSG_SYSTEM, LANG_UNIVERSAL, NULL, 0, "Thank you for your support. Enjoy your reward!", NULL);
                        break;
                    case 1:
                        ChatHandler::FillMessageData(&data, plr->GetSession(), CHAT_MSG_SYSTEM, LANG_UNIVERSAL, NULL, 0, "Thank you for your support. Your reward has been mailed to you.", NULL);
                        break;
                    case 2:
                        ChatHandler::FillMessageData(&data, plr->GetSession(), CHAT_MSG_SYSTEM, LANG_UNIVERSAL, NULL, 0, "|cffff0000Warning: Your reward could not be granted. Will try again later. :(|r", NULL);
                        break;
                    case 3:
                        ChatHandler::FillMessageData(&data, plr->GetSession(), CHAT_MSG_SYSTEM, LANG_UNIVERSAL, NULL, 0, "|cffff0000Warning: Your reward could not be granted. :(|r", NULL);
                        break;
                    case 4:
                        ChatHandler::FillMessageData(&data, plr->GetSession(), CHAT_MSG_SYSTEM, LANG_UNIVERSAL, NULL, 0, "Thank you for your support. You now have parts of your reward, the rest will arrive via mail.", NULL);
                        break;
                    }
                    plr->GetSession()->SendPacket(&data);

                    if(code != 2)
                        CharacterDatabase.PExecute("DELETE FROM donations WHERE id = %u",id);

                    plr->CastSpell(plr,19484,true);
                    CharacterDatabase.CommitTransaction(trans);
                }
                while(res->NextRow());
            }
        }
        
    public:
        DonationScript():WorldScript("DonationScript"){
            m_rewardTimer.SetCurrent(0);
            m_rewardTimer.SetInterval(30000);
        }
        
        void OnUpdate(uint32 diff) {
            m_rewardTimer.Update(diff);
            if(m_rewardTimer.Passed())
            {
                m_rewardTimer.Reset();
                sendRewards();
            }
        }
};

void AddSC_DonationScript() {
    new DonationScript();
}