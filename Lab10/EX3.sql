IF OBJECT_ID('Lab10_ex3', 'TR') is not null
   DROP TRIGGER Lab10_ex3
   GO
CREATE TRIGGER Lab10_ex3 ON studenti.studenti_reusita
AFTER UPDATE
AS
SET NOCOUNT ON
IF UPDATE (Nota)
DECLARE @ID_GRUPA INT = (SELECT Id_Grupa  FROM grupe WHERE Cod_Grupa = 'CIB171')
DECLARE @count int = (SELECT count(*) FROM deleted , inserted 
			where deleted.Id_Disciplina = inserted.Id_Disciplina and deleted.Id_Grupa = inserted.Id_Grupa 
			and deleted.Id_Profesor = inserted.Id_Profesor and deleted.Tip_Evaluare = inserted.Tip_Evaluare 
			and deleted.Id_Student = inserted.Id_Student
			and inserted.Nota < deleted.Nota 
			and inserted.Id_Grupa = @ID_GRUPA)
	
BEGIN
IF (@count > 0 )
PRINT ('Nu se perminte micsorarea notelor pentru grupa CIB 171')
ROLLBACK TRANSACTION
end

IF UPDATE(Data_evaluare)
		SET @count = (SELECT count(*) FROM deleted WHERE Data_Evaluare is not null and Id_Grupa = @ID_GRUPA)
		IF @count > 0
		BEGIN
			PRINT ('Nu se permite modificarea campului Tip_Evaluare')
			ROLLBACK TRANSACTION
		END
GO