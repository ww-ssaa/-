PROGRAM CountWords(INPUT, OUTPUT);
{Основная программа}

USES WordTypeDef, WordProcessing, WordStats, FileUtils, Processors;

VAR
  InFile, OutFile: TEXT; {Переменные входного и выходного файла}
  InName, OutName: STRING; {Имена входного и выходного файлов (вводит пользователь)}

BEGIN {CountWords}
  {Запись имен входного и выходного файла}
  GetFileNames(InName, OutName);
  {Связываем файлы с переменными, открываем для чтения и записи}
  OpenInputFile(InFile, InName);
  OpenOutputFile(OutFile, OutName);

  ProcessFile(InFile, OutFile, OutName);

END. {CountWords}
