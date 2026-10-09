PROGRAM TestRemove(INPUT, OUTPUT);
{Читает строку из входа, пропускает ее через RemoveExtraBlanks}
USES Queue;
VAR
  Ch: CHAR;

PROCEDURE RemoveExtraBlanks;
{Удаляет лишниe пробелы между словами на одной строке}
VAR
  Ch, Blank, LineEnd: CHAR;
  JustReadWord: BOOLEAN;
BEGIN {RemoveExtraBlanks}
  Blank := ' ';
  LineEnd := '$';
  AddQ(LineEnd);             
  HeadQ(Ch);
  JustReadWord := FALSE;
  WHILE Ch <> LineEnd 
  DO
    BEGIN
      IF Ch = Blank {Удаление ведущих пробелов}
      THEN
        BEGIN
          DelQ;
          HeadQ(Ch)
        END
      ELSE {Если не пробел, то читаем слово}
        BEGIN
          IF JustReadWord {Если слово прочитано, то добавляем пробел между словами} 
          THEN
            AddQ(Blank);           
          WHILE (Ch <> Blank) AND (Ch <> LineEnd) 
          DO
            BEGIN
              AddQ(Ch);
              DelQ;
              HeadQ(Ch)
            END;
          JustReadWord := TRUE
        END
    END;
  DelQ
END; {RemoveExtraBlanks}

BEGIN {TestRemove}
  EmptyQ;
  WRITE('Вход: ');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch)
    END;
  WRITELN;
  RemoveExtraBlanks;
  WRITE('Выход: ');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN('#')
END. {TestRemove}
