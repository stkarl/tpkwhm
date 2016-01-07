ALTER TABLE `tpkwhm`.`importproduct`
DROP INDEX `Import_Product_Origin_UNIQUE`
, ADD UNIQUE INDEX `Import_Product_Origin_UNIQUE` (`ProductCode` ASC) ;


UPDATE `tpkwhm`.`materialcategory` SET `Name`='Ghi chỉ số từ đồng hồ đo sản xuất lạnh', `Code`='MEASURELANH' WHERE `MaterialCategoryID`='2';
INSERT INTO `tpkwhm`.`materialcategory` (`MaterialCategoryID`, `Name`, `Code`, `Description`) VALUES ('11', 'Ghi chỉ số từ đồng hồ đo sản xuất màu', 'MEASUREMAU', 'Điện, nước, gas, Khí N2, Khí H2');
