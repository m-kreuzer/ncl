CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C   FFTPACK 5.0
C   Copyright (C) 1995-2004, Scientific Computing Division,
C   University Corporation for Atmospheric Research
C   Licensed under the GNU General Public License (GPL)
C
C   Authors:  Paul N. Swarztrauber and Richard A. Valent
C
C   $Id: cmf5kb.f,v 1.2 2006-11-21 01:10:16 haley Exp $
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

      SUBROUTINE DCMF5KB(LOT,IDO,L1,NA,CC,IM1,IN1,CH,IM2,IN2,WA)
      DOUBLE PRECISION TR11
      DOUBLE PRECISION TI11
      DOUBLE PRECISION TR12
      DOUBLE PRECISION TI12
      DOUBLE PRECISION TI5
      DOUBLE PRECISION TI2
      DOUBLE PRECISION TI4
      DOUBLE PRECISION TI3
      DOUBLE PRECISION TR5
      DOUBLE PRECISION TR2
      DOUBLE PRECISION TR4
      DOUBLE PRECISION TR3
      DOUBLE PRECISION CHOLD1
      DOUBLE PRECISION CHOLD2
      DOUBLE PRECISION CR2
      DOUBLE PRECISION CI2
      DOUBLE PRECISION CR3
      DOUBLE PRECISION CI3
      DOUBLE PRECISION CR5
      DOUBLE PRECISION CI5
      DOUBLE PRECISION CR4
      DOUBLE PRECISION CI4
      DOUBLE PRECISION DR3
      DOUBLE PRECISION DR4
      DOUBLE PRECISION DI3
      DOUBLE PRECISION DI4
      DOUBLE PRECISION DR5
      DOUBLE PRECISION DR2
      DOUBLE PRECISION DI5
      DOUBLE PRECISION DI2
      DOUBLE PRECISION CC(2,IN1,L1,IDO,5),CH(2,IN2,L1,5,IDO),WA(IDO,4,2)
      DATA TR11,TI11,TR12,TI12/.3090169943749474D0,.9510565162951536D0,
     +     -.8090169943749474D0,.5877852522924731D0/
C
C FFTPACK 5.0 auxiliary routine
C
      M1D = (LOT-1)*IM1 + 1
      M2S = 1 - IM2
      IF (IDO.GT.1 .OR. NA.EQ.1) GO TO 102
      DO 101 K = 1,L1
          DO 101 M1 = 1,M1D,IM1
              TI5 = CC(2,M1,K,1,2) - CC(2,M1,K,1,5)
              TI2 = CC(2,M1,K,1,2) + CC(2,M1,K,1,5)
              TI4 = CC(2,M1,K,1,3) - CC(2,M1,K,1,4)
              TI3 = CC(2,M1,K,1,3) + CC(2,M1,K,1,4)
              TR5 = CC(1,M1,K,1,2) - CC(1,M1,K,1,5)
              TR2 = CC(1,M1,K,1,2) + CC(1,M1,K,1,5)
              TR4 = CC(1,M1,K,1,3) - CC(1,M1,K,1,4)
              TR3 = CC(1,M1,K,1,3) + CC(1,M1,K,1,4)
              CHOLD1 = CC(1,M1,K,1,1) + TR2 + TR3
              CHOLD2 = CC(2,M1,K,1,1) + TI2 + TI3
              CR2 = CC(1,M1,K,1,1) + TR11*TR2 + TR12*TR3
              CI2 = CC(2,M1,K,1,1) + TR11*TI2 + TR12*TI3
              CR3 = CC(1,M1,K,1,1) + TR12*TR2 + TR11*TR3
              CI3 = CC(2,M1,K,1,1) + TR12*TI2 + TR11*TI3
              CC(1,M1,K,1,1) = CHOLD1
              CC(2,M1,K,1,1) = CHOLD2
              CR5 = TI11*TR5 + TI12*TR4
              CI5 = TI11*TI5 + TI12*TI4
              CR4 = TI12*TR5 - TI11*TR4
              CI4 = TI12*TI5 - TI11*TI4
              CC(1,M1,K,1,2) = CR2 - CI5
              CC(1,M1,K,1,5) = CR2 + CI5
              CC(2,M1,K,1,2) = CI2 + CR5
              CC(2,M1,K,1,3) = CI3 + CR4
              CC(1,M1,K,1,3) = CR3 - CI4
              CC(1,M1,K,1,4) = CR3 + CI4
              CC(2,M1,K,1,4) = CI3 - CR4
              CC(2,M1,K,1,5) = CI2 - CR5
  101 CONTINUE
      RETURN
  102 DO 103 K = 1,L1
          M2 = M2S
          DO 103 M1 = 1,M1D,IM1
              M2 = M2 + IM2
              TI5 = CC(2,M1,K,1,2) - CC(2,M1,K,1,5)
              TI2 = CC(2,M1,K,1,2) + CC(2,M1,K,1,5)
              TI4 = CC(2,M1,K,1,3) - CC(2,M1,K,1,4)
              TI3 = CC(2,M1,K,1,3) + CC(2,M1,K,1,4)
              TR5 = CC(1,M1,K,1,2) - CC(1,M1,K,1,5)
              TR2 = CC(1,M1,K,1,2) + CC(1,M1,K,1,5)
              TR4 = CC(1,M1,K,1,3) - CC(1,M1,K,1,4)
              TR3 = CC(1,M1,K,1,3) + CC(1,M1,K,1,4)
              CH(1,M2,K,1,1) = CC(1,M1,K,1,1) + TR2 + TR3
              CH(2,M2,K,1,1) = CC(2,M1,K,1,1) + TI2 + TI3
              CR2 = CC(1,M1,K,1,1) + TR11*TR2 + TR12*TR3
              CI2 = CC(2,M1,K,1,1) + TR11*TI2 + TR12*TI3
              CR3 = CC(1,M1,K,1,1) + TR12*TR2 + TR11*TR3
              CI3 = CC(2,M1,K,1,1) + TR12*TI2 + TR11*TI3
              CR5 = TI11*TR5 + TI12*TR4
              CI5 = TI11*TI5 + TI12*TI4
              CR4 = TI12*TR5 - TI11*TR4
              CI4 = TI12*TI5 - TI11*TI4
              CH(1,M2,K,2,1) = CR2 - CI5
              CH(1,M2,K,5,1) = CR2 + CI5
              CH(2,M2,K,2,1) = CI2 + CR5
              CH(2,M2,K,3,1) = CI3 + CR4
              CH(1,M2,K,3,1) = CR3 - CI4
              CH(1,M2,K,4,1) = CR3 + CI4
              CH(2,M2,K,4,1) = CI3 - CR4
              CH(2,M2,K,5,1) = CI2 - CR5
  103 CONTINUE
      IF (IDO.EQ.1) RETURN
      DO 105 I = 2,IDO
          DO 104 K = 1,L1
              M2 = M2S
              DO 104 M1 = 1,M1D,IM1
                  M2 = M2 + IM2
                  TI5 = CC(2,M1,K,I,2) - CC(2,M1,K,I,5)
                  TI2 = CC(2,M1,K,I,2) + CC(2,M1,K,I,5)
                  TI4 = CC(2,M1,K,I,3) - CC(2,M1,K,I,4)
                  TI3 = CC(2,M1,K,I,3) + CC(2,M1,K,I,4)
                  TR5 = CC(1,M1,K,I,2) - CC(1,M1,K,I,5)
                  TR2 = CC(1,M1,K,I,2) + CC(1,M1,K,I,5)
                  TR4 = CC(1,M1,K,I,3) - CC(1,M1,K,I,4)
                  TR3 = CC(1,M1,K,I,3) + CC(1,M1,K,I,4)
                  CH(1,M2,K,1,I) = CC(1,M1,K,I,1) + TR2 + TR3
                  CH(2,M2,K,1,I) = CC(2,M1,K,I,1) + TI2 + TI3
                  CR2 = CC(1,M1,K,I,1) + TR11*TR2 + TR12*TR3
                  CI2 = CC(2,M1,K,I,1) + TR11*TI2 + TR12*TI3
                  CR3 = CC(1,M1,K,I,1) + TR12*TR2 + TR11*TR3
                  CI3 = CC(2,M1,K,I,1) + TR12*TI2 + TR11*TI3
                  CR5 = TI11*TR5 + TI12*TR4
                  CI5 = TI11*TI5 + TI12*TI4
                  CR4 = TI12*TR5 - TI11*TR4
                  CI4 = TI12*TI5 - TI11*TI4
                  DR3 = CR3 - CI4
                  DR4 = CR3 + CI4
                  DI3 = CI3 + CR4
                  DI4 = CI3 - CR4
                  DR5 = CR2 + CI5
                  DR2 = CR2 - CI5
                  DI5 = CI2 - CR5
                  DI2 = CI2 + CR5
                  CH(1,M2,K,2,I) = WA(I,1,1)*DR2 - WA(I,1,2)*DI2
                  CH(2,M2,K,2,I) = WA(I,1,1)*DI2 + WA(I,1,2)*DR2
                  CH(1,M2,K,3,I) = WA(I,2,1)*DR3 - WA(I,2,2)*DI3
                  CH(2,M2,K,3,I) = WA(I,2,1)*DI3 + WA(I,2,2)*DR3
                  CH(1,M2,K,4,I) = WA(I,3,1)*DR4 - WA(I,3,2)*DI4
                  CH(2,M2,K,4,I) = WA(I,3,1)*DI4 + WA(I,3,2)*DR4
                  CH(1,M2,K,5,I) = WA(I,4,1)*DR5 - WA(I,4,2)*DI5
                  CH(2,M2,K,5,I) = WA(I,4,1)*DI5 + WA(I,4,2)*DR5
  104     CONTINUE
  105 CONTINUE
      RETURN
      END
