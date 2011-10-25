
UPDATE `version` SET `db_version`='TDB 335.11.42' LIMIT 1;

UPDATE `spell_script_names` SET `ScriptName`='spell_marrowgar_coldflame_bonestorm' WHERE `spell_id`=72705 AND `ScriptName`='spell_marrowgar_coldflame';

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (70346,72456,72868,72869);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,70346,0,18,1,37672,0,0, '', 'Slime Puddle - target Mutated Abomination'),
(13,0,72456,0,18,1,38285,0,0, '', 'Slime Puddle - target Mutated Abomination'),
(13,0,72868,0,18,1,37672,0,0, '', 'Slime Puddle - target Mutated Abomination'),
(13,0,72869,0,18,1,38285,0,0, '', 'Slime Puddle - target Mutated Abomination');

UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=70539 WHERE `entry`=37672;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72457 WHERE `entry`=38605;
UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=72875 WHERE `entry`=38786;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72876 WHERE `entry`=38787;

UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=70539 WHERE `entry`=38285;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72457 WHERE `entry`=38788;
UPDATE `creature_template` SET `exp`=2,`spell1`=70360,`spell2`=72875 WHERE `entry`=38789;
UPDATE `creature_template` SET `exp`=2,`spell1`=72527,`spell2`=72876 WHERE `entry`=38790;

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_expunged_gas';
DELETE FROM `spell_proc_event` WHERE `entry` IN (70215,72858,72859,72860,70672,72455,72832,72833);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(70672,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0),
(72455,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0),
(72832,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0),
(72833,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0,0,0);

DELETE FROM `spell_script_names` WHERE `spell_id`=13161;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(13161, 'spell_hun_aspect_of_the_beast');

DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=23789;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(0, 23789, 8, 'Stoneclaw Totem TEST - can crash client by spawning too many totems');

-- Add spell Magma Totem TEST to disables table
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=61904;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES
(0, 61904, 8, 'Magma Totem TEST - can crash client by spawning too many totems');

-- Move a high guid to a lower one (Vyragosa)
SET @oldguid = 250006;
SET @newguid = 202602;
UPDATE `creature` SET `guid`=@newguid WHERE `guid`=@oldguid;
UPDATE `creature_addon` SET `guid`=@newguid, `path_id`=@newguid*100 WHERE `guid`=@oldguid;
UPDATE `waypoint_data` SET `id`=@newguid*100 WHERE `id`=@oldguid*100;

-- By Aokromes:
-- Orientation fix for portal from ghostlands to eastern plagelands.
UPDATE `areatrigger_teleport` SET `target_orientation`=2.255664 WHERE `id`=4386;
-- Spawn Arcane Container also on heroic mode SLab
UPDATE `gameobject` SET `spawnMask`=3 WHERE `guid`=22674;

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_rotface_mutated_infection';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(69674,'spell_rotface_mutated_infection'),
(71224,'spell_rotface_mutated_infection'),
(73022,'spell_rotface_mutated_infection'),
(73023,'spell_rotface_mutated_infection');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (67590,67602,67603,67604,65684,67176,67177,67178,65686,67222,67223,67224);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES
(67590, 'spell_powering_up'),
(67602, 'spell_powering_up'),
(67603, 'spell_powering_up'),
(67604, 'spell_powering_up'),
(65684, 'spell_valkyr_essences'),
(67176, 'spell_valkyr_essences'),
(67177, 'spell_valkyr_essences'),
(67178, 'spell_valkyr_essences'),
(67222, 'spell_valkyr_essences'),
(65686, 'spell_valkyr_essences'),
(67223, 'spell_valkyr_essences'),
(67224, 'spell_valkyr_essences');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `ConditionTypeOrReference` = 18 AND `SourceEntry` IN (65875,67303,67304,67305,65876,67306,67307,67308) ;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 65875, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 67303, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 67304, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 67305, 0, 18, 1, 34497, 2, 0, '', 'Twins Pact - Dark'),
(13, 0, 65876, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light'),
(13, 0, 67306, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light'),
(13, 0, 67307, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light'),
(13, 0, 67308, 0, 18, 1, 34496, 2, 0, '', 'Twins Pact - Light');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (65879,65916,67244,67245,67246,67248,67249,67250);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(65879, 'spell_power_of_the_twins'),
(65916, 'spell_power_of_the_twins'),
(67244, 'spell_power_of_the_twins'),
(67245, 'spell_power_of_the_twins'),
(67246, 'spell_power_of_the_twins'),
(67248, 'spell_power_of_the_twins'),
(67249, 'spell_power_of_the_twins'),
(67250, 'spell_power_of_the_twins');

UPDATE `creature_template` SET `ScriptName`='npc_vereth_the_cunning' WHERE `entry`=30944;
UPDATE `creature_template` SET `npcflag`=`npcflag`|0x1000000 WHERE `entry` in(31770,31736);
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`npcflag`=`npcflag`|0x1000000,`VehicleId`=282,`spell1`=59643,`spell2`=4342,`spell3`=4336 WHERE `entry`=31785;
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`npcflag`=`npcflag`|0x1000000,`VehicleId`=282,`spell1`=4338,`spell2`=4342,`spell3`=4336 WHERE `entry`=31784;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` in (31785,31770,31736,31784);
INSERT INTO `npc_spellclick_spells` VALUES
(31785,59656,13283,1,13283,1,0,0,0),
(31770,59654,0,0,0,1,0,0,0),
(31736,59592,13280,1,13280,1,0,0,0),
(31784,59593,0,0,0,1,0,0,0);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (59643,4338);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(59643, 'spell_q13280_13283_plant_battle_standard'),
(4338, 'spell_q13280_13283_plant_battle_standard');
DELETE FROM `gossip_menu_option` WHERE `menu_id`=1293 AND `id`=1; 
DELETE FROM `gossip_menu_option` WHERE `menu_id`=1293 AND `id`=2;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(1293,1,0, 'Make this inn my home!',8,66179,0,0,0,0,NULL),
(1293,2,1, 'I want to browse your goods!',3,66179,0,0,0,0,NULL);
-- ----------
-- Tank Class Passive Threat
-- ----------
DELETE FROM spell_linked_spell WHERE spell_effect IN (57340, 57339);
INSERT INTO spell_linked_spell VALUES
    (7376,  57339, 2, 'Defensive Stance Passive - Tank Class Passive Threat'),
    (21178, 57339, 2, 'Bear Form (Passive2) - Tank Class Passive Threat'),
    (25780, 57340, 2, 'Righteous Fury - Tank Class Passive Threat'),
    (48263, 57340, 2, 'Frost Presence - Tank Class Passive Threat');

-- ----------
-- restructure spell_threat
-- ----------
TRUNCATE TABLE `spell_threat`;
ALTER    TABLE `spell_threat` CHANGE `Threat` `flatMod` int(6);
ALTER    TABLE `spell_threat` ADD COLUMN `pctMod`   FLOAT NOT NULL DEFAULT 1.0 COMMENT 'threat multiplier for damage/healing' AFTER `flatMod`;
ALTER    TABLE `spell_threat` ADD COLUMN `apPctMod` FLOAT NOT NULL DEFAULT 0.0 COMMENT 'additional threat bonus from attack power' AFTER `pctMod`;
INSERT INTO `spell_threat` VALUES
-- Other
-- Src: SELECT id, SpellNameEN, RankEN FROM `Spell` WHERE `DescriptionEN` LIKE '%threat%' AND `SpellFamilyName` <> '0' AND NOT (Attributes & 0x40) GROUP BY SpellNameEN ORDER BY RankEN DESC;
    (5676,  0,   2.00, 0.0),  -- Searing Pain (Rank 1) (Warlock)
    (28176, 0,   0.00, 0.0),  -- Fel Armor - Heal (Rank 1) (Warlock) [Assumption]
    (8056,  0,   2.00, 0.0),  -- Frost Shock (Rank 1) (Shaman) [Assumption]
    (26688, 0,   0.00, 0.0),  -- Anesthetic Poison - Proc (Rank 1) (Rogue)
    (15237, 0,   0.00, 0.0),  -- Holy Nova - Heal (Rank 1) (Priest)
    (23455, 0,   0.00, 0.0),  -- Holy Nova - Damage (Rank 1) (Priest)
    (32546, 0,   0.50, 0.0),  -- Binding Heal (Rank 1) (Priest) [Assumption]
    (33619, 0,   0.00, 0.0),  -- Reflective Shield - Proc (Priest)
    (2139,  180, 1.00, 0.0),  -- Counterspell (Mage) [Assumption]
-- Death Knight
-- Src: http://www.tankspot.com/showthread.php?40485-Death-Knight-threat-values&p=113584#post113584
    (63611, 0,   0.00, 0.0),  -- Blood Presence - Heal
    (45524, 240, 1.00, 0.0),  -- Chains of Ice
    (43265, 0,   1.90, 0.0),  -- Death and Decay
    (49576, 110, 1.00, 0.0),  -- Death Grip
    (48743, 0,   0.00, 0.0),  -- Death Pact
    (65142, 0,   0.00, 0.0),  -- Ebon Plague
    (47568, 0,   0.00, 0.0),  -- Empower Rune Weapon
    (51209, 112, 1.00, 0.0),  -- Hungering Cold
    (49039, 110, 1.00, 0.0),  -- Lichborn
    (56815, 0,   1.75, 0.0),  -- Rune Strike
    (50422, 0,   0.00, 0.0),  -- Scent of Blood - Proc
    (55090, 51,  1.00, 0.0),  -- Scourge Strike (Rank 1)
    (55265, 63,  1.00, 0.0),  -- Scourge Strike (Rank 2)
    (55270, 98,  1.00, 0.0),  -- Scourge Strike (Rank 3)
    (55271, 120, 1.00, 0.0),  -- Scourge Strike (Rank 4)
    (49916, 138, 1.00, 0.0),  -- Strangulate
    (50181, 0,   0.00, 0.0),  -- Vendetta - Proc
-- Druid
-- Src: http://www.tankspot.com/showthread.php?47813-WOTLK-Bear-Threat-Values&p=200948#post200948
    (17057, 0,   0.00, 0.0),  -- Furor - Proc 
    (5211,  53,  1.00, 0.0),  -- Bash (Rank 3)
    (6798,  105, 1.00, 0.0),  -- Bash (Rank 2)
    (8983,  158, 1.00, 0.0),  -- Bash (Rank 1)
    (45334, 40,  1.00, 0.0),  -- Feral Charge (Bear) - Root
    (19675, 80,  1.00, 0.0),  -- Feral Charge (Bear) - Interrupt
    (34299, 0,   0.00, 0.0),  -- Improved Leader of the Pack - Heal
    (6807,  13,  1.00, 0.0),  -- Maul (Rank 1)
    (6808,  20,  1.00, 0.0),  -- Maul (Rank 2)
    (6809,  27,  1.00, 0.0),  -- Maul (Rank 3)
    (8972,  47,  1.00, 0.0),  -- Maul (Rank 4)
    (9745,  75,  1.00, 0.0),  -- Maul (Rank 5)
    (9880,  106, 1.00, 0.0),  -- Maul (Rank 6)
    (9881,  140, 1.00, 0.0),  -- Maul (Rank 7)
    (26996, 212, 1.00, 0.0),  -- Maul (Rank 8)
    (48479, 345, 1.00, 0.0),  -- Maul (Rank 9)
    (48480, 422, 1.00, 0.0),  -- Maul (Rank 10)
    (60089, 638, 1.00, 0.0),  -- Faerie Fire (Feral) - Proc
    (33745, 182, 0.50, 0.0),  -- Lacerate (Rank 1)
    (48567, 409, 0.50, 0.0),  -- Lacerate (Rank 2)
    (48568, 515, 0.50, 0.0),  -- Lacerate (Rank 3)
    (779,   0,   1.50, 0.0),  -- Swipe (Bear) (Rank 1)
    (5209,  98,  1.00, 0.0),  -- Challenging Roar
    (29166, 0,   10.0, 0.0),  -- Innervate [base is 5 per 1 mana]
-- Paladin
-- Src: http://www.tankspot.com/showthread.php?39761-Paladin-Threat-Values-(Updated-for-3.2.2)&p=103813#post103813
    (7294,  0,   2.00, 0.0),  -- Retribution Aura
    (20185, 0,   0.00, 0.0),  -- Judgement of Light
    (19742, 0,   0.00, 0.0),  -- Blessing of Wisdom (Rank 1)
    (25894, 0,   0.00, 0.0),  -- Greater Blessing of Wisdom (Rank 1)
    (20470, 0,   0.00, 0.0),  -- Righteous Fury
    (498,   0,   0.00, 0.0),  -- Divine Protection
-- Warrior
-- Src: http://www.tankspot.com/showthread.php?39775-WoW-3.0-Threat-Values-(Warrior)&p=103972#post103972
    (845,   8,   1.00, 0.0),  -- Cleave (Rank 1)
    (7369,  15,  1.00, 0.0),  -- Cleave (Rank 2)
    (11608, 25,  1.00, 0.0),  -- Cleave (Rank 3)
    (11609, 35,  1.00, 0.0),  -- Cleave (Rank 4)
    (20569, 48,  1.00, 0.0),  -- Cleave (Rank 5)
    (25231, 68,  1.00, 0.0),  -- Cleave (Rank 6)
    (47519, 95,  1.00, 0.0),  -- Cleave (Rank 7)
    (47520, 112, 1.00, 0.0),  -- Cleave (Rank 8)
    (78,    5,   1.00, 0.0),  -- Heroic Strike (Rank 1)
    (284,   10,  1.00, 0.0),  -- Heroic Strike (Rank 2)
    (285,   16,  1.00, 0.0),  -- Heroic Strike (Rank 3)
    (1608,  22,  1.00, 0.0),  -- Heroic Strike (Rank 4)
    (11564, 31,  1.00, 0.0),  -- Heroic Strike (Rank 5)
    (11565, 48,  1.00, 0.0),  -- Heroic Strike (Rank 6)
    (11566, 70,  1.00, 0.0),  -- Heroic Strike (Rank 7)
    (11567, 92,  1.00, 0.0),  -- Heroic Strike (Rank 8)
    (25286, 104, 1.00, 0.0),  -- Heroic Strike (Rank 9)
    (29707, 121, 1.00, 0.0),  -- Heroic Strike (Rank 10)
    (30324, 164, 1.00, 0.0),  -- Heroic Strike (Rank 11)
    (47449, 224, 1.00, 0.0),  -- Heroic Strike (Rank 12)
    (47450, 259, 1.00, 0.0),  -- Heroic Strike (Rank 13)
    (57755, 0,   1.50, 0.0),  -- Heroic Throw
    (6572,  7,   1.00, 0.0),  -- Revenge (Rank 1)
    (6574,  11,  1.00, 0.0),  -- Revenge (Rank 2)
    (7379,  15,  1.00, 0.0),  -- Revenge (Rank 3)
    (11600, 27,  1.00, 0.0),  -- Revenge (Rank 4)
    (11601, 41,  1.00, 0.0),  -- Revenge (Rank 5)
    (25288, 53,  1.00, 0.0),  -- Revenge (Rank 6)
    (25269, 58,  1.00, 0.0),  -- Revenge (Rank 7)
    (30357, 71,  1.00, 0.0),  -- Revenge (Rank 8)
    (57823, 121, 1.00, 0.0),  -- Revenge (Rank 9)
    (23922, 228, 1.00, 0.0),  -- Shield Slam (Rank 1)
    (23923, 268, 1.00, 0.0),  -- Shield Slam (Rank 2)
    (23924, 307, 1.00, 0.0),  -- Shield Slam (Rank 3)
    (23925, 347, 1.00, 0.0),  -- Shield Slam (Rank 4)
    (25258, 387, 1.00, 0.0),  -- Shield Slam (Rank 5)
    (30356, 426, 1.00, 0.0),  -- Shield Slam (Rank 6)
    (47487, 650, 1.00, 0.0),  -- Shield Slam (Rank 7)
    (47488, 770, 1.00, 0.0),  -- Shield Slam (Rank 8)
    (1464,  18,  1.00, 0.0),  -- Slam (Rank 1)
    (8820,  24,  1.00, 0.0),  -- Slam (Rank 2)
    (11604, 38,  1.00, 0.0),  -- Slam (Rank 3)
    (11605, 49,  1.00, 0.0),  -- Slam (Rank 4)
    (25241, 59,  1.00, 0.0),  -- Slam (Rank 5)
    (25242, 78,  1.00, 0.0),  -- Slam (Rank 6)
    (47474, 123, 1.00, 0.0),  -- Slam (Rank 7)
    (47475, 140, 1.00, 0.0),  -- Slam (Rank 8)
    (7386,  345, 1.00, 0.05), -- Sunder Armor
    (20243, 0,   1.00, 0.05), -- Devastate (Rank 1)
    (6343,  0,   1.85, 0.0);  -- Thunder Clap (Rank 1)

DELETE FROM `disables` WHERE `entry` IN (1242, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1825, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1826, 3386, 3387, 3388, 3389) AND `sourceType` = 4;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (1242, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1825, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1826, 3386, 3387, 3388, 3389);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(1242, 11, 0, 0, 'achievement_bg_av_perfection'),
(1803, 11, 0, 0, 'achievement_bg_av_perfection'),
(1804, 11, 0, 0, 'achievement_bg_av_perfection'),
(1805, 11, 0, 0, 'achievement_bg_av_perfection'),
(1806, 11, 0, 0, 'achievement_bg_av_perfection'),
(1807, 11, 0, 0, 'achievement_bg_av_perfection'),
(1808, 11, 0, 0, 'achievement_bg_av_perfection'),
(1809, 11, 0, 0, 'achievement_bg_av_perfection'),
(1810, 11, 0, 0, 'achievement_bg_av_perfection'),
(1825, 11, 0, 0, 'achievement_bg_av_perfection'),
(1811, 11, 0, 0, 'achievement_bg_av_perfection'),
(1812, 11, 0, 0, 'achievement_bg_av_perfection'),
(1813, 11, 0, 0, 'achievement_bg_av_perfection'),
(1814, 11, 0, 0, 'achievement_bg_av_perfection'),
(1815, 11, 0, 0, 'achievement_bg_av_perfection'),
(1816, 11, 0, 0, 'achievement_bg_av_perfection'),
(1817, 11, 0, 0, 'achievement_bg_av_perfection'),
(1818, 11, 0, 0, 'achievement_bg_av_perfection'),
(1819, 11, 0, 0, 'achievement_bg_av_perfection'),
(1826, 11, 0, 0, 'achievement_bg_av_perfection'),
(3386, 11, 0, 0, 'achievement_everything_counts'),
(3387, 11, 0, 0, 'achievement_everything_counts'),
(3388, 11, 0, 0, 'achievement_everything_counts'),
(3389, 11, 0, 0, 'achievement_everything_counts');
ALTER TABLE `spell_dbc` ADD COLUMN `AttributesEx6` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `AttributesEx5`;
ALTER TABLE `spell_dbc` ADD COLUMN `AttributesEx7` INT UNSIGNED NOT NULL DEFAULT '0' AFTER `AttributesEx6`;

-- Dummy effect with caster as target
DELETE FROM `spell_dbc` WHERE `id` IN (68308);
INSERT INTO `spell_dbc` (`Id`, `Attributes`, `AttributesEx`, `AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`Effect1`,`EffectImplicitTargetA1`,`EffectImplicitTargetB1`,`comment`)
VALUES
(68308, 0x09800100, 0x00000420, 0x00004005, 0x10040000, 0x00000080, 0x00000008, 0x00001000, 3, 1, 0, 'Vault of Archavon - Earth, Wind & Fire - Achievement Check');

DELETE FROM `spell_dbc` WHERE `Id`=63975;
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(63975,0,0,384,0,0,262144,128,0,0,0,0,1,0,0,0,0,0,0,0,0,13,0,-1,0,0,77,0,0,0,1,1,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,'Glyph of Blackstab - 3.2.2');

UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (4362,4363); -- The Fate of the Kingdom & The Princess's Surprise
UPDATE `quest_template` SET `NextQuestId`=4342 WHERE `entry`=4341; -- Kharan Mighthammer
UPDATE `quest_template` SET `PrevQuestId`=4341 WHERE `entry`=4342; -- Kharan's Tale
UPDATE `quest_template` SET `PrevQuestId`=4342 WHERE `entry`=4361; -- The Bearer of Bad News
UPDATE `quest_template` SET `PrevQuestId`=4361 WHERE `entry`=4362; -- The Fate of the Kingdom
UPDATE `quest_template` SET `PrevQuestId`=4362 WHERE `entry`=4363; -- The Princess's Surprise

DELETE FROM `trinity_string` WHERE `entry`=5030;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(5030, '%s attempts to run away in fear!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE `trinity_string` SET `content_default`='Faction %s (%u) can''t have reputation.' WHERE `entry`=326; -- can'nt -> can't

DELETE FROM `spell_target_position` WHERE `id` IN (17278,49097,55431);
INSERT INTO `spell_target_position` (`id` ,`target_map` ,`target_position_x` ,`target_position_y` ,`target_position_z` ,`target_orientation`) VALUES
(17278, 329, 3534.3, -2966.74, 125.001, 0.279253), -- Cannon Fire cast by a trap GO Cannonball
(49097, 0, -466.4, 1496.36, 17.43, 2.1), -- Out of Body Experience, quest with the same name (Grizzly Hills -> Silverpine)
(55431, 571, 5787.781250, -1582.446045, 234.830414, 2.14); -- Summon Gymer
-- 53821 Teach:Death Gate - couldn't find enough info

-- Fixing Lord Thorval, Lady Alistra and Amal'thazad in map 609
UPDATE `creature_template` SET `gossip_menu_id`=9691 WHERE `entry`=28471; -- Lady Alistra
UPDATE `creature_template` SET `gossip_menu_id`=9692 WHERE `entry`=28472; -- Lord Thorval
UPDATE `creature_template` SET `gossip_menu_id`=9693 WHERE `entry`=28474; -- Amal'thazad

DELETE FROM `gossip_menu` WHERE `entry`=9791 AND `text_id`=13475;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9791,13475);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9691,9692,9693,9791,10371);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9691,0,3,'I seek training, Lady Alistra.',5,16,0,0,0,0,''),
(9691,1,0,'I wish to unlearn my talents.',1,1,9791,0,0,0,''),
(9691,2,0,'Learn about Dual Talent Specialization.',1,1,10371,0,0,0,''),
(9692,0,3,'I seek training, Lord Thorval.',5,16,0,0,0,0,''),
(9692,1,0,'I wish to unlearn my talents.',1,1,9791,0,0,0,''),
(9692,2,0,'Learn about Dual Talent Specialization.',1,1,10371,0,0,0,''),
(9693,0,3,'I seek training, Amal''thazad.',5,16,0,0,0,0,''),
(9693,1,0,'I wish to unlearn my talents.',1,1,9791,0,0,0,''),
(9693,2,0,'Learn about Dual Talent Specialization.',1,1,10371,0,0,0,''),
(9791,0,0,'Yes. I do.',16,16,0,0,0,0,''),
(10371,0,0,'Purchase a Dual Talent Specialization.',18,16,0,0,0,10000000,'Are you sure you wish to purchase a Dual Talent Specialization?'); -- Fixing this entry because Dual Talent Specialization needs confirmation by players.

-- Darion Mograine DK trainer (Since the quest 'Taking back Acherus' until go to Stormwind/Orgrimmar)
-- The gossip_menu (`entry` and `text_id`) are already in TDB UP41. Only needs this changes:
UPDATE `creature_template` SET `gossip_menu_id`=10027, `trainer_class`=6 WHERE `entry`=31084;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=10027;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(10027,0,3,'I require training, Highlord.',5,16,0,0,0,0,'');

UPDATE `smart_scripts` SET `action_param1`=1,`event_flags`=1 WHERE `action_type`=25;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND ((`entryorguid`=11360 AND `id`=1) OR (`entryorguid`=27225 AND `id`=20) OR (`entryorguid`=27615 AND `id`=15));
UPDATE `smart_scripts` SET `id`=20 WHERE `entryorguid`=27225 AND `id`=21;
UPDATE `smart_scripts` SET `id`=21 WHERE `entryorguid`=27225 AND `id`=22;
DELETE FROM `creature_text` WHERE `text`='%s attempts to run away in fear!';

DELETE FROM `spell_dbc` WHERE `Id`=24677;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(24677,0,0,256,0,4,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,6,0,-1,0,0,77,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'GY Mid Trigger - 2.0.12 spell - AV Snowfall Graveyard');

UPDATE `gameobject_template` SET `data16`=1 WHERE `entry`=180418 AND `WDBVerified`=11723;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=44572;
INSERT INTO `spell_linked_spell` VALUES
(44572,71757,0, 'Deep Freeze - Damage Proc');

DELETE FROM `spell_bonus_data` WHERE `entry`=71757;
INSERT INTO `spell_bonus_data` (`entry`,`direct_bonus`,`dot_bonus`,`ap_bonus`,`ap_dot_bonus`,`comments`) VALUES
(71757,2.143,0,0,0, 'Mage - Deep Freeze');

DELETE FROM `gossip_menu` WHERE `entry`=2211 AND `text_id`=2850;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(2211, 2850);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=160445;

DELETE FROM `smart_scripts` WHERE `entryorguid`=160445 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(160445, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 12, 9136, 1, 60*1000, 0, 0, 0, 8, 0, 0, 0, -7917.378906, -2610.533936, 221.123123, 5.040257, 'Sha''ni Proudtusk''s Remains - On gossip hello summon Sha''ni Proudtusk');
-- Need a way to prevent spamming this action.

DELETE FROM `conditions` WHERE `sourceEntry` IN (62584,64185);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`)
VALUES
(13,0,62584,0,18,1,33202,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32919,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32916,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32906,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,33203,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,32918,0,0,'','target for Lifebinder\'s Gift'),
(13,0,62584,0,18,1,33215,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,33202,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32919,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32916,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32906,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,33203,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,32918,0,0,'','target for Lifebinder\'s Gift'),
(13,0,64185,0,18,1,33215,0,0,'','target for Lifebinder\'s Gift');

DELETE FROM `spell_target_position` WHERE `id` IN (46233,52462,54963);
INSERT INTO `spell_target_position` (`id` ,`target_map` ,`target_position_x` ,`target_position_y` ,`target_position_z` ,`target_orientation`) VALUES
(46233,571,3202.959961,5274.073730,46.887897,0.015704), -- Call Mammoth Orphan
(52462,609,2387.738525,-5898.617676,108.353539,4.354776), -- Hide In Mine Car
(54963,571,6153.721191,-1075.270142,403.517365,2.232988); -- Teleporter Power Cell

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_baltharus_enervating_brand';

UPDATE `item_template` SET `BuyPrice` = 40000, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 79, `spellcategorycooldown_1` = 3000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45006; -- Jillian's Tonic of Endless Rage
UPDATE `item_template` SET `BuyPrice` = 40000, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 79, `spellcategorycooldown_1` = 3000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45007; -- Jillian's Tonic of Pure Mojo
UPDATE `item_template` SET `delay` = 0, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45008; -- Jillian's Tonic of Stoneblood
UPDATE `item_template` SET `BuyPrice` = 40000, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 79, `spellcategorycooldown_1` = 3000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45009; -- Jillian's Tonic of the Frost Wyrm
UPDATE `item_template` SET `BuyPrice` = 200, `stackable` = 20, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 4, `spellcategorycooldown_1` = 60000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45276; -- Jillian's Genius Juice
UPDATE `item_template` SET `BuyPrice` = 200, `stackable` = 20, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcooldown_2` = 0, `spellcooldown_3` = 0, `spellcooldown_4` = 0, `spellcooldown_5` = 0, `spellcategory_1` = 4, `spellcategorycooldown_1` = 60000, `spellcategorycooldown_2` = 0, `spellcategorycooldown_3` = 0, `spellcategorycooldown_4` = 0, `spellcategorycooldown_5` = 0, `WDBVerified`=12340 WHERE `entry` = 45277; -- Jillian's Savior Sauce
UPDATE `item_template` SET `BuyPrice` = 6, `delay` = 0, `spellcharges_1` = -1, `spellcooldown_1` = 0, `spellcategory_1` = 11, `spellcategorycooldown_1` = 1000, `WDBVerified`=12340 WHERE `entry` = 45279; -- Jillian's Gourmet Fish Feast
UPDATE `item_template` SET `WDBVerified`=12340 WHERE `entry` =46766; -- Red War Fuel
UPDATE `item_template` SET `Quality`=0,`Flags`=65538,`WDBVerified`=12340 WHERE `entry`=10791; -- Goblin Engineer Membership Card

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (57294,57399);
INSERT INTO `spell_linked_spell` VALUES
(57294,59690,2,'Well Fed - Well Fed (DND)'),
(57399,59699,2,'Well Fed - Well Fed (DND)');

DELETE FROM `spell_group` WHERE `spell_id` IN (59690,59699);

UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~1 WHERE `unit_flags` & 1;
-- Sets SmartAI for Mechagnomes
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25814;

-- Says for Mechagnomes
DELETE FROM `creature_text` WHERE `entry`=25814;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(25814,1,1, 'We are Mechagnome...resistance is futile.',12,0,0,0,0,0, ''),
(25814,1,2, 'The flesh is weak. We will make you better, stronger...faster.',12,0,0,0,0,0, ''),
(25814,1,3, 'We can decurse you, we have the technology.',12,0,0,0,0,0, '');

-- Mechagnome SAI
-- NOTE: Mechagnome SAI required for Horde quest Souls of the Decursed 
DELETE FROM `smart_scripts` WHERE `entryorguid`=25814 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25814,0,0,0,4,0,100,0,0,0,0,0,1,1,10000,0,0,0,0,0,0,0,0,0,0,0,0, 'Fizzcrank Mechagnome - Chance Say on Aggro'),
(25814,0,1,0,8,0,100,0,45980,0,0,0,33,25773,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Fizzcrank Mechagnome - Killcredit on spellhit - Recursive'),
(25814,0,2,0,8,0,100,0,46485,0,0,0,33,26096,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Fizzcrank Mechagnome - Killcredit on spellhit - Souls of the Decursed');
-- (25814,0,2,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fizzcrank Mechagnome - On Re-Cursive Transmatter Injection spellhit despawn self'),

-- Links item spell to spawn spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=45980;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (45980,46022,0, 'Re-Cursive quest');

-- Despawn Mechagnome after spellcast (Mechagnome would not despawn using SAI resulting in possibility of multiple uses of item for credit)
DELETE FROM `spell_scripts` WHERE `id`=45980;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(45980,0,1,18,0,0,0,0,0,0,0);

-- FOR SURVIVOR

-- Sets smartAI for Fizzcrank Survivor
UPDATE `creature_template` SET `AIName` ='SmartAI' WHERE `entry`=25773;

-- Says for Fizzcrank Survivor
DELETE FROM `creature_text` WHERE `entry`=25773;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(25773,0,1, 'I survived and I''m flesh again!',12,0,0,0,0,0, ''),
(25773,0,2, 'But... but... I was perfect!',12,0,0,0,0,0, ''),
(25773,0,3, 'Where am I? Who are you? What''s that strange feeling?',12,0,0,0,0,0, ''),
(25773,0,4, 'I''m flesh and blood again! Thank you!',12,0,0,0,0,0, '');

-- Random says, Teleport spell effect & despawn
DELETE FROM `smart_scripts` WHERE `entryorguid`=25773 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25773,0,0,0,1,0,100,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 'Fizzcrank Survivor - On spawn talk'),
(25773,0,1,0,1,0,100,1,5000,5000,5000,5000,11,41232,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Fizzcrank Survivor - OOC Cast spell'),
(25773,0,2,0,1,0,100,0,5000,5000,5000,5000,41,2000,0,0,0,0,0,0,0,0,0,0,0,0,0, 'Fizzcrank Survivor - OOC Force despawn');

-- Remove Eventai and Eventai says
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (25814,25773);
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-533,-534,-535);

UPDATE `creature_template` SET `exp`=0,`speed_run`=0.78571 WHERE `entry`=28239; -- Arcane Beam
DELETE FROM `creature_template_addon` WHERE `entry`=28239;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(28239,0,0,1,0, '51019'); -- Arcane Beam

UPDATE `gameobject_template` SET `WDBVerified`=12340 WHERE `entry`=179545;
DELETE FROM `gameobject` WHERE `id` IN (179545,179485);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(6,179545,429,1,1,116.135,638.836,-48.467,-0.785397,0,0,0,1,7200,255,1),
(159,179485,429,1,1,558.806,550.065,-25.4008,3.14159,0,0,0,1,180,255,1);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`IN (65686, 65684, 67222, 67176, 67223, 67177, 67224, 67178);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(65686, -65684, 2, 'Remove Dark Essence 10M'), 
(65684, -65686, 2, 'Remove Light Essence 10M'),
(67222, -67176, 2, 'Remove Dark essence 10M H'),
(67176, -67222, 2, 'Remove Light essence 10M H'),
(67223, -67177, 2, 'Remove Dark essence 25M'),
(67177, -67223, 2, 'Remove Light essence 25M'),
(67224, -67178, 2, 'Remove Dark essence 25M H'),
(67178, -67224, 2, 'Remove Light essence 25M H');

-- Orgrimmar: Hidden Enemies (5727)
SET @Gossip=21272;

DELETE FROM `gossip_menu` WHERE `text_id` IN (4513,4533,4534,4535,4536);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(3701,4513), -- 1st
(@Gossip+0,4533), -- 2nd
(@Gossip+1,4534), -- 3rd
(@Gossip+2,4535), -- 4th
(@Gossip+3,4536); -- last
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (3701,@Gossip+0,@Gossip+1,@Gossip+2,@Gossip+3);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(3701,0,0, 'You may speak frankly, Neeru...' ,1,1,@Gossip+0,0,0,0,NULL),
(@Gossip+0,0,0, 'It is good to see the Burning Blade is taking over where the Shadow Council once failed.' ,1,1,@Gossip+1,0,0,0,NULL),
(@Gossip+1,0,0, 'So the Searing Blade is expendable?' ,1,1,@Gossip+2,0,0,0,NULL),
(@Gossip+2,0,0, 'If there is anything you would have of me...' ,1,1,@Gossip+3,0,0,0,NULL); -- Must Link to Final Action Menu as well

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=3216; -- Neeru Fireblade
DELETE FROM `smart_scripts` WHERE `entryorguid`=3216 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3216, 0, 0, 0, 62, 0, 100, 0, @Gossip+2, 0, 0, 0, 15, 5727, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Neeru Fireblade - On gossip select give Hidden Enemies quest completed');

UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`|2 WHERE `entry`=5727; -- Hidden Enemies (quest completable by external event)
-- Conditions so gossips don't show up if the player doesn't have the item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3701;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` BETWEEN @Gossip+0 AND @Gossip+3;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,3701,0,0,2,14544,1,0,0,'', 'Neeru Fireblade: Quest Hidden Enemies gossip option - requires item Lieutenant''s Insignia'),
(14,@Gossip+0,4533,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 1 - requires item Lieutenant''s Insignia'),
(14,@Gossip+1,4534,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 2 - requires item Lieutenant''s Insignia'),
(14,@Gossip+2,4535,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 3 - requires item Lieutenant''s Insignia'),
(14,@Gossip+3,4536,0,2,14544,1,0,0, '', 'Neeru Fireblade: Quest Hidden Enemies gossip 4 - requires item Lieutenant''s Insignia');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=66512;
INSERT INTO `spell_linked_spell` VALUES
(66512, 66510, 0, 'Summon Deep Jormungar on Pound Drum');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=0 AND `SourceEntry`=66512;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 66512, 0, 18, 0, 195308, 0, 0, '', 'Pound Drum: Target Mysterious Snow Mound'),
(13, 0, 66512, 0, 18, 0, 195309, 0, 0, '', 'Pound Drum: Target Mysterious Snow Mound');

-- Morbent Fel SAI
SET @ENTRY := 1200;
SET @SPELL_SACRED_CLEANSING := 8913;
SET @SPELL_TOUCH_OF_DEATH := 3108;
SET @SPELL_PRESENCE_OF_DEATH := 3109;
SET @SPELL_UNHOLY_SHIELD := 8909;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,11,@SPELL_UNHOLY_SHIELD,0,0,0,0,0,1,0,0,0,0,0,0,0,"Morbent Fel - Out Of Combat - Cast Unholy Shield"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_SACRED_CLEANSING,0,0,0,36,24782,0,0,0,0,0,1,0,0,0,0,0,0,0,"Morbent Fel - On Spellhit - Update Template"),
(@ENTRY,0,2,0,0,0,100,0,0,0,24000,24000,11,@SPELL_TOUCH_OF_DEATH,0,0,0,0,0,2,0,0,0,0,0,0,0,"Morbent Fel - In Combat - Cast Touch of Death"),
(@ENTRY,0,3,0,0,0,100,0,0,0,3700,13300,11,@SPELL_PRESENCE_OF_DEATH,0,0,0,0,0,2,0,0,0,0,0,0,0,"Morbent Fel - In Combat - Cast Presence of Death"),
(@ENTRY,0,4,0,2,0,100,1,0,15,0,0,28,@SPELL_UNHOLY_SHIELD,1,0,0,0,0,1,0,0,0,0,0,0,0,"Morbent Fel - At 15% HP - Remove Unholy Shield");

DELETE FROM `creature` WHERE `id`=25589;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(2017,25589,571,1,1,0,0,4464.63,5378.07,-15.2737,6.05299,600,0,0,1,0,0);
DELETE FROM `creature_template_addon` WHERE `entry`=25589;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(25589,0,1,1,0, ''); -- sitting

DELETE FROM `script_texts` WHERE `npc_entry`=27654 AND `entry` BETWEEN -1578016 AND -1578005;
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `sound`, `type`, `comment`) VALUES
(27654, -1578005, 'The prisoners shall not go free! The word of Malygos is law!', 13594, 1, 'SAY_AGGRO'),
(27654, -1578006, 'A fitting punishment!', 13602, 1, 'SAY_KILL_1'),
(27654, -1578007, 'Sentence: executed!', 13603, 1, 'SAY_KILL_2'),
(27654, -1578008, 'Another casualty of war!', 13604, 1, 'SAY_KILL_3'),
(27654, -1578009, 'The war... goes on.', 13605, 1, 'SAY_DEATH'),
(27654, -1578010, 'It is too late to run!', 13598, 1, 'SAY_PULL_1'),
(27654, -1578011, 'Gather ''round....', 13599, 1, 'SAY_PULL_2'),
(27654, -1578012, 'None shall escape!', 13600, 1,  'SAY_PULL_3'),
(27654, -1578013, 'I condemn you to death!', 13601, 1, 'SAY_PULL_4'),
(27654, -1578014, 'Tremble, worms!', 13595, 1,  'SAY_STOMP_1'),
(27654, -1578015, 'I will crush you!', 13596, 1, 'SAY_STOMP_2'),
(27654, -1578016, 'Can you fly?', 13597, 1, 'SAY_STOMP_3');

SET @Gossip=21276;
SET @Azuregos=15481; -- Spirit of Azuregos
SET @Item=20949; -- Magical Ledger
UPDATE `creature_template` SET `gossip_menu_id`=@Gossip, `AIName`='SmartAI' WHERE `entry`=@Azuregos;

DELETE FROM `gossip_menu` WHERE (`entry` BETWEEN @Gossip AND @Gossip+12) AND `text_id` IN (7881,7901,7885,7886,7887,7888,7889,7890,7891,7892,7893,7894,7895,7896,7897);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(@Gossip+00, 7881), -- gossip if no quest nor item
(@Gossip+00, 7901), -- gossip if item
(@Gossip+00, 7885), -- 01
(@Gossip+01, 7886), -- 02
(@Gossip+02, 7887), -- 03
(@Gossip+03, 7888), -- 04
(@Gossip+04, 7889), -- 05
(@Gossip+05, 7890), -- 06
(@Gossip+06, 7891), -- 07
(@Gossip+07, 7892), -- 08
(@Gossip+08, 7893), -- 09
(@Gossip+09, 7894), -- 10
(@Gossip+10, 7895), -- 11
(@Gossip+11, 7896), -- 12
(@Gossip+12, 7897); -- 13

DELETE FROM `gossip_menu_option` WHERE `menu_id` BETWEEN @Gossip AND @Gossip + 14;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@Gossip+00,0,'How did you know? I mean, yes... Yes I am looking for that shard. Do you have it?',1,1,@Gossip+01),
(@Gossip+01,0,'Alright. Where?',1,1,@Gossip+02),
(@Gossip+02,0,'By Bronzebeard''s... um, beard! What are you talking about?',1,1,@Gossip+03),
(@Gossip+03,0,'Fish? You gave a piece of what could be the key to saving all life on Kalimdor to a fish?',1,1,@Gossip+04),
(@Gossip+04,0,'A minnow? The oceans are filled with minnows! There could be a hundred million million minnows out there!',1,1,@Gossip+05),
(@Gossip+05,0,'...',1,1,@Gossip+06),
(@Gossip+06,0,'You put the piece on a minnow and placed the minnow somewhere in the waters of the sea between here and the Eastern Kingdoms? And this minnow has special powers?',1,1,@Gossip+07),
(@Gossip+07,0,'You''re insane.',1,1,@Gossip+08),
(@Gossip+08,0,'I''m all ears.',1,1,@Gossip+09),
(@Gossip+09,0,'Come again.',1,1,@Gossip+10),
(@Gossip+10,0,'Ok, let me get this straight. You put the scepter entrusted to your Flight by Anachronos  on a minnow of your own making and now you expect me to build an... an arcanite buoy or something... to force your minnow out of hiding? AND potentially incur the wrath of an Elemental Lord? Did I miss anything? Perhaps I am to do this without any clothes on, during a solar eclipse, on a leap year?',1,1,@Gossip+11),
(@Gossip+11,0,'FINE! And how, dare I ask, am I supposed to acquire an arcanite buoy?',1,1,@Gossip+12),
(@Gossip+12,0,'But...',1,1,0);

DELETE FROM `creature_text` WHERE `entry`=@Azuregos;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@Azuregos, 0, 0, 'I SAID GOOD BYE!', 12, 0, 100, 1, 0, 0, 'Spirit of Azuregos');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup` BETWEEN @Gossip+0 AND @Gossip+2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(14,@Gossip+0,7901,0,2,@Item,1, 'Spirit of Azuregos - show gossip 7901 if player has item Magical Ledger'),
(14,@Gossip+0,7885,0,14,8575,0, 'Spirit of Azuregos - show gossip 7885 if player does not have quest Azuregos''s Magical Ledger'),
(14,@Gossip+0,7885,0,8,8555,0, 'Spirit of Azuregos - show gossip 7885 if player has quest The Charge of the Dragonflights rewarded'),
(14,@Gossip+0,7881,0,14,8555,0, 'Spirit of Azuregos - show gossip 7881 if player does not have quest The Charge of the Dragonflights'),
(15,@Gossip+0,0,0,26,@Item,1, 'Spirit of Azuregos - show gossip option if player does not have item Magical Ledger'),
(15,@Gossip+0,0,0,14,8575,0, 'Spirit of Azuregos - show gossip option if player does not have quest Azuregos''s Magical Ledger'),
(15,@Gossip+0,0,0,8,8555,0, 'Spirit of Azuregos - show gossip option if player has quest The Charge of the Dragonflights rewarded');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@Azuregos AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@Azuregos, 0, 0, 0, 62, 0, 100, 0, @Gossip+11, 0, 0, 0, 56, @Item, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Azuregos - On gossip select 11 give item'),
(@Azuregos, 0, 1, 2, 62, 0, 100, 0, @Gossip+12, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Azuregos - On gossip select 12 close gossip'),
(@Azuregos, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Azuregos - Link 2 say');

-- Not related
UPDATE `game_event` SET `start_time`='2011-12-04 00:01:00' WHERE `eventEntry`=4;

SET @GUID = 209102;

-- add creatures
DELETE FROM `creature` WHERE `id` IN (28601, 28602) AND `map`=1;
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@GUID+00,28601, 1, -6027.13, -1249.12, -146.765, 0.0407544),
(@GUID+01,28602, 1, -6165.74, -1250.34, -162.183, 3.16428),
(@GUID+02,28602, 1, -6118.16, -1258.77, -143.281, 3.17606),
(@GUID+03,28602, 1, -6118.18, -1241.33, -143.281, 3.12169),
(@GUID+04,28602, 1, -6104.87, -1256.41, -143.281, 3.04315),
(@GUID+05,28602, 1, -6104.56, -1243.58, -143.281, 3.07064),
(@GUID+06,28602, 1, -6067.35, -1243.76, -143.481, 3.17274),
(@GUID+07,28602, 1, -6067.17, -1255.45, -143.430, 3.15703),
(@GUID+08,28602, 1, -6038.16, -1243.56, -146.897, 3.15153),
(@GUID+09,28602, 1, -6036.82, -1255.32, -146.901, 3.19238),
(@GUID+10,28602, 1, -6042.26, -1249.25, -146.887, 3.19238);

-- add weapons to creatures
DELETE FROM `creature_equip_template` WHERE `entry`=2476;
INSERT INTO `creature_equip_template` VALUES 
(2476, 7714, 0, 0);

-- correct creature_template
UPDATE `creature_template` SET `faction_A` = 2080, `faction_H` = 2080, `lootid` = `entry` WHERE `entry` IN (28601, 28602);
UPDATE `creature_template` SET `equipment_id` = 1803 WHERE `entry`=28601;
UPDATE `creature_template` SET `equipment_id` = 2476 WHERE `entry`=28601;

-- create questloot
DELETE FROM `creature_loot_template` WHERE `entry`=28601;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(28601, 38708, -100, 1, 0, 1, 1);

UPDATE `instance_template` SET `allowMount`=1 WHERE `map`=531; -- Allow mount in AQ40
UPDATE `instance_template` SET `allowMount`=1 WHERE `map`=631; -- Allow mount in ICC

-- Fix to Spell targets for Ignis adds
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62343;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62488;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62343,0,18,1,33121,0,0, '', 'Heat to Iron Construct'),
(13,0,62488,0,18,1,33121,0,0, '', 'Activate Construct to iron Construct');
 
-- Burn Secondary Effect from Vehicles
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=65044;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,65044,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65044,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65044,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65044,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65044,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A');
 
-- Burn Secondary Effect from Vehicles
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=65045;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,65045,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65045,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65045,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65045,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65045,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62911;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62911,0,18,1,33365,0,0, '', 'Thorim\'s Hammer to Thorim\'s Hammer');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62906;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62906,0,18,1,33367,0,0, '', 'Freya\'s Ward to Freya\'s Ward');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62705;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62705,1,18,1,33060,0,0, '', 'Auto-repair to Salvaged Siege Engine'),
(13,0,62705,2,18,1,33067,0,0, '', 'Auto-repair to Salvaged Siege Turret'),
(13,0,62705,3,18,1,33062,0,0, '', 'Auto-repair to Salvaged Chopper'),
(13,0,62705,4,18,1,33109,0,0, '', 'Auto-repair to Salvaged Demolisher'),
(13,0,62705,5,18,1,33167,0,0, '', 'Auto-repair to Salvaged Demolisher Mechanic Seat');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63294;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,63294,0,18,1,33367,0,0, '', 'Freya Dummy Blue to Freya\'s Ward');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63295;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,63295,0,18,1,33367,0,0, '', 'Freya Dummy Green to Freya\'s Ward');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63292;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,63292,0,18,1,33367,0,0, '', 'Freya Dummy Yellow to Freya\'s Ward');

-- Template updates
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~8 WHERE `entry`=33059; -- Wrecked Demolisher
UPDATE `creature_template` SET `exp`=0 WHERE `entry`=33666; -- Demolisher Engineer Blastwrench
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~8 WHERE `entry`=33063; -- Wrecked Siege Engine
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216 WHERE `entry`=33067; -- Salvaged Siege Turret
UPDATE `creature_template` SET `VehicleId`=387 WHERE `entry`=33113; -- Flame Leviathan
UPDATE `creature_template` SET `exp`=0 WHERE `entry`=33143; -- Overload Control Device
UPDATE `creature_template` SET `exp`=0,`npcflag`=`npcflag`|16777216,`unit_flags`=`unit_flags`|33571584 WHERE `entry`=33139; -- Flame Leviathan Turret
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`|12 WHERE `entry`=33216; -- Mechagnome Pilot
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`|12 WHERE `entry`=33572; -- Steelforged Defender
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33280 WHERE `entry`=33186; -- Razorscale
UPDATE `creature_template` SET `speed_run`=2.14286 WHERE `entry`=34120; -- Brann's Flying Machine
UPDATE `creature_template` SET `speed_walk`=1.6,`speed_run`=1.42857 WHERE `entry`=33118; -- Ignis the Furnace Master
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554688 WHERE `entry`=33121; -- Iron Construct
 
-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=5,`combat_reach`=1,`gender`=2 WHERE `modelid`=25870; -- Salvaged Chopper
UPDATE `creature_model_info` SET `bounding_radius`=0.6,`combat_reach`=1,`gender`=1 WHERE `modelid`=28787; -- Razorscale
UPDATE `creature_model_info` SET `bounding_radius`=0.62,`combat_reach`=1,`gender`=0 WHERE `modelid`=29185; -- Ignis the Furnace Master
 
-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (33114,33142,33143,33139,33189,33216,33572,33090,33186,33287,33259,34120,
23033,34086,33118,33210,33121,34085,33816);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(33114,0,0,257,0, NULL), -- Flame Leviathan Seat
(33142,0,0,1,0, NULL), -- Leviathan Defense Turret
(33143,0,0,1,0, NULL), -- Overload Control Device
(33139,0,0,1,0, NULL), -- Flame Leviathan Turret
(33189,0,0,1,0, NULL), -- Liquid Pyrite
(33216,0,0,1,0, NULL), -- Mechagnome Pilot
(33572,0,0,1,0, NULL), -- Steelforged Defender
(33090,0,0,1,0, NULL),-- Pool of Tar
(33186,0,50331648,1,0, NULL), -- Razorscale
(33816,0,0,1,375, NULL), -- Expedition Defender
(33287,0,0,1,0, NULL), -- Expedition Engineer
(33259,0,0,1,375, NULL), -- Expedition Trapper
(34120,0,50331648,1,0, NULL), -- Brann's Flying Machine
(23033,0,0,1,0, NULL), -- Invisible Stalker (Floating)
(34086,0,33554432,1,0, NULL), -- Magma Rager
(33118,0,0,1,0, NULL), -- Ignis the Furnace Master
(33210,0,0,1,0, NULL), -- Expedition Commander
(33121,0,0,1,0, NULL), -- Iron Construct
(34085,0,0,1,0, NULL); -- Forge Construct

DELETE FROM `spell_dbc` WHERE `Id`=37794;
INSERT INTO `spell_dbc` (`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`)VALUES
(37794,0,0,384,0,0,1048576,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,21,1,0,-1,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,0,16963,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'Transform Infernal');

-- Template updates
UPDATE `creature_template` SET `unit_flags`=0,`AIName`='SmartAI' WHERE `entry`=21419; -- Infernal Attacker
UPDATE `creature_model_info` SET `bounding_radius`=1.3545,`combat_reach`=3,`gender`=2 WHERE `modelid`=20577; -- Infernal Attacker
UPDATE `creature_template_addon` SET `bytes1`=0,`bytes2`=1,`mount`=0,`emote`=0,`auras`=NULL WHERE `entry`=21419; -- Infernal Attacker

DELETE FROM `smart_scripts` WHERE `entryorguid`=21419 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(21419, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 37794, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infernal Attacker - On spawn cast Transform Infernal on self');

DELETE FROM `event_scripts` WHERE `id` IN (16929,17084);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
-- H
(16929, 3, 10, 25742, 360000, 0, 3533.64, 4535.52, -12.9953, 3.47514), -- Alluvion
(16929, 10, 8, 25742, 0, 0, 0, 0, 0, 0), -- KC
(16929, 3, 10, 25629, 360000, 0, 3511.96, 4527.18, -12.9949, 0.357893), -- Kryxix
-- A
(17084, 3, 10, 25794, 360000, 0, 3533.64, 4535.52, -12.9953, 3.47514), -- Shake-n-Quake 5000
(17084, 10, 8, 25794, 0, 0, 0, 0, 0, 0), -- KC
(17084, 3, 10, 25629, 360000, 0, 3511.96, 4527.18, -12.9949, 0.357893); -- Kryxix

UPDATE `creature` SET `spawnMask`=1 WHERE `guid` IN (1102,85587) AND `id` IN (22237,17318);
DELETE FROM `game_event_creature` WHERE `eventEntry`=7 AND `guid`=1102;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(7,1102); -- Loirea Galerunner - Lunar Festival

-- Fix Startup Errors
UPDATE `creature_template` SET `exp`=0,`npcflag`=`npcflag`|16777216,`unit_flags`=`unit_flags`|33571584 WHERE `entry`=34111;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (33139,34111);
INSERT INTO `npc_spellclick_spells`(`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(34111,46598,0,0,0,1,0,0,0),
(33139,46598,0,0,0,1,0,0,0);
 
-- Added Burn to Vehicles for Hard mode Mechanics
-- Thanks to horn for the reminder
-- Burn Secondary Effect from Vehicles
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (65044,65045);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,65044,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65044,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65044,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65044,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65044,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65044,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A'),
(13,0,65044,8,18,1,33062,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65044,9,18,1,34045,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65044,10,18,1,33109,0,0, '', 'Flames to Salvaged Demolisher'),
(13,0,65044,11,18,1,33060,0,0, '', 'Flames to Salvaged Salvaged Siege Engine'),
-- Burn Secondary Effect from Vehicles
(13,0,65045,1,18,1,34234,0,0, '', 'Flames to Runeforged Sentry'),
(13,0,65045,2,18,1,33236,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,3,18,1,33572,0,0, '', 'Flames to Steelforged Defender'),
(13,0,65045,4,18,1,33237,0,0, '', 'Flames to Ulduar Colossus'),
(13,0,65045,5,18,1,33189,0,0, '', 'Flames to Liquid pyrite'),
(13,0,65045,6,18,1,33090,0,0, '', 'Flames to Pool of Tar'),
(13,0,65045,7,18,1,34161,0,0, '', 'Flames to Mechanostriker 54-A'),
(13,0,65045,8,18,1,33062,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65045,9,18,1,34045,0,0, '', 'Flames to Salvaged Chopper'),
(13,0,65045,10,18,1,33109,0,0, '', 'Flames to Salvaged Demolisher'),
(13,0,65045,11,18,1,33060,0,0, '', 'Flames to Salvaged Salvaged Siege Engine');

SET @GUID = 209113;
DELETE FROM `creature` WHERE `id` IN (30395,30446,30450,30454);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`) VALUES
(@GUID+00, 30395, 571, 1, 1, 8348.89, -2509.48, 1147.37, 3.7001, 120, 0),
(@GUID+01, 30446, 571, 1, 1, 8253.4, -2566.37, 1149.7, 0.0698132, 120, 0),
(@GUID+02, 30446, 571, 1, 1, 8281.26, -2612.78, 1150.66, 0.349066, 120, 0),
(@GUID+03, 30446, 571, 1, 1, 8283.91, -2585.09, 1149.51, 5.00909, 120, 0),
(@GUID+04, 30446, 571, 1, 1, 8300.43, -2564.86, 1153.59, 0.261799, 120, 0),
(@GUID+05, 30446, 571, 1, 1, 8310.22, -2550.68, 1153.69, 1.91986, 120, 0),
(@GUID+06, 30446, 571, 1, 1, 8331.42, -2502.39, 1140.05, 4.53786, 120, 0),
(@GUID+07, 30446, 571, 1, 1, 8354.63, -2549.88, 1148.54, 4.95674, 120, 0),
(@GUID+08, 30446, 571, 1, 1, 8361.87, -2526.85, 1141.39, 3.68264, 120, 0),
(@GUID+09, 30446, 571, 1, 1, 8382.5, -2549.35, 1145.97, 3.82227, 120, 0),
(@GUID+10, 30446, 571, 1, 1, 8393.97, -2540.06, 1131.91, 5.07891, 120, 0),
(@GUID+24, 30454, 571, 1, 1, 8289.31, -2602.48, 1151.42, 1.95477, 120, 0),
(@GUID+25, 30454, 571, 1, 1, 8294.61, -2589.08, 1150.63, 1.39626, 120, 0),
(@GUID+26, 30454, 571, 1, 1, 8300.51, -2596.84, 1151.87, 3.9619, 120, 0),
(@GUID+27, 30454, 571, 1, 1, 8303.38, -2521.44, 1154.39, 5.07891, 120, 0),
(@GUID+28, 30454, 571, 1, 1, 8312.52, -2561.31, 1152.03, 4.72984, 120, 0),
(@GUID+29, 30454, 571, 1, 1, 8314.11, -2500.82, 1143.3, 1.6057, 120, 0),
(@GUID+30, 30454, 571, 1, 1, 8317.65, -2573.94, 1151.43, 3.03687, 120, 0),
(@GUID+31, 30454, 571, 1, 1, 8336.79, -2502.89, 1133.36, 5.41052, 120, 0),
(@GUID+32, 30454, 571, 1, 1, 8342.26, -2505.45, 1134.28, 4.01426, 120, 0),
(@GUID+33, 30454, 571, 1, 1, 8351.38, -2508.96, 1135.07, 0.244346, 120, 0),
(@GUID+34, 30454, 571, 1, 1, 8381.3, -2529.69, 1133.36, 4.62512, 120, 0),
(@GUID+35, 30454, 571, 1, 1, 8387.79, -2527.25, 1135.03, 4.53786, 120, 0),
(@GUID+36, 30454, 571, 1, 1, 8393.11, -2548.1, 1143.71, 1.72788, 120, 0),
(@GUID+37, 30454, 571, 1, 1, 8398.62, -2526.46, 1134.62, 3.80482, 120, 0),
(@GUID+38, 30454, 571, 1, 1, 8401.63, -2539.44, 1132.53, 1.39626, 120, 0),
(@GUID+39, 30454, 571, 1, 1, 8406.36, -2532.98, 1131.75, 2.04204, 120, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@GUID+11, 30450, 571, 1, 1, 8259.18, -2570.82, 1149.61, 1.56682, 120, 5, 1),
(@GUID+12, 30450, 571, 1, 1, 8264.03, -2566.79, 1149.61, 2.96147, 120, 5, 1),
(@GUID+13, 30450, 571, 1, 1, 8284.46, -2601.7, 1150.49, 5.66794, 120, 5, 1),
(@GUID+14, 30450, 571, 1, 1, 8292.88, -2572.04, 1146.46, 1.3252, 120, 5, 1),
(@GUID+15, 30450, 571, 1, 1, 8298.51, -2592.29, 1150.48, 0.513648, 120, 5, 1),
(@GUID+16, 30450, 571, 1, 1, 8306.36, -2524.83, 1152.22, 2.29176, 120, 5, 1),
(@GUID+17, 30450, 571, 1, 1, 8313.22, -2565.91, 1150.88, 0.739577, 120, 5, 1),
(@GUID+18, 30450, 571, 1, 1, 8334.5, -2519.78, 1138.3, 5.60389, 120, 5, 1),
(@GUID+19, 30450, 571, 1, 1, 8336.27, -2512.15, 1135.11, 3.55008, 120, 5, 1),
(@GUID+20, 30450, 571, 1, 1, 8350.84, -2544.52, 1147.52, 5.8518, 120, 5, 1),
(@GUID+21, 30450, 571, 1, 1, 8365.42, -2533.72, 1132.69, 5.61117, 120, 5, 1),
(@GUID+22, 30450, 571, 1, 1, 8377.27, -2545.82, 1140.66, 2.91336, 120, 5, 1),
(@GUID+23, 30450, 571, 1, 1, 8396.34, -2529.92, 1131.82, 1.30778, 120, 5, 1);

UPDATE `creature_template` SET `npcflag`=3,`gossip_menu_id`=9906 WHERE `entry`=30395; -- Chieftain Swiftspear
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=30446; -- Frostfloe Rift
UPDATE `creature_template` SET `MovementType`=1 WHERE `entry`=30450; -- Wailing Winds
UPDATE `creature_template` SET `InhabitType`=7,`flags_extra`=`flags_extra`|128 WHERE `entry`=30454; -- Frostfloe Deep Stalker

UPDATE `creature_model_info` SET `bounding_radius`=0.6076385,`combat_reach`=2.625,`gender`=0 WHERE `modelid`=27004; -- Chieftain Swiftspear
UPDATE `creature_model_info` SET `bounding_radius`=0.5,`combat_reach`=1,`gender`=2 WHERE `modelid`=27617; -- Wailing Winds

DELETE FROM `creature_template_addon` WHERE `entry` IN (30395,30446,30450,30454);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30395,0,0,1,0, NULL), -- Chieftain Swiftspear
(30446,0,0x3000000,1,0, NULL), -- Frostfloe Rift
(30450,0,0,1,0, NULL), -- Wailing Winds
(30454,0,0x3000000,1,0, NULL); -- Frostfloe Deep Stalker

DELETE FROM `gossip_menu` WHERE `entry`=9906 AND `text_id`=13776;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(9906, 13776);

-- Quest 12983 "Last of Her Kind"

-- Add Injured Icemaw Matriarch
DELETE FROM `creature` WHERE `id`=29563;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(152124,29563,571,1,1,0,0,7335.381,-2055.097,764.3585,3.368485,120,0,0,1,0,0,0,0,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216 WHERE `entry`=29563; -- Injured Icemaw Matriarch
-- SAI for Harnessed Icemaw Matriarch
SET @ENTRY := 30468;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=35, `faction_H`=35 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,27,0,100,0,0,0,0,0,53,1,@ENTRY,0,12983,0,0,1,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - On Passenger - Start WP movement'),
(@ENTRY,0,1,0,40,0,100,0,1,@ENTRY,0,0,18,130,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - Reach Waypoint - Make Unatackable'),
(@ENTRY,0,2,0,40,0,100,0,50,@ENTRY,0,0,33,29563,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - Reach Waypoint - Quest Credit'),
(@ENTRY,0,3,0,40,0,100,0,51,@ENTRY,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Harnessed Icemaw Matriarch - Reach Waypoint - Despawn');
-- Waypoints for Harnessed Icemaw Matriarch
DELETE FROM `waypoints` WHERE `entry`=30468;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(30468,1,7339.617,-2058.659,764.919,'Harnessed Icemaw Matriarch'),
(30468,2,7338.267,-2064.381,765.3577,'Harnessed Icemaw Matriarch'),
(30468,3,7335.772,-2073.805,767.4077,'Harnessed Icemaw Matriarch'),
(30468,4,7327.591,-2087.35,770.8978,'Harnessed Icemaw Matriarch'),
(30468,5,7319.448,-2095.41,773.6814,'Harnessed Icemaw Matriarch'),
(30468,6,7305.165,-2107.299,774.3261,'Harnessed Icemaw Matriarch'),
(30468,7,7275.178,-2114.627,775.6678,'Harnessed Icemaw Matriarch'),
(30468,8,7258.999,-2116.149,778.5131,'Harnessed Icemaw Matriarch'),
(30468,9,7241.648,-2119.356,777.7652,'Harnessed Icemaw Matriarch'),
(30468,10,7226.729,-2115.936,777.3341,'Harnessed Icemaw Matriarch'),
(30468,11,7208.441,-2115.223,770.9512,'Harnessed Icemaw Matriarch'),
(30468,12,7198.355,-2115.354,767.3314,'Harnessed Icemaw Matriarch'),
(30468,13,7193.219,-2115.251,765.6339,'Harnessed Icemaw Matriarch'),
(30468,14,7188.855,-2117.307,763.8766,'Harnessed Icemaw Matriarch'),
(30468,15,7177.065,-2123.511,762.9337,'Harnessed Icemaw Matriarch'),
(30468,16,7163.708,-2131.039,762.1168,'Harnessed Icemaw Matriarch'),
(30468,17,7146.599,-2130.739,762.0986,'Harnessed Icemaw Matriarch'),
(30468,18,7127.765,-2130.799,760.3064,'Harnessed Icemaw Matriarch'),
(30468,19,7130.188,-2108.955,761.6824,'Harnessed Icemaw Matriarch'),
(30468,20,7122.738,-2087.617,763.7275,'Harnessed Icemaw Matriarch'),
(30468,21,7114.396,-2070.318,765.9775,'Harnessed Icemaw Matriarch'),
(30468,22,7101.815,-2051.608,765.8251,'Harnessed Icemaw Matriarch'),
(30468,23,7091.483,-2031.099,765.8953,'Harnessed Icemaw Matriarch'),
(30468,24,7087.403,-2012.366,767.2703,'Harnessed Icemaw Matriarch'),
(30468,25,7081.406,-1985.07,767.9617,'Harnessed Icemaw Matriarch'),
(30468,26,7073.832,-1961.028,769.3597,'Harnessed Icemaw Matriarch'),
(30468,27,7068.839,-1934.135,775.7347,'Harnessed Icemaw Matriarch'),
(30468,28,7064.366,-1916.702,781.6978,'Harnessed Icemaw Matriarch'),
(30468,29,7070.385,-1906.559,785.4976,'Harnessed Icemaw Matriarch'),
(30468,30,7079.504,-1899.025,787.0339,'Harnessed Icemaw Matriarch'),
(30468,31,7085.339,-1887.627,788.9089,'Harnessed Icemaw Matriarch'),
(30468,32,7067.585,-1884.709,793.0339,'Harnessed Icemaw Matriarch'),
(30468,33,7041.699,-1884.614,797.4276,'Harnessed Icemaw Matriarch'),
(30468,34,7029.2,-1871.599,803.4189,'Harnessed Icemaw Matriarch'),
(30468,35,7025.071,-1858.876,811.2399,'Harnessed Icemaw Matriarch'),
(30468,36,7018.791,-1838.968,820.2399,'Harnessed Icemaw Matriarch'),
(30468,37,7011.697,-1814.383,820.7299,'Harnessed Icemaw Matriarch'),
(30468,38,7009.096,-1791.501,820.7303,'Harnessed Icemaw Matriarch'),
(30468,39,7017.041,-1758.968,819.6544,'Harnessed Icemaw Matriarch'),
(30468,40,7013.258,-1723.917,819.8597,'Harnessed Icemaw Matriarch'),
(30468,41,6995.103,-1720.753,820.1116,'Harnessed Icemaw Matriarch'),
(30468,42,6975.483,-1722.112,820.7366,'Harnessed Icemaw Matriarch'),
(30468,43,6959.883,-1724.389,820.5955,'Harnessed Icemaw Matriarch'),
(30468,44,6941.025,-1720.429,820.5955,'Harnessed Icemaw Matriarch'),
(30468,45,6920.026,-1709.558,820.7527,'Harnessed Icemaw Matriarch'),
(30468,46,6902.995,-1697.53,820.6683,'Harnessed Icemaw Matriarch'),
(30468,47,6886.746,-1682.953,820.2584,'Harnessed Icemaw Matriarch'),
(30468,48,6867.681,-1684.361,819.8834,'Harnessed Icemaw Matriarch'),
(30468,49,6847.065,-1695.642,819.9857,'Harnessed Icemaw Matriarch'),
(30468,50,6824.819,-1701.835,820.6398,'Harnessed Icemaw Matriarch'),
(30468,51,6824.819,-1701.835,820.5497,'Harnessed Icemaw Matriarch');

-- Phasing Spell
DELETE FROM `spell_area` WHERE `spell`=55857 AND `area`=4455;
INSERT INTO `spell_area`(`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES 
(55857,4455,12983,1,12983,0,0,2,1);

-- From Nay:
-- TODO: Respawn the whole cave, lots of shit wrong (phasemasks etc)
UPDATE `creature` SET `phaseMask`=2 WHERE `id`=29563;
DELETE FROM `creature_template_addon` WHERE `entry`=30468;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30468,0,0,1,0, NULL); -- Harnessed Icemaw Matriarch

UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Zandalar Madcap''s Mantle. Can you help?' WHERE `menu_id`=21270 AND `id`=0; -- It said: "...Zandalar Madcap's Belt." (Wrong name, that item doesn't exist)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Zandalar Predator''s Mantle. Can you help?' WHERE `menu_id`=21271 AND `id`=2; -- It said: "...Zandalar Predator's Tunic." (Wrong name, that item doesn't exist)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Maelstrom''s Tendril. Can you help?' WHERE `menu_id`=21271 AND `id`=4; -- It said: "... Malestrom's Tendril." (Typo)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Maelstrom''s Tendril. Can you help?' WHERE `menu_id`=21271 AND `id`=5; -- It said: "... Malestrom's Tendril." (Typo)
UPDATE `gossip_menu_option` SET `option_text`='I seem to have misplaced my Maelstrom''s Tendril. Can you help?' WHERE `menu_id`=21271 AND `id`=6; -- It said: "... Malestrom's Tendril." (Typo)
UPDATE `smart_scripts` SET `comment`='Falthir the Sightless - On gossip select 2 give item Zandalar Madcap''s Mantle' WHERE `entryorguid`=14905 AND `id`=2; -- It said: "...Zandalar Augur''s Belt" (Wrong name, that item doesn't correspond with rouge class)

-- Quest: Tomb of the Lightbringer, make Anchorite Truuen speak Common not Draconic
UPDATE `script_texts` SET `language`=7 WHERE `comment` LIKE 'npc_anchorite_truuen%' AND `language`=11;

SET @GUID=209153;
DELETE FROM `creature` WHERE `id`=29413;
INSERT INTO `creature` (`guid` ,`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(@GUID+0, 29413, 571, 1, 1, 0, 0, 6471.48, -1658.6, 432.644, 5.41462, 600, 0, 0, 1, 0, 0),
(@GUID+1, 29413, 571, 1, 1, 0, 0, 6477.3, -1651.6, 430.185, 5.4107, 600, 0, 0, 1, 0, 0),
(@GUID+2, 29413, 571, 1, 1, 0, 0, 6492.54, -1648.41, 429.39, 5.2222, 600, 0, 0, 1, 0, 0),
(@GUID+3, 29413, 571, 1, 1, 0, 0, 6512.8, -1621.17, 428.168, 6.19609, 600, 0, 0, 1, 0, 0),
(@GUID+4, 29413, 571, 1, 1, 0, 0, 6489.6, -1624.66, 428.328, 2.01384, 600, 0, 0, 1, 0, 0),
(@GUID+5, 29413, 571, 1, 1, 0, 0, 6426.13, -1605.26, 422.576, 1.22452, 600, 0, 0, 1, 0, 0),
(@GUID+6, 29413, 571, 1, 1, 0, 0, 6430.89, -1604.5, 423.222, 0.949627, 600, 0, 0, 1, 0, 0),
(@GUID+7, 29413, 571, 1, 1, 0, 0, 6386.45, -1599.39, 420.724, 2.33193, 600, 0, 0, 1, 0, 0),
(@GUID+8, 29413, 571, 1, 1, 0, 0, 6375.45, -1593.56, 425.553, 1.04387, 600, 0, 0, 1, 0, 0),
(@GUID+9, 29413, 571, 1, 1, 0, 0, 6696.47, -998.844, 415.433, 2.83458, 600, 0, 0, 1, 0, 0),
(@GUID+10, 29413, 571, 1, 1, 0, 0, 6630.7, -1004.17, 424.376, 2.72462, 600, 0, 0, 1, 0, 0),
(@GUID+11, 29413, 571, 1, 1, 0, 0, 6612.56, -1017.17, 427.344, 3.38043, 600, 0, 0, 1, 0, 0),
(@GUID+12, 29413, 571, 1, 1, 0, 0, 6594.54, -1017.6, 429.443, 2.02955, 600, 0, 0, 1, 0, 0),
(@GUID+13, 29413, 571, 1, 1, 0, 0, 6578.55, -982.887, 434.147, 5.99973, 600, 0, 0, 1, 0, 0),
(@GUID+14, 29413, 571, 1, 1, 0, 0, 6580.09, -997.177, 434.919, 5.56384, 600, 0, 0, 1, 0, 0),
(@GUID+15, 29413, 571, 1, 1, 0, 0, 6596.23, -1008.78, 429.445, 5.69736, 600, 0, 0, 1, 0, 0),
(@GUID+16, 29413, 571, 1, 1, 0, 0, 6594.65, -1049.05, 430.103, 2.46544, 600, 0, 0, 1, 0, 0),
(@GUID+17, 29413, 571, 1, 1, 0, 0, 6570.9, -1050.44, 432.848, 3.76527, 600, 0, 0, 1, 0, 0),
(@GUID+18, 29413, 571, 1, 1, 0, 0, 6533.12, -1075.28, 432.917, 1.53867, 600, 0, 0, 1, 0, 0),
(@GUID+19, 29413, 571, 1, 1, 0, 0, 6536.16, -1078.86, 433.175, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+20, 29413, 571, 1, 1, 0, 0, 6536.22, -1076.53, 433.014, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+21, 29413, 571, 1, 1, 0, 0, 6534.27, -1076.49, 432.958, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+22, 29413, 571, 1, 1, 0, 0, 6534.71, -1073.77, 432.928, 1.54652, 600, 0, 0, 1, 0, 0),
(@GUID+23, 29413, 571, 1, 1, 0, 0, 6538.16, -1076.95, 433.1, 1.55438, 600, 0, 0, 1, 0, 0),
(@GUID+24, 29413, 571, 1, 1, 0, 0, 6536.77, -1073.94, 432.995, 1.46013, 600, 0, 0, 1, 0, 0),
(@GUID+25, 29413, 571, 1, 1, 0, 0, 6538.6, -1075.64, 433.11, 1.49155, 600, 0, 0, 1, 0, 0),
(@GUID+26, 29413, 571, 1, 1, 0, 0, 6621.56, -1078.08, 415.032, 1.05174, 600, 5, 0, 1, 0, 1),
(@GUID+27, 29413, 571, 1, 1, 0, 0, 6641.11, -1093.62, 402.801, 1.36196, 600, 0, 0, 1, 0, 0),
(@GUID+28, 29413, 571, 1, 1, 0, 0, 6610.29, -1279.72, 394.475, 3.31761, 600, 0, 0, 1, 0, 0),
(@GUID+29, 29413, 571, 1, 1, 0, 0, 6599.47, -1270.63, 394.829, 1.10278, 600, 0, 0, 1, 0, 0);

-- Nay:
UPDATE `creature_template_addon` SET `bytes1`=0,`bytes2`=1,`mount`=0,`emote`=233,`auras`=NULL WHERE `entry`=29413;
UPDATE `creature_model_info` SET `bounding_radius`=0.31,`combat_reach`=0,`gender`=0 WHERE `modelid`=27173;
-- Not sure if all  of them should have the emote, check this later.

UPDATE `creature_text` SET `sound`=16825 WHERE `entry`=37129 AND `groupid`=5 AND `id`=0;

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`
|1 -- CHARM
|2 -- DISORIENTED
|4 -- DISARM
|8 -- DISTRACT
|16 -- FEAR
|32 -- GRIP
|64 -- ROOT
|128 -- PACIFY
|256 -- SILENCE
|512 -- SLEEP
|1024 -- SNARE
|2048 -- STUN
|4096 -- FREEZE
|8192 -- KNOCKOUT
|65536 -- POLYMORPH
|131072 -- BANISH
|524288 -- SHACKLE
|4194304 -- TURN
|8388608 -- HORROR
|67108864 -- DAZE
|536870912 -- SAPPED
WHERE `entry` IN
(36597,39166,39167,39168, -- The Lich King
36612,37957,37958,37959, -- Lord Marrowgar
36626,37504,37505,37506, -- Festergut
36627,38390,38549,38550, -- Rotface
36678,38431,38585,38586, -- Professor Putricide
36853,38265,38266,38267, -- Sindragosa
36855,38106,38296,38297, -- Lady Deathwhisper
37813,38402,38582,38583, -- Deathbringer Saurfang
37955,38434,38435,38436, -- Blood-Queen Lana'thel
37970,38401,38784,38785,  -- Prince Valanar
37972,38399,38769,38770, -- Prince Keseleth
37973,38400,38771,38772); -- Prince Taldaram

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~2097152 /* INFECTED */ WHERE `entry` IN 
(36626,37504,37505,37506,-- Festergut
36627,38390,38549,38550, -- Rotface
36678,38431,38585,38586); -- Professor Putricide

-- Remove spawns of Perimeter Bunny - they are spawned by spell 54355 used by GO 191502 (Land Mine) 
DELETE FROM `creature` WHERE `id`=29397; 

UPDATE `creature_template` SET `scale`=1 WHERE `entry`=22997;

SET @Gossip = 21289;
SET @NElf = 31111;

DELETE FROM `gossip_menu` WHERE `entry`=@Gossip AND `text_id` IN (15037,15038);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(@Gossip, 15037),
(@Gossip, 15038);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@Gossip AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`) VALUES
(@Gossip, 0, 0, 'I believe in you.', 1, 1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@Gossip;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @Gossip, 15038, 0, 1, 58493, 0, 0, 0, '', 'Mohawk Grenade - aura'),
(14, @Gossip, 15037, 0, 11, 58493, 0, 0, 0, '', 'Mohawk Grenade - no aura'),
(15, @Gossip, 0, 0, 26, 43489, 1, 0, 0, '', 'Mohawk Grenade - no item');

UPDATE `creature_template` SET `gossip_menu_id`=@Gossip,`minlevel`=80,`maxlevel`=80,`npcflag`=`npcflag`|1,`AIName`='SmartAI' WHERE `entry`=@NElf;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@NElf AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@NElf, 0, 0, 1, 62, 0, 100, 0, @Gossip, 0, 0, 0, 11, 69243, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Mohawk - On gossip select cast Create Mohawk Grenade'),
(@NElf, 0, 1, 0, 61, 0, 100, 0, @Gossip, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Night Elf Mohawk - Link - close gossip');

DELETE FROM `creature_template_addon` WHERE `entry`=36778;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(36778, 0, 0, 3, 1, 0, NULL); -- sleep

-- Applied immunities to following mechanics:
--  MECHANIC_CHARM
--  MECHANIC_DISORIENTED
--  MECHANIC_DISARM
--  MECHANIC_DISTRACT
--  MECHANIC_FEAR
--  MECHANIC_GRIP
--  MECHANIC_ROOT
--  MECHANIC_SILENCE
--  MECHANIC_SLEEP
--  MECHANIC_SNARE
--  MECHANIC_STUN
--  MECHANIC_FREEZE
--  MECHANIC_KNOCKOUT
--  MECHANIC_POLYMORPH
--  MECHANIC_BANISH
--  MECHANIC_SHACKLE
--  MECHANIC_TURN
--  MECHANIC_HORROR
--  MECHANIC_DAZE
--  MECHANIC_SAPPED

UPDATE `creature_template` SET `mechanic_immune_mask`=617299839 WHERE `entry` IN (
36597,39166,39167,39168, -- The Lich King
36612,37957,37958,37959, -- Lord Marrowgar
36626,37504,37505,37506, -- Festergut
36627,38390,38549,38550, -- Rotface
36678,38431,38585,38586, -- Professor Putricide
36853,38265,38266,38267, -- Sindragosa
36855,38106,38296,38297, -- Lady Deathwhisper
37813,38402,38582,38583, -- Deathbringer Saurfang
37955,38434,38435,38436, -- Blood-Queen Lana'thel
37970,38401,38784,38785, -- Prince Valanar
37972,38399,38769,38770, -- Prince Keseleth
37973,38400,38771,38772); -- Prince Taldaram

SET @GUID := 209102;
SET @NPC_HERENN := 28601;
SET @NPC_DEATHS_HAND_ACOLYTE := 28602;
SET @PATH := @NPC_DEATHS_HAND_ACOLYTE * 10;
SET @OMEGA_RUNE := 38708;

DELETE FROM `creature` WHERE `id` IN (@NPC_HERENN,@NPC_DEATHS_HAND_ACOLYTE);
-- add High Cultist Herenn (28601) 
INSERT INTO `creature` (`guid`,`id`,`map`,`position_x`,`position_y`,`position_z`,`orientation`) VALUES
(@GUID+10,@NPC_HERENN,1,-6028.08,-1249.02,-146.7644,3.054326);

-- add Death's Hand Acolyte (28602), genders are random (25342,25343)
INSERT INTO `creature`(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(@GUID,  @NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6163.63,-1249.54,-159.7329,3.11264,120,0,0,1,0,2),   -- wandering
(@GUID+1,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6083.673,-1249.462,-143.4821,0.01435,120,0,0,1,0,2), -- wandering 
(@GUID+2,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6037.476,-1243.375,-146.8277,5.98647,120,0,0,1,0,0), -- kneeled 
(@GUID+3,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6036.1,-1255.38,-146.8277,1.15191,120,0,0,1,0,0),    -- kneeled 
(@GUID+4,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6065.16,-1256.21,-143.3607,3.10668,120,0,0,1,0,0),
(@GUID+5,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6118.18,-1241.33,-143.281,3.12169,120,0,0,1,0,0),
(@GUID+6,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6104.965,-1243.601,-143.1921,3.12413,120,0,0,1,0,0),
(@GUID+7,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6065.27,-1242.8,-143.3297,3.14159,120,0,0,1,0,0),
(@GUID+8,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6104.698,-1256.314,-143.1921,3.05432,120,0,0,1,0,0),
(@GUID+9,@NPC_DEATHS_HAND_ACOLYTE,1,1,1,0,0,-6121.342,-1258.456,-143.1921,2.9147,120,0,0,1,0,0);

-- update creature_template Death's Hand Acolyte for equipment
UPDATE `creature_template` SET `equipment_id`=815 WHERE `entry`=@NPC_DEATHS_HAND_ACOLYTE;

-- set waypoint id's and visual effects
DELETE FROM `creature_addon` WHERE `guid` IN (@GUID,@GUID+1,@GUID+2,@GUID+3);
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@GUID  ,@PATH,0,1,0,''), 
(@GUID+1,@PATH+20,0,1,0,''), 
(@GUID+2,0,8,0,0,''),       -- kneeling
(@GUID+3,0,8,0,0,'');       -- kneeling

-- pathing Death's Hand Acolyte #1
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-6167.854,-1249.36,-162.6509,0,0,0,100,0),
(@PATH,2,-6154.54,-1249.757,-155.4785,0,0,0,100,0),
(@PATH,3,-6141.45,-1249.3,-147.7103,0,0,0,100,0),
(@PATH,4,-6140.292,-1249.466,-147.2287,0,0,0,100,0),
(@PATH,5,-6138.544,-1249.176,-145.9789,0,0,0,100,0),
(@PATH,6,-6136.085,-1249.64,-143.2982,0,0,0,100,0),
(@PATH,7,-6120.995,-1250.048,-143.2961,0,0,0,100,0),
(@PATH,8,-6133.946,-1250.144,-143.3480,0,0,0,100,0);

-- pathing Death's Hand Acolyte #2
DELETE FROM `waypoint_data` WHERE `id`=@PATH+20;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH+20,1,-6063.011,-1249.407,-143.4293,0,0,0,100,0),
(@PATH+20,2,-6067.342,-1249.435,-143.2057,0,0,0,100,0),
(@PATH+20,3,-6081.293,-1249.456,-143.4746,0,0,0,100,0),
(@PATH+20,4,-6083.673,-1249.462,-143.4821,0,0,0,100,0),
(@PATH+20,5,-6091.368,-1249.619,-143.6254,0,0,0,100,0),
(@PATH+20,6,-6100.618,-1249.619,-143.3754,0,0,0,100,0),
(@PATH+20,7,-6105.942,-1249.782,-143.2761,0,0,0,100,0);

-- SAI for High Cultist Herenn, also add loot and equipment
UPDATE `creature_template` SET `AIName`='SmartAI',`equipment_id`=1803 WHERE `entry`=@NPC_HERENN;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@NPC_HERENN;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@NPC_HERENN,0,0,0,0,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'High Cultist Herenn - in Combat - Say Text 0');

-- High Cultist Herenn talk text 
DELETE FROM `creature_text` WHERE `entry`=@NPC_HERENN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@NPC_HERENN,0,0,'Fool! You led us to the only being that could stand up to our armies! You will never bring the Etymidian back to Northrend!',12,0,100,25,0,0,'High Cultist Herenn');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warl_ritual_of_doom_effect';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18541, 'spell_warl_ritual_of_doom_effect');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dreamwalker_twisted_nightmares';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(71941, 'spell_dreamwalker_twisted_nightmares');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dreamwalker_summon_suppresser_effect';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(70936, 'spell_dreamwalker_summon_suppresser_effect');

UPDATE `creature_template` SET `scriptname`='mob_bullet_controller' WHERE `entry` = 34743;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `ConditionTypeOrReference` = 18 AND `SourceEntry` IN (66152,66153);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 66152, 0, 18, 1, 34720, 1, 0, '', 'Light Bullets Stalker - Light Orb Spawn'),
(13, 0, 66153, 0, 18, 1, 34704, 1, 0, '', 'Dark Bullets Stalker - Dark Orb Spawn');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (53475,53487,54015);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(53475, 'spell_gen_oracle_wolvar_reputation'), -- Set Oracle Faction Friendly
(53487, 'spell_gen_oracle_wolvar_reputation'), -- Set Wolvar Faction Honored
(54015, 'spell_gen_oracle_wolvar_reputation'); -- Set Oracle Faction Honored
DELETE FROM command WHERE name = 'dev';
INSERT INTO command VALUES
('dev', 3, 'Syntax: .dev [on/off]\r\n\r\nEnable or Disable in game Dev tag or show current state if on/off not provided.');

DELETE FROM trinity_string WHERE entry IN (1137, 1138);
INSERT INTO trinity_string (`entry`,`content_default`) VALUES
(1137, 'Dev mode is ON'),
(1138, 'Dev mode is OFF');

DELETE FROM `spell_script_names` WHERE `spell_id`=63342;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(63342,'spell_kologarn_summon_focused_eyebeam');

-- Remove redundant areatrigger scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` IN(5369,5423);
-- Add spellscript for trap spell
DELETE FROM `spell_script_names` WHERE `spell_id`=62705;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62705,'spell_auto_repair');


-- [Q] Help Tavara

-- Tavara SAI
SET @ENTRY := 17551;
SET @SPELL_GIFT_OF_THE_NAARU_PR := 59544; -- Gift of the Naaru - Priest
SET @SPELL_LESSER_HEAL_R1 := 2050; -- Lesser Heal R1
SET @SPELL_LESSER_HEAL_R2 := 2052; -- Lesser Heal R2
SET @SPELL_RENEW_R1 := 139; -- Renew R1 (they don't have R2 yet)
UPDATE `creature_template` SET `AIName`='SmartAI',`RegenHealth`=0 WHERE `entry`=@ENTRY;
UPDATE `quest_template` SET `ReqSpellCast1`=0 WHERE `entry`=9586;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_LESSER_HEAL_R1,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(@ENTRY,0,1,0,8,0,100,1,@SPELL_LESSER_HEAL_R2,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_GIFT_OF_THE_NAARU_PR,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit"),
(@ENTRY,0,3,0,8,0,100,1,@SPELL_RENEW_R1,0,0,0,33,17551,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tavara - On Spellhit - Give Quest Credit");

-- [Q] Weakness to Lightning

-- Scavenge-bot 004-A8 SAI
SET @ENTRY := 25752;
SET @SPELL_CUTING_LASER := 49945;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,10000,10000,15000,11,@SPELL_CUTING_LASER,0,0,0,0,0,2,0,0,0,0,0,0,0,"Scavenge-bot 004-A8 - In Combat - Cast Cutting Laser"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scavenge-bot 004-A8 - On Spellhit - Set Phase 1"),
(@ENTRY,0,2,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Scavenge-bot 004-A8 - On Death - Quest Credit (Phase 1)");

-- Scavenge-bot 005-B6 SAI
SET @ENTRY := 25792;
SET @SPELL_CUTING_LASER := 49945;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,10000,10000,15000,11,@SPELL_CUTING_LASER,0,0,0,0,0,2,0,0,0,0,0,0,0,"Scavenge-bot 005-B6 - In Combat - Cast Cutting Laser"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scavenge-bot 005-B6 - On Spellhit - Set Phase 1"),
(@ENTRY,0,2,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Scavenge-bot 005-B6 - On Death - Quest Credit (Phase 1)");

-- Defendo-tank 66D SAI
SET @ENTRY := 25758;
SET @SPELL_SHOOT := 49987;
SET @SPELL_MACHINE_GUN := 49981;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Defendo-tank 66D - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,0,0,100,0,1100,3100,2300,13700,11,@SPELL_SHOOT,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defendo-tank 66D - In Combat - Cast Shoot"),
(@ENTRY,0,2,0,0,0,100,0,9800,13100,18300,19200,11,@SPELL_MACHINE_GUN,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defendo-tank 66D - In Combat - Cast Machine Gun"),
(@ENTRY,0,3,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defendo-tank 66D - On Spellhit - Set Phase 1"),
(@ENTRY,0,4,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Defendo-tank 66D - On Death - Quest Credit (Phase 1)");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Incoming $r flier! Shoot $g him:her; down!",12,0,100,0,0,0,"Defendo-tank 66D");

-- Sentry-bot 57-K SAI
SET @ENTRY := 25753;
SET @SPELL_STUN := 46641;
SET @SPELL_FIREWORK := 6668;
SET @SPELL_POWER_OF_THE_STORM := 46432;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=`mechanic_immune_mask`|8 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,3000,13000,13000,26000,11,@SPELL_FIREWORK,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentry-bot 57-K - Out of Combat - Cast Red Firework"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentry-bot 57-K - On Aggro - Say Line 0"),
(@ENTRY,0,2,0,0,0,100,0,1100,3100,2300,13700,11,@SPELL_STUN,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sentry-bot 57-K - In Combat - Cast Stun"),
(@ENTRY,0,3,0,8,0,100,0,@SPELL_POWER_OF_THE_STORM,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sentry-bot 57-K - On Spellhit - Set Phase 1"),
(@ENTRY,0,4,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,7,0,0,0,0,0,0,0,"Sentry-bot 57-K - On Death - Quest Credit (Phase 1)");

-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Warning! Warning! Intruder alert! Intruder alert!",12,0,100,0,0,0,"Sentry-bot 57-K"),
(@ENTRY,0,1,"You have been detected. You will be assimilated or eliminated.",12,0,100,0,0,0,"Sentry-bot 57-K"),
(@ENTRY,0,2,"Activate counter-measures. Repel intruder.",12,0,100,0,0,0,"Sentry-bot 57-K");

DELETE FROM `conditions` WHERE `SourceEntry` IN (35352) AND `ConditionValue2` IN (25752,25792,25758,25753);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,35352,0,24,1,25752,0,0,'',"Spell Power of the Storm can only be cast at Scavenge-bot 004-A8"),
(18,0,35352,0,24,1,25792,0,0,'',"Spell Power of the Storm can only be cast at Scavenge-bot 005-B6"),
(18,0,35352,0,24,1,25758,0,0,'',"Spell Power of the Storm can only be cast at Defendo-tank 66D"),
(18,0,35352,0,24,1,25753,0,0,'',"Spell Power of the Storm can only be cast at Sentry-bot 57-K");


-- Mammoth Calf SAI
SET @ENTRY := 24613;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_TRAMPLE := 15550;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Mammoth Calf - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_TRAMPLE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mammoth Calf - In Combat - Cast Trample");

-- Wooly Mammoth SAI
SET @ENTRY := 24614;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_TRAMPLE := 15550;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Mammoth - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_TRAMPLE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wooly Mammoth - In Combat - Cast Trample");

-- Wooly Rhino Bull SAI
SET @ENTRY := 25489;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_RHINO_CHARE := 50500;
SET @SPELL_THICK_HIDE := 50502;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Rhino Bull - On Death - Cast Animal Blood"),
(@ENTRY,0,1,2,4,0,100,0,0,0,0,0,11,@SPELL_RHINO_CHARE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wooly Rhino Bull - On Aggro - Cast Rhino Charge"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,11,@SPELL_THICK_HIDE,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wooly Rhino Bull - On Aggro - Cast Thick Hide");

-- Carrion Condor SAI
SET @ENTRY := 26174;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_SWOOP := 5708;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Carrion Condor - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_SWOOP,0,0,0,0,0,2,0,0,0,0,0,0,0,"Carrion Condor - In Combat - Cast Swoop");

-- Marsh Caribou SAI
SET @ENTRY := 25680;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_GORE := 32019;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Marsh Caribou - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_GORE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Marsh Caribou - In Combat - Cast Gore");

-- Marsh Fawn SAI
SET @ENTRY := 25829;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_GORE := 32019;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Marsh Fawn - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_GORE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Marsh Fawn - In Combat - Cast Gore");

-- Sand Turtle SAI
SET @ENTRY := 25482;
SET @SPELL_ANIMAL_BLOOD := 46221;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Sand Turtle - On Death - Cast Animal Blood");

-- Tundra Wolf SAI
SET @ENTRY := 25675;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_INFECTED_BITE := 7367;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Tundra Wolf - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_INFECTED_BITE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Tundra Wolf - In Combat - Cast Infected Bite");

-- Wooly Mammoth Bull SAI
SET @ENTRY := 25743;
SET @SPELL_THUNDERING_ROAR := 46316;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Mammoth Bull - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,0,0,100,0,3000,9000,9000,18000,11,@SPELL_THUNDERING_ROAR,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wooly Mammoth Bull - In Combat - Cast Thundering Roar"); -- It's a fear spell

-- Wooly Rhino Calf SAI
SET @ENTRY := 25488;
SET @SPELL_ANIMAL_BLOOD := 46221;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Rhino Calf - On Death - Cast Animal Blood");

-- Wooly Rhino Matriarch SAI
SET @ENTRY := 25487;
SET @SPELL_ANIMAL_BLOOD := 46221;
SET @SPELL_THICK_HIDE := 50502;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,@SPELL_ANIMAL_BLOOD,2,0,0,0,0,7,0,0,0,0,0,0,0,"Wooly Rhino Matriarch - On Death - Cast Animal Blood"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,11,@SPELL_THICK_HIDE,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wooly Rhino Matriarch - On Aggro - Cast Thick Hide");

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_bloodlust';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_heroism';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(2825,'spell_sha_bloodlust'),
(32182,'spell_sha_heroism');


DELETE FROM `spell_script_names` WHERE `spell_id` IN (62374,62475);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(62374,'spell_pursue'),
(62475,'spell_systems_shutdown');

-- Set `title_A` to male variant (Patron)
UPDATE `achievement_reward` SET `title_A`=138 WHERE `entry`=1793;

DELETE FROM `spell_dbc` WHERE `Id`=72958;
INSERT INTO `spell_dbc` (`Id`,`Attributes`,`AttributesEx`,`AttributesEx2`,`ProcChance`,`DurationIndex`,`Effect1`,`EffectImplicitTargetA1`,`EffectApplyAuraName1`,`EffectAmplitude1`,`EffectTriggerSpell1`,`Comment`) VALUES
(72958,0x000001C0,0,0,101,21,6,1,23,85000,72957,'Shaman T10 shoulder visual');

ALTER TABLE `game_event_creature` DROP PRIMARY KEY, ADD PRIMARY KEY (`guid`,`eventEntry`);
ALTER TABLE `game_event_gameobject` DROP PRIMARY KEY, ADD PRIMARY KEY (`guid`,`eventEntry`);

-- Fix quest 11162 Challenge to the Black Flight
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~768 WHERE `entry`=23789; -- Smolderwing

UPDATE `gameobject_template` SET `faction`=1732 WHERE `entry`=195139; -- Portal to Stormwind
UPDATE `gameobject_template` SET `faction`=1735 WHERE `entry`=195140; -- Portal to Orgrimmar

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128|2 WHERE `entry` IN (18967,18968,19230); -- Dark Assault - Alliance/Horde/Legion Portal - Invisible Stalker

DELETE FROM `gameobject` WHERE `id` IN (195139, 195140);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(164, 195140, 530, 1, 1, -161.3178, 965.4099, 54.29044, 0, 0, 0, 0, 0, 200, 0, 1), -- Portal to Orgrimmar
(170, 195139, 530, 1, 1, -337.4917, 962.6188, 54.28853, 0, 0, 0, 0, 0, 200, 0, 1); -- Portal to Stormwind

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128|2 WHERE `entry` IN (19871); -- World Trigger (World Trigger (Not Immune NPC))

DELETE FROM `game_event_creature` WHERE `guid` IN (62848,62849) AND `eventEntry`=11;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES 
(11, 62848),
(11, 62849);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=41058;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 0, 41058, 0, 24, 1, 29625, 0, 0, '', 'Hyldnir Harpoon target Hyldsmeet Proto-Drake'),
(18, 0, 41058, 0, 24, 1, 29754, 0, 0, '', 'Hyldnir Harpoon target Column Ornament');

-- Fix quest Strength of the Tempest
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=29079;
DELETE FROM `smart_scripts` WHERE `entryorguid`=29079 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29079,0,0,0,9,0,100,0,0,70,2000,6000,11,53062,0,0,0,0,0,18,70,0,0,0,0,0,0,'Shrine of the Tempest - Range cast Lightning Strike'); -- GUESSING, 10% sure that this is the correct spell. Could 51213 Weather Shrine Active Aura

DELETE FROM `spell_scripts` WHERE `id`=53062;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(53062, 0, 0, 15, 53067, 2, 0, 0, 0, 0, 0); -- Cast create item spell

UPDATE `creature_template` SET `unit_flags`=32768,`equipment_id`=53 WHERE `entry`=24062; -- Wildervar Miner
UPDATE `creature_template` SET `unit_flags`=33536 WHERE `entry`=24178; -- Shatterhorn

UPDATE `creature_model_info` SET `bounding_radius`=1.25,`combat_reach`=4.375,`gender`=0 WHERE `modelid`=22486; -- Shatterhorn

DELETE FROM `creature_template_addon` WHERE `entry` IN (24062,24178);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(24062,0,1,257,0, NULL), -- Wildervar Miner
(24178,0,3,1,0, '6606'); -- Shatterhorn, Self Visual - Sleep Until Cancelled  (DND)
DELETE FROM `creature_addon` WHERE `guid` IN (120419,120422,106573);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(120419,0,0,0,0,1,''), -- Wildervar Miner, talk
(120422,0,0,0,0,1,''); -- Wildervar Miner, talk

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;

-- The ram meat spell may only be used if player is inside the mine
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=43209;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,43209,0,23,4534,0,0,64,'','Place Ram Meat can only be used in Wildervar Mine');

-- Insert missing spell_target_position for Place Ram Meat spell
DELETE FROM `spell_target_position` WHERE `id`=43209;
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(43209,571,2636.288086,-5050.891113,295.537445,5.374982);

-- Shatterhorn SAI
SET @ENTRY := 24178;
SET @SPELL_GROUND_SMASH := 12734; -- Ground Smash
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Aggro - Say Line 0'),
(@ENTRY,0,1,0,0,0,100,0,3000,5000,12000,13000,11,@SPELL_GROUND_SMASH,1,0,0,0,0,2,0,0,0,0,0,0,0,'Shatterhorn - In Combat - Cast Ground Smash'),
(@ENTRY,0,2,0,6,0,100,0,0,0,0,0,41,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - Force Despawn 8 Seconds After Death'),
(@ENTRY,0,3,0,8,0,0,0,43209,0,0,0,19,0x300,1,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove unit flags'),
(@ENTRY,0,4,0,8,0,0,0,43209,0,0,0,28,6606,1,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove sleep aura'),
(@ENTRY,0,5,0,8,0,0,0,43209,0,0,0,91,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove byte1 3');

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'%s wakes up from the smell of fresh meat!',16,0,100,15,0,0,'Shatterhorn on aggro line and roar at same time');

/* Target is null, can't use event_scripts
-- Event send by Place Ram Meat spell
DELETE FROM `event_scripts` WHERE `id`=15739;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(15739, 2, 14, 6606, 0, 0, 0, 0, 0, 0),
(15739, 3, 5, 0x6+0x35, 0x300, 0, 0, 0, 0, 0);
*/

-- Fix quest What Illidan Wants, Illidan Gets...
-- Make the npc_text entries work properly
DELETE FROM `gossip_menu` WHERE `entry` IN (8336,8342,8341,8340,8339,8338) AND `text_id` IN (10401,10405,10406,10407,10408,10409);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES 
(8336,10401),
(8342,10405),
(8341,10406),
(8340,10407),
(8339,10408),
(8338,10409);

-- Conditions for gossip menu of quest What Illidan Wants, Illidan Gets...
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8336;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8336,0,0,9,10577,0,0,0,'','Only show first gossip if player is on quest What Illidan Wants, Illidan Gets...');

-- Insert options (for players)
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (8336,8342,8341,8340,8339,8338);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(8336,0,0,'I bring word from Lord Illidan.',1,1,8342),
(8342,0,0,'The cipher fragment is to be moved. Have it delivered to Zuluhed.',1,1,8341),
(8341,0,0,'Perhaps you did not hear me, Ruusk. I am giving you an order from Illidan himself!',1,1,8340),
(8340,0,0,'Very well. I will return to the Black Temple and notify Lord Illidan of your unwillingness to carry out his wishes. I suggest you make arrangements with your subordinates and let them know that you will soon be leaving this world.',1,1,8339),
(8339,0,0,'Do I need to go into all the gory details? I think we are both well aware of what Lord Illidan does with those that would oppose his word. Now, I must be going! Farewell, Ruusk! Forever...',1,1,8338),
(8338,0,0,'Ah, good of you to come around, Ruusk. Thank you and farewell.',1,1,0); -- Here the quest credit is given

-- Commander Ruusk SAI
UPDATE `creature_template` SET `gossip_menu_id`=8336,`AIName`='SmartAI' WHERE `entry`=20563;
DELETE FROM `smart_scripts` WHERE `entryorguid`=20563 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(20563,0,0,1,62,0,100,0,8338,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Ruusk - On Gossip Select - Close Gossip'),
(20563,0,1,0,61,0,100,0,0,0,0,0,26,10577,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Ruusk - On Gossip Select (link) - Quest Credit');

SET @ENTRY_FIRJUS := 24213;
SET @ENTRY_JLARBORN := 24215;
SET @ENTRY_YORUS := 24214;
SET @ENTRY_OLUF := 23931;
SET @QUEST := 11300;

-- Summon Firjus on quest accept - this starts the quest
UPDATE `quest_template` SET `StartScript`=@QUEST WHERE `entry`=@QUEST;
DELETE FROM `quest_start_scripts` WHERE `id`=@QUEST;
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(@QUEST,3,10,@ENTRY_FIRJUS,300000,0,799.653931,-4718.678711,-96.236053,4.992353);

-- Firjus, Jlarborn, Yorus and Oluf SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY_FIRJUS,@ENTRY_JLARBORN,@ENTRY_YORUS,@ENTRY_OLUF);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (@ENTRY_FIRJUS,@ENTRY_JLARBORN,@ENTRY_YORUS,@ENTRY_OLUF);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_FIRJUS,@ENTRY_JLARBORN,@ENTRY_YORUS,@ENTRY_OLUF) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY_FIRJUS,0,0,0,0,0,100,0,3000,6000,12000,15000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Firjus - In Combat - Cleave'),
(@ENTRY_FIRJUS,0,1,0,0,0,100,0,10000,10000,10000,10000,11,43348,0,0,0,0,0,2,0,0,0,0,0,0,0,'Firjus - In Combat - Head Crush'),
(@ENTRY_FIRJUS,0,2,0,6,0,100,1,0,0,0,0,12,@ENTRY_JLARBORN,1,300000,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Firjus - On Death - Summon Jlarborn'),
(@ENTRY_JLARBORN,0,0,0,0,0,100,1,1000,2000,0,0,11,19131,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jlarborn - In Combat - Shield Charge'),
(@ENTRY_JLARBORN,0,1,0,0,0,100,0,4000,5000,15000,16000,11,12169,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jlarborn - In Combat - Shield Block'),
(@ENTRY_JLARBORN,0,2,0,0,0,100,0,7000,8000,18000,19000,11,38233,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jlarborn - In Combat - Shield Bash'),
(@ENTRY_JLARBORN,0,3,0,0,0,100,0,10000,10000,10000,10000,11,8374,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jlarborn - In Combat - Arcing Smash'),
(@ENTRY_JLARBORN,0,4,0,6,0,100,1,0,0,0,0,12,@ENTRY_YORUS,1,300000,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Jlarborn - On Death - Summon Yorus'),
(@ENTRY_YORUS,0,0,0,0,0,100,0,3000,6000,12000,15000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Yorus - In Combat - Cleave'),
(@ENTRY_YORUS,0,1,0,0,0,100,0,8000,9000,18000,19000,11,41057,0,0,0,0,0,1,0,0,0,0,0,0,0,'Yorus - In Combat - Whirlwind'),
(@ENTRY_YORUS,0,2,0,6,0,100,1,0,0,0,0,12,@ENTRY_OLUF,1,300000,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Yorus - On Death - Summon Oluf'),
(@ENTRY_OLUF,0,0,0,0,0,100,0,3000,6000,12000,15000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Oluf - In Combat - Cleave'),
(@ENTRY_OLUF,0,1,0,0,0,100,0,8000,9000,28000,29000,11,13730,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oluf - In Combat - Demoralizing Shout'),
(@ENTRY_OLUF,0,2,0,0,0,100,0,7000,7000,21000,21000,11,6533,0,0,0,0,0,2,0,0,0,0,0,0,0,'Oluf - In Combat - Net'),
(@ENTRY_OLUF,0,3,0,0,0,100,1,1000,1000,0,0,11,42870,0,0,0,0,0,2,0,0,0,0,0,0,0,'Oluf - In Combat - Throw Harpoon'),
(@ENTRY_OLUF,0,4,0,0,0,100,0,10000,10000,10000,10000,11,41057,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oluf - In Combat - Whirlwind'),
(@ENTRY_OLUF,0,5,0,6,0,100,1,0,0,0,0,50,186640,90000,0,0,0,0,8,0,0,0,799.653931,-4718.678711,-96.236053,4.992353,'Oluf - On Death - Summon Ancient Cipher');

-- Doctor Razorgrin SAI
SET @ENTRY := 25678;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `creature_ai_texts` WHERE `entry`=-767;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Doctor Razorgin - On Aggro - Say Line 0 (random)');
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'Ah, good... more parts!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,1,'Clear!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,2,'Fresh meat!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,3,'I recommened evisceration!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,4,'It''s no good... you need more work first.',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,5,'Live, damn you!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines'),
(@ENTRY,0,6,'The doctor is in!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines');

UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16,`unit_flags`=0x8040,`speed_run`=2.85714,`InhabitType`=`InhabitType`|4 WHERE `entry`=32358; -- Fumblub Gearwind
UPDATE `creature_template` SET `faction_A`=1885,`faction_H`=1885,`unit_flags`=0x8040,`speed_run`=1.28571 WHERE `entry`=32438; -- Syreian the Bonecarver

UPDATE `creature_model_info` SET `bounding_radius`=1.25,`combat_reach`=3.919432,`gender`=1 WHERE `modelid`=27970; -- Syreian the Bonecarver

UPDATE `creature_addon` SET `mount`=25587, `bytes1`=0x3000000 WHERE `guid`=151938; -- Fumblub Gearwind

DELETE FROM `creature_template_addon` WHERE `entry` IN (32358,32438);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(32358,25587,0x3000000,1,0, NULL), -- Fumblub Gearwind
(32438,0,0,2,0, NULL); -- Syreian the Bonecarver

-- Removing obsolete quest 960, which was replaced by quest 961
DELETE FROM `creature_questrelation` WHERE `quest`=960;
DELETE FROM `creature_involvedrelation` WHERE `quest`=960;

DELETE FROM `disables` WHERE `sourceType`=1 AND `entry`=960;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1, 960, 0, '', '', 'Deprecated quest');

-- Skin loot entry
SET @LibraryLaborer := 29724;
SET @UldarBoss := 29725;
SET @AirStrip := 29726;
SET @ReavandDispo := 29727;
SET @HallsofStone := 29728;
SET @Dirkee := 29729;
SET @Recovery := 29730;
-- Ref Loot Entry
SET @UldarBossRef := 50013;
SET @AirStripRef := 50013+1;
SET @HallsofStoneRef := 50013+2;
SET @ReavandDispoRef := 50013+3;
SET @LibraryLaborerRef := 50013+4;
-- Add loot to the skinning table 
DELETE FROM `skinning_loot_template` WHERE `entry` IN (@Recovery,@Dirkee,@LibraryLaborer,@ReavandDispo,@HallsofStone,@AirStrip,@UldarBoss);
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES 
(@Recovery, 41338, 42, 1, 0, 1, 3), -- Sprung Whirlygig
(@Recovery, 41337, 44, 1, 0, 1, 3), -- Whizzed out Gizmo
(@Recovery, 39690, 9, 1, 0, 1, 3), -- Volatile Blasting trigger
(@Recovery, 39681, 4, 1, 0, 2, 4), -- Handfull of copper bolts
(@Recovery, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@Recovery, 39682, 0.5, 1, 0, 1, 1), -- Overcharged Capacitor
(@Dirkee, 41338, 42, 1, 0, 1, 3), -- Sprung Whirlygig
(@Dirkee, 41337, 44.5, 1, 0, 1, 3), -- Whizzed out Gizmo
(@Dirkee, 39690, 10, 1, 0, 1, 3), -- Volatile Blasting trigger
(@Dirkee, 39681, 3, 1, 0, 2, 4), -- Handfull of copper bolts
(@Dirkee, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@LibraryLaborer , 1, 100, 1, 0, -@LibraryLaborerRef, 1),
(@ReavandDispo, 1, 100, 1, 0, -@ReavandDispoRef, 1),
(@HallsofStone, 1, 100, 1, 0, -@HallsofStoneRef, 1),
(@AirStrip, 1, 100, 1, 0, -@AirStripRef, 1),
(@UldarBoss, 1, 100, 1, 0, -@UldarBossRef, 1);
-- Add loot to the reference table 
DELETE FROM `reference_loot_template` WHERE `entry` IN (@AirStripRef,@ReavandDispoRef,@LibraryLaborerRef,@HallsofStoneRef,@UldarBossRef);
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES 
(@AirStripRef, 41338, 33, 1, 0, 1, 1), -- Sprung Whirlygig
(@AirStripRef, 41337, 42, 1, 0, 1, 1), -- Whizzed out Gizmo
(@AirStripRef, 39690, 13, 1, 0, 1, 3), -- Volatile Blasting trigger
(@AirStripRef, 39681, 10, 1, 0, 1, 4), -- Handfull of copper bolts
(@AirStripRef, 39686, 1.2, 1, 0, 1, 1), -- Frost steel Tube
(@AirStripRef, 49050, 0.8, 1, 0, 1, 1), -- jeeves
(@ReavandDispoRef, 41338, 40, 1, 0, 1, 3), -- Sprung Whirlygig
(@ReavandDispoRef, 41337, 40, 1, 0, 1, 3), -- Whizzed out Gizmo
(@ReavandDispoRef, 39690, 9.5, 1, 0, 1, 3), -- Volatile Blasting trigger
(@ReavandDispoRef, 39681, 9.5, 1, 0, 2, 4), -- Handfull of copper bolts
(@ReavandDispoRef, 39686, 0.5, 1, 0, 1, 1), -- Frost steel Tube
(@ReavandDispoRef, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@LibraryLaborerRef, 41338, 43, 1, 0, 1, 3), -- Sprung Whirlygig
(@LibraryLaborerRef, 41337, 42, 1, 0, 1, 3), -- Whizzed out Gizmo
(@LibraryLaborerRef, 39690, 9, 1, 0, 1, 3), -- Volatile Blasting trigger
(@LibraryLaborerRef, 39681, 4, 1, 0, 2, 4), -- Handfull of copper bolts
(@LibraryLaborerRef, 49050, 1, 1, 0, 1, 1), -- jeeves
(@LibraryLaborerRef, 39686, 0.5, 1, 0, 1, 1), -- Frost steel Tube
(@LibraryLaborerRef, 39682, 0.5, 1, 0, 1, 1), -- Overcharged Capacitor
(@HallsofStoneRef, 41338, 43.5, 1, 0, 1, 3), -- Sprung Whirlygig
(@HallsofStoneRef, 41337, 42, 1, 0, 1, 3), -- Whizzed out Gizmo
(@HallsofStoneRef, 39690, 8, 1, 0, 1, 3), -- Volatile Blasting trigger
(@HallsofStoneRef, 39681, 5, 1, 0, 2, 4), -- Handfull of copper bolts
(@HallsofStoneRef, 49050, 0.5, 1, 0, 1, 1), -- jeeves
(@HallsofStoneRef, 39686, 0.5, 1, 0, 1, 1), -- Frost steel Tube
(@HallsofStoneRef, 39682, 0.5, 1, 0, 1, 1), -- Overcharged Capacitor
(@UldarBossRef, 35627, 43, 1, 0, 2, 10), -- Eternal Shadow
(@UldarBossRef, 35624, 42, 1, 0, 4, 10), -- Eternal Earth
(@UldarBossRef, 35623, 43, 1, 0, 2, 6), -- Eternal Air
(@UldarBossRef, 36860, 42, 1, 0, 2, 6), -- Eternal Fire
(@UldarBossRef, 39690, 30, 1, 0, 16, 19), -- Volatile Blasting trigger
(@UldarBossRef, 39686, 26, 1, 0, 2, 3), -- Frost steel Tube
(@UldarBossRef, 39682, 22, 1, 0, 5, 5), -- Overcharged Capacitor
(@UldarBossRef, 39681, 21, 1, 0, 8, 10), -- Handfull of copper bolts
(@UldarBossRef, 49050, 2, 1, 0, 1, 1); -- jeeves

UPDATE `creature_template` SET `skinloot`=@LibraryLaborer WHERE `entry` IN (29389,29724); -- Library Guardian and Mechagnome Laborer
UPDATE `creature_template` SET `skinloot`=@ReavandDispo WHERE `entry` IN (34273,34274,29382); -- Stromforged Reaver and XB-488 Disposalbot
UPDATE `creature_template` SET `skinloot`=@Dirkee WHERE `entry`=32500; -- Dirkee
UPDATE `creature_template` SET `skinloot`=@Recovery WHERE `entry` IN (34267,34268); -- Parts Recovery Technician
UPDATE `creature_template` SET `skinloot`=@AirStrip WHERE `entry` IN (32358,25792,25758,25752,25753,25814,25793); -- Fumblub Gearwind, Scavenge-bot 005-B6, Defendo-tank 66D, Scavenge-bot 004-A8, Sentry-bot 57-K, Fizzcrank Mechagnome, 55-D Collect-a-tron
UPDATE `creature_template` SET `skinloot`=@HallsofStone WHERE `entry` IN (27972,31383,27971,31387); -- Lightning Construct, Unrelenting Construct
UPDATE `creature_template` SET `skinloot`=@UldarBoss WHERE `entry` IN (34332,34106,33113,34003,33293,33885); -- Leviathan Mk II, Flame Leviathan, XT-002 Deconstructor

-- Jormunger Control Orb
DELETE FROM `gameobject` WHERE `id`=192262;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(173, 192262, 571, 1, 0x8, 8497.219, -90.90104, 789.2875, 0.1396245, 0, 0, 0.06975555, 0.9975641, 0, 0, 0);

DELETE FROM `creature` WHERE `id` IN (30301,30322,30300);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(4089, 30301, 571, 1, 0x8, 0, 0, 8497.78, -99.0251, 786.528, 3.01942, 120, 0, 0, 1, 0, 0, 0, 0, 0), -- Tamed Jormungar
(4090, 30322, 571, 1, 0x8, 0, 0, 8505.47, -86.2532, 787.339, 3.28122, 120, 0, 0, 1, 0, 0, 0, 0, 0), -- Earthen Jormungar Handler
(4765, 30322, 571, 1, 0x8, 0, 0, 8502.62, -111.308, 790.176, 3.05433, 120, 0, 0, 1, 0, 0, 0, 0, 0),
(6095, 30322, 571, 1, 0x8, 0, 0, 8498.78, -46.0375, 788.895, 2.53073, 120, 0, 0, 1, 0, 0, 0, 0, 0),
(6096, 30300, 571, 1, 0x8, 0, 0, 8015.63, -126.515, 865.719, 3.39914, 120, 0, 0, 1, 0, 0, 0, 0, 0); -- Iron Colossus

-- Template updates
UPDATE `gameobject_template` SET `flags`=0x4 WHERE `entry`=192262; -- Jormungar Control Orb
UPDATE `creature_template` SET `faction_A`=1771,`faction_H`=1771,`unit_flags`=0x8040,`speed_walk`=2.8,`speed_run`=1.5873 WHERE `entry`=30300; -- Iron Colossus
UPDATE `creature_template` SET `faction_A`=1770,`faction_H`=1770,`npcflag`=0x1,`unit_flags`=0x300,`equipment_id`=1003,`speed_run`=0.99206 WHERE `entry`=30322; -- Earthen Jormungar Handler
UPDATE `creature_template` SET `faction_A`=113,`faction_H`=113,`unit_flags`=0x300,`speed_walk`=6,`speed_run`=2.14286,`VehicleId`=227 WHERE `entry`=30301; -- Tamed Jormungar

-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=3.1,`combat_reach`=50,`gender`=0 WHERE `modelid`=27093; -- Iron Colossus
UPDATE `creature_model_info` SET `bounding_radius`=0.31,`combat_reach`=1,`gender`=0 WHERE `modelid`=26091; -- Earthen Jormungar Handler
UPDATE `creature_model_info` SET `bounding_radius`=1.55,`combat_reach`=5,`gender`=2 WHERE `modelid`=26935; -- Tamed Jormungar

-- Addon data for creature 30300 (Iron Colossus)
DELETE FROM `creature_template_addon` WHERE `entry` IN (30300,30322,30301);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30300,0,0,1,0, NULL), -- Iron Colossus
(30322,0,0,1,0, NULL), -- Earthen Jormungar Handler
(30301,0,0,1,0, NULL); -- Tamed Jormungar

DELETE FROM `spell_area` WHERE spell=56526;
INSERT INTO `spell_area`(`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES 
(56526,4436,13007,1,13007,0,0,2,1), -- Snowdrift Plains
(56526,4435,13007,1,13007,0,0,2,1); -- Navirs Cradle

DELETE FROM `spell_dbc` WHERE `Id`=31247;
INSERT INTO `spell_dbc`(`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(31247,0,0,256,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,-1,0,0,77,0/*122*/,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'Silithyst Cap Reward');

UPDATE `creature_template` SET `minlevel`=82, `maxlevel`=82 WHERE `entry`=31674; -- Ingvar the Plunderer (1)

DELETE FROM `player_factionchange_items` WHERE `alliance_id`=48356; -- Wrong entry
 
DELETE FROM `player_factionchange_spells` WHERE `alliance_id` IN (67093,67091,67095,67096,67092,67085,67080,67082,67087,67083,67084,67086,60867,67065,67064,67079,67066);
INSERT INTO `player_factionchange_spells` (`alliance_id`,`horde_id`) VALUES
(67093,67132),
(67091,67130),
(67095,67134),
(67096,67135),
(67092,67131),
(67085,67141),
(67080,67136),
(67082,67138),
(67087,67139),
(67083,67143),
(67084,67140),
(67086,67142),
(60867,60866),
(67065,67147),
(67064,67144),
(67079,67145),
(67066,67146);
 
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (47003,47626,44503,47654);
INSERT INTO `player_factionchange_items` (`race_A`,`alliance_id`,`commentA`,`race_H`,`horde_id`,`commentH`) VALUES
(0,47003,'Dawnbreaker Greaves',0,47430,'Dawnbreaker Sabatons'),
(0,47626,'Plans: Sunforged Breastplate',0,47643,'Plans: Sunforged Breastplate'),
(0,44503,'Schematic: Mekgineers Chopper',0,44502,'Schematic: Mechano-Hog'),
(0,47654,'Pattern: Bejeweled Wizards Bracers',0,47639,'Pattern: Bejeweled Wizards Bracers');

SET @ENTRY := 33499; -- Skeletal Woodcutter
SET @QUEST_LOOT := 45080; -- Large Femur
SET @QUEST := 13654; -- There's Something About the Squire
SET @SPELL1 := 63124; -- Incapacitate Maloric
SET @SPELL2 := 63126; -- Search Maloric

-- add quest item to Skeletal Woodcutter
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@ENTRY;
DELETE FROM `creature_loot_template` WHERE `entry`=@ENTRY;
INSERT INTO `creature_loot_template` VALUES
(@ENTRY,@QUEST_LOOT,-100,1,0,1,1); -- 100% drop

-- set visual effects on the skeletons
DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`emote`) VALUES
(@ENTRY,234); -- chopping wood

SET @ENTRY := 33498; -- Maloric
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,23,0,100,0,@SPELL1,1,0,0,81,16777216,0,0,0,0,0,1,0,0,0,0,0,0,0,'Maloric - on Aura: Incapacitate Maloric - set npcflag: Spellclick'),
(@ENTRY,0,1,0,23,0,100,0,@SPELL1,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Maloric - on NoAura: Incapacitate Maloric - set npcflag: none');

-- conditions for Large Femur and Maloric
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=@QUEST_LOOT;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@SPELL2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,@QUEST_LOOT,0,24,1,@ENTRY,0,0,'','Item:Large Femur only target Maloric'),
(17,0,@SPELL2,0,9,@QUEST,0,0,0,'','Needs taken Quest 13654 to perform Spell: Search Maloric');

-- cast search Maloric, get quest item, quest completed
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=@ENTRY;
INSERT INTO `npc_spellclick_spells` VALUES
(@ENTRY,@SPELL2,@QUEST,1,@QUEST,2,0,0,0);

-- [Q] Scourgekabob
-- Despawn Mummy Bunny SAI
SET @ENTRY := 27931;
SET @SPELL_CREDIT := 50035;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts`  (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)  VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,11,@SPELL_CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0,'Despawn Mummy Bunny - Just Summoned - Quest Credit');

-- Fix an older sql guid
DELETE FROM `gameobject` WHERE `id`=192262; -- Jormunger Control Orb
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(173, 192262, 571, 1, 0x8, 8497.219, -90.90104, 789.2875, 0.1396245, 0, 0, 0.06975555, 0.9975641, 0, 0, 0);

-- Saronite Mine Slave SAI
SET @ENTRY := 31397;
SET @QUEST := 13300;
SET @GOSSIP := 10137;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Saronite Mine Slave - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,1,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Yell Line (random)"),
(@ENTRY*100,9,2,0,0,0,100,1,0,0,0,0,33,31866,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Quest Credit"),
(@ENTRY*100,9,3,0,0,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,0,0,0,0,0,0,0,0,"Saronite Mine Slave - On Script - Force Despawn");

-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"AHAHAHAHA... you'll join us soon enough!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,1,"I don't want to leave! I want to stay here!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,2,"NO! You're wrong! The voices in my head are beautiful!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,3,"My life for you!",14,0,100,0,0,0,"Saronite Mine Slave"),
(@ENTRY,0,4,"I'm coming, master!",14,0,100,0,0,0,"Saronite Mine Slave");

-- Actual story menu
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=14068;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,14068);

-- Insert option menu
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@GOSSIP,0,0,"Go on, you're free. Get out of here!",1,1,0);

-- Only show gossip if player is on quest Slaves to Saronite
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `ConditionValue1`=@QUEST;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,@QUEST,0,0,0,'',"Only show first gossip if player is on quest Slaves to Saronite");

-- Prisoners of the Grimtotems
UPDATE `gameobject_template` SET `ScriptName`='go_blackhoof_cage'/*,`data2`=30000*/ WHERE `entry`=186287;
UPDATE `quest_template` SET `ReqSpellCast1`=0 WHERE `entry`=11145;
DELETE FROM `creature_text` WHERE `entry`=23720;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(23720,0,0,"Thank you! There's no telling what those brutes would've done to me.",12,0,100,18,0,0,"Theramore Prisoner");

-- Electromental SAI
SET @ENTRY := 21729;
SET @SPELL_LIGHTNING_BOLT := 37273;
SET @SPELL_MAGNETO_COLLECTOR := 37136;
SET @SPELL_ELECTROMENTAL_VISUAL := 37248;
SET @SPELL_SUMMON_ELECTROMENTAL := 37264;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,0,0,0,0,11,@SPELL_ELECTROMENTAL_VISUAL,1,0,0,0,0,1,0,0,0,0,0,0,0,"Electromental - Out Of Combat - Cast Power Converters: Electromental Visual"),
(@ENTRY,0,1,0,0,0,100,0,1000,2000,2400,3800,11,@SPELL_LIGHTNING_BOLT,1,0,0,0,0,2,0,0,0,0,0,0,0,"Electromental - In Combat - Cast Lightning Bolt"),
(@ENTRY,0,2,0,8,0,100,0,@SPELL_MAGNETO_COLLECTOR,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Electromental - on spellhit - increment event phase'),
(@ENTRY,0,3,0,6,1,100,0,0,0,0,0,33,21731,0,0,0,0,0,7,0,0,0,0,0,0,0,'Electromental - on death during phase 1 - give quest credit');

-- Insert spell
DELETE FROM `spell_dbc` WHERE `Id`=@SPELL_SUMMON_ELECTROMENTAL;
INSERT INTO `spell_dbc`(`Id`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectMiscValueB1`,`EffectMiscValueB2`,`EffectMiscValueB3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`EffectSpellClassMaskA1`,`EffectSpellClassMaskA2`,`EffectSpellClassMaskA3`,`EffectSpellClassMaskB1`,`EffectSpellClassMaskB2`,`EffectSpellClassMaskB3`,`EffectSpellClassMaskC1`,`EffectSpellClassMaskC2`,`EffectSpellClassMaskC3`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`SpellFamilyFlags3`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`DmgMultiplier3`,`AreaGroupId`,`SchoolMask`,`Comment`) VALUES
(@SPELL_SUMMON_ELECTROMENTAL,0,0,256,0,0,0,0,0,0,0,0,1,0,0,101,0,0,0,0,26,1,0,-1,0,0,28,0,0,1,0,0,0,0,0,0,0,0,0,0,0,18,38,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,@ENTRY,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,'Power Converters: Summon Electromental');

-- Fix quest 12166: The Liquid Fire Of Elune
SET @SPELL := 46770;
SET @VISUAL := 47972;
SET @ITEM := 36956;
SET @ELK := 26616;
SET @GRIZZLY := 26643;
SET @ELKDUMMY = 27111;
SET @GRIZZLYDUMMY = 27112;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ELK, @GRIZZLY);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ELK,@GRIZZLY) AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `id` IN (2661601,2661602,2661603,2664301,2664302,2664303);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@GRIZZLY,0,0,1,8,0,100,0x01,@SPELL,0,0,0,33,@GRIZZLYDUMMY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rabid Grizzly - On spell hit - Give kill credit for quest 12166'),
(@GRIZZLY,0,1,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Rabid Grizzly - Despawn after 5 seconds'),
(@ELK,0,0,1,8,0,100,0x01,@SPELL,0,0,0,33,@ELKDUMMY,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Blighted Elk - On spell hit - Give kill credit for quest 12166'),
(@ELK,0,1,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Blighted Elk - Despawn after 5 secondes');
 
-- Fix the quest item to allow it to only target the two quest NPCs
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=@ITEM;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,@ITEM,0,24,2,@GRIZZLY,0,0,'','Item Elune Liquid Fire target Rabid Grizzly (dead)'),
(18,0,@ITEM,0,24,2,@ELK,0,0,'','Item Elune Liquid Fire target Blighted Elk (dead)');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=46770;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(46770, 47972, 1, 'Liquid Fire of Elune');

UPDATE `creature_template` SET `baseattacktime`=2000,`unit_flags`=`unit_flags`|0x8040,`equipment_id`=1014 WHERE `entry` IN (35309,35310); -- Argent Lightwielder
UPDATE `creature_template` SET `baseattacktime`=2000,`unit_flags`=`unit_flags`|0x8040,`equipment_id`=279 WHERE `entry` IN (35307,35308); -- Argent Priestess
UPDATE `creature_template` SET `baseattacktime`=1500,`unit_flags`=`unit_flags`|0x140,`equipment_id`=1926 WHERE `entry` IN (35451,35490); -- The Black Knight

UPDATE `creature_model_info` SET `bounding_radius`=0.208,`combat_reach`=1.5,`gender`=1 WHERE `modelid`=29763; -- Argent Lightwielder
UPDATE `creature_model_info` SET `bounding_radius`=0.208,`combat_reach`=1.5,`gender`=1 WHERE `modelid`=29761; -- Argent Priestess
UPDATE `creature_model_info` SET `bounding_radius`=0.766,`combat_reach`=3,`gender`=0 WHERE `modelid`=29837; -- The Black Knight

DELETE FROM `creature_template_addon` WHERE `entry` IN (35309,35307,35451);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(35309,0,0,1,0, NULL), -- Argent Lightwielder
(35307,0,0,1,0, NULL), -- Argent Priestess
(35451,0,0,1,0, NULL); -- The Black Knight

-- Related to last commit:
UPDATE `creature_model_info` SET `bounding_radius`=1.222,`combat_reach`=3,`gender`=0 WHERE `modelid`=23966; -- Rabid Grizzly
UPDATE `creature_model_info` SET `bounding_radius`=0.98,`combat_reach`=0.98,`gender`=0 WHERE `modelid`=23952; -- Blighted Elk
DELETE FROM `creature_template_addon` WHERE `entry` IN (26616,26643);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(26616,0,0,1,0, NULL), -- Blighted Elk
(26643,0,0,1,0, NULL); -- Rabid Grizzly

-- [Q] In the Name of Loken
-- Gavrock SAI
SET @ENTRY := 26420;
SET @QUEST := 12204;
SET @GOSSIP := 9485;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gavrock - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Remove Gossip & Quest Flags"),
(@ENTRY*100,9,2,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Say Text 0"),
(@ENTRY*100,9,3,0,0,0,100,0,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Say Text 1"),
(@ENTRY*100,9,4,0,0,0,100,0,15000,15000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Say Text 2"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gavrock - On Script - Quest Credit"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavrock - On Script - Add Gossip & Quest Flags");

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Ah, yes. Loken is well known to me.",12,0,100,0,0,0,"Gavrock"),
(@ENTRY,1,0,"It is he who commands the sons of iron in their war against us.",12,0,100,0,0,0,"Gavrock"),
(@ENTRY,2,0,"From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!",12,0,100,0,0,0,"Gavrock");

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,@QUEST);

-- Hugh Glass SAI
SET @ENTRY := 26484;
SET @QUEST := 12204;
SET @GOSSIP := 9484;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Hugh Glass - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Remove Gossip & Quest Flags"),
(@ENTRY*100,9,2,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Say Text 0"),
(@ENTRY*100,9,3,0,0,0,100,0,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Say Text 1"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Hugh Glass - On Script - Quest Credit"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hugh Glass - On Script - Add Gossip & Quest Flags");

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(@GOSSIP, 0, 0, 'Calm down, I want to ask you about the Iron Dwarves and Loken.', 1, 1, 0, 0, 0, 0, NULL);

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`TEXT`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"He's out to get me, too! I'd be careful around here if I was you, traveler. You never know which tree he's hiding behind!",12,0,100,0,0,0,"Hugh Glass"),
(@ENTRY,1,0,"That's not something Limpy Joe would ask! But yeah, I know Loken.",12,0,100,0,0,0,"Hugh Glass");

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,@QUEST);

-- [Q] The Dreghood Elder
SET @ENTRY_AYLAAN := 20679;
SET @ENTRY_AKORU := 20678;
SET @ENTRY_MOROD := 20677;

-- Aylaan the Waterwalker - Akoru the Firecaller - Morod the Windstirrer SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY_AKORU,@ENTRY_AYLAAN,@ENTRY_MOROD);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_AKORU,@ENTRY_AYLAAN,@ENTRY_MOROD);
INSERT INTO `smart_scripts`  (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)  VALUES
(@ENTRY_AYLAAN,0,0,0,62,0,100,0,8161,0,0,0,33,@ENTRY_AYLAAN,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aylaan the Waterwalker - On Gossip Select - Quest Credit The Dreghood Elders"),
(@ENTRY_AYLAAN,0,1,0,62,0,100,0,8161,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aylaan the Waterwalker - On gossip option select - Close gossip"),
(@ENTRY_AKORU,0,0,0,62,0,100,0,8163,0,0,0,33,@ENTRY_AKORU,0,0,0,0,0,7,0,0,0,0,0,0,0,"Akoru the Firecaller - On Gossip Select - Quest Credit The Dreghood Elders"),
(@ENTRY_AKORU,0,1,0,62,0,100,0,8163,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Akoru the Firecaller - On gossip option select - Close gossip"),
(@ENTRY_MOROD,0,0,0,62,0,100,0,8162,0,0,0,33,@ENTRY_MOROD,0,0,0,0,0,7,0,0,0,0,0,0,0,"Morod the Windstirrer - On Gossip Select - Quest Credit The Dreghood Elders"),
(@ENTRY_MOROD,0,1,0,62,0,100,0,8162,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Morod the Windstirrer - On gossip option select - Close gossip");

-- Only show first gossip if player is on quest The Dreghood Elders
DELETE FROM `conditions` WHERE `SourceGroup` IN (8161,8163,8162) AND `ConditionValue1` IN (10368);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8161,0,0,9,10368,0,0,0,'',"Only show gossip if player is on quest The Dreghood Elders"),
(15,8163,0,0,9,10368,0,0,0,'',"Only show gossip if player is on quest The Dreghood Elders"),
(15,8162,0,0,9,10368,0,0,0,'',"Only show gossip if player is on quest The Dreghood Elders");

-- [Q] The Warm-Up
-- Kirgaraak SAI
SET @ENTRY := 29352;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;


DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=@ENTRY;
DELETE FROM smart_scripts WHERE source_type=9 AND entryorguid=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,0,0,5,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - At 5% HP - Run Script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,33,30221,0,0,0,0,0,7,0,0,0,0,0,0,0,'Kirgaraak - On Script - Quest Credit'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - On Script - Make Friendly'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - On Script - Evade'),
(@ENTRY*100,9,3,0,0,0,100,0,10000,10000,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kirgaraak - On Script - Reset Faction');

UPDATE `creature_template` SET `exp`=0 WHERE `entry`=24921; -- Cosmetic Trigger - LAB

UPDATE `creature_model_info` SET `bounding_radius`=2,`combat_reach`=7,`gender`=0 WHERE `modelid`=26202; -- Kirgaraak

DELETE FROM `creature_template_addon` WHERE `entry` IN (@ENTRY,29918,24921);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@ENTRY,0,0,1,0, NULL), -- Kirgaraak
(29918,0,0,1,0, NULL), -- Warbear Matriarch
(24921,0,0,1,0, NULL); -- Cosmetic Trigger - LAB

-- Not working correctly. It will work when spells get fixed
-- 1) Can't have more than one 54324 in the same target. 2) That aura gets removed when target enters in combat and it shouldn't
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=24921;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN -104008 AND -103996 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(-103996, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-103997, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-103998, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-103999, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104000, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104001, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104002, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104003, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104004, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104005, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104006, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104007, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak'),
(-104008, 0, 0, 0, 1, 0, 0, 1, 500, 500, 0, 0, 11, 54324, 0, 0, 0, 0, 0, 11, @ENTRY, 60, 0, 0, 0, 0, 0, 'Cosmetic Trigger - LAB (Brunnhildar Village) - Cast Cosmetic Chains at Kirgaraak');

-- Quest:The Armor's Secrets (12980)
DELETE FROM `creature` WHERE `id`=30190;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(6337,30190,571,1,1,0,0,8256.75,-433.488,970.583,4.223697,300,0,0,1,0,0,0,0,0);

-- Anvil and Metel bars
DELETE FROM `gameobject` WHERE `id` IN (192125,192128);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(177,192125,571,1,1,8262.05,-430.288,968.272,0,0,0,-0.861628,0.507539,120,0,1),
(183,192125,571,1,1,8231.716,-451.452576,968.368835,-3.10665226,0,0,0,0,120,0,1),
(181,192128,571,1,1,8281.357,-432.069,970.723,-2.844883,0,0,-0.9890156,0.1478114,120,0,1),
(188,192128,571,1,1,8233.997,-434.379456,970.722961,-2.07693934,0,0,0,0,120,0,1),
(190,192128,571,1,1,8243.935,-429.880981,970.722961,-1.08210289,0,0,0,0,120,0,1),
(194,192128,571,1,1,8246.777,-424.707367,970.722961,-1.16936862,0,0,0,0,120,0,1),
(197,192128,571,1,1,8264.213,-432.40332,975.778564,1.134463,0,0,0,0,120,0,1);

-- Template updates
UPDATE `creature_template` SET `npcflag`=`npcflag`|1,`speed_run`=0.99206 WHERE `entry`=30190; -- Attendant Tock
UPDATE `creature_template` SET `speed_run`=0.99206 WHERE `entry`=30170; -- Mechagnome Attendant

-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (30190,30170);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30190,0,0,1,0,NULL), -- Mechagnome Attendant
(30170,0,7,1,0, NULL); -- Attendant Tock

SET @ENTRY=30190;
UPDATE `creature_template` SET `gossip_menu_id`=9880, `AIName`='SmartAI' WHERE entry=@ENTRY;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9880;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9880,0,0,'I found this strange armor plate. Can you tell me more about it?',1,1,0,0,0,0, '');

DELETE FROM `gossip_menu` WHERE `entry`=9880;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9880,13703);

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,9880,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Start Script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Remove Gossip Flag'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Close Gossip'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,50,192132,77000,0,0,0,0,8,0,0,0,8262.029,-430.0284,974.1605,-2.757613, 'Attendant Tock - Summon Armor'),
(@ENTRY*100,9,3,0,0,0,100,0,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 0'),
(@ENTRY*100,9,4,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 1'),
(@ENTRY*100,9,5,0,0,0,100,0,4000,4000,0,0,69,0,0,0,0,0,0,8,0,0,0,8262.029,-430.0284,976.1391,1.6, 'Attendant Tock - Move'), -- Move
(@ENTRY*100,9,6,0,0,0,100,0,15000,15000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 2'),
(@ENTRY*100,9,7,0,0,0,100,0,6000,6000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 3'),
(@ENTRY*100,9,8,0,0,0,100,0,7000,7000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 4'),
(@ENTRY*100,9,9,0,0,0,100,0,7000,7000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 5'),
(@ENTRY*100,9,10,0,0,0,100,0,6000,6000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 6'),
(@ENTRY*100,9,11,0,0,0,100,0,5000,5000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 7'),
(@ENTRY*100,9,12,0,0,0,100,0,6000,6000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 8'),
(@ENTRY*100,9,13,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,1,0,0,0,8256.75,-433.488,970.583,4.223697, 'Attendant Tock - Move Home'),
(@ENTRY*100,9,14,0,0,0,100,0,6000,6000,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Speach 9'),
(@ENTRY*100,9,15,0,0,0,100,0,0,0,0,0,33,30190,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Attendant Tock - Quest Credit'),
(@ENTRY*100,9,16,0,0,0,100,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Attendant Tock - Add Gossip Flag');

DELETE FROM `creature_text` WHERE `entry`=30190;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(30190,0,0,'Metallic specimen of foreign origin detected.',12,0,100,0,5,0, 'Attendant Tock'),
(30190,1,0,'Beginning analysis...',12,0,100,0,0,0, 'Attendant Tock'),
(30190,2,0,'Specimen identified as an alloy of saronite and iron.',12,0,100,0,0,0, 'Attendant Tock'),
(30190,3,0,'The ore used in this sample originated deep wihin the crust of Azeroth and was recently unearthed.',12,0,100,275,0,0, 'Attendant Tock'),
(30190,4,0,'The saronite in this sample is nearly pure. Ores like this do not occur naturally on the surface of Azeroth.',12,0,100,0,0,0, 'Attendant Tock'),
(30190,5,0,'This ore can only have been created by a powerful, malevolent force. Attempting to access databanks for more information...',12,0,100,1,0,0, 'Attendant Tock'),
(30190,6,0,'Access denied?!',12,0,100,6,0,0, 'Attendant Tock'),
(30190,7,0,'Further information can only be accessed from the archives within Ulduar, by order of Keeper Loken.',12,0,100,1,0,0, 'Attendant Tock'),
(30190,8,0,'But one thing is for certain: this plate''s size, thickness, and bolt holes point to a use as armor for a colossal structure.',12,0,100,1,0,0, 'Attendant Tock'),
(30190,9,0,'Directive completed. Returning TO standby mode.',12,0,100,1,0,0, 'Attendant Tock');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9880;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9880,0,0,9,12980,0,0,0, '', 'The Armor''s Secrets');

-- Quest: No Where to Run (12261)
-- SAI for Destructive Ward
SET @ENTRY :=27430;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - On spawn Start Script'),
(@ENTRY*100,9,0,0,0,0,100,0,2000,2000,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,1,0,0,0,100,0,15000,15000,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,2,0,0,0,100,0,1000,1000,0,0,11,48735,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Powerup'),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Raid Emote'),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,11,48733,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Pulse'),
(@ENTRY*100,9,5,0,0,0,100,0,15000,15000,0,0,11,48718,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Construct'),
(@ENTRY*100,9,6,0,0,0,100,0,15000,15000,0,0,11,48718,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Construct'),
(@ENTRY*100,9,7,0,0,0,100,0,1000,1000,0,0,11,48735,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Powerup'),
(@ENTRY*100,9,8,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Raid Emote'),
(@ENTRY*100,9,9,0,0,0,100,0,0,0,0,0,11,48733,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Pulse'),
(@ENTRY*100,9,10,0,0,0,100,0,25000,25000,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,11,0,0,0,100,0,0,0,0,0,11,48715,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Skeleton'),
(@ENTRY*100,9,12,0,0,0,100,0,0,0,0,0,11,48718,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Summon Smoldering Construct'),
(@ENTRY*100,9,13,0,0,0,100,0,2000,2000,0,0,11,48735,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Powerup'),
(@ENTRY*100,9,14,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Raid Emote'),
(@ENTRY*100,9,15,0,0,0,100,0,0,0,0,0,11,48734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Barrage'),
(@ENTRY*100,9,16,0,0,0,100,0,1000,1000,0,0,11,48734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Barrage'),
(@ENTRY*100,9,17,0,0,0,100,0,1000,1000,0,0,11,48734,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Barrage'),
(@ENTRY*100,9,18,0,0,0,100,0,0,0,0,0,11,52409,0,0,0,0,0,23,0,0,0,0,0,0,0, 'Destructive Ward - Destructive Ward Kill Credit'),
(@ENTRY*100,9,19,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Destructive Ward - Despawn');

DELETE FROM `creature_text` WHERE `entry`=27430;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27430,0,0, 'The Destructive Ward gains in power.',41,0,100,0,0,0, 'Destructive Ward'),
(27430,1,0, 'The Destructive Ward is fully charged!',41,0,100,0,0,0, 'Destructive Ward');

-- Template update
UPDATE `creature_template` SET `exp`=2,`minlevel`=73,`maxlevel`=73,`unit_flags`=`unit_flags`|4|256,`speed_run`=1, RegenHealth=0 WHERE `entry`=27430; -- Destructive Ward

-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=1,`combat_reach`=1,`gender`=2 WHERE `modelid`=25167; -- Destructive Ward
UPDATE `creature_model_info` SET `bounding_radius`=0.945,`combat_reach`=0.945,`gender`=0 WHERE `modelid`=23951; -- Snowfall Elk

-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (27430,26615);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(26615,0,0,1,0, NULL), -- Snowfall Elk
(27430,0,0,1,0, NULL); -- Destructive Ward

-- [Q] Brother Against Brother
-- Lakka SAI
SET @ENTRY := 18956;
SET @QUEST := 10097;
SET @GOSSIP := 7868;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100) AND `source_type` IN (0,9);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lakka - On Gossip Select - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lakka - On Script - Close Gossip"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lakka - On Script - Say Text 0"), -- Target_type_action_invoker because of <name>
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lakka - On Script - Quest Credit"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lakka - On Script - Despawn");

-- NPC talk text insert
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Thank you for freeing me, $N! I'm going to make my way to Shattrath!",12,0,100,0,0,0,"Lakka");

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,@QUEST);

-- Make Fjola drop two items from her loot table
-- 10 Normal
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=34497 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=34497 AND `item`=1;
-- 25 Normal
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35350 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35350 AND `item`=1;
-- 10 Heroic
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35351 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35351 AND `item`=1;
-- 25 Herioc
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35352 AND `item`=2;
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=35352 AND `item`=1;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -58600;

DELETE FROM `creature_text` WHERE `entry` IN (36597,38995,38579,36823,39217);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36597,0,0,'So the Light''s vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?',14,0,0,0,0,17349,'The Lich King - SAY_LK_INTRO_1'),
(36597,1,0,'You''ll learn of that first hand. When my work is complete, you will beg for mercy -- and I will deny you. Your anguished cries will be testament to my unbridled power...',14,0,0,22,0,17350,'The Lich King - SAY_LK_INTRO_2'),
(36597,2,0,'I''ll keep you alive to witness the end, Fordring. I would not want the Light''s greatest champion to miss seeing this wretched world remade in my image.',14,0,0,0,0,17351,'The Lich King - SAY_LK_INTRO_3'),
(36597,3,0,'Come then champions, feed me your rage!',14,0,0,0,0,0,'The Lich King - SAY_LK_AGGRO'),
(36597,4,0,'I will freeze you from within until all that remains is an icy husk!',14,0,0,0,0,17369,'The Lich King - SAY_LK_REMORSELESS_WINTER'),
(36597,5,0,'Watch as the world around you collapses!',14,0,0,0,0,17370,'The Lich King - SAY_LK_QUAKE'),
(36597,6,0,'Val''kyr, your master calls!',14,0,0,0,0,17373,'The Lich King - SAY_LK_SUMMON_VALKYR'),
(36597,7,0,'Frostmourne hungers...',14,0,0,0,0,17366,'The Lich King - SAY_LK_HARVEST_SOUL'),
(36597,8,0,'Argh... Frostmourne, obey me!',14,0,0,0,0,17367,'The Lich King - SAY_LK_FROSTMOURNE_ESCAPE'),
(36597,9,0,'Frostmourne feeds on the soul of your fallen ally!',14,0,0,0,0,17368,'The Lich King - SAY_LK_FROSTMOURNE_KILL'),
(36597,10,0,'Hope wanes!',14,0,0,0,0,17363,'The Lich King - SAY_LK_KILL'),
(36597,10,1,'The end has come!',14,0,0,0,0,17364,'The Lich King - SAY_LK_KILL'),
(36597,11,0,'Face now your tragic end!',14,0,0,0,0,17365,'The Lich King - SAY_LK_BERSERK'),
(36597,12,0,'%s begins to cast Defile!',41,0,0,0,0,0,'The Lich King - EMOTE_DEFILE_WARNING'),
(36597,13,0,'|TInterface\\Icons\\ability_creature_disease_02.blp:16|tYou have been infected by |cFFCF00FFNecrotic Plague!|r',42,0,0,0,0,0,'The Lich King - EMOTE_NECROTIC_PLAGUE_WARNING'),
(36597,14,0,'No questions remain unanswered. No doubts linger. You ARE Azeroth''s greatest champions. You overcame every challenge I laid before you. My mightiest servants have fallen before your relentless onslaught... your unbridled fury...',14,0,0,0,0,17353,'The Lich King - SAY_LK_OUTRO_1'),
(36597,15,0,'Is it truly the righteousness that drives you? I wonder...',14,0,0,0,0,17354,'The Lich King - SAY_LK_OUTRO_2'),
(36597,16,0,'You trained them well, Fordring. You delivered the greatest fighting force this world has ever known... right into my hands -- exactly as I intended. You shall be rewarded for your unwitting sacrifice.',14,0,0,0,0,17355,'The Lich King - SAY_LK_OUTRO_3'),
(36597,17,0,'Watch now as I raise them from the dead to become masters of the Scourge. They will shroud this world in chaos and destruction. Azeroth''s fall will come at their hands -- and you will be the first to die.',14,0,0,0,0,17356,'The Lich King - SAY_LK_OUTRO_4'),
(36597,18,0,'I delight in the irony...',14,0,0,0,0,17357,'The Lich King - SAY_LK_OUTRO_5'),
(36597,19,0,'Impossible...',14,0,0,0,0,17358,'The Lich King - SAY_LK_OUTRO_6'),
(36597,20,0,'Now I stand, the lion before the lambs... and they do not fear.',14,0,0,0,0,17361,'The Lich King - SAY_LK_OUTRO_7'),
(36597,21,0,'They cannot fear.',14,0,0,0,0,17362,'The Lich King - SAY_LK_OUTRO_8'),
(38995,0,0,'We''ll grant you a swift death, Arthas. More than can be said for the thousands you''ve tortured and slain.',14,0,0,0,0,17390,'Highlord Tirion Fordring - SAY_TIRION_INTRO_1'),
(38995,1,0,'So be it. Champions, attack!',14,0,0,0,0,17391,'Highlord Tirion Fordring - SAY_TIRION_INTRO_2'),
(38995,2,0,'LIGHT, GRANT ME ONE FINAL BLESSING. GIVE ME THE STRENGTH... TO SHATTER THESE BONDS!',14,0,0,0,0,17392,'Highlord Tirion Fordring - SAY_TIRION_OUTRO_1'),
(38995,3,0,'No more, Arthas! No more lives will be consumed by your hatred!',14,0,0,0,0,17393,'Highlord Tirion Fordring - SAY_TIRION_OUTRO_2'),
(38579,0,0,'Free at last! It is over, my son. This is the moment of reckoning.',14,0,0,1,0,17397,'Terenas Menethil - SAY_TERENAS_OUTRO_1'),
(38579,1,0,'Rise up, champions of the Light!',14,0,0,0,0,17398,'Terenas Menethil - SAY_TERENAS_OUTRO_2'),
(36823,0,0,'You have come to bring Arthas to justice? To see the Lich King destroyed?',14,0,0,0,0,17394,'Terenas Menethil - SAY_TERENAS_INTRO_1'),
(36823,1,0,'First, you must escape Frostmourne''s hold, or be damned as I am; trapped within this cursed blade for all eternity.',14,0,0,0,0,17395,'Terenas Menethil - SAY_TERENAS_INTRO_2'),
(36823,2,0,'Aid me in destroying these tortured souls! Together we will loosen Frostmourne''s hold and weaken the Lich King from within!',14,0,0,0,0,17396,'Terenas Menethil - SAY_TERENAS_INTRO_3'),
(39217,0,0,'You have come to bring Arthas to justice? To see the Lich King destroyed?',14,0,0,0,0,17394,'Terenas Menethil - SAY_TERENAS_INTRO_1'),
(39217,1,0,'First, you must escape Frostmourne''s hold, or be damned as I am; trapped within this cursed blade for all eternity.',14,0,0,0,0,17395,'Terenas Menethil - SAY_TERENAS_INTRO_2');

-- Text corrections
DELETE FROM `creature_text` WHERE `entry`=36627 AND `groupid` IN (4,9);
DELETE FROM `creature_text` WHERE `entry`=36678 AND `groupid`=9;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36627,4,0,'|TInterface\\Icons\\spell_shadow_unstableaffliction_2.blp:16|t%s begins to cast |cFFFF0000Unstable Ooze Explosion!|r',41,0,0,0,0,0,'Rotface - EMOTE_UNSTABLE_EXPLOSION'),
(36627,9,0,'|TInterface\\Icons\\ability_creature_disease_02.blp:16|tYou have |cFF00FF00Mutated Infection!|r',42,0,0,0,0,0,'Rotface - EMOTE_MUTATED_INFECTION'),
(36678,9,0,'|TInterface\\Icons\\inv_misc_herb_evergreenmoss.blp:16|t%s cast |cFF00FF00Malleable Goo!|r',41,0,0,0,0,0,'Professor Putricide - EMOTE_MALLEABLE_GOO');

UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.71429,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=974,`faction_H`=974,`unit_flags`=768,`dynamicflags`=0,`equipment_id`=2425,`baseattacktime`=1500 WHERE `entry` IN (36597,39166,39167,39168); -- The Lich King
UPDATE `creature_template` SET `exp`=2,`unit_class`=2 WHERE `entry`=38995; -- Highlord Tirion Fordring
UPDATE `creature_template` SET `speed_walk`=1.2,`speed_run`=0.428571,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`dynamicflags`=0 WHERE `entry` IN (36633,39305,39306,39307); -- Ice Sphere
UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.42857,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0 WHERE `entry`=36701; -- Raging Spirit
UPDATE `creature_template` SET `speed_walk`=1.2,`speed_run`=0.428571,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`dynamicflags`=0,`unit_flags`=33554944 WHERE `entry`=38757; -- Defile
UPDATE `creature_template` SET `minlevel`=80,`maxlevel`=80,`exp`=2,`faction_A`=14,`faction_H`=14,`speed_walk`=2,`speed_run`=1.71429,`unit_flags`=33554944,`dynamicflags`=0,`VehicleId`=532,`InhabitType`=1|4 WHERE `entry` IN (36609,39120,39121,39122); -- Val'kyr Shadowguard
UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.71429,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=35,`faction_H`=35,`unit_flags`=33554944,`dynamicflags`=0,`VehicleId`=531,`InhabitType`=1|4,`flags_extra`=0 WHERE `entry`=36598; -- Strangulate Vehicle
UPDATE `creature_template` SET `speed_walk`=1.2,`speed_run`=0.428571,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=33554944,`dynamicflags`=0,`flags_extra`=128 WHERE `entry`=38584; -- Frostmourne Trigger
UPDATE `creature_template` SET `speed_walk`=2.8,`speed_run`=1,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=32832,`dynamicflags`=0,`flags_extra`=256,`InhabitType`=1|4 WHERE `entry` IN (37799,39284,39285,39286); -- Vile Spirit
UPDATE `creature_template` SET `speed_walk`=1,`speed_run`=1,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=1665,`faction_H`=1665,`unit_flags`=32832,`dynamicflags`=0,`flags_extra`=0,`equipment_id`=2475 WHERE `entry` IN (36823,38579,39217); -- Terenas Menethil
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=24648; -- Invisible Stalker (Scale x2)
UPDATE `creature_template` SET `difficulty_entry_1`=39287,`difficulty_entry_2`=39288,`difficulty_entry_3`=39289 WHERE `entry`=39190; -- Wicked Spirit
UPDATE `creature_template` SET `speed_walk`=2.8,`speed_run`=1,`exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`unit_flags`=32832,`dynamicflags`=0,`flags_extra`=256,`InhabitType`=1|4 WHERE `entry` IN (39190,39287,39288,39289); -- Wicked Spirit
UPDATE `creature_template` SET `exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0,`flags_extra`=256 WHERE `entry`=36824; -- Spirit Warden
UPDATE `creature_template` SET `exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0,`flags_extra`=128 WHERE `entry`=39137; -- Shadow Trap
UPDATE `creature_template` SET `exp`=2,`minlevel`=80,`maxlevel`=80,`faction_A`=14,`faction_H`=14,`InhabitType`=1|4,`flags_extra`=`flags_extra`|128 WHERE `entry`=39189; -- Spirit Bomb

-- HACK, Unit::_IsValidAttackTarget returns false because of UNIT_FLAG_OOC_NOT_ATTACKABLE flag
UPDATE `creature_template` SET `unit_flags`=0x02000000 WHERE `entry`=36171;

UPDATE `creature_model_info` SET `combat_reach`=5.5 WHERE `modelid`=30721; -- The Lich King
UPDATE `creature_model_info` SET `gender`=0 WHERE `modelid`=31286; -- Highlord Tirion Fordring

DELETE FROM `creature` WHERE `guid`=202865;
DELETE FROM `creature_addon` WHERE `guid`=150211;
INSERT INTO `creature_addon` (`guid`,`bytes1`,`auras`) VALUES
(150211,1,'72846 73220 73878'); -- The Lich King

DELETE FROM `creature_template_addon` WHERE `entry` IN (39137,36609,39120,39121,39122,36598,37799,39284,39285,39286,39190,39287,39288,39289,36823,38579,39217,39189);
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`auras`) VALUES
(39137,0,'73530'),
(36609,50331648,''), -- Val'kyr Shadowguard
(39120,50331648,''), -- Val'kyr Shadowguard
(39121,50331648,''), -- Val'kyr Shadowguard
(39122,50331648,''), -- Val'kyr Shadowguard
(36598,50331648,''), -- Strangulate Vehicle
(37799,50331648,''), -- Vile Spirit
(39284,50331648,''), -- Vile Spirit
(39285,50331648,''), -- Vile Spirit
(39286,50331648,''), -- Vile Spirit
(39190,50331648,''), -- Wicked Spirit
(39287,50331648,''), -- Wicked Spirit
(39288,50331648,''), -- Wicked Spirit
(39289,50331648,''), -- Wicked Spirit
(36823,0,'72372'), -- Terenas Menethil
(38579,0,'72372'), -- Terenas Menethil
(39217,0,'72372'), -- Terenas Menethil
(39189,0,'73572'); -- Spirit Bomb

UPDATE `gameobject` SET `rotation3`=1,`animprogress`=255,`spawntimesecs`=604800 WHERE `guid` IN (100056,100061,100064);
UPDATE `gameobject` SET `rotation2`=1,`animprogress`=255,`spawntimesecs`=604800 WHERE `guid` IN (100057,100058,100059,100060,100062);
UPDATE `gameobject` SET `rotation3`=1,`animprogress`=255,`spawntimesecs`=-604800 WHERE `guid`=100063;

UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry`=202438; -- Lavaman Pillars (Unchained)
UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry`=202188; -- Doodad_Icecrown_ThroneFrostyWind01
UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry`=202189; -- Doodad_Icecrown_ThroneFrostyEdge01

DELETE FROM `gameobject` WHERE `id`=202438;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`position_x`,`position_y`,`position_z`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(100488,202438,631,15,425.0885,-2123.311,858.6748,1,-604800,255,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (71614,70338,73785,73786,73787,68981,74270,74271,74272,72262,71440,76379,74086,72595,73650,72679,74318,74319,74320,73028,74321,74322,74323,73582,71809,71811,72431,72405,72429,73159);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,71614,0,18,1,38995,0,0, '', 'Ice Lock - target Highlord Tirion Fordring'),
(13,0,70338,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,70338,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,70338,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,73785,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,73785,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,73785,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,73786,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,73786,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,73786,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,73787,0,18,1,0,0,0, '', 'Necrotic Plague - target player'),
(13,0,73787,0,18,1,37698,0,0, '', 'Necrotic Plague - target Shambling Horror'),
(13,0,73787,0,18,1,37695,0,0, '', 'Necrotic Plague - target Drudge Ghoul'),
(13,0,68981,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,68981,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,68981,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,68981,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,74270,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,74270,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,74270,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,74270,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,74271,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,74271,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,74271,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,74271,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,74272,0,18,0,202141,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing02'),
(13,0,74272,0,18,0,202142,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing01'),
(13,0,74272,0,18,0,202143,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing03'),
(13,0,74272,0,18,0,202144,0,0, '', 'Remorseless Winter - target Doodad_IceShard_standing04'),
(13,0,72262,0,18,1,22515,0,0, '', 'Quake - target World Trigger'),
(13,0,71440,0,18,1,36597,0,0, '', 'Harvest Soul - target The Lich King'),
(13,0,76379,0,18,1,36597,0,0, '', 'Harvest Soul - target The Lich King'),
(13,0,74086,0,18,1,0,0,0, '', 'Destroy Soul - target player'),
(13,0,72595,0,18,1,0,0,0, '', 'Restore Soul - target player'),
(13,0,73650,0,18,1,0,0,0, '', 'Restore Soul - target player'),
(13,0,72679,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74318,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74319,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74320,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,73028,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74321,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,73650,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,74323,0,18,1,36597,0,0, '', 'Harvested Soul - target The Lich King'),
(13,0,73582,0,18,1,39190,0,0, '', 'Trigger Vile Spirit (Inside, Heroic) - target Wicked Spirit'),
(13,0,71809,0,18,1,36597,0,0, '', 'Jump - target The Lich King'),
(13,0,71811,0,18,1,36597,0,0, '', 'Jump - target The Lich King'),
(13,0,72431,0,18,1,0,0,0, '', 'Jump - target player'),
(13,0,72405,0,18,1,38995,0,0, '', 'Broken Frostmourne - target Highlord Tirion Fordring'),
(13,0,72429,0,18,1,0,0,0, '', 'Mass Resurrection - target player'),
(13,0,73159,0,18,1,0,0,0, '', 'Play Movie - target player');

DELETE FROM `spell_target_position` WHERE `id` IN (70860,72546,73655);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(70860,631,529.302,-2124.49, 840.857,3.1765), -- Frozen Throne Teleport
(72546,631,514.000,-2523.00,1050.990,3.1765), -- Harvest Soul (normal mode)
(73655,631,495.708,-2523.76,1050.990,3.1765); -- Harvest Soul (heroic mode)

DELETE FROM `spell_area` WHERE `spell`=74276;
INSERT INTO `spell_area` (`spell`,`area`,`autocast`) VALUES
(74276,4910,1); -- In Frostmourne Room

DELETE FROM `disables` WHERE `entry` IN (12825,13246,13247,13244,13245,13342,13309,13362,13311,12823,13163,13164,13243,12764,12909,12826,13103,13136,13137,13138,12818) AND `sourceType`=4;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12825,13246,13247,13244,13245,13342,13309,13362,13311,12823,13163,13164,13243,12764,12909,12826,13103,13136,13137,13138,12818);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(12825,12,2,0,''), -- Bane of the Fallen King
(13246,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (10 player)
(13246,12,0,0,''), -- Been Waiting a Long Time for This (10 player)
(13247,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (10 player) Heroic
(13247,12,2,0,''), -- Been Waiting a Long Time for This (10 player) Heroic
(13244,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (25 player)
(13244,12,1,0,''), -- Been Waiting a Long Time for This (25 player)
(13245,11,0,0,'achievement_been_waiting_long_time'), -- Been Waiting a Long Time for This (25 player) Heroic
(13245,12,3,0,''), -- Been Waiting a Long Time for This (25 player) Heroic
(13342,12,0,0,''), -- Lich King 10-player bosses killed
(13309,12,0,0,''), -- Lich King 10-player raids completed (final boss killed)
(13362,12,1,0,''), -- Lich King 25-player bosses killed
(13311,12,1,0,''), -- Lich King 25-player raids completed (final boss killed)
(12823,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (10 player)
(12823,12,0,0,''), -- Neck-Deep in Vile (10 player)
(13163,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (10 player) Heroic
(13163,12,2,0,''), -- Neck-Deep in Vile (10 player) Heroic
(13164,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (25 player)
(13164,12,1,0,''), -- Neck-Deep in Vile (25 player)
(13243,11,0,0,'achievement_neck_deep_in_vile'), -- Neck-Deep in Vile (25 player) Heroic
(13243,12,3,0,''), -- Neck-Deep in Vile (25 player) Heroic
(12764,12,0,0,''), -- The Frozen Throne (10 player)
(12909,12,1,0,''), -- The Frozen Throne (25 player)
(12826,12,3,0,''), -- The Light of Dawn
(13103,12,0,0,''), -- Victories over the Lich King (Icecrown 10 player)
(13136,12,1,0,''), -- Victories over the Lich King (Icecrown 25 player)
(13137,12,2,0,''), -- Victories over the Lich King (Heroic Icecrown 10 player)
(13138,12,3,0,''), -- Victories over the Lich King (Heroic Icecrown 25 player)
(12818,12,3,0,''); -- Realm First! Fall of the Lich King

UPDATE `creature_template` SET `ScriptName`='boss_the_lich_king' WHERE `entry`=36597;
UPDATE `creature_template` SET `ScriptName`='npc_tirion_fordring_tft' WHERE `entry`=38995;
UPDATE `creature_template` SET `ScriptName`='npc_shambling_horror_icc' WHERE `entry`=37698;
UPDATE `creature_template` SET `ScriptName`='npc_raging_spirit' WHERE `entry`=36701;
UPDATE `creature_template` SET `ScriptName`='npc_valkyr_shadowguard' WHERE `entry`=36609;
UPDATE `creature_template` SET `ScriptName`='npc_strangulate_vehicle' WHERE `entry`=36598;
UPDATE `creature_template` SET `ScriptName`='npc_terenas_menethil' WHERE `entry` IN (36823,38579,39217); -- not difficulty_entries
UPDATE `creature_template` SET `ScriptName`='npc_spirit_warden' WHERE `entry`=36824;
UPDATE `creature_template` SET `ScriptName`='npc_spirit_bomb' WHERE `entry`=39189;
UPDATE `creature_template` SET `ScriptName`='npc_broken_frostmourne' WHERE `entry`=38584;

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_infest';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_necrotic_plague';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_necrotic_plague_jump';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_shadow_trap_visual';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_shadow_trap_periodic';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_quake';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_ice_burst_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_raging_spirit';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_defile';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_summon_into_air';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_soul_reaper';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_valkyr_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_eject_all_passengers';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_cast_back_to_caster';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_life_siphon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirits';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirits_visual';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirit_move_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_vile_spirit_damage_target_search';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_harvest_soul';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_lights_favor';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_soul_rip';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_restore_soul';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_in_frostmourne_room';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_summon_spirit_bomb';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_trigger_vile_spirit';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_jump';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_jump_remove_aura';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_mass_resurrection';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_the_lich_king_play_movie';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70541,'spell_the_lich_king_infest'),
(73779,'spell_the_lich_king_infest'),
(73780,'spell_the_lich_king_infest'),
(73781,'spell_the_lich_king_infest'),
(70337,'spell_the_lich_king_necrotic_plague'),
(73912,'spell_the_lich_king_necrotic_plague'),
(73913,'spell_the_lich_king_necrotic_plague'),
(73914,'spell_the_lich_king_necrotic_plague'),
(70338,'spell_the_lich_king_necrotic_plague_jump'),
(73785,'spell_the_lich_king_necrotic_plague_jump'),
(73786,'spell_the_lich_king_necrotic_plague_jump'),
(73787,'spell_the_lich_king_necrotic_plague_jump'),
(73530,'spell_the_lich_king_shadow_trap_visual'),
(74282,'spell_the_lich_king_shadow_trap_periodic'),
(72262,'spell_the_lich_king_quake'),
(69110,'spell_the_lich_king_ice_burst_target_search'),
(69200,'spell_the_lich_king_raging_spirit'),
(72754,'spell_the_lich_king_defile'),
(73708,'spell_the_lich_king_defile'),
(73709,'spell_the_lich_king_defile'),
(73710,'spell_the_lich_king_defile'),
(69037,'spell_the_lich_king_summon_into_air'),
(70497,'spell_the_lich_king_summon_into_air'),
(73579,'spell_the_lich_king_summon_into_air'),
(74300,'spell_the_lich_king_summon_into_air'),
(69409,'spell_the_lich_king_soul_reaper'),
(73797,'spell_the_lich_king_soul_reaper'),
(73798,'spell_the_lich_king_soul_reaper'),
(73799,'spell_the_lich_king_soul_reaper'),
(69030,'spell_the_lich_king_valkyr_target_search'),
(68576,'spell_the_lich_king_eject_all_passengers'),
(74445,'spell_the_lich_king_cast_back_to_caster'),
(68984,'spell_the_lich_king_cast_back_to_caster'),
(73488,'spell_the_lich_king_life_siphon'),
(73782,'spell_the_lich_king_life_siphon'),
(73783,'spell_the_lich_king_life_siphon'),
(73784,'spell_the_lich_king_life_siphon'),
(70498,'spell_the_lich_king_vile_spirits'),
(70499,'spell_the_lich_king_vile_spirits_visual'),
(70501,'spell_the_lich_king_vile_spirit_move_target_search'),
(70534,'spell_the_lich_king_vile_spirit_damage_target_search'),
(68980,'spell_the_lich_king_harvest_soul'),
(74325,'spell_the_lich_king_harvest_soul'),
(74296,'spell_the_lich_king_harvest_soul'),
(74297,'spell_the_lich_king_harvest_soul'),
(69382,'spell_the_lich_king_lights_favor'),
(69397,'spell_the_lich_king_soul_rip'),
(72595,'spell_the_lich_king_restore_soul'),
(73650,'spell_the_lich_king_restore_soul'),
(74276,'spell_the_lich_king_in_frostmourne_room'),
(74302,'spell_the_lich_king_summon_spirit_bomb'),
(74341,'spell_the_lich_king_summon_spirit_bomb'),
(74342,'spell_the_lich_king_summon_spirit_bomb'),
(74343,'spell_the_lich_king_summon_spirit_bomb'),
(73582,'spell_the_lich_king_trigger_vile_spirit'),
(71811,'spell_the_lich_king_jump'),
(72431,'spell_the_lich_king_jump_remove_aura'),
(72429,'spell_the_lich_king_mass_resurrection'),
(73159,'spell_the_lich_king_play_movie');

/*
Approximate damage of NPCs before armor reduction
75k-90k - The Lich King
25k-30k - Shambling Horror
3.5-5k - Drudge Ghoul
30k-40k - Raging Spirit
10k-12k - Spirit Warden
10k-12k - Terenas Menethil

Multipliers
1.2 = 10H/25N
1.5 = 25H
*/

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=150 WHERE `entry`=36597; -- The Lich King 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=180 WHERE `entry`=39167; -- The Lich King 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=180 WHERE `entry`=39168; -- The Lich King 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=225 WHERE `entry`=39169; -- The Lich King 25H

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=50 WHERE `entry`=37698; -- Shambling Horror 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=60 WHERE `entry`=39299; -- Shambling Horror 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=60 WHERE `entry`=39300; -- Shambling Horror 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=75 WHERE `entry`=39301; -- Shambling Horror 25H

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=7 WHERE `entry`=37695; -- Drudge Ghoul 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=8.4 WHERE `entry`=39309; -- Drudge Ghoul 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=8.4 WHERE `entry`=39310; -- Drudge Ghoul 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=10.5 WHERE `entry`=39311; -- Drudge Ghoul 25H

UPDATE `creature_template` SET `difficulty_entry_1`=39302,`difficulty_entry_2`=39303,`difficulty_entry_3`=39304 WHERE `entry`=36701; -- Raging Spirit
UPDATE `creature_template` SET `speed_walk`=2,`speed_run`=1.42857,`exp`=2,`minlevel`=83,`maxlevel`=83,`faction_A`=14,`faction_H`=14,`dynamicflags`=0 WHERE `entry` IN (39302,39303,39304); -- Raging Spirit
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=60 WHERE `entry`=36701; -- Raging Spirit 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=72 WHERE `entry`=39302; -- Raging Spirit 25N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=72 WHERE `entry`=39303; -- Raging Spirit 10H
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=90 WHERE `entry`=39304; -- Raging Spirit 25H

UPDATE `creature_template` SET `difficulty_entry_1`=39296 WHERE `entry`=36824; -- Spirit Warden
UPDATE `creature_template` SET `minlevel`=83,`maxlevel`=83,`exp`=2,`faction_A`=14,`faction_H`=14,`flags_extra`=256 WHERE `entry`=39296; -- Spirit Warden (1)
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=20 WHERE `entry`=36824; -- Spirit Warden 10N
UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=20 WHERE `entry`=39296; -- Spirit Warden 25N

UPDATE `creature_template` SET `mindmg`=509,`maxdmg`=683,`attackpower`=805,`dmg_multiplier`=20 WHERE `entry`=36823; -- Terenas Menethil

-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105857;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2721.081,`position_y`=-1832.136,`position_z`=4.838899 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2710.015,-1832.177,4.838899,0,0,0,100,0),
(@PATH,2,2700.421,-1833.964,4.838899,0,0,0,100,0),
(@PATH,3,2693.419,-1835.334,4.867931,0,0,0,100,0),
(@PATH,4,2700.177,-1834.009,4.838899,0,0,0,100,0),
(@PATH,5,2710.015,-1832.177,4.838899,0,0,0,100,0),
(@PATH,6,2721.081,-1832.136,4.838899,0,0,0,100,0),
(@PATH,7,2732.511,-1831.47,4.838899,0,0,0,100,0),
(@PATH,8,2737.419,-1830.768,4.838899,0,0,0,100,0),
(@PATH,9,2732.511,-1831.47,4.838899,0,0,0,100,0),
(@PATH,10,2721.081,-1832.136,4.838899,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105821;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2738.191,`position_y`=-1784.905,`position_z`=5.87062 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2734.5,-1775.514,6.962903,0,0,0,100,0),
(@PATH,2,2738.191,-1784.905,5.87062,0,0,0,100,0),
(@PATH,3,2741.883,-1793.762,5.804742,0,0,0,100,0),
(@PATH,4,2746.422,-1807.012,5.22166,0,0,0,100,0),
(@PATH,5,2748.496,-1816.049,5.223536,0,0,0,100,0),
(@PATH,6,2750.136,-1823.419,5.425339,0,0,0,100,0),
(@PATH,7,2748.496,-1816.049,5.223536,0,0,0,100,0),
(@PATH,8,2746.422,-1807.012,5.22166,0,0,0,100,0),
(@PATH,9,2741.883,-1793.762,5.804742,0,0,0,100,0),
(@PATH,10,2738.191,-1784.905,5.87062,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105859;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2753.638,`position_y`=-1895.846,`position_z`=5.03679 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2754.177,-1888.177,5.087607,0,0,0,100,0),
(@PATH,2,2754.56,-1879.827,5.126619,0,0,0,100,0),
(@PATH,3,2754.854,-1867.842,5.131936,0,0,0,100,0),
(@PATH,4,2754.627,-1856.456,5.450566,0,0,0,100,0),
(@PATH,5,2753.946,-1848.716,5.450566,0,0,0,100,0),
(@PATH,6,2751.545,-1837.476,5.39562,0,0,0,100,0),
(@PATH,7,2753.931,-1848.54,5.450566,0,0,0,100,0),
(@PATH,8,2754.627,-1856.456,5.450566,0,0,0,100,0),
(@PATH,9,2754.854,-1867.842,5.131936,0,0,0,100,0),
(@PATH,10,2754.56,-1879.827,5.126619,0,0,0,100,0),
(@PATH,11,2754.177,-1888.177,5.087607,0,0,0,100,0),
(@PATH,12,2753.638,-1895.846,5.03679,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105810;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2805.754,`position_y`=-1824.487,`position_z`=10.76279 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2811.704,-1833.185,11.26279,0,0,0,100,0),
(@PATH,2,2825.015,-1839.888,11.25652,0,0,0,100,0),
(@PATH,3,2811.704,-1833.185,11.26279,0,0,0,100,0),
(@PATH,4,2805.754,-1824.487,10.76279,0,0,0,100,0),
(@PATH,5,2806.472,-1815.43,10.76279,0,0,0,100,0),
(@PATH,6,2806.509,-1806.167,10.63779,0,0,0,100,0),
(@PATH,7,2806.472,-1815.43,10.76279,0,0,0,100,0),
(@PATH,8,2805.754,-1824.487,10.76279,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105750;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2691.886,`position_y`=-1764.669,`position_z`=9.601107 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2681.84,-1768.02,9.601107,0,0,0,100,0),
(@PATH,2,2691.886,-1764.669,9.601107,0,0,0,100,0),
(@PATH,3,2705.537,-1760.065,9.601107,0,0,0,100,0),
(@PATH,4,2714.329,-1758.981,9.601107,0,0,0,100,0),
(@PATH,5,2705.537,-1760.065,9.601107,0,0,0,100,0),
(@PATH,6,2691.886,-1764.669,9.601107,0,0,0,100,0);
-- Pathing for Conquest Hold Berserker Entry: 27500
SET @NPC := 105854;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2683.998,`position_y`=-1873.36,`position_z`=14.20639 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2681.924,-1863.327,14.19665,0,0,0,100,0),
(@PATH,2,2691.357,-1860.246,13.94065,0,0,0,100,0),
(@PATH,3,2705.164,-1860.508,13.85815,0,0,0,100,0),
(@PATH,4,2706.999,-1867.629,13.94356,0,0,0,100,0),
(@PATH,5,2702.301,-1873.661,13.86975,0,0,0,100,0),
(@PATH,6,2690.931,-1875.133,13.94601,0,0,0,100,0),
(@PATH,7,2683.998,-1873.36,14.20639,0,0,0,100,0);

-- Pathing for Westfall Brigade Marine Entry: 27501
SET @NPC := 105933;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2670.551,`position_y`=-2010.984,`position_z`=18.17214 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2673.404,-2006.613,18.2068,0,0,0,100,0),
(@PATH,2,2670.639,-2010.848,18.17313,0,0,0,100,0),
(@PATH,3,2667.047,-2016.413,18.20223,0,0,0,100,0),
(@PATH,4,2670.551,-2010.984,18.17214,0,0,0,100,0);
-- Pathing for Westfall Brigade Marine Entry: 27501
SET @NPC := 105932;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2633.481,`position_y`=-1987.501,`position_z`=8.764043 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2632.814,-1993.635,8.538836,0,0,0,100,0),
(@PATH,2,2638.163,-1998.093,8.282835,0,0,0,100,0),
(@PATH,3,2643.552,-2000.655,8.280496,0,0,0,100,0),
(@PATH,4,2646.837,-1997.753,8.30875,0,0,0,100,0),
(@PATH,5,2649.113,-1994.113,8.310638,0,0,0,100,0),
(@PATH,6,2649.836,-1989.002,8.284628,0,0,0,100,0),
(@PATH,7,2645.433,-1984.703,8.336969,0,0,0,100,0),
(@PATH,8,2638.931,-1981.989,8.592985,0,0,0,100,0),
(@PATH,9,2633.481,-1987.501,8.764043,0,0,0,100,0);

-- Missing spawn for Purkom "Venture Coin Vendor" Horde
DELETE FROM `creature` WHERE `id`=27730;
DELETE FROM `creature` WHERE `guid`=107018 AND `id`=27511;
INSERT INTO creature (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(107018,27730,571,1,1,0,0,2492.467,-1839.655,11.72851,5.532694,120,0,0,1,0,0);

-- Rogue Voidwalkers Shouldn't have weapons
UPDATE `creature_template` SET `equipment_id`=0 WHERE `entry`=16974;

-- Add Missing Spawn
DELETE FROM `creature` WHERE `guid` IN (13425,13426,13427,13428,14241);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
-- Bubb Lazarr
(13425,27628,571,1,1,0,0,2404.771,-1823.437,1.99793,5.078908,300,0,0,1,0,0),
-- Rocket Propelled Warhead
(13426,27593,571,1,1,0,0,2394.92358,-1832.18921,-1.69907868,2.687807,300,0,0,1,0,0),
(13427,27593,571,1,1,0,0,2396.13013,-1829.49475,-1.6780616,2.75762,300,0,0,1,0,0),
(13428,27593,571,1,1,0,0,2397.40283,-1826.75,-1.65229559,2.72271371,300,0,0,1,0,0),
(14241,27593,571,1,1,0,0,2398.62329,-1824.14063,-1.66098964,2.740167,300,0,0,1,0,0);

-- Template updates Rocket Propelled Warhead
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216,`InhabitType`=4,`unit_flags`=`unit_flags`|16384,`speed_walk`=12,`speed_run`=4.28571 WHERE `entry`=27593;

UPDATE `creature_model_info` SET `bounding_radius`=0.534723,`combat_reach`=3.5,`gender`=2 WHERE `modelid`=26611; -- Rocket Propelled Warhead

DELETE FROM `creature_template_addon` WHERE `entry`=27593;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(27593,0,0,1,0, NULL); -- Rocket Propelled Warhead

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=27593;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) VALUES
(27593, 49177, 0, 0, 0, 1, 0, 0, 0); -- Ride Rocket Propelled Warhead

-- Fix requirements for Element 115 from Nayd
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=4 AND `SourceEntry`=37664;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 24095, 37664, 0, 9, 12433, 0, 0, 0, '', 'Element 115 - Seeking Solvent'),
(4, 24095, 37664, 1, 9, 12434, 0, 0, 0, '', 'Element 115 - Always Seeking Solvent'),
(4, 24095, 37664, 2, 9, 12443, 0, 0, 0, '', 'Element 115 - Seeking Solvent'),
(4, 24095, 37664, 3, 9, 12446, 0, 0, 0, '', 'Element 115 - Always Seeking Solvent'),
(4, 24095, 37664, 4, 9, 12437, 0, 0, 0, '', 'Element 115 - Riding the Red Rocket A'),
(4, 24095, 37664, 5, 9, 12432, 0, 0, 0, '', 'Element 115 - Riding the Red Rocket H');
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=100 WHERE `entry`=24095 AND `item`=37664;

-- Add some missing Azure Scalebane Spawns to crystalsong Forest
DELETE FROM `creature` WHERE `guid` IN (6499,6627,7630,10504,12599,12954,13423,13424);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`unit_flags`,`dynamicflags`) VALUES
(6499,31402,571,1,1,0,0,5220.886,591.7798,187.861328,4.866286,180,10,0,1,0,1,0,0),
(6627,31402,571,1,1,0,0,5344.32,595.7,183.07399,4.99164152,180,10,0,1,0,1,0,0),
(7630,31402,571,1,1,0,0,5411.67773,623.1622,178.355133,0.87266463,180,10,0,1,0,1,0,0),
(10504,31402,571,1,1,0,0,5434.40332,783.9654,182.770508,0.5726554,180,10,0,1,0,1,0,0),
(12599,31402,571,1,1,0,0,5464.40771,716.290344,171.820313,2.65290046,180,10,0,1,0,1,0,0),
(12954,31402,571,1,1,0,0,5573.34326,862.8543,161.738586,1.48352981,180,10,0,1,0,1,0,0),
(13423,31402,571,1,1,0,0,5659.52734,987.839844,174.5677,0.314159274,180,0,0,1,0,0,570688256,32),
(13424,31402,571,1,1,0,0,5660.18652,1028.454,174.562653,2.79252672,180,0,0,1,0,0,570688256,32);
-- Addons for dead appearance
DELETE FROM `creature_addon` WHERE `guid` IN (13423,13424);
INSERT INTO `creature_addon` (`guid`,`bytes2`,`auras`) VALUES
(13423,1,29266),
(13424,1,29266);
UPDATE `creature_model_info` SET `bounding_radius`=0.465,`combat_reach`=1.5,`gender`=0 WHERE `modelid`=25195; -- Azure Scalebane
DELETE FROM `creature_template_addon` WHERE `entry`=31402;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(31402,0,0,1,0, NULL); -- Azure Scalebane

DELETE FROM `spell_script_names` WHERE `spell_id`=40121;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (40121,'spell_dru_swift_flight_passive');

DELETE FROM `command` WHERE `name` = 'ticket reset';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('ticket reset', 3, 'Syntax: .ticket reset\nRemoves all closed tickets and resets the counter, if no pending open tickets are existing.');
DELETE FROM `trinity_string` WHERE `entry` IN(2027,2028);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES 
('2027', 'There are pending open tickets, please close them first!'),
('2028', 'All closed tickets were deleted and counter is reseted to |cffff00ff 1|r');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_righteous_defense';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_mana_leech';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(31789,'spell_pal_righteous_defense'),
(34433,'spell_pri_mana_leech');

-- Repair all page_text with HTML format content (Now you can see maps, centered titles and graphics in GO and items with page_texts)
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1>Horde Conscription Registration</H1>\n<BR></BR>\n<P>This person has demonstrated incredible feats of strength and skill in the name of the Horde. They should immediately be assigned to work in the Crossroads.</P>\n<BR></BR>\n<BR></BR>\n<P>Respectfully yours:</P>\n<BR></BR>\n<BR></BR>\n<BR></BR>\n<BR></BR>\n<P>Looks good to me.<BR></BR>\n- Takrin Pathseeker</P>\n</BODY>\n</HTML>' WHERE `entry`=340;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1>Horde Conscription Registration</H1>\n<BR></BR>\n<P>This person has demonstrated incredible feats of strength and skill in the name of the Horde. They should immediately be assigned to work in the Crossroads.</P>\n<BR></BR>\n<BR></BR>\n<P>Respectfully yours:\n<BR></BR>- Kargal Battlescar</P>\n<BR></BR>\n<BR></BR>\n<BR></BR>\n<P>Looks good to me.<BR></BR>\n- Takrin Pathseeker</P>\n</BODY>\n</HTML>' WHERE `entry`=341;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<BR/>\n<H1 align=\"center\">\nEliza\n</H1>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<P align=\"center\">\nBeloved wife, may the earth sate your hunger.\n</P>\n</BODY>\n</HTML>\n' WHERE `entry`=731;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<BR/>\n<H1 align=\"center\">\nEliza\n</H1>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<P align=\"center\">\nBeloved wife, may the earth sate your hunger.\n</P>\n</BODY>\n</HTML>\n' WHERE `entry`=750;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<BR/>\n<P>\nIn memory of my dear mentor, Horatio M. Montgomery, M.D. Healer, Teacher, Friend.\n</P>\n<BR/>\n<H1 align=\"center\">\n50 BTFT - 25 ATFT\n</H1>\n<BR/>\n<P>\n\"The world is full of the sick and weary. It is our job, as healers, NAY, as men and women of medicine, to cleanse them ALL of the ''itis.''\"\n</P>\n<BR/>\n<P>\n- H.M.M., M.D., PhD, JD, Grandmaster Farmer, Dancer Extraordinaire, Friend to the Animals\n</P>\n<BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=1031;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<BR/>\n<P>\nIn memory of my dear mentor, Horatio M. Montgomery, M.D. Healer, Teacher, Friend.\n</P>\n<BR/>\n<H1 align=\"center\">\n50 BTFT - 25 ATFT\n</H1>\n<BR/>\n<P>\n\"The world is full of the sick and weary. It is our job, as healers, NAY, as men and women of medicine, to cleanse them ALL of the ''itis.''\"\n</P>\n<BR/>\n<P>\n- H.M.M., M.D., PhD, JD, Grandmaster Farmer, Dancer Extraordinaire, Friend to the Animals\n</P>\n<BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=1050;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\9330_Gammerita_sepia_256\"/>\n</BODY>\n</HTML>' WHERE `entry`=1171;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\9330_Gammerita_sepia_256\"/>\n</BODY>\n</HTML>' WHERE `entry`=1190;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\Linken_sepia_256px\"/>\n</BODY>\n</HTML>' WHERE `entry`=1371;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\Linken_sepia_256px\"/>\n</BODY>\n</HTML>' WHERE `entry`=1391;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nCRYSTAL PYLON USER''S MANUAL\n</H1>\n<BR/>\n<P align=\"center\">\n\"A guide to collecting and using the power crystals of Un''Goro Crater\"\n</P>\n<BR/>\n<BR/>\n<P align=\"left\">\nChapter 1: The Northern Pylon\n</P>\n<BR/>\n<P align=\"left\">\nChapter 2: The Eastern Pylon\n</P>\n<BR/>\n<P align=\"left\">\nChapter 3: The Western Pylon\n</P>\n<BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=1491;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nCRYSTAL PYLON USER''S MANUAL\n</H1>\n<BR/>\n<P align=\"center\">\n\"A guide to collecting and using the power crystals of Un''Goro Crater\"\n</P>\n<BR/>\n<BR/>\n<P align=\"left\">\nChapter 1: The Northern Pylon\n</P>\n<BR/>\n<P align=\"left\">\nChapter 2: The Eastern Pylon\n</P>\n<BR/>\n<P align=\"left\">\nChapter 3: The Western Pylon\n</P>\n<BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=1510;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nChapter 1: THE NORTHERN PYLON\n</H1>\n<BR/>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_mini_north\" align=\"left\"/>\n<P align=\"right\">\nThe Northern\n<BR/>\nPylon accepts\n<BR/>\nyellow, red,\n<BR/>\nand green\n<BR/>\ncrystals.\n</P>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<P align=\"left\">\nThe Pylon focuses on the energy that can be created using yellow crystals as the main source of power.\n</P>\n</BODY>\n</HTML>\n' WHERE `entry`=1511;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nNorthern Crystal Combinations\n</H1>\n<BR/>\n<P align=\"left\">\nThere are two possible effects: one that will produce damage, and one that will negate damage.\n</P>\n<BR/>\n<P align=\"left\">\nCRYSTAL CHARGE: Requires red and yellow crystals.\n<BR/>\nThis will produce a large explosion.\n</P>\n<BR/>\n<P align=\"left\">\nCRYSTAL RESTORE: Requires yellow and green crystals.\n<BR/>\nThis will provide you with a healing aura.\n</P>\n</BODY>\n</HTML>\n' WHERE `entry`=1512;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nNORTHERN PYLON TABLE DIAGRAM\n</H1>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_north\"/>\n</BODY>\n</HTML>' WHERE `entry`=1513;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nChapter 2: THE EASTERN PYLON\n</H1>\n<BR/>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_mini_east\" align=\"left\"/>\n<P align=\"right\">\nThe Eastern\n<BR/>\nPylon accepts\n<BR/>\nblue, yellow,\n<BR/>\nand green\n<BR/>\ncrystals.\n</P>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<P align=\"left\">\nThe Pylon focuses on the energy that can be created using blue crystals as the main source of power.\n</P>\n</BODY>\n</HTML>\n' WHERE `entry`=1514;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nEastern Crystal Combinations\n</H1>\n<BR/>\n<P align=\"left\">\nThere are two possible effects: one provides bonus to spirit, and one that creates a damaging shield.\n</P>\n<BR/>\n<P align=\"left\">\nCRYSTAL FORCE: Requires blue and green crystals.\n<BR/>\nThis will provide you with an increase in spirit.\n</P>\n<BR/>\n<P align=\"left\">\nCRYSTAL SPIRE: Requires blue and yellow crystals.\n<BR/>\nThis will create a shield that does damage to attackers.\n</P>\n</BODY>\n</HTML>\n' WHERE `entry`=1515;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nEASTERN PYLON TABLE DIAGRAM\n</H1>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_east\"/>\n</BODY>\n</HTML>' WHERE `entry`=1516;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nEASTERN PYLON TABLE DIAGRAM\n</H1>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_east\"/>\n</BODY>\n</HTML>' WHERE `entry`=1530;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nChapter 3: THE WESTERN PYLON\n</H1>\n<BR/>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_mini_west\" align=\"left\"/>\n<P align=\"right\">\nThe Western\n<BR/>\nPylon accepts\n<BR/>\nred, green,\n<BR/>\nand blue\n<BR/>\ncrystals.\n</P>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<P align=\"left\">\nThe Pylon focuses on the energy that can be created using red crystals as the main source of power.\n</P>\n</BODY>\n</HTML>' WHERE `entry`=1531;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nWestern Crystal Combinations\n</H1>\n<BR/>\n<P align=\"left\">\nThere are two possible effects: one that increases your protection from damage, and one that weakens an enemy''s defenses.\n</P>\n<BR/>\n<P align=\"left\">\nCRYSTAL WARD: Requires red and green crystals.\n<BR/>\nThis will provide you with an increase to armor.\n</P>\n<BR/>\n<P align=\"left\">\nCRYSTAL YIELD: Requires blue and red crystals.\n<BR/>\nThis can lower the armor of a specific target.\n</P>\n</BODY>\n</HTML>' WHERE `entry`=1532;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nWESTERN PYLON TABLE DIAGRAM\n</H1>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_west\"/>\n</BODY>\n</HTML>' WHERE `entry`=1533;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nWESTERN PYLON TABLE DIAGRAM\n</H1>\n<BR/>\n<IMG src=\"Interface\\Pictures\\11482_crystals_west\"/>\n</BODY>\n</HTML>' WHERE `entry`=1550;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blackrock_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1635;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blasted_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1636;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_ungoro_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1637;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_nightdragon_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1638;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blackrock_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1639;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_bldbank_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1640;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_ungoro_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1641;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blackrock_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1642;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blasted_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1643;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_ungoro_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1644;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blackrock_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1645;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_bldbank_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1646;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blasted_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1647;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_ungoro_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1648;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_blackrock_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1649;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_bldbank_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1650;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_whipper_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1651;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_ungoro_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1652;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\11733_ungoro_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=1690;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\14679_Tirion_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=2351;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\14679_Tirion_256\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=2370;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">A TREATISE ON MILITARY RANKS</H1><BR/>\n<IMG src=\"Interface\\PvPRankBadges\\PvPRankAlliance\" align=\"left\"/><BR/>\n<P align=\"right\">What follows are</P>\n<P align=\"right\">the military ranks</P>\n<P align=\"right\">of the Alliance,</P>\n<P align=\"right\">proceeded by such</P>\n<P align=\"right\">information as is</P>\n<P align=\"right\">known for the races</P>\n<P align=\"right\">of the Horde.  Each</P>\n<P align=\"right\">is presented in two</P>\n<P align=\"right\">sections, the officers and then the enlisted, with the ranks of each listed in descending order from highest to lowest. Long live the Alliance!</P>\n</BODY>\n</HTML>' WHERE `entry`=2654;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE ALLIANCE</H1><BR/>\n<P align="center">Part 1</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank14" align="left"/><BR/>\n<P align="right">Grand Marshal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank13" align="left"/><BR/>\n<P align="right">Field Marshal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank12" align="left"/><BR/>\n<P align="right">Marshal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank11" align="left"/><BR/>\n<P align="right">Commander</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank10" align="left"/><BR/>\n<P align="right">Lieutenant Commander</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2655;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE ALLIANCE</H1><BR/>\n<P align="center">Part 2</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank09" align="left"/><BR/>\n<P align="right">Knight-Champion</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank08" align="left"/><BR/>\n<P align="right">Knight-Captain</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank07" align="left"/><BR/>\n<P align="right">Knight-Lieutenant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank06" align="left"/><BR/>\n<P align="right">Knight</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2656;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">ENLISTED RANKS OF THE ALLIANCE</H1><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank05" align="left"/><BR/>\n<P align="right">Sergeant Major</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank04" align="left"/><BR/>\n<P align="right">Master Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank03" align="left"/><BR/>\n<P align="right">Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank02" align="left"/><BR/>\n<P align="right">Corporal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank01" align="left"/><BR/>\n<P align="right">Private</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2657;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE HORDE</H1><BR/>\n<P align="center">Part 1</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank14" align="left"/><BR/>\n<P align="right">High Warlord</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank13" align="left"/><BR/>\n<P align="right">Warlord</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank12" align="left"/><BR/>\n<P align="right">General</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank11" align="left"/><BR/>\n<P align="right">Lieutenant General</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank10" align="left"/><BR/>\n<P align="right">Champion</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2658;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">ENLISTED RANKS OF THE HORDE</H1><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank05" align="left"/><BR/>\n<P align="right">First Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank04" align="left"/><BR/>\n<P align="right">Senior Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank03" align="left"/><BR/>\n<P align="right">Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank02" align="left"/><BR/>\n<P align="right">Grunt</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank01" align="left"/><BR/>\n<P align="right">Scout</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2660;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">MILITARY RANKS OF THE HORDE &amp; ALLIANCE</H1>\n<BR/>\n<BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRankHorde" align="left"/>\n<BR/>\n<P align="right">Throm''ka!  In this</P>\n<P align="right">book you will find</P>\n<P align="right">many listings of</P>\n<P align="right">the military ranks</P>\n<P align="right">of the Horde and</P>\n<P align="right">the puny Alliance.</P>\n<P align="right">First will come the</P>\n<P align="right">Horde, then the Alliance,</P>\n<P align="right">each with listings of officers and enlisted ranks.  As is fitting, the strongest are listed at the top, with the weaker listed below them.</P>\n</BODY>\n</HTML>' WHERE `entry`=2661;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE HORDE</H1><BR/>\n<P align="center">Part 1</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank14" align="left"/><BR/>\n<P align="right">High Warlord</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank13" align="left"/><BR/>\n<P align="right">Warlord</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank12" align="left"/><BR/>\n<P align="right">General</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank11" align="left"/><BR/>\n<P align="right">Lieutenant General</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank10" align="left"/><BR/>\n<P align="right">Champion</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2662;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE HORDE</H1><BR/>\n<P align="center">Part 2</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank09" align="left"/><BR/>\n<P align="right">Centurion</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank08" align="left"/><BR/>\n<P align="right">Legionnaire</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank07" align="left"/><BR/>\n<P align="right">Blood Guard</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank06" align="left"/><BR/>\n<P align="right">Stone Guard</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2663;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">HORDE ENLISTED RANKS</H1><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank05" align="left"/><BR/>\n<P align="right">First Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank04" align="left"/><BR/>\n<P align="right">Senior Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank03" align="left"/><BR/>\n<P align="right">Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank02" align="left"/><BR/>\n<P align="right">Grunt</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank01" align="left"/><BR/>\n<P align="right">Scout</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2664;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE ALLIANCE</H1><BR/>\n<P align="center">Part 1</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank14" align="left"/><BR/>\n<P align="right">Grand Marshal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank13" align="left"/><BR/>\n<P align="right">Field Marshal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank12" align="left"/><BR/>\n<P align="right">Marshal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank11" align="left"/><BR/>\n<P align="right">Commander</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank10" align="left"/><BR/>\n<P align="right">Lieutenant Commander</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2665;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">ALLIANCE MILITARY RANKS</H1><BR/>\n<P align=\"center\">OFFICERS</P><BR/>\n<P align=\"center\">Grand Marshal</P>\n<P align=\"center\">Field Marshal</P>\n<P align=\"center\">Marshal</P>\n<P align=\"center\">Commander</P>\n<P align=\"center\">Lieutenant Commander</P>\n<P align=\"center\">Knight-Champion</P>\n<P align=\"center\">Knight-Captain</P>\n<P align=\"center\">Knight-Lieutenant</P>\n<P align=\"center\">Knight</P><BR/>\n<P align=\"center\">ENLISTED</P><BR/>\n<P align=\"center\">Sergeant Major</P>\n<P align=\"center\">Master Sergeant</P>\n<P align=\"center\">Sergeant</P>\n<P align=\"center\">Corporal</P>\n<P align=\"center\">Private</P><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2676;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">HORDE MILITARY RANKS</H1><BR/>\n<P align=\"center\">OFFICERS</P><BR/>\n<P align=\"center\">High Warlord</P>\n<P align=\"center\">Warlord</P>\n<P align=\"center\">General</P>\n<P align=\"center\">Lieutenant General</P>\n<P align=\"center\">Champion</P>\n<P align=\"center\">Centurion</P>\n<P align=\"center\">Legionnaire</P>\n<P align=\"center\">Blood Guard</P>\n<P align=\"center\">Stone Guard</P><BR/>\n<P align=\"center\">ENLISTED</P><BR/>\n<P align=\"center\">First Sergeant</P>\n<P align=\"center\">Senior Sergeant</P>\n<P align=\"center\">Sergeant</P>\n<P align=\"center\">Grunt</P>\n<P align=\"center\">Scout</P><BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=2677;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<BR/>\n<P align=\"left\">Here lies Durotan - first Chieftain of the Frostwolf Clan, and father of our honored Warchief, Thrall.  He was the bravest of our kind - betrayed by those who would see our people enslaved. Durotan gave his life that our freedom might be gained. We honor him - and the legacy he passed on to us through his son.</P><BR/>\n<P align=\"left\">Drek''Thar, Far Seer of the Frostwolves </P>\n</BODY>\n</HTML>' WHERE `entry`=2731;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">HORDE MILITARY RANKS</H1><BR/>\n<P align=\"center\">OFFICERS</P><BR/>\n<P align=\"center\">High Warlord</P>\n<P align=\"center\">Warlord</P>\n<P align=\"center\">General</P>\n<P align=\"center\">Lieutenant General</P>\n<P align=\"center\">Champion</P>\n<P align=\"center\">Centurion</P>\n<P align=\"center\">Legionnaire</P>\n<P align=\"center\">Blood Guard</P>\n<P align=\"center\">Stone Guard</P><BR/>\n<P align=\"center\">ENLISTED</P><BR/>\n<P align=\"center\">First Sergeant</P>\n<P align=\"center\">Senior Sergeant</P>\n<P align=\"center\">Sergeant</P>\n<P align=\"center\">Grunt</P>\n<P align=\"center\">Scout</P><BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=2770;
UPDATE `page_text` SET `text`='You cannot understand a single word on this ledger. You don''t even know what language it is written in!' WHERE `entry`=2822;
UPDATE `page_text` SET `text`='<HTML>\r\n<BODY>\r\n<IMG src=\"Interface\\Pictures\\21037_crudemap_256\"/>\r\n</BODY>\r\n</HTML>\r\n' WHERE `entry`=2828;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE HORDE</H1><BR/>\n<P align="center">Part 2</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank09" align="left"/><BR/>\n<P align="right">Centurion</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank08" align="left"/><BR/>\n<P align="right">Legionnaire</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank07" align="left"/><BR/>\n<P align="right">Blood Guard</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank06" align="left"/><BR/>\n<P align="right">Stone Guard</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2854;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">ENLISTED RANKS OF THE HORDE</H1><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank05" align="left"/><BR/>\n<P align="right">First Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank04" align="left"/><BR/>\n<P align="right">Senior Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank03" align="left"/><BR/>\n<P align="right">Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank02" align="left"/><BR/>\n<P align="right">Grunt</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank01" align="left"/><BR/>\n<P align="right">Scout</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2855;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">OFFICER RANKS OF THE ALLIANCE</H1><BR/>\n<P align="center">Part 2</P>\n<IMG src="Interface\\PvPRankBadges\\PvPRank09" align="left"/><BR/>\n<P align="right">Knight-Champion</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank08" align="left"/><BR/>\n<P align="right">Knight-Captain</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank07" align="left"/><BR/>\n<P align="right">Knight-Lieutenant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank06" align="left"/><BR/>\n<P align="right">Knight</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2856;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align="center">ALLIANCE ENLISTED RANKS</H1><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank05" align="left"/><BR/>\n<P align="right">Sergeant Major</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank04" align="left"/><BR/>\n<P align="right">Master Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank03" align="left"/><BR/>\n<P align="right">Sergeant</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank02" align="left"/><BR/>\n<P align="right">Corporal</P><BR/><BR/>\n<IMG src="Interface\\PvPRankBadges\\PvPRank01" align="left"/><BR/>\n<P align="right">Private</P><BR/><BR/>\n</BODY>\n</HTML>' WHERE `entry`=2857;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">\nAnthony Ray Stark\n</H1>\n<H2 align=\"center\">\n1961 - 2005\n</H2>\n</BODY>\n</HTML>' WHERE `entry`=2858;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">BRAZIER OF INVOCATION: USER''S MANUAL</H1><BR/><P align=\"center\">Where to find Haunted Loci</P><BR/><P align=\"center\">INTRODUCTION</P><BR/><P align=\"left\">Contained within these pages are the locations of the fallen and corrupted spirits and souls involved in the Lord Valthalak''s Amulet Incident. Though you have already saved these former companions of mine, it would be my conjecture that repugnant echoes of the evil that once twisted their spirits still linger at those haunted loci. Such was the malevolent power of Lord Valthalak''s spirit.</P><BR/><P align=\"left\">Additionally, the brazier can be used to summon forth Lord Valathalak, though as before, extreme caution should be taken in doing so.</P><BR/></BODY></HTML>' WHERE `entry`=2859;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">INTRODUCTION, continued...</H1><BR/><P align=\"left\">The brazier itself functions just as the Brazier of Beckoning did. Simply place it within range of any of the five haunted loci and it will invoke the spirits of the dead.</P><BR/><P align=\"left\">As a side note, because I know that you''ll be interested in knowing, the Banner of Provocation can be used in similar fashion at the arena in Blackrock Depths. Be sure to teach Theldren and his goons a lesson for me every time you get a chance when you''re there.</P><BR/><P align=\"left\">Read on should you desire further enlightment.</P><BR/></BODY></HTML>' WHERE `entry`=2860;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">ISALIEN</H1><BR/><P align=\"center\">Night Elven Priestess of the Moon</P><BR/><P align=\"left\">When Isalien decided to take her leave of the company, she did so with the intention of making a pilgrimage to Dire Maul, the fallen, ancestral night elven city once known as Eldre''Thalas. Therein still stands a library of great knowledge, a sanctum that a small number of night elves have been able to hold back the tide from. She was intent upon finding answers both to her heritage and possibly concerning the amulet pieces. It should be noted that she was also a good friend of Falrin Treeshaper.</P><BR/></BODY></HTML>' WHERE `entry`=2861;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">ISALIEN, continued...</H1><BR/><P align=\"left\">Unfortunately, as she and her companion hippogryph, Empyrean, were entering the city, they were assailed by Alzzin the Wildshaper and his minions. There she fell, never to rise again. Perhaps it is for the best that Isalien never unlocked any further secrets from the evil magic that Lord Valthalak put into containing a portion of his essence in the amulet.</P><BR/><P align=\"left\">The open-aired chamber where Alzzin resides is one of these haunted loci.</P><BR/></BODY></HTML>' WHERE `entry`=2862;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">MOR GRAYHOOF</H1><BR/><P align=\"center\">Tauren Druid and First to Fall</P><BR/><P align=\"left\">Mor Grayhoof was ever a stalwart and trusted companion within The Veiled Blade. It is unfortunate that he was the first to fall to Lord Valthalak''s evil minions.</P><BR/><P align=\"left\">As we fled from Valthalak, we were being pursued by a veritable army of his spectral assassins and stalkers. The flight from Blackrock Spire was chaotic, to say the least. Unfortunately along the way, Mor somehow lost his footing, though I suspect that he was pushed. In any case, he fell down in to the recesses of the lower portion of the spire.</P><BR/></BODY></HTML>' WHERE `entry`=2863;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">MOR GRAYHOOF, continued...</H1><BR/><P align=\"left\">Later, we discovered that Mor had actually survived the fall. But there was to be no happy ending for my good friend; he was taken prisoner by the trolls of Tazz''Alaor. Not long after, as he was being tortured by War Master Voone, a group of Valthalak''s assassins jumped in and finished the job.</P><BR/><P align=\"left\">Should you seek to raise the echo of Mor Grayhoof''s spirit, War Master Voone''s chamber is a haunted location.</P><BR/></BODY></HTML>' WHERE `entry`=2864;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">JARIEN AND SOTHOS</H1><BR/><P align=\"center\">Siblings and would-be members of the Scarlet Crusade</P><BR/><P align=\"left\">Jarien and Sothos were two of the most intolerant people that I knew. Yet their skills as combatants were exceptional, and they came from money, which I suppose is why Anthion, the leader of The Veiled Blade, kept them on.</P><BR/><P align=\"left\">The siblings eventually found themselves enamored with the teachings and philosophy of the Scarlet Crusade. They had always exhibited a certain zeal in vanquishing any of the Scourge that we ran across in our travels, and it was suspected that their family had ties to the organization.</P><BR/></BODY></HTML>' WHERE `entry`=2865;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">JARIEN AND SOTHOS, continued...</H1><BR/><P align=\"left\">So it was that they found themselves facing the trials that are required of those that seek to join the Crusade. Of particular interest to them was a position of knighthood within the ranks; something that required more difficult testing apparently. For it was later discovered that Sothos actually failed his final test. Jarien would not have it though, and in open defiance she insisted that he be able to join her amongst the knights. From what we have gathered, Grand Crusader Dathrohan slew them both right on the spot in the middle of his chambers.</P><BR/><P align=\"left\">Thus it is that another of these haunted loci is The Crimson Throne inside The Scarlet Bastion at Stratholme.</P><BR/></BODY></HTML>' WHERE `entry`=2866;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">KORMOK</H1><BR/><P align=\"center\">Two-Headed Ogre Necromancer</P><BR/><P align=\"left\">What can be said about Kormok? He was a two-headed ogre of the caster variety who didn''t used to be all that bad. When we first took him into the fold it was as a prisoner on some job we''d accepted in Burning Steppes. He proved himself invaluable in helping us to get out of a sticky situation we fell into there, however, and so he came on as one of the company''s premier mages.</P><BR/><P align=\"left\">The odd thing about him though was the completely different nature of his two heads. One was always cheerful if not a little foolish, while the other was sly, calculating and had an almost dead look to its eyes. Kind of creepy really.</P><BR/></BODY></HTML>' WHERE `entry`=2867;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">KORMOK, continued...</H1><BR/><P align=\"left\">Later, through the course of our travels, Kormok became exposed to the necromantic side of magic. Unfortunately the creepy head exhibited an affinity for raising dead spirits, and took a perverse pleasure in it, especially in summoning forth the exiled spirits of Purgation Isle to do his bidding.</P><BR/><P align=\"left\">After the company disbanded, Kormok enrolled at the Scholomance to further his ''education''. The spectral assassins found entrance to the school all too easy, and slew him right there in front of his new master, Ras Frostwhisper.</P><BR/><P align=\"left\">This makes Ras Frostwhisper''s chamber one of the haunted locations where the brazier can be successfully utilized.</P><BR/></BODY></HTML>' WHERE `entry`=2868;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">LORD VALTHALAK</H1><BR/><P align=\"center\">Draconid Noble and former General of Blackrock Spire</P><BR/><P align=\"left\">Before General Drakkisath, there was Lord Valthalak, a draconid warlock of immense power. It is common for the leadership of the Spire to change hands, and unfortunately for us, we were going to play a part in the latest shift in power.</P><BR/><P align=\"left\">We''d been commissioned by a goblin smuggler-wizard out of Booty Bay, Gremnik Rizzlesprang, to steal Valthalak''s spellbook. We don''t know if he wanted to study it or sell it (or both), and it doesn''t matter now. What does matter is that we infiltrated the upper reaches of Blackrock Spire and slew Lord Valthalak in his lair. That''s when the fun really began.</P><BR/></BODY></HTML>' WHERE `entry`=2869;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">LORD VALTHALAK, continued...</H1><BR/><P align=\"left\">We had no idea of the depths of Valthalak''s magical knowledge where soul-manipulation was concerned, or we probably would never have taken on the job in the first place. But take it we did, and it proved to be the last job we ever would take.</P><BR/><P align=\"left\">Having slain Lord Valthalak, and taken his spellbook, Kormok must have sensed something about his amulet. He insisted on taking it as his share of the loot, which quickly devolved into a heated argument, and almost a fight, over the thing. We didn''t know at the time that the amulet actually housed a good portion of Valthalak''s spirit; we found that out later, much to our displeasure.</P><BR/></BODY></HTML>' WHERE `entry`=2870;
UPDATE `page_text` SET `text`='<HTML><BODY><H1 align=\"center\">LORD VALTHALAK, continued...</H1><BR/><P align=\"left\">Splitting the amulet into pieces, we fled from the newly risen ghost of Valthalak, as well his army of spectral assassins. And the noise we made fighting over the amulet had roused a number of the Spire''s remaining defenders!</P><BR/><P align=\"left\">Almost all of us made it out of Blackrock and thought we were safe. But, even from the beyond, Valthalak sent his minions at us no matter where we hid. The Veiled Blade soon broke apart after that mission, and then we were really easy pickings.</P><BR/><P align=\"left\">As you must know, this makes Lord Valthalak''s abode, what is now The Beast''s chamber in Blackrock Spire, the last of the haunted locations.</P><BR/></BODY></HTML>' WHERE `entry`=2871;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<IMG src=\"Interface\\Pictures\\24475_gordawg_256\"/>\n</BODY>\n</HTML>' WHERE `entry`=2944;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<BR/>\n<H1 align=\"center\">\nTHE GREEN HILLS OF STRANGLETHORN\n</H1>\n<BR/>\n<H3 align=\"center\">\nby Hemet Nesingwary\n</H3>\n</BODY>\n</HTML>' WHERE `entry`=2945;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<H1 align=\"center\">\nLAMENT OF THE HIGHBORNE\n</H1>\n<BR/>\n<IMG src=\"Interface\\FlavorImages\\BloodElfLogo-small\"/>\n</BODY>\n</HTML>' WHERE `entry`=2990;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>Loosely translated version...</P>\n<BR/>\n<P>By the light, by the light of the sun,</P>\n<P>Children of the blood,</P>\n<P>Our enemies are breaking through.</P>\n<P>Children of the blood,</P>\n<P>By the light,</P>\n<P>Failing children of the blood,</P>\n<P>They are breaking through.</P>\n<P>O children of the blood,</P>\n<P>By the light of the sun.</P>\n<P>Failing children of the blood,</P>\n<P>They are breaking through.</P>\n<P>O children of the blood,</P>\n<P>By the light of the sun,</P>\n<P>The sun.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=2991;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>Thalassian version...</P>\n<BR/>\n<P>Anar''alah, anar''alah belore,</P>\n<P>Sin''dorei,</P>\n<P>Shindu fallah na.</P>\n<P>Sin''dorei,</P>\n<P>Anar''alah,</P>\n<P>Shindu sin''dorei,</P>\n<P>Shindu fallah na.</P>\n<P>Sin''dorei,</P>\n<P>Anar''alah belore.</P>\n<P>Shindu sin''dorei,</P>\n<P>Shindu fallah na.</P>\n<P>Sin''dorei,</P>\n<P>Anar''alah belore,</P>\n<P>Belore.</P>\n</BODY>\n</HTML>' WHERE `entry`=2992;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>Okay, $N, this is a list of all the stuff that I''m going to need for our new super-secret, er..., super weapon. For now, let''s just call it \"Crafty''s Ultra-Advanced Proto-Typical Shortening Blaster\".</P>\n<BR/>\n<P>Trust me, it''s going to be far more revolutionary than that old, hokey world enlarger!</P>\n<BR/>\n<P>Anyway, don''t think too hard about it right now. Just get me this stuff and we''ll be golden!</P>\n</BODY>\n</HTML>' WHERE `entry`=3040;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<H1 align=\"center\">My Tools</H1>\n<BR/>\n<P>First things first... I need my tools. For a project this intricate no others will do!</P>\n<BR/>\n<P>When we had to run for our lives to escape from the pumping station -- that''s a whole different story -- I didn''t have time to pick them up. I mean, come on, I was running for my life! But I do remember that I left them under the pumping station to the east.</P>\n</BODY>\n</HTML>' WHERE `entry`=3041;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<H1 align=\"center\">An Overcharged Capacitor</H1>\n<BR/>\n<P>Any engineering hack worth their salt should be able to whip one of these up for you if you can''t create it yourself. Hell, I''d make one for you, but I''m missing my tools at the moment, remember?</P>\n<BR/>\n<P>So, do whatever it takes, but get me one. The project''s going nowhere without it. If you have to, head back to the southern continents and scour the auction house!</P>\n</BODY>\n</HTML>' WHERE `entry`=3042;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<H1 align=\"center\">A Handful of Rocknar''s Grit</H1>\n<BR/>\n<P>This last bit might be a little tricky to get, but it''s necessary to fashion the blaster''s lens from only the finest sand. That means obtaining it from a top-notch elemental.</P>\n<BR/>\n<P>Rocknar will do nicely. He was spotted to the southeast in the Frozen Reach between Unu''pe and the Wailing Ziggurat. Go break down his icy exterior to get to his rocky core and bring me back a handful.</P>\n</BODY>\n</HTML>' WHERE `entry`=3043;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">WANTED: HEMET NESINGWARY</H1>\n<H1 align=\"center\">FOR CRIMES AGAINST NATURE!</H1>\n<BR/>\n<IMG src=\"Interface\\Pictures\\obj_nesingwary_256\" align=\"center\"/>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<BR/>\n<H1 align=\"center\">Artist''s rendition of \"The Extinctionator\" in his natural habitat: the burning hellfire of the underworld.</H1>\n<BR/>\n<H1 align=\"left\">Last Wildlife Holocaust Location: Nagrand, Outland</H1>\n<BR/>\n<H1 align=\"left\">Also Known As: The Great Game Hunter, The Butcher of Badlands, The Stranglethorn Ripper, Old Man Death, Hemet, Nessie, Ol'' Dirty, Ol'' Dirty D, Father of the Bounty, The Extinctionator</H1>\n<BR/>\n</BODY>\n</HTML>\n' WHERE `entry`=3057;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<H1 align=\"center\">The Diary of High General Abbendis</H1>\n<BR/>\n<IMG src=\"Interface\\FlavorImages\\ScarletCrusadeLogo\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=3092;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>The voice whispered, \"Come to me.\" From the very beginning I knew that it was the Holy Light speaking to me in dreams. At last! After all of my years of prayers and good deeds, the cleansing of the blight of the unliving from the face of Azeroth. After all of the failures and resurrections.</P>\n<BR/>\n<P>Finally!</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3093;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>It happened again. \"Come to me...\", the Light commanded.</P>\n<BR/>\n<P>I woke up freezing, but it wasn''t cold in my chambers. I''m going to redouble my efforts! I''ll tell the high abbot tomorrow that I want prayers increased. No more half-measures!</P>\n<BR/>\n<P>The Holy Light has taken notice of our good work. I can feel it!</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3094;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>This time I was awake! It was very vivid, and yet for over a minute, in the middle of the warm, sunny day, my breath came out misted and chill. One of the priests noticed and dropped to his knees in prayer.</P>\n<BR/>\n<P>No one else heard the voice, though. At least the witness proves that I''m not going insane. Maybe I should ask Landgren to pray on the matter?</P>\n<BR/>\n<P>I''ll get Jordan and Street to scrutinize their recruiting efforts tomorrow. We''ve grown bloated with ranks of unbelievers who yearn only to destroy the undead. That''s not enough!</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3095;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>The commander and the bishop were both receptive. Not that they had any choice. Bishop Street in particular seemed very enthusiastic. He spoke of a revival for the crusade and swore to ferret out the weak of faith within our ranks.</P>\n<BR/>\n<P>I told him to go easy. I''ve no intention of destroying the Crusade. However, I do like the sound of forming an elite cadre of the most faithful to do the Light''s bidding in Northrend. I fear the man''s friendship with LeCraft is slowly twisting him. They both have their uses, though.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3096;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>I will leave most of the Crusade here to continue mopping-up operations on the undead in our backyard. I imagine that once they have finished what we began, most will disband and go back to their homes to live in peace.</P>\n<BR/>\n<P>That somehow seems right. At our finest, we have always been the salt of the earth, rising up to take back our homes from the filth of the Scourge corruption, to return our Lordaeron to its former glory. To a time before the Scourge, before Arthas and regicide... before the Lich King.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3097;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>There have been whispers amongst the men about a day soon to come that will change everything for the Scarlet Crusade. Bishop Street has put a name to it, calling it the Crimson Dawn.</P>\n<BR/>\n<P>I will put some thought to this, though I can feel the truth of it in my bones. I pray that it will bring weal for us rather than woe.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3098;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>The Light has spoken again with a great deal of urgency. I came away from the dream with a sense of impatience. I will not disappoint. There must be no more delays. We must soon be underway!</P>\n<BR/>\n<P>What a great coincidence then - and I had to control myself from showing my relief - this afternoon Captain Shely procured for us a number of new ships for the voyage. Perhaps it was no coincidence at all? The Holy Light expresses its will in ways that we are not meant to understand.</P>\n<BR/>\n<P>I will take the Sinner''s Folly as my flag. I think the name is most fitting.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3099;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Now I know why the Light has been pushing me to be underway. In the dead of night a Scourge necropolis appeared in the sky over us and out poured the minions of hell!</P>\n<BR/>\n<P>A new breed of death knight leads the assault. Already the casualties we''ve suffered have been catastrophic. With the Scourge able to strike at us anywhere and at will from above, there seems no way to mount a proper defense.</P>\n<BR/>\n<P>I fear that our intended expedition to Northrend is over before it has begun.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3100;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>I''ve been informed that Hearthglen and the surrounding area have already begun to assemble a host. High Commander Galvar Pureblood himself intends to lead them to save us. His efforts will be for naught.</P>\n<BR/>\n<P>I must see to it that my best couriers get through the enemy lines and warn him off. Hearthglen must prepare to dig in and rally the rest of the Crusade.</P>\n<BR/>\n<P>With any luck they''ll get through before nightfall.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3101;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<H1 align=\"center\">The Path of Redemption</H1>\n<BR/>\n<IMG src=\"Interface\\FlavorImages\\ScarletCrusadeLogo\"/>\n</BODY>\n</HTML>\n' WHERE `entry`=3121;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>The voice whispered, \"Come to me.\" From the very beginning I knew that it was the Holy Light speaking to me in dreams. At last! After all of my years of prayers and good deeds, the cleansing of the blight of the unliving from the face of Azeroth. After all of the failures and resurrections.</P>\n<BR/>\n<P>Finally!</P>\n</BODY>\n</HTML>' WHERE `entry`=3122;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>It happened again. \"Come to me...\", the Light commanded.</P>\n<BR/>\n<P>This time I woke up freezing, but it wasn''t cold in my chambers. I''m going to redouble my efforts! I''ll tell the high abbot tomorrow that I want prayers increased. No more half-measures!</P>\n<BR/>\n<P>The Holy Light has taken notice of our good work. I can feel it!</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3123;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>This time I was awake! It was very vivid, and yet for over a minute, in the middle of the warm, sunny day, my breath came out misted and chill. One of the priests noticed and dropped to his knees in prayer.</P>\n<BR/>\n<P>No one else heard the voice, though. At least the witness proves that I''m not going insane. Maybe I should ask Landgren to pray on the matter?</P>\n<BR/>\n<P>I''ll get Jordan and Street to scrutinize their recruiting efforts tomorrow. We''ve grown bloated with ranks of unbelievers who yearn only to destroy the undead. That''s not enough!</P>\n<BR/>\n</BODY>\n</HTML>\n\n\n\n' WHERE `entry`=3124;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>The commander and the bishop were both receptive. Not that they had any choice. Bishop Street in particular seemed very enthusiastic. He spoke of a new crusade and swore to ferret out the weak of faith within our ranks.</P>\n<BR/>\n<P>I told him to go easy. We''re not destroying the Crusade so much as forming an elite cadre of the most faithful to do the Light''s bidding in Northrend. I fear the man''s friendship with LeCraft is slowly twisting him. They both have their uses, though.</P>\n<BR/>\n<P>Street''s talk of a new crusade, however, has me thinking. I believe that when this new force is assembled, I will give us a new name. It''ll have to be evocative of our new mission, yet still provide a tie to the past. I will pray with the high abbot on this.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3125;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>Our prayers have been answered. The high abbot was particularly moved by the force of the Light''s voice, its clarity, and sense of purpose.</P>\n<BR/>\n<P>Those of us going north - the most faithful - shall be known as the Scarlet Onslaught.</P>\n<BR/>\n<P>And an onslaught upon Northrend we shall be! The cancer of the Scourge threatens to overflow in the crown of the world and drown the rest of us. The time has come to take the fight directly to the Lich King''s doorstep.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3126;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>It is with trepidation that I gaze upon New Avalon, I somehow suspect for the last time. The fate of our cause lies in Northrend. I am filled with a sense of ominous foreboding for some reason. The mission ahead should shake away these concerns. I will put them out of my mind.</P>\n<BR/>\n<P>The Crimson Dawn is upon us.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3127;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<BR/>\n<P>It is with trepidation that I gaze upon New Avalon, I somehow suspect for the last time. The fate of our cause lies in Northrend. I am filled with a sense of ominous foreboding for some reason. The mission ahead should shake away these concerns. I will put them out of my mind.</P>\n<BR/>\n<P>The Crimson Dawn is upon us.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3129;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>There''s been no word from any of my couriers this morning. It''s clear that none of them made it through to Hearthglen. The Plaguelands are lost. Pureblood will come with his forces and they''ll be annihilated out in the open.</P>\n<BR/>\n<P>This afternoon I received a vision from the Light. In it, I saw the utter destruction of everything that we''ve built here. The message was clear - I was being told to take the remainder of the most faithful and abandon the Crusade to their doom.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3143;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Landgren later told me that he''d received the same vision. I cannot comprehend how the Light would tell us to take such a dishonorable action, but it is not my place to question - I am to obey, and obey I shall.</P>\n<BR/>\n<P>It was with trepidation that I gazed upon New Avalon, I suspect for the last time. Our fate lies in Northrend. I am filled with a sense of ominous foreboding for some reason. The mission ahead should shake away these concerns. I will put them out of my mind.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3144;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Perhaps with luck, High Commander Pureblood will somehow endure and marshal the survivors. I''m a coward - a dog running away with my tail tucked between my legs!</P>\n<BR/>\n<P>Two months they tell me that this journey is going to take. The other ships aren''t built for speed like the Folly. They''re carrying most of our forces and equipment, and they''re not much more than single sail freighters, but they''ll get there safely.</P>\n<BR/>\n<P>I''m not looking forward to this, but for the Light I will endure the sea sickness. I simply mustn''t let the others see.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3145;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>I''ve not written in a while. It''s as much as I can do to stand upright and not get sick. The men are beginning to wonder why I keep myself holed up in my cabin most of the time. It wouldn''t be good for morale for them to see me this way.</P>\n<BR/>\n<P>It shouldn''t be long now. I pray that it won''t be. Six weeks already and every day it seems that the weather gets worse. I can only hope that Northrend itself does not have such horrible weather. I wasn''t built for the cold.</P>\n<BR/>\n<P>The Holy Light has been silent for a very long time.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3146;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>We were attacked with no warning whatsoever! Giants in massive oared longships came out of the mist like ghosts! They were silent as the dead.</P>\n<BR/>\n<P>I lost a ship and all of the men on it. We fought with great courage and skill considering that we have only the most rudimentary naval combat training.</P>\n<BR/>\n<P>Afterward, the screams of our men who''d been taken captive by the giants echoed across the water. After a while it grew silent again. Bishop Street led the men in prayers.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3147;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>I awoke this morning in the middle of making adjustments to my maps. The Light was guiding my hand, showing me exactly where we must go.</P>\n<BR/>\n<P>We are close!</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3148;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Landfall!</P>\n<BR/>\n<P>Exiting the rowboat upon the beach, I planted our banner and was overcome by the Holy Light, which spoke through me. Today is the Crimson Dawn - the great day that we''ve waited for. This is to be the site of New Hearthglen. We are no longer the Scarlet Crusade. We are now the Scarlet Onslaught!</P>\n<BR/>\n<P>And an onslaught upon Northrend we shall be! The cancer of the Scourge threatens to overflow in the crown of the world and drown the rest of us. The time has come to take the fight directly to the Lich King''s doorstep!</P>\n</BODY>\n</HTML>' WHERE `entry`=3149;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>It''s been almost a month now and construction has proceeded apace. I''ve been too busy to write. My scouts tell me that this land is full of dragons and other strange beasts. We''ll keep to ourselves until we''re ready.</P>\n<BR/>\n<P>In the middle of services today, the high abbot proclaimed that a visitor would arrive soon - one that the Light was sending to lead us to victory.</P>\n<BR/>\n<P>I don''t know how I feel about that. Why didn''t the Light tell me? Have I not served faithfully? Now I''m to be replaced by some outsider?</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3150;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Admiral Barean Westwind showed up on my doorstep tonight! By all accounts he''d died upon these shores an age ago.</P>\n<BR/>\n<P>He didn''t look old enough and yet I knew that it was him. He claimed that he was the only survivor of his doomed fleet and that he''d survived only through the good graces of the Light.</P>\n</BODY>\n</HTML>' WHERE `entry`=3151;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>We stayed up speaking through the night and into the morning. He assured me that he had no intention of taking my place, but that the Light had instructed him to travel across the Great Dragonblight to serve as my advisor and commander in title only. He claimed that great change was coming to Northrend. The Alliance and the Horde were going to come en masse in response to a great plague that the Lich King was about to unleash upon them.</P>\n</BODY>\n</HTML>' WHERE `entry`=3152;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>The men have taken to the grand admiral with great zeal, especially High Abbot Landgren and Bishop Street. Apparently the Holy Light whispered a new blessing to the admiral in his sleep, which he passed on to Landgren. Some of the men have converted to the priesthood and are now being called \"raven priests\".</P>\n<BR/>\n<P>Only Jordan seems unimpressed. I suppose that''s understandable. He probably feels his position is threatened if mine is.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3153;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Something doesn''t seem right. I can''t put my finger on it, but I cannot make myself fully trust the admiral. He''s done nothing wrong. Quite the contrary! And yet, I have to trust my gut.</P>\n<BR/>\n<P>I will pray for understanding. The Light delivered the admiral to lead us to victory and it is not my place to question its decisions. I will continue to obey. I am faithful.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3154;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>Another couple of months have passed. We''ve made great strides in the construction of New Hearthglen. The wall is almost complete as is the barracks. Kaleiki''s men are miracle workers.</P>\n<BR/>\n<P>My heart hasn''t been into writing. I''ve been avoiding putting my thoughts here for some reason. The Light hasn''t visited me of late, though the admiral assures me that this is nothing to worry about.</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3155;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>My men report that a small group of Forsaken have broken ground on a camp along the hillside to the north. On the other side of the hill, the Alliance have apparently begun the construction of a much larger base.</P>\n<BR/>\n<P>The admiral says that we should leave them be. There are other Horde forces gathered to the west that would surely come to their aid if we were to attack. I don''t feel good about it, but I see the logic in his reasoning.</P>\n</BODY>\n</HTML>' WHERE `entry`=3156;
UPDATE `page_text` SET `text`='<HTML>\n<BODY>\n<P>The first phase of construction is done. Admiral Westwind has ordered a group of my men to establish a toehold further to the north. He wouldn''t go into detail, claiming that he was being \"guided\" to do so.</P>\n<BR/>\n<P>We caught four spies from the Forsaken town, Venomspite, this afternoon. I''m going to have LeCraft torture them for information. If we only caught four, how many more have slipped in amongst us?</P>\n<BR/>\n<P>Why do I feel as if things are beginning to unravel?</P>\n</BODY>\n</HTML>\n' WHERE `entry`=3558;

-- Missing gameobject "MILITARY RANKS OF THE HORDE & ALLIANCE" in Hall of Legends - Orgrimmar (map 1)
DELETE FROM `gameobject` WHERE `guid`=203 AND `id`=179707;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(203,179707,1,1,1,1655.29,-4213.86,56.469,1.95064,0,0,0.696499,0.717557,180,100,1);

UPDATE `creature_template` SET `scale`=1 WHERE `entry`=37690; -- Growing Ooze Puddle

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_slime_puddle';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70346,'spell_putricide_slime_puddle'),
(72456,'spell_putricide_slime_puddle'),
(72868,'spell_putricide_slime_puddle'),
(72869,'spell_putricide_slime_puddle');

ALTER TABLE `waypoint_data` ADD `orientation` float NOT NULL DEFAULT '0' AFTER `position_z`;

DELETE FROM `spell_group` WHERE `id` = 1114;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1114,1490),
(1114,60431),
(1114,60432),
(1114,60433),
(1114,51726),
(1114,51734),
(1114,51735);

DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1114;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(1114,3);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_shadowfiend';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(34433,'spell_pri_shadowfiend');

-- Move Shadowfiend's Mana Leech Aura from spellscript to creature addon.
DELETE FROM `spell_script_names` WHERE `ScriptName`= 'spell_pri_shadowfiend';
UPDATE `creature_template_addon` SET `auras`= '28305' WHERE `entry`=19668;

-- [Q] A Taste of Flame

-- Cyrus Therepentous SAI
SET @ENTRY := 9459;
SET @GOSSIP := 40060;
UPDATE `creature_template` SET `AIName`='SmartAI',`gossip_menu_id`=@GOSSIP WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,62,0,100,0,@GOSSIP,0,0,0,12,9461,1,360000,0,0,0,8,0,0,0,-7656.939941,-3009.474121,133.205612,4.830283,"Cyrus Therepentous - On Gossip Select - Summon Frenzied Black Drake"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cyrus Therepentous - On Gossip Select (Link) - Close Gossip");

-- Actual gossip option and text for Cyrus Therepentous
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=2494;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,2494);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,"I present you with proof...",1,1,0,0,0,0,NULL);

-- Frenzied Black Drake SAI
SET @ENTRY := 9461;
SET @SPELL_FRENZY := 8269;
SET @SPELL_DECIMATE := 13459;
SET @SPELL_FLAME_BREATH := 9573;
SET @SPELL_FLAME_BUFFET := 9574;
UPDATE `creature_template` SET `AIName`='SmartAI',`mechanic_immune_mask`=1104 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,2300,2900,19500,46300,11,@SPELL_FLAME_BREATH,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frenzied Black Drake - In Combat - Cast Flame Breath"),
(@ENTRY,0,1,0,0,0,100,0,1100,3800,2300,6100,11,@SPELL_FLAME_BUFFET,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frenzied Black Drake - In Combat - Cast Flame Buffet"),
(@ENTRY,0,2,0,0,0,100,0,28500,31600,70100,74400,11,@SPELL_DECIMATE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frenzied Black Drake - In Combat - Cast Decimate"),
(@ENTRY,0,3,4,2,0,100,1,0,30,0,0,11,@SPELL_FRENZY,1,0,0,0,0,1,0,0,0,0,0,0,0,"Frenzied Black Drake - At 30% HP - Cast Frenzy"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Frenzied Black Drake - At 30% HP - Emote Line 0");
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"%s goes into a frenzy!",16,0,100,0,0,0,"Frenzied Black Drake");

-- Conditions for the gossip option
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,4022, 'Show gossip if on quest A Taste of Flame (1) OR'),
(15,@GOSSIP,0,1,9,4023, 'Show gossip if on quest A Taste of Flame (2) OR'),
(15,@GOSSIP,0,2,9,4024, 'Show gossip if on quest A Taste of Flame (3) OR');

-- corrected quests in creature_involvedrelation and creature_questrelation
--  Horde npcs 14726 Rashona Straglash
UPDATE `creature_involvedrelation` SET  `quest` = 7824 WHERE `id` =14726 AND `quest` =7836;
UPDATE `creature_questrelation` SET `quest` = 7824 WHERE `id` =14726 AND `quest` =7836;
UPDATE `creature_involvedrelation` SET `quest` = 7832 WHERE `id` =14726 AND `quest` =7837;
UPDATE `creature_questrelation` SET `quest` = 7832 WHERE `id` =14726 AND `quest` =7837;

-- NPC 14727 Vehena
UPDATE `creature_involvedrelation` SET `quest` = 7836 WHERE `id` =14727 AND `quest` =7832;
UPDATE `creature_questrelation` SET `quest` = 7836 WHERE  `id` =14727 AND `quest` =7832;
UPDATE `creature_involvedrelation` SET `quest` = 7837 WHERE `id` =14727 AND `quest` =7824;
UPDATE `creature_questrelation` SET  `quest` = 7837 WHERE  `id` =14727 AND `quest` =7824;

-- Alliance npcs 14725 Raedon Dustriker
UPDATE `creature_involvedrelation` SET `quest` = 10352 WHERE `id` =14725 AND `quest` =7792;
UPDATE `creature_questrelation` SET `quest` = 10352 WHERE  `id` =14725 AND `quest` =7792;
UPDATE `creature_involvedrelation` SET `quest` = 10354 WHERE `id` =14725 AND `quest` =7798;
UPDATE `creature_questrelation` SET `quest` = 10354 WHERE  `id` =14725 AND `quest` =7798;

-- NPC 20604 Dugiru
UPDATE `creature_involvedrelation` SET `quest` = 7792 WHERE `id` =20604 AND `quest` =10352;
UPDATE `creature_questrelation` SET `quest` = 7792 WHERE  `id` =20604 AND `quest` =10352;
UPDATE `creature_involvedrelation` SET `quest` = 7798 WHERE `id` =20604 AND `quest` =10354;
UPDATE `creature_questrelation` SET `quest` = 7798 WHERE  `id` =20604 AND `quest` =10354;

-- NPC 14723 Mistina Steelshield
UPDATE `creature_involvedrelation` SET `quest` = 7802 WHERE `id` =14723 AND `quest` =7807;
UPDATE `creature_questrelation` SET `quest` = 7802 WHERE  `id` =14723 AND `quest` =7807;
UPDATE `creature_involvedrelation` SET `quest` = 7803 WHERE `id` =14723 AND `quest` =7808;
UPDATE `creature_questrelation` SET `quest` = 7803 WHERE  `id` =14723 AND `quest` =7808;

-- NPC 14724 Bublo Acerbus
UPDATE `creature_involvedrelation` SET `quest` = 7807 WHERE `id` =14724 AND `quest` =7802;
UPDATE `creature_questrelation` SET `quest` = 7807 WHERE  `id` =14724 AND `quest` =7802;
UPDATE `creature_involvedrelation` SET `quest` = 7808 WHERE `id` =14724 AND `quest` =7803;
UPDATE `creature_questrelation` SET `quest` = 7808 WHERE  `id` =14724 AND `quest` =7803;

DELETE FROM `gameobject_template` WHERE `entry` IN (180211,180213);
INSERT INTO `gameobject_template`(`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES
(180211,5,6314,'Uther''s Gnome Tribute','','','',0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340),
(180213,5,6315,'Uther''s Night Elf Tribute','','','',0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340);

-- [Q] A Meeting With The Magister
-- [Q] An Audience With The Arcanist
SET @ENTRY_HATHOREL := 36670;
SET @ENTRY_TYBALIN := 36669;
SET @QUEST_A := 20439;
SET @QUEST_H := 24451;
SET @GOSSIP_A := 10857;
SET @GOSSIP_H := 10858;
SET @SPELL_SUNREAVER_DISGUISE := 70973;
SET @SPELL_COVENANT_DISGUISE := 70971;
SET @SPELL_CREATE_BLADES := 69722;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY_HATHOREL,@ENTRY_TYBALIN);
UPDATE `quest_template` SET `OfferRewardText`="Excellent work. Now that this is in our hands, we must get it to Caladis Brightspear as soon as possible. We can't risk the book falling back into Sunreaver hands.$BI'll ensure that Shandy Glossgleam gets his tabard back without incident, along with a healthy reward for his help",`RequestItemsText`="Have you recovered that book?" WHERE `entry`=@QUEST_A;
UPDATE `quest_template` SET `OfferRewardText`="Excellent work. Now that this is in our hands, we must get it to Myralion Sunblaze as soon as possible. We can't risk the Silver Covenant taking the book from us again.$BI'll get that tabard back to Shandy and see that he's well compensated for his assistance. Once the book is in Myralion's hands, the Silver Covenant won't be a threat anymore.",`RequestItemsText`="Have you recovered that book?" WHERE `entry`=@QUEST_H;
DELETE FROM `creature` WHERE `guid`=150186 AND `id`=@ENTRY_HATHOREL; -- Double-spawned Hathorel
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY_HATHOREL,@ENTRY_HATHOREL*100,@ENTRY_TYBALIN,@ENTRY_TYBALIN*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY_TYBALIN,0,0,0,19,0,100,0,@QUEST_A,0,0,0,11,@SPELL_SUNREAVER_DISGUISE,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Quest Accept - Cast Sunreaver Disguise"),
(@ENTRY_TYBALIN,0,1,0,20,0,100,0,@QUEST_A,0,0,0,28,@SPELL_SUNREAVER_DISGUISE,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Quest Reward - Remove Aura Sunreaver Disguise"),
(@ENTRY_TYBALIN,0,2,3,62,0,100,0,@GOSSIP_A,1,0,0,11,@SPELL_SUNREAVER_DISGUISE,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Quest Accept - Cast Sunreaver Disguise"),
(@ENTRY_TYBALIN,0,3,0,61,0,100,0,@GOSSIP_A,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Gossip Select - Close Gossip"),
(@ENTRY_TYBALIN,0,4,0,62,0,100,0,@GOSSIP_H,0,0,0,80,@ENTRY_TYBALIN*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arcanist Tybalin - On Gossip Select - Run Script"),
(@ENTRY_TYBALIN*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Script - Close Gossip"),
(@ENTRY_TYBALIN*100,9,1,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Script - Say text 0"),
(@ENTRY_TYBALIN*100,9,2,0,0,0,100,0,6000,6000,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Script - Say text 1"),
(@ENTRY_TYBALIN*100,9,3,0,0,0,100,0,0,0,0,0,11,@SPELL_CREATE_BLADES,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Script - Cast Create Ancient Dragonforged Blades"),
(@ENTRY_TYBALIN*100,9,4,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,7,0,0,0,0,0,0,0,"Arcanist Tybalin - On Script - Say text 2"),

(@ENTRY_HATHOREL,0,0,0,19,0,100,0,@QUEST_H,0,0,0,11,@SPELL_COVENANT_DISGUISE,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Quest Accept - Cast Covenant Disguise"),
(@ENTRY_HATHOREL,0,1,0,20,0,100,0,@QUEST_H,0,0,0,28,@SPELL_COVENANT_DISGUISE,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Quest Reward - Remove Aura Covenant Disguise"),
(@ENTRY_HATHOREL,0,2,3,62,0,100,0,@GOSSIP_H,1,0,0,11,@SPELL_COVENANT_DISGUISE,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Quest Accept - Cast Covenant Disguise"),
(@ENTRY_HATHOREL,0,3,0,61,0,100,0,@GOSSIP_H,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Gossip Select - Close Gossip"),
(@ENTRY_HATHOREL,0,4,0,62,0,100,0,@GOSSIP_A,0,0,0,80,@ENTRY_HATHOREL*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Magister Hathorel - On Gossip Select - Run Script"),
(@ENTRY_HATHOREL*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Script - Close Gossip"),
(@ENTRY_HATHOREL*100,9,1,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Script - Say text 0"),
(@ENTRY_HATHOREL*100,9,2,0,0,0,100,0,6000,6000,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Script - Say text 1"),
(@ENTRY_HATHOREL*100,9,3,0,0,0,100,0,0,0,0,0,11,@SPELL_CREATE_BLADES,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Script - Cast Create Ancient Dragonforged Blades"),
(@ENTRY_HATHOREL*100,9,4,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,7,0,0,0,0,0,0,0,"Magister Hathorel - On Script - Say text 2");

-- Actual gossip option
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP_A,@GOSSIP_H);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(@GOSSIP_A,0,0,"I'm ready to deliver the tome, Magister Hathorel.",1,1,0,0,0,0,NULL),
(@GOSSIP_A,1,0,"Would you renew my Sunreaver disguise?",1,1,0,0,0,0,NULL),
(@GOSSIP_H,0,0,"I'm ready to deliver the tome, Arcanist Tybalin.",1,1,0,0,0,0,NULL),
(@GOSSIP_H,1,0,"Would you renew my Covenant disguise?",1,1,0,0,0,0,NULL);

-- Magister Hathorel
DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY_HATHOREL,@ENTRY_TYBALIN);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY_HATHOREL,0,0,"You're late, courier. No, I don't want any excuses; this errand is far too important.",12,0,100,1,0,0,"Magister Hathorel"),
(@ENTRY_HATHOREL,1,0,"Here's the tome our representative brought from Wyrmrest. Get this to Myralion Sunblaze immediately.",12,0,100,1,0,0,"Magister Hathorel"),
(@ENTRY_HATHOREL,2,0,"Watch your back, courier. I needn't remind you of the value of the book, nor the fact that the Silver Covenant will stop at nothing to take it from us.",12,0,100,1,0,0,"Magister Hathorel"),
-- Arcanist Tybalin
(@ENTRY_TYBALIN,0,0,"It's good to finally see you, courier. Krasus has entrusted us with one of the few remaining copies of Ancient Dragonforged Blades.",12,0,100,1,0,0,"Arcanist Tybalin"),
(@ENTRY_TYBALIN,1,0,"Here is the book. You must ensure it gets to Caladis Brightspear in Icecrown before the Sunreavers realize what is happening.",12,0,100,1,0,0,"Arcanist Tybalin"),
(@ENTRY_TYBALIN,2,0,"Travel quickly! The Sunreavers will not waste any time once they realize that we have the information they seek.",12,0,100,1,0,0,"Arcanist Tybalin");

-- Conditions for the gossip options
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (15) AND `SourceGroup` IN (@GOSSIP_A,@GOSSIP_H);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP_A,0,9,@QUEST_A),
(15,@GOSSIP_H,0,9,@QUEST_H),

(15,@GOSSIP_A,1,11,@SPELL_COVENANT_DISGUISE),
(15,@GOSSIP_H,1,11,@SPELL_SUNREAVER_DISGUISE),

(15,@GOSSIP_A,1,9,@QUEST_A),
(15,@GOSSIP_H,1,9,@QUEST_H);

-- [Q] Still At It
-- "Tipsy" McManus SAI
SET @ENTRY := 28566;
SET @GOSSIP := 9713;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100+0,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3,@ENTRY*100+4,@ENTRY*100+5,@ENTRY*100+6,@ENTRY*100+7,@ENTRY*100+8);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100+0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - On gossip option select - Run script"),
(@ENTRY,0,1,0,1,1,100,0,5000,5000,11000,11000,88,@ENTRY*100+1,@ENTRY*100+5,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - After 5 Sec - Run Random Script"),
(@ENTRY,0,2,0,38,1,100,0,1,1,0,0,80,@ENTRY*100+6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - On Data Set 1 1 - Run Completion Script"),
(@ENTRY,0,3,0,1,1,100,1,103900,103900,0,0,80,@ENTRY*100+8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Call Script Quest successful (phase 1) after some time (104s=9tasks)"),
(@ENTRY,0,4,0,1,2,100,1,0,0,0,0,80,@ENTRY*100+7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Timed - Run Failure Script"),
(@ENTRY,0,5,0,1,4,100,1,8000,8000,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Timed - Set Back Gossip & Quest Flags"),
(@ENTRY,0,6,0,1,4,100,1,8010,8010,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Timed - Reset script"),
-- Start Script
(@ENTRY*100+0,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tipsy McManus - Script 0 - Close Gossip"),
(@ENTRY*100+0,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 0 - Turn of Gossip & Questgiver flags"),
(@ENTRY*100+0,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 0 - Say Text 0"),
(@ENTRY*100+0,9,3,0,0,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 0 - Set Phase 1"),
-- Wants Orange
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 1 - Say Text 1"),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,12,28535,1,10000,0,0,0,8,0,0,0,5549.62354,5769.51367,-73.42824,2.75762,"Tipsy McManus - Script 1 - Summon Wants Orange"),
(@ENTRY*100+1,9,2,0,0,0,100,0,10000,10000,10000,10000,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 1 - set phase 2"),
-- Wants Papaya
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 2 - Say Text 2"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,12,28536,1,10000,0,0,0,8,0,0,0,5549.62354,5769.51367,-73.42824,2.75762,"Tipsy McManus - Script 2 - Summon Wants Papaya"),
(@ENTRY*100+2,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 2 - set phase 2"),
-- Wants Bananas
(@ENTRY*100+3,9,0,0,0,0,100,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 3 - Say Text 3"),
(@ENTRY*100+3,9,1,0,0,0,100,0,0,0,0,0,12,28537,1,10000,0,0,0,8,0,0,0,5549.62354,5769.51367,-73.42824,2.75762,"Tipsy McManus - Script 3 - Summon Wants Bananas"),
(@ENTRY*100+3,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 3 - set phase 2"),
-- Steaming Valve
(@ENTRY*100+4,9,0,0,0,0,100,0,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 4 - Say Text 4"),
(@ENTRY*100+4,9,1,0,0,0,100,0,0,0,0,0,12,28539,1,10000,0,0,0,8,0,0,0,5548.1,5767.4,-76.2673,-2.1293,"Tipsy McManus - Script 4 - Summon Steaming Valve"),
(@ENTRY*100+4,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 4 - set phase 2"),
-- Wants Fire
(@ENTRY*100+5,9,0,0,0,0,100,0,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 5 - Say Text 5"),
(@ENTRY*100+5,9,1,0,0,0,100,0,0,0,0,0,12,28540,1,10000,0,0,0,8,0,0,0,5552.58,5765.66,-78.0212,-3.00195,"Tipsy McManus - Script 5 - Summon Wants Fire"),
(@ENTRY*100+5,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 5 - Set Phase 2"),
-- Task successful
(@ENTRY*100+6,9,0,0,0,0,100,0,0,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 6 - Say Text 6"),
-- End failure
(@ENTRY*100+7,9,0,0,0,0,100,0,0,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 7 - Say Text 7"),
(@ENTRY*100+7,9,1,0,0,0,100,0,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 7 - Set Phase 4"),
-- Completion script
(@ENTRY*100+8,9,0,0,0,0,100,0,0,0,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 8 - Say Text 8"),
(@ENTRY*100+8,9,1,0,0,0,100,0,0,0,0,0,50,190643,30000,0,0,0,0,8,0,0,0,5547.13525,5767.09961,-78.025856,2.25147343,"Tipsy McManus - Script 8 - Summon Thunderbrew's Jungle Punch"),
(@ENTRY*100+8,9,2,0,0,0,100,0,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tipsy McManus - Script 8 - Set Phase 4");


-- NPC talk text for "Tipsy" McManus
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Beginning the distillation in 5 seconds.",12,0,100,0,0,0,"Tipsy McManus"),
(@ENTRY,1,0,"Add another orange, quickly!",12,0,100,25,0,0,"Tipsy McManus"),
(@ENTRY,2,0,"Put a papaya in the still!",12,0,100,25,0,0,"Tipsy McManus"),
(@ENTRY,3,0,"Add bananas!",12,0,100,25,0,0,"Tipsy McManus"),
(@ENTRY,4,0,"Pressure's too high! Open the pressure valve!",12,0,100,5,0,0,"Tipsy McManus"),
(@ENTRY,5,0,"The still needs heat! Light the brazier!",12,0,100,5,0,0,"Tipsy McManus"),
(@ENTRY,6,0,"Good job! Keep your eyes open, now.",12,0,100,4,0,0,"Tipsy McManus"),
(@ENTRY,6,1,"That'll do. Never know what it'll need next...",12,0,100,4,0,0,"Tipsy McManus"),
(@ENTRY,6,2,"Nicely handled! Stay on your toes!",12,0,100,4,0,0,"Tipsy McManus"),
(@ENTRY,6,3,"Well done! Be ready for anything!",12,0,100,4,0,0,"Tipsy McManus"),
(@ENTRY,7,0,"It's no good! I'm shutting it down...",12,0,100,0,0,0,"Tipsy McManus"),
(@ENTRY,8,0,"We've done it! Come get the cask.",12,0,100,0,0,0,"Tipsy McManus");

-- Add Gossip option
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`) VALUES
(@GOSSIP,0,0,"I'm ready to start the distillation, uh, Tipsy.",1,1);

-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,@GOSSIP,0,9,12644); -- Quest "Still At It" Has to be active and incomplete

-- Update creature_template for Wants XX targets
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`exp`=2,`unit_class`=2,`unit_flags`=`unit_flags`|33554432,`flags_extra`=`flags_extra`|128,`InhabitType`=4,`family`=23,`type`=3 WHERE `entry` IN (28535,28536,28537,28539,28540);

-- Wants Orange SAI
SET @ENTRY := 28535;
SET @SPELL_ORANGE := 51931;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_ORANGE,0,0,0,45,1,1,0,0,0,0,19,28566,0,0,0,0,0,0,"Wants Orange - On Spellhit - Set Data McManus");

-- Wants Papaya SAI
SET @ENTRY := 28536;
SET @SPELL_PAPAYA := 51933;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_PAPAYA,0,0,0,45,1,1,0,0,0,0,19,28566,0,0,0,0,0,0,"Wants Papaya - On Spellhit - Set Data McManus");

-- Wants Bananas SAI
SET @ENTRY := 28537;
SET @SPELL_BANANAS := 51932;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_BANANAS,0,0,0,45,1,1,0,0,0,0,19,28566,0,0,0,0,0,0,"Wants Bananas - On Spellhit - Set Data McManus");

-- Steam Valve SAI
SET @ENTRY := 28539;
SET @SPELL_STEAM_BLAST := 51920;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,0,0,0,11,@SPELL_STEAM_BLAST,0,0,0,0,0,1,0,0,0,0,0,0,0,"Steam Valve - Out Of Combat - Cast Cosmetic Steam Blast"),
(@ENTRY,0,1,0,6,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,28566,0,0,0,0,0,0,"Steam Valve - On Death - Set Data McManus");

-- Pressure Valve SAI
SET @ENTRY := 190635;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=1 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,64,0,100,0,500,500,0,0,51,0,0,0,0,0,0,19,28539,0,0,0,0,0,0,"Pressure Valve - On Gossip Hello - Kill Steam Valve");

-- Wants Fire SAI
SET @ENTRY := 28540;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,28566,0,0,0,0,0,0,"Wants Fire - On Death - Set Data McManus");

-- Brazier SAI
SET @ENTRY := 190636;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,64,0,100,0,500,500,0,0,51,0,0,0,0,0,0,19,28540,0,0,0,0,0,0,"Brazier - On Gossip Hello - Kill Wants Fire");

-- Add Spell Targets
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (51931,51932,51933);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,51931,18,1,28535), -- Toss Orange requires target Wants Orange
(13,51931,18,1,28536), -- Toss Orange requires target Wants Papaya
(13,51931,18,1,28537), -- Toss Orange requires target Wants Bananas
(13,51933,18,1,28535), -- Toss Papaya requires target Wants Orange
(13,51933,18,1,28536), -- Toss Papaya requires target Wants Papaya
(13,51933,18,1,28537), -- Toss Papaya requires target Wants Bananas
(13,51932,18,1,28535), -- Toss Bananas requires target Wants Orange
(13,51932,18,1,28536), -- Toss Bananas requires target Wants Papaya
(13,51932,18,1,28537); -- Toss Bananas requires target Wants Bananas

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q14112_14145_chum_the_water';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(66741,'spell_q14112_14145_chum_the_water');

-- Template updates for creature 35071 (North Sea Mako)
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`baseattacktime`=2000,`InhabitType`=`InhabitType`&~1 WHERE `entry` IN (35071,35060,35061); -- North Sea * (Last 2 entries guessed)
UPDATE `creature_template` SET `faction_A`=1885,`faction_H`=1885,`baseattacktime`=2000 WHERE `entry`=35072; -- Angry Kvaldir
-- Addon data for creature 35071 (North Sea Mako)
DELETE FROM `creature_template_addon` WHERE `entry` IN (35071,35072,35060,35061);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(35071,0,0,1,0, NULL), -- North Sea Mako
(35060,0,0,1,0, NULL), -- North Sea Thresher - guessed
(35061,0,0,1,0, NULL), -- North Sea Blue Shark - guessed
(35072,0,0,1,0, NULL); -- Angry Kvaldir

-- Snowblind Follower SAI
SET @ENTRY := 29618;
SET @SPELL_NET := 66474;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,0,@SPELL_NET,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Snowblind Follower - On Spellhit - Say Line 0 (random)"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,33,34899,0,0,0,0,0,7,0,0,0,0,0,0,0,"Snowblind Follower - On Spellhit (Link) - Quest Credit"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Snowblind Follower - On Spellhit (Link) - Forced Despawn");

-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Grrrrr!",12,0,100,0,0,0,"Snowblind Follower"),
(@ENTRY,0,1,"Me not afraid!",12,0,100,0,0,0,"Snowblind Follower"),
(@ENTRY,0,2,"Net not stop me! No... net stop me.",12,0,100,0,0,0,"Snowblind Follower"),
(@ENTRY,0,3,"No kill me!",12,0,100,0,0,0,"Snowblind Follower"),
(@ENTRY,0,4,"No!",12,0,100,0,0,0,"Snowblind Follower"),
(@ENTRY,0,5,"You no take... me!",12,0,100,0,0,0,"Snowblind Follower");

-- Hooked Net SHOULD hit this hard, fyi!
-- Sunreaver Agent SAI
SET @ENTRY := 36776;
SET @SPELL_HOOKED_NET := 59260;
SET @SPELL_SINISTER_STRIKE := 60195;
SET @SPELL_VANISH := 71400; -- Why is this called Vanish?... It teleports caster behind target
SET @SPELL_EVISCERATE := 15691;
SET @SPELL_BACKSTAB := 71410;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|2,`unit_class`=4 WHERE `entry`=@ENTRY; -- Civilian according to video
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sunreaver Agent - On Aggro - Say Line 0 (random)"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,11,@SPELL_HOOKED_NET,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sunreaver Agent - On Aggro - Cast Hooked Net"),
(@ENTRY,0,2,0,67,0,100,0,1000,3000,0,0,11,@SPELL_BACKSTAB,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sunreaver Agent - Behind Target - Cast Backstab"),
(@ENTRY,0,3,0,0,0,100,0,1000,1500,3000,3000,11,@SPELL_SINISTER_STRIKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sunreaver Agent - In Combat - Cast Sinister Strike"),
(@ENTRY,0,4,0,0,0,100,1,4000,6000,0,0,11,@SPELL_VANISH,1,0,0,0,0,2,0,0,0,0,0,0,0,"Sunreaver Agent - In Combat - Cast Vanish"),
(@ENTRY,0,5,0,0,0,100,0,9000,13000,20000,20000,11,@SPELL_EVISCERATE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sunreaver Agent - In Combat - Cast Eviscerate");

-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Did you think you would escape with your life?",12,0,100,1,0,0,"Sunreaver Agent"),
(@ENTRY,0,1,"You'll never run us out of the city, Silver Covenant thug!",12,0,100,1,0,0,"Sunreaver Agent");

-- Silver Covenant Agent SAI
SET @ENTRY := 36774;
SET @SPELL_HOOKED_NET := 59260;
SET @SPELL_SINISTER_STRIKE := 60195;
SET @SPELL_VANISH := 71400; -- Why is this called Vanish?... It teleports caster behind target
SET @SPELL_EVISCERATE := 15691;
SET @SPELL_BACKSTAB := 71410;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|2,`unit_class`=4 WHERE `entry`=@ENTRY; -- Civilian according to video
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Silver Covenant Agent - On Aggro - Say Line 0 (random)"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,11,@SPELL_HOOKED_NET,0,0,0,0,0,2,0,0,0,0,0,0,0,"Silver Covenant Agent - On Aggro - Cast Hooked Net"),
(@ENTRY,0,2,0,67,0,100,0,1000,3000,0,0,11,@SPELL_BACKSTAB,0,0,0,0,0,2,0,0,0,0,0,0,0,"Silver Covenant Agent - Behind Target - Cast Backstab"),
(@ENTRY,0,3,0,0,0,100,0,1000,1500,3000,3000,11,@SPELL_SINISTER_STRIKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Silver Covenant Agent - In Combat - Cast Sinister Strike"),
(@ENTRY,0,4,0,0,0,100,1,4000,6000,0,0,11,@SPELL_VANISH,1,0,0,0,0,2,0,0,0,0,0,0,0,"Silver Covenant Agent - In Combat - Cast Vanish"),
(@ENTRY,0,5,0,0,0,100,0,9000,13000,20000,20000,11,@SPELL_EVISCERATE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Silver Covenant Agent - In Combat - Cast Eviscerate");

-- Texts by
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"You Sunreaver lackeys are all the same.",12,0,100,1,0,0,"Silver Covenant Agent"),
(@ENTRY,0,1,"You won't escape from us so easily!",12,0,100,1,0,0,"Silver Covenant Agent");

UPDATE `creature_model_info` SET `bounding_radius`=0.383,`combat_reach`=1.5,`gender`=1 WHERE `modelid`=30438; -- Sunreaver Agent
UPDATE `creature_model_info` SET `bounding_radius`=0.383,`combat_reach`=1.5,`gender`=0 WHERE `modelid`=30310; -- Silver Covenant Agent

-- [Q] Tails Up
-- Apparently it won't fall asleep due to evading. We are evading because the gossip won't show if we are in combat.. -_-

-- Frost Leopard SAI
SET @ENTRY := 29327;
SET @QUEST := 13549;
SET @GOSSIP := 54000;
SET @SPELL_RAKE := 54668;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 52742;
UPDATE `creature_template` SET `AIName`='SmartAI',`npcflag`=0,`gossip_menu_id`=@GOSSIP,`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frost Leopard - In Combat - Cast Rake"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Reset - Set Faction Back"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_BLOWGUN,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Cast Sleep"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Set Faction Friendly"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Set npc_flag Gossip"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Evade"), -- The gossip only shows out of combat..
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script - Stop Auto Attack"),

(@ENTRY,0,3,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100+1,@ENTRY*100+3,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Gossip Select - Run Random Script"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,36,33007,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Update Template Male"),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Frost Leopard - Script 1 - Say Line 0"),
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,36,33010,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Update Template Female"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,33,33005,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Quest Credit"),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,29,2,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Follow Player"), -- Apparently crediting doesn't work through this action
(@ENTRY*100+3,9,0,0,0,0,100,0,0,0,0,0,36,33007,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 3 - Update Template Male"),
(@ENTRY*100+3,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Frost Leopard - Script 3 - Say Line 0");

-- Insert gossip and static text
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=14266;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,14266);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@GOSSIP,0,0,"Lift the frost leopard's tail to check if it's a male or a female.",1,1,0);

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Frost Leopard");

-- Male Frost Leopard SAI
SET @ENTRY := 33007;
SET @SPELL_RAKE := 54668;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Frost Leopard - In Combat - Cast Rake");

-- Icepaw Bear SAI
SET @ENTRY := 29319;
SET @QUEST := 13549;
SET @GOSSIP := 55000;
SET @SPELL_CLAWS_OF_ICE := 54632;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 52742;
UPDATE `creature_template` SET `AIName`='SmartAI',`npcflag`=0,`gossip_menu_id`=@GOSSIP,`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Icepaw Bear - In Combat - Cast Claws of Ice"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Reset - Set Faction Back"),
(@ENTRY,0,2,0,8,0,100,1,@SPELL_BLOWGUN,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Cast Sleep"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Set Faction Friendly"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Set npc_flag Gossip"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Evade"), -- The gossip only shows out of combat..
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script - Stop Auto Attack"),

(@ENTRY,0,3,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100+1,@ENTRY*100+3,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Gossip Select - Run Random Script"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,36,33008,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Update Template Male"),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Icepaw Bear - Script 1 - Say Line 0"),
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,36,33011,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Update Template Female"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,33,33006,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Quest Credit"),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,29,2,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Follow Player"), -- Apparently crediting doesn't work through this action
(@ENTRY*100+3,9,0,0,0,0,100,0,0,0,0,0,36,33008,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 3 - Update Template Male"),
(@ENTRY*100+3,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Icepaw Bear - Script 3 - Say Line 0");

-- Insert gossip and static text
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=14267;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,14267);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`) VALUES
(@GOSSIP,0,0,"Lift the icepaw bear's tail to check if it's a male or a female.",1,1,0);

-- Male Icepaw Bear SAI
SET @ENTRY := 33008;
SET @SPELL_CLAWS_OF_ICE := 54632;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Icepaw Bear - In Combat - Cast Claws of Ice");

-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Icepaw Bear");

-- Only show first gossip if player is on quest Tails Up
DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `ConditionValue1`=@QUEST;
DELETE FROM `conditions` WHERE `SourceEntry` IN (@SPELL_BLOWGUN) AND `ConditionValue1` IN (29327,29319);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,@QUEST,0,0,0,'',"Only show gossip if player is on quest Tails Up"),
(17,0,@SPELL_BLOWGUN,0,19,29327,0,0,0,'',"Spell To'kini's Blowgun can only be cast at Frost Leopard"),
(17,0,@SPELL_BLOWGUN,1,19,29319,0,0,0,'',"Spell To'kini's Blowgun can only be cast at Icepaw Bear");

-- Talbuk Doe SAI
SET @ENTRY := 20610; -- Talbuk Doe
SET @SPELL_GORE := 32019; -- Gore
SET @SPELL_TAG := 35771; -- Tag Subbued Talbuk
SET @SPELL_TAG_CREDIT := 40347; -- Talbuk Tagging Credit
SET @SPELL_SLEEPING := 42648; -- Sleeping Sleep
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - On Aggro - Say text 0"),
(@ENTRY,0,1,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_GORE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Talbuk Doe - In Combat - Cast Gore"),
(@ENTRY,0,2,0,2,0,100,1,0,20,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - At 20% HP - Say Text 1"),
(@ENTRY,0,3,0,8,0,100,0,@SPELL_TAG,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - On Spellhit - Run Script"),
(@ENTRY,0,4,0,11,0,100,0,0,0,0,0,19,386,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - On Respawn - Remove Unit Flag"),
(@ENTRY*100,9,0,0,0,0,100,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - Script - Evade"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,33,20982,0,0,0,0,0,7,0,0,0,0,0,0,0,"Talbuk Doe - Script - Give Quest Credit"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,18,386,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - Script - Set Unit Flag"),-- Make it un-attackable in any way
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEPING,1,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Doe - Script - Cast Sleeping Sleep");
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"%s calls for the aid of a nearby male!",16,0,100,0,0,0,"Talbuk Doe"),
(@ENTRY,1,0,"%s seems to have weakened.",16,0,100,0,0,0,"Talbuk Doe");

-- Talbuk Sire SAI
SET @ENTRY := 20777; -- Talbuk Sire
SET @SPELL_STOMP := 32023; -- Hoof Stomp
SET @SPELL_TAG := 35771; -- Tag Subbued Talbuk
SET @SPELL_SLEEPING := 42648; -- Sleeping Sleep
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_STOMP,0,0,0,0,0,2,0,0,0,0,0,0,0,"Talbuk Sire - In Combat - Cast Hoof Stomp"),
(@ENTRY,0,1,0,2,0,100,1,0,20,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Sire - At 20% HP - Say Text 0"),
(@ENTRY,0,2,0,8,0,100,0,@SPELL_TAG,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Sire - On Spellhit - Run Script"),
(@ENTRY,0,3,0,11,0,100,0,0,0,0,0,19,386,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Sire - On Respawn - Remove Unit Flag"),
(@ENTRY*100,9,0,0,0,0,100,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ancient Orc Ancestor - Script - Evade"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,11,@SPELL_TAG_CREDIT,2,0,0,0,0,7,0,0,0,0,0,0,0,"Talbuk Sire - Script - Give Killcredit"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,33,20982,0,0,0,0,0,7,0,0,0,0,0,0,0,"Talbuk Sire - Script - Give Quest Credit"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,18,386,0,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Sire - Script - Set Unit Flag"),-- Make it un-attackable in any way
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,11,@SPELL_SLEEPING,1,0,0,0,0,1,0,0,0,0,0,0,0,"Talbuk Sire - Script - Cast Sleeping Sleep");
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"%s seems to have weakened.",16,0,100,0,0,0,"Talbuk Sir");

-- Farahlon Lasher SAI
SET @ENTRY := 20774;
SET @SPELL_ENTANGLING_ROOTS := 12747;
SET @SPELL_FRENZY := 3019;
SET @SPELL_FLANKING_GROWTH := 36604;
SET @SPELL_ENERGY_FIELD_MODULATOR := 35772;
UPDATE `creature_template` SET `AIName`='SmartAI',`dmgschool`=3 WHERE `entry`=@ENTRY;
DELETE FROM `creature` WHERE `id` IN (21331,20983); -- Those are supposed to be summoned
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,11,@SPELL_FLANKING_GROWTH,0,0,0,0,0,2,0,0,0,0,0,0,0,"Farahlon Lasher - On Aggro - Cast Flanking Growth"),
(@ENTRY,0,1,0,0,0,100,0,20000,20000,25000,25000,11,@SPELL_ENTANGLING_ROOTS,0,0,0,0,0,2,0,0,0,0,0,0,0,"Farahlon Lasher - In Combat - Cast Entanglin Roots"),
(@ENTRY,0,2,0,8,0,100,0,@SPELL_ENERGY_FIELD_MODULATOR,0,0,0,36,20983,0,0,0,0,0,1,0,0,0,0,0,0,0,"Farahlon Lasher - On Spellhit - Change Entry To Mutated"),
(@ENTRY,0,3,0,2,0,100,1,0,30,0,0,11,@SPELL_FRENZY,1,0,0,0,0,1,0,0,0,0,0,0,0,"Farahlon Lasher - At 30% HP - Cast Frenzy"),
(@ENTRY,0,4,0,2,0,100,1,0,30,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Farahlon Lasher - At 30% HP - Say Line 0");
-- Text
DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY,20983);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"%s goes into a frenzy!",16,0,100,0,0,0,"Farahlon Lasher"),
(20983,0,0,"%s goes into a frenzy!",16,0,100,0,0,0,"Mutated Farahlon Lasher");

-- To prevent being able to use the quest item more than once per creature
-- Removing previous entry which didn't work
DELETE FROM `conditions` WHERE `SourceEntry`=35772 AND `ConditionValue2`=20774;
DELETE FROM `conditions` WHERE `SourceEntry`=29818 AND `ConditionValue2`=20774;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,29818,0,24,1,20774,0,0,'',"Item Energy Field Modulator can only be used if target is Farahlon Lasher");

-- Withered Corpse SAI
SET @ENTRY := 20561;
SET @SPELL_PROTECTORATE_IGNITER := 35372;
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=`unit_flags`|388 WHERE `entry`=@ENTRY;
DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@ENTRY,0,0,1,0,"29266"); -- Emote death spell (Permanent Feign Death)
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,@SPELL_PROTECTORATE_IGNITER,0,0,0,33,20561,0,0,0,0,0,7,0,0,0,0,0,0,0,"Withered Corpse - On Spellhit - Give Quest Credit"),
(@ENTRY,0,1,0,8,0,100,0,@SPELL_PROTECTORATE_IGNITER,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Withered Corpse - On Spellhit - Die");

-- Protector Igniter can only be used inside Access Shaft Zeon
-- We are not removing the previous one, just adding an extra check
DELETE FROM `conditions` WHERE `SourceEntry`=35372 AND `ConditionValue1`=3880;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,35372,0,23,3880,0,0,0,'',"Protector Igniter can only be used inside Access Shaft Zeon");

-- Invis BE Ballista SAI
SET @ENTRY := 19723;
SET @SPELL_BURN_BLOOD_ELF := 34526;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|130 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_BURN_BLOOD_ELF,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Invis BE Ballista - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,50,181915,20000,0,0,0,0,1,0,0,0,0,0,0,0,"Invis BE Ballista - Script - Summon Blaze (fire)"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,8,0,0,0,0,0,0,0,"Invis BE Ballista - Script - Despawn");

-- Invis BE Tent SAI
SET @ENTRY := 19724;
SET @SPELL_BURN_BLOOD_ELF := 34526;
UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=`flags_extra`|130 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_BURN_BLOOD_ELF,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Invis BE Tent - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,50,181915,20000,0,0,0,0,1,0,0,0,0,0,0,0,"Invis BE Tent - Script - Summon Blaze (fire)"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,8,0,0,0,0,0,0,0,"Invis BE Tent - Script - Despawn");

-- Windyreed Quest Credit (Hut 01) SAI
SET @ENTRY := 18142;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `gameobject` WHERE `id`=182146; -- Remove already spawned hut fires
SET @SPELL_LIVING_FIRE := 31927; -- Living Fire
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_LIVING_FIRE,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Windyreed Quest Credit - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1850.186401,6378.753906,49.132702,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1843.883911,6373.384277,46.005417,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1845.056030,6383.819336,56.662624,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1845.103638,6391.827148,53.700901,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1831.184937,6391.026855,45.671902,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,51,0,0,0,0,0,0,10,60165,17139,0,0,0,0,0,"Windyreed Quest Credit - Script - Kill Creature Inside Burning Hut");

-- Windyreed Quest Credit (Hut 02) SAI
SET @ENTRY := 18143;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
SET @SPELL_LIVING_FIRE := 31927; -- Living Fire
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_LIVING_FIRE,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Windyreed Quest Credit - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1915.344116,6350.488770,52.229897,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1907.135986,6353.901367,48.899532,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1911.698730,6354.161133,58.254566,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1926.308350,6360.901855,57.298611,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1921.458862,6367.373047,59.892593,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,51,0,0,0,0,0,0,10,60159,17139,0,0,0,0,0,"Windyreed Quest Credit - Script - Kill Creature Inside Burning Hut");

-- Windyreed Quest Credit (Hut 03) SAI
SET @ENTRY := 18144;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
SET @SPELL_LIVING_FIRE := 31927; -- Living Fire
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_LIVING_FIRE,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Windyreed Quest Credit - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1969.078369,6278.307129,56.866646,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1977.147461,6277.312988,59.912029,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1974.763306,6269.175781,51.401920,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1970.424805,6273.501953,61.741539,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,51,0,0,0,0,0,0,10,60157,17139,0,0,0,0,0,"Windyreed Quest Credit - Script - Kill Creature Inside Burning Hut");

-- Windyreed Quest Credit (Big Hut) SAI
SET @ENTRY := 18110;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
SET @SPELL_LIVING_FIRE := 31927; -- Living Fire
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,1,@SPELL_LIVING_FIRE,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Windyreed Quest Credit - On Spellhit - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1816.939941,6283.669922,61.357101,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1816.94,6283.67,61.3571,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1819.71,6305.89,63.4012,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1819.55,6298.08,73.4331,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1801.45,6308.03,59.2728,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,5,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1808.88,6307.05,72.4877,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,50,182146,20000,0,0,0,0,8,0,0,0,-1794.54,6300.6,71.2263,0,"Windyreed Quest Credit - Script - Summon Hut Fire (Large)"),
(@ENTRY*100,9,7,0,0,0,100,0,0,0,0,0,51,0,0,0,0,0,0,10,60166,17139,0,0,0,0,0,"Windyreed Quest Credit - Script - Kill Creatures Inside Burning Hut"),
(@ENTRY*100,9,8,0,0,0,100,0,0,0,0,0,51,0,0,0,0,0,0,10,60167,17139,0,0,0,0,0,"Windyreed Quest Credit - Script - Kill Creatures Inside Burning Hut");

-- Wazat SAI
SET @ENTRY := 19035;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,20000,40000,60000,80000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wazat - OOC - Say Text 0"),
(@ENTRY,0,1,0,1,0,100,0,60000,80000,80000,110000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wazat - OOC - Say Text 1"),
(@ENTRY,0,2,0,1,0,100,0,110000,130000,150000,170000,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wazat - OOC - Say Text 2");
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Oh sweet, delicious, spotted eggs - you will be mine...",12,0,100,0,0,0,"Wazat"),
(@ENTRY,1,1,"If only I could get this blasted machine working!",12,0,100,0,0,0,"Wazat"),
(@ENTRY,2,2,"They look so delicious...",12,0,100,0,0,0,"Wazat");

-- Wazat pathing: 11365
SET @GUID := 68343;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `MovementType`=2,`position_x`=-2428.169922,`position_y`=6885.750000,`position_z`=4.196100 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@GUID,@PATH,1,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2428.704590,6890.355469,4.297834,20000,0,0,100,0),
(@PATH,2,-2434.878418,6889.507813,4.266439,20000,0,0,100,0),
(@PATH,3,-2428.169922,6885.750000,4.196100,20000,0,0,100,0);

-- Windroc Matriarch SAI
SET @ENTRY := 19055;
SET @SPELL_EAGLE_CLAW := 30285; -- Eagle Claw
SET @SPELL_WING_BUFFET := 32914; -- Wing Buffet
UPDATE `creature_template` SET `AIName`='SmartAI',`InhabitType`=4,`spell1`=0 WHERE `entry`=@ENTRY; -- Always in air, of course - really? Albino Snake as mind control ability?
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,0,0,0,53,0,@ENTRY,1,0,0,0,1,0,0,0,0,0,0,0, 'Windroc Matriarch - Start WP movement'),
(@ENTRY,0,1,0,1,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windroc Matriarch - On Spawn - Emote Text 0"),
(@ENTRY,0,2,0,40,0,100,0,3,@ENTRY,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windroc Matriarch - Load script 1 at WP 3"),
(@ENTRY,0,3,0,0,0,100,0,4000,4000,6000,6000,11,@SPELL_EAGLE_CLAW,0,0,0,0,0,2,0,0,0,0,0,0,0,"Windroc Matriarch - In Combat - Cast Eagle Claw"),
(@ENTRY,0,4,0,0,0,100,0,7000,8000,11000,14000,11,@SPELL_WING_BUFFET,0,0,0,0,0,2,0,0,0,0,0,0,0,"Windroc Matriarch - In Combat - Cast Wing Buffet"),
-- Script 1
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,54,1000000000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Windroc Matriarch - Script - Pause Path'),
(@ENTRY*100,9,1,0,0,0,100,1,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windroc Matriarch - On Script - Set Faction Aggressive"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,'Windroc Matriarch - Script - Remove unit_flag OOC_NOT_ATTACKABLE'),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,20,1,0,0,0,0,0,21,0,0,0,0,0,0,0,'Windroc Matriarch - Script - Attack Nearest Player');
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Emote blabla",16,0,100,0,0,0,"Windroc Matriarch");
-- Waypoints
DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY,1,-2422.512695,6910.643555,20.124718,'Windroc Matriarch WP 1'),
(@ENTRY,2,-2420.722168,6901.208008,15.225160,'Windroc Matriarch WP 2'),
(@ENTRY,3,-2400.643066,6887.521973,-1.384245,'Windroc Matriarch WP 3');

-- Kurenai Captive
UPDATE `creature_template` SET `ScriptName`='npc_kurenai_captive' WHERE `entry`=18209;
DELETE FROM `creature_template_addon` WHERE `entry`=18209;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (18209,0,0,8,0,0,''); -- Kneel
DELETE FROM `script_waypoint` WHERE `entry`=18209;
INSERT INTO `script_waypoint` (`entry`,`pointid`,`location_x`,`location_y`,`location_z`,`waittime`,`point_comment`) VALUES
(18209,1,-1518.593872,8469.956055,-4.101756,0,''),
(18209,2,-1511.784546,8480.531250,-4.033919,0,''),
(18209,3,-1513.447754,8509.764698,-0.109888,0,''),
(18209,4,-1498.857788,8508.805664,0.844676,0,''),
(18209,5,-1454.215088,8495.808594,4.912439,0,''),
(18209,6,-1437.483521,8504.165039,6.879123,0,''),
(18209,7,-1382.29,8539.87,11.139,7500,''),
(18209,8,-1361.22,8521.44,11.144,0,''),
(18209,9,-1324.8,8510.69,13.05,0,''),
(18209,10,-1312.08,8492.71,14.235,0,'');

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1000482 AND -1000488;
DELETE FROM `creature_text` WHERE `entry` IN (18209,18210);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
-- Maghar Captive
(18210,0,0,"Look out!",12,0,100,0,0,0,"Maghar Captive"),
(18210,1,0,"Don't let them escape! Kill the strong one first!",12,0,100,0,0,0,"Maghar Captive"),
(18210,2,0,"More of them are coming! Watch out!",12,0,100,0,0,0,"Maghar Captive"),
(18210,3,0,"Where do you think you're going? Kill them all!",12,0,100,0,0,0,"Maghar Captive"),
(18210,4,0,"Ride the lightning, filth!",12,0,100,0,0,0,"Maghar Captive"),
(18210,5,0,"FROST SHOCK!",14,0,100,0,0,0,"Maghar Captive"),
(18210,6,0,"It is best that we split up now, in case they send more after us. Hopefully one of us will make it back to Garrosh. Farewell, stranger.",12,0,100,0,0,0,"Maghar Captive"),
-- Kurenai Captive
(18209,0,0,"Look out!",12,0,100,0,0,0,"Kurenai Captive"),
(18209,1,0,"Don't let them escape! Kill the strong one first!",12,0,100,0,0,0,"Kurenai Captive"),
(18209,2,0,"More of them are coming! Watch out!",12,0,100,0,0,0,"Kurenai Captive"),
(18209,3,0,"Where do you think you're going? Kill them all!",12,0,100,0,0,0,"Kurenai Captive"),
(18209,4,0,"Ride the lightning, filth!",12,0,100,0,0,0,"Kurenai Captive"),
(18209,5,0,"FROST SHOCK!",14,0,100,0,0,0,"Kurenai Captive"),
(18209,6,0,"Up ahead is the road to Telaar. We will split up when we reach the fork as they will surely send more Murkblood after us. Hopefully one of us makes it back to Telaar alive.",14,0,100,0,0,0,"Kurenai Captive");

SET @ENTRY := 18428;
UPDATE `gameobject_template` SET `ScriptName`='go_warmaul_prison' WHERE `entry` IN (182484,182486,182487,182488,182489,182490,182491,182492,182493,182494,182495,182496,182497,182498,182499,182501,182502,182503,182504);
UPDATE `quest_template` SET `ReqSpellCast1`=0 WHERE `entry`=9948;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Death to the ogres!",12,0,100,0,0,0,"Mag'har Prisoner"),
(@ENTRY,1,1,"Many thanks, hero!",12,0,100,0,0,0,"Mag'har Prisoner"),
(@ENTRY,2,2,"One day, a hero will rise and lift the orcs up to their former glory.",12,0,100,0,0,0,"Mag'har Prisoner"),
(@ENTRY,3,3,"Spirits watch over you, $R!",12,0,100,0,0,0,"Mag'har Prisoner"),
(@ENTRY,4,4,"Thank you, $R! Your service to the Mag'har will not be forgotten.",12,0,100,0,0,0,"Mag'har Prisoner");

-- Spell Place Kil'sorrow Banner can not only be cast on Warmaul Ogres
DELETE FROM `conditions` WHERE `SourceEntry` IN (32314) AND `ConditionValue2` IN (17138,18064);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,32314,0,18,1,17138,0,0,'',"Spell Place Kil'sorrow Banner can not only be cast on Warmaul Ogres"), -- Warmaul Reaver
(13,0,32314,1,18,1,18064,0,0,'',"Spell Place Kil'sorrow Banner can not only be cast on Warmaul Ogres"); -- Warmaul Shaman

-- Ancient Orc Ancestor SAI
SET @ENTRY := 18688;
SET @SPELL_SOUL_MIRROR := 34063; -- Soul Mirror
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,8,0,100,0,@SPELL_SOUL_MIRROR,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Ancient Orc Ancestor - On Spellhit - Run Script"),
(@ENTRY,0,1,0,0,0,100,0,20000,40000,60000,180000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Ancient Orc Ancestor - Timed - Say Line (random)"),
(@ENTRY,0,2,0,6,0,100,0,0,0,0,0,12,19480,3,120000,0,0,0,1,0,0,0,0,0,0,0,"Ancient Orc Ancestor - On Death - Summon Darkened Spirit"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,"Ancient Orc Ancestor - Script - Say Line (random)"),
(@ENTRY*100,9,1,0,0,0,100,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ancient Orc Ancestor - Script - Evade"),
(@ENTRY*100,9,2,0,0,0,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ancient Orc Ancestor - Script - Prevent Combat Movement"),
(@ENTRY*100,9,3,0,0,0,100,0,2000,2000,0,0,37,19480,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ancient Orc Ancestor - Script - Die");
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Ancestors watch over you, kind one...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,0,1,"Cease your crying! STOP!",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,0,2,"I remember everything...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,0,3,"It cannot be...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,0,4,"It comes for you...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,0,"The spirits call... I am consumed.",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,1,"Cannot control... It draws me in... The void grows...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,2,"It is dying. It is dying. It is dying.",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,3,"The cold embrace awaits...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,4,"The pain is unbearable.",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,5,"What is happening to me?",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,6,"What is this trickery? I... ARGH...",12,0,100,21,0,0,"Ancient Orc Ancestor"),
(@ENTRY,1,7,"What will become of us when it falls?",12,0,100,21,0,0,"Ancient Orc Ancestor");

-- Voidwraith SAI
-- These are somehow summoned but can't find any info on sniffs or google..
SET @ENTRY := 18659;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=91,`faction_H`=91,`dmgschool`=5 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
UPDATE `creature` SET `MovementType`=0,`spawndist`=0 WHERE `id`=18662; -- Ancestors
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,12,19480,3,120000,0,0,0,1,0,0,0,0,0,0,0,"Voidwraith - On Death - Summon Darkened Spirit");

-- Darkened Spirit SAI
SET @ENTRY := 19480;
SET @SPELL_CONSUMING_SHADOWS := 31293; -- Consuming Shadows
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=91,`faction_H`=91,`dmgschool`=5 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,7000,11000,15000,11,@SPELL_CONSUMING_SHADOWS,0,0,0,0,0,2,0,0,0,0,0,0,0,"Darkened Spirit - In Combat - Cast Consuming Shadows"),
(@ENTRY,0,1,0,6,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Darkened Spirit - Force Despawn 5 Seconds After Death"),
(@ENTRY,0,2,0,1,0,100,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Darkened Spirit - Timed - Say Line");
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"What... What have I become? Arrrgghhh...",12,0,100,21,0,0,"Darkened Spirit");

-- Spell Soul Mirror can only be cast at Ancient Orc Spectator
DELETE FROM `conditions` WHERE `SourceEntry`=34063 AND `ConditionValue2`=18688;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,34063,0,18,1,18688,0,0,'',"Spell Soul Mirror can only be cast at Ancient Orc Spectator");

-- these still need waypoints and proper aura
DELETE FROM `creature` WHERE `id`=18688;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(66946,18688,530,1,1,0,0,-2225.73,8586.74,-10.361,0.261799,300,0,0,6542,0,0,0,0,0),
(66947,18688,530,1,1,0,0,-1452.95,8533.52,12.8692,3.33358,300,0,0,6542,0,0,0,0,0),
(14337,18688,530,1,1,0,0,-1637.01,8569.54,-12.3352,5.65003,300,0,0,6326,0,0,0,0,0),
(14338,18688,530,1,1,0,0,-2300.29,8571.08,-22.0957,5.65003,300,0,0,6326,0,0,0,0,0),
(14339,18688,530,1,1,0,0,-2407.95,8655.04,-19.7505,5.65003,300,0,0,6542,0,0,0,0,0),
(14340,18688,530,1,1,0,0,-2530.94,8629.31,-25.5884,5.65003,300,0,0,6326,0,0,0,0,0),
(14341,18688,530,1,1,0,0,-2571.84,8558.23,-33.6043,5.65003,300,0,0,6542,0,0,0,0,0),
(14342,18688,530,1,1,0,0,-2218.21,8513.48,-17.1368,5.65003,300,0,0,6542,0,0,0,0,0),
(14343,18688,530,1,1,0,0,-2114.42,8743.48,11.699,5.65003,300,0,0,6326,0,0,0,0,0),
(14977,18688,530,1,1,0,0,-2017.31,8743.44,19.5169,5.65003,300,0,0,6542,0,0,0,0,0),
(14978,18688,530,1,1,0,0,-1812.61,8813.18,30.2393,6.13478,300,0,0,6326,0,0,0,0,0),
(14979,18688,530,1,1,0,0,-1750.87,8877.25,31.67,6.13478,300,0,0,6326,0,0,0,0,0),
(14980,18688,530,1,1,0,0,-1539.61,8686.33,24.643,6.13478,300,0,0,6326,0,0,0,0,0),
(14981,18688,530,1,1,0,0,-1653.31,8494.49,-12.8156,6.13478,300,0,0,6542,0,0,0,0,0),
(14982,18688,530,1,1,0,0,-1579.32,8426.67,-9.33804,6.13478,300,0,0,6326,0,0,0,0,0),
(14983,18688,530,1,1,0,0,-1040.87,7895.8,22.8202,6.13478,300,0,0,6326,0,0,0,0,0),
(14984,18688,530,1,1,0,0,-1059.54,7750.35,25.8758,6.13478,300,0,0,6326,0,0,0,0,0),
(14985,18688,530,1,1,0,0,-908.965,7783.44,40.1036,6.13478,300,0,0,6326,0,0,0,0,0),
(20556,18688,530,1,1,0,0,-886.413,7824.75,40.0754,6.13478,300,0,0,6542,0,0,0,0,0),
(21776,18688,530,1,1,0,0,-878.863,7881.25,38.6467,6.13478,300,0,0,6326,0,0,0,0,0),
(23111,18688,530,1,1,0,0,-1866.27,8098.74,-20.3459,6.13478,300,0,0,6542,0,0,0,0,0),
(24670,18688,530,1,1,0,0,-2106.82,8191.13,-15.5604,6.13478,300,0,0,6542,0,0,0,0,0),
(24761,18688,530,1,1,0,0,-2084.75,8286.22,-11.4935,6.13478,300,0,0,6542,0,0,0,0,0),
(24794,18688,530,1,1,0,0,-2206.14,8306.9,-26.191,6.13478,300,0,0,6542,0,0,0,0,0),
(25100,18688,530,1,1,0,0,-2256,8478.68,-24.6155,6.13478,300,0,0,6542,0,0,0,0,0),
(26559,18688,530,1,1,0,0,-2336.12,8477.34,-30.3842,6.13478,300,0,0,6326,0,0,0,0,0),
(26564,18688,530,1,1,0,0,-2350.53,8641.59,-15.5674,6.13478,300,0,0,6326,0,0,0,0,0),
(31807,18688,530,1,1,0,0,-2379.14,8531.65,-28.7321,6.13478,300,0,0,6326,0,0,0,0,0),
(31833,18688,530,1,1,0,0,-2411.61,8492.45,-33.4541,6.13478,300,0,0,6542,0,0,0,0,0),
(32072,18688,530,1,1,0,0,-2416.02,8330.76,-37.6002,6.13478,300,0,0,6542,0,0,0,0,0),
(40475,18688,530,1,1,0,0,-2336.04,8288.74,-36.3567,1.72398,300,0,0,6326,0,0,0,0,0),
(40476,18688,530,1,1,0,0,-2336.11,8225.27,-35.7699,1.72398,300,0,0,6326,0,0,0,0,0),
(40703,18688,530,1,1,0,0,-2258.45,8221.08,-31.2193,3.93488,300,0,0,6326,0,0,0,0,0),
(40716,18688,530,1,1,0,0,-2203.79,8149.55,-25.1002,3.93488,300,0,0,6326,0,0,0,0,0),
(40725,18688,530,1,1,0,0,-2184.8,8029.08,-17.6373,3.93488,300,0,0,6542,0,0,0,0,0),
(40727,18688,530,1,1,0,0,-2297.12,7848.94,-30.4255,3.93488,300,0,0,6326,0,0,0,0,0),
(42893,18688,530,1,1,0,0,-2544.55,7818.57,-45.0012,3.93488,300,0,0,6326,0,0,0,0,0),
(45204,18688,530,1,1,0,0,-2555.36,7930.22,-55.675,3.93488,300,0,0,6542,0,0,0,0,0),
(46570,18688,530,1,1,0,0,-2622.32,7987.03,-48.9066,3.93488,300,0,0,6542,0,0,0,0,0),
(46819,18688,530,1,1,0,0,-2126.06,8148.39,-15.8518,3.93488,300,0,0,6326,0,0,0,0,0);

-- Quest 12860, 12927 "Data Mining"
SET @CREDIT := 29752;
SET @SPELL_CREDIT := 59728;
SET @SPELL := 55161;
SET @NPC := 29746;

UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=7 WHERE `entry`=@NPC;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@NPC AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC,0,0,1,8,0,100,0,@SPELL_CREDIT,0,0,0,33,@CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Databank Core - On spell Retrieve Data hit - Give kill credit for quest Data Mining'),
(@NPC,0,1,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Databank Core - On spell Retrieve Data hit - Despawn (Linked)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@SPELL;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@SPELL_CREDIT;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL_CREDIT;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,@SPELL,0,29,@NPC,20,0,0, '', 'Spell Retrieve Data will only be cast near Databank'),
(13,0,@SPELL,0,18,1,@NPC,0,0, '', 'Spell Retrieve Data does only target Databank');

-- Not the right-way™
-- Dummy effect with caster as target
DELETE FROM `spell_dbc` WHERE `id` IN (68308);
INSERT INTO `spell_dbc` (`Id`,`Effect1`,`EffectImplicitTargetA1`,`EffectImplicitTargetB1`,`comment`)
VALUES
(68308, 3, 1, 0, 'Vault of Archavon - Earth, Wind & Fire - Achievement Check');
