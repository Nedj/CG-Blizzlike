#include "ScriptPCH.h"

class Trainer_Alchemy : public CreatureScript
{
public:
	Trainer_Alchemy()
		: CreatureScript("Trainer_Alchemy")
	{
	}

	struct Trainer_AlchemyAI : public ScriptedAI
	{
		Trainer_AlchemyAI(Creature *c) : ScriptedAI(c)
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
		return new Trainer_AlchemyAI(pCreature);
    }

	void CreatureWhisperBasedOnBool(const char *text, Creature *pCreature, Player *pPlayer, bool value)
	{
		if (value)
			pCreature->MonsterWhisper(text, pPlayer->GetGUID());
	}

	void MainMenu(Player *pPlayer, Creature *pCreature)
	{
		pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Learn Alchemy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
		if(pPlayer->HasSpell(51304) == true)
		{
		pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Flask of the North Materials", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
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
			case GOSSIP_ACTION_INFO_DEF + 1: // Learn Alchemy
				pPlayer->CLOSE_GOSSIP_MENU();
				if(pPlayer->HasSpell(51304) == true)
				{
			    pCreature->MonsterWhisper("You already know Alchemy!", pPlayer->GetGUID());
				}
			        if(pPlayer->HasSpell(51304) == false)
					{
				        if(pPlayer->GetFreePrimaryProfessionPoints() == 0)
						{
		                    pCreature->MonsterWhisper("You already know two Professions!", pPlayer->GetGUID());
						}
						if(pPlayer->GetFreePrimaryProfessionPoints() == 1)
				        {
				        pPlayer->learnSpellHighRank(51304); // Grand Master Skill
				        pPlayer->learnSpellHighRank(53042); // Mixology
				        pPlayer->learnSpellHighRank(67025); // Flask of the North
						pPlayer->MonsterWhisper("You have succesfully learned Alchemy!", pPlayer->GetGUID());
						}
						if(pPlayer->GetFreePrimaryProfessionPoints() == 2)
				        {
				        pPlayer->learnSpellHighRank(51304); // Grand Master Skill
				        pPlayer->learnSpellHighRank(53042); // Mixology
				        pPlayer->learnSpellHighRank(67025); // Flask of the North
						pPlayer->MonsterWhisper("You have succesfully learned Alchemy!", pPlayer->GetGUID());
						}		
				    }
					break;
					
			case GOSSIP_ACTION_INFO_DEF + 2: // Flask of the North Materials
				pPlayer->CLOSE_GOSSIP_MENU();
				pPlayer->AddItem(36908, 4);
				pPlayer->AddItem(40411, 1);
		}
        return true;
	}
};

void AddSc_Script_TAlchemy()
{
	new Trainer_Alchemy();
}