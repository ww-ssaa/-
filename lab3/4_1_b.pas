PROGRAM PaulRevere(INPUT, OUTPUT);
VAR
  Lanterns: CHAR;
  Dir: CHAR;
BEGIN
  READ(Lanterns);
  IF Lanterns = '1'
  THEN
    Dir := 'L'
  ELSE
    IF Lanterns = '2'
    THEN
      Dir := 'S'
    ELSE
      Dir := 'N';
  IF Dir <> 'N'
  THEN
    WRITE('The British are coming by ');
    IF Dir = 'L'
    THEN
      WRITELN('land.');
    IF Dir = 'S'
    THEN
      WRITELN('sea.')
  ELSE
    WRITELN('The North Church shows only ''', Lanterns, '''.')
END.
