PROGRAM InsertionSort(INPUT, OUTPUT);
{Сортирует символы из INPUT методом вставки в связанный список внутри массива}

CONST
  Max = 16; {Максимальный размер списка}
  ListEnd = 0; {Маркер конца связанного списка (нулевой указатель)}

TYPE
  RecArray = ARRAY [1 .. Max] OF RECORD
                                   Key: CHAR; {Символ}
                                   Next: 0 .. Max; {Следующий элемент списка}
                                 END;

VAR
  Arr: RecArray; {Массив для элементов списка}
  First, Index: 0 .. Max; {First - указатель на начало списка, Index - счетчик занятых ячеек в массиве}
  Prev, Curr: 0 .. Max; {Prev - символ после которого вставляем, Curr - до которого}
  Extra: CHAR; {Временный символ для считывания и отброса лишнего ввода}
  Found: BOOLEAN; {Флаг успешного нахождения позиции для вставки}

BEGIN {InsertionSort}
  First := 0;
  Index := 0;
  WHILE NOT EOLN
  DO
    BEGIN {Помещать запись в список, если позволяет пространство, иначе игнорировать и сообщать об ошибке}
      Index := Index + 1;
      IF Index > Max
      THEN
        BEGIN
          {Превышен лимит массива: считываем символ во избежание зависания, но игнорируем его}
          READ(Extra);
          WRITELN('Сообщение содержит: ', Extra, '. Игнорируем.')
        END
      ELSE
        BEGIN
          {Считываем символ в очередную свободную ячейку массива}
          READ(Arr[Index].Key);
          
          {Найти значения Prev и Curr, если существуют такие, что Arr[Prev].Key <= Arr[Index].Key <= Arr[Curr].Key}
          Prev := 0;
          Curr := First;
          
          {Без DP 1.1.1 - Найти значения Prev и Curr, если существуют такие что Arr[Prev].Key  <= Arr[Index].Key <= Arr[Curr].Key}
          
          {Вставляем запись в связанный список путем перенаправления указателей}
          Arr[Index].Next := Curr;
          IF Prev = 0
          THEN
            {Вставка в самое начало списка}
            First := Index
          ELSE
            {Вставка между элементами Prev и Curr}
            Arr[Prev].Next := Index
        END
    END; 
  {Печать отсортированного списка начиная с элемента Arr[First] по цепочке}
  Index := First;
  WHILE Index <> ListEnd
  DO
    BEGIN
      WRITE(Arr[Index].Key);
      Index := Arr[Index].Next
    END;
  WRITELN
END. {InsertionSort}
