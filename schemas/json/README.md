# JSON

[JavaScript Object Notation (JSON)] is a popular serialization format.
Beside XML and RDF, it is an  "official" serialization format for models of Asset Administration Shells (AAS).
Since JSON is a very versatile format, there are many ways how we could map an AAS model to it.
In this document, we explore our particular design of the serialization schema based on [JSON schema 2019-09], and explain in detail the rules how we mapped the [AAS meta-model] to it.

[JavaScript Object Notation (JSON)]: https://www.json.org
[JSON schema 2019-09]: https://json-schema.org/specification-links.html#2019-09-formerly-known-as-draft-8
[AAS meta-model]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10

## Top-Level Structure

The root of our serialization is a JSON object representing the instance of [Environment].
This environment contains three aggregations, corresponding to all [Identifiable] classes:

* [AssetAdministrationShell]'s,
* [Submodel]'s, and
* [ConceptDescription]'s.

[Environment]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=82
[Identifiable]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=51
[AssetAdministrationShell]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=57
[Submodel]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=61
[ConceptDescription]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=81

The JSON properties of the environment correspond to these three aggregations.

To simplify exploration of the JSON data, identifiable instances are only available at the level of the environment, and nowhere else.

## Mapping Rules

### Classes to JSON definitions

For each class of the [AAS meta-model], we provide [a definition] in the JSON schema.
The instances of the classes, abstract and concrete alike, are modeled as [JSON objects].

[a definition]: https://json-schema.org/understanding-json-schema/structuring.html#defs
[JSON objects]: https://json-schema.org/understanding-json-schema/reference/object.html

### UML properties to JSON properties

The class properties of the meta-model (attributes and aggregations) correspond directly to [JSON properties].

[JSON properties]: https://json-schema.org/understanding-json-schema/reference/object.html#properties

Optional attributes, *i.e.*, the attributes with the cardinality ``0..1``, are modeled as [non-required properties].

[non-required properties]: https://json-schema.org/understanding-json-schema/reference/object.html#required-properties

Aggregations, *i.e.*, the properties with the cardinality ``0..*``, ``1..*`` *etc.*, are modeled as [JSON arrays].

[JSON arrays]: https://json-schema.org/understanding-json-schema/reference/array.html

We explicitly forbid empty JSON arrays to avoid confusion about properties which have cardinality ``0..*``.
Namely, an empty array is semantically equal to an omitted attribute (according to the meta-model).
Thus, the JSON property representing an aggregation attribute must be omitted if the aggregation is empty.

In UML, it is the convention to name associations and aggregations in singular form. 
The cardinality is to be taken into account to decide on whether there are none, a single or several elements in the 
corresponding association or aggregation. 
In JSON it is best practice to use plural form for array in class properties. 
The singular name is used for its descriminator (see section on decriminators).
Typically the plural name is derived by just adding an "s" to the name.
For example, ``submodelElements`` instead of ``submodelElement`` in case of [Submodel] class.

If plural form made no sense for a property, we kept it as-is (*e.g.*, `isCaseOf`).
The full list of exceptions is available [as code in aas-core-meta].

[as code in aas-core-meta]: https://github.com/aas-core-works/aas-core-meta/blob/95055a55a8c8f60d75fb48c26eb932ff99945dd2/tests/test_v3rc2.py#L1122

### Primitive attribute values

The UML specification uses XSD types. For the [mapping of XSD to JSON types] please refer to [Part 2 of the series of the Asset Adminsistration Shell].

There are the following exceptions: 

[Property]/``value`` and [Range]/``min`` and [Range]/``max`` are mapped to a JSON string. The type it needs to be converted to by the data consumer is declared in [Property]/``valueType`` or [Range]/``valueType``, resp.

Primitive type [BlobType] (group of ``byte``s) is mapped to a JSON string with base64 encoding.

Note: in valueOnly Format of [Part 2 of the series of the Asset Adminsistration Shell] value has the JSON type as 
declared in [Property]/``valueType`` taking the [mapping of XSD to JSON types] into account.

[Part 2 of the series of the Asset Adminsistration Shell]: https://industrialdigitaltwin.org/wp-content/uploads/2021/11/Details_of_the_Asset_Administration_Shell_Part_2_V1.pdf
[mapping of XSD to JSON types]: https://industrialdigitaltwin.org/wp-content/uploads/2021/11/Details_of_the_Asset_Administration_Shell_Part_2_V1.pdf?__blob=publicationFile&v=10#page=83

[JSON strings]: https://json-schema.org/understanding-json-schema/reference/string.html

[Property]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=75
[Range]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=76
[BlobType]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=95
[JSON number]: https://www.rfc-editor.org/rfc/rfc4627#section-2.4
[JSON boolean]: https://json-schema.org/understanding-json-schema/reference/boolean.html
[XSD types]: https://www.w3.org/TR/xmlschema11-2
[5.7.12 Primitive and Simple Data Types]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=95

#### Hint: Round-Trip Conversions

Round-trip conversions XML to JSON to XML or RDF to JSON to RDF may not result in the original file.

The result of a model saved as XML is different to the model saved as JSON.
For example, if the user typed in `1` for a boolean UML attribute (e.g. for ``SubmodelElementList``/``orderRelevant``)
in the editor, saved the model as JSON and opened it again, she would suddenly see `true` instead of `1` 
(since the JSON library would silently convert `1` to a [JSON boolean] `true`).

### Inheritance

The inheritance relationships between the classes are modeled using [allOf composition].
While JSON schema knows no inheritance, we enforce through ``allOf`` that all the properties of the parent are defined in the descendants.

[allOf composition]: https://json-schema.org/understanding-json-schema/reference/combining.html#allof

### Discriminator

Many attributes in the meta-model refer to an abstract class.
When we de-serialize such attributes, we need to know the concrete class at runtime, since otherwise the de-serialization algorithm would 
not know how to interpret the properties of the object.

For example, consider the attribute [Submodel] which contains instances of [SubmodelElement].
When the de-serializer encounters the property ``submodelElements`` as an array and starts de-serializing its items, 
how can it know which constructor to call to parse the item?
This necessary nugget of information is commonly called "discriminator" (*e.g.*, see [OpenAPI 3 specification on polymorphism]).

[SubmodelElement]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=62
[OpenAPI 3 specification on polymorphism]: https://swagger.io/docs/specification/data-models/inheritance-and-polymorphism/

We define the discriminator for our serialization as an additional property, `modelType`, which do not correspond to any attribute in the meta-model.
Every class which has one or more descendants will have the discriminator `modelType` in its definition.

When a deserializer needs to de-serialize an instance of an abstract class, it can do so by dispatching the de-serialization to the appropriate de-serialization method based on `modelType`.

### Enumerations

The enumerations of the meta-model are directly mapped to [enumerated values in JSON schema].
Each enumeration is defined separately, and we do not in-line enumerations for readability.

[enumerated values in JSON schema]: https://json-schema.org/understanding-json-schema/reference/generic.html#enumerated-values

Enumerations which are not directly used in the schema are omitted.
For example, subsets of [KeyTypes] are omitted since only [KeyTypes] is used to define value of an attribute.

[KeyTypes]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=86

### Embedded Data Specifications

The meta-model defines data specifications in abstract (see Section [6 Predefined Data Specification Templates]).
However, the meta-model omits data specifications in an [Environment], and data specifications are intentionally non-identifiable.

[6 Predefined Data Specification Templates]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=106 

For practical applications, we need to access them *somehow*.
Therefore, the meta-model mandates to embed them in serializations (see Section [9.2.5 Embedded Data Specifications]).

[9.2.5 Embedded Data Specifications]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=150

We consequently embed the data specifications by adding `embeddedDataSpecifications` property to the definition corresponding to [HasDataSpecification], and deliberately omit the attribute [HasDataSpecification]/``dataSpecification`` in the schema.

[HasDataSpecification]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=56

## Examples

Examples of the JSON serializations can be found in [schemas/json/examples/](examples) folder.

## Background

### From Manual Transcription ...

The serialization to and from JSON changed over the course of different versions of the meta-model.
Originally, the schema had been manually designed, where a group of authors combed "the book" and manually transcribed it to JSON schema.
This was obviously error-prone as it often caused mismatches between other serializations (*e.g.*, XML and RDF), contained inconsistencies *etc.*

### ... to Automatic Generation

We eventually moved over to generate the serialization schemas based on a single-point-of-truth.
The current source is [aas-core-meta], a domain-specific Python representation of the meta-model.
The schemas are generated using [aas-core-codegen], a translating tool which transpiles aas-core-meta into different schemas and other targets such as SDKs.

[aas-core-meta]: https://github.com/aas-core-works/aas-core-meta
[aas-core-codegen]: https://github.com/aas-core-works/aas-core-codegen

While this approach reduced the rate of errors significantly, it also imposed certain limits on our schema design.
For example, the classes and enumerations are now programmatically mapped to JSON definitions, allowing for no exceptions.
Where we could in-line some of them for better readability, we are now forced to stick with the programmatic definitions.

Nonetheless some minor manual fixes were needed:

*XML*

- Type ``ValueDataType`` was renamed to ``ValueDataType_t`` for consistency reasons
- Type of attributes ``valueDataType`` was changed from ``xs:string`` to ``xs:anySimpleType`` for better consistency with the specification

