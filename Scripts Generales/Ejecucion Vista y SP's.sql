
use bases2;

--CONSULTA 2
EXEC sp_Reporte_Consulta2 'GUATE'

--CONSULTA 4
SELECT * 
  FROM vw_Reporte_Consulta4
 ORDER BY 'TASA DE POSITIVOS' DESC

--CONSULTA 6
EXEC sp_Reporte_Consulta6 150,160

--CONSULTA 8
EXEC sp_Reporte_Consulta8 '20210410'

