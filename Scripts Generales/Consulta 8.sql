USE bases2
GO
/* ************************************************************************** */
/* ARCHIVO: sp_Reporte_Consulta8          									  */
/* NOMBRE LOGICO:  sp_Reporte_Consulta8					                      */
/* BASE DE DATOS:  bases2									                  */
/* DISENADO POR:   Haroldo Arias                                              */
/* ************************************************************************** */
/*                              P R O P O S I T O                             */
/* Stored Procedure que reciba la fecha como parametro y que muestre el pais */
/* que reporto mas muertes en ese dia										  */ 
/* ************************************************************************** */
/*                          MODIFICACIONES                                    */
/*                                                                            */
/* FECHA                    AUTOR                       RAZON                 */
/* ************************************************************************** */
/*	15-04-2021               Haroldo Arias           Modificacion Inicial     */
/* ****************************************************************************/

if exists(select 1 from sys.objects where object_id = object_id(N'dbo.sp_Reporte_Consulta8'))
drop procedure sp_Reporte_Consulta8;
go

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

go