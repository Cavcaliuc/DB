CREATE TRIGGER Lab10_ex2 ON studenti.studenti_reusita
INSTEAD OF INSERT
AS SET NOCOUNT ON
   
  INSERT INTO studenti.studenti_reusita 
  SELECT * FROM inserted
  WHERE Id_Student in (SELECT Id_Student FROM studenti.studenti)
  GO

  INSERT INTO studentiS values (200,'AAA', 'BBB', '1999-11-18', null)
  INSERT INTO reusitaS values (200, 101, 101, 1, 'Examen', null, null)

 
  select * from studentiS where Id_Student= 200
  select * from reusitaS where Id_Student = 200