/*
 *      $Id: ContourPlotP.h,v 1.1 1995-04-01 00:03:58 dbrown Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1992			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		ContourPlotP.h
 *
 *	Author:		David Brown
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Fri Oct 2 15:01:59 MDT 1992
 *
 *	Description:	ContourPlot plot object private header file
 */

#ifndef _NCONTOURPLOTP_h
#define _NCONTOURPLOTP_h

#include <ncarg/hlu/DataCommP.h>
#include <ncarg/hlu/LogLinTransObjP.h>
#include <ncarg/hlu/PlotManagerI.h>
#include <ncarg/hlu/ContourPlot.h>
#include <ncarg/hlu/WorkspaceI.h>
#include <ncarg/hlu/ScalarFieldFloatP.h>
#include <ncarg/hlu/FormatI.h>

#define Nhl_cnDEF_ARRAY_SIZE	16
#define Nhl_cnMAX_LEVELS	256
#define Nhl_cnDEF_COLOR		NhlFOREGROUND
#define Nhl_cnDEF_PATTERN	1
#define Nhl_cnDEF_DASH_PATTERN  0
#define Nhl_cnDEF_LINE_LABEL_STRING	"LL_"
#define Nhl_cnINT_WKSPACE	1000
#define Nhl_cnFLOAT_WKSPACE	5000
#define Nhl_cnSTD_VIEW_WIDTH	0.5
#define Nhl_cnSTD_VIEW_HEIGHT	0.5
#define NhlcnMAPVAL		99
#define NhlcnDEF_INFO_LABEL	"CONTOUR FROM $CMN$ TO $CMX$ BY $CIU$"
#define NhlcnDEF_CONSTF_LABEL	"CONSTANT FIELD - VALUE IS $ZDV$"
#define NhlcnDEF_HIGH_LABEL	"H:B:$ZDV$:E:"
#define NhlcnDEF_LOW_LABEL	"L:B:$ZDV$:E:"
#ifndef FLT_MAX
#define FLT_MAX			10.0e37
#endif
typedef enum { _cnCONSTF, _cnINFO } _cnAnnoType;

typedef struct _NhlcnLabelAttrs {
	NhlBoolean		on;
	NhlPointer		text; /* cast to NhlString or NhlString* */
	NhlFormatRec		format;
	NhlBoolean		height_set;
	float			height;
	NhlTextDirection	direction;
	NhlFont			font;
	NhlBoolean		mono_color;
	NhlColorIndex		color;
	NhlColorIndex		*colors; /* cast to use for scalar gks ci */
	float			aspect;
	float			thickness;
	NhlFontQuality		quality;
	float			cspacing;
	float			angle;
	char			fcode[2];
	NhlColorIndex		back_color;
	NhlBoolean		perim_on;
	float			perim_space;
	float			perim_lthick;
	NhlColorIndex		perim_lcolor;
	NhlColorIndex		gks_bcolor;
	NhlColorIndex		gks_plcolor;
	float			real_height;
	float			pheight;
	float			pwidth;
	float			x_pos;
	float			y_pos;
	NhlJustification	just;
} NhlcnLabelAttrs;

typedef struct _NhlcnRegionAttrs {
	NhlBoolean	perim_on;
	float		perim_thick;
	NhlDashIndex	perim_dpat;
	NhlColorIndex	perim_color;
	NhlColorIndex	gks_pcolor;
	NhlColorIndex	fill_color;
	NhlColorIndex	gks_fcolor;
	NhlFillIndex	fill_pat;
	float		fill_scale;
} NhlcnRegionAttrs;

typedef struct _NhlContourPlotDataDepLayerPart{
	/* Public resources	*/

	NhlBoolean		labels;

	/* Private fields	*/
} NhlContourPlotDataDepLayerPart;
/* private resource */

#define NhlNcnDataChanged	".cnDataChanged"
#define NhlCcnDataChanged	".CnDataChanged"


typedef struct _NhlContourPlotLayerPart {

	/* Public resources */

	NhlGenArray	scalar_field_data;

	NhlcnLevelSelectionMode		level_selection_mode;
	int		level_count;
	int		max_level_count;
	NhlBoolean	level_spacing_set;
	float		level_spacing;
	NhlBoolean	min_level_set;
	float		min_level_val;
	NhlBoolean	max_level_set;
	float		max_level_val;
	NhlBoolean	llabel_interval_set;
	int		llabel_interval;
	NhlDrawOrder	label_order;
	NhlBoolean	label_masking;
	NhlDrawOrder	line_order;
	NhlDrawOrder	fill_order;
	NhlBoolean	lines_on;
	NhlBoolean	fill_on;
	NhlColorIndex	fill_background_color;

        NhlcnLabelScalingMode	label_scaling_mode;
        float		label_scale_value;
        float		label_scale_factor;
        NhlFormatRec	max_data_format;
        NhlBoolean	smoothing_on;
        float		smoothing_tension;
        float		smoothing_distance;
        NhlBoolean	check_point_distance;
        float		max_point_distance;

	NhlGenArray	levels;
	NhlBoolean	mono_level_flag;
	NhlcnLevelUseMode	level_flag;
	NhlGenArray	level_flags;
	NhlBoolean	mono_fill_color;
	NhlColorIndex	fill_color;
	NhlGenArray	fill_colors;
	NhlBoolean	mono_fill_pattern;
	NhlFillIndex	fill_pattern;
	NhlGenArray	fill_patterns;
	NhlBoolean	mono_fill_scale;
	float		fill_scale;
	NhlGenArray	fill_scales;

	NhlBoolean	mono_line_color;
	NhlGenArray	line_colors;
	NhlColorIndex	line_color;
	NhlBoolean	mono_line_dash_pattern;
	NhlDashIndex	line_dash_pattern;
	NhlGenArray	line_dash_patterns;
	NhlBoolean	mono_line_thickness;
	float		line_thickness;
	NhlGenArray	line_thicknesses;
	NhlBoolean	mono_llabel_color;
	float		llabel_color;
	NhlGenArray	llabel_colors;
	NhlGenArray	llabel_strings;

	NhlBoolean	line_dash_seglen_set;
	float		line_dash_seglen;
	NhlcnLineLabelPlacementMode	llabel_placement;

	NhlBoolean	low_use_high_attrs;
	NhlBoolean	high_use_line_attrs;
	NhlBoolean	constf_use_info_attrs;
	NhlcnHighLowLabelOverlapMode	high_low_overlap;

	NhlcnLabelAttrs 	line_lbls;
	NhlcnLabelAttrs 	high_lbls;
	NhlcnLabelAttrs 	low_lbls;
	NhlString		info_string; /* before substitution */
	NhlcnLabelAttrs 	info_lbl;
	NhlAnnotationRec	info_lbl_rec;
	NhlString		constf_string; /* before substitution */
	NhlcnLabelAttrs 	constf_lbl;
	NhlAnnotationRec	constf_lbl_rec;

	NhlcnRegionAttrs	missing_val;
	NhlcnRegionAttrs	grid_bound;
	NhlcnRegionAttrs	out_of_range;

	NhlAnnotationDisplayMode	display_labelbar;
	NhlAnnotationDisplayMode	display_legend;
	NhlAnnotationDisplayMode	display_titles;
	NhlAnnotationDisplayMode	display_tickmarks;
	NhlBoolean	x_min_set;
	float 		x_min;
	NhlBoolean	x_max_set;
	float		x_max;
	NhlBoolean	x_log;
	NhlBoolean	x_reverse;
	NhlBoolean	y_min_set;
	float 		y_min;
	NhlBoolean	y_max_set;
	float		y_max;
	NhlBoolean	y_log;
	NhlBoolean	y_reverse;
	NhlBoolean	auto_legend_labels;
	NhlGenArray	legend_labels;
	NhlBoolean	draw_lgnd_line_lbls_set;
	NhlBoolean	draw_lgnd_line_lbls;
	NhlBoolean	auto_labelbar_labels;
	NhlGenArray	labelbar_labels;

	/* private resource */

	NhlBoolean	dump_area_map;
	int		amap_crange;
	NhlBoolean	update_req;
	NhlBoolean	data_changed;

	/* Private Fields */

        NhlTransDat	*predraw_dat;
        NhlTransDat	*draw_dat;
        NhlTransDat	*postdraw_dat;
	NhlBoolean	new_draw_req;

	NhlLayer	overlay_object;
	NhlBoolean	data_init;
	NhlBoolean	cprect_call_req;
	int		ref_level;
	float		*real_levels;
	NhlColorIndex	*gks_line_colors;
	NhlColorIndex	*gks_llabel_colors;
	NhlGenArray	dash_table;
	float		zmin;
	float		zmax;
	NhlBoolean	const_field;
	NhlBoolean	display_constf;
	int		fill_count;
	int		line_count;
	NhlGenArray	ll_strings;
	NhlGenArray	ll_text_heights;
	int		*label_amap;
	int		iws_id;
	int		fws_id;
	int		label_aws_id;
	int		fill_aws_id;
	int		ezmap_aws_id;
	NhlBoolean	use_irr_trans;
	float		xc1,xcm,yc1,ycn; /* data bounds for Conpack */
	float		xlb,xub,ylb,yub; /* window boundaries */
	int		info_anno_id;
	int		constf_anno_id;

	NhlScalarFieldFloatLayerPart	*sfp;

	NhlString	*dtable;
	int		dtable_len;
	NhlLayer	trans_obj;
	NhlBoolean	do_lines;
	NhlBoolean	do_fill;
	NhlBoolean	do_labels;
	NhlWorkspace	*fws,*iws,*aws;
	NhlBoolean	area_ws_inited;
	float		*data;

} NhlContourPlotLayerPart;

typedef struct _NhlContourPlotDataDepLayerRec{
	NhlBaseLayerPart		base;
	NhlDataSpecLayerPart		dataspec;
	NhlContourPlotDataDepLayerPart	cndata;
} NhlContourPlotDataDepLayerRec;

typedef struct _NhlContourPlotLayerRec {
	NhlBaseLayerPart	base;
	NhlViewLayerPart	view;
	NhlTransformLayerPart	trans;
	NhlDataCommLayerPart	datacomm;
	NhlContourPlotLayerPart	contourplot;
} NhlContourPlotLayerRec;

typedef struct _NhlContourPlotDataDepLayerClassPart{
	NhlPointer		foo;
} NhlContourPlotDataDepLayerClassPart;

typedef struct NhlContourPlotLayerClassPart{
	NhlPointer		foo;
} NhlContourPlotLayerClassPart;

typedef struct _NhlContourPlotDataDepLayerClassRec{
	NhlBaseLayerClassPart		base_class;
	NhlDataSpecLayerClassPart	dataspec_class;
	NhlContourPlotDataDepLayerClassPart	cndata_class;
} NhlContourPlotDataDepLayerClassRec;

typedef struct _NhlContourPlotLayerClassRec{
	NhlBaseLayerClassPart		base_class;
	NhlViewLayerClassPart		view_class;
	NhlTransformLayerClassPart	trans_class;
	NhlDataCommLayerClassPart	datacomm_class;
	NhlContourPlotLayerClassPart	contourplot_class;
} NhlContourPlotLayerClassRec;

typedef struct _NhlContourPlotDataDepLayerClassRec
					*NhlContourPlotDataDepLayerClass;
typedef struct _NhlContourPlotDataDepLayerRec	*NhlContourPlotDataDepLayer;

typedef struct _NhlContourPlotLayerClassRec	*NhlContourPlotLayerClass;
typedef struct _NhlContourPlotLayerRec		*NhlContourPlotLayer;

extern NhlLayerClass			NhlcontourPlotDataDepLayerClass;
extern NhlContourPlotDataDepLayerClassRec NhlcontourPlotDataDepLayerClassRec;
extern NhlContourPlotLayerClassRec	NhlcontourPlotLayerClassRec;

#endif  /* _NCONTOURPLOTP_h */
