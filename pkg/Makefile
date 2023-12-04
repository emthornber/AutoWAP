################################################################################
#
#	Create autowap Debian package
#
#	24 November, 2023 - E M Thornber
#	Created
#
#	04 December, 2023 - E M Thornber
#	Added creation of hotspot.config
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
PYTHON=/usr/bin/python3
RM=/usr/bin/rm -f
TS=`date "+%y%m%d-%H%M"`
CFG_BASE=config
SRC_BASE=scripts

all: clean pkgs

clean:
	$(RM) *.log

pkgs: portable deb

portable: $(CFG_BASE)/hotspot.config
	$(EPM) -a all -f portable -g -vv --output-dir $(ODIR) srcdir=$(SDIR) pkgver=$(VERS) $(PKGNAME) $(SDIR)/pkg/$(PKGDEFN) 2>&1 | tee portable-$(TS).log

deb: $(CFG_BASE)/hotspot.config
	$(EPM) -a all -f deb      -g -vv --output-dir $(ODIR) srcdir=$(SDIR) pkgver=$(VERS) $(PKGNAME) $(SDIR)/pkg/$(PKGDEFN) 2>&1 | tee deb-$(TS).log

$(CFG_BASE)/hotspot.config: $(CFG_BASE)/hotspot-config-defn.json
	$(PYTHON) $(SRC_BASE)/create_hotspot_cfg.py < $< > $@
