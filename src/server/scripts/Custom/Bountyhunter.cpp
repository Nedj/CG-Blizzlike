#include "ScriptPCH.h"
#include <cstring>

#define BOUNTY_1 "I would like to place a 20g bounty."
#define BOUNTY_2 "I would like to place a 40g bounty."
#define BOUNTY_3 "I would like to place a 100g bounty."
#define BOUNTY_4 "I would like to place a 200g bounty."
#define PLACE_BOUNTY "I would like to place a bounty."
#define LIST_BOUNTY "List the current bounties."
#define NVM "Nevermind"
#define WIPE_BOUNTY "Wipe bounties"

//these are just visual prices, if you want to to change the real one, edit the sql further below
enum BountyPrice
{
	BOUNTY_PRICE_1 = 20,
	BOUNTY_PRICE_2 = 40,
	BOUNTY_PRICE_3 = 100,
	BOUNTY_PRICE_4 = 200,
};


bool passChecks(Player * pPlayer, const char * name)
{ 

	Player * pBounty = sObjectAccessor->FindPlayerByName(name);
	WorldSession * m_session = pPlayer->GetSession();
	if(!pBounty)
	{
		m_session->SendNotification("The player is offline or doesn't exist!");
		return false;
	}
	QueryResult result = CharacterDatabase.PQuery("SELECT * FROM bounties WHERE guid ='%u'", pBounty->GetGUID());
	if(result)
	{
		m_session->SendNotification("This player already has a bounty on them!");
		return false;
	}
	if(pPlayer->GetGUID() == pBounty->GetGUID())
	{
		m_session->SendNotification("You cannot set a bounty on yourself!");
		return false;
	}
	return true;
}

void alertServer(const char * name, int msg)
{
	std::string message;
	if(msg == 1)
	{
		message = "A bounty has been placed on ";
		message += name;
		message += ". Kill them immediately to collect the reward!";
	}
	else if(msg == 2)
	{
		message = "The bounty on ";
		message += name;
		message += " has been collected!";
	}
	sWorld->SendServerMessage(SERVER_MSG_STRING, message.c_str(), 0);
}

bool hasGold(Player * Player, uint32 required)
{
	uint32 currentmoney = Player->GetMoney();
	uint32 requiredmoney = (required * 10000);
	if(currentmoney < requiredmoney)
	{
		WorldSession *m_session = Player->GetSession();
		m_session->SendNotification("You don't have enough gold!");
		return false;
	}
	Player->SetMoney(currentmoney - requiredmoney);
	return true;
}

void flagPlayer(const char * name)
{
	Player * pBounty = sObjectAccessor->FindPlayerByName(name);
	pBounty->SetPvP(true);
	pBounty->SetByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
}

class BountyHunter : public CreatureScript
{
	public:
		BountyHunter() : CreatureScript("BountyHunter"){}
		bool OnGossipHello(Player * Player, Creature * Creature)
		{
			Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, PLACE_BOUNTY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
			Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, LIST_BOUNTY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
			Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, NVM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
			if ( Player->isGameMaster() )
			{
				Player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, WIPE_BOUNTY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
			}

			Player->PlayerTalkClass->SendGossipMenu(907, Creature->GetGUID());
			return true;
		}

		bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
		{
			pPlayer->PlayerTalkClass->ClearMenus();
			switch(uiAction)
			{
				case GOSSIP_ACTION_INFO_DEF+1:
				{
					pPlayer->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_BATTLE, BOUNTY_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5, "", 0, true);
					pPlayer->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_BATTLE, BOUNTY_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6, "", 0, true);
					pPlayer->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_BATTLE, BOUNTY_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7, "", 0, true);
					pPlayer->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_BATTLE, BOUNTY_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8, "", 0, true);
					pPlayer->PlayerTalkClass->SendGossipMenu(365, pCreature->GetGUID());
					break;
				}
				case GOSSIP_ACTION_INFO_DEF+2:
				{
					QueryResult Bounties = CharacterDatabase.PQuery("SELECT * FROM bounties");
					
					if(!Bounties)
					{
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return false;
					}

					if(	Bounties->GetRowCount() > 1)
					{
						pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Bounties: ", GOSSIP_SENDER_MAIN, 1);
						do
						{
							Field * fields = Bounties->Fetch();
							std::string option;
							QueryResult name = CharacterDatabase.PQuery("SELECT name FROM characters WHERE guid='%u'", fields[0].GetUInt64());
							Field * names = name->Fetch();
							option = names[0].GetString();
							option +=" ";
							option += fields[1].GetString();
							option += "g";
							pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, option, GOSSIP_SENDER_MAIN, 1);
						}while(Bounties->NextRow());
					}
					else
					{
						pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Bounties: ", GOSSIP_SENDER_MAIN, 1);
						Field * fields = Bounties->Fetch();
						std::string option;
						QueryResult name = CharacterDatabase.PQuery("SELECT name FROM characters WHERE guid='%u'", fields[0].GetUInt64());
						Field * names = name->Fetch();
						option = names[0].GetString();
						option +=" ";
						option += fields[1].GetString();
						option += "g";
						pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, option, GOSSIP_SENDER_MAIN, 1);
						
					}
					pPlayer->PlayerTalkClass->SendGossipMenu(878, pCreature->GetGUID());
					break;
				}
				case GOSSIP_ACTION_INFO_DEF+3:
				{
					pPlayer->PlayerTalkClass->SendCloseGossip();
					break;
				}
				case GOSSIP_ACTION_INFO_DEF+4:
				{
					CharacterDatabase.PExecute("TRUNCATE TABLE bounties");
					pPlayer->PlayerTalkClass->SendCloseGossip();
					break;
				}
			}
			return true;
		}

		bool OnGossipSelectCode(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction, const char * code)
		{
			pPlayer->PlayerTalkClass->ClearMenus();
			if ( uiSender == GOSSIP_SENDER_MAIN )
			{
				if(islower(code[0]))
					toupper(code[0]);

				if(passChecks(pPlayer, code))
				{
					Player * pBounty = sObjectAccessor->FindPlayerByName(code);
					switch (uiAction)
					{
						case GOSSIP_ACTION_INFO_DEF+5:
						{
							if(hasGold(pPlayer, BOUNTY_PRICE_1))
							{
								CharacterDatabase.PExecute("INSERT INTO bounties VALUES('%u','20', '1')", pBounty->GetGUID());
								alertServer(code, 1);
								flagPlayer(code);
								pPlayer->PlayerTalkClass->SendCloseGossip();
							}
							break;
						}
							
						case GOSSIP_ACTION_INFO_DEF+6:
						{
							if(hasGold(pPlayer, BOUNTY_PRICE_2))
							{
								CharacterDatabase.PExecute("INSERT INTO bounties VALUES('%u', '40', '2')", pBounty->GetGUID());
								alertServer(code, 1);
								flagPlayer(code);
								pPlayer->PlayerTalkClass->SendCloseGossip();
							}
							break;
						}
						case GOSSIP_ACTION_INFO_DEF+7:
						{
							if(hasGold(pPlayer, BOUNTY_PRICE_3))
							{
								CharacterDatabase.PExecute("INSERT INTO bounties VALUES('%u', '100', '3')", pBounty->GetGUID());
								alertServer(code, 1);
								flagPlayer(code);
								pPlayer->PlayerTalkClass->SendCloseGossip();
							}
							break;
						}
						case GOSSIP_ACTION_INFO_DEF+8:
						{
							if(hasGold(pPlayer, BOUNTY_PRICE_4))
							{
								CharacterDatabase.PExecute("INSERT INTO bounties VALUES('%u', '200', '4')", pBounty->GetGUID());
								alertServer(code, 1);
								flagPlayer(code);
								pPlayer->PlayerTalkClass->SendCloseGossip();
							}
							break;
						}

					}
				}
				else
				{
					pPlayer->PlayerTalkClass->SendCloseGossip();
				}
			}
			return true;
		}
};


class BountyKills : public PlayerScript
{
	public:
		BountyKills() : PlayerScript("BountyKills"){}

		void OnPVPKill(Player * Killer, Player * Bounty)
		{
			if(Killer->GetGUID() == Bounty->GetGUID())
				return;

			QueryResult result = CharacterDatabase.PQuery("SELECT * FROM bounties WHERE guid='%u'", Bounty->GetGUID());
			if(!result)
				return;

			Field * fields = result->Fetch();
			switch(fields[2].GetUInt64())
			{
			case 1:
				Killer->SetMoney(Killer->GetMoney() + (BOUNTY_PRICE_1 * 10000));
				break;
			case 2:
				Killer->SetMoney(Killer->GetMoney() + (BOUNTY_PRICE_2 * 10000));
				break;
			case 3:
				Killer->SetMoney(Killer->GetMoney() + (BOUNTY_PRICE_3 * 10000));
				break;
			case 4:
				Killer->SetMoney(Killer->GetMoney() + (BOUNTY_PRICE_4 * 10000));
				break;
			}
			CharacterDatabase.PExecute("DELETE FROM bounties WHERE guid='%u'", Bounty->GetGUID());
			alertServer(Bounty->GetName(), 2);

		}
};

void AddSC_BountyHunter()
{
	new BountyHunter();
	new BountyKills();
}