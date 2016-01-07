update materialandcategory set materialcategoryid = 6 where materialcategoryid = 3;
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='3';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='11';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='20';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='21';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='48';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='97';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='66';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='70';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='68';
DELETE FROM `tpkwhm`.`materialcategory` WHERE `MaterialCategoryID`='3';

DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='63';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='53';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='58';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='35';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='39';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='102';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='90';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='94';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='64';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='54';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='59';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='84';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='103';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='73';

DELETE FROM `tpkwhm`.`materialcategory` WHERE `MaterialCategoryID`='9';
DELETE FROM `tpkwhm`.`materialcategory` WHERE `MaterialCategoryID`='10';

INSERT INTO `tpkwhm`.`materialcategory` (`MaterialCategoryID`, `Name`, `Code`, `Description`) VALUES ('3', '3', '3', '3');


CREATE TEMPORARY TABLE tmp SELECT * FROM materialandcategory WHERE materialcategoryid = 1;
UPDATE tmp SET materialcategoryid = 3 where 1 = 1;
UPDATE tmp SET materialandcategoryid = materialandcategoryid + 200 where 1 = 1;
INSERT INTO materialandcategory SELECT * FROM tmp;
drop table tmp;

update materialandcategory set materialcategoryid = 7 where materialcategoryid = 1;
update materialandcategory set materialcategoryid = 8 where materialcategoryid = 3;

DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='1';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='4';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='9';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='28';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='24';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='65';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='32';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='36';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='96';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='87';
DELETE FROM `tpkwhm`.`usermaterialcate` WHERE `UserMaterialCateID`='91';
DELETE FROM `tpkwhm`.`materialcategory` WHERE `MaterialCategoryID`='1';
DELETE FROM `tpkwhm`.`materialcategory` WHERE `MaterialCategoryID`='3';

-- Hóa chất UNICOH  BR-0808

