drop user if exists Cliente@localhost;
drop user if exists Repartidor@localhost;
drop user if exists Bodeguero@localhost;
drop user if exists Expendedor@localhost;
drop user if exists Dueño@localhost;
drop user if exists Otro@localhost;

select * from medicamento;
describe medicamento;
INSERT INTO persona VALUES ('859394021','Edgar','Ayala','22','6324354','Carrera 30 - Calle 45');
INSERT INTO persona VALUES ('465198788','Karen','Rodriguez','18','6580398','Carrera 30 - Calle 22');
INSERT INTO persona VALUES ('842276690','Emili','Torres','31','7038928','Carrera 15 - Calle 45');
INSERT INTO persona VALUES ('248504922','Santiago','Fernandez','25','7590236','Carrera 10 - Calle 33');
INSERT INTO persona VALUES ('101478935','Felipe','Ramirez','27','6543893','Carrera 100 - Calle 78');

INSERT INTO cliente VALUES ('465198788','5');
INSERT INTO cliente VALUES ('859394021','7');
INSERT INTO cliente VALUES ('842276690','2');

INSERT INTO cargo VALUES ('1','Expendedor','1000000');
INSERT INTO cargo VALUES ('2','Repartidor','600000');
INSERT INTO cargo VALUES ('3','otros','700000');

INSERT INTO empleado VALUES ('01','8-9','248504922','1');
INSERT INTO empleado VALUES ('02','9-10','101478935','2');

INSERT INTO laboratorio VALUES ('01','TecnoQuimicas','6758943','carrera 10 - calle 45');
INSERT INTO laboratorio VALUES ('02','MK','3425169','carrera 15 - calle 30');
INSERT INTO laboratorio VALUES ('03','Genfar','4569812','carrera 7 - calle 44');
INSERT INTO laboratorio VALUES ('04','La santé','8549375','carrera 1 - calle 112');
INSERT INTO laboratorio VALUES ('05','Ecar','4269587','carrera 4 - calle 94');



INSERT INTO proveedor VALUES ('01','Drogas La Rebaja','6778243');
INSERT INTO proveedor VALUES ('02','FarmaTodo','8732906');

INSERT INTO medicamento VALUES ('001','Aciclovir','1000','antiviral','A1','Tatar virus');
INSERT INTO medicamento VALUES ('002','Acetaminofen','1000','antipiretico','A2','Dolor y fiebre');
INSERT INTO medicamento VALUES ('003','Acido ascorbico','2000','Sirve para escorbuto','A3','Carencia de vitamina');
INSERT INTO medicamento VALUES ('004','Acido Folico','1500','Antianemico','A4','Tratar la anemia');
INSERT INTO medicamento VALUES ('005','Acido salicilico','2500','Antihistaminico','A5','Control Acne');
INSERT INTO medicamento VALUES ('006','Ácido Valpróico.','1700','Anticonvulsivante.','A6','Convulsiones e Hiperactividad');
INSERT INTO medicamento VALUES ('007','Airbron.','1600','Antiinflamatorio','A7','Pulmones,Bronquios');
INSERT INTO medicamento VALUES ('008','Albendazol.','2100','Antihelmíntico','A8','Pulmones,Bronquios');
INSERT INTO medicamento VALUES ('009','Alendronato','2500','Antiosteoporotico','A9','Osteoporosis');
INSERT INTO medicamento VALUES ('010','Alopurinol','3100','Antigotoso','A10','Acido úrico y control gota');
INSERT INTO medicamento VALUES ('011','Amantadina.','2600','Antiviral','A11','parkinson e influenza');

INSERT INTO medicamento VALUES ('002','Nimesulida','1000','','N1','');
INSERT INTO medicamento VALUES ('003','Meloxicam','1000','','M1','');
INSERT INTO medicamento VALUES ('004','Acetaminofen','1000','','A1','');
INSERT INTO medicamento VALUES ('005','Ibuprofeno','1000','','I1','');
INSERT INTO medicamento VALUES ('006','Aspirina','3000','','A2','');
INSERT INTO medicamento VALUES ('007','Congestex','1200','','C1','');


INSERT INTO producto VALUES ('001','Tetero','4500','Avent','T1');
INSERT INTO producto VALUES ('002','Pañal E0','600','Huggies','PH0');
INSERT INTO producto VALUES ('003','Pañal E1','600','Huggies','PH1');
INSERT INTO producto VALUES ('004','Pañal E2','600','Huggies','PH2');
INSERT INTO producto VALUES ('005','Pañal E3','600','Huggies','PH3');
INSERT INTO producto VALUES ('006','Condon','1500','Sens','C1');
INSERT INTO producto VALUES ('007','Condon','5000','Durex','C2');
INSERT INTO producto VALUES ('008','Condon','8900','Today','C3');
INSERT INTO producto VALUES ('009','Condon','7500','Duo','C4');
INSERT INTO producto VALUES ('010','Pañal E0','700','Pequeñin','PP0');
INSERT INTO producto VALUES ('011','Pañal E1','700','Pequeñin','PP1');
INSERT INTO producto VALUES ('012','Pañal E2','700','Pequeñin','PP2');
INSERT INTO producto VALUES ('013','Pañal E3','700','Pequeñin','PP3');

INSERT INTO composicion VALUES ('001','Acetaminofen');
INSERT INTO composicion VALUES ('002','Ibuprofeno');
INSERT INTO composicion VALUES ('003','Nimesulida');
INSERT INTO composicion VALUES ('004','Meloxicam');
INSERT INTO composicion VALUES ('005','Omeprazol');

/*INSERT INTO componer VALUES ('001','001');
INSERT INTO componer VALUES ('001','002');
INSERT INTO componer VALUES ('002','003');*/

/*INSERT INTO producir VALUES ('001','001');
INSERT INTO producir VALUES ('001','002');
INSERT INTO producir VALUES ('002','001');
INSERT INTO producir VALUES ('002','002');

INSERT INTO embodegar VALUES ('1','001','001');*/



CREATE USER 'Bodeguero'@'localhost' IDENTIFIED BY '1234';
GRANT INSERT ON drogueria . embodegar TO 'Bodeguero'@'localhost';
GRANT SELECT ON drogueria . cliente TO 'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . cargo TO 'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . empleado TO  'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . laboratorio TO 'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . proveedor TO 'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . medicamento TO 'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . producto TO  'Bodeguero'@'localhost';	GRANT SELECT ON drogueria . embodegar TO  'Bodeguero'@'localhost';
GRANT UPDATE ON drogueria . embodegar TO 'Bodeguero'@'localhost';

CREATE USER 'Expendedor'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON drogueria . persona TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . cliente TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . empleado TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . laboratorio TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . proveedor TO 'Expendedor'@'localhost'; 	GRANT SELECT ON drogueria . medicamento TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . producto TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . composicion TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . componer TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . producir TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . embodegar TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . venta_producto TO 'Expendedor'@'localhost';	GRANT SELECT ON drogueria . venta_medicamento TO 'Expendedor'@'localhost';

CREATE USER 'Dueño'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON drogueria . * TO 'Dueño'@'localhost';

CREATE USER 'Otro'@'localhost' IDENTIFIED BY '1234';
GRANT INSERT ON drogueria . masaje TO 'Otro'@'localhost'; GRANT SELECT ON drogueria . inyeccion TO 'Otro'@'localhost';	
GRANT SELECT ON drogueria . masaje TO 'Otro'@'localhost'; GRANT SELECT ON drogueria . inyeccion TO 'Otro'@'localhost';	GRANT SELECT ON drogueria . cliente TO 'Otro'@'localhost';
GRANT UPDATE ON drogueria . masaje TO 'Otro'@'localhost'; GRANT UPDATE ON drogueria . inyeccion TO 'Otro'@'localhost';

CREATE USER 'Repartidor'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON drogueria . persona TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . cliente TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . empleado TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . laboratorio TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . proveedor TO 'Repartidor'@'localhost'; 	GRANT SELECT ON drogueria . medicamento TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . producto TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . composicion TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . componer TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . producir TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . embodegar TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . venta_producto TO 'Repartidor'@'localhost';	GRANT SELECT ON drogueria . venta_medicamento TO 'Repartidor'@'localhost';

CREATE USER 'Cliente'@'localhost' IDENTIFIED BY '1234';
GRANT INSERT ON drogueria . reserva TO 'Cliente'@'localhost';	
GRANT SELECT ON drogueria . reserva TO 'Cliente'@'localhost';	GRANT INSERT ON drogueria . producto TO 'Cliente'@'localhost';	GRANT INSERT ON drogueria . medicamento TO 'Cliente'@'localhost';	GRANT INSERT ON drogueria . cliente TO 'Cliente'@'localhost';	GRANT INSERT ON drogueria . venta_medicamento TO 'Cliente'@'localhost';	GRANT INSERT ON drogueria . venta_producto TO 'Cliente'@'localhost';
GRANT UPDATE ON drogueria . reserva TO 'Cliente'@'localhost';