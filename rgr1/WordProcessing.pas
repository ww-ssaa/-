UNIT WordProcessing;
{Процедуры и функции для работы с отдельным словом: инициализация, проверка символов, приведение регистра, сравнение, валидация} 
INTERFACE
  USES WordTypeDef;

  PROCEDURE InitWord(VAR W: WordType); {Заполняет слово пробелами (обнуление)}
  FUNCTION IsWordChar(Ch: CHAR): BOOLEAN; {Проверяет, является ли символ буквой или дефисом}
  FUNCTION LowerChar(VAR Ch: CHAR): CHAR; {Преобразует соответствующую заглавную букву в строчную}
  PROCEDURE LowerCaseWord(VAR W: WordType); {Переводит буквы слова в нижний регистр}
  FUNCTION WordEqual(VAR W1, W2: WordType): BOOLEAN; {Сравнивает два слова}
  FUNCTION CharOrder(Ch: CHAR): INTEGER; {Возвращает числовой индекс символа в алфавите}
  FUNCTION WordLess(VAR W1, W2: WordType): BOOLEAN; {Сравнивает два слова в алфавитном порядке}
  FUNCTION IsEmptyWord(VAR W: WordType): BOOLEAN; {Проверяет, пустое ли слово}
  FUNCTION HasLeadingDash(VAR W: WordType): BOOLEAN; {Проверяет, если первый символ слова дефис}
  FUNCTION HasTrailingDash(VAR W: WordType): BOOLEAN; {Проверяет, если последний символ слова (до пробела) дефис}
  FUNCTION HasDoubleDash(VAR W: WordType): BOOLEAN; {Проверяет, если в слове встречаются два дефиса подряд}
  FUNCTION IsValidWord(VAR W: WordType): BOOLEAN; {Проверяет корректность слова (не пустое, нет дефиса по краям, нет двух дефисов подряд)}
  PROCEDURE AddCharToWord(VAR W: WordType; Ch: CHAR); {Добавляет символ в конец текущего слова}

IMPLEMENTATION  

  PROCEDURE InitWord(VAR W: WordType);
  {Заполняет весь массив символов слова пробелами, чтобы записать новое слово}
  VAR 
    I: INTEGER;
  BEGIN
    FOR I := 1 TO MaxWordLen
    DO
      W[I] := ' ';
  END;

  FUNCTION IsWordChar(Ch: CHAR): BOOLEAN;
  {Проверка символа. Определяет, входит ли символ в состав слова.
  Если это заглавная или строчная латинская или русская буква или дефис, то возвращает TRUE, иначе FALSE}
  VAR 
    I: INTEGER;
    Found: BOOLEAN;
  BEGIN
    IsWordChar := FALSE;
    IF Ch = '-'
    THEN
      IsWordChar := TRUE
    ELSE
      BEGIN
        Found := FALSE;
        I := 1;
        WHILE (I <= AlphabetSize) AND NOT Found
        DO
          BEGIN
            IF (Ch = UpperChars[I]) OR (Ch = LowerChars[I])
            THEN
              BEGIN
                IsWordChar := TRUE;
                Found := TRUE;
              END;
            I := I + 1;
          END;
      END;
  END;
  
  FUNCTION LowerChar(VAR Ch: CHAR): CHAR; 
  {Преобразует соответствующую заглавную букву в строчную}
  VAR
    I: INTEGER;
    Found: BOOLEAN;
  BEGIN
    LowerChar := Ch;
    Found := FALSE;
    I := 1;
    WHILE (I <= AlphabetSize) AND NOT FOUND
    DO
      BEGIN
        IF Ch = UpperChars[I]
        THEN
          BEGIN
            LowerChar := LowerChars[I];
            Found := TRUE;
          END;
        I := I + 1;
      END;    
  END;

  PROCEDURE LowerCaseWord(VAR W: WordType);
  {Заменяет заглавные буквы на соответствующие строчные. Игнорирует уже строчные и дефис}
  VAR 
    I: INTEGER;
  BEGIN
    FOR I := 1 TO MaxWordLen
    DO
      IF W[I] <> ' '
      THEN
        W[I] := LowerChar(W[I]);
  END;

  FUNCTION WordEqual(VAR W1, W2: WordType): BOOLEAN;
  {Сравнивает два слова.
  Идёт посимвольно пока не встретит пробел (конец слова) или несовпадение.
  Возвращает TRUE, если слова одинаковы.}
  VAR 
    I: INTEGER;
  BEGIN
    I := 1;
    WHILE (I <= MaxWordLen) AND (W1[I] <> ' ') AND (W1[I] = W2[I])
    DO
      I := I + 1;
    IF (W1[I] <> W2[I])
    THEN
      WordEqual := FALSE
    ELSE
      WordEqual := TRUE;
  END;
  
  FUNCTION CharOrder(Ch: CHAR): INTEGER;
  {Возвращает числовой индекс символа в алфавите}
  VAR 
    I: INTEGER;
    Found: BOOLEAN;
  BEGIN
    CharOrder := 32767;   {Значение для символов не из алфавита}
    Found := FALSE;
    I := 1;
    WHILE (I <= AlphabetSize) AND NOT Found 
    DO
      BEGIN
        IF Ch = LowerChars[I]
        THEN
          BEGIN
            CharOrder := I;
            Found := TRUE;
          END;
        I := I + 1;
      END
  END;

  FUNCTION WordLess(VAR W1, W2: WordType): BOOLEAN;
  {Сравнивает два слова с точки зрения алфавитного порядка.
   Возвращает TRUE, если первое слово должно идти раньше второго}
  VAR 
    I: INTEGER;
  BEGIN
    I := 1;
    WHILE (I <= MaxWordLen) AND (W1[I] <> ' ') AND (W1[I] = W2[I])
    DO
      I := I + 1;
    IF (W1[I] = ' ') AND (W2[I] <> ' ')
    THEN
      WordLess := TRUE
    ELSE 
      IF (W1[I] <> ' ') AND (W2[I] = ' ')
      THEN
        WordLess := FALSE
      ELSE
        WordLess := CharOrder(W1[I]) < CharOrder(W2[I])
  END;

  FUNCTION IsEmptyWord(VAR W: WordType): BOOLEAN;
  {Возвращает TRUE, если слово обнулено}
  VAR 
    I: INTEGER;
  BEGIN
    I := 1;
    IsEmptyWord := TRUE;
    WHILE (I <= MaxWordLen) AND (W[I] = ' ')
    DO
      I := I + 1;
    IF I <= MaxWordLen
    THEN
      IsEmptyWord := FALSE;
  END;

  FUNCTION HasLeadingDash(VAR W: WordType): BOOLEAN;
  {Возвращает TRUE, если первый символ слова дефис}
  BEGIN
    HasLeadingDash := (W[1] = '-');
  END;

  FUNCTION HasTrailingDash(VAR W: WordType): BOOLEAN;
  {Возвращает TRUE, если последний символ слова (до пробела) дефис}
  VAR 
    Len: INTEGER;
  BEGIN
    Len := 1;
    WHILE (Len <= MaxWordLen) AND (W[Len] <> ' ')
    DO
      Len := Len + 1;
    Len := Len - 1;
    HasTrailingDash := (Len > 0) AND (W[Len] = '-');
  END;

  FUNCTION HasDoubleDash(VAR W: WordType): BOOLEAN;
  {Возвращает TRUE, если в слове встречаются два дефиса подряд}
  VAR 
    I, Len: INTEGER;
  BEGIN
    Len := 1;
    WHILE (Len <= MaxWordLen) AND (W[Len] <> ' ')
    DO
      Len := Len + 1;
    Len := Len - 1;
    HasDoubleDash := FALSE;
    I := 2;
    WHILE I <= Len
    DO
      BEGIN
        IF (W[I-1] = '-') AND (W[I] = '-')
        THEN
          HasDoubleDash := TRUE;
        I := I + 1;
      END
  END;

  FUNCTION IsValidWord(VAR W: WordType): BOOLEAN;
  {Проверяет корректность слова: не пустое, не начинается и не заканчивается дефисом, не содержит двух дефисов подряд}
  BEGIN
    IsValidWord := NOT IsEmptyWord(W) AND NOT HasLeadingDash(W) AND NOT HasTrailingDash(W) AND NOT HasDoubleDash(W);
  END;

  PROCEDURE AddCharToWord(VAR W: WordType; Ch: CHAR);
  {В массив мы добавляем буквы слова слева направо.
  Каждый новый символ записывается в первую ячейку, которая ещё содержит пробел.
  После добавления буквы на её месте уже не пробел, и следующий символ пойдёт в следующую свободную позицию}
  VAR 
    I: INTEGER;
  BEGIN
    I := 1;
    WHILE (I <= MaxWordLen) AND (W[I] <> ' ')
    DO
      I := I + 1;
    IF I <= MaxWordLen
    THEN
      W[I] := Ch;
  END;     

END.
