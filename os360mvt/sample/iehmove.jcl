//IEHMOVE  JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//LOAD     EXEC PGM=IEHMOVE
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=OLD,UNIT=3330,VOL=SER=WORK02
//DD1      DD  DISP=OLD,UNIT=3330,VOL=SER=HERC30
//TAPEIN   DD  DISP=OLD,UNIT=TAPE,VOL=SER=GODDRD,LABEL=(1,NL),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)
//SYSIN    DD  *
 MOVE DSNAME=G1SYS.VS.LOAD,TO=3330=HERC30,FROM=2400-3=(GODDRD,1),      X
               FROMDD=TAPEIN,RENAME=SYS1.VS2LINK
//