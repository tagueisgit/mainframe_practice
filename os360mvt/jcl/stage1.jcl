//STAGE1   JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      STAGE1                                             ***
//*    Product:  OS/360 MVT.                                        ***
//*    Purpose:  Stage 1 system generation. Defines the             ***
//*              configuration of the generated system, and         ***
//*              generates the stage 2 deck that does the work.     ***
//*    Step:     6.2                                                ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//ASMBLR   EXEC PGM=IEUASM,PARM='LIST,NOLOAD,DECK,NOXREF',REGION=256K
//SYSPRINT DD  SYSOUT=A
//SYSLIB   DD  DSN=SYS1.GENLIB,UNIT=3330,VOL=SER=DLIB01,DISP=SHR
//SYSPUNCH DD  UNIT=00D,DCB=BLKSIZE=80
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(35,10)),VOL=SER=WORK01
//SYSUT2   DD  UNIT=SYSDA,SPACE=(CYL,(35,10)),VOL=SER=WORK02
//SYSUT3   DD  UNIT=SYSDA,SPACE=(CYL,(50,10)),VOL=SER=WORK02
//SYSIN    DD  *
*
* SET FLAG TO ALLOW 768 DEVICES
*
    GBLB       &LIMIT(4)
&LIMIT(3) SETB 1
*
* SYSTEM CONFIGURATION
*
    CTRLPROG   TYPE=MVT,                   MVT SYSTEM                  X
               MAXIO=10,                   MAX 10 CONCURRENT I/OS      X
               FETCH=PCI,                  PCI PROGRAM FETCH           X
               ADDTRAN=15,                 15 ADDL TRANSIENT AREAS     X
               QSPACE=24,                  24 2K BLOCKS OF SQA         X
               OPTIONS=(SERVAID),          INCLUDE SERVICE AIDS        X
               HIARCHY=EXCLUDE             NO STORAGE HIERARCHIES
    CENPROCS   MODEL=158,                  370/158 CPU                 X
               INSTSET=UNIV,               WITH STORAGE PROTECTION     X
               FEATURE=PROTECT             AND UNIVERSAL CHARACTER SET
    SUPRVSOR   OPTIONS=(IDENTIFY,          INCLUDE IDENTIFY            X
               TRSVCTBL,                   RESIDENT SVC TTR TABLE      X
               COMM,                       ISSUE IEA101A AT IPL        X
               PROTECT,                    STORAGE PROTECTION          X
               ONLNTEST,                   INCLUDE OLTEP               X
               CCH,                        CHANNEL CHECK HANDLER       X
               DDR,                        DYNAMIC DEVICE RECONFIG     X
               DDRSYS,                     DDR FOR SYSTEM PACK         X
               APR,                        ALTERNATE PATH RETRY        X
               RER,                        REDUCED TAPE ERROR RECOVERY X
               DDRNSL),                    DDR FOR NONSTANDARD LABELS  X
               RESIDNT=(ATTACH,EXTRACT,IDENTIFY,SPIE,                  X
               BLDLTAB,ACSMETH,TRSVC,RENTCODE,ERP), RESIDENT SERVICES  X
               SER=MCH,                    HARDWARE ERROR RECOVERY     X
               WAIT=MULTIPLE,              MULTIPLE EVENT WAIT         X
               TIMER=JOBSTEP,              ALL TIMING FUNCTIONS        X
               TRACE=200,                  TRACE TABLE OF 200 ENTRIES  X
               ASCII=INCRES,               ASCII TRANSLATION RESIDENT  X
               USERERR=YES,                USER ERROR EXITS            X
               ALTSYS=350                  ALTERNATE SYSTEM VOLUME ADDR
    SCHEDULR   TYPE=MVT,                   MVT SYSTEM                  X
               VLMOUNT=AVR,                AUTOMATIC VOLUME RECOGNITIONX
               CONOPTS=(MCS,NOEXIT),       MULTIPLE CONSOLE SUPPORT    X
               CONSOLE=0C0,                MASTER CONSOLE              X
               ALTCONS=01F,                FIRST ALTERNATE CONSOLE     X
               HARDCPY=(01E,ALL,STCMDS),   HARDCOPY LOG OPTIONS        X
               ROUTCDE=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16), WTOS  X
               AREA=(8),                   STATUS DISPLAY AREA SIZE    X
               PFK=12,                     12 PF KEYS                  X
               OPSTRAN=1,                                              X
               REPLY=20,                   20 WTOR BUFFERS             X
               WTOBFRS=100,                100 WTO BUFFERS             X
               STARTI=MANUAL,              START INITS MANUALLY        X
               JOBQFMT=12,                 JOB QUEUE LOGICAL TRACK SIZEX
               JOBQWTP=2,                  WTP JOB QUEUE RECORDS       X
               JOBQLMT=180,                RESERVED JOB QUEUE RECORDS  X
               JOBQTMT=60,                 RESERVED JOB QUEUE RECORDS  X
               OPTIONS=(LOG,               INCLUDE SYSTEM LOG          X
               RJE,                        INCLUDE REMOTE JOB ENTRY    X
               CRJE,                       INCLUDE CONVERSATIONAL RJE  X
               TSO),                       INCLUDE TSO                 X
               WTLBFRS=10,                 10 WRITE-TO-LOG BUFFERS     X
               ACCTRTN=SMF,                SMF USED FOR ACCOUNTING     X
               ESV=NO,                     NO VOLUME ERROR STATISTICS  X
               EVA=NO                      NO ERROR VOLUME ANALYSIS
    SECONSLE   CONSOLE=01F,                SECONDARY CONSOLE           X
               ALTCONS=0C0,                ALTERNATE IS 0C0            X
               ROUTCDE=ALL,                ALL ROUTING CODES           X
               VALDCMD=(1,2,3),            ALL COMMANDS VALID          X
               USE=FC                      FULL CAPABILITY CONSOLE
    SECONSLE   CONSOLE=O-01E               OUTPUT-ONLY CONSOLE FOR LOG
    DATAMGT    ACSMETH=(BDAM,ISAM,BTAM,TCAM) INCLUDE ACCESS METHODS
    DCMLIB
    GRAPHICS   PORRTNS=INCLUDE,GSP=EXCLUDE
    HELP
    IMAGELIB
    MACLIB     EXCLUDE=(QTAM,GPS,OCR)
    PARMLIB
    PROCLIB
    SORTLIB
    SORTMERG   SIZE=65536,RECTYPE=(FIXED,VAR,LONG),                    X
               CNTLFLD=(MULTIPLE),                                     X
               MESSAGE=(PRINTER,ALL),                                  X
               SORTDEV=(2311,2314,2301)
    SYSUTILS   SIZE=64K
    TELCMLIB
    UADS
    UCS        UNIT=1403,IMAGE=(AN,PN,TN),DEFAULT=(AN,PN,TN)
    UCS        UNIT=3211,IMAGE=(P11,T11),DEFAULT=(P11,T11)
*
* COMPILERS AND LIBRARIES
*
    ALGOL
    ALGLIB
    ASSEMBLR   DESIGN=F
    CHECKER    TYPE=FORTRAN,DESIGN=H
    CHECKER    TYPE=PL1
    CMDLIB
    COBOL      DESIGN=E
    COBOL      DESIGN=U
    COBLIB     DESIGN=E
    COBLIB     DESIGN=U
    FORTRAN    DESIGN=G
    FORTRAN    DESIGN=H,SIZE=256K
    FORTLIB    DESIGN=H
    PL1        DESIGN=F
    PL1LIB
    RPG
*
* LINKAGE EDITOR AND LOADER
*
    EDITOR     DESIGN=F128,SIZE=128K
    LOADER
*
* I/O CONFIGURATION
*
* CHANNEL 0: UNIT RECORD DEVICES, 3270
*
    CHANNEL    ADDRESS=0,TYPE=MULTIPLEXOR
    IOCONTRL   UNIT=2821,MODEL=5,ADDRESS=008
    IODEVICE   UNIT=2520,ADDRESS=00B,MODEL=B1,FEATURE=(CARDIMAGE)
    IODEVICE   UNIT=2540R,ADDRESS=00C,MODEL=1,FEATURE=(CARDIMAGE)
    IODEVICE   UNIT=2540P,ADDRESS=00D,MODEL=1
    IODEVICE   UNIT=1403,MODEL=N1,ADDRESS=00E,FEATURE=(UNVCHSET)
    IOCONTRL   UNIT=3811,ADDRESS=010
    IODEVICE   UNIT=3211,ADDRESS=010
    IOCONTRL   UNIT=2821,MODEL=5,ADDRESS=018
    IODEVICE   UNIT=1403,MODEL=N1,ADDRESS=01E,FEATURE=(UNVCHSET)
    IODEVICE   UNIT=3215,ADDRESS=01F
    IOCONTRL   UNIT=3272,MODEL=2,ADDRESS=0C0
    IODEVICE   UNIT=3277,MODEL=2,ADDRESS=(0C0,8),                      X
               FEATURE=(EBKY3277,AUDALRM,DOCHAR)
*
* CHANNEL 1: DASD
*
    CHANNEL    ADDRESS=1,TYPE=BLKMPXR
    IODEVICE   UNIT=2314,ADDRESS=(130,8)
    IODEVICE   UNIT=3330,MODEL=1,ADDRESS=(150,8)
    IODEVICE   UNIT=3330,MODEL=1,ADDRESS=(160,8)
*
* CHANNEL 2: TAPE
*
    CHANNEL    ADDRESS=2,TYPE=BLKMPXR
    IOCONTRL   UNIT=3803,MODEL=2,ADDRESS=280
    IODEVICE   UNIT=3420,MODEL=3,ADDRESS=(280,6)
*
* CHANNEL 3: DASD
*
    CHANNEL    ADDRESS=3,TYPE=BLKMPXR
    IODEVICE   UNIT=2314,ADDRESS=(330,8)
    IODEVICE   UNIT=3330,MODEL=1,ADDRESS=(350,8)
    IODEVICE   UNIT=3330,MODEL=1,ADDRESS=(360,8)
*
* CHANNEL 7: HASP PSEUDO DEVICES
*
    CHANNEL    ADDRESS=7,TYPE=BLKMPXR
    IODEVICE   ADDRESS=(700,12),UNIT=HASP-2540R   Pseudo readers
    IODEVICE   ADDRESS=(720,32),UNIT=HASP-1403    Pseudo printers
    IODEVICE   ADDRESS=(770,8),UNIT=HASP-2540P    Pseudo punches
    IODEVICE   ADDRESS=(780,6),UNIT=HASP-2520     Internal readers
*
* ESOTERIC UNIT DEFINITIONS: SYSDA, SYSSQ, TAPE, HASP-REQUIRED
* 
    UNITNAME   NAME=DISK,UNIT=((130,8),(150,8),(160,8),(330,8),        X
               (350,8),(360,8))
    UNITNAME   NAME=SYSDA,UNIT=((130,8),(150,8),(160,8),(330,8),       X
               (350,8),(360,8))
    UNITNAME   NAME=SYSALLDA,UNIT=((130,8),(150,8),(160,8),(330,8),    X
               (350,8),(360,8))
    UNITNAME   NAME=SYSSQ,UNIT=((130,8),(150,8),(160,8),(330,8),       X
               (350,8),(360,8),(280,6))
    UNITNAME   NAME=SORT,UNIT=((130,8),(330,8))
    UNITNAME   NAME=SORTWK,UNIT=((130,8),(330,8))
    UNITNAME   NAME=SORTWORK,UNIT=((130,8),(330,8))
    UNITNAME   NAME=TAPE,UNIT=((280,6))
    UNITNAME   NAME=R,UNIT=((701,11))             Pseudo readers
    UNITNAME   NAME=A,UNIT=((721,31))             Pseudo printers
    UNITNAME   NAME=B,UNIT=((770,8))              Pseudo punches
    UNITNAME   NAME=INTRDR,UNIT=((780,6))         Internal readers
*
* HASP SVC DEFINITION
*
    SVCTABLE   SVC-220-T1-S0                      HASP SVC
*
* GENERATE MACRO
*
    OUTPUT     CLASS=(A,A)
    PRINT      NOGEN
    GENTSO     RESTYPE=3330,                                           X
               RESNAME=3330,                                           X
               RESVOL=MVTRES,                                          X
               LNKNAME=3330,                                           X
               LNKVOL=MVTRES,                                          X
               UT1SDS=SYS1.SYSUT1,                                     X
               UT2SDS=SYS1.SYSUT2,                                     X
               UT3SDS=SYS1.SYSUT3,                                     X
               UT4SDS=SYS1.SYSUT4,                                     X
               OBJPDS=SYS1.OBJPDS,                                     X
               INDEX=MVT1,                                             X
               LEPRT=(LIST,XREF),                                      X
               GENTYPE=ALL
    END
//
