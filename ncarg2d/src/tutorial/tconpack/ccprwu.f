	PROGRAM CCPRWU

        PARAMETER (K=40,N=40,LRWK=1000,LIWK=1000)
	REAL Z(K,N), RWRK(LRWK)
	INTEGER M, IWRK(LIWK), IIWU, IRWU

	CALL GETDAT (Z, K, M, N) 

C Open GKS
	CALL OPNGKS

C Initialize Conpack
	CALL CPRECT(Z,K,M,N,RWRK,LRWK,IWRK,LIWK)
C Draw perimeter
	CALL CPBACK(Z, RWRK, IWRK)
C Draw Contours
	CALL CPCLDR(Z,RWRK,IWRK)
C Find out how much real and integer workspace is used
	CALL CPGETI('IWU - INTEGER WORKSPACE USAGE',IIWU)
	CALL CPGETI('RWU - REAL WORKSPACE USAGE',IRWU)
	WRITE (6,*) 'Integer Workspace Used: ',IIWU,
     +		' Real Workspace Used: ',IRWU

C Close frame and close GKS
	CALL FRAME
	CALL CLSGKS

	STOP
	END

	SUBROUTINE GETDAT (Z, K, M, N)
	INTEGER I,J,K,M,N
	REAL Z(K,N)

	M=K
	DO 10, I=1,M
	  DO 20, J=1,N
	    Z(I,J)= 10.E-5*(-16.*REAL(I**2*J) +
     +		    34*REAL(I*J**2) - REAL(6*I) + 93.)
  20	  CONTINUE
  10	CONTINUE

	RETURN
	END

