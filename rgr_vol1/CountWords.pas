PROGRAM CountWords(INPUT, OUTPUT);

USES WordStats;

VAR
  InFile, OutFile: TEXT; {Переменные входного и выходного файла}
  InName, OutName: STRING; {Имена пользователя входного и выходного файлов}
  Ch: CHAR; {Текущий символ}
  CurrentWord: WordType; {Массив где накапливается собираемое слово}
  InWord: BOOLEAN; {Флаг. TRUE если уже внутри слова}

PROCEDURE AddCharToWord(VAR W: WordType; Ch: CHAR);
{В массив мы добавляем буквы слова слева направо. 
Каждый новый символ записывается в первую ячейку, которая ещё содержит пробел. 
После добавления буквы на её месте уже не пробел, и следующий символ пойдёт в следующую свободную позицию}
VAR 
  i: INTEGER;
BEGIN
  i := 1;
  WHILE (i <= MaxWordLen) AND (W[i] <> ' ')
  DO
    i := i + 1;
  IF i <= MaxWordLen
  THEN
    W[i] := Ch;
END;

FUNCTION IsValidWord(VAR W: WordType): BOOLEAN;
{Проверяет корректность слова: не пустое, не начинается и не заканчивается дефисом и не содержит двух дефисов подряд}
VAR 
  i, Len: INTEGER; 
  LastWasDash: BOOLEAN;
BEGIN
  Len := 1;
  WHILE (Len <= MaxWordLen) AND (W[Len] <> ' ')
  DO
    Len := Len + 1;
  Len := Len - 1;
  IF Len = 0
  THEN
    IsValidWord := FALSE {Пустое слово}
  ELSE 
    IF (W[1] = '-') OR (W[Len] = '-')
    THEN
      IsValidWord := FALSE {Начинается или заканчивается дефисом}
    ELSE
      BEGIN
        LastWasDash := FALSE;
        IsValidWord := TRUE;
        i := 2;
        WHILE i <= Len
        DO
          BEGIN
            IF W[i] = '-'
            THEN
              BEGIN
                IF LastWasDash
                THEN
                  IsValidWord := FALSE; {Два дефиса подряд} 
                LastWasDash := TRUE;
              END
            ELSE
             LastWasDash := FALSE;
             i := i + 1;
          END;
      END;
END;

BEGIN {CountWords}
  {Запись имен входного и выходного файла}
  WRITELN('Введите имя входного файла:');
  READLN(InName);
  WRITELN('Введите имя выходного файла:');
  READLN(OutName);
  {Связываем файлы с переменными. Открываем для чтения или записи}
  ASSIGN(InFile, InName);
  RESET(InFile);
  ASSIGN(OutFile, OutName);
  REWRITE(OutFile);
  
  InitWord(CurrentWord);
  InWord := FALSE;
  WHILE NOT EOF(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      IF IsWordChar(Ch) {Встретили символ который может быть частью слова}
      THEN
        BEGIN
          IF NOT InWord
          THEN
            InWord := TRUE; {Если не были в слове то начинаем новое}
          AddCharToWord(CurrentWord, Ch); {Добавляем символ в текущее слово}
        END
      ELSE {Встретили символ разделитель}
        BEGIN
          IF InWord {Были внутри слова и встретили разделитель, а значит слово кончилось}
          THEN
            BEGIN
              IF IsValidWord(CurrentWord)
              THEN
                AddWord(CurrentWord); {Если корректно добавляем в статистику}
              InitWord(CurrentWord); {Обнуление для нового}
              InWord := FALSE; {Сброс флага}
            END;
        END;
    END;
  IF InWord {Проверка на незаверщенное слово}
  THEN
    IF IsValidWord(CurrentWord)
    THEN
      AddWord(CurrentWord);
  {Сортировка и вывод}
  SortStats;
  WriteStats(OutFile);
  {Завершаем работу с файлами}
  CLOSE(InFile);
  CLOSE(OutFile);
  WRITELN('Статистика записана в файл ', OutName); {Вывод в консоль о завершении программы}
END. {CountWords}
