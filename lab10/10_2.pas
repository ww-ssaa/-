{10.2а - Ерошенко Тимофей ПС-11}
PROGRAM Formatizing(INPUT, OUTPUT);
VAR
  Ch, State, L1, L2, L3, L4, L5: CHAR;
  {Сстояния State: 
  'I' - Инициализация (изначальное состояние)
  'B' - Внутри BEGIN
  'O' - Внутри оператора (READ, WRITE...)
  'N' - Новая строка
  'S' - Обработка пробела
  'E' - Обработка END}
BEGIN
  State := 'I';
  L1 := ' '; 
  L2 := ' '; 
  L3 := ' '; 
  L4 := ' '; 
  L5 := ' ';
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      IF State = 'I' {Инициализация}
      THEN
        BEGIN
          IF Ch = ' ' {Убираем пробелы перед BEGIN}
          THEN
            {}
          ELSE
            WRITE(Ch); 
          {Перезаписываем значения, т.е. двигаем "окно"}
          L5 := L4; 
          L4 := L3; 
          L3 := L2; 
          L2 := L1; 
          L1 := Ch;
          IF (L5 = 'B') AND (L4 = 'E') AND (L3 = 'G') AND (L2 = 'I') AND (L1 = 'N')
          THEN              
            State := 'B' {Внутри BEGIN}
        END
      ELSE
        IF State = 'B' {Если внутри BEGIN => пропускаем пробелы => ищем первый оператор или END}
        THEN
          BEGIN 
            IF Ch = ' '
            THEN
              {Пропуск пробелов, поэтому ничего не делаем}
            ELSE
              IF Ch = 'E' {Возможно, начинается END}
              THEN
                BEGIN
                  WRITELN;
                  WRITE(Ch);
                  State := 'E' {Обработка END}
                END
              ELSE {Это начало первого оператора}
                BEGIN
                  WRITELN;
                  WRITE('  ', Ch);
                  State := 'O' {Перешли в состояние внутри оператора}
                END
          END
        ELSE
          IF State = 'O' {Внутри оператора -> выводим символы}
          THEN
            BEGIN
              IF Ch = ';' {Конец оператора}
              THEN
                BEGIN 
                  WRITE(Ch);
                  WRITELN;
                  State := 'N' {Новая строка после точки с запятой}
                END
              ELSE
                IF Ch = ' '
                THEN
                  State := 'S' {Проверка пробелов}
                ELSE
                  WRITE(Ch);    
            END
          ELSE
            IF State = 'N' {После точки с запятой -> пропускаем пробелы}
            THEN
              BEGIN
                IF Ch = ' '
                THEN
                  {Пропуск пробелов, поэтому ничего не делаем}
                ELSE
                  IF Ch = 'E' {Возможно, начинается END}
                  THEN
                    BEGIN
                      WRITE(Ch);
                      State := 'E' {Перешли в состояние END}
                    END
                  ELSE {Если начало следующего оператора}
                    BEGIN
                      WRITE('  ', Ch);
                      State := 'O' {Перешли в состояние внутри оператора}
                    END
              END
            ELSE
              IF State = 'S' {Внутри оператора, предыдущий символ был пробел}
              THEN
                BEGIN
                  IF Ch = ' '
                  THEN
                    {Пропускаем пробелы}
                  ELSE
                    IF Ch = 'E' {Возможно, начинается END}
                    THEN
                      BEGIN
                        WRITE(Ch);
                        State := 'E' {Перешли в состояние обработки END}
                      END
                    ELSE {Пробел внутри оператора -> не конец}
                      BEGIN
                        WRITE(' ', Ch);
                        State := 'O' {Вернулись в состояние внутри оператора}
                      END
                END
              ELSE
                IF State = 'E' {Обрабатываем END.}
                THEN
                  BEGIN 
                    WRITELN;
                    WRITE(Ch);
                    IF Ch = '.'
                    THEN
                      State := 'I' {Вернулись в инициализацию}
                  END
    END
END.
