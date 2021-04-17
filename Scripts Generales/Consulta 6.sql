
USE bases2
GO
/* ************************************************************************** */
/* ARCHIVO: sp_Reporte_Consulta6          									  */
/* NOMBRE LOGICO:  sp_Reporte_Consulta6					                      */
/* BASE DE DATOS:  bases2									                  */
/* DISENADO POR:   Haroldo Arias                                              */
/* ************************************************************************** */
/*                              P R O P O S I T O                             */
/* Stored procedure que reciba un rango de infectados por día y devuelve los  */
/* paises que en algún momento tuvieron ese rango con su fecha correspondiente*/ 
/* ************************************************************************** */
/*                          MODIFICACIONES                                    */
/*                                                                            */
/* FECHA                    AUTOR                       RAZON                 */
/* ************************************************************************** */
/*	15-04-2021               Haroldo Arias           Modificacion Inicial     */
/* ****************************************************************************/

if exists(select 1 from sys.objects where object_id = object_id(N'dbo.sp_Reporte_Consulta6'))
drop procedure sp_Reporte_Consulta6;
go

CREATE PROCEDURE sp_Reporte_Consulta6
	@i_valor_inicial	INT,
	@i_valor_final		INT
AS


SELECT C.ID_PAIS CODIGO,
	   P.LOCATIONN PAIS, 
	   C.DATEE FECHA, 
	   C.TOTAL_CASES CASOS
  FROM CASOS C
 INNER JOIN PAIS P ON P.ID_PAIS = C.ID_PAIS
 WHERE TOTAL_CASES BETWEEN @i_valor_inicial AND @i_valor_final;

GO