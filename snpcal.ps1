# winget install --id JohnMacFarlane.Pandoc -e
# cmake --workflow default

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Year,

    [Parameter(Mandatory = $true, Position = 1)]
    [string]$Month
)

$scriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

$snpcalExe = Join-Path $scriptRoot 'build/snpcal.exe'
if (-not (Test-Path -LiteralPath $snpcalExe)) {
    $snpcalExe = Join-Path $scriptRoot 'build/snpcal'
}
if (-not (Test-Path -LiteralPath $snpcalExe)) {
    throw "Could not find executable at '$scriptRoot/build/snpcal(.exe)'. Build it first with 'cmake --workflow default'."
}

$outFile = "$Year-$Month.pdf"

@('```') + (& $snpcalExe $Year $Month) + @('```') |
    & pandoc --from=markdown --to=pdf `
        --columns=133 --wrap=none `
        -V geometry=landscape,margin=0.4cm `
        -o $outFile

Write-Host "Saved $outFile"
