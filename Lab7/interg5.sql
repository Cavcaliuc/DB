---5. Sa se afiseze lista studentilor al caror nume se termina in ,,u" 

select nume_student, prenume_student
from studenti.studenti
where Nume_Student like '%u';