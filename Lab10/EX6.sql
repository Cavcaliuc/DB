CREATE TRIGGER ex6 ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
 DECLARE @D varchar(30)  
 DECLARE @event1 varchar(500)  
 DECLARE @event2 varchar(500)  
 DECLARE @event3 varchar(50) 
 SELECT @D=EVENTDATA(). value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]','nvarchar(max)')
 IF @D = 'Prenume_Profesor'    
 BEGIN  
 SELECT @event1 = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)') 
 SELECT @event3 = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)') 
 SELECT @event2 = REPLACE(@event1, @event3, 'profesori'); EXECUTE (@event2) 
 SELECT @event2 = REPLACE(@event1, @event3, 'profesori_new');EXECUTE (@event2) 
PRINT 'Datele au fost modificate in toate tabelele'
END
go

alter table profesori alter column Prenume_profesor varchar(60)