UNIT Dates;

INTERFACE

TYPE
  Month = (NoMonth, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec); {Месяца года. NoMonth - ошибка / отсутствие месяца}
  DayNum = 1 .. 31; {Номер дня в месяце}
  Date = RECORD {Месяц и день}
           Mo: Month;
           Day: DayNum
         END;
  FileOfDate = FILE OF Date; {Файл с датами}

PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month); {Чтение названия месяца из текстового файла}
PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month); {Вывод названия месяца в текстовый файл}
PROCEDURE ReadDate(VAR FIn: TEXT; VAR Res: Date); {Чтение даты из текстового файла}
PROCEDURE WriteDate(VAR FOut: TEXT; VAR Res: Date); {Вывод даты в текстовый файл}
FUNCTION Less(VAR D1, D2: Date): BOOLEAN; {Сравнение двух дат}
PROCEDURE CopyOut(VAR DateFile: FileOfDate); {Вывод содержимого файла дат}

IMPLEMENTATION

PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month);
{Чтение названия месяца из текстового файла}
VAR
  Ch1, Ch2, Ch3: CHAR;
BEGIN
  READ(FIn, Ch1, Ch2, Ch3);
  IF (Ch1 = 'J') AND (Ch2 = 'A') AND (Ch3 = 'N') THEN Mo := Jan ELSE
  IF (Ch1 = 'F') AND (Ch2 = 'E') AND (Ch3 = 'B') THEN Mo := Feb ELSE
  IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'R') THEN Mo := Mar ELSE
  IF (Ch1 = 'A') AND (Ch2 = 'P') AND (Ch3 = 'R') THEN Mo := Apr ELSE
  IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'Y') THEN Mo := May ELSE
  IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'N') THEN Mo := Jun ELSE
  IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'L') THEN Mo := Jul ELSE
  IF (Ch1 = 'A') AND (Ch2 = 'U') AND (Ch3 = 'G') THEN Mo := Aug ELSE
  IF (Ch1 = 'S') AND (Ch2 = 'E') AND (Ch3 = 'P') THEN Mo := Sep ELSE
  IF (Ch1 = 'O') AND (Ch2 = 'C') AND (Ch3 = 'T') THEN Mo := Oct ELSE
  IF (Ch1 = 'N') AND (Ch2 = 'O') AND (Ch3 = 'V') THEN Mo := Nov ELSE
  IF (Ch1 = 'D') AND (Ch2 = 'E') AND (Ch3 = 'C') THEN Mo := Dec
    ELSE 
      BEGIN
        Mo := NoMonth;
        WRITELN(OUTPUT, 'Ошибка: некорректный месяц - ''', Ch1, Ch2, Ch3, '''')
      END
END;

PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month);
{Вывод названия месяца в текстовый файл}
BEGIN
  IF Mo = Jan THEN WRITE(FOut, 'JAN') ELSE
  IF Mo = Feb THEN WRITE(FOut, 'FEB') ELSE
  IF Mo = Mar THEN WRITE(FOut, 'MAR') ELSE
  IF Mo = Apr THEN WRITE(FOut, 'APR') ELSE
  IF Mo = May THEN WRITE(FOut, 'MAY') ELSE
  IF Mo = Jun THEN WRITE(FOut, 'JUN') ELSE
  IF Mo = Jul THEN WRITE(FOut, 'JUL') ELSE
  IF Mo = Aug THEN WRITE(FOut, 'AUG') ELSE
  IF Mo = Sep THEN WRITE(FOut, 'SEP') ELSE
  IF Mo = Oct THEN WRITE(FOut, 'OCT') ELSE
  IF Mo = Nov THEN WRITE(FOut, 'NOV') ELSE
  IF Mo = Dec THEN WRITE(FOut, 'DEC')
    ELSE WRITE(FOut, 'NoMonth')
END;

PROCEDURE ReadDate(VAR FIn: TEXT; VAR Res: Date);
{Чтение даты из текстового файла с валидацией диапазона дней}
VAR
  TempDay: INTEGER;
BEGIN 
  ReadMonth(FIn, Res.Mo);
  READ(FIn, TempDay); 
  {Проверяем корректность дня}
  IF (TempDay < 1) OR (TempDay > 31)
  THEN
    BEGIN
      {Выводим ошибку, только если сам месяц до этого был корректным}
      IF Res.Mo <> NoMonth
      THEN
        BEGIN
          WRITE(OUTPUT, 'Ошибка: некорректное число в дате - ''');
          WriteMonth(OUTPUT, Res.Mo);
          WRITELN(OUTPUT, ' ', TempDay, '''');
          Res.Mo := NoMonth {Помечаем дату как некорректную для пропуска в основной программе}
        END
    END
  ELSE
    Res.Day := TempDay
END;

PROCEDURE WriteDate(VAR FOut: TEXT; VAR Res: Date);
{Вывод даты в текстовый файл}
BEGIN
  WriteMonth(FOut, Res.Mo);
  WRITE(FOut, Res.Day:3)
END;

FUNCTION Less(VAR D1, D2: Date): BOOLEAN;
{Сравнение двух дат: возвращает TRUE, если D1 < D2}
BEGIN
  IF D1.Mo < D2.Mo
  THEN
    Less := TRUE
  ELSE
    IF D1.Mo > D2.Mo
    THEN
      Less := FALSE
    ELSE
      Less := (D1.Day < D2.Day)
END; 

PROCEDURE CopyOut(VAR DateFile: FileOfDate);
{Вывод содержимого файла дат}
VAR
  VarDate: Date;
BEGIN 
  WHILE NOT EOF(DateFile)
  DO
    BEGIN
      READ(DateFile, VarDate);
      WriteDate(OUTPUT, VarDate);
      WRITELN
    END
END; 

BEGIN
END.
