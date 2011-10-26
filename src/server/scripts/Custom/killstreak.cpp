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
 * Copyright (C) Deco CrusadeGaming 2011
 * 
 */
#include "ScriptPCH.h"

class System_OnPvPKill : public PlayerScript
{
public:
    System_OnPvPKill() : PlayerScript("System_OnPvPKill") {}

    struct SystemInfo
    {
        uint32 KillStreak;
        uint32 LastGUIDKill;
    };

    static std::map<uint32, SystemInfo> KillingStreak;

    void OnPvPKill(Player* killer, Player* victim)
    {
        uint32 killerGUID = killer->GetGUID();
        uint32 victimGUID = victim->GetGUID();

        if (killerGUID == victimGUID || KillingStreak[killerGUID].LastGUIDKill == victimGUID)
            return;

        KillingStreak[killerGUID].KillStreak++;
        KillingStreak[victimGUID].KillStreak = 0;
        KillingStreak[killerGUID].LastGUIDKill = victimGUID;
        KillingStreak[victimGUID].LastGUIDKill = 0;

        switch (KillingStreak[killerGUID].KillStreak)
        {
            char msg[500];

            case 1:
                sprintf(msg, "[PvP System]: %s killed %s and is on a 1st kill streak. ", killer->GetName(), victim->GetName());
                sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
                break;
            case 15:
                sprintf(msg, "[PvP System]: %s killed %s and is on a 15 kill streak. ", killer->GetName(), victim->GetName());
                sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
                break;
            case 25:
                sprintf(msg, "[PvP System]: %s killed %s and is on a 25 kill streak. ", killer->GetName(), victim->GetName());
                sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
                break;
            case 50:
                sprintf(msg, "[PvP System]: Wow, %s killed %s is already on a 50 kill streak. ", killer->GetName(), victim->GetName());
                sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
                break;
            case 100:
                sprintf(msg, "[PvP System]: Amazing! %s killed %s and is on a 100 kill streak. ", killer->GetName(), victim->GetName());
                sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
                break;
            case 250:
                sprintf(msg, "[PvP System]: Incredible! %s killed %s and is on a 250 kill streak!!! CAN NO ONE STOP THE TERROR?! ", killer->GetName(), victim->GetName());
                sWorld->SendWorldText(LANG_SYSTEMMESSAGE, msg);
                break;
        }
    }
};

void AddSC_killstreak()
{
    new System_OnPvPKill;
}