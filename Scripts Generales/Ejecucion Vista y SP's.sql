
use bases2;

/******************** CREACION DE INDICES TABLAS MAS CONSULTADAS *******************************/
CREATE INDEX pais_continente ON PAIS(ID_PAIS,ID_CONTINENTE);

CREATE INDEX casos_id_pais ON CASOS(ID_PAIS);
CREATE INDEX casos_id_pais_fecha ON CASOS(ID_PAIS,DATEE);


CREATE INDEX muertes_id_pais ON MUERTES(ID_PAIS);
CREATE INDEX muertes_id_pais_fecha ON MUERTES(ID_PAIS,DATEE);

CREATE INDEX pruebas_id_pais ON PRUEBA(ID_PAIS);
CREATE INDEX pruebas_id_pais_fecha ON PRUEBA(ID_PAIS,DATEE);

CREATE INDEX vacunacion_id_pais ON VACUNACION(ID_PAIS);
CREATE INDEX vacunacion_id_pais_fecha ON VACUNACION(ID_PAIS,DATEE);

--CONSULTA 2
EXEC sp_Reporte_Consulta2 'GUATE'

--CONSULTA 4
SELECT * 
  FROM vw_Reporte_Consulta4
 ORDER BY 'TASA DE POSITIVOS' DESC

--CONSULTA 6
EXEC sp_Reporte_Consulta6 150,160

--CONSULTA 8
EXEC sp_Reporte_Consulta8 '20210410'

