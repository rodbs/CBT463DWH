CREATE TABLE SSISDWLog
(
	LogID int identity(1,1) NOT NULL,
	PackageName varchar(50) NOT NULL,
	TaskName varchar(50) NOT NULL,
	EventType varchar(20) NOT NULL,
	ErrorCode int NULL,
	ErrorDescription varchar(1000) NULL
)
GO

INSERT SSISDWLog (PackageName, TaskName, EventType, ErrorCode, ErrorDescription)
		VALUES(?,?,'OnEvent',?,?)