DROP TRIGGER IF EXISTS Lab10_ex5
GO
CREATE TRIGGER Lab10_ex5 
ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
DECLARE @TimpulCurent TIME
DECLARE @Inceput TIME
DECLARE @Sfarsit TIME
SELECT @TimpulCurent = CONVERT(Time, GETDATE())
SELECT @Inceput = '8:00:00'
SELECT @Sfarsit = '17:00:00'

IF (@TimpulCurent < @Inceput) OR (@TimpulCurent > @Sfarsit)
BEGIN	
PRINT 'Baza de date nu poate fi modificata inafara orelor de lucru. Ora curenta: ' + cast(@TimpulCurent as VARCHAR(20))
ROLLBACK
END

GO

alter table studenti.studenti alter column Nume_Student varchar(49);