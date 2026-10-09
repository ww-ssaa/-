{Разбиваем INPUT на Odds и Evens}
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
        Next := 'E';
      END
    ELSE
      BEGIN
        WRITE(Evens, Ch);
        Next := 'O';
      END;
    READ(INPUT, Ch);
  END;
WRITELN(Odds, '#');
WRITELN(Evens, '#');
