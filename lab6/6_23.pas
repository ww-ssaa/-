PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
BEGIN {Split}
  READ(Ch);
  Next := 'O';
  REWRITE(Odds);
  REWRITE(Evens);
  WHILE Ch <> '#'
  DO
    BEGIN
      IF Next = 'O' {Копируем нечетные в Odds}
      THEN
        BEGIN
          WRITE(Odds, Ch);
          Next := 'E'
        END
      ELSE {Копируем четные в Evens}
        BEGIN
          WRITE(Evens, Ch);
          Next := 'O'
        END;
      READ(Ch)
    END;
  WRITE(Odds, '#');
  WRITE(Evens, '#');
  RESET(Odds); {Выводим Odds}
  READ(Odds, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      READ(Odds, Ch)
    END;
  WRITELN;
  RESET(Evens); {Выводим Evens}
  READ(Evens, Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      READ(Evens, Ch)
    END;
  WRITELN
END. {Split}
      
  
