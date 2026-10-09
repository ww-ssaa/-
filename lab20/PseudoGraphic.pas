UNIT PseudoGraphic;

INTERFACE

CONST
  Size = 5; {Размер матрицы символа}
  MaxLen = 10; {Максимальная длина выводимой строки}
  CharPixels = Size * Size; {Общее число пикселей в одном символе}
  LinePixels = MaxLen * CharPixels; {Максимальное число пикселей во всей строке}

TYPE
  MatrixType = SET OF 1 .. CharPixels; {Множество для хранения позиций символа матрицы}
  LineSetType = SET OF 1 .. LinePixels; {Множество для хранения позиций всей строки}
  StrArrayType = ARRAY[1 .. MaxLen] OF CHAR; {Массив для хранения символов входной строки}
  SupportedArray = ARRAY[CHAR] OF BOOLEAN; {Связывает символы с TRUE/FALSE}


FUNCTION ReadLetter(VAR F: TEXT; VAR Ch: CHAR): BOOLEAN; {Читает исходный символ}
FUNCTION GetMatrix(Ch: CHAR): MatrixType; {Возвращает множество позиций для введённого символа} 
PROCEDURE PrintMatrix(VAR FOut: TEXT; VAR LineSet: LineSetType; Len: INTEGER); {Выводит собранную строку матриц горизонтально}
PROCEDURE LoadAlphabet; {Загружает множества символов из файла CHARS.TXT}
PROCEDURE BuildLineSet(VAR Str: StrArrayType; Len: INTEGER; VAR LineSet: LineSetType); {Заносит все псевдографические символы строки в одно множество}


IMPLEMENTATION

VAR
  Alphabet: ARRAY[CHAR] OF MatrixType; {Хранит таблицы матриц символов}
  Supported: SupportedArray; {Флаг наличия символа в алфавите}

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
  IF Supported[Ch]
  THEN
    GetMatrix := Alphabet[Ch]
  ELSE 
    GetMatrix := [] 
END; 

PROCEDURE PrintMatrix(VAR FOut: TEXT; VAR LineSet: LineSetType; Len: INTEGER);
{Выводит собранную строку матриц горизонтально}
VAR
  Row, Col, Pos, ChIdx: INTEGER;
  {Row - строка матрицы, Col - столбец матрицы, Pos - текущая позиция в матрице, ChIdx - номер символа в строке}  
BEGIN 
  FOR Row := 1 TO Size
  DO
    BEGIN
      FOR ChIdx := 1 TO Len
      DO
        BEGIN
          FOR Col := 1 TO Size
          DO
            BEGIN
              Pos := ((ChIdx - 1) * CharPixels) + ((Row - 1) * Size + Col); {Сдвиг по букве И вычисление точки в самой букве}
              IF Pos IN LineSet
              THEN
                WRITE(FOut, 'X')
              ELSE
                WRITE(FOut, ' ')
            END;
          {Отделяем буквы пробелом при печати}
          IF ChIdx < Len
          THEN
            WRITE(FOut, ' ')
        END;
      WRITELN(FOut)
    END
END; 

PROCEDURE LoadAlphabet;
{Загружает множества символов из файла CHARS.TXT}
VAR
  FChar: TEXT; {Переменная для связи файла}
  Ch: CHAR; {Символ}
  Mat: MatrixType; {Хранит матрицу текущего символа}
  PosNum: INTEGER; {Временная переменная для считывания точек буквы}
BEGIN
  {Обьявляем пробел как поддерживаемый символ}  
  Alphabet[' '] := [];
  Supported[' '] := TRUE;
  
  ASSIGN(FChar, 'CHARS.TXT');
  RESET(FChar);
  WHILE NOT EOF(FChar) {Помечаются поддерживаемыми только символы входящие в файл}
  DO
    BEGIN
      IF NOT EOLN(FChar)
      THEN
        BEGIN
          READ(FChar, Ch);
          Mat := [];
          WHILE NOT EOLN(FChar)
          DO
            BEGIN
              READ(FChar, PosNum);
              Mat := Mat + [PosNum]
            END;
          Alphabet[Ch] := Mat;
          Supported[Ch] := TRUE
        END;
      READLN(FChar)
    END;
  CLOSE(FChar)
END; 

PROCEDURE BuildLineSet(VAR Str: StrArrayType; Len: INTEGER; VAR LineSet: LineSetType);
{Заносит все псевдографические символы строки в одно множество}
VAR
  ChIdx, Pos: INTEGER; {ChIdx - номер символа в строке, Pos - текущая позиция в матрице символа}  
  Ch: CHAR; {Символ}
  Mat: MatrixType; {Хранит матрицу текущего символа}
BEGIN
  LineSet := [];
  FOR ChIdx := 1 TO Len
  DO
    BEGIN
      Ch := Str[ChIdx];
      Mat := GetMatrix(Ch);      
      {Если символ не поддерживается, заменяем его на квадрат 5х5}
      IF (Mat = []) AND (NOT Supported[Ch])
      THEN
        BEGIN
          Mat := [1 .. CharPixels];
          WRITELN(OUTPUT, 'Ошибка: символ ''', Ch, ''' не поддерживается.')
        END;
      {Соединяем множества символов в одно большое}
      FOR Pos := 1 TO CharPixels
      DO
        BEGIN
          IF Pos IN Mat
          THEN
            LineSet := LineSet + [(ChIdx - 1) * CharPixels + Pos]
        END
    END
END; 

BEGIN
END.
