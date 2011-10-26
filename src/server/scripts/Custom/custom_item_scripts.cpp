/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
 */

/* ScriptData
SDName: Custom Item_Scripts
SD%Complete:
SDComment: Items for a range of different items. See content below (in script)
SDCategory: Items
EndScriptData */

/* ContentData
item_gh_teleporter  	Teloports Player to guild house

EndContentData */

#include "ScriptPCH.h"
#include "Spell.h"


/*######
# item_gh_teleporter
# attempt to attach guild house teleport to item.
######*/

#define GH_NO_GUILDHOUSE "Your guild does not have a guild house!"
#define GH_NO_GUILD      "You should really join a guild."


class item_gh_teleporter : public ItemScript
{
public:
    item_gh_teleporter() : ItemScript("item_gh_teleporter") { }

    bool OnUse(Player *pPlayer, Item *pItem, SpellCastTargets const& targets)
    {
	    if (pPlayer->GetGuildId() == 0)
            {
	    		pPlayer->SendEquipError(GH_NO_GUILD,pItem,NULL);
                return false;
            }

        QueryResult result = CharacterDatabase.PQuery("SELECT tele_x, tele_y, tele_z, map FROM guild_houses WHERE guildid = '%d'", pPlayer->GetGuildId());
        if (!result)
        {
        	pPlayer->SendEquipError(GH_NO_GUILDHOUSE,pItem,NULL);
            return false;
        }

       float x, y, z, o;
       uint32 map;
            
       Field *fields = result->Fetch();
       x = fields[0].GetFloat();
       y = fields[1].GetFloat();
       z = fields[2].GetFloat();
       o = 0;
       map = fields[3].GetUInt32();

       pPlayer->SaveRecallPosition();
       pPlayer->TeleportTo(map, x, y, z, o);
       pPlayer->SaveToDB();


      return true;
    }

};

void AddSC_custom_item_scripts()
{

    new item_gh_teleporter();
}
