USE bases2
GO
/* ************************************************************************** */
/* ARCHIVO: sp_Reporte_Consulta8          									  */
/* NOMBRE LOGICO:  sp_Reporte_Consulta8					                      */
/* BASE DE DATOS:  bases2									                  */
/* DISENADO POR:   Haroldo Arias                                              */
/* ************************************************************************** */
/*                              P R O P O S I T O                             */
/* Stored Procedure que reciba la fecha como parámetro y que muestre el país  */
/* que reporto más muertes en ese día										  */ 
/* ************************************************************************** */
/*                          MODIFICACIONES                                    */
/*                                                                            */
/* FECHA                    AUTOR                       RAZON                 */
/* ************************************************************************** */
/*	15-04-2021               Haroldo Arias           Modificacion Inicial     */
/* ****************************************************************************/

CREATE PROCEDURE sp_Reporte_Consulta8
	@i_fecha	DATE
AS

SELECT TOP 1 
	   M.ID_PAIS CODIGO,
	   P.LOCATIONN PAIS, 
	   M.DATEE FECHA, 
	   M.NEW_DEATHS MUERTES
  FROM MUERTES M
 INNER JOIN PAIS P ON P.ID_PAIS = M.ID_PAIS
 WHERE DATEE=@i_fecha
 ORDER BY M.NEW_DEATHS DESC;

