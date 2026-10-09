PROGRAM InsertSort2 (INPUT, OUTPUT);
{Сортировка символов методом вставки в динамический связанный список}

TYPE 
  NodePtr = ^Node; {NodePtr как указатель на запись Node}
  Node = RECORD
           Next: NodePtr; {Указатель на следующий узел списка}
           Key: CHAR {Символ}
         END;

VAR
  FirstPtr, NewPtr: NodePtr; {FirstPtr - указатель на начало списка, NewPtr - указатель на новый символ}
  Curr, Prev: NodePtr; {Curr - символ до которого вставляем, Prev - символ после которого вставляем}
  Found: BOOLEAN; {Флаг нахождения позиции для вставки}

BEGIN {InsertSort2}
  FirstPtr := NIL;
  WHILE NOT EOLN
  DO
    BEGIN
      NEW(NewPtr); {Выделяем в памяти место под новый элемент Node и записываем его адрес в переменную NewPtr}
      READ(NewPtr^.Key);
      {2.1. Поместить NewPtr в надлежащее место}
      Prev := NIL;
      Curr := FirstPtr;
      Found := FALSE;
      {2.1.1 Найдем значение Prev и Curr, такие что Prev^.Key <= NewPtr^.Key <= Curr^.Key}
      WHILE (Curr <> NIL) AND (NOT Found)
      DO
        IF NewPtr^.Key > Curr^.Key
        THEN
          BEGIN
            Prev := Curr;
            Curr := Curr^.Next
          END
        ELSE
          Found := TRUE;
      {Связываем указатели для вставки элемента}
      NewPtr^.Next := Curr;
      IF Prev = NIL 
      THEN
        FirstPtr := NewPtr
      ELSE
        Prev^.Next := NewPtr
    END;
  READLN;
  {2.2. Печать значений начиная с FirstPtr^.Key}
  NewPtr := FirstPtr;
  WHILE NewPtr <> NIL
  DO
    BEGIN
      WRITE(NewPtr^.Key);
      NewPtr := NewPtr^.Next
    END;
  WRITELN
END.  {InsertSort2}
