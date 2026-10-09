PROGRAM What(INPUT, OUTPUT);
{Цифра или нет?}
VAR
  Ch: CHAR;
BEGIN
  READ(Ch);
  IF '0' <= Ch
  THEN
    IF Ch <= '9'
    THEN
      WRITELN('YES ', Ch, ' - цифра!')
    ELSE
      WRITELN('NO ', Ch, ' - не цифра!')
  ELSE
  WRITELN('NO ', Ch, ' - не цифра!')
END.
