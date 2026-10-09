PROGRAM TestLexico(INPUT, OUTPUT);
{Лексикографическое сравнение. Пример: ABC < ABD, ABC < ABCD}
VAR
  F1, F2: TEXT;
  S1, S2: STRING;
  Result: CHAR;

PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
{Result 0, 1, 2 если лексикографический порядок F1 =, <, > чем F2       
соответственно. Фактические параметры, соответствующие F1 и F2,
должны быть различными}
VAR
  Ch1, Ch2: CHAR;
BEGIN
  RESET(F1);
  RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1)) AND (NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF Ch1 < Ch2 
      THEN
        Result := '1'
      ELSE 
        IF Ch1 > Ch2 
        THEN
          Result := '2'
    END;
  IF Result = '0' 
  THEN
    BEGIN
      IF EOLN(F1) AND EOLN(F2) 
      THEN
        Result := '0'        
      ELSE 
        IF EOLN(F1) 
        THEN
          Result := '1'       
        ELSE 
          Result := '2'      
    END
END;

BEGIN {TestLexico}
  WRITELN('Введите первую строку: ');
  READLN(S1);
  WRITELN('Введите вторую строку: ');
  READLN(S2);

  ASSIGN(F1, 'temp1.txt');
  ASSIGN(F2, 'temp2.txt');
  REWRITE(F1);
  WRITE(F1, S1);
  RESET(F1);
  REWRITE(F2);
  WRITE(F2, S2);
  RESET(F2);

  Lexico(F1, F2, Result);

  WRITE('Результат: ');
  IF Result = '0' 
  THEN
    WRITELN('Строки равны')
  ELSE 
    IF Result = '1' 
    THEN
      WRITELN('Первая строка меньше второй')
    ELSE 
      IF Result = '2' 
      THEN
        WRITELN('Первая строка больше второй');
  CLOSE(F1);
  CLOSE(F2)
END. {TestLexico}
