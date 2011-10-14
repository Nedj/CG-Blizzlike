#include "ScriptPCH.h"
#include "PvpAddon.h"

class system_hook : public PlayerScript
{
    public:
        system_hook() : PlayerScript("system_hook") {}
        
		// Hook PvP
		void OnPvPKill(Player *Killer, Player *Victim)
        {
			if (sPvpAddon->isKillingStreakArea(Killer->GetAreaId()))
				sPvpAddon->KillingStreakSystem(Killer, Victim);
        }

		// Hook Player Login
		void OnPlayerLogout(Player *Player)
		{
			sPvpAddon->CleanKillingStreak(Player);
		}

		// Hook Duel end
		void OnDuelEnd(Player *winner, Player *loser, DuelCompleteType type)
		{
		}
};

void AddSC_system_hook()
{
    new system_hook;
}