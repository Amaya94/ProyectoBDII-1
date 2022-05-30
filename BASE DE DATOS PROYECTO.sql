
DROP DATABASE IF EXISTS ProyectoFinal_2;
CREATE DATABASE ProyectoFinal_2 CHARACTER SET utf8mb4;
USE ProyectoFinal_2;

CREATE TABLE Supervisores (
  codigo_Supervisores INT  AUTO_INCREMENT PRIMARY KEY,
  Nombres_Supervisor VARCHAR(50) NOT NULL,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Telefono_Supervisor INT(10) NOT NULL,
  Area_Supervisor VARCHAR(50) NOT NULL,
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

USE `proyectofinal_2`;
DROP procedure IF EXISTS `calc_comisiones`;

USE `proyectofinal_2`;
DROP procedure IF EXISTS `calc_comisiones`;


USE `proyectofinal_2`;
DROP procedure IF EXISTS `comisiones_supervisores`;

-- --------------------------------------------------------------------------------------------




