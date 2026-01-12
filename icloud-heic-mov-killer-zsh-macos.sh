#!/bin/zsh

verzeichnis="/home/example/path"

for datei in "$verzeichnis"/*; do
  [[ -f "$datei" ]] || continue

  basis="${datei%.*}"

  # Suche nach HEIC (egal ob .heic oder .HEIC) – (N) verhindert "no matches found"
  heic_files=( "${basis}.heic"(N) "${basis}.HEIC"(N) )

  # Wenn eine HEIC existiert: lösche alles andere mit gleicher Basis (aber niemals HEIC)
  if (( ${#heic_files} > 0 )); then
    ext="${datei##*.}"
    if [[ "$ext" != "heic" && "$ext" != "HEIC" ]]; then
      rm -- "$datei"
      echo "Datei gelöscht: $datei"
    fi
  fi
done