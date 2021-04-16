/*********************************************************/
/*						CONSULTA 10						 */
/*********************************************************/
/* Consulta que muestre los países de Latinoamérica		 */
/* ordenados de los más infectados a los menos infectados*/ 
/* para un rango de fechas en específico.				 */
/*********************************************************/

/*
Argentina, Bolivia, Brasil, Chile, Colombia, Costa Rica, Cuba, Ecuador, El Salvador, Guatemala, Honduras, 
México, Nicaragua, Panamá, Paraguay, Perú, Puerto Rico, República Dominicana, Uruguay, Venezuela
*/

DECLARE @fecha_inicio DATE,
	    @fecha_fin	  DATE;

SET @fecha_inicio = '20210401';
SET @fecha_fin = '20210415';

SELECT P.ID_PAIS CODIGO,
	   P.LOCATIONN PAIS,
	   CAST(MAX(C.TOTAL_CASES) AS INT) 'CASOS TOTALES'
  FROM CASOS C
 INNER JOIN PAIS P ON P.ID_PAIS = C.ID_PAIS
 WHERE P.ID_CONTINENTE IN(4,6)
   AND P.ID_PAIS NOT IN(3,9,20,27,23,24,32,45,50,78,77,95,84,133,103,110,62,80,174,198,187,181,195)
   AND C.DATEE BETWEEN @fecha_inicio AND @fecha_fin
 GROUP BY P.ID_PAIS, P.LOCATIONN 
  ORDER BY CAST(MAX(C.TOTAL_CASES) AS INT) DESC;

