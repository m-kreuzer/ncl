C
C	$Id: cmptit.f,v 1.3 1994-02-17 21:21:51 haley Exp $
C
	PROGRAM MAPTIT
C
C The program EXMPL5 produces a single frame with maximal-area
C views of all the EZMAP projections of the globe.
C
C Define area map array and size for area fill applications
C
	PARAMETER (LMAP=250000, MCS=10000, NIDS=2)
	INTEGER MAP(LMAP), IAREA(NIDS), IGRP(NIDS)
	REAL XCS(MCS), YCS(MCS)
C
C Declare masking and area shading routines external
C
	EXTERNAL MASK
	EXTERNAL SHADE1
	EXTERNAL SHADE2
	EXTERNAL CFILL
C
C Open GKS.
C
	CALL OPNGKS
C
C Turn off the clipping indicator.
C
	CALL GSCLIP (0)
C
C Set up color table and dash pattern
C 
	CALL COLOR
	CALL DASHDB(65535)
C
C Set the outline-dataset parameter.
C
	CALL MAPSTC ('OU - OUTLINE DATASET SELECTOR','CO')
	CALL MAPSTI ('LA - LABEL FLAG',0)
C
C Put meridians and parallels every 15 degrees.
C
	CALL MAPSTI ('GR - GRID SPACING',15)
C
C Don't draw labels
C
	CALL MAPSTI ('LA - LABEL FLAG',0)
C
C Do draw elliptical perimeter
C
	CALL MAPSTI ('EL - ELLIPTICAL-PERIMETER SELECTOR',1)
C
C Lambert conformal conic.
C
	CALL MAPPOS (.025,.24375,.63125,.85)
	CALL MAPROJ ('LC',30.,0.,45.)
	CALL MAPINT
C Yellow Grid
	CALL GSPLCI (13)
	CALL MAPGRD
	CALL MAPLBL
C Green Contenental Outline
	CALL GSPLCI (6)
	CALL MAPLOT
C
C Stereographic.
C
	CALL MAPPOS (.26875,.4875,.63125,.85)
	CALL MAPROJ ('ST',0.,0.,0.)
C Aqua
	CALL MAPINT
	CALL GSPLCI (8)
	CALL MAPGRD
	CALL MAPLBL
C Chartreuse
	CALL GSPLCI (2)
	CALL MAPLOT
C
C Orthographic.
C
	CALL MAPPOS (.5125,.73125,.63125,.85)
	CALL MAPROJ ('OR',0.,0.,0.)
C Orchid
	CALL MAPINT
	CALL GSPLCI (15)
	CALL MAPGRD
	CALL MAPLBL
C SlateBlue
	CALL GSPLCI (8)
	CALL MAPLOT
C
C Lambert equal-area.
C
	CALL MAPPOS (.75625,.975,.63125,.85)
	CALL MAPROJ ('LE',0.,0.,0.)
C Red
	CALL MAPINT
	CALL GSPLCI (3)
	CALL MAPGRD
	CALL MAPLBL
C Yellow
	CALL GSPLCI (6)
	CALL MAPLOT
C
C Gnomonic.
C
C Draw lat/lon lines only over the oceans
	CALL GSPLCI (1)
	CALL MAPPOS (.025,.24375,.3875,.60625)
	CALL MAPROJ ('GN',0.,0.,0.)
	CALL ARINAM (MAP, LMAP)
	CALL MAPINT
	CALL MAPBLA (MAP)
	CALL MAPGRM (MAP, XCS, YCS, MCS, IAREA, IGRP, NIDS, MASK)
	CALL MAPLBL
	CALL MAPLOT
C
C Azimuthal equidistant.
C
	CALL ARINAM (MAP, LMAP)
	CALL MAPPOS (.26875,.4875,.3875,.60625)
	CALL MAPROJ ('AE',0.,0.,0.)
	CALL MAPINT
	CALL MAPBLA (MAP)
	CALL MAPGRM (MAP, XCS, YCS, MCS, IAREA, IGRP, NIDS, MASK)
	CALL GSPLCI (2)
	CALL MAPLBL
	CALL MAPLOT 
C
C Satellite-view.
C
C Do this plot in white with Softfill over the water and no lat/lon
C lines
	CALL ARINAM (MAP, LMAP)
	CALL GSPLCI (1)
	CALL MAPPOS (.5125,.73125,.3875,.60625)
	CALL MAPROJ ('SV',0.,0.,0.)
	CALL MAPSTR ('SA - SATELLITE DISTANCE',2.)
	CALL MAPSTC ('OU - OUTLINE DATASET SELECTOR','PO')
	CALL MAPINT
	CALL MAPBLA (MAP)
	CALL ARSCAM (MAP, XCS, YCS, MCS, IAREA, IGRP, NIDS, SHADE1)
	CALL MAPLBL
	CALL MAPLOT
C
C Mercator.
C
	CALL ARINAM (MAP, LMAP)
	CALL GSPLCI (1)
	CALL MAPPOS (.75625,.975,.3875,.60625)
	CALL MAPROJ ('ME',0.,0.,0.)
	CALL MAPINT
	CALL MAPBLA (MAP)
	CALL ARSCAM (MAP, XCS, YCS, MCS, IAREA, IGRP, NIDS, SHADE2)
	CALL MAPLBL
	CALL MAPLOT
C
C Cylindrical equidistant.
C
	CALL ARINAM (MAP, LMAP)
	CALL GSPLCI (1)
	CALL MAPPOS (.025,.4875,.13125,.3625)
	CALL MAPROJ ('CE',0.,0.,0.)
	CALL MAPINT
	CALL MAPBLA (MAP)
	CALL ARSCAM (MAP, XCS, YCS, MCS, IAREA, IGRP, NIDS, CFILL)
	CALL MAPLBL
	CALL MAPLOT
C
C Mollweide type.
C
	CALL ARINAM (MAP, LMAP)
	CALL GSPLCI (1)
	CALL MAPPOS (.5125,.975,.13125,.3625)
	CALL MAPROJ ('MO',0.,0.,0.)
	CALL MAPINT
	CALL MAPBLA (MAP)
	CALL ARSCAM (MAP, XCS, YCS, MCS, IAREA, IGRP, NIDS, CFILL)
	CALL MAPLBL
	CALL MAPLOT
C
C and the labels under each sub-plot.
C
	CALL GSLWSC(2.)
	CALL SET (0.,1.,0.,1.,0.,1.,0.,1.,1)
	CALL PLCHHQ (.134375,.61875,'LAMBERT CONFORMAL CONIC',
     +                                          .0085,0.,0.)
	CALL PLCHHQ (.378125,.61875,'STEREOGRAPHIC',
     +						.0085,0.,0.)
	CALL PLCHHQ (.621875,.61875,'ORTHOGRAPHIC',
     +						.0085,0.,0.)
	CALL PLCHHQ (.865625,.61875,'LAMBERT EQUAL-AREA',
     +						.0085,0.,0.)
	CALL PLCHHQ (.134375,.375,'GNOMONIC',
     +						.0085,0.,0.)
	CALL PLCHHQ (.378125,.375,'AZIMUTHAL EQUIDISTANT',
     +						.0085,0.,0.)
	CALL PLCHHQ (.621875,.375,'SATELLITE-VIEW',
     +						.0085,0.,0.)
	CALL PLCHHQ (.865625,.375,'MERCATOR',
     +						.0085,0.,0.)
	CALL PLCHHQ (.25625,.11875,'CYLINDRICAL EQUIDISTANT',
     +                                          .0085,0.,0.)
	CALL PLCHHQ (.74375,.11875,'MOLLWEIDE TYPE',
     +						.0085,0.,0.)
C
C Draw a boundary around the edge of the plotter frame.
C
c      CALL BNDARY
C
C Advance the frame.
C
	CALL FRAME
C
C Close GKS.
C
	CALL CLSGKS
C
C Done.
C
	STOP
C
	END
	SUBROUTINE MASK(XC,YC,MCS,AREAID,GRPID,IDSIZE)

	INTEGER AREAID(IDSIZE),GRPID(IDSIZE),ID
	REAL XC(MCS),YC(MCS)

C Retrieve area id for geographical area
	DO 10, I=1,IDSIZE
	   IF (GRPID(I).EQ.1) ID=AREAID(I)
 10	CONTINUE
C If the line is over water, and has 2 or more points draw it.
	IF ((MAPACI(ID).EQ.1).AND.(MCS.GE.2)) THEN
	   CALL CURVED(XC,YC,MCS)
	ENDIF
	
C Otherwise, don't draw the line - mask it.

	RETURN
	END

	SUBROUTINE SHADE1 (XC, YC, NPTS, AREAID, GRPID, IDSIZE)
C
C Fill area map
C
    INTEGER IDSIZE, NPTS
	INTEGER AREAID(IDSIZE),GRPID(IDSIZE),IWRK(5000)
	REAL XC(NPTS), YC(NPTS), RWRK(5000)

	IAID = 0
	DO 10 I=1,IDSIZE
	   IF (GRPID(I) .EQ. 1) IAID = AREAID(I)
 10	CONTINUE
C
C Fill Areas over land using softfill
C
C Areas over water have area color indices of 1 so we use that to 
C distinguish them.
C
	IF ((IAID .GT. 0) .AND. (MAPACI(IAID) .EQ. 1)) THEN
	   CALL SFSETR('SP',.005)
	   CALL SFSETR('ANGLE', 45.)
	   CALL SFWRLD(XC, YC, NPTS-1, RWRK, 5000, IWRK, 5000)
	ENDIF

	RETURN
	END

	SUBROUTINE SHADE2 (XC, YC, NPTS, AREAID, GRPID, IDSIZE)
C
C Fill area map
C
    INTEGER IDSIZE, NPTS
	INTEGER AREAID(IDSIZE),GRPID(IDSIZE),IWRK(10000)
	REAL XC(NPTS), YC(NPTS), RWRK(10000)

	CALL GSFAIS (1)
	IAID = 0
	DO 10 I=1,IDSIZE
	   IF (GRPID(I) .EQ. 1) IAID = AREAID(I)
 10	CONTINUE
C
C Fill Areas over land using softfill
C
C Areas over water have area color indices of 1 so we use that to 
C distinguish them.
C
	IF (IAID .GT. 0) THEN
	   IF (MAPACI(IAID) .EQ. 1) THEN
	      CALL SFSETR('SP',.005)
	      CALL SFSETR('ANGLE', 45.)
	      CALL SFWRLD(XC, YC, NPTS-1, RWRK, 10000, IWRK, 10000)
	   ELSE 
	      CALL GSFACI (MAPACI(IAID))
	      CALL GFA (NPTS, XC, YC)
	   ENDIF
	ENDIF

	RETURN
	END

	SUBROUTINE CFILL (XC, YC, NPTS, AREAID, GRPID, IDSIZE)
C
C Fill area map
C
    INTEGER IDSIZE, NPTS
	INTEGER AREAID(IDSIZE), GRPID(IDSIZE), ICOL
	REAL XC(NPTS), YC(NPTS)

	ICOL = 0
	DO 10, I=1,IDSIZE
	   IF (GRPID(I).EQ.1) IAREA=AREAID(I)
 10	CONTINUE
	   
	IF (IAREA .GE. 1) THEN
	   ICOL = MAPACI(IAREA)
	   IF (ICOL .eq. 1) THEN
C Color the ocean blue.
	      CALL GSFACI(2)
	      CALL GFA(NPTS-1, XC, YC)
	   ELSE 
C If the area is over land, fill it using the country color id.
	      CALL GSFACI(ICOL+2)
	      CALL GFA(NPTS-1, XC, YC)
	   ENDIF
	ENDIF
	
	RETURN
	END

      SUBROUTINE COLOR
C
C     BACKGROUND COLOR
C     BLACK
      CALL GSCR(1,0,0.,0.,0.)
C
C     FORGROUND COLORS
C White
      CALL GSCR(1,  1, 1.0, 1.0, 1.0)
C Aqua
      CALL GSCR(1,  2, 0.0, 0.9, 1.0)
C Red
      CALL GSCR(1,  3, 0.9, 0.25, 0.0)
C OrangeRed
      CALL GSCR(1,  4, 1.0, 0.0, 0.2)
C Orange
      CALL GSCR(1,  5, 1.0, 0.65, 0.0)
C Yellow
      CALL GSCR(1,  6, 1.0, 1.0, 0.0)
C GreenYellow
      CALL GSCR(1,  7, 0.7, 1.0, 0.2)
C Chartreuse
      CALL GSCR(1,  8, 0.5, 1.0, 0.0)
C Celeste
      CALL GSCR(1,  9, 0.2, 1.0, 0.5)
C Green
      CALL GSCR(1, 10, 0.2, 0.8, 0.2)
C DeepSkyBlue
      CALL GSCR(1, 11, 0.0, 0.75, 1.0)
C RoyalBlue
      CALL GSCR(1, 12, 0.25, 0.45, 0.95)
C SlateBlue
      CALL GSCR(1, 13, 0.4, 0.35, 0.8)
C DarkViolet
      CALL GSCR(1, 14, 0.6, 0.0, 0.8)
C Orchid
      CALL GSCR(1, 15, 0.85, 0.45, 0.8)
C Lavender
      CALL GSCR(1, 16, 0.8, 0.8, 1.0)
C Gray
      CALL GSCR(1, 17, 0.7, 0.7, 0.7)
C Done.
C
        RETURN
C
      END

