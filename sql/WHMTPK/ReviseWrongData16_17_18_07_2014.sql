Update importmaterial set remainquantity = 60  where importmaterialid = 3010;
Update importmaterial set remainquantity = 60  where importmaterialid = 3012;
Update importmaterial set remainquantity = 180  where importmaterialid = 3017;
Update importmaterial set remainquantity = 570  where importmaterialid = 3020;
Update importmaterial set remainquantity = 1177  where importmaterialid = 3029;
Update importmaterial set remainquantity = 620  where importmaterialid = 3041;
Update importmaterial set remainquantity = 115  where importmaterialid = 3045;
Update importmaterial set remainquantity = 2690  where importmaterialid = 3048;
Update importmaterial set remainquantity = 1560  where importmaterialid = 3056;
Update importmaterial set remainquantity = 2525  where importmaterialid = 4497;
Update importmaterial set remainquantity = 940  where importmaterialid = 4507;
Update importmaterial set remainquantity = 630  where importmaterialid = 4510;
Update importmaterial set remainquantity = 720  where importmaterialid = 4514;
Update importmaterial set remainquantity = 356  where importmaterialid = 4516;
Update importmaterial set remainquantity = 825  where importmaterialid = 4518;
Update importmaterial set remainquantity = 470  where importmaterialid = 4519;
Update importmaterial set remainquantity = 1980  where importmaterialid = 4520;
Update importmaterial set remainquantity = 3240  where importmaterialid = 4522;
Update importmaterial set remainquantity = 7  where importmaterialid = 4523;
Update importmaterial set remainquantity = 0.2  where importmaterialid = 4524;
Update importmaterial set remainquantity = 280  where importmaterialid = 4525;
Update importmaterial set remainquantity = 555  where importmaterialid = 4528;
Update importmaterial set remainquantity = 1530  where importmaterialid = 4529;
Update importmaterial set remainquantity = 210  where importmaterialid = 4530;
Update importmaterial set remainquantity = 50  where importmaterialid = 4536;
Update importmaterial set remainquantity = 5  where importmaterialid = 4537;
Update importmaterial set remainquantity = 10  where importmaterialid = 4540;
Update importmaterial set remainquantity = 1420  where importmaterialid = 4541;
Update importmaterial set remainquantity = 1050  where importmaterialid = 4542;
Update importmaterial set remainquantity = 1860  where importmaterialid = 4545;
Update importmaterial set remainquantity = 1325  where importmaterialid = 4548;
Update importmaterial set remainquantity = 340  where importmaterialid = 4549;
Update importmaterial set remainquantity = 1610  where importmaterialid = 4554;
Update importmaterial set remainquantity = 714  where importmaterialid = 4555;


Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3014;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3015;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3018;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3019;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3030;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3035;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3036;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3037;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3038;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3040;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3044;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3046;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3050;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3051;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 3057;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4511;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4512;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4513;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4526;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4533;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4534;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4546;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4547;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4552;
Update importmaterial set status = 2, remainquantity = 0  where importmaterialid = 4553;

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='200' WHERE `ImportMaterialID`='4520';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4520', `Previous`='0' WHERE `ExportMaterialID`='349';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4520', `Previous`='0' WHERE `ExportMaterialID`='339';
UPDATE `tpkwhm`.`exportmaterial` SET `Previous`='0' WHERE `ExportMaterialID`='328';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='60' WHERE `ImportMaterialID`='4518';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4518', `Previous`='825' WHERE `ExportMaterialID`='315';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4518', `Previous`='705' WHERE `ExportMaterialID`='326';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4518', `Previous`='585' WHERE `ExportMaterialID`='337';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4518', `Previous`='225' WHERE `ExportMaterialID`='347';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='2700' WHERE `ImportMaterialID`='4515';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4515', `Previous`='2700' WHERE `ExportMaterialID`='350';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4515', `Previous`='0' WHERE `ExportMaterialID`='276';


UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='1740' WHERE `ImportMaterialID`='4527';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4527', `Previous`='2000' WHERE `ExportMaterialID`='318';


UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='2' WHERE `ImportMaterialID`='4540';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4540', `Previous`='10' WHERE `ExportMaterialID`='322';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4540', `Previous`='6' WHERE `ExportMaterialID`='343';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='96.5' WHERE `ImportMaterialID`='4498';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4498' WHERE `ExportMaterialID`='450';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4498' WHERE `ExportMaterialID`='438';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='2' WHERE `ImportMaterialID`='4523';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4523', `Previous`='7' WHERE `ExportMaterialID`='333';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4523', `Previous`='5' WHERE `ExportMaterialID`='351';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='70' WHERE `ImportMaterialID`='4508';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4508' WHERE `ExportMaterialID`='379';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='2930' WHERE `ImportMaterialID`='4522';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='980' WHERE `ImportMaterialID`='4548';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4548' WHERE `ExportMaterialID`='405';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4548' WHERE `ExportMaterialID`='421';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='0', `Status`='2' WHERE `ImportMaterialID`='4545';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4545', `Previous`='0' WHERE `ExportMaterialID`='417';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4545', `Previous`='0' WHERE `ExportMaterialID`='422';
UPDATE `tpkwhm`.`exportmaterial` SET `Previous`='0' WHERE `ExportMaterialID`='429';

UPDATE `tpkwhm`.`importmaterial` SET `RemainQuantity`='0', `Status`='2' WHERE `ImportMaterialID`='4524';

UPDATE `tpkwhm`.`exportmaterial` SET `Previous`='0.2' WHERE `ExportMaterialID`='243';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4524', `Previous`='0' WHERE `ExportMaterialID`='312';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4524', `Previous`='0' WHERE `ExportMaterialID`='323';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4524', `Previous`='0' WHERE `ExportMaterialID`='334';
UPDATE `tpkwhm`.`exportmaterial` SET `ImportMaterialID`='4524', `Previous`='0' WHERE `ExportMaterialID`='344';

/* can doi so lieu sai trong 3 ngay 16,17,18/07/2014
Bao tay  materialid = 57 xuat nhieu` hon co' 1,5kg -> ko co de tru`, sau nay nhap ve thi tru sau
Sơn lót vàng mặt trên materialid = 33 xuat nhieu hon co 335kg, - > ko co de tru`, sau nay nhap ve thi tru sau.
 */


update importproduct set status = 2 where importproductid in (
  Select importproductid from exportproduct where exportproductbillid in
                                                  (select exportproductbillid from exportproductbill
                                                  where confirmedby is not null  and status = 2 and exporttypeid = 4));


update importproduct set sizeid = 165 where sizeid = 159;
delete from size where sizeid not in (
  select distinct sizeid from importproduct);













