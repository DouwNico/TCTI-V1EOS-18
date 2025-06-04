#!/usr/bin/env bash

# Gemaakt door Douwe de Jong voor het vak TCTI-V1EOS-18.

# stap 1: if statement, vraag om input(read, -p) als input leeg is dan whoami uitvoeren en die input opslaan
# stap 2.1: while-loop, vraag om input(read, -s -p) en sla op in temp var. break 2.1 als de input korter is dan 8 tekens
# stap 2.2: vraag nog een keer om input(read, -s -p) en sla op in temp var. break naar 2.1 als de input korter is dan 8 tekens
# stap 2.3: vergelijk de 2 temp vars als ze gelijk zijn sla op in var en als ze niet gelijk zijn break naar 2.1
# stap 3: maak een tekstbestand met de gebruikersnaam en de MD5-hash van het wachtwoord.

Passwordfile=$1

vraag_username(){
    while [ -z $Name ]; do # checkt of er een gebruikersnaam is
        read -p "Wat is je gebruikersnaam?: " Username
        if [ $Username ]; then # als er iets is ingevoerd dan zorgt dit er voor dat de while loop wordt onderbroken
            Name=$Username
            break
        else # anders wordt de username van de huidige user genomen
            Name= whoami 
            break
        fi
    done
}

vraag_wachtwoord() {
    while [ -z $Password ]; do # Als er nog geen wachtwoord is wordt deze loop uitgevoerd
        read -s -p "Geeft een wachtwoord op(langer dan 8 tekens): " Pass1
        while [ $Pass1 ]; do # na het vragen van de input wordt gekeken of er 8 of meer karakters in de string zitten
            if [ ${#Pass1} -lt 8 ]; then 
                echo -e "\nwachtwoord is niet lang genoeg"
                break # als er minder dan 8 karakters in het ww zitten dan break naar de vorige while loop
            else
                echo -e "\n"
                read -s -p "Geeft een wachtwoord nogmaals op: " Pass2
                if [ $Pass1 = $Pass2 ]; then # checkt of de 2 opgegeven wachtwoorden hetzelfde zijn.
                    Password=$Pass2 # Als ze gelijk zijn dan het wachtwoord meegeven aan de var om de loop te onderbreken en opslaan voor de volgende functie
                    break
                else # als het niet overeen komt dan weer opnieuw beginnen
                    echo -e "\nWachtwoord komt niet overeen!"
                    break
                fi
            fi
        done
    done
}

opslaan() {
    
    touch $Passwordfile # maakt de meegegeven file aan
    echo "Gebruikersnaam=$Name" >> $Passwordfile # voegt de gebruikersnaam toe aan het bestand
    MD5=$(echo -n "$Password" | md5sum) # het berekenen van de MD5 hash
    echo "Wachtwoord=$MD5" >> $Passwordfile # voegt de hash toe aan het meegegeven bestand
}

vraag_username
echo -e "\nDe gebruikersnaam wordt: $Name"
vraag_wachtwoord
echo -e "\nHet wachtwoord wordt opgeslagen"
opslaan