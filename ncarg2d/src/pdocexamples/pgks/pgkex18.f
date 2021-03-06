
      PROGRAM PGKEX18
C
C  Produce an NX x NY  CELL ARRAY based on the Mandelbrot set--color
C  the cells depending upon the speed of convergence or divergence.
C
C Define the error file, the Fortran unit number, the workstation type,
C and the workstation ID to be used in calls to GKS routines.
C
C     PARAMETER (IERRF=6, LUNIT=2, IWTYPE=1,  IWKID=1)   ! NCGM
C     PARAMETER (IERRF=6, LUNIT=2, IWTYPE=8,  IWKID=1)   ! X Windows
C     PARAMETER (IERRF=6, LUNIT=2, IWTYPE=11, IWKID=1)   ! PDF
C     PARAMETER (IERRF=6, LUNIT=2, IWTYPE=20, IWKID=1)   ! PostScript
C
      PARAMETER (IERRF=6, LUNIT=2, IWTYPE=1,  IWKID=1)
      PARAMETER (NX=20, NY=20, NITER=101)
      INTEGER COLIA(NX,NY)
      COMPLEX Z
C
C  Region of interest.
C
      DATA XL,XR,YB,YT/-2.,.5,-1.25,1.25/
C
C  Open GKS, open and activate a workstation.
C
      CALL GOPKS (IERRF,IDUM)
      CALL GOPWK (IWKID,LUNIT,IWTYPE)
      CALL GACWK (IWKID)
C
C  Set up normalizaton transformation.
C
      CALL GSWN(1,XL,XR,YB,YT)
      CALL GSVP(1,.1,.9,0.,.8)
      CALL GSELNT(1)
C
C  Define color indices in a continuous spectrum.
C
      DO 11 K = 1,NITER
        H = REAL(K)/REAL(NITER)*360.
        CALL HLSRGB(H,50.,100.,RV,GV,BV)
        CALL GSCR(IWKID,K,RV,GV,BV)
   11 CONTINUE
      CALL GSCR(IWKID,NITER+1,0.,0.,1.)
C
C  Set up the cell array and call GCA.
C
      DX = (XR-XL)/NX
      DY = (YT-YB)/NY
      DO 10 J=1,NY
        Y = YB+DY*REAL(J-1)
        DO 20 I=1,NX
          X = XL+DX*REAL(I-1)
          Z = CMPLX(X,Y)
          CALL CONVG(Z,NITER,.001,10000.,ITER)
          COLIA(I,J) = ITER
   20   CONTINUE
   10 CONTINUE
      CALL GCA(XL,YB,XR,YT,NX,NY,1,1,NX,NY,COLIA)
C
C  Label the plot using Plotchar.
C
      CALL GSCLIP(0)
      CALL PCSETI('FN',25)
      CALL PCSETI('CC',NITER+1)
      CALL PLCHHQ(XL+.5*(XR-XL),YB+(YT-YB)*1.07,'Cell array',.033,0.,0.)
      CALL FRAME
C
C  Deactivate and close the workstation, close GKS.
C
      CALL GDAWK (IWKID)
      CALL GCLWK (IWKID)
      CALL GCLKS
C	
      STOP
      END
      SUBROUTINE CONVG(Z,NUM,TOLSM,TOLLG,ITER)
C
C  Iterate Z(N+1) = Z(N)**2+Z0 for N=1,...,NUM .  If the complex absolute
C  values get smaller than TOLSM, then set ITER equal to the number of
C  iterations and return.  If the complex absolute value gets larger than
C  TOLLG, set ITER to NUM and return.
C
      COMPLEX Z,ZS,ZN,ZO
      ZS = Z
      ZO = Z
      DO 10 I=1,NUM
        ZN = ZO*ZO+ZS
        IF (CABS(ZN-ZO) .LT. TOLSM) THEN
          ITER = I
          RETURN
        ELSE IF (CABS(ZN-ZO) .GT. TOLLG) THEN
          ITER = I
          RETURN
        ENDIF
        ZO = ZN
   10 CONTINUE
      ITER=NUM
      RETURN
      END
