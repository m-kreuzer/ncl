.\"
.\"     $Id: nnsetr.m,v 1.4 2000-07-13 03:18:09 haley Exp $
.\"
.TH NNSETR 3NCARG "March 1997-1998" UNIX "NCAR GRAPHICS"
.na
.nh
.SH NAME
NNSETR - Sets the value of an internal parameter of type REAL.
.SH SYNOPSIS
CALL NNSETR (PNAM, RVAL);
.SH DESCRIPTION 
.IP PNAM 12
A character string that specifies the name of the
parameter to be set. 
.IP RVAL 12
A REAL value that
is the value to be assigned to the
internal parameter specified by pnam.
.SH USAGE
This routine allows you to set the current value of
Natgrid parameters.  For a complete list of parameters available
in this utility, see the natgrid_params man page.
.SH ACCESS
To use NNSETR, load the NCAR Graphics library ngmath.
.SH SEE ALSO
natgrid,
natgrid_params, 
natgrids, 
nngetr.
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

