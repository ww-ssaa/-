{DP1}
PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
BEGIN {Split}
  {DP2}
  Next := 'O';
  REWRITE(Odds);
  REWRITE(Evens);
  READ(INPUT, Ch);
  WHILE (Ch <> '#')
  DO
    BEGIN
      IF Next = 'O'
      THEN
        BEGIN
          REWRITE(Odds, Ch);
          Next := 'E'
        END
      ELSE
        BEGIN
          WRITE(Evens, Ch);
          Next := 'O'
        END;
      WRITELN(Next);
      READ(INPUT, Ch)
    END;
  WRITELN(Odds, '#'); 
  WRITELN(Evens, '#');
  {DP3}
  RESET(Odds);
  READ(Odds, Ch);
  WHILE (Ch <> '#')
  DO
    BEGIN
      WRITE(OUTPUT, Ch);
      READ(Odds, Ch)
    END;
  WRITELN(OUTPUT);
  {DP4}
END. {Split}
