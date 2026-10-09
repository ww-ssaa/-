UNIT Processors;
{Имеет в себе две процедуры для обработки символа и фала}
INTERFACE
  USES WordTypeDef;
  
  PROCEDURE FlushWord(VAR W: WordType; VAR InWord: BOOLEAN); {Завершает текущее слово}
  PROCEDURE ProcessChar(Ch: CHAR; VAR InWord: BOOLEAN; VAR W: WordType); {Обрабатывает один символ}
  PROCEDURE ProcessFile(VAR InFile, OutFile: TEXT; OutName: STRING); {Обрабатывает файлы}
  
IMPLEMENTATION
  USES WordProcessing, WordStats;
  
  PROCEDURE FlushWord(VAR W: WordType; VAR InWord: BOOLEAN);
  {Завершает текущее слово: если слово существует и корректно, 
  добавляет его в статистику, затем обнуляет массив и сбрасывает флаг}
  BEGIN
    IF InWord AND IsValidWord(W)
    THEN
      AddWord(W);
    InitWord(W);
    InWord := FALSE;
  END;

  PROCEDURE ProcessChar(Ch: CHAR; VAR InWord: BOOLEAN; VAR W: WordType);               
  {Обрабатывает один символ: если символ может быть частью слова, то добавляет его к текущему слову,
   иначе завершает текущее слово (если оно было) и подготавливает буфер для следующего}
  BEGIN
    IF IsWordChar(Ch) {Встретили символ, который может быть частью слова}
    THEN
      BEGIN
        IF NOT InWord {Если не были в слове, то начинаем новое}
        THEN
          InWord := TRUE;
        AddCharToWord(W, Ch);
      END
    ELSE {Встретили символ-разделитель}
      FlushWord(W, InWord);
  END;
  
  PROCEDURE ProcessFile(VAR InFile, OutFile: TEXT; OutName: STRING);
  {Читает входной файл посимвольно, выделяет слова, добавляет их в статистику,
  затем выводит отсортированную статистику в выходной файл.}
  VAR
    Ch: CHAR;
    CurrentWord: WordType;
    InWord: BOOLEAN;
  BEGIN
    InitWord(CurrentWord);
    InWord := FALSE;
       
    WHILE (NOT EOF(InFile)) OR InWord
      DO
        BEGIN
          IF NOT EOF(InFile)
          THEN
            BEGIN
              READ(InFile, Ch);
              ProcessChar(Ch, InWord, CurrentWord);
            END
          ELSE
            FlushWord(CurrentWord, InWord); 
        END;
        
    WriteStats(OutFile);

    CLOSE(InFile);
    CLOSE(OutFile);
    WRITELN('Статистика записана в файл ', OutName);
  END;    
  
END.
