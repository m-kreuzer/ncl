.\"
.\"     $Id: nngetsloped.m,v 1.4 2000-07-13 03:18:08 haley Exp $
.\"
.TH NNGETSLOPED 3NCARG "March 1997-1998" UNIX "NCAR GRAPHICS"
.SH NAME
NNGETSLOPED - retrieve the double precision slope at a specified coordinate.
.SH SYNOPSIS
CALL NNGETSLOPED (I,J,SLOPE,IER)
.SH DESCRIPTION
.IP I 12
(Integer, Input) - A subscript indexing the first dimensioned variable 
in the output grid of the most recent call to NATGRIDD. 
.IP J 12
(Integer, Input) - A subscript indexing the second dimensioned variable 
in the output grid of the most recent call to NATGRIDD. 
.IP SLOPE 12
(Double precision, Output) - The slope at the grid point Z(I,J), 
where Z is the output grid in the most recent call to NATGRIDD. 
.IP IER 12
(Integer, Output) - An error return value. If IER is returned as 0, then 
no errors were detected. If IER is non-zero, then refer to the man
page for natgrid_errors for details.
.SH ACCESS
To use NNGETSLOPED, load the NCAR Graphics library ngmath.
.SH SEE ALSO
natgrid,
natgridd,
natgrid_params.
.sp
Complete documentation for Natgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/natgrid/nnhome.html
.SH COPYRIGHT
Copyright (C) 2000
.br
University Corporation for Atmospheric Research
.br

This documentation is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1 of the
License, or (at your option) any later version.

This software is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this software; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA.

