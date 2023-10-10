//I01ALCIN JOB 1,'I01ALCIN HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I01ALCIN                                           ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Allocate installation data sets.                   ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*********************************************************************
//*
//*-----------------------------------------------------------------***
//*    Specify volume to contain new installation data sets.        ***
//*-----------------------------------------------------------------***
//STEP0   EXEC PGM=IEFBR14
//HASPVOL   DD  DISP=OLD,UNIT=3330,VOL=SER=HERC01    <-- volser here
//*
//*-----------------------------------------------------------------***
//*    Allocate installation data sets.                             ***
//*-----------------------------------------------------------------***
//ALLOC   EXEC PGM=IEFBR14,COND=(0,NE)
//*
//*--- Unmodified IBM source ---------------------------------------***
//HASPIBM  DD  DSN=SYS1.HASPIBM,
//             DISP=(NEW,CATLG,DELETE),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(TRK,(450))
//*
//*--- HASP utilities ----------------------------------------------***
//HASPMOD  DD  DSN=SYS1.HASPMOD,
//             DISP=(NEW,CATLG,DELETE),
//             DCB=(RECFM=U,BLKSIZE=6144),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(TRK,(10,,5))
//*
//*--- IBM HASP APARs ----------------------------------------------***
//HASPAPAR DD  DSN=SYS1.HASPAPAR,
//             DISP=(NEW,CATLG,DELETE),
//             DCB=(RECFM=F,LRECL=80,BLKSIZE=80),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,2)
//*
//*--- MVT refit modifications -------------------------------------***
//HASPRFIT DD  DSN=SYS1.HASPRFIT,
//             DISP=(NEW,CATLG,DELETE),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,2)
//*
//*--- MVT source and macros modified for HASP support -------------***
//HASPSUP  DD  DSN=SYS1.HASPSUP,
//             DISP=(NEW,CATLG,DELETE),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=1600),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,(5,,5))
//*
//*--- Placeholder for modified source -----------------------------***
//HASPSRC  DD  DSN=SYS1.HASPSRC,
//             DISP=(NEW,CATLG,DELETE),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,(40,,20))
//*
//*--- Placeholder for assembled HASP object decks -----------------***
//HASPOBJ  DD  DSN=SYS1.HASPOBJ,
//             DISP=(NEW,CATLG,DELETE),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,(5,,8))
//*
//*--- Placeholder for HASP overlay library ------------------------***
//OLAYLIB  DD  DSN=SYS1.HASPOLIB,
//             DISP=(NEW,CATLG,DELETE),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,1)
//*
//*--- Placeholder for XF Assembler load library -------------------***
//XFASMLIB DD  DSN=SYS1.XFASM.LOAD,
//             DISP=(NEW,CATLG,DELETE),
//             VOL=REF=*.STEP0.HASPVOL,
//             SPACE=(CYL,(2,,8))
//
/*EOF

