#include "ScriptPCH.h"

class paw_teleporter : public CreatureScript
{
public:
	paw_teleporter()
		: CreatureScript("paw_teleporter")
	{
	}

	struct paw_teleporterAI : public ScriptedAI
	{
		paw_teleporterAI(Creature *c) : ScriptedAI(c)
		{
		}

		void Reset()
		{
			me->RestoreFaction();
		}

		void EnterEvadeMode()
        {
            me->GetMotionMaster()->Clear();
            ScriptedAI::EnterEvadeMode();
        }

	};

	CreatureAI* GetAI(Creature* pCreature) const
    {
		return new paw_teleporterAI(pCreature);
    }

	void CreatureWhisperBasedOnBool(const char *text, Creature *pCreature, Player *pPlayer, bool value)
	{
		if (value)
			pCreature->MonsterWhisper(text, pPlayer->GetGUID());
	}

	void MainMenu(Player *pPlayer, Creature *pCreature)
	{
				pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Main Mall", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
				pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Gurubashi Arena", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
			if(pPlayer->HasItemCount(6782, 1) == true) // Pawaox's Development Badge
			{
				pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Test 1", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
				pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Test 2", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
				pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "T3st 3", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
			}
			if(pPlayer->getClass() == 3) // Hunter
			{
				pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Hunter Pets", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
			}
		pPlayer->SEND_GOSSIP_MENU(907, pCreature->GetGUID());
	}

	bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
		MainMenu(pPlayer, pCreature);

        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
		if (pPlayer->isInCombat())
		{
			pCreature->MonsterWhisper("You are in combat!", pPlayer->GetGUID());
			pPlayer->CLOSE_GOSSIP_MENU();

			return true;
		}

		pPlayer->PlayerTalkClass->ClearMenus();

		switch (uiAction)
		{
			case GOSSIP_ACTION_INFO_DEF + 1: // Main Mall
				pPlayer->CLOSE_GOSSIP_MENU();
			if (pPlayer->GetTeam() == ALLIANCE)
			{
				pPlayer->TeleportTo(0, -4937.8139f, -935.227539f, 503.5f, 5.407766f);
            }
	        if (pPlayer->GetTeam() == HORDE)
			{
				pPlayer->TeleportTo(1, 1520.051025f, -4413.70947f, 16.99f, 0.0463f);
			}
				break;
			case GOSSIP_ACTION_INFO_DEF + 2: // Gurubashi
				pPlayer->CLOSE_GOSSIP_MENU();
			if (pPlayer->GetTeam() == ALLIANCE)
			{
				pPlayer->TeleportTo(0, -13215.3681f, 202.7399f, 43.01f, 1.4667f);
            }
	        if (pPlayer->GetTeam() == HORDE)
			{
				pPlayer->TeleportTo(0, -13257.211914f, 224.172562f, 43.01f, 0.8148f);
			}
				break;
			case GOSSIP_ACTION_INFO_DEF + 3: // Test 1
				pPlayer->CLOSE_GOSSIP_MENU();
			if (pPlayer->GetTeam() == ALLIANCE)
			{
            }
	        if (pPlayer->GetTeam() == HORDE)
			{
			}
				break;
			case GOSSIP_ACTION_INFO_DEF + 4: // Test 2
				pPlayer->CLOSE_GOSSIP_MENU();
			if (pPlayer->GetTeam() == ALLIANCE)
			{
            }
	        if (pPlayer->GetTeam() == HORDE)
			{
			}
				break;
			case GOSSIP_ACTION_INFO_DEF + 5: // Test 3
				pPlayer->CLOSE_GOSSIP_MENU();
			if (pPlayer->GetTeam() == ALLIANCE)
			{
            }
	        if (pPlayer->GetTeam() == HORDE)
			{
			}
				break;
			case GOSSIP_ACTION_INFO_DEF + 6: // Hunter Pets
				pPlayer->CLOSE_GOSSIP_MENU();
			{
				pPlayer->TeleportTo(532, -11010.2724f, -1975.7115f, 275.01f, 5.662f);
            }
		}
        return true;
	}
};

void AddSc_Script_PawTeleporter()
{
	new paw_teleporter();
}