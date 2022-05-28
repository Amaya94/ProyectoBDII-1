
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

/*
CREATE DEFINER=`root`@`localhost` PROCEDURE `comisiones_venta`
(in Area char, in Ventas_Actuales int, in Meta int)
BEGIN
/*
   DECLARE IRTRA float;
   DECLARE ISR float;
   DECLARE IGSS float;
   DECLARE comision int;
   DECLARE total float;
   DECLARE tot_desc float;

	
   IF Area = "jardineria" THEN
      SELECT codigo_ventas FROM Ventas WHERE codigo_ventas=codigo_Supervisores INTO Supervisores;
      
	IF Ventas_Actuales < 1000 THEN
      SET comision = 0;
    END IF;  
	IF Ventas_Actuales >1000 && Ventas_Actuales <= 3000 THEN
      SET comision = 100;
    END IF;  
	IF Ventas_Actuales >3001 && Ventas_Actuales <= 5000 THEN
      SET comision = 300;
    END IF;  
	IF Ventas_Actuales >5001 && Ventas_Actuales <= 8000 THEN
      SET comision = 500;
    END IF;  
	IF Ventas_Actuales >8001 && Ventas_Actuales <= 10000 THEN
      SET comision = 700;
    END IF;  
    IF Ventas_Actuales >10001  THEN
      SET comision = 1000;
    END IF;
    
	SET IGSS =  Sueldo_Base  * 0.0487;
    SET ISR = Sueldo_Base * 0.05;
    SET IRTRA = Sueldo_Base * 0.01;
    SET tot_desc = IGSS + ISR + IRTRA;
    
    IF Metas_No_Alcanzadas = 0 THEN
	 SET total = (Sueldo_Base - tot_desc) + comision + Bonificacion;
    END IF;
    IF Metas_No_Alcanzadas = 1 THEN
	 SET total = (Sueldo_Base - tot_desc)  + Bonificacion;
    END IF; 
    IF Metas_No_Alcanzadas = 2 THEN
	 SET total = 0;
	END IF;
    IF Metas_No_Alcanzadas >= 3 THEN
	 SET total = 0;
	END IF;
     
	UPDATE Supervisores SET Estatus_Supervisores = "BAJA" ;
	INSERT INTO Pagos VALUES (codigo_ventas,Apellidos_Supervisor,Sueldo,Bonificacion,comision,IGSS,ISR,IRTRA,total);
   END IF;
   
   /*SET IVA=subtotal*0.12;
   SET Total=subtotal+IVA;
   INSERT INTO factura VALUES (numfact, numpedido, cliente, subtotal, IVA, total);
   UPDATE pedidos set Status=1 WHERE pedido_id=numpedido;
   SELECT * FROM factura;
   SELECT * FROM pedidos;*/
/*
END
*/