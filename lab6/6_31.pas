PROGRAM SelectSort(INPUT, OUTPUT);
VAR
  Ch, Min: CHAR;
  F1: TEXT;
BEGIN {SelectSort}
  REWRITE(F1); {Копировать INPUT в F1 и эхо в OUTPUT}
  WRITE('INPUT: ');
  READ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(F1, Ch);
      WRITE(Ch);
      READ(Ch);
    END;
  WRITELN;
  WRITELN(F1, '#')
END. {SelectSort}
