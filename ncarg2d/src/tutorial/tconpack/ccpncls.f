	PROGRAM CCPREC

        PARAMETER (M=40,N=40,LRWK=1000,LIWK=1000)
	REAL Z(M,N), RWRK(LRWK)
	INTEGER IWRK(LIWK)

	CALL GETDAT (Z, M, N) 

C Open GKS
	CALL OPNGKS

C Make Conpack draw exactly 10 equally spaced contour levels
	CALL CPSETI ('CLS - CONTOUR LEVEL SELECTION FLAG',-10)
C Initialize Conpack
	CALL CPRECT (Z, M, M, N, RWRK, LRWK, IWRK, LIWK)
C Draw perimeter
	CALL CPBACK (Z, RWRK, IWRK)
C Draw Contours
	CALL CPCLDR (Z, RWRK, IWRK)
C Close frame and close GKS
	CALL FRAME
	CALL CLSGKS

	STOP
	END

	SUBROUTINE GETDAT (Z, M, N)
	INTEGER I,J,M,N
	REAL Z(M,N)

	DO 10, I=1,M
	  DO 20, J=1,N
	    Z(I,J)= 10E-5*(-16.*REAL(I**2*J) +
     +		    34*REAL(I*J**2) - REAL(6*I) + 93.)
  20	  CONTINUE
  10	CONTINUE

	RETURN
	END

