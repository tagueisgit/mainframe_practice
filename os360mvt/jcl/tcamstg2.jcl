//TCAMSTG2 JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      TCAMSTG2                                           ***
//*    Product:  OS/360 MVT TCAM.                                   ***
//*    Purpose:  Stage 2 generation for TCAM.                       ***
//*    Step:     11.5                                               ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//ASM      EXEC PGM=IEUASM,PARM='LOAD,NODECK',REGION=512K
//SYSLIB   DD  DSNAME=SYS1.MACLIB,DISP=SHR
//SYSUT1   DD  DSNAME=&SYSUT1,UNIT=SYSDA,SPACE=(1700,(400,50)),
//             SEP=(SYSLIB)
//SYSUT2   DD  DSNAME=&SYSUT2,UNIT=SYSDA,SPACE=(1700,(400,50))
//SYSUT3   DD  DSNAME=&SYSUT3,SPACE=(1700,(400,50)),  
//             UNIT=SYSDA
//SYSPRINT DD  SYSOUT=A
//SYSGO    DD  DSNAME=&LOADSET,UNIT=SYSDA,SPACE=(80,(200,50)),
//             DISP=(MOD,PASS)
//SYSIN DD *
TCAM CSECT
         INTRO ENVIRON=TSO,KEYLEN=60,LNUNITS=3,CIB=2, ...................
               CROSSRF=0,TRACE=0,LINETYP=BOTH,                 .........
               DTRACE=0,STARTUP=C,OLTEST=0,PROGID=TCAM
         LTR   15,15
         BNZ   IEDAYBYE
         LA    3,DCBL1
         LA    4,DCBL2-DCBL1
         LA    5,DCBLAST
         SR    7,7
OPENLOOP LR    1,3
         OPEN  MF=(E,(1))
         USING IHADCB,6
         L     6,0(,3)
         TM    DCBOFLGS,DCBOFOPN
         BO    OPNLTST
         MVC   OPENWTO+34(8),DCBDDNAM
OPENWTO  WTO   'IKJ403I LINE GROUP FOR DD          NOT OPENED',DESC=6, -
               ROUTCDE=2
         B     OPENNEXT
OPNLTST  BALR  7,0
OPENNEXT BXLE  3,4,OPENLOOP
         DROP  6
         B     OPENDONE
DCBL1    DS    0F
DCBLAST  OPEN  (DCB1,(INOUT)),MF=L
DCBL2    EQU   *
OPENDONE DS    0H
         LTR   7,7
         BZ    IEDAYBYE
         READY
         CLOSE (DCB1)
IEDAYBYE L     13,4(,13)
         RETURN (14,12)
         TTABLE LAST=TLAST,MAXLEN=5
OPNAME   OPTION A
TLAST    TERMINAL QBY=T,DCB=DCB1,RLN=1,TERM=327L,QUEUES=TS,        .........
               UTERM=NO,SCRSIZE=(24,80),                          .........
               FEATURE=(NOBREAK,NOATTN)
         TSINPUT
DCB1    DCB   DSORG=TX,MACRF=(G,P),INTVL=0,CPRI=S, .......................
               DDNAME=L3270,BUFIN=2,BUFOUT=3,MH=TSOMH, ....................
               BUFSIZE=60,BUFMAX=3,PCI=(N,N),TRANS=EBCD, ................
               SCT=EBCD,INVLIST=(AA)
AA       INVLIST ORDER=(TLAST+06),AUTO=NO
TSOMH    STARTMH TSOMH=YES,STOP=YES,CONV=YES,LC=IN
         INHDR
         CODE
         LOGON
         INBUF
         CUTOFF 300
         CARRIAGE
         SIMATTN
         INMSG
         ATTEN
         HANGUP
 MSGGEN X'1000000000',C'IKJ54011I TSO IS NOT ACTIVE '
 MSGGEN X'8000000000',C'IKJ54012A ENTER LOGON - '
 MSGGEN X'4000000000',                                                 X
               C'IKJ54013I LOGON FAILED, INVALID COMMAND '
 MSGGEN X'2000000000',                                                 X
               C'IKJ54014I YOUR TERMINAL IS NOT USABLE WITH TSO '
 MSGGEN X'0000200000',                                                 X
               C'IKJ54015I TSO MESSAGES CANNOT REACH THIS TERMINAL '
 MSGGEN X'0800000000',                                                 X
               C'IKJ54016I HIGH PAGING OR MAX USERS, TRY LATER '
 MSGGEN X'0000004000',                                                 X
               C'IKJ54017A TERMINAL ERROR, REENTER INPUT '
 MSGGEN X'0100000000',                                                 X
               C'IKJ54018A MESSAGE TOO LONG, REENTER INPUT '
 MSGGEN X'0200000000',                                                 X
               C'IKJ54020A MESSAGE LOST, REENTER INPUT '
 MSGGEN X'0000800000',X'14065AC915'
 MSGGEN X'0000400000',X'14065AC415'
 MSGGEN X'0000120000',X'14065A15'
 MSGGEN 0,X'FF'
         INEND
         OUTBUF
         CODE
         OUTMSG
         ATTEN
         HANGUP
 MSGGEN X'0000800000',X'14065AC915'
 MSGGEN X'0000120000',X'14065A15'
 MSGGEN X'0000200000',                                                 X
               C'IKJ54015I TSO MESSAGES CANNOT REACH THIS TERMINAL '
 MSGGEN 0,X'FF'
         OUTEND
         DCBD  DSORG=TX
         END
/*
//LKED     EXEC PGM=IEWL,PARM=(XREF,LIST,LET,CALL),REGION=512K,
//             COND=(8,LT,ASM)
//SYSLIN   DD  DSNAME=&LOADSET,DISP=(OLD,DELETE)
//SYSLMOD  DD  DISP=SHR,DSN=SYS1.LINKLIB(IEDQTCAM)
//SYSUT1   DD  DSNAME=&SYSUT1,UNIT=(SYSDA,SEP=(SYSLIN,SYSLMOD)),
//             SPACE=(1024,(50,20))
//SYSPRINT DD  SYSOUT=A
//SYSLIB   DD  DISP=SHR,DSN=SYS1.TELCMLIB
//
