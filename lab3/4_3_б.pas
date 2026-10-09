PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := 'Y';
  WHILE Looking = 'Y'
  DO
    BEGIN
      IF W1 = 'l'
      THEN
        IF W2 = 'a'
        THEN
          IF W3 = 'n'
          THEN
            IF W4 = 'd'
            THEN
              Looking := 'L';
      IF W1 = 's'
      THEN
        IF W2 = 'e'
        THEN
          IF W3 = 'a'
          THEN
            Looking := 'S'
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      IF W4 = '#'
      THEN
        Looking := 'N';
    END;
    IF Looking = 'L'
      THEN
        WRITELN('The British are coming by land.')
      ELSE
        IF Looking = 'S'
        THEN
          WRITELN('The British are coming by sea.')
        ELSE
          WRITELN('Sarah didn''t say')
END.