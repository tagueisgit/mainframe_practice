//TSOSETUP JOB CLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      TSOSETUP                                           ***
//*    Product:  OS/360 MVT TSO.                                    ***
//*    Purpose:  Create TSO parameter member and allocate broadcast ***
//*              and swap datasets.                                 ***
//*    Step:     11.3                                               ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//IKJPRM00 EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.PARMLIB,UNIT=3330,VOL=SER=MVTRES
//SYSUT2   DD  DISP=SHR,DSN=SYS1.PARMLIB,UNIT=3330,VOL=SER=MVTRES
//SYSIN    DD  DATA
./ ADD NAME=IKJPRM00
TS      TERMAX=16
TS      REGNMAX=1
TS      MAP=50
TS      REGSIZE(1)=(200K,16K)
TS      LPA=(IKJPTGT,IKJSCAN,IKJEFT02,IKJEFT25)
TS      LPA=(IKJPARS)
DRIVER  AVGSERVICE PREEMPT SUBQUEUES(1)=3
DRIVER  CYCLES(1,1)=0
DRIVER  CYCLES(1,2)=0
DRIVER  CYCLES(1,3)=0
DRIVER  MAXOCCUPANCY(1,1)=2500
DRIVER  MINSLICE(1,1)=450
DRIVER  MAXOCCUPANCY(1,2)=4500
DRIVER  MINSLICE(1,2)=750
DRIVER  MAXOCCUPANCY(1,3)=4500
DRIVER  MINSLICE(1,3)=4500
DRIVER  SERVICE(1,1)=450
DRIVER  SERVICE(1,2)=1500
DRIVER  SERVICE(1,3)=6000
TIOC    BUFSIZE=44
TIOC    BUFFERS=80
TIOC    OWAITHI=8
TIOC    OWAITLO=4
TIOC    INLOCKHI=4
TIOC    INLOCKLO=2
TIOC    SLACK=01
TIOC    RESVBUF=10
TIOC    USERCHG=99
./ ENDUP
/*
//*
//ALLOCATE EXEC PGM=IEFBR14
//SYSLBC   DD  DISP=(NEW,CATLG),UNIT=3330,VOL=SER=MVTRES,
//             DSN=SYS1.BRODCAST,SPACE=(CYL,1),
//             DCB=(DSORG=DA,RECFM=F,LRECL=129,BLKSIZE=129,KEYLEN=1)
//SYSWAP00 DD  DISP=(NEW,CATLG),UNIT=3330,VOL=SER=MVTRES,
//             DSN=SYS1.SWAP0,SPACE=(CYL,50)
//
