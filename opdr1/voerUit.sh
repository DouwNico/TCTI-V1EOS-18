#!/usr/bin/env bash

# Gemaakt door Douwe de Jong voor het vak TCTI-V1EOS-18.
FILE_EXTENTION=$1

case $FILE_EXTENTION in

  *.py)
  # Als het bestand endigt op .py dan wordt de pyhton interperter opgeroepen om het bestand uit te voeren.
  echo "Het pythonbestand wordt uitgevoerd:"
  python3 $FILE_EXTENTION
  ;;

  *.sh)
  # Als het bestand eindigt op .sh wordt het script uitgevoerd met bash.
  echo "Het Bash script wordt uitgevoerd:"
  bash $FILE_EXTENTION
  ;;

  *.cc)
  # Als het een C++ bestand is dat wordt het geprint met cat.
  echo "Het C++ wordt geprint:"
  cat $FILE_EXTENTION
  ;;

  *)
  # geef een fout melding terug, als het niet een van de bovenstaande opties is.
  echo "Bestandsextensie niet herkend!"
  ;;
esac
