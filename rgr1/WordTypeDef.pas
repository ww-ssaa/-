UNIT WordTypeDef;
{Определяет основные типы данных и константы для всей программы}
INTERFACE
  CONST
    MaxWords = 50000; {Максимальное количество уникальных слов}
    MaxWordLen = 50; {Максимальная длина слова}
    AlphabetSize = 59;
    UpperChars: ARRAY [1..AlphabetSize] OF CHAR = (
      'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
      'А','Б','В','Г','Д','Е','Ё','Ж','З','И','Й','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ъ','Ы','Ь','Э','Ю','Я'  
    );
    LowerChars: ARRAY [1..AlphabetSize] OF CHAR = (
      'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
      'а','б','в','г','д','е','ё','ж','з','и','й','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я'
    );
  TYPE
    WordType = ARRAY [1..MaxWordLen] OF CHAR;   { Тип для хранения слова как массива фиксированной длины }
    WordEntry = RECORD {Число вхождений в формате - Слово, Количество, Индекс следующего слова в списке} 
                  Word: WordType;              
                  Count: INTEGER;             
                  Next: INTEGER;               
                END;
  VAR
    Stats: ARRAY [1..MaxWords] OF WordEntry; {Массив для всей статистики}
    StatsCount: INTEGER; {Количество уникальных слов}
    First: INTEGER; {Индекс первого элемента в отсортированном списке}
    
IMPLEMENTATION

BEGIN
  StatsCount := 0;
  First := 0;
END.
