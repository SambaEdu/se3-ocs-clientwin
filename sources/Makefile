#!/usr/bin/make -f
# Makefile for se3_clonage

all:

install:
    # Add here commands to install the package into debian/slis-core.
    # Install des fichiers de configuration et de cron.
	cp -R agent_win_1.0RC3/* $(DESTDIR)/var/se3/Progs/ro/inventory/deploy/
	cp -R script_config/* $(DESTDIR)/var/se3/Progs/install/
	cp -R cpau/* $(DESTDIR)/var/se3/Progs/install/installdll/
clean:
