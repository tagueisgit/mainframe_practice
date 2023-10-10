//TCAMSTG1 JOB CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      TCAMSTG1                                           ***
//*    Product:  OS/360 MVT TCAM.                                   ***
//*    Purpose:  Stage 1 generation for TCAM.                       ***
//*    Step:     11.4                                               ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//TCAMSTG1 EXEC ASMFC,PARM.ASM='DECK',REGION.ASM=512K
//ASM.SYSUT1 DD UNIT=SYSDA
//ASM.SYSUT2 DD UNIT=SYSDA
//ASM.SYSUT3 DD UNIT=SYSDA
//ASM.SYSIN DD *
         PRINT NOGEN
         LINEGRP TERM=327L,DDNAME=L3270,LINENO=01,                     +
               DIAL=NO,UNITNO=1,SCREEN=(24,080)
TCAM     TSOMCP
         END
//