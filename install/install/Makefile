ROOT_DIR = /ptmp/haley
INS_DIR	= $(ROOT_DIR)/INSTALL
SRC_TAR	= $(ROOT_DIR)/SRC.TAR

TARGETS		= HPUX_HP9000_8xx HPUX_HP9000_7xx AIX_32_RS6000 AIX_64_RS6000 \
		Solaris_sun4 ULTRIX_RISC IRIX_n32_IP IRIX_64_IP LINUX_alpha \
		OSF1_alpha UNICOS_YMP UNICOS_J90 UNICOS_C90 LINUX_PC LINUX_IA64 \
		Solaris_PC CYGWIN_PC DARWIN_MAC

SHELL		= /bin/sh

all::	dirs

all::
	@/bin/rm -f var/TOC
all::
	@-for name in $(TARGETS); do \
		cp $(ROOT_DIR)/$$name/sizes var/sizes.$$name; \
		cp $(ROOT_DIR)/$$name/version var/version.$$name; \
	done

dirs::
	@if (test ! -d $(INS_DIR)) then mkdir $(INS_DIR); else continue; fi
	@if (test ! -d $(INS_DIR) || test ! -w $(INS_DIR)) then \
	echo "Installation Error - $(INS_DIR) is not writeable"; exit 1; \
	fi
	@/bin/rm -fr $(INS_DIR)/*

install::	all
	tar -cf - . | (cd $(ROOT_DIR)/INSTALL; tar -xf -)

clean::
	/bin/rm -f var/*

