
# 6. CREAREA TABELELOR SI INDECSILOR 

## Task 1
### Sa se scrie o instructiune T-SQL, care ar popula coloana Adresa _ Postala _ Profesor din tabelul profesori cu valoarea 'mun. Chisinau',unde adresa este necunoscută.

```SQL
UPDATE profesori set Adresa_Postala_Profesor = 'mun.Chisinau'
				 where Adresa_Postala_Profesor IS NULL;

SELECT Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor
FROM profesori
```
![image](https://user-images.githubusercontent.com/34598802/48318052-8d04ea00-e603-11e8-9cc0-3e6904d75822.png)

## Task 2
### Sa se modifice schema tabelului grupe, ca sa corespunda urmatoarelor cerinte:<br/>
  a) Campul Cod_ Grupa sa accepte numai valorile unice și să nu accepte valori necunoscute. <br/>
  b) Să se țină cont că cheie primară, deja, este definită asupra coloanei Id_ Grupa. <br/>

  ```SQL
ALTER TABLE grupe 
ADD UNIQUE (Cod_Grupa)
ALTER TABLE grupe 
ALTER COLUMN Cod_Grupa char(6) NOT NULL;

select Cod_Grupa
from grupe
```


