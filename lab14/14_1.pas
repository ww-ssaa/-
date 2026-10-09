PROGRAM RunReverse(INPUT, OUTPUT);

PROCEDURE Reverse(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {Reverse} 
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Ch);
      Reverse(INPUT, OUTPUT);
      WRITE(OutFile, Ch)
    END 
END; {Reverse}

BEGIN {RunReverse}
  Reverse(INPUT, OUTPUT);
  WRITELN
END. {RunReverse}
