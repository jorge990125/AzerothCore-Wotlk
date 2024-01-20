-- DB update 2021_09_23_00 -> 2021_09_23_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_23_00 2021_09_23_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632158215060703500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632158215060703500');

DELETE FROM `creature_loot_template` WHERE `Entry` IN (2640, 4442, 6514, 6527, 8299, 9318, 9416, 10419, 11456, 11462) AND `Item` = 9197;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_23_01' WHERE sql_rev = '1632158215060703500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;