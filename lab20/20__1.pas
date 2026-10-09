PROGRAM PseudoGraphicPrint(INPUT, OUTPUT);
{Программа для псевдо-графической печати введенных символов}
CONST
  Size = 5; {Размер матрицы символа}
  MSet = [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
  PSet = [1, 2, 3, 4, 6, 10, 11, 12, 13, 14, 16, 21];
  CSet = [1, 2, 3, 4, 5, 6, 10, 11, 16, 20, 21, 22, 23, 24, 25];
  SSet = [1, 2, 3, 4, 5, 6, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25];

TYPE
  MatrixType = SET OF 1..(Size * Size); {Множество для хранения позиций символа матрицы}

FUNCTION ReadLetter(VAR F: TEXT; VAR Ch: CHAR): BOOLEAN;
{Читает исходный символ}
BEGIN 
  IF EOLN(F)
  THEN
    ReadLetter := FALSE
  ELSE
    BEGIN 
      ReadLetter := TRUE;
      READ(F, Ch)
    END
END; 

FUNCTION GetMatrix(Ch: CHAR): MatrixType;
{Возвращает множество позиций для введённого символа} 
BEGIN
  CASE Ch OF 
    'M': GetMatrix := MSet; 
    'P': GetMatrix := PSet; 
    'C': GetMatrix := CSet; 
    'S': GetMatrix := SSet; 
  ELSE 
    GetMatrix := [] 
  END 
END; 

PROCEDURE PrintMatrix(VAR FOut: TEXT; MatPos: MatrixType);
{Выводит нужную матрицу}
VAR
  Row, Col, Pos: INTEGER; 
  {Row - строка матрицы, Col - столбец матрицы, Pos - текущая позиция в матрице} 
BEGIN 
  FOR Row := 1 TO Size
  DO
    BEGIN
      FOR Col := 1 TO Size
      DO
        BEGIN
          Pos := (Row - 1) * Size + Col;
          IF Pos IN MatPos
          THEN
            WRITE(FOut, 'X')
          ELSE
            WRITE(FOut, ' ');
        END;
      WRITELN(FOut)
    END
END; 

{PseudoGraphicPrint}
VAR
  Ch: CHAR; {Символ пользователя}
  Mat: MatrixType; {Матрица для печати}
BEGIN
  WRITELN('Можно вводить символы M P C S в верхнем регистре (один или подряд без пробелов)');
  WRITELN('Пустая строка завершает программу');
  WRITE('Введите символ(ы): ');
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN  
      WHILE ReadLetter(INPUT, Ch)
      DO
        BEGIN
          Mat := GetMatrix(Ch);
          IF Mat = []
          THEN
            WRITELN('Ошибка: неверный символ - ''', Ch, '''')
          ELSE
            BEGIN
              PrintMatrix(OUTPUT, Mat);
              WRITELN
            END
        END;
      READLN; {Завершает обработку текущей строки}
      WRITE('Введите символ(ы): ')
    END
END. {PseudoGraphicPrint}
