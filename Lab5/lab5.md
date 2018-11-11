# 5.Transact-SQL: instrucțiuni procedurale  

![image](https://user-images.githubusercontent.com/34598802/47282917-a361ec00-d5e9-11e8-9382-4240c2c32ad3.png)

# TASK 1
## Completati urmatorul cod pentru a afisa cel mai mare numar dintre cele trei numere prezentate:

```SQL
declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand();
set @MAI_MARE = @N1;
if @MAI_MARE < @N2
   set @MAI_MARE = @N2;
if @MAI_MARE < @N3
   set @MAI_MARE = @N3;

print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast(@MAI_MARE as varchar(2));
```

![image](https://user-images.githubusercontent.com/34598802/48316882-eebc5880-e5f1-11e8-899c-4109849c2e03.png)


# TASK 2
## Afisati primele zece date(numele, prenumele studentului) in functie de valoarea notei (cu exceptia notelor 6 si 8) a studentului la primul test al disciplinei Baze de date, folosind structura de altemativa IF. .. ELSE. Sa se foloseasca variabilele



