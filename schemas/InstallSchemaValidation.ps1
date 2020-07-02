<#
.Description
This script installs the tools for schema validation.
#>

function Main {
    Push-Location

    Set-Location $PSScriptRoot
    $schemasDir = $PSScriptRoot

    # Undo if the directory exists
    Remove-Item "schema-validation" -Recurse -ErrorAction Ignore


    $url = "https://github.com/admin-shell-io/schema-validation/releases/download/v1.0.0/schema-validation.zip"
    $zipPath = Join-Path $schemasDir "schema-validation.zip"

    Invoke-WebRequest -Uri $url -OutFile $zipPath

    Expand-Archive -Path $zipPath -DestinationPath $schemasDir

    Remove-Item $zipPath

    Pop-Location
}
Main

