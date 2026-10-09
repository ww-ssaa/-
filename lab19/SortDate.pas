PROGRAM SortDate(INPUT, OUTPUT);

USES Dates;

VAR
  Copying: BOOLEAN; {Флаг TRUE, если из DateFile копируются элементы, < D. FALSE при >= D}
  D, VarDate: Date; {D - дата, считанная из файла, для копирования в DateFile. VarDate - промежуточное хранение даты}
  TFile, DateFile: FileOfDate; {TFile - временный файл для дат. DateFile - итоговый остортированный список}
  FInput: TEXT; {Исходный неотсортированный список дат}

BEGIN {SortDate}
  ASSIGN(DateFile, 'DF.DAT');
  ASSIGN(TFile, 'TF.DAT');
  ASSIGN(FInput, 'FI.TXT');
  REWRITE(DateFile);
  REWRITE(TFile);
  RESET(FInput);
  {Проверка первой даты на ошибки}
  VarDate.Mo := NoMonth;
  WHILE (NOT EOF(FInput)) AND (VarDate.Mo = NoMonth)
  DO
    BEGIN
      ReadDate(FInput, VarDate);
      READLN(FInput)
    END;
  {Если в файле была хотя бы одна корректная дата, запускаем сортировку}
  IF VarDate.Mo <> NoMonth
  THEN
    BEGIN
      WRITE(DateFile, VarDate);
      RESET(DateFile);
      WHILE NOT EOF(FInput)
      DO
        BEGIN
          {Помещаем новую дату в DateFile в соответствующее место}
          ReadDate(FInput, D);
          READLN(FInput);
          IF D.Mo <> NoMonth
          THEN
            BEGIN
              {Копируем элементы меньшие, чем D из DateFile в TFile}
              REWRITE(TFile);
              Copying := TRUE;
              WHILE (NOT EOF(DateFile)) AND Copying
              DO
                BEGIN
                  READ(DateFile, VarDate);
                  IF Less(VarDate, D)
                  THEN
                    WRITE(TFile, VarDate)
                  ELSE
                    Copying := FALSE
                END;
              {Копируем D в TFile}
              WRITE(TFile, D);
              {Копируем остаток DateFile в TFile}
              IF NOT Copying
              THEN
                WRITE(TFile, VarDate);
              WHILE NOT EOF(DateFile)
              DO
                BEGIN
                  READ(DateFile, VarDate);
                  WRITE(TFile, VarDate)
                END;
              {Копируем TFile в DateFile}
              RESET(TFile);
              REWRITE(DateFile);
              WHILE NOT EOF(TFile)
              DO
                BEGIN
                  READ(TFile, VarDate);
                  WRITE(DateFile, VarDate)
                END;
              RESET(DateFile)
            END
        END;
      {Копируем итоговый DateFile в OUTPUT}
      RESET(DateFile);
      CopyOut(DateFile)
    END;
  CLOSE(DateFile);
  CLOSE(TFile);
  CLOSE(FInput)
END. {SortDate}
