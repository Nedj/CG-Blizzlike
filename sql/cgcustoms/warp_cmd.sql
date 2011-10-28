DELETE FROM `command` WHERE `name` = 'warp';

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('warp', 3, 'Syntax: .warp $dir #value\r\n\r\nTeleport in the direction indicated by dir (f=forward,b=backward,u=up,d=down) by the number of coordinate units specified as value.');