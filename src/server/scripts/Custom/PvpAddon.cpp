 /*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Copyright (C) nef2.1 deco
 * 
 */
 
#include "Common.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "UpdateMask.h"
#include "World.h"
#include "Group.h"
#include "Guild.h"
#include "ArenaTeam.h"
#include "Transport.h"
#include "Language.h"
#include "GameEventMgr.h"
#include "Spell.h"
#include "Chat.h"
#include "AccountMgr.h"
#include "InstanceSaveMgr.h"
#include "SpellAuras.h"
#include "Util.h"
#include "WaypointManager.h"
#include "GossipDef.h"
#include "Vehicle.h"
#include "AchievementMgr.h"
#include "DisableMgr.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "PoolMgr.h"
#include "ObjectMgr.h"
#include "PvpAddon.h"


PvpAddon::~PvpAddon()
{
}

PvpAddon::PvpAddon()
{
}

void PvpAddon::LoadKillingStreak()
{
	uint32 oldMSTime = getMSTime();
	
	m_killingstreak.clear();
	
	QueryResult result = WorldDatabase.Query("SELECT entry,areaId,numberOfKill,ItemEntryWin,quantity,ArenaPointWin,HonorPointWin,notificationType,notification FROM killingstreak"); 
	
	if (!result)
	{
		sLog->outString(">> Loaded 0 KillingStreak.");
		sLog->outString();
		return;
	}
	
	uint32 count = 0; 
	
	do
	{
		Field *fields = result->Fetch();
		
		uint32 entry = fields[0].GetUInt32();
		
		KillingStreakData killingstreak;
		
		killingstreak.areaId = fields[1].GetUInt32();
		killingstreak.kill_required = fields[2].GetUInt32();
		killingstreak.item_entry = fields[3].GetUInt32();
		killingstreak.quantity = fields[4].GetUInt32();
		killingstreak.arena_point = fields[5].GetUInt32();
		killingstreak.honor_point = fields[6].GetUInt32();
		killingstreak.notification_type = fields[7].GetUInt32();
		killingstreak.notification = fields[8].GetString();
		
		if (killingstreak.item_entry !=0 && killingstreak.quantity == 0)
		{
			sLog->outErrorDb("Killing Streak entry %u win item but quantity is 0", killingstreak);
			continue;
		}
		
		if(killingstreak.notification_type != ZONE_BROADCAST && killingstreak.notification_type !=WORLD_BROADCAST)
		{
			sLog->outErrorDb("Killing Streak entry %u have unknown notification type", killingstreak);
			continue;
		}
		
		m_killingstreak[entry] = killingstreak;
		
		
		++count; 
	}
	while (result->NextRow());
	
	sLog->outString(">> Loaded %u Killingstreak in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

bool PvpAddon::isKillingStreakArea(uint32 areaId)
{
	for (KillingStreak::const_iterator itr = m_killingstreak.begin(); itr != m_killingstreak.end(); ++itr)
    {
		if (itr->second.areaId == areaId)
			return true;
    }
	
	return false;
}

KillingStreakData const* PvpAddon::GetKillingStreakData(uint32 areaId, uint32 kill) const
{
	const KillingStreakData* alt = NULL;
	
	for (KillingStreak::const_iterator itr = m_killingstreak.begin(); itr != m_killingstreak.end(); ++itr)
    {
		if (itr->second.areaId == areaId && itr->second.kill_required == kill)
			return &itr->second;
    }
	
    return alt;
}


void PvpAddon::KillingStreakSystem(Player *pKiller, Player *pVictim)
{
    uint32 killerGuid = pKiller->GetGUID();
    uint32 victimGuid = pVictim->GetGUID();
                
    if(killerGuid == victimGuid) return;
    
    if ((pKiller->getLevel() - pVictim->getLevel()) < DIFF_LEVEL) return;

	if (KSsystem[killerGuid].areaId != NULL)
	{
		if (pKiller->GetAreaId() != KSsystem[killerGuid].areaId)
		{
			KSsystem[killerGuid].KillStreak = 0;
			KSsystem[killerGuid].areaId = pKiller->GetAreaId();
		}
	 }

    KSsystem[killerGuid].KillStreak++;
    KSsystem[victimGuid].KillStreak = 0;
    KSsystem[killerGuid].LastGUIDKill = victimGuid;
    KSsystem[victimGuid].LastGUIDKill = 0;

	 const KillingStreakData *killingstreak = sPvpAddon->GetKillingStreakData(pKiller->GetAreaId(), KSsystem[killerGuid].KillStreak);

	if (killingstreak == NULL)
		return;
		
	if (killingstreak->notification != "")
	{	
		char msg[500];
						
		switch (killingstreak->notification_type)
		{
			case ZONE_BROADCAST :
				sprintf(msg, killingstreak->notification.c_str(), pKiller->GetName(), killingstreak->kill_required);
				sWorld->SendZoneText(pKiller->GetZoneId(), msg);
			break;
						
			case WORLD_BROADCAST:
				sprintf(msg, killingstreak->notification.c_str(), pKiller->GetName(), killingstreak->kill_required);
				sWorld->SendWorldText(LANG_KS_WORLD_BROADCAST, msg);
			break;
						
			default:
				sLog->outErrorDb("Unknown notification type for Killingstreak entry %u" , killingstreak);
			break;
		}
	}
					
	if (killingstreak->honor_point != NULL)
		pKiller->ModifyHonorPoints(killingstreak->honor_point);
					
	if(killingstreak->arena_point != NULL)
		pKiller->ModifyArenaPoints(killingstreak->arena_point);
						
	if (killingstreak->item_entry != NULL && killingstreak->quantity != NULL)
	{
		ItemPosCountVec dest;
		uint8 msg = pKiller->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, killingstreak->item_entry, killingstreak->quantity);
						
		if (msg != EQUIP_ERR_OK)
		{
			sPvpAddon->SendKSMail(pKiller, killingstreak->item_entry, killingstreak->quantity);
			return;
		}
			
		pKiller->AddItem(killingstreak->item_entry, killingstreak->quantity);
	}
}

void PvpAddon::SendKSMail(Player *pKiller, uint32 itemId, uint32 quantity)
{
	/*uint32 noSpaceForCount = 0;
	quantity -= noSpaceForCount;
	
	std::string subject = "Votre récompense KillingStreak";
    std::string text    = "Voici un objet recu par manque de place dans votre inventaire";
                       
    uint8 mails_count = 0;
    mails_count = pKiller->GetMailSize();
                       
    // extract items
    typedef std::pair<uint32,uint32> ItemPair;
    typedef std::list< ItemPair > ItemPairs;
    ItemPairs items;
                       
    if (mails_count > 200)
    {
        ChatHandler(pKiller).PSendSysMessage("Votre boite aux lettres est pleine!");
        return;
    }
       
    ItemPrototype const* item_proto = sObjectMgr->GetItemPrototype(itemId);
    if (!item_proto)
    {
        ChatHandler(pKiller).PSendSysMessage(LANG_COMMAND_ITEMIDINVALID, itemId);
        return;
    }

    if (item_proto->MaxCount > 0 && noSpaceForCount > uint32(item_proto->MaxCount))
    {
       ChatHandler(pKiller).PSendSysMessage(LANG_COMMAND_INVALID_ITEM_COUNT, noSpaceForCount,itemId);
       return;
    }

    while (noSpaceForCount > item_proto->GetMaxStackSize())
    {
       items.push_back(ItemPair(itemId,item_proto->GetMaxStackSize()));
       noSpaceForCount -= item_proto->GetMaxStackSize();
    }

    items.push_back(ItemPair(itemId,noSpaceForCount));

    if (items.size() > MAX_MAIL_ITEMS)
    {
         ChatHandler(pKiller).PSendSysMessage(LANG_COMMAND_MAIL_ITEMS_LIMIT, MAX_MAIL_ITEMS);
        return;
    }

     // from console show not existed sender
     MailSender sender(MAIL_NORMAL,pKiller->GetSession() ? pKiller->GetGUIDLow() : 0, MAIL_STATIONERY_DEFAULT);

    // fill mail
    MailDraft draft(subject, text);

    SQLTransaction trans = CharacterDatabase.BeginTransaction();

	for (ItemPairs::const_iterator itr = items.begin(); itr != items.end(); ++itr)
	{
        if (Item* item = Item::CreateItem(itr->first,itr->second,pKiller->GetSession() ? pKiller : 0))
        {
            item->SaveToDB(trans);                               // save for prevent lost at next mail load, if send fail then item will deleted
			draft.AddItem(item);
		}
	}

    draft.SendMailTo(trans, MailReceiver(pKiller,pKiller->GetGUIDLow()), sender);
    CharacterDatabase.CommitTransaction(trans);

	ChatHandler(pKiller).PSendSysMessage("Vous n'avez pas assez de place dans votre sac. L'objet a ete envoye dans votre boite aux lettres.");*/
}

void PvpAddon::CleanKillingStreak(Player *pPlayer)
{
	uint32 pguid = pPlayer->GetGUID();
	KSsystem[pguid].LastGUIDKill = 0;
	KSsystem[pguid].KillStreak = 0;
	KSsystem[pguid].areaId = 0;
}
