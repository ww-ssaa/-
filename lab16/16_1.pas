PROGRAM SortMonth(INPUT, OUTPUT);
USES DateIO;
VAR
  m1, m2: Month;

PROCEDURE OutMonth(VAR F: TEXT; m1, m2: Month; Flag: BOOLEAN);
BEGIN
  WriteMonth(F, m1);
  IF Flag 
  THEN
    WRITE(F, ' предшествует ')
  ELSE
    WRITE(F, ' следует за ');
  WriteMonth(F, m2);
  WRITELN(F);
END;

BEGIN
  ReadMonth(INPUT, m1);
  ReadMonth(INPUT, m2);

  IF (m1 = NoMonth) OR (m2 = NoMonth) 
  THEN
    WRITELN('¬ходные данные записаны неверно')
  ELSE 
    IF m1 < m2 
    THEN
      OutMonth(OUTPUT, m1, m2, TRUE)
    ELSE 
      IF m1 > m2 
      THEN
        OutMonth(OUTPUT, m1, m2, FALSE)
      ELSE
        BEGIN
          WRITE('ќба мес€ца ');
          WriteMonth(OUTPUT, m1);
          WRITELN;
        END;
END.
