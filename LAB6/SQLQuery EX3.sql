--ex3
--La tabelul grupe, să se adauge 2 coloane noi Sef_grupa și Prof_Indrumator, ambele de tip INT. 
--Să se populeze câmpurile nou-create cu cele mai potrivite candidaturi în baza criteriilor de mai jos:


ALTER TABLE grupe
ADD Sef_Grupa int,Prof_Indrumator int;

DECLARE c1 CURSOR FOR 
SELECT id_grupa FROM grupe 

DECLARE @gid int
  ,@sid int
  ,@pid int

OPEN c1
FETCH NEXT FROM c1 into @gid 
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT TOP 1 @sid=id_student
 FROM studenti_reusita
 WHERE id_grupa = @gid and Id_Student NOT IN (SELECT isnull(sef_grupa,'') FROM grupe)
 GROUP BY id_student
 ORDER BY cast(avg (NOTA*1.0)as decimal(5,2)) DESC

SELECT TOP 1 @pid=id_profesor
    FROM studenti_reusita
    WHERE id_grupa = @gid AND Id_profesor NOT IN (SELECT isnull (prof_indrumator, '') FROM grupe)
    GROUP BY id_profesor
    ORDER BY count (DISTINCT id_disciplina) DESC, id_profesor

UPDATE grupe
  SET   sef_grupa = @sid
    ,prof_indrumator = @pid
WHERE Id_Grupa=@gid
FETCH NEXT FROM c1 into @gid 
END
CLOSE c1
DEALLOCATE c1

Select *
from grupe