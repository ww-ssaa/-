{DP1}
PROGRAM IFSort3(INPUT, OUTPUT);
{Сортирует 3-строку из INPUT в OUTPUT}
  VAR
    Ch1, Ch2, Ch3:Char;
  BEGIN {IFSort3}
    READ(Ch1, Ch2, Ch3);
    WRITELN('Входные данные ', Ch1, Ch2, Ch3);
    WRITE('Сортированные данные');
    {Сортируем Ch1, Ch2, Ch3 в OUTPUT}
  END. {IFsort3}

