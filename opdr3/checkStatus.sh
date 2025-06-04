#!/usr/bin/env bash

# Gemaakt door Douwe de Jong voor het vak TCTI-V1EOS-18.

# Mapt de argumenten naar leesbare variabelen
Directory=$1
Commando=$2
Logfile=$3

if [ -e $Logfile ]; then # kijkt of de logfile bestaat
    rm -f $Logfile # verwijderd oude logfile
    touch $Logfile # maakt een lege logfile aan
else
    touch $Logfile # maakt een lege logfile aan
fi

for item in $Directory*; do # Een for-loop die door de directory heen loopt
    if $Commando $item > /dev/null; then # checkt of het commando succesvol wordt uitgevoerd en redirect de normale uitvoer naar /dev/null
        echo "$Commando is succesvol uitgevoerd op $item" >> $Logfile # Zet het resultaat in de Logfile
    else
        echo "$Commando is NIET succesvol uitgevoerd op $item" >> $Logfile # Zet het resultaat in de Logfile
    fi
    
done
