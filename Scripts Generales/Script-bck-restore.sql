--creacion de backup de la base de datos
BACKUP DATABASE [bases2] 
	TO  
	DISK = N'/var/opt/mssql/data/bases2.bak' WITH NOFORMAT, 
	NOINIT,  
	NAME = N'bases2-Full Database Backup', 
	SKIP,
	NOREWIND,
	NOUNLOAD, 
	STATS = 10
GO
--Restauracion de la base de datos
USE [master]
	RESTORE DATABASE [bases2] FROM  DISK = N'/var/opt/mssql/data/bases2.bak' WITH  FILE = 1,  
	MOVE N'bases2' TO N'/var/opt/mssql/data/bases2.mdf',
	MOVE N'bases2_log' TO N'/var/opt/mssql/data/bases2_log.ldf', 
	NOUNLOAD,  STATS = 5

GO

--Backup bitacora de transacciones
BACKUP LOG [bases2] 
	TO  DISK = N'/var/opt/mssql/data/backup_trans_log.trn' WITH NOFORMAT,
	NOINIT, 
	NAME = N'bases2-Full Database Backup', 
	SKIP, NOREWIND,
	NOUNLOAD,  STATS = 10
GO
-- Restaurar bitacora de transacciones
RESTORE LOG [bases2] FROM  
	DISK = N'/var/opt/mssql/data/backup_trans_log.trn' WITH  
	FILE = 1, 
	NOUNLOAD,  STATS = 10
GO
DBCC LOG('bases2')

-- Truncate los registros de la base de datos
USE [bases2]
GO
DBCC SHRINKFILE (N'bases2_log' , 0, TRUNCATEONLY)
GO


-- Ver la collation de las tablas en la base de datos
SELECT t.name TableName, c.name ColumnName, collation_name  
FROM sys.columns c  
inner join sys.tables t on c.object_id = t.object_id;

/*INFORMACION SOBRE LA FRAGMENTACION DE LOS INDICES EN LAS TABLAS*/
SELECT  OBJECT_NAME(IDX.OBJECT_ID) AS Table_Name, 
IDX.name AS Index_Name, 
IDXPS.index_type_desc AS Index_Type, 
IDXPS.avg_fragmentation_in_percent  Fragmentation_Percentage
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) IDXPS 
INNER JOIN sys.indexes IDX  ON IDX.object_id = IDXPS.object_id 
AND IDX.index_id = IDXPS.index_id 
ORDER BY Fragmentation_Percentage DESC

/***Determinaci�n de la duraci�n prevista de la p�gina**/

SELECT
CASE instance_name WHEN '' THEN 'Overall' ELSE instance_name END AS NUMA_Node, cntr_value AS PLE_s
FROM sys.dm_os_performance_counters    
WHERE counter_name = 'Page life expectancy';