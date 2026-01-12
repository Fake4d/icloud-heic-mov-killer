#!/bin/bash

# Verzeichnis, in dem du nach Dateien suchen möchtest
verzeichnis="/home/example/path"

# Schleife über alle Dateien im Verzeichnis
shopt -s nullglob
for datei in "$verzeichnis"/*; do
        [[ -f "$datei" ]] || continue
        basis="${datei%.*}"

        # Überprüfe, ob eine Datei mit derselben Basis als HEIC existiert
        heic_files=( "${basis}.heic" "${basis}.HEIC" )
        if [[ -f "${heic_files[0]}" || -f "${heic_files[1]}" ]]; then
            ext="${datei##*.}"
            if [[ "${ext,,}" != "heic" ]]; then
                rm -- "$datei"
                echo "Datei gelöscht: $datei"
            fi
        fi
done
