
--ex3
--Rezolvati aceesi sarcina, 1, apeland la structura selectiva CASE.
declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand();
set @MAI_MARE = @N1;
set @MAI_MARE = case 
	 when  @MAI_MARE < @N2 and @N3 < @N2
	 then  @N2
	 when @MAI_MARE < @N3 and @N2<@N3
	 then  @N3
	 else @MAI_MARE
	 end   
print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast( @MAI_MARE   as varchar(2));