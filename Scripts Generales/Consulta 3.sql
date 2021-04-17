/*********************************************************/
/*						CONSULTA 3						 */
/*********************************************************/
/* Consulta que agrupe la cantidad actual de contagios   */
/* de los Últimos 3 meses por continentepor país.		 */
/*********************************************************/

SELECT T2.ID_CONTINENTE,T2.Con1, 
	  (T2.total_ayer-T1.total_3meses)Total_casos_3MESES_hasta_hoy 
 FROM(
	SELECT CONTINENTE.ID_CONTINENTE, 
	       (CONTINENTE.CONTINENT)Con,
		   SUM(CASOS.TOTAL_CASES)total_3meses 
		   FROM CASOS, 
		        PAIS, 
				CONTINENTE
		  WHERE CASOS.ID_PAIS = PAIS.ID_PAIS 
		    AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE 
			AND CASOS.DATEE= DATEADD(day,-92,CONVERT(date,GETDATE())) 
		  GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE
	)T1
 FULL OUTER JOIN
	(
	SELECT CONTINENTE.ID_CONTINENTE, 
	       (CONTINENTE.CONTINENT)Con1,
		   SUM(CASOS.TOTAL_CASES)total_ayer 
	  FROM CASOS, 
		   PAIS, 
		   CONTINENTE
	 WHERE CASOS.ID_PAIS = PAIS.ID_PAIS 
	   AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE 
	   AND CASOS.DATEE= DATEADD(day,-2,CONVERT(date,GETDATE())) 
	 GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE
	) T2 ON T1.Con=T2.Con1;


	/*otra opcion*/
	SELECT CONTINENTE.ID_CONTINENTE, 
		  (CONTINENTE.CONTINENT)Con,
		  SUM(CASOS.TOTAL_CASES)total_hace_3meses 
	 FROM CASOS, 
	      PAIS, 
		  CONTINENTE
	WHERE CASOS.ID_PAIS = PAIS.ID_PAIS 
	  AND PAIS.ID_CONTINENTE=CONTINENTE.ID_CONTINENTE 
	  AND CASOS.DATEE= DATEADD(day,-92,CONVERT(date,GETDATE())) 
	GROUP BY CONTINENTE.CONTINENT, CONTINENTE.ID_CONTINENTE;