/*********************************************************/
/*						CONSULTA 1						 */
/*********************************************************/
/* Consulta que agrupe la cantidad actual de contagios   */
/* por pais.											 */
/*********************************************************/
	SELECT CASOS.ID_PAIS, 
		   PAIS.LOCATIONN, 
		   CAST(ISNULL(CASOS.TOTAL_CASES,0) AS INT) TOTAL_CASES, 
		   CASOS.DATEE 
     FROM CASOS, PAIS
	WHERE CASOS.ID_PAIS = PAIS.ID_PAIS 
	  AND CASOS.DATEE= DATEADD(day,-2,CONVERT(date,GETDATE()));