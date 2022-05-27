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
  codigo_venta INT   PRIMARY KEY,
  Apellidos_Supervisor VARCHAR(50) NOT NULL,
  Sueldo INT(10) NOT NULL,
  Ventas_Actuales INT(10) NOT NULL,
  Meta INT(10) NOT NULL,
  Bonificacion INT(10) NOT NULL,
  Metas_No_Alcanzadas INT(5) NOT NULL,
  
  FOREIGN KEY (codigo_venta) REFERENCES Supervisores (codigo_Supervisores)
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











/*------------------------STORED PROCEDURES----------------------------------------------*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `promedio_venta`
(in promedio int, in supervisor float, in meta int)
BEGIN
/*Hay un mínimo de promedios de ventas mensuales que debe cumplir cada supervisor de área. 
Obviamente, este promedio mínimo varía según el área que supervisa. */
/*
   DECLARE jardineria int;
   DECLARE electronicos int;
   DECLARE ferreteria int;
   DECLARE supervisor int;
   DECLARE descuento float;
   DECLARE IRTRA float;
   DECLARE ISR float;
   DECLARE IGSS float;
   DECLARE total float;
   DECLARE subtotal float;
   SET subtotal=supervisor;
	/*
   IF jardineria >= 3000 THEN
      SELECT cliente_id FROM pedidos WHERE pedido_id=numpedido INTO cliente;
      SET descuento=tot_factura*0.10;
      SET subtotal=tot_factura-descuento;
   END IF;
   SET IVA=subtotal*0.12;
   SET Total=subtotal+IVA;
   INSERT INTO factura VALUES (numfact, numpedido, cliente, subtotal, IVA, total);
   UPDATE pedidos set Status=1 WHERE pedido_id=numpedido;
   SELECT * FROM factura;
   SELECT * FROM pedidos;
*/
END
