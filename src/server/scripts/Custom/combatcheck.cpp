// Place DB_CombatCheck as the scriptname for the NPC to check if player is in combat on gossip hello

#include "ScriptPCH.h"

class DB_CombatCheck : public CreatureScript
{
	public:
	DB_CombatCheck()
	: CreatureScript("DB_CombatCheck")
	{
	}

	bool OnGossipHello(Player* Player, Creature* Creature)
	{
		if (Player->isInCombat())
		{
			Player->GetSession()->SendAreaTriggerMessage("|cffff0000You are in combat|r");
			return true;
		}
		else
		{
			return false;
		}
	}
};

void AddSC_DB_CombatCheck()
{
	new DB_CombatCheck();
}