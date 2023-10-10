//CTLG3330  JOB  CLASS=A,MSGLEVEL=(1,1)
//*
//*********************************************************************
//*                                                                 ***
//*    Job:      CTLG3330                                           ***
//*    Product:  OS/360 MVT.                                        ***
//*    Purpose:  Catalog and rename, where needed, all DLIB         ***
//*              datasets in the MFT driving system catalog.        ***
//*    Step:     5.4                                                ***
//*    Update:   2003/02/08                                         ***
//*                                                                 ***
//*********************************************************************
//*
//STEP EXEC PGM=IEHPROGM
//DLIB01 DD UNIT=3330,VOLUME=SER=DLIB01,DISP=OLD
//SYSPRINT DD SYSOUT=A
//SYSIN DD *
 RENAME DSNAME=SYS1.COBLIB,NEWNAME=SYS1.DCOBLIB,VOL=3330=DLIB01
 RENAME DSNAME=SYS1.FORTLIB,NEWNAME=SYS1.DFORTLIB,VOL=3330=DLIB01
 RENAME DSNAME=SYS1.MACLIB,NEWNAME=SYS1.DMACLIB,VOL=3330=DLIB01
 RENAME DSNAME=SYS1.PARMLIB,NEWNAME=SYS1.DPARMLIB,VOL=3330=DLIB01
 RENAME DSNAME=SYS1.PL1LIB,NEWNAME=SYS1.DPL1LIB,VOL=3330=DLIB01
 RENAME DSNAME=SYS1.PROCLIB,NEWNAME=SYS1.DPROCLIB,VOL=3330=DLIB01
 RENAME DSNAME=SYS1.SORTLIB,NEWNAME=SYS1.DSORTLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DCOBLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DFORTLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DMACLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DPARMLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DPL1LIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DPROCLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DSORTLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.AL531,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.AS037,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.CB545,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.CI505,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.CI535,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.CO503,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.CQ513,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.CQ519,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DM508,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DM509,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DN527,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DN533,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DN539,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.DN554,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.ED521,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.FO500,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.FO520,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.FO550,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.GENLIB,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.IO523,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.IO526,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.LD547,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.LM501,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.LM512,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.LM532,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.LM546,VOL=3330=DLIB01
 CATLG   DSNAME=SYS1.LM537,VOL=3330=DLIB01
 CATLG   DSNAME=SYS1.LM542,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.MODGEN,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.NL511,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.PL552,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.RC536,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.RC541,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.RC543,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.RC551,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.RG038,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.SM023,VOL=3330=DLIB01
 CATLG DSNAME=SYS1.UT506,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.TSOGEN,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.TSOMAC,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.TCAMMAC,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.DCMDLIB,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.DUADS,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.DHELP,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.CI555,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.CQ548,VOL=3330=DLIB01
  CATLG    DSNAME=SYS1.MODGEN2,VOL=3330=DLIB01
//