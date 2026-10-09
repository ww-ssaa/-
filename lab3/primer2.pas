{DP1}
PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN
  WHILE Looking = 'Y'
  DO
    BEGIN

    END;

END.

{DP1.1}
BEGIN
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := 'Y';
END;

{DP1.2}
BEGIN
 W1 := W2;
 W2 := W3;
 W3 := W4;
 READ(W4);
 IF W4 = '#'
 THEN
   Looking := 'N'
END;

{DP1.3}
BEGIN
  IF W1 = 'l'
  THEN
    IF W2 = 'a'
    THEN
      IF W3 = 'n'
      THEN
        IF W4 = 'd'
        THEN
          Looking := 'L'
END;

{DP1.4}
BEGIN
  IF W2 = 's'
    THEN
      IF W3 = 'e'
      THEN
        IF W4 = 'a'
        THEN
          Looking := 'S'
END;

{DP1.5}
BEGIN
  IF Looking = 'L'
  THEN
    WRITELN('The British are coming by land.')
  ELSE
    IF Looking = 'S'
    THEN
      WRITELN('The British are coming by sea.')
    ELSE
      WRITELN('Sarah didn''t say')
END;