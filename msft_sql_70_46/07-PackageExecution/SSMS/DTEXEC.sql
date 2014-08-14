--Use DTEXEC to configure and execute packages stored in the SSISDB catalog or 
--packages created with or stored in older versions of SSIS (msdb).
/*
	%ProgramFiles(x86)%\Microsoft SQL Server\110\DTS\Binn\DTExec.exe 
	/SERVER SQLNUGGET /ISServer "\SSISDB\70-463\07-PackageExecution\DimCustomer.dtsx" 
	/Par "$Project::ProjectParam(String)";garth@nuggetlab.com
	/Par "$Package::PackageParam(Int32)";25
	/Par "CM.AWDW2012_temp.InitialCatalog";AdventureWorksDW_temp
	/Par "CM.AW2012.InitialCatalog";AdventureWorks2012
	/Par "$ServerOption::LOGGING_LEVEL(Int32)";1
*/


--Use DTEXECUI for packages created with or stored in older versions of SSIS (msdb).
/*
	%ProgramFiles(x86)%\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\DTExecUI.exe
*/