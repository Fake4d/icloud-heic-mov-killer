#!/bin/bash

# Verzeichnis, in dem du nach Dateien suchen möchtest
verzeichnis="/home/example/path"

# Schleife über alle Dateien im Verzeichnis
for datei in "$verzeichnis"/*; do
        dateiname="${datei%.*}"

        # Überprüfe, ob eine Datei mit derselben Basis, aber anderer Erweiterung existiert
	shopt -s nocaseglob # Ignoriere Groß-/Kleinschreibung
        andere_datei="${dateiname}.heic"
        if [[ -f "$andere_datei" && "$andere_datei" != "$datei" ]]; then
            # Lösche die Datei
            rm "$datei"
            echo "Datei $datei gelöscht."
        fi
done

