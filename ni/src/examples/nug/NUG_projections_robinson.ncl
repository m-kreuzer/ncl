;-----------------------------------------------------------------
;  NCL User Guide Example:  NCL_projections_robinson.ncl
; 
;  KMF 30.10.14
;-----------------------------------------------------------------
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;-- read the data and define

  diri  = "./"
  fili  = "MITgcm_rectilinear_grid_3D.nc"
  
  file1 =  addfile(diri+fili,"r")
  var   =  file1->SSS(0,0,:,:)

;-- define the workstation (plot type and name)
  wks = gsn_open_wks("png","NCL_robinson")

;-- set resources
  res                       =  True
  res@gsnSpreadColors       =  True
  res@gsnMaximize           =  True
  res@lbLabelStride         =  2
  res@lbBoxMinorExtentF     =  0.15            ;-- decrease the height of the labelbar
  res@cnFillOn              =  True            ;-- turn on contour fill
  res@cnLinesOn             =  False           ;-- turn off contour lines
  res@cnLineLabelsOn        =  False           ;-- turn off line labels
  res@cnLevelSelectionMode  = "ManualLevels"   ;-- set contour levels manually
  res@cnMinLevelValF        =    0.            ;-- minimum contour level
  res@cnMaxLevelValF        =   40.            ;-- maximum contour level
  res@cnLevelSpacingF       =    2             ;-- contour level spacing
  res@mpProjection          = "Robinson"       ;-- change projection
  res@mpGridAndLimbOn       =  True             ;-- plot grid lines

  res@tiMainString          = "NCL UG Example: Robinson projection"   ;-- title string
  res@tiMainFontHeightF     =  0.02

;-- draw the contour map
  plot = gsn_csm_contour_map(wks, var, res)

end