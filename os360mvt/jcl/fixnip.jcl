//FIXNIP   JOB CLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      FIXNIP                                             ***
//*    Product:  OS/360 MVT.                                        ***
//*    Purpose:  Select the correct source for IEAANIP. Fix a bug   ***
//*              that causes a loop when IPLing on a 16 MB system.  ***
//*    Step:     5.5                                                ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*    Note:     The lower case i in the second RENAME statement is ***
//*              correct. Do not change it!                         ***
//*                                                                 ***
//*********************************************************************
//*
//PROGM    EXEC PGM=IEHPROGM
//SYSPRINT DD  SYSOUT=A
//DD1      DD  UNIT=3330,VOL=SER=DLIB01,DISP=OLD
//SYSIN    DD  *
 RENAME DSNAME=SYS1.MODGEN2,MEMBER=IEAANIP,NEWNAME=XIEAANIP,           X
               VOL=3330=DLIB01
 RENAME DSNAME=SYS1.MODGEN2,MEMBER=iEAANIP,NEWNAME=IEAANIP,            X
               VOL=3330=DLIB01
//IEAANIP  EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.MODGEN2,UNIT=3330,VOL=SER=DLIB01
//SYSUT2   DD  DISP=SHR,DSN=SYS1.MODGEN2,UNIT=3330,VOL=SER=DLIB01
//SYSIN    DD  DATA
./ CHANGE NAME=IEAANIP
         LTR   9,9                          WRAPAROUND?     @HERCULES   14345020
         BC    8,IEASETKX                   YES, 16 MB DONE @HERCULES   14347020
IEASETKX EQU   *                                            @HERCULES   14360020
./ ENDUP
/*
//*
//
