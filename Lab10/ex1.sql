DROP TRIGGER IF EXISTS inregistrare_noua 
GO
CREATE TRIGGER inregistrare_noua ON plan_studii.orarul
AFTER UPDATE
AS SET NOCOUNT ON
IF UPDATE(Auditoriu)
SELECT 'Lectia la disciplina ' + UPPER(disciplineS.Disciplina)+ ', a grupei ' + grupe.Cod_Grupa +
		', ziua de ' + CAST(inserted.Zi as VARCHAR(5)) + ', de la ora ' + CAST(inserted.Ora as VARCHAR(5))
		+ ', a fost transferata in aula ' + CAST(inserted.Auditoriu as VARCHAR(5)) + ', Blocul '+
		CAST(inserted.Bloc as VARCHAR(5)) + '. Auditoriul vechi: ' + CAST(deleted.Auditoriu as VARCHAR(5))+
		', Auditoriul nou: ' + CAST(inserted.Auditoriu as VARCHAR(5))
FROM inserted,deleted, disciplineS, grupe
WHERE deleted.Id_Disciplina = disciplineS.Id_Disciplina
AND inserted.Id_Grupa = grupe.Id_Grupa
GO

 UPDATE orarul 
 SET Auditoriu=119 where Id_Profesor=101

 select * from orarul