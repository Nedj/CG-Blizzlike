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
 
#ifndef _PVPADDON_H
#define _PVPADDON_H
 
#include "Log.h"
#include "Object.h"
#include "Bag.h"
#include "Creature.h"
#include "Player.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "Corpse.h"
#include "QuestDef.h"
#include "ItemPrototype.h"
#include "NPCHandler.h"
#include "DatabaseEnv.h"
#include "Mail.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include <ace/Singleton.h>
#include "Vehicle.h"
#include <string>
#include <map>
#include <limits>
#include "ConditionMgr.h"

//== KillingStreak =================================================

#define LANG_KS_WORLD_BROADCAST 20000
#define DIFF_LEVEL 5

struct KillingStreakData
{
	uint32 areaId;
	uint32 kill_required;
	uint32 item_entry;
	uint32 quantity;
	uint32 arena_point;
	uint32 honor_point;
	uint32 notification_type;
	std::string notification;
};

struct PlayerKillingStreak
{
    uint32 KillStreak;
    uint32 LastGUIDKill;
	uint32 areaId;
};

static std::map<uint32, PlayerKillingStreak> KSsystem;

enum KSNotificationType
{
	ZONE_BROADCAST = 1,
	WORLD_BROADCAST = 2,
};

		
typedef UNORDERED_MAP<uint32, KillingStreakData> KillingStreak;

class PvpAddon
{
	friend class ACE_Singleton<PvpAddon, ACE_Null_Mutex>;
	~PvpAddon();
	PvpAddon(); 
	
	public:
		void LoadPvPAddon();
		
		/* KillingStreak */
		void KillingStreakSystem(Player *pKiller, Player *pVictim);
		void LoadKillingStreak();
		bool isKillingStreakArea(uint32 areaId);
		void CleanKillingStreak(Player *pPlayer);
		void SendKSMail(Player *pKiller, uint32 itemId, uint32 quantity);
		KillingStreakData const* GetKillingStreakData(uint32 areaId, uint32 kill) const;
		 
	protected:
		KillingStreak m_killingstreak;// KillingStreak
		
	private:
		
};



#define sPvpAddon ACE_Singleton<PvpAddon, ACE_Null_Mutex>::instance()
#endif