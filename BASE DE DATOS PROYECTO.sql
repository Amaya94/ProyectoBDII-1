DROP DATABASE IF EXISTS ProyectoFinal_2;
CREATE DATABASE ProyectoFinal_2 CHARACTER SET utf8mb4;
USE ProyectoFinal_2;

CREATE TABLE Supervisores (
  codigo_Supervisores INT  AUTO_INCREMENT PRIMARY KEY,
  Nombres_Supervisor VARCHAR(50) NOT NULL,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Telefono_Supervisor INT(10) NOT NULL,
  Area_Sup VARCHAR(50) NOT NULL,
  Meses_Laborados INT(10) NOT NULL,
  Estatus_Supervisores VARCHAR(20) NOT NULL
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE Ventas (
  codigo_ventas INT   PRIMARY KEY,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Sueldo INT(10) NOT NULL,
  Ventas_Actuales INT(10) NOT NULL,
  Meta INT(10) NOT NULL,
  Bonificacion INT(10) NOT NULL,
  Metas_No_Alcanzadas INT(5) NOT NULL,
  
  FOREIGN KEY (codigo_ventas) REFERENCES Supervisores (codigo_Supervisores)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE Pagos (
  codigo_pagos INT  PRIMARY KEY,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Sueldo_Base INT(10) NOT NULL,
  Bonificacion INT(10) NOT NULL,
  Comision FLOAT(10) NOT NULL,
  IGSS FLOAT(10) NOT NULL,
  ISR FLOAT(10) NOT NULL,
  IRTRA FLOAT(10) NOT NULL,
  Liquido_A_Recibir FLOAT(10) NOT NULL,
  
  FOREIGN KEY (codigo_pagos) REFERENCES Supervisores (codigo_Supervisores)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE Planilla (
  codigo_planilla INT  PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Sueldo_Base INT(10) NOT NULL,
  Bonificacion INT(10) NOT NULL,
  Comision FLOAT(10) NOT NULL,
  IGSS FLOAT(10) NOT NULL,
  ISR FLOAT(10) NOT NULL,
  IRTRA FLOAT(10) NOT NULL,
  Liquido_A_Recibir FLOAT(10) NOT NULL,
  
  FOREIGN KEY (codigo_planilla) REFERENCES Supervisores (codigo_Supervisores)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

INSERT INTO Supervisores VALUES ('28','DIEGO ANDRE','PEREZ SOSA','45986532','JARDINERIA','24','ALTA');
INSERT INTO Supervisores VALUES ('36','MARIA MERCEDEZ','ANTLLON LOPEZ','44356698','ELECTRONICOS','36','ALTA');
INSERT INTO Supervisores VALUES ('125','PABLO ANTONIO','MELENDEZ OSORIO','33552698','FERRETERIA','26','ALTA');
INSERT INTO Supervisores VALUES ('98','SILVIA LORENA','CASTILLO ARMAS','56552365','JARDINERIA','40','ALTA');
INSERT INTO Supervisores VALUES ('235','JOSE ANTONIO','PALACIOS ORDOÑEZ','41425698','ELECTRONICOS','48','ALTA');

INSERT INTO Ventas VALUES ('28','PEREZ SOSA','3200','8700','1000','250','0');
INSERT INTO Ventas VALUES ('36','ANTILLON PEREZ','4000','12500','5000','250','0');
INSERT INTO Ventas VALUES ('125','MELENDEZ OSORIO','3500','7500','3000','250','0');
INSERT INTO Ventas VALUES ('98','CASTILLO ARMAS','3200','4200','1000','250','1');
INSERT INTO Ventas VALUES ('235','PALACIOS ORDOÑEZ','4000','18500','5000','250','0');

INSERT INTO Pagos VALUES ('28','PEREZ SOSA','3200','250','0','0','0','0','0');
INSERT INTO Pagos VALUES ('36','ANTILLON PEREZ','4000','250','0','0','0','0','0');
INSERT INTO Pagos VALUES ('125','MELENDEZ OSORIO','3500','250','0','0','0','0','0');
INSERT INTO Pagos VALUES ('98','CASTILLO ARMAS','3200','250','0','0','0','0','0');
INSERT INTO Pagos VALUES ('235','PALACIOS ORDOÑEZ','3200','250','0','0','0','0','0');

SELECT * FROM Pagos;


USE `proyectofinal_2`;
DROP procedure IF EXISTS `calculo_comisiones`;

DELIMITER $$
USE `proyectofinal_2`$$
CREATE PROCEDURE `calculo_comisiones` (IN codigo_pagos INT)
BEGIN	
	DECLARE SueldoT, VentasAT, MetaT, BonificacionT, MTNA, ComisionT FLOAT;
    DECLARE Tot_Desc, IGSST, IRTRAT, ISRT, Liquido FLOAT;
    DECLARE AreaT VARCHAR(100);
    DECLARE contador_supervisor INT;
    CREATE TEMPORARY TABLE IF NOT EXISTS Supervisores_temporary AS (SELECT * FROM Supervisores);
    CREATE TEMPORARY TABLE IF NOT EXISTS ventas_temporary AS (SELECT * FROM ventas);
	CREATE TEMPORARY TABLE IF NOT EXISTS pagos_temporary AS (SELECT * FROM pagos);
    
	/*SELECT Sueldo, Ventas_Actuales, Meta, Bonificacion, Metas_No_Alcanzadas 
	INTO SueldoT, VentasAT, MetaT, BonificacionT, MTNA FROM ventas;
	
    SELECT Area_Sup INTO AreaT FROM supervisores;*/
    
	SELECT COUNT(1) INTO contador_supervisor FROM Supervisores_temporary;
		
	IF LOWER(AreaT) = 'JARDINERIA' THEN
		IF Ventas_Actuales >= 1000 AND Ventas_Actuales <3000 THEN
			SET ComisionT = 100;
	    ELSEIF Ventas_Actuales  >= 3001 AND Ventas_Actuales <5000 THEN
			SET ComisionT = 300;
		ELSEIF Ventas_Actuales >= 5001 AND Ventas_Actuales <8000 THEN
			SET ComisionT = 500;
		ELSEIF Ventas_Actuales >= 8001 AND Ventas_Actuales <10000 THEN
			SET ComisionT = 700;
		ELSEIF Ventas_Actuales >= 10001 THEN
			SET ComisionT = 1000;
		END IF;
		
        SET IGSST = Sueldo * 0.0487;
		SET IRTRAT = Sueldo * 0.01;
		SET ISRT = Sueldo * 0.01;
		SET Tot_Desc = IGSST+IRTRAT+ISRT;
        
        IF Metas_No_Alcanzadas = 0 THEN
			SET Liquido = (SueldoT - Tot_Desc) + ComisionT + BonificacionT;
		ELSEIF Metas_No_Alcanzadas = 1 THEN
			SET Liquido = (SueldoT - Tot_Desc) + BonificacionT;
		ELSEIF Metas_No_Alcanzadas = 2 THEN
			SET Liquido = 0;
		ELSEIF Metas_No_Alcanzadas >= 3 THEN
			SET Liquido = 0;
		ELSEIF Metas_No_Alcanzadas >= 3 THEN
			UPDATE Supervisores SET Estatus_Supervisores = 'BAJA' WHERE codigo_Supervisores = codigo_pagos ;
		END IF;
		
        IF (codigo_Supervisores = codigo_ventas) THEN 
        UPDATE Pagos SET Comision = ComisionT, IGSS = IGSST, ISR = ISRT, IRTRA = IRTRAT, 
        Liquido_A_Recibir = Liquido WHERE codigo_Pagos = codigo_pagos;
		END IF;
        
	END IF;
    	
END$$
DELIMITER ;
call proyectofinal_2.calculo_comisiones(28);
SELECT * FROM pagos;
