PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds: TEXT;
BEGIN {Split}
  READ(Ch);
  Next := 'O';
  REWRITE(Odds);
  WHILE Ch <> '#'
  DO
    BEGIN
      IF Next = 'O' {Копируем нечетные в Odds} 
      THEN
        BEGIN
          WRITE(Odds, Ch);
          Next := 'E'
        END
      ELSE
        Next := 'O';
      READ(Ch)
    END;
  WRITE(Odds, '#');
  RESET(Odds); {Выводим Odds}
  READ(Odds, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      READ(Odds, Ch)
    END;
  WRITELN
END. {Split}
      
  
