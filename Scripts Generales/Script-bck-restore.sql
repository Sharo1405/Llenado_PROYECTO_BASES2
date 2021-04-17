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
SELECT name, description FROM sys.fn_helpcollations() WHERE name='SQL_Latin1_General_CP1_CI_AS';