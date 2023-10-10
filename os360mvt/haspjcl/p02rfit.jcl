//P02RFIT  JOB 1,'P02RFIT  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      P02RFIT                                            ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Update customized HASP source in SYS1.HASPSRC      ***
//*              with MVT refit mods.                               ***
//*    Update:   2003/01/26                                         ***
//*                                                                 ***
//*********************************************************************
//*
/*JOBPARM LINES=9999
//*
//RFIT    EXEC PGM=IEBUPDTE,PARM=MOD,REGION=96K
//SYSUT1   DD  DISP=OLD,DSN=SYS1.HASPSRC
//SYSUT2   DD  DISP=OLD,DSN=SYS1.HASPSRC
//SYSPRINT DD  SYSOUT=A
//SYSIN    DD  DISP=OLD,DSN=SYS1.HASPRFIT
//
/*EOF
