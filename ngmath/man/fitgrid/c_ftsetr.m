.\"
.\"	$Id: c_ftsetr.m,v 1.2 2000-07-13 03:18:00 haley Exp $
.\"
.TH c_ftsetr 3NCARG "March 1998" UNIX "NCAR GRAPHICS"
.SH NAME
c_ftsetr - set float valued parameters
.SH FUNCTION PROTOTYPE
void c_ftsetr(char *, float);
.SH SYNOPSIS
void c_ftsetr (pnam, fval);
.SH DESCRIPTION
.IP pnam 12
The name of the control parameter to be assigned a float value. 
.IP fval 12
The value to be assigned to the control parameter whose name is 
pointed to by pnam. 
.SH USAGE
c_ftsetr is used to set values for any of the control parameters 
that take float values. The values set by c_ftsetr remain in effect 
until changed by subsequent calls to c_ftsetr. 
.SH ACCESS
To use c_ftsetr, load the NCAR Graphics library ngmath.
.SH SEE ALSO
fitgrid_params, c_ftgetr
.sp
Complete documentation for Fitgrid is available at URL
.br
http://ngwww.ucar.edu/ngdoc/ng/ngmath/fitgrid/fithome.html
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

