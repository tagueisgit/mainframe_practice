//P01GEN   JOB 1,'HASPGEN  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      P01GEN                                             ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Build SYS1.HASPSRC containing customized           ***
//*              HASP source.                                       ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*********************************************************************
//*
//*-----------------------------------------------------------------***
//*    Copy user HASP parms to a temporary disk data set.           ***
//*-----------------------------------------------------------------***
//COPY    EXEC PGM=IEBGENER,REGION=100K
//SYSPRINT DD SYSOUT=A
//SYSIN    DD DUMMY
//SYSUT2   DD DSN=&&HASPPRM,DISP=(NEW,PASS),UNIT=SYSDA,
//            DCB=(LRECL=80,BLKSIZE=80,RECFM=FB),
//            SPACE=(TRK,(90,90))
//SYSUT1   DD *
&JCOPYLM=20                  OUTPUT JOB COPY LIMIT
&MAXJOBS=100               * MAXIMUM NUMBER OF JOBS IN SYSTEM
&MAXXEQS=3                 * MAXIMUM JOBS FOR OS MULTI-JOBBING
&NUMDDT=96                   NUMBER OF DATA DEFINITION TABLES
&NUMINRS=6                   NUMBER OF INTERNAL READERS
&NUMOSC=5                    NUMBER OF OS CONSOLES
&NUMPRTS=2                 * NUMBER OF PRINTERS
&NUMPUNS=1                 * NUMBER OF PUNCHES
&NUMRDRS=1                 * NUMBER OF READERS
&NUMJOES=64                  NUMBER OF JOB OUTPUT ELEMENTS
&NUMWTOQ=64                  NUMBER OF WTO BUFFERS
&PRTRANS=NO                  PRINT TRANSLATE OPTION
&RDR=700                     PSEUDO-READER FOR HOSRDR
&TSOSTCN=YES                 STATUS/CANCEL SUPPORT OPTION
&WCLSREQ=*X                  REQUEUE CLASSES FOR HASP WRITER
&WTRCLAS=AH                  CLASSES PROCESSED BY HASP WRITER
&WTR=720                     PSEUDO-WRITER FOR HASP TO RETRIEVE SMBS
$$X=*                        OS OUTPUT CLASS
UPDATE
./    ADD NAME=$INITSVC,LIST=ALL
./    NUMBER NEW1=1000,INCR=1000
&INITSVC SETC  '220' **************HASP INITIALIZATION SVC VALUE   RFIT
/*
//*
//*-----------------------------------------------------------------***
//*    Delete existing SYS1.HASPSRC data set.                       ***
//*-----------------------------------------------------------------***
//DELETE EXEC PGM=IEFBR14,REGION=100K
//HASPSRC  DD  DISP=(OLD,DELETE),DSN=SYS1.HASPSRC
//*
//*-----------------------------------------------------------------***
//*    Execute HASPGEN program to create customized                 ***
//*    SYS1.HASPSRC source library.  The resulting source           ***
//*    reflects customer HASP parms and IBM APAR fixes              ***
//*    but not refit-to-MVT changes or usermods.                    ***
//*-----------------------------------------------------------------***
//HASPGEN EXEC PGM=HASPGEN,PARM=CARDS,REGION=100K
//STEPLIB  DD  DISP=SHR,DSN=SYS1.HASPMOD
//HASPSRC  DD  DSN=SYS1.HASPSRC,
//             VOL=REF=SYS1.HASPIBM,
//             DCB=SYS1.HASPIBM,
//             DISP=(NEW,CATLG),
//             SPACE=(CYL,(60,,20))
//SYSIN    DD  DISP=SHR,DSN=SYS1.HASPIBM
//SYSPRINT DD  SYSOUT=A
//SYSUDUMP DD  SYSOUT=A
//GENIN    DD  DSN=&&HASPPRM,DISP=(OLD,DELETE)
//         DD  DISP=OLD,DSN=SYS1.HASPAPAR
//
/*EOF
