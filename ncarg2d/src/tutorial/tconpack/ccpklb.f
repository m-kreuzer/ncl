	PROGRAM CCPKLB

        PARAMETER (K=40,N=40,LRWK=2000,LIWK=2000)
	REAL Z(K,N), RWRK(LRWK)
	INTEGER M, IWRK(LIWK)
	CHARACTER*16 STRING

	CALL GETDAT (Z, K, M, N) 

C Open GKS
	CALL OPNGKS

C Initialize Conpack
	CALL CPRECT(Z,K,M,N,RWRK,LRWK,IWRK,LIWK)

	CALL CPPKCL(Z, RWRK, IWRK)
	CALL CPPKLB(Z, RWRK, IWRK)
	CALL CPGETI('NCL - NUMBER OF CONTOUR LEVELS',NOCL)
	DO 10, I=1,NOCL
	   CALL CPSETI('PAI - PARAMETER ARRAY INDEX',I)
	   CALL CPGETR('CLV - CONTOUR LEVEL VALUE',CLVL)
	   WRITE (STRING,5) CLVL
     	   CALL CPSETC('LLT - LINE LABEL TEXT',STRING)
 10	CONTINUE

C Draw perimeter
	CALL CPBACK(Z, RWRK, IWRK)
C Draw Contours
	CALL CPCLDR(Z,RWRK,IWRK)

C Close frame and close GKS
	CALL FRAME
	CALL CLSGKS

 5	FORMAT ('Contour at ',F5.3)
	STOP
	END

	SUBROUTINE GETDAT (Z, K, M, N)
	INTEGER I,J,K,M,N
	REAL Z(K,N)

	M=K
	DO 10, I=1,M
	  DO 20, J=1,N
	    Z(I,J)= 10.E-8*(-16.*REAL(I**2*J) +
     +		    34*REAL(I*J**2) - REAL(6*I) + 93.)
  20	  CONTINUE
  10	CONTINUE

	RETURN
	END

