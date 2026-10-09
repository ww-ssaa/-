UNIT WordStats;
{Содержит процедуры для работы со статистикой слов: добавление, поиск, вставка в список, вывод}
INTERFACE
  USES WordTypeDef;       

  FUNCTION FindWordIndex(VAR Lower: WordType): INTEGER; {Ищет индекс слова и возвращает сам индекс}
  PROCEDURE IncrementCount(Index: INTEGER); {Увеличивает счётчик}
  PROCEDURE InsertInOrder(NewIndex: INTEGER); {Вставляет новый элемент в связанный список, сохраняя алфавитный порядок}
  PROCEDURE AddNewWord(VAR Lower: WordType); {Добавляет новое слово в конец массива}
  PROCEDURE AddWord(VAR W: WordType); {Добавляет слово в массив статистики}
  PROCEDURE WriteWord(VAR F: TEXT; VAR W: WordType; Cnt: INTEGER); {Выводит одно слово и его счётчик в файл}
  PROCEDURE WriteStats(VAR F: TEXT); {Выводит статистику в файл}
 
IMPLEMENTATION
  USES WordProcessing;

  FUNCTION FindWordIndex(VAR Lower: WordType): INTEGER;
  {Ищет слово Lower в массиве Stats. Возвращает индекс, если найдено. Иначе 0}
  VAR 
    I, Res: INTEGER;
  BEGIN
    I := 1;
    Res := 0;
    WHILE (I <= StatsCount) AND (Res = 0)
    DO
      BEGIN
        IF WordEqual(Stats[I].Word, Lower)
        THEN
          Res := I;
        I := I + 1;
      END;
    FindWordIndex := Res;
  END;

  PROCEDURE IncrementCount(Index: INTEGER);
  {Увеличивает счётчик найденного слова на 1}
  BEGIN
    Stats[Index].Count := Stats[Index].Count + 1;
  END;
  
  PROCEDURE InsertInOrder(NewIndex: INTEGER);
  {Вставляет новый элемент с индексом NewIndex в список по алфавиту. 
  Перебирает список от начала (First) до конца, сравнивая слова. 
  Находит позицию где новое слово должно быть перед текущим (Curr). 
  Затем корректирует указатели: новый элемент -> Curr, а предыдущий (если есть) –> на новый. 
  Если элемент вставляется в начало, обновляет First}
    VAR 
      Prev, Curr: INTEGER; {Prev - слово после которого вставляем, Curr - до которого}
    BEGIN
      Prev := 0; {0 - конец списка}
      Curr := First;
      WHILE (Curr <> 0) AND WordLess(Stats[Curr].Word, Stats[NewIndex].Word) {Не конец и текущее слово должно быть раньше нового}
      DO
        BEGIN {Если текущее < нового, значит новое должно быть после текущего}
          Prev := Curr;
          Curr := Stats[Curr].Next; 
        END;
      Stats[NewIndex].Next := Curr; {Даем индекс новому слову после предыдущего}
      IF Prev = 0 {Если предыдущего нет, значит мы в начале}
      THEN
        First := NewIndex {Если в начале то делаем этот индекс первым}
      ELSE
        Stats[Prev].Next := NewIndex; {Если не в начале то следующим} 
    END;  

  PROCEDURE AddNewWord(VAR Lower: WordType);
  {Добавляет новое слово в конец массива, ставит параметры по умолчанию и вставляет в отсортированный список}
  BEGIN
    StatsCount := StatsCount + 1;
    Stats[StatsCount].Word := Lower;
    Stats[StatsCount].Count := 1;
    Stats[StatsCount].Next := 0;
    InsertInOrder(StatsCount);
  END;

  PROCEDURE AddWord(VAR W: WordType);
  {Получает слово. Приводит его к нижнему регистру (LowerCaseWord). 
  Ищет в массиве Stats среди уже добавленных уникальных слов. 
  Если находит такое же, то увеличивает его счётчик на 1. 
  Иначе, добавляет новую запись в конец массива и вставляет в список по алфавиту}
  VAR 
    Lower: WordType;
    Index: INTEGER;
  BEGIN
    Lower := W;
    LowerCaseWord(Lower);
    Index := FindWordIndex(Lower);
    IF Index <> 0
    THEN
      IncrementCount(Index)
    ELSE
      AddNewWord(Lower);
  END;
  
  PROCEDURE WriteWord(VAR F: TEXT; VAR W: WordType; Cnt: INTEGER);
  {Выводит одно слово (до первого пробела) и его счётчик в файл}
  VAR 
    I: INTEGER;
  BEGIN
    I := 1;
    WHILE (I <= MaxWordLen) AND (W[I] <> ' ')
    DO
      BEGIN
        WRITE(F, W[I]);
        I := I + 1;
      END;
    WRITELN(F, ' ', Cnt);
  END;

  PROCEDURE WriteStats(VAR F: TEXT);
  {Выводит статистику в текстовый файл. 
  Идем по зараннее отсортированному списку и выписываем слово, 
  а через пробел его количество повторений. Каждая запись на новой строке.}
  VAR 
    I: INTEGER;
  BEGIN
    I := First;
    WHILE I <> 0
    DO
      BEGIN
        WriteWord(F, Stats[I].Word, Stats[I].Count);
        I := Stats[i].Next;
      END;
  END;
  
END.
