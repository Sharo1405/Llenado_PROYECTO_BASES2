USE bases2
GO
/* ************************************************************************** */
/* ARCHIVO: top_pais_mas_vacunas          									  */
/* NOMBRE LOGICO:  top_pais_mas_vacunas					                      */
/* BASE DE DATOS:  bases2									                  */
/* DISENADO POR:   Gary Ortiz                                                 */
/* ************************************************************************** */
/*                              P R O P O S I T O                             */
/* Crear una vista que muestre al top 10 de países con mayor cantidad         */
/* de pruebas.																  */
/* ************************************************************************** */
/*                          MODIFICACIONES                                    */
/*                                                                            */
/* FECHA                    AUTOR                       RAZON                 */
/* ************************************************************************** */
/*	15-04-2021               Gary Ortiz              Modificacion Inicial     */
/* ****************************************************************************/

if exists(select 1 from sys.views where name='top_pais_mas_vacunas' and type='v')
drop view top_pais_mas_vacunas;
go

CREATE VIEW top_pais_mas_vacunas
	AS
	Select TOP 10 PRUEBA.ID_PAIS,PAIS.LOCATIONN,PRUEBA.TOTAL_TESTS, PRUEBA.DATEE from PRUEBA, PAIS WHERE PRUEBA.ID_PAIS=PAIS.ID_PAIS
	AND PRUEBA.DATEE= DATEADD(day,-2,CONVERT(date,GETDATE()))
	ORDER BY PRUEBA.TOTAL_TESTS DESC;

GO	
	
Select * from top_pais_mas_vacunas;