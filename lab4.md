

INSTRUCTIUNEA SELECT TRANSACT-SQL

![image](https://user-images.githubusercontent.com/34598802/46936140-0988c500-d066-11e8-8d3a-5cd9c1de345c.png)
![image](https://user-images.githubusercontent.com/34598802/46936197-405edb00-d066-11e8-94b3-f6d9d421a519.png)

Nr de ordine:
4.Afisati care dintre discipline au denumirea formata din mai mult de 20 de caractere?
select Disciplina
from discipline
where LEN(Disciplina)>20;

![image](https://user-images.githubusercontent.com/34598802/46965709-45e31200-d0b4-11e8-8ac4-ed06b012438a.png)

Nr de ordine +16:
20.Afisati numarul de studenti care au sustinut testul (Testul 2) la disciplina Baze de date in 2018. 
select count(Id_Student)
from studenti_reusita 
where Tip_Evaluare = 'Testul 2' and Id_Disciplina = 107 and Data_Evaluare like '%2018%'

![image](https://user-images.githubusercontent.com/34598802/46965769-6ca14880-d0b4-11e8-923b-ed66500dd242.png)
![image](https://user-images.githubusercontent.com/34598802/46965793-7b87fb00-d0b4-11e8-80cc-6f989d7fd9ef.png)

Random 28-39:
35.Gasiti denumirile disciplinelor si media notelor pe disciplina. Afisati numai disciplinele cu medii mai mari de 7.0.
select d.Disciplina, AVG(sr.Nota)
from discipline as d inner join studenti_reusita as sr
on d.Id_Disciplina=sr.Id_Disciplina
group by Disciplina
having (AVG(sr.Nota)>7);

![image](https://user-images.githubusercontent.com/34598802/46966455-85aaf900-d0b6-11e8-80fc-9a6257e378b9.png)
![image](https://user-images.githubusercontent.com/34598802/46966386-4d0b1f80-d0b6-11e8-88f9-3d3fdef06a0f.png)
