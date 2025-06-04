#!/usr/bin/env bash

# Gemaakt door Douwe de Jong voor het vak TCTI-V1EOS-18.

# Optie 1 met behulp van find -exec
optie_1() {
    # Maakt de map Afbeeldingen aan in de meegegeven map
    mkdir $1/"Afbeeldingen"/
    # Vind en verplaatst de jpg bestanden naar de nieuwe afbeeldingen map
    find $1 -type f -name '*.jpg' -exec mv {} $1/Afbeeldingen/ \;
    # Hetzelfde alleen dan voor png bestanden
    find $1 -type f -name '*.png' -exec mv {} $1/Afbeeldingen/ \; 
}

# Optie 2 met behulp van een loop
optie_2() {
    # Maakt de map Afbeeldingen aan in de meegegeven map
    mkdir $1/"Afbeeldingen"/
    # Itereren door de files in het opgegeven pad.
    for file in $1*; do
        # Met regex checken of .jpg voorkomt in de bestandsnaam
        if [[ $file =~ ".jpg" ]]; then
            # De file verplaatsen naar de nieuwe Afbeeldingen map.
            mv $file $1/Afbeeldingen/
        # Met regex checken of .png voorkomt in de bestandsnaam
        elif [[ $file =~ ".png" ]]; then
            # De file verplaatsen naar de nieuwe Afbeeldingen map.
            mv $file $1/Afbeeldingen/
        fi
    done
}

# optie_1 $1
optie_2 $1