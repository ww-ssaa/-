PROGRAM Split(INPUT, OUTPUT);
VAR
  Ch, Next: CHAR;
BEGIN {Split}
  READ(Ch);
  WRITELN('Input: ');
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      READ(Ch) 
    END; 
  WRITELN
END. {Split}
