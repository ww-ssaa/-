UNIT WordStats;

INTERFACE
  CONST
    MaxWords = 50000; {Максимальное количество уникальных слов}
    MaxWordLen = 50; {Максимальная длина слова}
  TYPE
    WordType = ARRAY [1..MaxWordLen] OF CHAR; {Тип данных для хранения слова как массива символов фиксированной длины}
    WordEntry = RECORD {Число вхождений в формате - Слово Количество} 
                  word: WordType;
                  count: INTEGER;
                END;
  VAR
    Stats: ARRAY [1..MaxWords] OF WordEntry; {Массив для всей статистики}
    StatsCount: INTEGER; {Количество уникальных слов}

  PROCEDURE InitWord(VAR W: WordType); {Заполняет слово пробелами (обнуление)}
  FUNCTION IsWordChar(Ch: CHAR): BOOLEAN; {Проверяет, является ли символ буквой или дефисом}
  PROCEDURE LowerCaseWord(VAR W: WordType); {Переводит буквы слова в нижний регистр}
  FUNCTION WordEqual(VAR W1, W2: WordType): BOOLEAN; {Сравнивает слова}
  PROCEDURE AddWord(VAR W: WordType); {Добавляет слово в массив статистики}
  FUNCTION WordLess(VAR W1, W2: WordType): BOOLEAN; {Сравнивает два слова в алфавитном порядке}
  PROCEDURE SortStats; {Сортирует слова в алфавитном порядке}
  PROCEDURE WriteStats(VAR F: TEXT); {Выводит статистику в файл}
 
IMPLEMENTATION

  PROCEDURE InitWord(VAR W: WordType);
  {Заполняет весь массив символов слова пробелами, чтобы записать новое слово}
  VAR 
    i: INTEGER;
  BEGIN
    FOR i := 1 TO MaxWordLen 
    DO
      W[i] := ' ';
  END;

  FUNCTION IsWordChar(Ch: CHAR): BOOLEAN;
  {Проверка символа. Определяет, входит ли символ в состав слова. 
  Если это заглавная или строчная латинская или русская буква или дефис, то возвращает TRUE, иначе FALSE}
  BEGIN
    IsWordChar := FALSE;
    IF (Ch >= 'A') AND (Ch <= 'Z')
    THEN
      IsWordChar := TRUE
    ELSE 
      IF (Ch >= 'a') AND (Ch <= 'z')
      THEN
        IsWordChar := TRUE
      ELSE 
        IF (Ch >= 'А') AND (Ch <= 'Я')
        THEN
          IsWordChar := TRUE
        ELSE 
          IF (Ch >= 'а') AND (Ch <= 'я')
          THEN
            IsWordChar := TRUE
          ELSE 
            IF (Ch = 'Ё') OR (Ch = 'ё')
            THEN
              IsWordChar := TRUE
            ELSE 
              IF Ch = '-'
              THEN
                IsWordChar := TRUE
  END;

  PROCEDURE LowerCaseWord(VAR W: WordType);
  {Заменяет заглавные буквы на соответствующие строчные. Игнорирует уже строчные и дефис}
  VAR 
    i: INTEGER;
  BEGIN
    FOR i := 1 TO MaxWordLen 
    DO
      BEGIN
        {Латинские}
        IF W[i] = 'A' THEN W[i] := 'a' ELSE
        IF W[i] = 'B' THEN W[i] := 'b' ELSE
        IF W[i] = 'C' THEN W[i] := 'c' ELSE
        IF W[i] = 'D' THEN W[i] := 'd' ELSE
        IF W[i] = 'E' THEN W[i] := 'e' ELSE
        IF W[i] = 'F' THEN W[i] := 'f' ELSE
        IF W[i] = 'G' THEN W[i] := 'g' ELSE
        IF W[i] = 'H' THEN W[i] := 'h' ELSE
        IF W[i] = 'I' THEN W[i] := 'i' ELSE
        IF W[i] = 'J' THEN W[i] := 'j' ELSE
        IF W[i] = 'K' THEN W[i] := 'k' ELSE
        IF W[i] = 'L' THEN W[i] := 'l' ELSE
        IF W[i] = 'M' THEN W[i] := 'm' ELSE
        IF W[i] = 'N' THEN W[i] := 'n' ELSE
        IF W[i] = 'O' THEN W[i] := 'o' ELSE
        IF W[i] = 'P' THEN W[i] := 'p' ELSE
        IF W[i] = 'Q' THEN W[i] := 'q' ELSE
        IF W[i] = 'R' THEN W[i] := 'r' ELSE
        IF W[i] = 'S' THEN W[i] := 's' ELSE
        IF W[i] = 'T' THEN W[i] := 't' ELSE
        IF W[i] = 'U' THEN W[i] := 'u' ELSE
        IF W[i] = 'V' THEN W[i] := 'v' ELSE
        IF W[i] = 'W' THEN W[i] := 'w' ELSE
        IF W[i] = 'X' THEN W[i] := 'x' ELSE
        IF W[i] = 'Y' THEN W[i] := 'y' ELSE
        IF W[i] = 'Z' THEN W[i] := 'z' ELSE
        {Русские}
        IF W[i] = 'А' THEN W[i] := 'а' ELSE
        IF W[i] = 'Б' THEN W[i] := 'б' ELSE
        IF W[i] = 'В' THEN W[i] := 'в' ELSE
        IF W[i] = 'Г' THEN W[i] := 'г' ELSE
        IF W[i] = 'Д' THEN W[i] := 'д' ELSE
        IF W[i] = 'Е' THEN W[i] := 'е' ELSE
        IF W[i] = 'Ё' THEN W[i] := 'ё' ELSE
        IF W[i] = 'Ж' THEN W[i] := 'ж' ELSE
        IF W[i] = 'З' THEN W[i] := 'з' ELSE
        IF W[i] = 'И' THEN W[i] := 'и' ELSE
        IF W[i] = 'Й' THEN W[i] := 'й' ELSE
        IF W[i] = 'К' THEN W[i] := 'к' ELSE
        IF W[i] = 'Л' THEN W[i] := 'л' ELSE
        IF W[i] = 'М' THEN W[i] := 'м' ELSE
        IF W[i] = 'Н' THEN W[i] := 'н' ELSE
        IF W[i] = 'О' THEN W[i] := 'о' ELSE
        IF W[i] = 'П' THEN W[i] := 'п' ELSE
        IF W[i] = 'Р' THEN W[i] := 'р' ELSE
        IF W[i] = 'С' THEN W[i] := 'с' ELSE
        IF W[i] = 'Т' THEN W[i] := 'т' ELSE
        IF W[i] = 'У' THEN W[i] := 'у' ELSE
        IF W[i] = 'Ф' THEN W[i] := 'ф' ELSE
        IF W[i] = 'Х' THEN W[i] := 'х' ELSE
        IF W[i] = 'Ц' THEN W[i] := 'ц' ELSE
        IF W[i] = 'Ч' THEN W[i] := 'ч' ELSE
        IF W[i] = 'Ш' THEN W[i] := 'ш' ELSE
        IF W[i] = 'Щ' THEN W[i] := 'щ' ELSE
        IF W[i] = 'Ъ' THEN W[i] := 'ъ' ELSE
        IF W[i] = 'Ы' THEN W[i] := 'ы' ELSE
        IF W[i] = 'Ь' THEN W[i] := 'ь' ELSE
        IF W[i] = 'Э' THEN W[i] := 'э' ELSE
        IF W[i] = 'Ю' THEN W[i] := 'ю' ELSE
        IF W[i] = 'Я' THEN W[i] := 'я';
      END;
  END;

  FUNCTION WordEqual(VAR W1, W2: WordType): BOOLEAN;
  {Сравнивает два слова. 
  Идёт посимвольно пока не встретит пробел (конец слова) или несовпадение. 
  Возвращает TRUE, если слова одинаковы}
  VAR 
    i: INTEGER;
  BEGIN
    i := 1;
    WHILE (i <= MaxWordLen) AND (W1[i] <> ' ') AND (W2[i] <> ' ') AND (W1[i] = W2[i])
    DO
      i := i + 1;
    IF (W1[i] <> W2[i])
    THEN
      WordEqual := FALSE
    ELSE
      WordEqual := TRUE;
  END;

  PROCEDURE AddWord(VAR W: WordType);
  {Получает слово. Приводит его к нижнему регистру (LowerCaseWord). 
  Ищет в массиве Stats среди уже добавленных уникальных слов. 
  Если находит такое же, то увеличивает его счётчик на 1. 
  Иначе, добавляет новую запись в конец массива (StatsCount увеличивается). Копирует слово и устанавливает счётчик на 1}
  VAR 
    i: INTEGER; 
    Found: BOOLEAN; 
    Lower: WordType;
  BEGIN
    Lower := W;
    LowerCaseWord(Lower);
    Found := FALSE;
    i := 1;
    WHILE (i <= StatsCount) AND NOT Found
    DO
      BEGIN
        IF WordEqual(Stats[i].word, Lower)
        THEN
          BEGIN
            Stats[i].count := Stats[i].count + 1;
            Found := TRUE;
          END;
        i := i + 1;
      END;
    IF NOT Found
    THEN
      BEGIN
        StatsCount := StatsCount + 1;
        Stats[StatsCount].word := Lower;
        Stats[StatsCount].count := 1;
      END;
  END;

  FUNCTION WordLess(VAR W1, W2: WordType): BOOLEAN;
  {Сравнивает два слова с точки зрения алфавитного порядка.
  Возвращает TRUE, если первое слово должно идти раньше второго}
  VAR 
    i: INTEGER;
  BEGIN
    i := 1;
    WHILE (i <= MaxWordLen) AND (W1[i] = W2[i]) AND (W1[i] <> ' ')
    DO
      i := i + 1;
    IF (W1[i] = ' ') AND (W2[i] <> ' ')
    THEN
      WordLess := TRUE
    ELSE 
      IF (W1[i] <> ' ') AND (W2[i] = ' ')
      THEN
        WordLess := FALSE
      ELSE
        WordLess := W1[i] < W2[i];
  END;

  PROCEDURE SortStats;
  {Сортирует массив Stats по алфавиту (по полю word). 
  Попарно сравнивает слова через WordLess и меняет записи местами, если порядок неверный}
  VAR 
    i, j: INTEGER; 
    Temp: WordEntry;
  BEGIN
    FOR i := 1 TO StatsCount - 1
    DO
      FOR j := i+1 TO StatsCount
      DO
        IF WordLess(Stats[j].word, Stats[i].word)
        THEN
          BEGIN
            Temp := Stats[i];
            Stats[i] := Stats[j];
            Stats[j] := Temp;
          END;
  END;

  PROCEDURE WriteStats(VAR F: TEXT);
  {Выводит статистику в текстовый файл (либо в консоль если файл не обозначен). 
  Для каждой записи от 1 до StatsCount выписывает слово и через пробел его счётчик. 
  Каждая запись на новой строке.}
  VAR 
    i, k: INTEGER;
  BEGIN
    FOR i := 1 TO StatsCount
    DO
      BEGIN
        k := 1;
        WHILE (k <= MaxWordLen) AND (Stats[i].word[k] <> ' ')
        DO
          BEGIN
            WRITE(F, Stats[i].word[k]);
            k := k + 1;
          END;
        WRITELN(F, ' ', Stats[i].count);
      END;
  END;

BEGIN
  StatsCount := 0;
END.
