# Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  Custom/combatcheck.cpp
  Custom/PvpAddon.cpp
  Custom/PvpAddon.h
  Custom/system_hook.cpp
  Custom/Bountyhunter.cpp
  Custom/trainer_alchemy.cpp
  Custom/trainer_blacksmithing.cpp
  Custom/trainer_enchanting.cpp
  Custom/trainer_engineering.cpp
  Custom/trainer_inscription.cpp
  Custom/trainer_jewelcrafting.cpp
  Custom/trainer_leatherworking.cpp
  Custom/trainer_tailoring.cpp
  Custom/petopia.cpp
  Custom/hunter_hourglass.cpp
  Custom/paw_teleporter.cpp
  Custom/arenateamranks.cpp
)

message("  -> Prepared: Custom")
