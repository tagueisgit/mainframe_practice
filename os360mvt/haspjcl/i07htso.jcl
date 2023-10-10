//I07HTSO  JOB 1,'I07HTSO  HASP 4',MSGLEVEL=(1,1),
//               COND=(0,NE),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I07HTSO                                            ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Install TSO CANCEL/STATUS hooks for HASP.          ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*********************************************************************
//*
/*JOBPARM LINES=9999
//*
//*-----------------------------------------------------------------***
//*    Assemble IKJEFF00 (SVC 100).                                 ***
//*-----------------------------------------------------------------***
//AEFF00  EXEC PGM=IFOX00,REGION=2048K,PARM=(DECK,NOLOAD),COND=(0,NE)
//STEPLIB   DD DISP=SHR,DSN=SYS1.XFASM.LOAD
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT2    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT3    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSPRINT  DD SYSOUT=A
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD DUMMY
//SYSGO     DD DUMMY
//SYSPUNCH  DD DSN=&&EFF00,UNIT=SYSDA,SPACE=(80,(200,50)),
//             DISP=(NEW,PASS)
//SYSIN     DD DISP=SHR,DSN=SYS1.HASPSUP(IKJEFF00)
//*
//*-----------------------------------------------------------------***
//*    Append link edit control statements for the SVC 100          ***
//*    load module with overpunched "0" in last position            ***
//*    of load module NAME statement.                               ***
//*-----------------------------------------------------------------***
//DEFF00  EXEC PGM=IEBDG,COND=(0,NE),REGION=128K
//SYSPRINT  DD SYSOUT=A
//OUTSET    DD DISP=(MOD,PASS),DSN=&&EFF00
//SYSIN     DD *
  DSD OUTPUT=(OUTSET)
    FD NAME=CARD1,STARTLOC=1,LENGTH=15,PICTURE=15,' ENTRY IKJEFF00'
    FD NAME=CARD2A,STARTLOC=1,LENGTH=13,PICTURE=13,' NAME IGC0010'
    FD NAME=CARD2B,STARTLOC=14,LENGTH=1,PICTURE=3,B'192'
    FD NAME=CARD2C,STARTLOC=15,LENGTH=3,PICTURE=3,'(R)'
    CREATE NAME=(CARD1),QUANTITY=1,FILL=X'40'
    CREATE NAME=(CARD2A,CARD2B,CARD2C),QUANTITY=1,FILL=X'40'
  END
//*
//*-----------------------------------------------------------------***
//*    Assemble IKJEFF41 (BRDR reader/interpreter linkage           ***
//*    routine).                                                    ***
//*-----------------------------------------------------------------***
//AEFF41  EXEC PGM=IFOX00,REGION=2048K,PARM=(DECK,NOLOAD),COND=(0,NE)
//STEPLIB   DD DISP=SHR,DSN=SYS1.XFASM.LOAD
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT2    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT3    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSPRINT  DD SYSOUT=A
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD DUMMY
//SYSGO     DD DUMMY
//SYSPUNCH  DD DSN=&&EFF41,UNIT=SYSDA,SPACE=(80,(200,50)),
//             DISP=(NEW,PASS)
//SYSIN     DD DISP=SHR,DSN=SYS1.HASPSUP(IKJEFF41)
//*
//*-----------------------------------------------------------------***
//*    Assemble IKJEFF47 (BRDR HASP exit).                          ***
//*-----------------------------------------------------------------***
//AEFF47  EXEC PGM=IFOX00,REGION=2048K,PARM=(DECK,NOLOAD)
//STEPLIB   DD DISP=SHR,DSN=SYS1.XFASM.LOAD
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT2    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT3    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSPRINT  DD SYSOUT=A
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD DUMMY
//SYSGO     DD DUMMY
//SYSPUNCH  DD DSN=&&EFF47,UNIT=SYSDA,SPACE=(80,(200,50)),
//             DISP=(NEW,PASS)
//SYSIN     DD DISP=SHR,DSN=SYS1.HASPSUP(IKJEFF47)
//*
//*-----------------------------------------------------------------***
//*    Assemble IKJEFF50 (CANCEL/STATUS initialization routine).    ***
//*-----------------------------------------------------------------***
//AEFF50  EXEC PGM=IFOX00,REGION=2048K,PARM=(DECK,NOLOAD),COND=(0,NE)
//STEPLIB   DD DISP=SHR,DSN=SYS1.XFASM.LOAD
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT2    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT3    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSPRINT  DD SYSOUT=A
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD DUMMY
//SYSGO     DD DUMMY
//SYSPUNCH  DD DSN=&&EFF50,UNIT=SYSDA,SPACE=(80,(200,50)),
//             DISP=(NEW,PASS)
//SYSIN     DD DISP=SHR,DSN=SYS1.HASPSUP(IKJEFF50)
//*
//*-----------------------------------------------------------------***
//*    Assemble IKJEFF55 (CANCEL/STATUS message CSECT).             ***
//*-----------------------------------------------------------------***
//AEFF55  EXEC PGM=IFOX00,REGION=2048K,PARM=(DECK,NOLOAD),COND=(0,NE)
//STEPLIB   DD DISP=SHR,DSN=SYS1.XFASM.LOAD
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB,DCB=BLKSIZE=12960
//          DD DISP=SHR,DSN=SYS1.HASPSUP
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT2    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT3    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSPRINT  DD SYSOUT=A
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD DUMMY
//SYSGO     DD DUMMY
//SYSPUNCH  DD DSN=&&EFF55,UNIT=SYSDA,SPACE=(80,(200,50)),
//             DISP=(NEW,PASS)
//SYSIN     DD DISP=SHR,DSN=SYS1.HASPSUP(IKJEFF55)
//*
//*-----------------------------------------------------------------***
//*    Link IKJEFF00 to SYS1.SVCLIB as SVC 100.                     ***
//*-----------------------------------------------------------------***
//LEFF00  EXEC PGM=IEWL,COND=(8,LT),REGION=200K,
//             PARM='NCAL,LIST,XREF,RENT,REUS,DC'
//SYSLMOD   DD DISP=SHR,DSN=SYS1.SVCLIB
//SYSUT1    DD DSN=&SYSUT1,UNIT=SYSDA,SPACE=(1024,(50,20))
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD DISP=(OLD,DELETE),DSN=&&EFF00
//*
//*-----------------------------------------------------------------***
//*    Run IEHIOSUP to rebuild TTRs in SYS1.SVCLIB.                 ***
//*-----------------------------------------------------------------***
//IOSUP   EXEC PGM=IEHIOSUP,PARM=TSO,COND=(0,NE),REGION=128K
//SYSPRINT  DD SYSOUT=A
//SYSUT1    DD DSNAME=SYS1.SVCLIB,DISP=SHR
//*
//*-----------------------------------------------------------------***
//*    Link IKJEFF41 to SYS1.LINKLIB.                               ***
//*-----------------------------------------------------------------***
//LEFF46  EXEC PGM=IEWL,COND=(8,LT),REGION=200K,
//             PARM='NCAL,LIST,XREF,LET,REUS,RENT,REFR'
//SYSLMOD   DD DISP=SHR,DSN=SYS1.LINKLIB
//EFF41     DD DISP=(OLD,DELETE),DSN=&&EFF41
//SYSUT1    DD DSN=&SYSUT1,UNIT=SYSDA,SPACE=(1024,(50,20))
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD *
    INCLUDE EFF41
    INCLUDE SYSLMOD(IKJEFF41)
    ENTRY IKJEFF41
    NAME IKJEFF41(R)
//*
//*-----------------------------------------------------------------***
//*    Link IKJEFF47 to SYS1.LINKLIB.                               ***
//*-----------------------------------------------------------------***
//LEFF47  EXEC PGM=IEWL,COND=(8,LT),REGION=200K,
//             PARM='NCAL,LIST,XREF,LET,REUS,RENT,REFR'
//SYSLMOD   DD DISP=SHR,DSN=SYS1.LINKLIB
//EFF47     DD DISP=(OLD,DELETE),DSN=&&EFF47
//SYSUT1    DD DSN=&SYSUT1,UNIT=SYSDA,SPACE=(1024,(50,20))
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD *
    INCLUDE EFF47
    ENTRY IKJEFF47
    NAME IKJEFF47(R)
//*
//*-----------------------------------------------------------------***
//*    Link IKJEFF50 as STATUS command to SYS1.CMDLIB.              ***
//*-----------------------------------------------------------------***
//LEFF50  EXEC PGM=IEWL,COND=(8,LT),REGION=200K,
//             PARM='NCAL,LIST,XREF,REUS,RENT,REFR'
//SYSLMOD   DD DISP=SHR,DSN=SYS1.CMDLIB
//EFF50     DD DISP=(OLD,DELETE),DSN=&&EFF50
//EFF55     DD DISP=(OLD,DELETE),DSN=&&EFF55
//SYSUT1    DD DSN=&SYSUT1,UNIT=SYSDA,SPACE=(1024,(50,20))
//SYSPRINT  DD SYSOUT=A
//SYSLIN    DD *
    INCLUDE EFF50
    INCLUDE EFF55
    INCLUDE SYSLMOD(STATUS)
    ENTRY IKJEFF50
    ALIAS IKJEFF5A    /* CANCEL entry point */
    ALIAS ST
    NAME STATUS(R)
//*
//
