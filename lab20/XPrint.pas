PROGRAM XPrint(INPUT, OUTPUT);

USES PseudoGraphic;

VAR
  Ch: CHAR; {Символ}
  LineSet: LineSetType; {Множество для печати всей строки}
  Str: StrArrayType; {Массив для хранения введенных символов строки}
  Len: INTEGER; {Текущая длина строки}

BEGIN {XPrint}
  LoadAlphabet;
  WRITELN('Можно вводить заглавные символы латинской раскладки');
  WRITELN('Ограничение ', MaxLen ,' символов подряд (пробел считается как символ)');
  WRITELN('Пустая строка завершает программу');
  WRITELN;
  WRITE('Введите символ(ы): ');
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN  
      Len := 0;
      {Читаем символы строки через ReadLetter}
      WHILE (Len < MaxLen) AND ReadLetter(INPUT, Ch)
      DO
        BEGIN
          Len := Len + 1;
          Str[Len] := Ch
        END;
      {Проверка на превышение лимита}
      IF NOT EOLN(INPUT)
      THEN
        BEGIN
          WRITE(OUTPUT, 'Ошибка: превышен лимит длины строки(', MaxLen,'). Отброшены символы: ''');
          {Посимвольно считываем и выводим лишние буквы}
          WHILE NOT EOLN(INPUT)
          DO
            BEGIN
              READ(INPUT, Ch);
              WRITE(OUTPUT, Ch)
            END;
          WRITELN(OUTPUT, '''. Вывод без отброшенных символов:')
        END;
      READLN(INPUT);  
      {Создание и печать}
      IF Len > 0
      THEN
        BEGIN
          BuildLineSet(Str, Len, LineSet);
          WRITELN;
          PrintMatrix(OUTPUT, LineSet, Len);
          WRITELN
        END;
      WRITE('Введите символ(ы): ')
    END
END. {XPrint}
