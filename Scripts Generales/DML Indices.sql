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
