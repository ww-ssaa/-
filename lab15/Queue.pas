UNIT Queue;
{Релизует очередь символов}
INTERFACE
  PROCEDURE CopyOpen(VAR F1, F2: TEXT); {Копирует строку из F1 в F2 без RESET или REWRITE}
  PROCEDURE EmptyQ; {Очищает очередь, делает её пустой}
  PROCEDURE AddQ(VAR Elt: CHAR); {Добавляет символ Elt в конец очереди}
  PROCEDURE DelQ; {Удаляет первый символ из очереди (если очередь не пуста)}
  PROCEDURE HeadQ(VAR Elt: CHAR); {Возвращает первый символ очереди в переменную Elt (не удаляя его)}
  PROCEDURE WriteQ; {Выводит содержимое очереди в OUTPUT}
IMPLEMENTATION
  VAR
    Q, TEMP: TEXT;

  PROCEDURE CopyOpen(VAR F1, F2: TEXT);
  {Копирует строку из F1 в F2 без RESET или REWRITE;
   таким образом F1 должен быть готов для чтения, а F2 для записи,
   но прошлые строки у этих файлов могут быть не пусты}
  VAR Ch: CHAR;
  BEGIN
    WHILE NOT EOLN(F1)
    DO
      BEGIN
        READ(F1, Ch);
        WRITE(F2, Ch)
      END
  END;

  PROCEDURE EmptyQ;
  {Очищает очередь, делает её пустой}
  BEGIN
    REWRITE(Q);
    WRITELN(Q);
    RESET(Q)
  END;

  PROCEDURE AddQ(VAR Elt: CHAR);
  {Добавляет символ Elt в конец очереди}
  VAR Temp: TEXT;
  BEGIN
    REWRITE(Temp);
    CopyOpen(Q, Temp);
    WRITE(Temp, Elt);
    WRITELN(Temp);
    RESET(Temp);
    REWRITE(Q);
    CopyOpen(Temp, Q);
    WRITELN(Q);
    RESET(Q)
  END;

  PROCEDURE DelQ;
  {Удаляет первый символ из очереди (если очередь не пуста)}
  VAR Ch: CHAR;
  BEGIN
    READ(Q, Ch);
    IF NOT EOF(Q)
    THEN {не пустой}
      BEGIN
        REWRITE(Temp);
        CopyOpen(Q, Temp);
        WRITELN(Temp);
        RESET(Temp);
        REWRITE(Q);
        CopyOpen(Temp, Q);
        WRITELN(Q)
      END;
    RESET(Q)
  END;

  PROCEDURE HeadQ(VAR Elt: CHAR);
  {Возвращает первый символ очереди в переменную Elt (не удаляя его). Если очередь пуста, возвращает '#'}
  BEGIN
    IF NOT EOLN(Q)
    THEN
      READ(Q, Elt)
    ELSE
      Elt := '#';
    RESET(Q)
  END;

  PROCEDURE WriteQ;
  {Выводит содержимое очереди в OUTPUT}
  BEGIN
    CopyOpen(Q, OUTPUT);
    WRITELN(OUTPUT);
    RESET(Q)
  END;

BEGIN
END.
