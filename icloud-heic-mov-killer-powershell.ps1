[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Parameter(Position=0)]
    [string]$Directory = "C:\Users\YourUser\Downloads\test\iCloud",

    [switch]$Recurse,

    [switch]$Force
)

# Get files (optionally recursive)
$files = if ($Recurse) {
    Get-ChildItem -Path $Directory -File -Recurse -ErrorAction Stop
} else {
    Get-ChildItem -Path $Directory -File -ErrorAction Stop
}

foreach ($file in $files) {
    # skip HEICs
    if ($file.Extension -ieq ".heic") { continue }

    $base = [System.IO.Path]::ChangeExtension($file.FullName, $null)

    # Find any file with the same base and a .heic extension (case-insensitive)
    # Use wildcard search for the same base + any extension then filter by extension
    $candidatePattern = "$base.*"
    $heicCandidate = Get-ChildItem -Path $candidatePattern -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -ieq ".heic" } |
        Select-Object -First 1

    if ($heicCandidate) {
        $what = "Remove file '$($file.FullName)' because HEIC exists: '$($heicCandidate.Name)'"
        if ($PSCmdlet.ShouldProcess($file.FullName, $what)) {
            $removeParams = @{ LiteralPath = $file.FullName; ErrorAction = 'Stop' }
            if ($Force) { $removeParams.Force = $true }
            Remove-Item @removeParams
            Write-Host "Deleted: $($file.FullName)"
        } else {
            Write-Host "Would delete: $($file.FullName) (HEIC present: $($heicCandidate.Name))"
        }
    }
}
