
USE bases2
GO
/* ************************************************************************** */
/* ARCHIVO: sp_Reporte_Consulta2          									  */
/* NOMBRE LOGICO:  sp_Reporte_Consulta2					                      */
/* BASE DE DATOS:  bases2									                  */
/* DISENADO POR:   Haroldo Arias                                              */
/* ************************************************************************** */
/*                              P R O P O S I T O                             */
/* Stored procedure que recibe el nombre del país y nos muestra el acumulado  */	
/* mensual de infectados, muertes y vacunados.								  */
/* ************************************************************************** */
/*                          MODIFICACIONES                                    */
/*                                                                            */
/* FECHA                    AUTOR                       RAZON                 */
/* ************************************************************************** */
/*	15-04-2021               Haroldo Arias           Modificacion Inicial     */
/* ****************************************************************************/

ALTER PROCEDURE sp_Reporte_Consulta2
	@i_pais			VARCHAR(60)
AS

SELECT @i_pais = UPPER(@i_pais);

DECLARE @w_id_pais INT;
DECLARE @w_nombre_pais VARCHAR(250);

SELECT @w_id_pais = p.id_pais, @w_nombre_pais=p.locationn
  FROM pais as p
 WHERE upper(p.locationn) like '%'+@i_pais+'%';


 SELECT c.DATEE, 
		ISNULL(c.TOTAL_CASES,0) TOTAL_CASES, 
		ISNULL(m.TOTAL_DEATHS,0) TOTAL_DEATHS, 
		ISNULL(v.TOTAL_VACCINATIONS,0) TOTAL_VACCINATIONS
   INTO #info_pais
   FROM casos c 
  INNER JOIN muertes m ON m.id_pais = c.id_pais AND m.datee = c.datee
  INNER JOIN vacunacion v ON V.id_pais = c.id_pais AND v.datee = c.datee
  WHERE c.id_pais = @w_id_pais;


  SELECT @w_id_pais CÓDIGO,
		 @w_nombre_pais PAÍS,
	     CAST(SUM(TOTAL_CASES) AS int) CASOS,
		 CAST(SUM(TOTAL_DEATHS) AS int) MUERTES,
		 CAST(SUM(TOTAL_VACCINATIONS) AS int) VACUNACIONES,
		 MONTH(DATEE) MES,
		 YEAR(DATEE) AÑO
    FROM #info_pais
	GROUP BY MONTH(DATEE), YEAR(DATEE)

   DROP TABLE #info_pais;




   