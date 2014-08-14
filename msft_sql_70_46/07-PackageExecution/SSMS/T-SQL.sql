
USE master
GO
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE WITH OVERRIDE


--xp_cmdshell to shell out DTEXEC.exe from T-SQL
EXEC xp_cmdshell 'DTExec.exe /SERVER SQLNUGGET /ISServer "\SSISDB\70-463\07-PackageExecution\DimCustomer.dtsx" 
					/Par "$Project::ProjectParam(String)";garth@nuggetlab.com
					/Par "$Package::PackageParam(Int32)";25
					/Par "CM.AWDW2012_temp.InitialCatalog";AdventureWorksDW2012_temp
					/Par "CM.AW2012.InitialCatalog";AdventureWorks2012
					/Par "$ServerOption::LOGGING_LEVEL(Int32)";1'


--Built-in stored procedures to set parameters and execute package from T-SQL
DECLARE @execution_id bigint
EXEC ssisdb.catalog.create_execution 
	@folder_name = N'70-463',
	@project_name = N'07-PackageExecution',
	@package_name = N'DimCustomer.dtsx',
	@use32bitruntime = False,
	@reference_id = NULL,
	@execution_id = @execution_id OUTPUT


EXEC ssisdb.catalog.set_object_parameter_value  
	@object_type = 20,
	@folder_name = N'70-463',
	@project_name = N'07-PackageExecution',
	@parameter_name = N'ProjectParam', 
	@parameter_value = N'garth@nuggetlab.com'

EXEC ssisdb.catalog.set_object_parameter_value  
	@object_type = 30,
	@folder_name = N'70-463',
	@project_name = N'07-PackageExecution',
	@object_name = N'DimCustomer.dtsx',
	@parameter_name = N'PackageParam', 
	@parameter_value = 25

EXEC ssisdb.catalog.set_execution_parameter_value 
	@execution_id, 
	@object_type = 50,
	@parameter_name = N'LOGGING_LEVEL', 
	@parameter_value = 1

EXEC ssisdb.catalog.start_execution 
	@execution_id
GO