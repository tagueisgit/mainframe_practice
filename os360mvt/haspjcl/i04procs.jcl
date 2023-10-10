//I04PROCS JOB 1,'I04PROCS HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      I04PROCS                                           ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Add HASP procedures to SYS1.PROCLIB.               ***
//*    Update:   2004/12/28                                         ***
//*                                                                 ***
//*********************************************************************
//*
//*-----------------------------------------------------------------***
//*    Add HASP procedures to SYS1.PROCLIB.                         ***
//*-----------------------------------------------------------------***
//PROCS   EXEC PGM=IEBUPDTE,PARM=NEW,REGION=128K
//SYSPRINT DD  SYSOUT=A
//SYSUT2   DD  DISP=SHR,DSN=SYS1.PROCLIB
//SYSIN    DD  DATA
./         ADD NAME=HASP,LIST=ALL
./      NUMBER NEW1=20000,INCR=20000
//IEFPROC EXEC PGM=HASP,REGION=144K,TIME=1440
//OLAYLIB   DD DSNAME=SYS1.HASPOLIB,DISP=SHR
./    ADD NAME=HOSRDR,LIST=ALL
./    NUMBER NEW1=1000,INCR=1000
//IEFPROC EXEC PGM=IEFIRC,REGION=64K,TIME=1440,
//       PARM='00103005005024905611SPOOL   E00011'                     *
//             BPPTTTOOOMMMIIICCCRLSSSSSSSSAAAADD                      X
//         B   PROGRAMMER NAME AND                         B           *
//             ACCOUNT NUMBER NOT NEEDED                               X
//             PROGRAM CAN BE ROLLED OUT                               X
//         P   PRIORITY=01                                 PP          *
//         T   JOB STEP INTERVAL=030 MINUTES               TTT         *
//         O   PRIMARY SYSOUT SPACE=050 TRACKS             OOO         *
//         M   SECONDARY SYSOUT SPACE=050 TRACKS           MMM         *
//         I   READER/INTERPRETER DISPATCHING PRIORITY=249 III         *
//         C   JOB STEP DEFAULT REGION=056K                CCC         *
//         R   DISPLAY AND EXECUTE COMMANDS=1              R           *
//         L   BYPASS LABEL OPTION=1                       L           *
//         S   SYSOUT UNIT NAME=TSOUT                      SSSSSSSS    *
//         A   COMMAND AUTHORITY FOR MCS=E000              AAAA        *
//             ALL COMMANDS MUST BE AUTHORIZED                         X
//         D   JCL AND ALLOCATION MESSAGE                  DD          *
//             LEVEL DEFAULTS=11
//IEFRDER   DD UNIT=00C,DISP=OLD,
//             DCB=(RECFM=F,LRECL=80,BLKSIZE=80,BUFNO=1)
//IEFPDSI   DD DISP=SHR,DSN=SYS1.PROCLIB
//IEFDATA   DD UNIT=SYSDA,VOLUME=REF=SYS1.LINKLIB,
//             SPACE=(80,(200,200),RLSE,CONTIG),DISP=OLD,
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=80,BUFL=80)
./         ADD NAME=ASMHASP,LIST=ALL
./      NUMBER NEW1=20000,INCR=20000
//ASMHASP PROC ASMBLR=IFOX00,MODULE=HASPBR1
//ASM     EXEC PGM=&ASMBLR,REGION=96K,PARM='DECK,NOLOAD'
//STEPLIB   DD DISP=SHR,DSN=SYS1.XFASM.LOAD
//SYSLIB    DD DSNAME=SYS1.HASPSRC,DISP=SHR,DCB=BLKSIZE=3120
//          DD DSNAME=SYS1.MACLIB,DISP=SHR
//SYSUT1    DD UNIT=SYSDA,SPACE=(CYL,(30,10))
//SYSUT2    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSUT3    DD UNIT=SYSDA,SPACE=(CYL,(10,10))
//SYSPRINT  DD SYSOUT=A,SPACE=(3509,(300,50),RLSE),
//             DCB=(RECFM=FBM,LRECL=121,BLKSIZE=3509)
//SYSIN     DD DSNAME=SYS1.HASPSRC(&MODULE),DISP=SHR
//SYSGO     DD DUMMY,DCB=(RECFM=FB,LRECL=80,BLKSIZE=400)
//SYSLIN    DD DUMMY,DCB=(RECFM=FB,LRECL=80,BLKSIZE=400)
//SYSPUNCH  DD DSNAME=SYS1.HASPOBJ(&MODULE),DISP=OLD,
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=400)
./         ADD NAME=RMTGEN,LIST=ALL
./      NUMBER NEW1=20000,INCR=20000
//RMTGEN  EXEC PGM=RMTGEN,REGION=88K
//STEPLIB   DD DSNAME=SYS1.HASPMOD,DISP=SHR
//GENPDS    DD DSNAME=SYS1.HASPSRC(HRTPOPTS),DISP=SHR
//SYSIN     DD UNIT=SYSDA,SPACE=(3200,(200,50),,,ROUND),
//             DCB=(RECFM=FB,BLKSIZE=3200,LRECL=80)
//SYSLIB    DD DSNAME=SYS1.MACLIB,DISP=SHR
//SYSUT1    DD UNIT=SYSDA,SPACE=(1700,(400,50),,,ROUND)
//SYSUT2    DD UNIT=SYSDA,SPACE=(1700,(400,50),,,ROUND)
//SYSUT3    DD UNIT=(SYSDA,SEP=(SYSUT1,SYSUT2,SYSLIB)),
//             SPACE=(1700,(400,50),,,ROUND)
//SYSPRINT  DD SYSOUT=A
//SYSPUNCH  DD SYSOUT=B
//SYSGO     DD UNIT=SYSDA,SPACE=(400,(100,50),,,ROUND),
//             DCB=(RECFM=FB,BLKSIZE=400,LRECL=80)
//CARDIN    DD DDNAME=OPTIONS
./    ADD NAME=HOSBRDR,LIST=ALL
./    NUMBER NEW1=1000,INCR=1000
//IEFPROC EXEC PGM=IKJEFF40,REGION=64K,TIME=1440,
//       PARM='00103005005024905611SPOOL   E00011'                     *
//             BPPTTTOOOMMMIIICCCRLSSSSSSSSAAAADD                      X
//         B   PROGRAMMER NAME AND                         B           *
//             ACCOUNT NUMBER NOT NEEDED                               X
//             PROGRAM CAN BE ROLLED OUT                               X
//         P   PRIORITY=01                                 PP          *
//         T   JOB STEP INTERVAL=030 MINUTES               TTT         *
//         O   PRIMARY SYSOUT SPACE=050 TRACKS             OOO         *
//         M   SECONDARY SYSOUT SPACE=050 TRACKS           MMM         *
//         I   READER/INTERPRETER DISPATCHING PRIORITY=249 III         *
//         C   JOB STEP DEFAULT REGION=056K                CCC         *
//         R   DISPLAY AND EXECUTE COMMANDS=1              R           *
//         L   BYPASS LABEL OPTION=1                       L           *
//         S   SYSOUT UNIT NAME=TSOUT                      SSSSSSSS    *
//         A   COMMAND AUTHORITY FOR MCS=E000              AAAA        *
//             ALL COMMANDS MUST BE AUTHORIZED                         X
//         D   JCL AND ALLOCATION MESSAGE                  DD          *
//             LEVEL DEFAULTS=11
//HASPRDR   DD UNIT=INTRDR,DCB=BUFNO=1
//IEFPDSI   DD DISP=SHR,DSN=SYS1.PROCLIB
//IEFDATA   DD UNIT=SYSDA,VOL=SER=SPOOL1,
//             SPACE=(80,(200,200),RLSE,CONTIG),DISP=OLD,
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=80,BUFL=80)
//IEFRDER   DD DUMMY,DCB=BLKSIZE=80
./ ENDUP
/*
//
/*EOF
