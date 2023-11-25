################################################################################
#
#	Create autowap Debian package
#
#	24 November, 2023 - E M Thornber
#	Created
#
#	EVs required
#	ODIR - where to place the .deb file
#	SDIR - current source directory
#	VERS - package version
#
#	Working directory is assumed to be ${CMAKE_CURRENT_SOURCE_DIR}
################################################################################

EPM=/usr/bin/epm
PKGNAME=autowap
PKGDEFN=autowap.epm
RM=/usr/bin/rm -f
TS=`date "+%y%m%d-%H%M"`
CFG_BASE=./config

all: clean pkgs

clean:
	$(RM) *.log

pkgs: portable deb

portable:
	$(EPM) -a all -f portable -vv --output-dir $(ODIR) srcdir=$(SDIR) version=$(VERS) $(PKGNAME) $(SDIR)/pkg/$(PKGDEFN) | tee portable-$(TS).log

deb:
	$(EPM) -a all -f deb      -vv --output-dir $(ODIR) srcdir=$(SDIR) version=$(VERS) $(PKGNAME) $(SDIR)/pkg/$(PKGDEFN) | tee deb-$(TS).log
