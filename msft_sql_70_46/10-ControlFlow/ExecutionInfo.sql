IF OBJECT_ID('ExecutionInfo', 'U') IS NOT NULL
	DROP TABLE dbo.ExecutionInfo;
 GO

CREATE TABLE dbo.ExecutionInfo
(
  ExecID int identity NOT NULL,
  TaskID uniqueidentifier NOT NULL,
  TaskName nvarchar(255) NOT NULL,
  TaskTime datetime NOT NULL DEFAULT(GETDATE()),
  TaskFileName nvarchar(255) NOT NULL,
  CONSTRAINT PK_RunInfo PRIMARY KEY CLUSTERED (ExecID ASC)
)