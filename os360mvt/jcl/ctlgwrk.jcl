//CTLGWRK  JOB CLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      CTLGWRK                                            ***
//*    Product:  OS/360 MVT.                                        ***
//*    Purpose:  Catalog the sysgen work datasets in the MFT        ***
//*              driving system catalog. Catalog the system job     ***
//*              queue and dump datasets in the target MVT system   ***
//*              catalog.                                           ***
//*    Step:     5.3                                                ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//CTLGWRK  EXEC PGM=IEHPROGM
//SYSPRINT DD  SYSOUT=A
//CVOL     DD  DISP=SHR,UNIT=3330,VOL=SER=SYSRES
//SYSIN    DD  *
 CATLG DSNAME=SYS1.OBJPDS,VOL=3330=WORK01
 CATLG DSNAME=SYS1.SYSUT1,VOL=3330=WORK01
 CATLG DSNAME=SYS1.SYSUT2,VOL=3330=WORK02
 CATLG DSNAME=SYS1.SYSUT3,VOL=3330=WORK02
 CATLG DSNAME=SYS1.SYSUT4,VOL=3330=WORK01
//MAKECTLG EXEC PGM=IEHPROGM
//SYSPRINT DD  SYSOUT=A
//NEWCVOL  DD  DISP=(NEW,KEEP),UNIT=3330,VOL=SER=MVTRES,DSN=SYSCTLG,
//             SPACE=(CYL,(1,1))
//SYSIN    DD  *
 CATLG DSNAME=SYS1.SYSJOBQE,VOL=3330=MVTRES,CVOL=3330=MVTRES
 CATLG DSNAME=SYS1.DUMP,VOL=3330=MVTRES,CVOL=3330=MVTRES
//
