
DROP DATABASE IF EXISTS ProyectoFinal_2;
CREATE DATABASE ProyectoFinal_2 CHARACTER SET utf8mb4;
USE ProyectoFinal_2;

CREATE TABLE Supervisores (
  codigo_Supervisores INT  AUTO_INCREMENT PRIMARY KEY,
  Nombres_Supervisor VARCHAR(50) NOT NULL,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Telefono_Supervisor INT(10) NOT NULL,
  Area VARCHAR(50) NOT NULL,
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
DROP procedure IF EXISTS `calc_comisiones`;

DELIMITER $$
USE `proyectofinal_2`$$
CREATE PROCEDURE `calc_comisiones` ()
BEGIN
	DECLARE Tot_Desc FLOAT;
    DECLARE Comision INT;
    DECLARE IGSS, IRTRA, ISR, Liquido_A_Recibir FLOAT;
    
	SELECT Apellidos_Supervisor, Sueldo, Bonificacion, codigo_ventas FROM Ventas;
    SELECT Area, Estatus_Supervisores, codigo_Supervisores FROM Supervisores;
    SELECT Ventas_Actuales, Metas_No_Alcanzadas FROM Ventas;
    
    IF @Area = 'JARDINERIA' THEN
		IF @Ventas_Actuales >= 1000 AND @Ventas_Actuales <3000 THEN
			SET Comision = 100;
		END IF;
		IF @Ventas_Actuales >= 3001 AND @Ventas_Actuales <5000 THEN
			SET Comision = 300;
		END IF;
		IF @Ventas_Actuales >= 5001 AND @Ventas_Actuales <8000 THEN
			SET Comision = 500;
		END IF;
        IF @Ventas_Actuales >= 8001 AND @Ventas_Actuales <10000 THEN
			SET Comision = 700;
		END IF;
        IF @Ventas_Actuales >= 10001 THEN
			SET Comision = 1000;
		END IF;
		SET IGSS = Sueldo * 0.0487;
        SET IRTRA = Sueldo * 0.01;
        SET ISR = Sueldo * 0.01;
        SET Tot_Desc = IGSS+IRTRA+ISR;
        
        IF @Metas_No_Alcanzadas = 0 THEN
			SET Liquido_A_Recibir = (Sueldo_Base - Tot_Desc) + Comision + Bonificacion;
		END IF;
        IF @Metas_No_Alcanzadas = 1 THEN
			SET Liquido_A_Recibir = (Sueldo_Base - Tot_Desc) + Bonificacion;
		END IF;
        IF @Metas_No_Alcanzadas = 2 THEN
			SET Liquido_A_Recibir = 0;
		END IF;
        IF @Metas_No_Alcanzadas >= 3 THEN
			SET Liquido_A_Recibir = 0;
		END IF;

		IF @Metas_No_Alcanzadas >= 3 THEN
			UPDATE Supervisores
            SET Estatus_Supervisores = 'BAJA'
            WHERE codigo_Supervisores = codigo_pagos ;
		END IF;
        
        IF @codigo_pagos = @codigo_Supervisores THEN
			UPDATE Pagos
			SET Comision = @comision;
			SET IGSS = @IGSS;
			SET ISR = @ISR;
			SET IRTRA = @IRTRA;
			SET Liquido_A_Recibir = @Liquido_A_Recibir;
			/*WHERE codigo_Pagos = codigo_Supervisores;*/
		END IF;
        END IF;
END$$

DELIMITER ;

CALL calc_comisiones;
