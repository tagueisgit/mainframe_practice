//TCAMPRCS JOB CLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      TCAMPRCS                                           ***
//*    Product:  OS/360 MVT TSO/TCAM.                               ***
//*    Purpose:  Add TCAM and TSO procs to SYS1.PROCLIB.            ***
//*    Step:     11.2                                               ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//TCAM     EXEC PGM=IEBUPDTE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=SYS1.PROCLIB
//SYSUT2   DD  DISP=SHR,DSN=SYS1.PROCLIB
//SYSIN    DD  DATA
./ ADD NAME=TCAM
//TCAM     EXEC PGM=IEDQTCAM,ROLL=(NO,NO),TIME=1440,DPRTY=(15,15),
//             REGION=128K
//SYSABEND DD  SYSOUT=A,SPACE=(CYL,(20,10),RLSE)
//L3270    DD  UNIT=0C1
./ ADD NAME=TSO
//TSO      EXEC PGM=IKJEAT00,ROLL=(NO,NO),TIME=1440,DPRTY=(13,13)
//SYSUADS  DD  DISP=SHR,DSN=SYS1.UADS
//SYSPARM  DD  DISP=SHR,DSN=SYS1.PARMLIB
//SYSLBC   DD  DISP=SHR,DSN=SYS1.BRODCAST
//SYSWAP00 DD  DISP=SHR,DSN=SYS1.SWAP0
//IEFPDSI  DD  DISP=SHR,DSN=SYS1.PROCLIB
./ ADD NAME=IKJACCNT
//IKJACCNT EXEC PGM=IKJEFT01,ROLL=(NO,NO)
//STEPLIB  DD  DISP=SHR,DSN=SYS1.CMDLIB
//SYSUADS  DD  DISP=SHR,DSN=SYS1.UADS
//SYSHELP  DD  DISP=SHR,DSN=SYS1.HELP
//DD1      DD  DYNAM
//DD2      DD  DYNAM
//DD3      DD  DYNAM
//DD4      DD  DYNAM
//DD5      DD  DYNAM
//DD6      DD  DYNAM
//DD7      DD  DYNAM
//DD8      DD  DYNAM
./ ENDUP
/*
//*
//
