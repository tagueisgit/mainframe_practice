//I03LOAD  JOB 1,'I03LOAD  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I03LOAD                                            ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Load unmodified IBM HASP source, IBM fixes,        ***
//*              MVT refit mods, HASP utilities, OS/VS XF           ***
//*              assembler and modified MVT source from tape.       ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*********************************************************************
//*
/*JOBPARM LINES=9999
//*
//*-----------------------------------------------------------------***
//*    Load IBM HASP source from tape to SYS1.HASPIBM.              ***
//*-----------------------------------------------------------------***
//SOURCE  EXEC PGM=IEBGENER,REGION=96K
//SYSPRINT DD  SYSOUT=A
//SYSUT2   DD  DISP=OLD,DSN=SYS1.HASPIBM
//SYSUT1   DD  DSN=HASPIBM,DISP=OLD,
//             UNIT=2400-3,VOL=SER=HASP4,
//             LABEL=(2,NL),DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600)
//SYSIN    DD  DUMMY
//*
//*-----------------------------------------------------------------***
//*    Load IBM HASP APARs from tape to SYS1.HASPAPAR.              ***
//*-----------------------------------------------------------------***
//APARS   EXEC PGM=IEBGENER,REGION=96K,COND=(0,NE)
//SYSPRINT DD  SYSOUT=A
//SYSUT2   DD  DISP=OLD,DSN=SYS1.HASPAPAR
//SYSUT1   DD  DSN=HASPAPAR,DISP=OLD,
//             UNIT=2400-3,VOL=(,RETAIN,SER=H4SUPB),
//             LABEL=(1,SL),DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600)
//SYSIN    DD  DUMMY
//*
//*-----------------------------------------------------------------***
//*    Load MVT refit modifications from tape to SYS1.HASPRFIT.     ***
//*-----------------------------------------------------------------***
//REFIT   EXEC PGM=IEBGENER,REGION=96K,COND=(0,NE)
//SYSPRINT DD  SYSOUT=A
//SYSUT2   DD  DISP=OLD,DSN=SYS1.HASPRFIT
//SYSUT1   DD  DSN=HASPRFIT,DISP=OLD,
//             UNIT=2400-3,VOL=(,RETAIN,SER=H4SUPB),
//             LABEL=(2,SL),DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600)
//SYSIN    DD  DUMMY
//*
//*-----------------------------------------------------------------***
//*    Link IBM HASP utilities from tape to SYS1.HASPMOD.           ***
//*-----------------------------------------------------------------***
//LNKUTIL EXEC PGM=IEWL,PARM='LIST,MAP,NCAL',REGION=96K,COND=(0,NE)
//SYSUT1   DD  UNIT=SYSDA,SPACE=(TRK,30)
//SYSLMOD  DD  DISP=OLD,DSN=SYS1.HASPMOD
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSNAME=HASPUTIL,DISP=OLD,
//             UNIT=2400-3,VOL=(,RETAIN,SER=H4SUPB),
//             LABEL=(3,SL),DCB=(RECFM=FB,LRECL=80,BLKSIZE=400)
//*
//*-----------------------------------------------------------------***
//*    Link OS/VS XF Assembler from tape to SYS1.XFASM.LOAD.        ***
//*-----------------------------------------------------------------***
//LNKASM  EXEC PGM=IEWL,PARM='LIST,MAP,NCAL',REGION=96K,COND=(0,NE)
//SYSUT1   DD  UNIT=SYSDA,SPACE=(TRK,30)
//SYSLMOD  DD  DISP=OLD,DSN=SYS1.XFASM.LOAD
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSNAME=XFASM,DISP=OLD,
//             UNIT=2400-3,VOL=(,RETAIN,SER=H4SUPB),
//             LABEL=(4,SL),DCB=(RECFM=FB,LRECL=80,BLKSIZE=400)
//*
//*-----------------------------------------------------------------***
//*    Load modified MVT macros and source from tape to             ***
//*    SYS1.HASPSUP.                                                ***
//*-----------------------------------------------------------------***
//HASPTSO EXEC PGM=IEBUPDTE,PARM=NEW,REGION=96K,COND=(0,NE)
//SYSPRINT DD  SYSOUT=A
//SYSUT2   DD  DISP=SHR,DSN=SYS1.HASPSUP
//SYSIN    DD  DSNAME=HASPSUP,DISP=OLD,
//             UNIT=2400-3,VOL=SER=H4SUPB,
//             LABEL=(5,SL),DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600)
//
/*EOF
