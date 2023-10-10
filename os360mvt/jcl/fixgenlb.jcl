//FIXGENLB JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      FIXGENLB                                           ***
//*    Product:  OS/360 MVT.                                        ***
//*    Purpose:  Fix several JCL generation errors in the           ***
//*              distributed SYSGEN macros. Change the test for the ***
//*              interval timer in IEANIP00 to deal with faster     ***
//*              systems.                                           ***
//*    Step:     5.6                                                ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//SGASMPAK EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=SGASMPAK,UPDATE=INPLACE
 PUNCH '//SG&SGCTRLA(1) EXEC PGM=IEUASM,'                               00000400
./ ENDUP
/*
//*
//SGIFC600 EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=SGIFC600,UPDATE=INPLACE
 PUNCH ' CATLG CVOL=&SGCTRLC(29)=&SGCTRLC(30),VOL=&SGCTRLC(29)=&SGCTRLCX92920021
               (30),DSNAME=SYS1.LOGREC'                          S21021 93930021
./ ENDUP
/*
//*
//SGIEA2NP EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=SGIEA2NP,UPDATE=INPLACE
&TIMBCTC SETC  '100000'                             @HERCULES  BH M5821 11289921
./ ENDUP
/*
//*
//GENERATE EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=GENERATE,UPDATE=INPLACE
         PUNCH      '//OBJPDS DD DSNAME=&OBJPDS,UNIT=SYSDA,'            32777017
         PUNCH '//  DISP=OLD'                                           32777019
.JB03A   PUNCH      '// DISP=(,CATLG),'                                 32777117
 PUNCH '//SYSUT1 DD DSN=SYS1.&SGCTRLC(41).MACLIB,'                      41360019
 PUNCH '// DISP=SHR'                                                    41360020
 PUNCH '//SG&SGCTRLA(1) EXEC PGM=IEWL,COND=(4,LT),REGION=150K,'         44940000
.*       JOBSEP     TYPE=LK     ELIMINATE EXTRA JOB IN STAGE 2  JRM     51052919
 PUNCH '//PARMLIBA DD DSNAME=SYS1.&SGCTRLC(41).PARMLIB,'                64930019
 PUNCH '// DISP=SHR'                                                    64980019
 PUNCH '//PL1LIBA DD DSNAME=SYS1.&SGCTRLC(41).PL1LIB,'                  65570019
 PUNCH '// DISP=SHR'                                                    65620019
 PUNCH '//FORTLIBA DD DSNAME=SYS1.&SGCTRLC(41).FORTLIB,'                66450019
 PUNCH '// DISP=SHR'                                                    66500019
 PUNCH '//COBLIBA DD DSNAME=SYS1.&SGCTRLC(41).COBLIB,'                  67570019
 PUNCH '// DISP=SHR'                                                    67620019
 PUNCH '//SORTLIBA DD DSNAME=SYS1.&SGCTRLC(41).SORTLIB,'                68610019
 PUNCH '// DISP=SHR'                                                    68660019
 PUNCH '//PROCLIBA DD DSNAME=SYS1.&SGCTRLC(41).PROCLIB,'                69650019
 PUNCH '// DISP=SHR'                                                    69700019
./ ENDUP
/*
//*
//TSASMPAK EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSUT2   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=TSASMPAK
         JOBSEP     TYPE=TA                                             02000020
&SGCTRLA(1) SETA &SGCTRLA(1)+1                                          03000020
./ ENDUP
/*
//*
//JOBSEP   EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSUT2   DD  DISP=SHR,DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=JOBSEP,LIST=ALL
         GBLC       &FTCPTYP                                            00001450
         PUNCH  '// PARM=''**** R&RELNOA&FTCPTYP&FTCJOBE  ** F A I L E C00002300
               D **** F A I L E D ****'','                              00002400
         AIF ('&FTCPTYP' EQ 'LK').LKCOND                                00002450
         PUNCH      '// COND=(0,EQ)'                                    00002500
         AGO .DOJOB                                                     00002520
.LKCOND  ANOP                                                           00002540
         PUNCH      '// COND=(4,GE)'                                    00002560
.DOJOB   ANOP                                                           00002580
&FTCPTYP SETC  '&TYPE'                                                  00002750
         PUNCH      '//R21&TYPE&FTCJOBN JOB CLASS=A,MSGCLASS=A,MSGLEVEL200002800
               =(1,1)'                                                  00002900
./ ENDUP
/*
//*
//
