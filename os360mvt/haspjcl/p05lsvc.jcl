//P05LSVC  JOB 1,'P05LSVC  HASP 4',MSGLEVEL=(1,1),CLASS=A,MSGCLASS=A
//*********************************************************************
//*                                                                 ***
//*    Job:      P05LSVC                                            ***
//*    Product:  HASP V4 for MVT.                                   ***
//*    Purpose:  Link HASP SVC into the nucleus.                    ***
//*    Update:   2003/01/26                                         ***
//*                                                                 ***
//*********************************************************************
//*
//LINKSVC EXEC PGM=IEWL,REGION=192K,
//             PARM='NCAL,DC,SIZE=(128K,6K),SCTR,LET,LIST,XREF'
//HASPOBJ  DD  DISP=SHR,DSN=SYS1.HASPOBJ
//SYSUT1   DD  UNIT=SYSDA,SPACE=(CYL,(10,5))
//SYSLMOD  DD  DISP=SHR,DSN=SYS1.NUCLEUS
//SYSPRINT DD  SYSOUT=A
//SYSLIN   DD  *
 INSERT IEAANIP0
 INSERT IEAQFX00
 INCLUDE HASPOBJ(HASPSVC)
 INCLUDE SYSLMOD(IEANUC01)
 NAME IEANUC01(R)
/*
//
/*EOF
