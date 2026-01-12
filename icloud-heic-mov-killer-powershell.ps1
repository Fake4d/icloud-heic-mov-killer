<# 
Löscht alle Nicht-HEIC-Dateien, wenn eine HEIC mit gleicher Basis existiert.
#>

$verzeichnis = "C:\Users\YourUser\Downloads\test\iCloud"

Get-ChildItem -LiteralPath $verzeichnis -File | ForEach-Object {
    $file = $_
    $basis = [System.IO.Path]::ChangeExtension($file.FullName, $null)

    $heicLower = "${basis}.heic"
    $heicUpper = "${basis}.HEIC"
    $heicExists = (Test-Path -LiteralPath $heicLower) -or (Test-Path -LiteralPath $heicUpper)

    if ($heicExists -and -not ($file.Extension -ieq ".heic")) {
        Remove-Item -LiteralPath $file.FullName
        Write-Host "Datei gelöscht: $($file.FullName)"
    }
}
