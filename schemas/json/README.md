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

### Classes 🠒 JSON definitions

For each class of the [AAS meta-model], we provide [a definition] in the JSON schema.
The instances of the classes, abstract and concrete alike, are modeled as [JSON objects].

[a definition]: https://json-schema.org/understanding-json-schema/structuring.html#defs
[JSON objects]: https://json-schema.org/understanding-json-schema/reference/object.html

### Attributes  🠒 JSON properties

The attributes of classes defined in the meta-model correspond directly to [JSON properties].

[JSON properties]: https://json-schema.org/understanding-json-schema/reference/object.html#properties

### Cardinality

Optional attributes, *i.e.*, the attributes with the cardinality ``0..1``, are modeled as [non-required properties].

[non-required properties]: https://json-schema.org/understanding-json-schema/reference/object.html#required-properties

Attributes describing aggregations, *i.e.*, the attributes with the cardinality ``0..*``, ``1..*`` *etc.*, are modeled as [JSON arrays].

[JSON arrays]: https://json-schema.org/understanding-json-schema/reference/array.html

We explicitly forbid empty JSON arrays to avoid confusion about attributes which have cardinality ``0..*``.
Namely, an empty array is semantically equal to an omitted attribute (according to the meta-model).
Thus, the JSON property representing an aggregation attribute must be omitted if the aggregation is empty.

In UML, it is the convention to name associations and aggregations in singular form. The cardinality is to be taking into account to decide on whether there are none, a single or several elements in the corresponding association or aggregation. 
In JSON it is the array that declares the set of elements, therefore we choose the plural name for it. The singular name is used for its descriminator (see section on decriminators).
Typically the plural name is derived by just adding an "s" to the name.
For example, ``submodelElements`` instead of ``submodelElement`` in case of [Submodel] class.

If plural form made no sense for a property, we kept it as-is (*e.g.*, `isCaseOf`).
The full list of exceptions is available [as code in aas-core-meta].

If plural form made no sense for an attribute, we kept it as-is (*e.g.*, `isCaseOf`).
The full list of exceptions is available [as code in aas-core-meta].

[as code in aas-core-meta]: https://github.com/aas-core-works/aas-core-meta/blob/95055a55a8c8f60d75fb48c26eb932ff99945dd2/tests/test_v3rc2.py#L1122

### Primitive attribute values

The UML specification uses xsd types. For the mapping of xsd types to JSON types please refer to [Part 2 of the series of the Asset Adminsistration Shell].

There are the following exceptions: For [Property]/value and [Range]/min and [Range]/min the type xs:string is used because the type is only known at run-time. Its type is declared in [Property]/valueType or [Range]/valueType, resp.
Note: in valueOnly Format of [Part 2 of the series of the Asset Adminsistration Shell] value has the type as declared in Property/valueType.

[Part 2 of the series of the Asset Adminsistration Shell]: https://industrialdigitaltwin.org/wp-content/uploads/2021/11/Details_of_the_Asset_Administration_Shell_Part_2_V1.pdf?__blob=publicationFile&v=10#page=81


### Be aware of possible type mismatches between xsd and JSON types

Type mappings are not trivial. Some sort of type mapping is always needed when using different programming languages and different serialization formats. One way to avoid some JSON type conversion problems would have been to just use [JSON strings] for all primitive attributes values. 
However, besides loss of semantics and higher effort for programmers there also is the risk of JSON injection attacks. 

[JSON strings]: https://json-schema.org/understanding-json-schema/reference/string.html

[Property]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=75
[Range]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=76
[JSON number]: https://www.rfc-editor.org/rfc/rfc4627#section-2.4
[JSON boolean]: https://json-schema.org/understanding-json-schema/reference/boolean.html
[XSD types]: https://www.w3.org/TR/xmlschema11-2
[5.7.12 Primitive and Simple Data Types]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=95

The following would have been arguments in favor to stricly use JSON strings for all primitive attribute values:

First, a [JSON number] can only be a concrete numerical value where special cases such as `INF` and `NaN` are not representable in JSON, whereas these values are completely valid instances of [xs:decimal].

[xs:decimal]: https://www.w3.org/TR/xmlschema11-2/#decimal

Second, the [lexical space] of XSD values is much larger than the lexical space of JSON numbers and booleans.
For example, both `1` and `true` are valid lexical representations of a true value.
In contrast, JSON recognizes only `true`.
We are not considering cases in which a semantic definition would even redefine the semantics of `1` as `false`.

[lexical space]: https://www.w3.org/TR/xmlschema11-2/#lexical-space

In many cases the semantics of a [Property] or any other [SubmodelElement] is also restricting its value range in case of numerical values. However, when just looking at the [Property/valueType] this information is not given`and the value range seems larger than it actually is allowed to be.

[Property/semanticId]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=75
[Property/value]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=75

Third, a round-trip conversions XML 🠒 JSON 🠒 XML or RDF 🠒 JSON 🠒 RDF would be lossy.
This makes proper testing hard, and can cause a lot of confusion both for the developers and end-users using, say, GUI editors.
The result of a model saved as XML is different to the model saved as JSON.
For example, if the user typed in `1` for a boolean [Property/value] in the editor, saved the model as JSON and opened it again, she would suddenly see `true` instead of `1` (since the JSON library would silently convert `1` to a JSON boolean `true`).
This effect would not happen if we saved the model to XML (`1` will remain `1`).

Fourth, the precision of the XSD numeric types is well-defined, while JSON specification is vague when it comes to precision and size of the [JSON number].
XSD is very specific about the format, *e.g.*, [xs:float] is a 32-bit floating point number following IEEE 754, [xs:long] is a 64-bit integer number *etc.*
JSON specification leaves us in the dark about the precision, and defines only the lexical form (see [Section 2.4 of RFC 4627]).

On top of that, most JSON libraries parse numbers as 64-bit floating-point which might lead to catastrophic failures due to silent round-ups or round-downs.
This is especially problematic when 64-bit integers are converted to 64-bit floats.
Despite popular belief, such catastrophic conversions do occur in practice more often than expected since 64-bit integers are used in applications for, *e.g.*, hash values, nanoseconds since epoch or randomized numeric IDs.

For a concrete illustration of the problem, here is a short snippet in C# which demonstrates the problem:

```cs
using System;

public class Program
{
  public static void Main()
  {
    // Mind the last digits in the following code!
    Console.WriteLine(
      double.Parse("9007199254740993") == 9007199254740992.0);
    
    Console.WriteLine(
      double.Parse("9007199254740994") == 9007199254740994.0);
    
    Console.WriteLine(
      double.Parse("9007199254740995") == 9007199254740996.0);
    
    Console.WriteLine(
      double.Parse("9007199254740996") == 9007199254740996.0);

    // Gives the output:
    // True ?!💀?!
    // True
    // True ?!💀?!
    // True

    Console.WriteLine(
      long.Parse("9007199254740993") == 9007199254740993);
    
    Console.WriteLine(
      long.Parse("9007199254740994") == 9007199254740994);
    
    Console.WriteLine(
      long.Parse("9007199254740995") == 9007199254740995);
    
    Console.WriteLine(
      long.Parse("9007199254740996") == 9007199254740996);

    // Gives the output (as expected):
    // True
    // True
    // True
    // True
  }
}
```

(The snippet is available on-line on [C# fiddle JkkIlT]).

More information is available, say, on [this StackOverflow question about int🠒float casting].

[xs:float]: https://www.w3.org/TR/xmlschema11-2/#float
[xs:long]: https://www.w3.org/TR/xmlschema11-2/#long
[Section 2.4 of RFC 4627]: https://www.rfc-editor.org/rfc/rfc4627#section-2.4
[C# fiddle JkkIlT]: https://dotnetfiddle.net/JkkIlT
[this StackOverflow question about int🠒float casting]: https://stackoverflow.com/questions/59635426/how-does-the-int-to-float-cast-work-for-large-numbers

### Inheritance

The inheritance relationships between the classes are modeled using [allOf composition].
While JSON schema knows no inheritance, we enforce through ``allOf`` that all the properties of the parent are defined in the descendants.

[allOf composition]: https://json-schema.org/understanding-json-schema/reference/combining.html#allof

### Discriminator

Many attributes in the meta-model refer to an abstract class.
When we de-serialize such attributes, we need to know the concrete class at runtime, since otherwise the de-serialization algorithm would not know how to interpret the properties of the object.

For example, consider the attribute [Submodel] which contains instances of [SubmodelElement].
When the de-serializer encounters the property ``submodelElements`` as an array and starts de-serializing its items, how can it know which constructor to call to parse the item?
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

We consequently embed the data specifications by adding `embeddedDataSpecifications` property to the definition corresponding to [HasDataSpecification], and deliberately omit the attribute `HasDataSpecification/dataSpecification` in the schema.

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
