#!/bin/bash
# $Id$
# keyser@sambaedu.org - 12/2006
SE3MODULE="se3-ocs-clientwin"
PATH_SE3MODULE="$PWD"


SOURCE_DIR="sources"
#Couleurs
COLTITRE="\033[1;35m"	# Rose
COLPARTIE="\033[1;34m"	# Bleu

COLTXT="\033[0;37m"	# Gris
COLCHOIX="\033[1;33m"	# Jaune
COLDEFAUT="\033[0;33m"	# Brun-jaune
COLSAISIE="\033[1;32m"	# Vert

COLCMD="\033[1;37m"	# Blanc

COLERREUR="\033[1;31m"	# Rouge
COLINFO="\033[0;36m"	# Cyan

POURSUIVRE()
{
	REPONSE=""
	while [ "$REPONSE" != "o" -a "$REPONSE" != "O" -a "$REPONSE" != "n" ]
	do
		#echo -e "$COLTXT"
		echo -e "${COLTXT}Peut-on poursuivre ? (${COLCHOIX}O/n${COLTXT}) $COLSAISIE\c"
		read REPONSE
		if [ -z "$REPONSE" ]; then
			REPONSE="o"
		fi
	done
echo -e "$COLTXT"
	if [ "$REPONSE" != "o" -a "$REPONSE" != "O" ]; then
		ERREUR "Abandon!"
	fi
}



svn update $PATH_SE3MODULE || exit 1

cp -a "$PATH_SE3MODULE" /tmp/
cd /tmp/

echo "Suppression reps .svn"

find ./$SE3MODULE -name .svn -print0 | xargs -0 rm -r


echo "construction du paquet $SE3MODULE"
POURSUIVRE
cd $SE3MODULE/$SOURCE_DIR
dh_clean
debuild -uc -us -b
cd ..
cp *.deb "$PATH_SE3MODULE"/
cd /tmp
rm -rf $SE3MODULE
cd $PATH_SE3MODULE
