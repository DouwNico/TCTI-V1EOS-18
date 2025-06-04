#!/usr/bin/env bash

# Gemaakt door Douwe de Jong voor het vak TCTI-V1EOS-18.

# Dependicies: flac, imagemagick, wget

# Dit scripts doel is om van een CD geripte .WAVs te converteren naar .FLAC en de front cover toe te voegen.
# de front cover kan zowel een lokale afbeelding zijn als een foto van het internet.

# Het script wordt aangeroepen met: naarFLAC /pad/naar/WAV_bestanden /pad/met/nieuwe_map_naam /pad/of/hyperlink/naar_foto

# Dit gaat als volgt:
# Stap 1.1: Het script kijkt of er een foto is meegegeven. (geen foto/lokale foto/hyperlink)
# Stap 1.2: Als het een hyperlink is wordt het bestand gedownload en geconverteerd naar het juist bestandsformaat en afmetingen
# Stap 2.1: Met een for loop worden de .wav bestanden geconverteerd naar .flac en in een nieuwe map geplaatst
# Stap 2.2: Afhankelijk van stap 1 wordt er een front cover aan meegegeven
# Stap 2.3: De resultaten van de conversie worden getest/geanalizeerd en de resultaten worden in een tekst bestand gezet.


check_foto() {
    if [[ $1 =~ "http"  ]]; then # checkt of http voorkomt in de invoer van de foto
        wget --output-document=front_cover $1 # als het een hyperlink is dan wordt de foto opgehaald met wget
        convert ./front_cover -resize '512x512' Cover.png # de foto wordt geresized naar een acceptabel formaat
        Cover="./Cover.png"
        echo "Cover gedownload!"
        rm ./front_cover # het temp bestand wordt gewist
    elif [ $1 ]; then
        convert $1 -resize '512x512' Cover.png # de foto wordt geresized naar een acceptabel formaat
        Cover="./Cover.png"
    else
        Cover=$1
    fi
}

wav_naar_flac() {
    if [ -z $Cover ]; then # als er geen cover is ingevoerd
        for file in $1*; do # dan wordt alle .wav files zonder cover geconverteerd
            if [[ $file =~ ".wav" ]]; then
                flac -V --keep-foreign-metadata-if-present --best $file 2>> ./Result.log # de -V optie is voor de verificatie dat de encoding goed gelukt is
                echo "$file is geconverteerd"
            fi
        done
    else # Als er wel een foto is meegegeven dan wordt hij ge-embed in de flac file
        for file in $1*; do
            if [[ $file =~ ".wav" ]]; then
                flac -V --keep-foreign-metadata-if-present --best --picture $Cover $file 2>> ./Result.log
                echo "$file is geconverteerd met cover"
            fi
        done
    fi
}

cleanup() { # De output van de flac encoder is vrij verbose dus hier wordt alleen de regels die te maken hebben met de verify info er uit gehaald
    if [ $2 ]; then # als er een nieuwe map naam is opgegeven wordt hij hier aangemaakt en alle flacs naar die map verplaatst
        grep Verify ./Result.log > ./Final_Result.log
        rm ./Result.log # opschonen van de oude file
        mkdir $2
        mv ./Final_Result.log $2 # de log verplaatsen naar de nieuwe map
        if [ $Cover ]; then # als er een cover is wordt die ook verplaatst naar de nieuwe map
            mv ./Cover.png $2
        fi
        for file in $1*; do # alle .flac files worden overgezet naar de nieuwe map
            if [[ $file =~ ".flac" ]]; then
                mv $file $2
            fi
        done
    else # als er niewe map is meegegeven dan wordt alsnog de cleanup gedaan.
        grep Verify ./Result.log > ./Final_Result.log
        rm ./Result.log
    fi
}

check_foto $3
wav_naar_flac $1
cleanup $1 $2