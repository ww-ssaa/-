UNIT FileUtils;
{Содержит процедуры для ввода имён файлов, открытия и закрытия файлов}
INTERFACE

  PROCEDURE GetFileNames(VAR InName, OutName: STRING); {Запрашивает у пользователя имена входного и выходного файлов}
  PROCEDURE OpenInputFile(VAR F: TEXT; CONST Name: STRING); {Связывает файловую переменную с именем и открывает файл для чтения}
  PROCEDURE OpenOutputFile(VAR F: TEXT; CONST Name: STRING); {Связывает файловую переменную с именем и создаёт (или перезаписывает) файл для записи}

IMPLEMENTATION

  PROCEDURE GetFileNames(VAR InName, OutName: STRING);
  {Запрашивает у пользователя имена входного и выходного файлов}
  BEGIN
    WRITELN('Введите имя входного файла:');
    READLN(InName);
    WRITELN('Введите имя выходного файла:');
    READLN(OutName);
  END;

  PROCEDURE OpenInputFile(VAR F: TEXT; CONST Name: STRING);
  {Связывает файловую переменную с именем и открывает файл для чтения}
  BEGIN
    ASSIGN(F, Name);
    RESET(F);
  END;

  PROCEDURE OpenOutputFile(VAR F: TEXT; CONST Name: STRING);
  {Связывает файловую переменную с именем и создаёт (или перезаписывает) файл для записи}
  BEGIN
    ASSIGN(F, Name);
    REWRITE(F);
  END;

END.
