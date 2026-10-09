PROGRAM SarahRevere(INPUT, OUTPUT);
{Распознаёт слова land или sea во входном потоке до символа '#'}
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN;

BEGIN {SarahRevere}
  {Инициализация окна и флагов}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := TRUE;
  Land := FALSE;
  Sea := FALSE;
  
  WHILE Looking AND NOT (Land OR Sea)
  DO
    BEGIN
      {движение окна}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      
      IF W4 = '#'
      THEN
        Looking := FALSE;
        
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
      Sea := (W1 = 's') AND (W2 = 'e') AND (W3 = 'a');
    END;
  IF Land
  THEN
    WRITELN('The British are coming by land.')
  ELSE 
    IF Sea
    THEN
      WRITELN('The British are coming by sea.')
    ELSE
      WRITELN('Sarah didn''t say.')
END.
