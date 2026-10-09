PROGRAM PaulRevere(INPUT, OUTPUT);
VAR
  Lanterns: CHAR;
BEGIN
  READ(Lanterns);
  IF Lanterns = '1'
  THEN
    WRITELN('The British are coming by land.')
  ELSE
    IF Lanterns = '2'
    THEN
      WRITELN('The British are coming by sea.')
    ELSE
      IF Lanterns = '3'
      THEN
        WRITELN('The British are coming by air.')
      ELSE
        WRITELN('The North Church shows only ''', Lanterns, '''.')
END.