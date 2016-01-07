update importproduct set sizeid = 130 where sizeid = 194;
delete from size where sizeid = 194;

update importproduct set sizeid = 127 where sizeid = 193;
delete from size where sizeid = 193;

update importproduct set sizeid = 129 where sizeid = 196;
delete from size where sizeid = 196;

ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `ReduceCost` DOUBLE NULL;


ALTER TABLE `tpkwhm`.`province` DROP FOREIGN KEY `FK_Province_Region` ;
ALTER TABLE `tpkwhm`.`province` CHANGE COLUMN `RegionID` `RegionID` BIGINT(20) NULL DEFAULT NULL  ,
  ADD CONSTRAINT `FK_Province_Region`
  FOREIGN KEY (`RegionID` )
  REFERENCES `tpkwhm`.`region` (`RegionID` )
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

