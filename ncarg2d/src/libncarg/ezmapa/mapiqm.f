C
C $Id: mapiqm.f,v 1.4 1994-03-18 23:18:52 kennison Exp $
C
      SUBROUTINE MAPIQM (IAM,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
C
      DIMENSION IAM(*),XCS(*),YCS(*),IAI(*),IAG(*)
C
C Declare required common blocks.  See MAPBD for descriptions of these
C common blocks and the variables in them.
C
      COMMON /MAPCMB/ IIER
      SAVE /MAPCMB/
      COMMON /MAPCMC/ IGI1,IGI2,NOVS,XCRA(100),YCRA(100),NCRA
      SAVE /MAPCMC/
C
C Check for an uncleared prior error.
C
      IF (.NOT.(ICFELL('MAPIQM - UNCLEARED PRIOR ERROR',1).NE.0))
     +GO TO 10000
      IIER=-1
      RETURN
10000 CONTINUE
C
C Terminate the line, if any.
C
      IF (.NOT.(NCRA.GT.1)) GO TO 10001
      CALL ARDRLN (IAM,XCRA,YCRA,NCRA,XCS,YCS,MCS,IAI,IAG,MAI,LPR)
      IF (.NOT.(ICFELL('MAPIQM',2).NE.0)) GO TO 10002
      IIER=-1
      RETURN
10002 CONTINUE
      NCRA=0
10001 CONTINUE
C
C Done.
C
      RETURN
C
      END
