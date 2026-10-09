PROGRAM Split(INPUT, OUTPUT);
{Копирует INPUT в OUTPUT, сначала нечетные, а затем четные элементы}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;

PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
{DP 1.1. Копируем F1 в OUTPUT}
BEGIN
  RESET(F1);
  WHILE NOT EOF(F1) 
  DO
    BEGIN
      WHILE NOT EOLN(F1) 
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(Ch)
        END;
      READLN(F1)
    END
END;

BEGIN {DP 1.2. Разделяет INPUT в Odds и Evens}
  REWRITE(Odds);
  REWRITE(Evens);
  Next := 'O';
  WHILE NOT EOF 
  DO
    BEGIN
      WHILE NOT EOLN 
      DO
        BEGIN
          {DP 1.2.1. Прочитать Ch, записать в файл, выбранный через Next, переключить Next}
          READ(Ch);
          IF Next = 'O' 
          THEN
            BEGIN
              Next := 'E';
              WRITE(Odds, Ch)
            END  
          ELSE
            BEGIN
              WRITE(Evens, Ch);
              Next := 'O'      
            END
        END; 
      READLN;
      WRITELN(Odds);
      WRITELN(Evens)
    END;
  WRITELN(Odds);
  WRITELN(Evens);
  CopyOut(Odds, Ch); 
  CopyOut(Evens, Ch);
  WRITELN
END.
