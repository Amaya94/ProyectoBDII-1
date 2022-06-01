CREATE DEFINER=`root`@`localhost` PROCEDURE `comisiones_supervisores`()
BEGIN

  DECLARE Tot_Desc INTEGER;
  DECLARE Comision INTEGER;
  DECLARE Supervisores VARCHAR(255);
  DECLARE var_Metas_No_Alcanzadas INT;
  DECLARE var_Ventas_Actuales INT;
  DECLARE var_codigo_Supervisores INT;
  DECLARE var_Bonificacion int;
  DECLARE IGSS, IRTRA, ISR, Liquido_A_Recibir FLOAT;

  DECLARE cursor1 CURSOR FOR SELECT Apellidos_Supervisor, Sueldo, Bonificacion, codigo_ventas FROM Ventas;
  DECLARE cursor2 CURSOR FOR SELECT Area_Supervisor, Estatus_Supervisores, codigo_Supervisores FROM Supervisores;
  DECLARE cursor3 CURSOR FOR SELECT codigo_Supervisores, Bonificacion, Ventas_Actuales, Metas_No_Alcanzadas FROM Ventas;
  
  OPEN cursor3;
  bucle: LOOP

    FETCH cursor3 INTO var_codigo_Supervisores, var_Bonificacion, var_Metas_No_Alcanzadas, var_Ventas_Actuales ;

    SELECT
     var_Ventas_Actuales AS 'Ventas_Actuales',
	 var_Metas_No_Alcanzadas AS 'Metas_No_Alcanzadas',
	 var_codigo_Supervisores AS 'codigo_Supervisores',
	 var_Bonificacion AS 'Bonificacion'
	 FROM Ventas WHERE Sueldo = Bonificacion;


  END LOOP bucle;
  CLOSE cursor3;

END