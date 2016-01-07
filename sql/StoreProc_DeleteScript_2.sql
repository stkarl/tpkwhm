DELIMITER //

START TRANSACTION//

DROP PROCEDURE IF EXISTS `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`//
CREATE PROCEDURE `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`()
BEGIN
	DECLARE varOutletAuditResultDistinctID, varFullRangeID BIGINT;
	DECLARE stopIndex4,stopIndex5, varFacing, varRatio, varOutletBrandID INT;
	DECLARE varSummaryBrand1, varSummaryBrand2 DOUBLE;

	DECLARE cur_ CURSOR FOR
	SELECT DISTINCT(r1.OutletAuditResultID) FROM FCVAuditData.temp_tb__ r1;
DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET stopIndex4 = 1;
SET stopIndex4 = 0;
OPEN cur_;
	REPEAT
		FETCH cur_ INTO varOutletAuditResultDistinctID;
		IF stopIndex4 != 1 THEN
		BEGIN
			-- Select list oarfullrangeSKU
				DECLARE cur_OARFullRangeSKU CURSOR FOR
				SELECT r1.FullRangeID, r1.Facing FROM FCVAuditData.temp_tb__ r1 WHERE r1.OutletAuditResultID = varOutletAuditResultDistinctID;
			DECLARE CONTINUE HANDLER FOR NOT FOUND
				SET stopIndex5 = 1;
			SET stopIndex5 = 0;
			SET varSummaryBrand1 = 0;
			SET varSummaryBrand2 = 0;
			-- find ratio, summaryfacing
			OPEN cur_OARFullRangeSKU;
				REPEAT
					FETCH cur_OARFullRangeSKU INTO varFullRangeID, varFacing;
					SELECT f.OutletBrandID, f.Ratio INTO varOutletBrandID, varRatio  FROM FullRangeSKU f WHERE FullRangeSKUID = 	varFullRangeID;
					IF stopIndex5 != 1 THEN
					BEGIN
						IF varOutletBrandID = 1 THEN
						BEGIN
								SET varSummaryBrand1 = varSummaryBrand1 + 1.0*(varFacing/varRatio);
						END;
						END IF;

						IF varOutletBrandID = 2 THEN
						BEGIN
								SET varSummaryBrand2 = varSummaryBrand2 + 1.0*(varFacing/varRatio);
						END;
						END IF;

					END;
					END IF;
				UNTIL stopIndex5 = 1
			END REPEAT;
			CLOSE cur_OARFullRangeSKU;

			Update OARNofacing Set Facing = varSummaryBrand1 WHERE OutletAuditResultID = varOutletAuditResultDistinctID AND OutletBrandID = 1;
			Update OARNofacing Set Facing = varSummaryBrand2 WHERE OutletAuditResultID = varOutletAuditResultDistinctID AND OutletBrandID = 2;

			-- Update OarNoFacing onf Set onf.Facing = onf.Facing/2
			-- where OutletAuditResultID = varOutletAuditResultDistinctID;
		END;
		END IF;
	UNTIL stopIndex4 = 1
END REPEAT;
CLOSE cur_;

DROP table temp_tb__;

END //
CALL `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`()//
DROP PROCEDURE `FCVAuditData`.`DeleteDuplicateOARFullRangeSKU`//

COMMIT//

DELIMITER ;