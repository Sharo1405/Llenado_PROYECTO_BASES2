/*********************************************************/
/*						CONSULTA 9						 */
/*********************************************************/
/* Consulta que muestre los datos de Guatemala para un   */
/* rango de fechas especifico.							 */
/*********************************************************/

select * from (	
	SELECT pais.ID_PAIS,
		   CAST(isnull(casos.TOTAL_CASES,0) AS INT) TOTAL_CASES,
		   casos.DATEE 
	  FROM pais
	  inner join casos on pais.ID_PAIS=casos.ID_PAIS
	  WHERE pais.ID_PAIS=79
	)a
	full outer join	
	(
	SELECT pais.ID_PAIS,
	       CAST(isnull(MUERTES.TOTAL_DEATHS,0) AS INT) TOTAL_DEATHS,
		   MUERTES.DATEE 
	  FROM pais
	 inner join MUERTES on pais.ID_PAIS=MUERTES.ID_PAIS
   	 WHERE pais.ID_PAIS=79
	)b on a.DATEE=b.DATEE


/*otra forma*/
Select * 
  from casos
 inner join muertes on muertes.ID_PAIS=casos.ID_PAIS and MUERTES.DATEE=casos.datee
 inner join VACUNACION on VACUNACION.ID_PAIS=casos.ID_PAIS and VACUNACION.DATEE = casos.datee
 inner join prueba on prueba.ID_PAIS=casos.ID_PAIS and prueba.DATEE=casos.datee
 where casos.ID_PAIS=79
   and casos.DATEE between DATEADD(day,-25,CONVERT(date,GETDATE())) 
   and DATEADD(day,-2,CONVERT(date,GETDATE()))
