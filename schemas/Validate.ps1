<#
This script validates all the examples against the schemas.
#>

function Main 
{
    Push-Location

    $schemasDir = $PSScriptRoot

    $schemaValidationDir = Join-Path $schemasDir "schema-validation"
    if(!(Test-Path $schemaValidationDir -PathType Container))
    {
        throw "The schema-validation could not be found: $schemaValidationDir; have you installed it?"
    }

    Set-Location $schemasDir

    
    Write-Host "Validating JSON ..."
    & $(Join-Path $schemaValidationDir "ValidateJson") --inputs 'json\examples\*.json' --schema 'json\aas.json'
    if($LASTEXITCODE -ne 0) 
    {
        throw "JSON validation failed."
    }

    Write-Host "Validating XML ..."
    & $(Join-Path $schemaValidationDir "ValidateXml") --inputs 'xml\examples\*.xml' --schema 'xml\AAS.xsd'
    if($LASTEXITCODE -ne 0) 
    {
        throw "XML validation failed."
    }

    Write-Host "Validating RDF ..."
    & $(Join-Path $schemaValidationDir "ValidateRdf") --model 'rdf\rdf-ontology.ttl'
    if($LASTEXITCODE -ne 0) 
    {
        throw "RDF validation failed."
    }

    & $(Join-Path $schemaValidationDir "ValidateRdf") --model 'rdf\shacl-schema.ttl'
    if($LASTEXITCODE -ne 0) 
    {
        throw "RDF validation failed."
    }

    Pop-Location
}
Main
