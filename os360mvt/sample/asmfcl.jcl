//ASMFCL  JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//MIM#3   EXEC ASMFCL,REGION.ASM=256K
//ASM.SYSIN DD DISP=SHR,DSN=MIM#3,UNIT=TAPE,VOL=SER=SHAR77,
//             LABEL=(2,SL)
//LKED.SYSLMOD DD DISP=SHR,DSN=SYS1.HERCLIB(MIM#3)
//
