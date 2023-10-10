//I05MACUP JOB 1,'I05MACUP HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I05MACUP                                           ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Update MVT sysgen macros in SYS1.GENLIB and        ***
//*              SYS1.MODGEN to add HASP support.                   ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*    Notes: 1. An IOGEN or SYSGEN must be performed after         ***
//*              this job is run to include HASP support in         ***
//*              the MVT system.                                    ***
//*                                                                 ***
//*           2. Depending on your MVT distribution, some or        ***
//*              all of the HASP macro mods installed by this job   ***
//*              may already be present.  You may skip updating     ***
//*              any macro whose HASP support is already            ***
//*              installed.                                         ***
//*                                                                 ***
//*           3. SYS1.GENLIB macros SGGBLPAK, SGPAK248 and          ***
//*              SGPAK768 are completely replaced by this job,      ***
//*              rather than being updated, because the macros      ***
//*              as supplied by IBM don't have sequence numbers     ***
//*              on every line.  If you have made any local         ***
//*              mods to any of these macros, review the HASP       ***
//*              versions in SYS1.HASPSUP and update them as        ***
//*              necessary to include your local mods before        ***
//*              running this job.                                  ***
//*                                                                 ***
//*********************************************************************
//*
/*JOBPARM LINES=9999
//*
//*-----------------------------------------------------------------***
//*    Specify volser of MVT DLIB volume.                           ***
//*-----------------------------------------------------------------***
//STEP0   EXEC PGM=IEFBR14
//HASPVOL   DD DISP=OLD,UNIT=3330,VOL=SER=DLIB01  <-- DLIB volser here
//*
//*-----------------------------------------------------------------***
//*    Use IEBDG to build IEBUPDTE control statements.              ***
//*-----------------------------------------------------------------***
//IEBDG   EXEC PGM=IEBDG,COND=(0,NE),REGION=128K
//SYSPRINT  DD SYSOUT=A
//CIECIOS   DD DSN=&&CIOS,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE) 
//CIECIUCB  DD DSN=&&CIUCB,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//CIECXCP   DD DSN=&&CXCP,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//CIODEV    DD DSN=&&CIODEV,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//CGGBLPAK  DD DSN=&&CGBLPAK,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//CGIEC202  DD DSN=&&CIEC202,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//CGPAK248  DD DSN=&&CPAK248,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//CGPAK768  DD DSN=&&CPAK768,DISP=(NEW,PASS),UNIT=SYSDA,
//             DCB=SYS1.HASPSUP,SPACE=(TRK,(5,5),RLSE)
//SYSIN     DD *
  DSD OUTPUT=(CIECIOS)
    FD NAME=KCHANGE,STARTLOC=1,LENGTH=15,PICTURE=15,'./ CHANGE NAME='
    FD NAME=KIOS,STARTLOC=16,LENGTH=8,PICTURE=8,'IECIOS  '
    CREATE NAME=(KCHANGE,KIOS),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CIECIUCB)
    FD NAME=KIUCB,STARTLOC=16,LENGTH=8,PICTURE=8,'IECIUCB '
    CREATE NAME=(KCHANGE,KIUCB),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CIECXCP)
    FD NAME=KXCP,STARTLOC=16,LENGTH=8,PICTURE=8,'IECXCP  '
    CREATE NAME=(KCHANGE,KXCP),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CIODEV)
    FD NAME=NKIODEV,STARTLOC=16,LENGTH=8,PICTURE=8,'IODEVICE'
    CREATE NAME=(KCHANGE,NKIODEV),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CGGBLPAK)
    FD NAME=KADD,STARTLOC=1,LENGTH=15,PICTURE=15,'./    ADD NAME='
    FD NAME=KGBLPAK,STARTLOC=16,LENGTH=8,PICTURE=8,'SGGBLPAK'
    CREATE NAME=(KADD,KGBLPAK),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CGIEC202)
    FD NAME=KC202,STARTLOC=16,LENGTH=8,PICTURE=8,'SGIEC202'
    CREATE NAME=(KCHANGE,KC202),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CGPAK248)
    FD NAME=KPAK248,STARTLOC=16,LENGTH=8,PICTURE=8,'SGPAK248'
    CREATE NAME=(KADD,KPAK248),QUANTITY=1,FILL=X'40'
  END
  DSD OUTPUT=(CGPAK768)
    FD NAME=KPAK768,STARTLOC=16,LENGTH=8,PICTURE=8,'SGPAK768'
    CREATE NAME=(KADD,KPAK768),QUANTITY=1,FILL=X'40'
  END
//*
//*-----------------------------------------------------------------***
//*    Replace SGGBLPAK, SGPAK248 and SGPAK768 macros in            ***
//*    SYS1.GENLIB.                                                 ***
//*-----------------------------------------------------------------***
//GENLIB1  EXEC PGM=IEBUPDTE,PARM=NEW,REGION=96K,COND=(0,NE)
//SYSPRINT  DD SYSOUT=A
//SYSUT2    DD DISP=OLD,DSN=SYS1.GENLIB,
//             SPACE=(CYL,(14,2)),
//             UNIT=SYSDA,VOL=REF=*.STEP0.HASPVOL
//SYSIN     DD DCB=SYS1.HASPSUP,
//             DISP=(OLD,DELETE),DSN=&&CGBLPAK         SGGBLPAK
//          DD DISP=SHR,DSN=SYS1.HASPSUP(SGGBLPAK)     SGGBLPAK
//          DD DISP=(OLD,DELETE),DSN=&&CPAK248         SGPAK248
//          DD DISP=SHR,DSN=SYS1.HASPSUP(SGPAK248)     SGPAK248
//          DD DISP=(OLD,DELETE),DSN=&&CPAK768         SGPAK768
//          DD DISP=SHR,DSN=SYS1.HASPSUP(SGPAK768)     SGPAK768
//*
//*-----------------------------------------------------------------***
//*    Update IODEVICE and SGIEC202 macros in SYS1.GENLIB.          ***
//*-----------------------------------------------------------------***
//GENLIB2  EXEC PGM=IEBUPDTE,PARM=MOD,REGION=96K,COND=(0,NE)
//SYSPRINT  DD SYSOUT=A
//SYSUT1    DD DISP=OLD,DSN=SYS1.GENLIB,
//             UNIT=SYSDA,VOL=REF=*.STEP0.HASPVOL
//SYSUT2    DD DISP=OLD,DSN=SYS1.GENLIB,
//             SPACE=(CYL,(14,2)),
//             UNIT=SYSDA,VOL=REF=*.STEP0.HASPVOL
//SYSIN     DD DCB=SYS1.HASPSUP,
//             DISP=(OLD,DELETE),DSN=&&CIODEV          IODEVICE
//          DD DISP=SHR,DSN=SYS1.HASPSUP(IODEVICE)     IODEVICE
//          DD DISP=(OLD,DELETE),DSN=&&CIEC202         SGIEC202
//          DD DISP=SHR,DSN=SYS1.HASPSUP(SGIEC202)     SGIEC202
//*
//*-----------------------------------------------------------------***
//*    Update IECIOS, IECIUCB and IECXCP macros in SYS1.MODGEN.     ***
//*-----------------------------------------------------------------***
//MODGEN   EXEC PGM=IEBUPDTE,PARM=MOD,REGION=96K,COND=(0,NE)
//SYSPRINT  DD SYSOUT=A
//SYSUT1    DD DISP=OLD,DSN=SYS1.MODGEN,
//             UNIT=SYSDA,VOL=REF=*.STEP0.HASPVOL
//SYSUT2    DD DISP=OLD,DSN=SYS1.MODGEN,
//             UNIT=SYSDA,VOL=REF=*.STEP0.HASPVOL
//SYSIN     DD DCB=SYS1.HASPSUP,
//             DISP=(OLD,DELETE),DSN=&&CIOS            IECIOS
//          DD DISP=SHR,DSN=SYS1.HASPSUP(IECIOS)       IECIOS 
//          DD DISP=(OLD,DELETE),DSN=&&CIUCB           IECIUCB
//          DD DISP=SHR,DSN=SYS1.HASPSUP(IECIUCB)      IECIUCB
//          DD DISP=(OLD,DELETE),DSN=&&CXCP            IECXCP
//          DD DISP=SHR,DSN=SYS1.HASPSUP(IECXCP)       IECXCP
//
/*EOF
