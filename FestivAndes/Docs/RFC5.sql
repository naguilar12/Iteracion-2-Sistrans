with tabla1 as(select totalClientes, totalBoletas, fecha, id_sitio, tipo, totalClientes/capacidad as proporcion, id_espectaculo, sum(precio)as totalBoleta from  
				(select count(id_cliente)as totalClientes, count(id_cliente)as totalBoletas,id_funcion, fecha, id_espectaculo from funcion natural join boleta where fecha between" + "'" + rent.getFechaInicial()+"'"+" and " + "'" + rent.getFechaFinal() + "'"
				+" group by id_funcion, fecha, id_espectaculo) " +  
				"natural join (select precio, sitio.capacidad, tipo, sitio.id_sitio from sitio inner join localidad on sitio.ID_SITIO = localidad.ID_SITIO) group by totalClientes, totalBoletas, fecha, id_sitio, tipo, " +
				" totalClientes/capacidad, id_espectaculo),"
				+" tabla2 as( "
				+" select id_espectaculo, id_cat from(select * from categoria inner join ESPECTACULOCATEGORIA on id_cat = id_categoria)"
				+" inner join espectaculo on id_espec = id_espectaculo where id_espectaculo = "+idCompania+")"
				+" select * from tabla1 natural join tabla2 order by totalBoleta desc";
        
        
//RFC5 CONSULTA DE UNA COMPANIA
WITH RANGO_FECHAS AS (SELECT ID, FECHA_HORA, ID_ESPECTACULO, ID_SITIO FROM FUNCION WHERE FECHA_HORA BETWEEN  '01/01/05' AND '01/01/19'),
     FUNCION_ESPECTACULO AS (SELECT R.ID, FECHA_HORA, ID_ESPECTACULO, NOMBRE, ID_SITIO FROM (RANGO_FECHAS R INNER JOIN ESPECTACULO E ON R.ID_ESPECTACULO = E.ID)),
     ESPECTACULO_COMPANIA AS (SELECT ID, FECHA_HORA, C.ID_ESPECTACULO, NOMBRE, ID_SITIO, ID_COMPANIA FROM (FUNCION_ESPECTACULO F INNER JOIN COMPANIA_ESPECTACULO C ON F.ID_ESPECTACULO = C.ID_ESPECTACULO AND C.ID_COMPANIA=2)),
     CON_SITIO AS (SELECT E.ID, FECHA_HORA, ID_ESPECTACULO, NOMBRE, ID_SITIO,NOMBRE_SITIO, LUGAR_ABIERTO, ID_COMPANIA, CAPACIDAD FROM (ESPECTACULO_COMPANIA E INNER JOIN SITIO S ON E.ID_SITIO = S.ID)),
     CON_CATEGORIA AS (SELECT ID AS ID_FUNCION, FECHA_HORA, C.ID_ESPECTACULO, NOMBRE AS NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, ID_COMPANIA, CAPACIDAD FROM(CON_SITIO C INNER JOIN CATEGORIA_ESPECTACULO CE ON C.ID_ESPECTACULO = CE.ID_ESPECTACULO)),
     VENDIDAS AS (SELECT C.ID_FUNCION, FECHA_HORA, ID_ESPECTACULO, NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, CAPACIDAD, ID_COMPANIA, COUNT(ID_CLIENTE) AS BOLETAS_VENDIDAS, COUNT(ID_CLIENTE) AS ASISTENTES, SUM(B.COSTO) AS TOTAL_FACTURADO FROM(CON_CATEGORIA C INNER JOIN BOLETA B ON C.ID_FUNCION = B.ID_FUNCION AND (B.ESTADO = 2 OR B.ESTADO = 1))  GROUP BY C.ID_FUNCION, FECHA_HORA, ID_ESPECTACULO, NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, ID_COMPANIA, CAPACIDAD ),
     PROPORCION AS (SELECT ID_FUNCION, FECHA_HORA, ID_ESPECTACULO, NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, ASISTENTES/CAPACIDAD AS PROPORCION, ID_COMPANIA, BOLETAS_VENDIDAS, ASISTENTES, TOTAL_FACTURADO FROM VENDIDAS)
SELECT * FROM PROPORCION;

--RFC5 CONSULTA GERENTE GENERAL
WITH RANGO_FECHAS AS (SELECT ID, FECHA_HORA, ID_ESPECTACULO, ID_SITIO FROM FUNCION WHERE FECHA_HORA BETWEEN  '01/01/05' AND '01/01/19'),
     FUNCION_ESPECTACULO AS (SELECT R.ID, FECHA_HORA, ID_ESPECTACULO, NOMBRE, ID_SITIO FROM (RANGO_FECHAS R INNER JOIN ESPECTACULO E ON R.ID_ESPECTACULO = E.ID)),
     ESPECTACULO_COMPANIA AS (SELECT ID, FECHA_HORA, C.ID_ESPECTACULO, NOMBRE, ID_SITIO, ID_COMPANIA FROM (FUNCION_ESPECTACULO F INNER JOIN COMPANIA_ESPECTACULO C ON F.ID_ESPECTACULO = C.ID_ESPECTACULO)),
     CON_SITIO AS (SELECT E.ID, FECHA_HORA, ID_ESPECTACULO, NOMBRE, ID_SITIO,NOMBRE_SITIO, LUGAR_ABIERTO, ID_COMPANIA, CAPACIDAD FROM (ESPECTACULO_COMPANIA E INNER JOIN SITIO S ON E.ID_SITIO = S.ID)),
     CON_CATEGORIA AS (SELECT ID AS ID_FUNCION, FECHA_HORA, C.ID_ESPECTACULO, NOMBRE AS NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, ID_COMPANIA, CAPACIDAD FROM(CON_SITIO C INNER JOIN CATEGORIA_ESPECTACULO CE ON C.ID_ESPECTACULO = CE.ID_ESPECTACULO)),
     VENDIDAS AS (SELECT C.ID_FUNCION, FECHA_HORA, ID_ESPECTACULO, NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, CAPACIDAD, ID_COMPANIA, COUNT(ID_CLIENTE) AS BOLETAS_VENDIDAS, COUNT(ID_CLIENTE) AS ASISTENTES, SUM(B.COSTO) AS TOTAL_FACTURADO FROM(CON_CATEGORIA C INNER JOIN BOLETA B ON C.ID_FUNCION = B.ID_FUNCION AND (B.ESTADO = 2 OR B.ESTADO = 1))  GROUP BY C.ID_FUNCION, FECHA_HORA, ID_ESPECTACULO, NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, ID_COMPANIA, CAPACIDAD ),
     PROPORCION AS (SELECT ID_FUNCION, FECHA_HORA, ID_ESPECTACULO, NOMBRE_ESPECTACULO, CATEGORIA, ID_SITIO, NOMBRE_SITIO, LUGAR_ABIERTO, ASISTENTES/CAPACIDAD AS PROPORCION, ID_COMPANIA, BOLETAS_VENDIDAS, ASISTENTES, TOTAL_FACTURADO FROM VENDIDAS)
SELECT * FROM PROPORCION;