//IEBEDIT  JOB CLASS=A,MSGLEVEL=(1,1)
//COPY     EXEC PGM=IEBEDIT
//SYSIN    DD  *
 EDIT START=ABSTRACT
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DISP=SHR,DSN=ABSTRACT,UNIT=TAPE,VOL=SER=SHAR77,
//             LABEL=(5,SL)
//SYSUT2   DD  SYSOUT=A
//
