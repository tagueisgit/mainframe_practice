//P04ASM   JOB 1,'P04ASM   HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      P04ASM                                             ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Assemble HASP source.                              ***
//*    Update:   2003/02/10                                         ***
//*                                                                 ***
//*    Note:     This jobstream is split into several jobs          ***
//*              to avoid an abend422 due to excessive SMB          ***
//*              requirements.                                      ***
//*                                                                 ***
//*********************************************************************
//*
/*JOBPARM LINES=9999
//*
//*-----------------------------------------------------------------***
//*    Delete existing SYS1.HASPOBJ data set.                       ***
//*-----------------------------------------------------------------***
//DELETE  EXEC PGM=IEFBR14
//HASPOBJ  DD  DISP=(OLD,DELETE),DSN=SYS1.HASPOBJ
//*
//*-----------------------------------------------------------------***
//*    Allocate new SYS1.HASPOBJ data set.                          ***
//*-----------------------------------------------------------------***
//ALLOC   EXEC PGM=IEFBR14
//HASPOBJ  DD  DSN=SYS1.HASPOBJ,
//             VOL=REF=SYS1.HASPIBM,
//             DCB=SYS1.HASPIBM,
//             DISP=(NEW,CATLG),
//             SPACE=(CYL,(5,,8))
//*
//*-----------------------------------------------------------------***
//*    Compress SYS1.HASPMOD.                                       ***
//*-----------------------------------------------------------------***
//COMPRESS EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=A
//SYSUT3   DD  UNIT=SYSDA,SPACE=(CYL,(2,1))
//SYSUT4   DD  UNIT=SYSDA,SPACE=(CYL,(2,1))
//SYSUT1   DD  DISP=OLD,DSN=SYS1.HASPMOD
//SYSUT2   DD  DISP=OLD,DSN=SYS1.HASPMOD
//SYSIN    DD  DUMMY
//*
//*-----------------------------------------------------------------***
//*    Assemble HASP modules to SYS1.HASPOBJ data set,              ***
//*    and link HASPOBLD to SYS1.HASPMOD.                           ***
//*-----------------------------------------------------------------***
//P04AACCT JOB 1,'P04AACCT HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPACCT EXEC ASMHASP,MODULE=HASPACCT
//P04ABR1  JOB 1,'P04ABR1  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPBR1  EXEC ASMHASP,MODULE=HASPBR1
//P04ACOMM JOB 1,'P04ACOMM HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPCOMM EXEC ASMHASP,MODULE=HASPCOMM
//P04ACON  JOB 1,'P04ACON  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPCON  EXEC ASMHASP,MODULE=HASPCON
//P04AINIT JOB 1,'P04AINIT HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPINIT EXEC ASMHASP,MODULE=HASPINIT
//P04AINIF JOB 1,'P04AINIF HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPINTF EXEC ASMHASP,MODULE=HASPINTF
//P04AMISC JOB 1,'P04AMISC HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPMISC EXEC ASMHASP,MODULE=HASPMISC
//P04ANUC  JOB 1,'P04ANUC  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPNUC  EXEC ASMHASP,MODULE=HASPNUC
//P04APRPU JOB 1,'P04APRPU HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPPRPU EXEC ASMHASP,MODULE=HASPPRPU
//P04ARDR  JOB 1,'P04ARDR  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPRDR  EXEC ASMHASP,MODULE=HASPRDR
//P04ARTAM JOB 1,'P04ARTAM HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPRTAM EXEC ASMHASP,MODULE=HASPRTAM
//P04ASVC  JOB 1,'P04ASVC  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPSVC  EXEC ASMHASP,MODULE=HASPSVC
//P04AWTR  JOB 1,'P04AWTR  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPWTR  EXEC ASMHASP,MODULE=HASPWTR
//P04AXEQ  JOB 1,'P04AXEQ  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPXEQ  EXEC ASMHASP,MODULE=HASPXEQ
//P04AOBLD JOB 1,'P04AOBLD HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
/*JOBPARM LINES=9999
//HASPOBLD EXEC ASMHASP,MODULE=HASPOBLD
//LNKOBLD  EXEC PGM=IEWL,PARM='LIST,MAP,NCAL',REGION=96K
//SYSLIN    DD DSNAME=SYS1.HASPOBJ(HASPOBLD),DISP=SHR
//SYSUT1    DD DSN=&&UT1,UNIT=SYSALLDA,SPACE=(CYL,(10,5))
//SYSLMOD   DD DSNAME=SYS1.HASPMOD(HASPOBLD),DISP=OLD
//SYSPRINT  DD SYSOUT=A
//
/*EOF
