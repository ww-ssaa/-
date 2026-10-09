{Копируем Evens в OUTPUT}
RESET(Evens);
READ(Evens, Ch);
WHILE (Ch <> '#')
DO
  BEGIN
    WRITE(OUTPUT, Ch);
    READ(Evens, Ch);
  END;
WRITELN(OUTPUT);
