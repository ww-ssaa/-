PROGRAM SelectSort(INPUT, OUTPUT); {Сортирует символы, предшествующие #, из INPUT в OUTPUT. Программа выдаст ошибку, если в INPUT отсутствует #}
VAR
  Ch, Min: CHAR;
  F1, F2: TEXT;
BEGIN {SelectSort}
  REWRITE(F1); {Копировать INPUT в F1 и эхо в OUTPUT}
  WRITE('Input: ');
  READ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(F1, Ch);
      WRITE(Ch);
      READ(Ch);
    END;
  WRITELN;
  WRITELN(F1, '#');
  WRITE('Sorted: '); {Сортировать F1 в OUTPUT, используя стратегию SelectSort}
  RESET(F1);
  READ(F1, Ch);
  WHILE Ch <> '#'
  DO {Ch <> '#' и Ch1 – первый символ F1}
    BEGIN
      REWRITE(F2); {Выбираем минимальный из F1 и копируем остаток F1 в F2}
      Min := Ch;
      READ(F1, Ch);
      WHILE Ch <> '#'
      DO {Ch <> '#' и Ch1 – первый символ F1}
        BEGIN {Выбираем минимальный из (Ch, Min) копируем второй символ в F2}
          IF Ch < Min
          THEN  {Ch – минимальный из (Ch, Min)}
            BEGIN
              WRITE(F2, Min);
              Min := Ch;
            END
          ELSE {Min – минимальный из (Ch, Min)}
            WRITE(F2, Ch);
          READ(F1, Ch)
        END;
      WRITELN(F2, '#');
      WRITE(Min);
      RESET(F2); {Копируем F2 в F1}
      REWRITE(F1);
      READ(F2, Ch);
      WHILE Ch <> '#'
      DO
        BEGIN
          WRITE(F1, Ch);
          READ(F2, Ch)
        END;
      WRITELN(F1, '#');
      RESET(F1);
      READ(F1, Ch)
    END;
  WRITELN
END. {SelectSort}
