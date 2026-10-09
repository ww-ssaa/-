PROGRAM BubbleSort(INPUT, OUTPUT);
{Сортируем первую строку INPUT в OUTPUT}
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2: TEXT;
BEGIN {BubbleSort}
  REWRITE(F1); { Копируем INPUT в F1 }
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(Ch);
      WRITE(F1, Ch)
    END;
  WRITELN(F1);                          
  Sorted := 'N';
  WHILE Sorted ='N'
  DO
    BEGIN
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      Sorted := 'Y'
      { Копируем F2 в F1 }
    END;
  { Копируем F1 в OUTPUT }
  RESET(F1);
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(OUTPUT, Ch)
    END;
  WRITELN(OUTPUT)
END. {BubbleSort}
