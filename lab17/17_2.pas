PROGRAM TestReadNumber;
VAR
  Number: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  IF NOT EOLN
  THEN
    READ(F, Ch);
    IF Ch = '0' THEN D := 0 ELSE
    IF Ch = '1' THEN D := 1 ELSE
    IF Ch = '2' THEN D := 2 ELSE
    IF Ch = '3' THEN D := 3 ELSE
    IF Ch = '4' THEN D := 4 ELSE
    IF Ch = '5' THEN D := 5 ELSE
    IF Ch = '6' THEN D := 6 ELSE
    IF Ch = '7' THEN D := 7 ELSE
    IF Ch = '8' THEN D := 8 ELSE
    IF Ch = '9' THEN D := 9 ELSE
    D := -1
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  N := 0;
  ReadDigit(F, Digit);
  IF Digit = -1 
  THEN
    N := -1
  ELSE
    BEGIN
      WHILE (Digit <> -1) AND (N <> -2) 
      DO
        BEGIN
          IF (N > MAXINT DIV 10) OR ((N = MAXINT DIV 10) AND (Digit > MAXINT MOD 10)) 
          THEN
            N := -2
          ELSE
            N := N * 10 + Digit;
            ReadDigit(F, Digit);
        END;
    END
END; {ReadNumber}

BEGIN {TestReadNumber}
  WRITELN('Введите число (только цифры):');
  ReadNumber(INPUT, Number);
  IF Number = -1 
  THEN
    WRITELN('Ошибка: ввод начинается не с цифры')
  ELSE 
    IF Number = -2 
    THEN
      WRITELN('Ошибка: число превышает допустимый диапазон')
    ELSE
      WRITELN('Прочитано число: ', Number)
END. {TestReadNumber}
