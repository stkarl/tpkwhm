use FCVAuditData;

-- Init admin user
INSERT INTO User(`UserID`, `UserName`, `Password`, `Fullname`, `Email`, `Status`, `Role`) VALUES(1, 'admin', 'FmMBvO967Ew=', 'Administrator', 'vien.nguyen@banvien.com', 1, 'ADMIN');

-- Outlet Brand
INSERT INTO OutletBrand(`OutletBrandID`, `Name`) VALUES(1, 'Friso');
INSERT INTO OutletBrand(`OutletBrandID`, `Name`) VALUES(2, 'Dutch Lady IFT');

-- Promotion Type
INSERT INTO PromotionType(`PromotionTypeID`, `Type`) VALUES(1, 'Discount');
INSERT INTO PromotionType(`PromotionTypeID`, `Type`) VALUES(2, 'Rebate');
INSERT INTO PromotionType(`PromotionTypeID`, `Type`) VALUES(3, 'Display');
INSERT INTO PromotionType(`PromotionTypeID`, `Type`) VALUES(4, 'Mix');

-- Unit
INSERT INTO Unit(`UnitID`, `Unit`) VALUES(1, 'Thùng');
INSERT INTO Unit(`UnitID`, `Unit`) VALUES(2, 'Hộp/Lon');
INSERT INTO Unit(`UnitID`, `Unit`) VALUES(3, 'VND');

-- Brand Group
INSERT INTO BrandGroup(`BrandGroupID`, `Code`, `Name`) VALUES(1, 'IFT', 'Ngành hàng sữa bột');
INSERT INTO BrandGroup(`BrandGroupID`, `Code`, `Name`) VALUES(2, 'DBB', 'Ngành hàng sữa nước');


