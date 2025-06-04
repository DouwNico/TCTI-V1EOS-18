#!/usr/bin/env bash

# Gemaakt door Douwe de Jong voor het vak TCTI-V1EOS-18.

jpgNaarPng() {
    # Itereren door de files in het opgegeven pad.
    for file in $1*; do
        # Met regex checken of .jpg voorkomt in de bestandsnaam.
        if [[ $file =~ ".jpg" ]]; then
            # Bij het gematchte bestand de string naar het pad opslaan in een nieuwe variable zonder .jpg erachter.
            new_name="${file%.jpg}"
            # Het bestand converteren en resizen naar max 128x128 en opslaan als png.
            convert $file -resize '128x128' $new_name.png
        fi
    done
}
jpgNaarPng $1