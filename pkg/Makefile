################################################################################
#
#	Create autowap Debian package
#
#	24 November, 2023 - E M Thornber
#	Created
#
#	11 October, 2024 - E M Thornber
#	Streamlined targets
#
#	EVs required
#	ODIR - where to place the .deb file
#	SDIR - current source directory
#	VERS - package version
#
#	Working directory is assumed to be ${CMAKE_CURRENT_SOURCE_DIR}
################################################################################

EPM := $(shell which epm)
PKGNAME := $(shell basename %{SDIR} | tr '[:upper:]' '[:lower:'] )
PKGDEFN := $(SDIR)/pkg/$(PKGNAME).epm
RM=/usr/bin/rm -f
TS=`date "+%y%m%d-%H%M"`
CFG_BASE=./config

all: pkgs

pkgs: portable deb

deb portable:
	sudo $(RM) $(ODIR)/$@-*.log
	sudo $(EPM) -a all -f $@ -vv --output-dir $(ODIR) srcdir=$(SDIR) version=$(VERS) $(PKGNAME) $(PKGDEFN) 2>&1 | tee $@-$(TS).log
