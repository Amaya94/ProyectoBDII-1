CREATE DEFINER=`root`@`localhost` PROCEDURE `promedio_venta`(in promedio int, in supervisor float, in meta int)
BEGIN
/*Hay un mínimo de promedios de ventas mensuales que debe cumplir cada supervisor de área. 
Obviamente, este promedio mínimo varía según el área que supervisa. */

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