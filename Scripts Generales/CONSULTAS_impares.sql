/****** Script for SelectTopNRows command from SSMS  ******/
SELECT CASOS.ID_PAIS, PAIS.LOCATIONN , CASOS.TOTAL_CASES , CASOS.DATEE FROM CASOS, PAIS
WHERE CASOS.ID_PAIS = PAIS.ID_PAIS AND CASOS.ID_PAIS=14 ORDER BY CASOS.DATEE ASC;
/*CREACION DE INDEX PARA CONSULTAS*/
	CREATE INDEX index_id_pais ON PAIS(ID_PAIS, LOCATIONN);
	DROP INDEX index_id_pais ON PAIS;
/*CONSULTA 1 : 1.
Consulta que agrupe la cantidad actual de contagios por país.*/

	SELECT CASOS.ID_PAIS, PAIS.LOCATIONN , CAST(ISNULL(CASOS.TOTAL_CASES,0) AS INT) TOTAL_CASES , CASOS.DATEE FROM CASOS, PAIS
	WHERE CASOS.ID_PAIS = PAIS.ID_PAIS AND CASOS.DATEE= DATEADD(day,-3,CONVERT(date,GETDATE()));
	select DATEADD(day,-4,CONVERT(date,GETDATE()));

/*CONSULTA 3 : Consulta que agrupe la cantidad actual de contagios de los últimos 3 meses por continente*/
	SELECT T2.ID_CONTINENTE,T2.Con1, (T2.total_ayer-T1.total_3meses)Total_casos_3MESES_hasta_hoy FROM(
	SELECT CONTINENTE.ID_CONTINENTE, (CONTINENTE.CONTINENT)Con ,SUM(CASOS.TOTAL_CASES)total_3meses FROM CASOS, PAIS, CONTINENTE
	WHERE CASOS.ID_PAIS = PAIS.ID_PAIS AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE 
	AND CASOS.DATEE= DATEADD(day,-93,CONVERT(date,GETDATE())) 
	GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE
	)T1
	FULL OUTER JOIN
	(
	SELECT CONTINENTE.ID_CONTINENTE, (CONTINENTE.CONTINENT)Con1 ,SUM(CASOS.TOTAL_CASES)total_ayer FROM CASOS, PAIS, CONTINENTE
	WHERE CASOS.ID_PAIS = PAIS.ID_PAIS AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE 
	AND CASOS.DATEE= DATEADD(day,-3,CONVERT(date,GETDATE())) 
	GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE
	)T2 ON T1.Con=T2.Con1;
	/*otra opcion*/
	SELECT CONTINENTE.ID_CONTINENTE, (CONTINENTE.CONTINENT)Con ,SUM(CASOS.TOTAL_CASES)total_hace_3meses FROM CASOS, PAIS, CONTINENTE
	WHERE CASOS.ID_PAIS = PAIS.ID_PAIS AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE 
	AND CASOS.DATEE= DATEADD(day,-93,CONVERT(date,GETDATE())) 
	GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE;



/*CONSULTA 5: Promedio contagios durante el primer trimestre de la pandemia.*/
/*POR PAIS*/
	SELECT CASOS.ID_PAIS, PAIS.LOCATIONN, AVG(ISNULL(CASOS.NEW_CASES,0))PROMEDIO FROM CASOS, PAIS
	WHERE CASOS.ID_PAIS=PAIS.ID_PAIS 
	AND
	CASOS.DATEE BETWEEN '2020-03-01' AND '2020-06-30'
	GROUP BY CASOS.ID_PAIS,PAIS.LOCATIONN;
/*POR CONTINENTE*/
	SELECT CONTINENTE.ID_CONTINENTE, (CONTINENTE.CONTINENT)Con, AVG(ISNULL(CASOS.NEW_CASES,0))PROMEDIO FROM CASOS, PAIS, CONTINENTE
	WHERE CASOS.ID_PAIS=PAIS.ID_PAIS AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE
	AND
	CASOS.DATEE BETWEEN '2020-03-01' AND '2020-06-30'
	GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE;


/*CONSULTA 7: Crear una vista que muestre al top 10 de países con mayor cantidad de pruebas*/
	CREATE VIEW top_pais_mas_vacunas
	AS
	Select TOP 10 PRUEBA.ID_PAIS,PAIS.LOCATIONN,PRUEBA.TOTAL_TESTS, PRUEBA.DATEE from PRUEBA, PAIS WHERE PRUEBA.ID_PAIS=PAIS.ID_PAIS
	AND PRUEBA.DATEE= DATEADD(day,-3,CONVERT(date,GETDATE()))
	ORDER BY PRUEBA.TOTAL_TESTS DESC;

	Select * from top_pais_mas_vacunas;

/*CONSULTA 9: Consulta que muestre los datos de Guatemala para un rango de fechas especifico.*/
	SELECT * FROM CASOS, PAIS 
	WHERE CASOS.ID_PAIS=PAIS.ID_PAIS 
	and PAIS.LOCATIONN='Guatemala'
	and CASOS.DATEE BETWEEN DATEADD(day,-15,CONVERT(date,GETDATE())) and DATEADD(day,-3,CONVERT(date,GETDATE()));

