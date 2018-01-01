ALTER TABLE `tpkwhm`.`bookproductbill` ADD COLUMN `BankAccount` TEXT NULL DEFAULT NULL;

ALTER TABLE setting CONVERT TO CHARACTER SET utf8;
INSERT INTO `tpkwhm`.`setting`
(`FieldName`, `FieldValue`)
VALUES ('default.bank.account', 'Công ty CP TM & SX Tôn Tân Phước Khanh \n \t STK: 0600.28474.574 tại Ngân hàng Sacombank - PGD Lạc Hồng - TPHCM');


