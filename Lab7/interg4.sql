---4. Afisati care dintre discipline au denumirea formata din mai mult de 20 de caractere? 

select disciplina
from plan_studii.discipline
where len(disciplina)>20;