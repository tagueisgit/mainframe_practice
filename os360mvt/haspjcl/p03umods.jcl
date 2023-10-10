//P03UMODS JOB 1,'P03UMODS HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      P03UMODS                                           ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Update customized HASP source in SYS1.HASPSRC      ***
//*              with user modifications.  Usermods included        ***
//*              in this sample job are:                            ***
//*                                                                 ***
//*                THAS811    Test if hot reader is ready during    ***
//*                           initialization and leave DCTHOLD on   ***
//*                           if not.                               ***
//*                THAS812    Recognize "SYSOUT=*".                 ***
//*                THAS813    Start and stop HOSBRDR.               ***
//*                                                                 ***
//*    Update:   2004/12/31                                         ***
//*                                                                 ***
//*    Note:     Message "IEB805I CONTROL STATEMENT ERROR" and      ***
//*              return code 4 are normal if there are no usermods  ***
//*              in the SYSIN input stream.  If usermods are        ***
//*              present, any return code except 0 indicates        ***
//*              an error.                                          ***
//*                                                                 ***
//*********************************************************************
//*
//UMODS   EXEC PGM=IEBUPDTE,PARM=MOD,REGION=96K
//SYSUT1   DD  DISP=OLD,DSN=SYS1.HASPSRC
//SYSUT2   DD  DISP=OLD,DSN=SYS1.HASPSRC
//SYSPRINT DD  SYSOUT=A
//SYSIN    DD  DATA,DLM='??'
./ CHANGE NAME=HASPCOMM ========================================================
         XR    R0,R0               Issue                       @THAS813 C5699020
         LA    R1,CPSBRDR           "STOP HOSBRDR"             @THAS813 C5699040
         SVC   34                    command                   @THAS813 C5699060
CPSBRDR  DC    0F'0',AL2(CPSBRDRL,0),C'P HOSBRDR.HOSBRDR '     @THAS813 C5958130
CPSBRDRL EQU   *-CPSBRDR                                       @THAS813 C5958160
./ CHANGE NAME=HASPINIT ========================================================
         AIF   (NOT &AUTORDR).NOARDRB                          @THAS811 N4667010
*------------------------------------------------------------* @THAS811 N4667020
*        The following logic tests if a hot reader is        * @THAS811 N4667030
*        ready.  If the reader is not ready, DCTHOLD         * @THAS811 N4667040
*        will be left turned on in its DCT so HASPRDR's      * @THAS811 N4667050
*        $GETUNIT for the device will fail, preventing       * @THAS811 N4667060
*        HASPRDR from trying to read from the not ready      * @THAS811 N4667070
*        device.  If the reader is ready, DCTHOLD will be    * @THAS811 N4667080
*        turned off to permit normal HASPRDR processing.     * @THAS811 N4667090
*------------------------------------------------------------* @THAS811 N4667100
         CLI   DCTDEVTP,DCTRDR     Is this a reader?           @THAS811 N4667110
         BNE   NURAVAIL            Branch if not a reader      @THAS811 N4667120
         TM    UCBFL1,X'FE'        Test UCB flags              @THAS811 N4667130
         BNZ   NURDRAIN            Drain reader if unavailable @THAS811 N4667140
NURRDSIO LA    R1,NURRDCCW         Get CCW address             @THAS811 N4667150
         ST    R1,72                and put in CAW             @THAS811 N4667160
         LH    R1,UCBCHA           Get reader address          @THAS811 N4667170
         N     R1,=A(X'00000FFF')   in R1                      @THAS811 N4667180
         SIO   0(R1)                 and issue NOP to reader   @THAS811 N4667190
         BC    1,NURDRAIN          Drain reader if inoperative @THAS811 N4667200
         BC    4,NURRDCST          Branch if CSW stored        @THAS811 N4667210
         BC    2,NURRDSIO          Wait for I/O to take        @THAS811 N4667220
NURRDTIO LH    R1,UCBCHA           Get reader address          @THAS811 N4667230
         N     R1,=A(X'00000FFF')   in R1                      @THAS811 N4667240
         TIO   0(R1)                 and test for completion   @THAS811 N4667250
         BC    1,NURDRAIN          Drain reader if inoperative @THAS811 N4667260
         BC    2,NURRDTIO          Loop until complete         @THAS811 N4667270
         BC    8,NURAVAIL          Available, go lift DCTHOLD  @THAS811 N4667280
NURRDCST TM    68,X'02'            Test for unit check         @THAS811 N4667290
         BO    NURRDHLD            Leave reader DCT held if so @THAS811 N4667300
         TM    69,X'3F'            Test permanent I/O errors   @THAS811 N4667310
         BZ    NURAVAIL            None, make reader available @THAS811 N4667320
NURRDHLD NI    DCTSTAT,255-DCTDRAIN Else leave reader DCT held @THAS811 N4667330
         B     NURASOFF            Continue                    @THAS811 N4667340
NURRDCCW CCW   X'03',0,X'20',1     NOP CCW for reader test     @THAS811 N4667350
*------------------------------------------------------------* @THAS811 N4667360
*        End of code to test if hot reader is ready.         * @THAS811 N4667370
*------------------------------------------------------------* @THAS811 N4667380
.NOARDRB ANOP  ,                                               @THAS811 N4667390
NURASOFF NI    SRTESTAT,255-SRTEONLI Vary auto starts offline  @THAS811 N4670000
         XR    R0,R0               Issue                       @THAS813 N6038320
         LA    R1,NSTRBRDR          "START HOSBRDR"            @THAS813 N6038340
         SVC   34                    command                   @THAS813 N6038360
NSTRBRDR DC    0F'0',AL2(NSTRBRDL,0),C'S HOSBRDR.HOSBRDR '     @THAS813 N6168030
NSTRBRDL EQU   *-NSTRBRDR                                      @THAS813 N6168070
./ CHANGE NAME=HASPXEQ =========================================================
         CLI   3(R1),C'*'          Was class specified as "*"? @THAS812 X6698040
         BE    XJCLSYST            Go set to MSGCLASS if so    @THAS812 X6698060
XJCLSYST IC    WA,XJCLOMC+1        Set SYSOUT class = MSGCLASS @THAS812 X6704000
./ ENDUP =======================================================================
??
//
/*EOF
