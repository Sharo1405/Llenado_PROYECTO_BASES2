USE bases2
GO
/* ************************************************************************** */
/* ARCHIVO: vw_Reporte_Consulta4          									  */
/* NOMBRE LOGICO:  vw_Reporte_Consulta4					                      */
/* BASE DE DATOS:  bases2									                  */
/* DISENADO POR:   Haroldo Arias                                              */
/* ************************************************************************** */
/*                              P R O P O S I T O                             */
/* Vista que muestre los paises con mayor aceleración de contagios durante    */
/* el mes de diciembre 2020 y enero 2021.									  */
/* ************************************************************************** */
/*                          MODIFICACIONES                                    */
/*                                                                            */
/* FECHA                    AUTOR                       RAZON                 */
/* ************************************************************************** */
/*	15-04-2021               Haroldo Arias           Modificacion Inicial     */
/* ****************************************************************************/

if exists(select 1 from sys.views where name='vw_Reporte_Consulta4' and type='v')
drop view vw_Reporte_Consulta4;
go

CREATE VIEW vw_Reporte_Consulta4
 AS 
 SELECT  C.ID_PAIS		CODIGO,
		 P.LOCATIONN	PAIS,
		 CAST(ISNULL(SUM(C.NEW_CASES),0) AS INT) 'CASOS TOTALES',
		 CAST(ISNULL(SUM(C.NEW_CASES),0) AS INT) / 60 'TASA POR DIA'
 FROM CASOS C
 INNER JOIN PAIS P ON P.ID_PAIS = C.ID_PAIS
 WHERE DATEE BETWEEN '20201201' AND '20210131'
 GROUP BY C.ID_PAIS, P.LOCATIONN;
 go