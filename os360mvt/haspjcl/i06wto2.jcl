//I06WTO2  JOB 1,'I06WTO2  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I06WTO2                                            ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Add HASP WTO exit 2 hook to SVC 35.                ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*********************************************************************
//*
//*-----------------------------------------------------------------***
//*    NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE       ***
//*                                                                 ***
//*    This usermod replaces IGC0003E (IEEMVWTO), the initial load  ***
//*    of SVC 35.  It assumes you have specified OPTIONS=MCS on     ***
//*    the sysgen SCHEDULR macro.  Before installing it, back up    ***
//*    your MVT SYSRES volume so that you will have a working       ***
//*    system in case anything goes wrong.                          ***
//*-----------------------------------------------------------------***
//*
//ASM      EXEC PGM=IEUASM,PARM=(LOAD,NODECK),REGION=256K
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB,DCB=BLKSIZE=12320
//          DD DISP=SHR,DSN=SYS1.MODGEN,UNIT=3330,VOL=SER=DLIB01
//*         DD DISP=SHR,DSN=SYS1.PVTMACS
//SYSUT1    DD DSN=&&SYSUT1,UNIT=SYSDA,SPACE=(1700,(600,100))
//SYSUT2    DD DSN=&&SYSUT2,UNIT=SYSDA,SPACE=(1700,(600,100))
//SYSUT3    DD DSN=&&SYSUT3,UNIT=SYSDA,SPACE=(1700,(600,100))
//SYSGO     DD DSN=&&OBJSET,UNIT=SYSDA,SPACE=(1700,(600,100)),
//             DISP=(NEW,PASS),DCB=(RECFM=FB,LRECL=80,BLKSIZE=80)
//SYSPRINT  DD SYSOUT=A
//SYSIN     DD DISP=SHR,DSN=SYS1.HASPSUP(IEEMVWTO)
//*
//LKED     EXEC PGM=IEWL,COND=(4,LT),REGION=200K,
//             PARM='NCAL,LIST,XREF,LET,RENT'
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(5,5))
//SYSPRINT  DD SPACE=(121,(850,100),RLSE),
// DCB=(RECFM=FB,LRECL=121,BLKSIZE=605),
//             SYSOUT=A
//SYSLMOD   DD DISP=OLD,DSNAME=SYS1.SVCLIB(IGC0003E)
//SYSLIN    DD DSN=&&OBJSET,DISP=(OLD,DELETE)
//*
//IOSUP    EXEC PGM=IEHIOSUP,PARM=TSO,COND=(4,LT),REGION=128K
//SYSPRINT  DD SYSOUT=A
//SYSUT1    DD DSNAME=SYS1.SVCLIB,DISP=OLD
//
/*EOF
