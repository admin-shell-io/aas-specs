# This is the repository of the Asset Administration Shell

[![Check](
https://github.com/admin-shell-io/aas-specs/workflows/Check/badge.svg
)](
https://github.com/admin-shell-io/aas-specs/actions?query=workflow%3ACheck
)
[![Creative Commons License](
https://licensebuttons.net/l/by/4.0/88x31.png
)](
https://creativecommons.org/licenses/by/4.0/
)

This repository contains specifications of the Asset Administration Shell, including the normative schemas of the serializations, the rules applied to create them, how the specification is mapped into the serializations, and examples of how to use the schemas.

## Schemas

The schemas of the Asset Administration Shell for JSON, RDF and XML as well as a XMI and YAML representation of the metmodel are provided in the respective directories. 
These schemas are derived from the document series, part 1,
["Details of the Asset Administration Shell"](
https://www.plattform-i40.de/PI40/Redaktion/EN/Standardartikel/specification-administrationshell.html
) published by the [Platform Industrie 4.0](http://www.plattform-i40.de) and [IDTA](https://industrialdigitaltwin.org/en/).

### JSON

The JSON schema, mapping rules and examples are available at
[schemas/json/](schemas/json/).

### RDF

The RDF data model, mapping rules and examples are available at [schemas/rdf/](schemas/rdf/).

### XML

The XML schema, mapping rules and examples are available at [schemas/xml/](schemas/xml/).

### XMI

The XMI file for the UML metamodel is available at [schemas/xmi/](schemas/xmi/).

### YAML

The YAML files for the API definitions are available at [schemas/yaml/](schemas/yaml/).

  
## Releases

The following versioning scheme is applied: 'V\<major>.\<minor>.\<patch>'. 
Major versions indicate breaking changes while minor updates are backward compatible.
The patch position is increased whenever bugfixes need to be applied. Note that, as long as the UML-based metamodel has the state of a "Release Candidate", the acronym 'RC' followed by the number of the corresponding release candidate is added to the patch position.
The following release contains the latest version of the AAS schemas (see also the [releases](https://github.com/admin-shell-io/aas-specs/releases) section of this repository):
* [3.0.5RC02](https://github.com/admin-shell-io/aas-specs/releases/tag/V3.0.5RC02) is the corresponding release for the `V3.0RC02` version of the AAS metamodel, containing the normative schemas for the published document "Part 1: Details of the Asset Administration Shell - The exchange of information between partners in the value chain of Industrie 4.0 - **Version 3.0RC02**". *Use this release if you want to work with the latest specified AAS version.*

Previous releases (deprecated by [3.0.5RC02](https://github.com/admin-shell-io/aas-specs/releases/tag/V3.0.5RC02)):
* [3.0.4RC01](https://github.com/admin-shell-io/aas-specs/releases/tag/V3.0.4RC01) is the final release for the `V3.0RC01` version of the AAS metamodel, containing the normative schemas for the published document "Part 1: Details of the Asset Administration Shell - The exchange of information between partners in the value chain of Industrie 4.0 - Version 3.0RC01". *No additional bugfix or patch releases for the metamodel version `V3.0RC01` shall be expected.*
* [3.0.3RC01](https://github.com/admin-shell-io/aas-specs/tree/V3.0.3RC01) is a pre-release of the schemas for the published document "Part 1: Details of the Asset Administration Shell - The exchange of information between partners in the value chain of Industrie 4.0 - Version 3.0RC01" that solves several typos and bugs of `3.0.2.RC01`
* [3.0.2.RC01](https://github.com/admin-shell-io/aas-specs/releases/tag/v3.0.2.RC01) is a pre-release of the schemas for the published document "Part 1: Details of the Asset Administration Shell - The exchange of information between partners in the value chain of Industrie 4.0 - Version 3.0RC01" that solves several typos and bugs of `3.0.1.RC01`
* [3.0.1.RC01](https://github.com/admin-shell-io/aas-specs/releases/tag/v3.0.1.RC01) is a pre-release of the schemas for the published document "Part 1: Details of the Asset Administration Shell - The exchange of information between partners in the value chain of Industrie 4.0 - Version 3.0RC01" that solves a bug in the JSON schema of `3.0.RC01`
* [3.0.RC01](https://github.com/admin-shell-io/aas-specs/releases/tag/v3.0.RC01) is a pre-release containing the schemes as contained by the document 'Details of the Asset Administration Shell - Part 1 - Version 3.0.RC01' [download](https://www.plattform-i40.de/PI40/Redaktion/EN/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.html)


## Contributing

Feature requests, reports about inconsistencies, mistakes *etc.* are highly
welcome! Please [submit a new issue](
https://github.com/admin-shell-io/aas-specs/issues/new
).

If you want to contribute, see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This work is licensed under a [Creative Commons Attribution 4.0 International License](
https://creativecommons.org/licenses/by/4.0/). The implementation is based on the specifications of the "Details of the Asset Administration Shell" published on https://www.plattform-i40.de and https://industrialdigitaltwin.org/en/ 
which is licensed under Creative Commons CC-BY-4.0.
