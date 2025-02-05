CREATE DEFINER=`root`@`localhost` PROCEDURE `comisiones_venta`
(in Area char, in Ventas_Actuales int, in Meta int)
BEGIN
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

END
