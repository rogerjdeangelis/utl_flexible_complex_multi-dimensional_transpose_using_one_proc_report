Flexible complex multi-dimensional transpose using one proc report

see git hub
https://goo.gl/zb1xUd
https://github.com/rogerjdeangelis/utl_flexible_complex_multi-dimensional_transpose_using_one_proc_report

see
https://stackoverflow.com/questions/48851823/multiple-transactions-lines-to-base-table-sas

However there is a bug in proc report. Proc report does not honor the ods report.
You need to rename the alphabetical ordered column names to match the
ods printed report.

As a side benefit this does make your learn key features
of proc report;

Proc report can do amazing transposes with very few lines od code.
I feel the output is more important than the static report.
Proc transpose can sort, summarize and tramspose all at once.


INPUT
=====

 WORK.HAVE total obs=8

   ID    SEGMENT WEEK   AVERAGE    FREQ |
                                        |  ONE OBSERVATION
                                        |
   1     PC        1      400        3  |  PC 1 AVG = 400   PC 1 Frq = 3
   1     PC        2      550        3  |  PC 2 AVG = 550   PC 2 Frq = 3
   1     Sports    1      500        2  |  SP 1 AVG = 500   SP 1 Frq = 2
   1     Sports    2      350        3  |  SP 2 AVG = 350   SP 2 Frq = 3
                                        |
   2     PC        1      700        3  |
   2     PC        2      250        3  |
   2     Sports    1      650        2  |
   2     Sports    2      720        3  |
                                        |
 EXAMPLE OUTPUT
 ==============

  ID
    ID    PC1AVG    PC1FRQ    PC2AVG    PC2FRQ      SP1AVG    SP1FRQ    SP2AVG    SP2FRQ

    1       400        3        550        3          500        2        350        3
    2       ....


 PROCESS
=========

    proc report data=have
    nowd missing out=want (rename=(
       _C1_ =  PC1Avg
       _C2_ =  PC1Frq
       _C3_ =  PC2Avg
       _C4_ =  PC2Frq
       _C5_ =  Sp1Avg
       _C6_ =  Sp1Frq
       _C7_ =  Sp2Avg
       _C8_ =  Sp2Frq));
    cols segment, week, (average freq);
    by id;
    define segment  / across;
    define  average / analysis ;
    define week     / across;
    define  freq    / analysis ;
    run;quit;

FULL OUTPUT
===========

Up to 40 obs from want total obs=2

  ID    PC1AVG    PC1FRQ    PC2AVG    PC2FRQ    SP1AVG    SP1FRQ    SP2AVG    SP2FRQ

  1       400        3        550        3        500        2        350        3
  2       700        3        250        3        650        2        720        3

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
input ID $  Week Segment $ Average Freq;
datalines;
1 1 Sports 500 2
1 1 PC 400 3
1 2 Sports 350 3
1 2 PC 550 3
2 1 Sports 650 2
2 1 PC 700 3
2 2 Sports 720 3
2 2 PC 250 3
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

proc report data=have
nowd missing out=want (rename=(
   _C1_ =  PC1Avg
   _C2_ =  PC1Frq
   _C3_ =  PC2Avg
   _C4_ =  PC2Frq
   _C5_ =  Sp1Avg
   _C6_ =  Sp1Frq
   _C7_ =  Sp2Avg
   _C8_ =  Sp2Frq));
cols segment, week, (average freq);
by id;
define segment  / across;
define  average / analysis ;
define week     / across;
define  freq    / analysis ;
run;quit;

