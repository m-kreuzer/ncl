/*
 *	$Id: rasview.c,v 1.7 1992-03-26 22:13:07 clyne Exp $
 */
/*
 *	rasview.c
 *
 *	Author		John Clyne
 *
 *	Date		Fri Mar  1 14:58:27 MST 1991
 *
 *	Display a raster file to an X window. 
 */
#include <stdio.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>     /* Get standard string definations. */
#include <X11/Shell.h>
#include <ncarv.h>
#include <ncarg_ras.h>
#include "rasdraw.h"



/*
 *      a global structure that contains values of command line options
 */
static	struct	{
	char	*palette;	/* color palette		*/
	boolean	quiet;		/* quiet or verbose mode	*/
	boolean	version;	/* print version		*/
	} opt;

/*
 *	the options that we want to have parsed
 */
static	OptDescRec	set_options[] = {
	{"palette", 1, NULL, "Specify a color palette file"},
	{"quiet", 0, NULL, "Operate in quite mode"},
	{"Version", 0, NULL, "Print version number end exit"},
	{NULL}
};
	
/*
 *	return structure for loading options
 */
static	Option	get_options[] = {
	{"palette", NCARGCvtToString, (Voidptr)&opt.palette, sizeof(opt.palette)
	},
	{"quiet", NCARGCvtToBoolean, (Voidptr) &opt.quiet, sizeof(opt.quiet)
	},
	{"Version", NCARGCvtToBoolean, (Voidptr)&opt.version,sizeof(opt.version)
	},
	{
	NULL
	}
};

main(argc, argv)
	int	argc;
	char	**argv;
{
	Raster	*ras, *RasterOpen();
	Context	*context, *RasDrawOpen();
	int	status;
	unsigned char	default_colors[768];
	char	*pal_name;	/* name of a default color palette	*/
	int	verbose;	/* verbose or quite mode		*/
	int	count;		/* number of image displayed		*/
	char	*prog_name;
	int	i;

	int	exit_status = 0;

	void	usage();

	prog_name = argv[0];

	/*
	 * register the options we're interested in and have them parsed
	 */
	if (ParseOptionTable(&argc, argv, set_options) < 0) {
		fprintf(
			stderr,"%s : Error parsing command line options : %s\n",
			prog_name, ErrGetMsg()
		);
		exit(1);
	}

	/*
	 * load the options into opt
	 */
	if (GetOptions(get_options) < 0) {
		fprintf(
			stderr,"%s : GetOptions() : %s\n",
			prog_name,ErrGetMsg()
		);
		exit(1);
	}
	pal_name = opt.palette;
	verbose = ! opt.quiet;

	if (opt.version) {
		PrintVersion(prog_name);
		exit(0);
	}


	/*
	 * init libraster
	 */
	(void) RasterInit(&argc, argv);

	if ((context = RasDrawOpen(&argc, argv, FALSE)) == (Context *) NULL) {
		fprintf(
			stderr, "%s : Error initializing display : %s\n",
			prog_name, ErrGetMsg()
		);
		exit(1);
	}

	/*
	 * make sure nothing left on command line execpt file names
	 */
	for (i=0; i<argc; i++) {
		if (*argv[i] == '-') usage(prog_name, (char *) NULL);
	}

	/*
	 * load default palette if one was requested.
	 */
	if (pal_name) {
		if (PaletteRead(pal_name,NULL,default_colors)== RAS_OK){
			(void) RasDrawSetPalette(context, default_colors,
				default_colors + 256,
				default_colors + 512, 
				256);
		}
		else {
			RasterPrintError(pal_name);
			exit_status++;
		}
	}

	/*
	 * anything left on command line is assumed to be a raster file
	 */
	while(*(++argv))
	{

		if ((ras = RasterOpen(*argv, NULL)) == (Raster *) NULL){
			(void) RasterPrintError(*argv);
			exit_status++;
			continue;	/* skip this file	*/
		}

		if (verbose) {
			(void) fprintf(stderr, 
				"Displaying images from file: %s\n", *argv);
		}

		/*
		 * display all the images in the file
		 */
		count = 0;
		for (;;) {
			if ((status = RasterRead(ras)) != RAS_OK) {
				break;
			}
			if (verbose) {
				count++;
				(void) fprintf(stderr,
					"	image number: %d\n",count);
			}

			exit_status += display_image(ras, context, verbose);
		}

		(void) RasterClose(ras);

		if (status == RAS_ERROR) {
			RasterPrintError(*argv);
			exit_status++;
		}
	}
	RasDrawClose(context);
	exit(exit_status);
}

/*
 *	display_image
 *
 *	display an image. If the image is Direct colour format dither it
 *	to an 8-bit image.
 *
 * on entry
 *	*ras		: contains image to display
 *	*context	: context returned by RasDrawOpen()
 *	verbose		: verbose or quiet mode?
 */
static	display_image(ras, context, verbose)
	Raster	*ras;
	Context	*context;
	int	verbose;
{
	static	Raster	*indexed_ras = (Raster *) NULL;
	int	status;

	Raster	*RasterCreate();

	if (ras->type == RAS_INDEXED && (context->encoding & RASDRAW_8BIT)) {
		(void) RasDraw(ras, context);
	}
	else if(ras->type == RAS_DIRECT && (context->encoding & RASDRAW_24BIT)){
		(void) RasDraw(ras, context);
	}
	/*
	 * if true color dither to indexed 8-bit image
	 */
	else if (ras->type == RAS_DIRECT && context->encoding & RASDRAW_8BIT) {
		if (! indexed_ras) {	/* alloc memory for indexed image */
			indexed_ras = RasterCreate(ras->nx,ras->ny,RAS_INDEXED);
			if (indexed_ras == (Raster *) NULL) {
				(void) RasterPrintError((char *)NULL);
				return(-1);
			}
		}
		(void) fprintf(stderr, 
			"Warning: dithering 24-bit to 8-bit image\n");

		status = RasterDither(ras, indexed_ras, verbose);

		if (status == RAS_ERROR) {
			(void) RasterPrintError((char *) NULL);
			return(-1);
		}

		(void) RasDraw(indexed_ras, context);
	} 
	else {
		(void) fprintf(stderr, "Error: unknow image format\n");
		return(-1);
	}
	return(0);
}

void	usage(prog_name, message) 
	char	*prog_name;
	char	*message;
{

	if (message) {
		(void) fprintf(stderr, "%s: %s", prog_name, message);
	}

	(void) fprintf(stderr, 
		"%s: Usage: %s [-Version] [-pal palette_file] [-quiet] [raster_file...]\n",
		prog_name, prog_name);
	PrintOptionHelp(stderr);

	exit(1);
}
