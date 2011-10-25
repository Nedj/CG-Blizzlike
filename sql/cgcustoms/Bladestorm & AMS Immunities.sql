DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (46924, 48707);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('46924', '-13810', '2', 'Bladestorm immune at Frost Trap'),
('46924', '-51514', '2', 'Bladestorm immune at Hex'),
('46924', '-116', '2', 'Bladestorm immune at FrostBolt'),
('46924', '-45524', '2', 'Bladestorm immune at Chains of Ice'),
('46924', '-68766', '2', 'Bladestorm immune at Desecration'),
('46924', '-8643', '2', 'Bladestorm immune at Kidney Shot'),
('46924', '-58617', '2', 'Bladestorm immune at Glyph of Heart Strike'),
('48707', '-33786', '2', 'AMS Immune to Cyclone'),
('48707', '-51514', '2', 'AMS Immune to Hex');
