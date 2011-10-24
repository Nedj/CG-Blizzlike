#include "ScriptPCH.h"

class Hunter_Hourglass : public CreatureScript
{
public:
	Hunter_Hourglass()
		: CreatureScript("Hunter_Hourglass")
	{
	}

	struct HourglassAI : public ScriptedAI
	{
		HourglassAI(Creature *c) : ScriptedAI(c)
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
		return new HourglassAI(pCreature);
    }

	void CreatureWhisperBasedOnBool(const char *text, Creature *pCreature, Player *pPlayer, bool value)
	{
		if (value)
			pCreature->MonsterWhisper(text, pPlayer->GetGUID());
	}

	void MainMenu(Player *pPlayer, Creature *pCreature)
	{
	    if(pPlayer->getClass() == 3)
		    {
			    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Summon The Stone", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1); 
				
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
			case GOSSIP_ACTION_INFO_DEF + 1:
				pPlayer->CLOSE_GOSSIP_MENU();
                pPlayer->SummonCreature(643409, -10975.8154f, -1992.571899f, 275.5f, 0.541440f, TEMPSUMMON_TIMED_DESPAWN,30000);
				break;
		}
        return true;
	}
};



void AddSc_Script_HHourglass()
{
	new Hunter_Hourglass();
}