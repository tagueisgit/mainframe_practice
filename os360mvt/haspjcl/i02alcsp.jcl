//I02ALCSP JOB 1,'I02ALCSP HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I02ALCSP                                           ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Allocate SYS1.HASPACE.                             ***
//*    Update:   2003/01/31                                         ***
//*                                                                 ***
//*********************************************************************
//*
//*-----------------------------------------------------------------***
//*    Specify volume to contain new SYS1.HASPACE.                  ***
//*-----------------------------------------------------------------***
//STEP0   EXEC PGM=IEFBR14
//SPOOL    DD  DISP=OLD,UNIT=3330,VOL=SER=SPOOL1    <-- volser here
//*
//*-----------------------------------------------------------------***
//*    Allocate HASP spool data set.                                ***
//*-----------------------------------------------------------------***
//SPOOL    EXEC PGM=IEFBR14,COND=(0,NE)
//HASPACE  DD  DSN=SYS1.HASPACE,
//             DISP=(NEW,CATLG,DELETE),
//             VOL=REF=*.STEP0.SPOOL,
//             SPACE=(CYL,403)
//
/*EOF
