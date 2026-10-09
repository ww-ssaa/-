PROGRAM TestRecursiveSort(INPUT, OUTPUT);
{Требовалось только собрать, поэтому Тест только для компиляции}
VAR
  F: TEXT;
  Ch: CHAR;

PROCEDURE Split(VAR F1, F2, F3: TEXT);
{Разбивает F1 на два файла F2 и F3, чередуя символы}
VAR
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
  {Копировать F1 попеременно в F2 и F3}
  Switch := '2';
  WHILE NOT(EOLN(F1))
  DO
    BEGIN
      READ(F1, Ch);
      IF Switch = '2'
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3'
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2'
        END
    END;
  WRITELN(F2);
  WRITELN(F3)
END; {Split}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
{Сливает F2, F3 в F1 в сортированном порядке}
VAR
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  READ(F2, Ch2);
  READ(F3, Ch3);
  WHILE (NOT(EOLN(F2))) AND (NOT(EOLN(F3)))
  DO
    BEGIN
      IF Ch2 < Ch3
      THEN
        BEGIN
          WRITE(F1, Ch2);
          READ(F2, Ch2)
        END
      ELSE
        BEGIN
          WRITE(F1, Ch3);
          READ(F3, Ch3)
        END
    END;
  {Копировать остаток F2 в F1}
  WHILE NOT(EOLN(F2))
  DO
    BEGIN
      READ(F2, Ch2);
      WRITE(F1, Ch2)
    END;
  {Копировать остаток F3 в F1}
  WHILE NOT(EOLN(F3))
  DO
    BEGIN
      READ(F3, Ch3);
      WRITE(F1, Ch3)
    END;
  WRITELN(F1)
END; {Merge}

PROCEDURE RecursiveSort(VAR F1: TEXT);
{Рекурсивная сортировка слиянием строки символов в файле F1}
VAR
  F2, F3: TEXT;
  Ch: CHAR;
  
BEGIN {RecursiveSort} 
  RESET(F1);
  IF NOT(EOLN(F1))
  THEN
    BEGIN
      READ(F1, Ch);
      IF NOT(EOLN(F1))
      THEN
        BEGIN
          RESET(F1);
          Split(F1, F2, F3);
          RecursiveSort(F2);
          RecursiveSort(F3);
          Merge(F1, F2, F3)
        END
    END
END; {RecursiveSort}

BEGIN {TestRecursiveSort}
  ASSIGN(F, 'test.txt');
  REWRITE(F);
  WRITE('Введите символы: ');
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(Ch);
      WRITE(F, Ch)
    END;
  WRITELN(F);
  CLOSE(F);
  RecursiveSort(F);
  RESET(F);
  WRITE('Результат сортировки: ');
  WHILE NOT EOLN(F)
  DO
    BEGIN
      READ(F, Ch);
      WRITE(Ch)
    END;
  WRITELN;
  CLOSE(F)
END. {TestRecursiveSort}
