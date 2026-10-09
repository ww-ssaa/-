PROGRAM CountReverse(INPUT, OUTPUT);
{Считает количество реверсов в строке из 3-х и более символов}
USES Count3;

VAR
  Ch1, Ch2, Ch3, O, T, H: CHAR;
BEGIN
  Start;
  WRITE('Ввод: ');         
  
  IF NOT EOLN 
  THEN 
    READ(Ch1);
    
  IF NOT EOLN 
  THEN 
    READ(Ch2);
  
  WHILE NOT EOLN 
  DO
    BEGIN
      READ(Ch3);
      IF ((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3)) 
      THEN
        Bump;
      Ch1 := Ch2;
      Ch2 := Ch3
    END;
  Value(H, T, O);
  IF (H = '9') AND (T = '9') AND (O = '9') THEN
    WRITELN('Как минимум 999 реверсов')
  ELSE
    WRITELN('Реверсов: ', H, T, O)
END.
