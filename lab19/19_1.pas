PROGRAM Prime(INPUT, OUTPUT);
{Находит простые числа в диапазоне методом Решета Эратосфена}

CONST
  Start = 2; {Первое простое число}
  Min = 50; {Начало диапазона вывода}
  Max = 70; {Конец диапазона вывода}
    
TYPE
  Numbers = ARRAY [Start .. Max] OF BOOLEAN;
    
VAR
  Sieve: Numbers; {Sieve - решето с неудаленными числами}
  CurrentNumber, Multiple: INTEGER; {CurrentNumber - текущее проверяемое число. Multiple - текущее кратное число}
    
BEGIN
  {Считаем, что все числа простые}    
  FOR CurrentNumber := Start TO Max 
  DO
    Sieve[CurrentNumber] := TRUE;       
  {Решето Эратосфена}
  FOR CurrentNumber := Start TO Max 
  DO
    IF Sieve[CurrentNumber] 
    THEN
      BEGIN
        {Удаляем все кратные}
        Multiple := CurrentNumber * 2;
        WHILE Multiple <= Max 
        DO
          BEGIN
            Sieve[Multiple] := FALSE;
            Multiple := Multiple + CurrentNumber
          END
      END;     
  {Вывод простых чисел из диапазона}
  WRITE('Простые числа в диапазоне от ', Min, ' до ', Max, ' будут: ');        
  FOR CurrentNumber := Min TO Max
  DO
    IF Sieve[CurrentNumber]
    THEN
      WRITE(CurrentNumber, ' ')
END.
