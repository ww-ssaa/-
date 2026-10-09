PROGRAM PaulRevere(INPUT, OUTPUT);
VAR
  Lanterns: CHAR;
BEGIN
  READ(Lanterns);
  IF Lanterns = 'F'
  THEN
    BEGIN
      READ(Lanterns);
      IF Lanterns = 'F'
      THEN
        WRITELN('The British are coming by sea.')
      ELSE
        WRITELN('The British are coming by land.')
    END
  ELSE
    WRITELN('The North Church shows only ''', Lanterns, '''.')
END.
