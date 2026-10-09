PROGRAM BubbleSort(INPUT, OUTPUT); { Сортируем первую строку INPUT в OUTPUT }
PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  WHILE NOT EOLN(InFile) 
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END;
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2: TEXT;
BEGIN { BubbleSort }
  REWRITE(F1);  { Копируем INPUT в F1 }
  CopyFile (INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y';  {Копируем F1 в F2,проверяя отсортированность и переставляя первые соседнии символы по порядку}
      RESET(F1);
      REWRITE(F2);
      IF NOT EOLN(F1)
      THEN
        BEGIN
          READ(F1, Ch1);
          WHILE NOT EOLN(F1)
          DO { По крайней мере два символа остается для Ch1,Ch2 }
            BEGIN
              READ(F1, Ch2);
              IF Ch1 <= Ch2  {Выводим   min(Ch1,Ch2) в  F2, записывая отсортированные символы }
              THEN
                BEGIN
                  WRITE(F2, Ch1);
                  Ch1 := Ch2
                END
              ELSE
                BEGIN
                  WRITE(F2, Ch2);
                  Sorted := 'N'
                END
            END;
          WRITELN(F2, Ch1) { Выводим последний символ в F2 }
        END;
      RESET(F2);
      REWRITE(F1);  {Копируем F2 в F1}
      CopyFile (F2, F1);
    END;
  RESET(F1);
  CopyFile (F1, OUTPUT); {Копируем F1 в OUTPUT}
END.{ BubbleSort }
