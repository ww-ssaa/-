PROGRAM CountSym(INPUT,OUTPUT);
  
USES Count3;

VAR
  Ch, O, T, H: CHAR; 
BEGIN {CountSym}
  Start;
  WRITE('Ввод: ');          
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      Bump;
    END; 
  Value(O, T, H);
  IF (O = '9') AND (T = '9') AND (H = '9')
  THEN
    WRITELN ('Как минимум 999 символов')
  ELSE
    WRITELN('Колисчество символов ', O, T, H)
END.{CountSym}
