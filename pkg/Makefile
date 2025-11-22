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
#	28 December, 2024 - E M Thornber
#	Corrected destination of build log files
#
#   22 November, 2025 - E M Thornber
#   Updated package file name to contain just distribution and architecture
#
#	EVs required
#	ODIR - where to place the .deb file
#	PKGNAME - package name
#	SDIR - current source directory
#	VERS - package version
#
#	Working directory is assumed to be ${CMAKE_CURRENT_SOURCE_DIR}
################################################################################

ARCH := all
EPM := $(shell which epm)
CODENAME := $(shell lsb_release -sc)
PKGDEFN := $(SDIR)/pkg/$(PKGNAME).epm
RM=/usr/bin/rm -f
TS=`date "+%y%m%d-%H%M"`
CFG_BASE=./config

all: pkgs

pkgs: portable deb

deb portable:
	sudo $(RM) $(ODIR)/$@-*.log
	sudo $(EPM) -a $(ARCH) -f $@ -m $(CODENAME)-$(ARCH) -vv --output-dir $(ODIR) srcdir=$(SDIR) version=$(VERS) $(PKGNAME) $(PKGDEFN) 2>&1 | tee $(ODIR)/$@-$(TS).log
