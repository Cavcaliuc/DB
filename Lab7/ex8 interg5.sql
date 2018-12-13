-- Query by using the synonym.  
--5. Sa se afiseze lista studentilor al caror nume se termina in ,,u" 

select distinct nume_student, prenume_student
from studentiA
where Nume_Student like '%u';