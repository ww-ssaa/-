PROGRAM RunRCopy(INPUT, OUTPUT);

PROCEDURE RCopy(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {RCopy} 
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch);
      RCopy(INPUT, OUTPUT)
    END 
END; {RCopy}

BEGIN {RunRCopy}
  RCopy(INPUT, OUTPUT);
  WRITELN
END. {RunRCopy}
