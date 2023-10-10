//P06LHASP JOB 1,'P06LHASP HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      P06LHASP                                           ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Build HASP load module.                            ***
//*    Update:   2003/02/02                                         ***
//*                                                                 ***
//*********************************************************************
//*
//*-----------------------------------------------------------------***
//*    Delete existing overlay library.                             ***
//*-----------------------------------------------------------------***
//DELETE  EXEC PGM=IEFBR14
//HASPOLIB DD  DISP=(OLD,DELETE),DSN=SYS1.HASPOLIB
//*
//*-----------------------------------------------------------------***
//*    Build overlay library.                                       ***
//*-----------------------------------------------------------------***
//OBLD    EXEC PGM=HASPOBLD
//STEPLIB  DD  DISP=SHR,DSN=SYS1.HASPMOD
//SYSOBJ   DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPNUC)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPRDR)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPXEQ)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPWTR)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPPRPU)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPACCT)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPMISC)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPCON)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPRTAM)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPCOMM)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPINIT)
//         DD  DISP=SHR,DSN=SYS1.HASPOBJ(HASPINTF)
//SYSLIN   DD  DSN=&&TEMP,UNIT=SYSDA,DISP=(NEW,PASS),
//             SPACE=(400,(400,50)),DCB=BLKSIZE=400
//OLAYLIB  DD  DSN=SYS1.HASPOLIB,UNIT=SYSDA,VOL=REF=SYS1.HASPMOD,
//             DISP=(NEW,CATLG),
//             SPACE=(CYL,1)
//SYSPRINT DD  SYSOUT=A,DCB=BLKSIZE=121
//SYSIN    DD  *,DCB=BLKSIZE=80   <---- HASPOBLD input goes here
/*
//*
//*-----------------------------------------------------------------***
//*    Link HASP load module into SYS1.LINKLIB.                     ***
//*-----------------------------------------------------------------***
//LKHASP  EXEC PGM=IEWL,PARM='XREF,LIST',REGION=192K,COND=(4,LT,OBLD)
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(10,5))
//SYSLMOD  DD  DISP=SHR,DSN=SYS1.LINKLIB
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  DSN=&&TEMP,DISP=(OLD,DELETE)
//         DD *
 NAME HASP(R)
/*
//
/*EOF
