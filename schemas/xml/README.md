# XML

Extensible Markup Language ([XML]) is a popular serialization format for data exchange and storage.

[XML]: https://www.w3.org/TR/2008/REC-xml-20081126/

While there are many possibilities to represent a model of an Asset Administration Shell in XML, we provide our "official" XML schema definition ([XSD]) to foment interoperability between different tools and systems.

[XSD]: https://www.w3.org/TR/xmlschema-0/

Below we explain in more detail how our schema is constructed, point the user to the examples and finally give some background information on our particular schema design.

## Top-Level Structure

The root element of our XML is an XML element representing the instance of [Environment].
This environment contains three aggregations, corresponding to all [Identifiable] classes:

* [AssetAdministrationShell]'s,
* [Submodel]'s, and
* [ConceptDescription]'s.

[Environment]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=82

[Identifiable]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=51

[AssetAdministrationShell]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=57

[Submodel]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=61

[ConceptDescription]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=81

To simplify exploration of the XML data, identifiable instances are only available at the level of the environment, and nowhere else.

We now continue to see how to serialize the instances and their properties.

## Mapping Rules

Building blocks of an XML document include only [XML elements], [XML attributes] and [text enclosed in an element].
XML elements can nest children elements.
Using these building blocks, we map an AAS model to XML.

[XML elements]: https://www.w3schools.com/xml/xml_elements.asp

[XML attributes]: https://www.w3schools.com/xml/xml_attributes.asp

[text enclosed in an element]: https://www.w3schools.com/xml/xml_elements.asp

### UML Property to XML Element

Before we look into how to represent instances of classes, let us start bottom-up and see first how individual properties are represented.

We represent each property of a class with an XML element whose name corresponds to the property in the meta-model.
The name is given in camel-case where all abbreviations are left as capitalized (``dataSpecificationIec61360`` instead of ``dataSpecificationIEC61360``).

It is common in UML to use singular form for aggregations, which is the case for the meta-model.
This is, however, in contrast to programming code, where plural form for sequences is common.
Since the naming of XML elements has direct influence on the programming code, we name the properties in plural form diverging from the name in the meta-model. 
For example, ``submodelElements`` instead of ``submodelElement`` in case of [Submodel/submodelElement] property in the meta-model.

[Submodel/submodelElement]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=61

In cases where plural form made no sense for a property, we kept it as-is in singular form (*e.g.*, `isCaseOf`).
The full list of exceptions is available [as code in aas-core-meta].

[as code in aas-core-meta]: https://github.com/aas-core-works/aas-core-meta/blob/95055a55a8c8f60d75fb48c26eb932ff99945dd2/tests/test_v3rc2.py#L1122

### Why no XML attributes?

While some meta-model properties are indeed very apt to be succinctly represented as XML attributes, we decided *not* to use XML attributes at all for three reasons.

First, the XML attribute must be a string, and therefore does not allow for structured data to be represented with it.
As the meta-model evolves, we need to be able to gracefully evolve the schema with as little breakages as possible.
An XML attribute puts a limit in so far that an attribute can only be represented as string.
Moreover, as the schema evolves, making [diff]'s is important to trace the changes.
This is much harder when the attributes switch from an XML attribute to an XML element.

[diff]: https://en.wikipedia.org/wiki/Diff

Second, many classes contain a mix of primitive properties and structured properties.
If we allowed XML attributes, the former would be represented as XML attributes, while the latter would be represented as XML elements.
This leads to confusion where the writer is forced to go back and forth in the specification, and always double-check whether a property should be represented as an XML attribute or an XML element.

Third, we automatically generate the schema from a machine-readable meta-model representation (see Section [Background] below).
The mix of XML attributes and elements would have complicated the code and prolonged the development.

[Background]: #Background

We finally decided that the drawbacks outlined above outweighed the advantage in form of succinct representation.

### Optional Properties

If a property has cardinality ``0..1`` or ``0..*`` and is not specified in the instance, the element is simply omitted.

### Properties of Simple Data Types

The property values given in the meta-model as simple data types (see Section [5.7.12 Primitive and Simple Data Types] of the meta-model) are serialized as text enclosed in the XML element corresponding to the property.
Please see Section [Why no XML attributes?] on why we do not serialize them as XML attributes.

[5.7.12 Primitive and Simple Data Types]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=95
[Why no XML attributes?]: why-no-xml-attributes

The byte arrays (``BlobType`` in meta-model) are serialized as Base64-encoded text.

Simple type ``rdf:langString`` is serialized as if it were a proper meta-model class with properties ``language`` and ``text``.
See the following Section [Instances of Classes as Attribute Values] about how to serialize instances of classes in general as that section directly applies to ``rdf:langString``.

[Instances of Classes as Attribute Values]: #Instances-of-Classes-as-Attribute-Values

### Instances of Classes as Property Values

To serialize instances of meta-model classes as values of properties, we need to nest them somehow within the XML element corresponding to the property.
This is not as trivial as it seems.

If the property type is a concrete or abstract class with descendants, the deserializer needs to know the exact concrete class at the time of de-serialization.
However, this information is obviously missing in the meta-model.
For example, the property [Submodel/submodelElement] tells the deserializer that its items are instances of [SubmodelElement], but the deserializer does not know which *concrete* deserialization method to apply to understand the nested XML data: is it [Property], [Range] or some other descendant of [SubmodelElement]?

[Submodel/submodelElement]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=61

[SubmodelElement]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=62

[Property]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=75

[Range]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=76

Therefore, the information about the concrete type of the serialized instance must be encoded somehow in XML when the type in the meta-model is too vague.
This nugget of information is usually called a *discriminator* (*e.g.*, see [OpenAPI 3 specification on polymorphism]).

[OpenAPI 3 specification on polymorphism]: https://swagger.io/docs/specification/data-models/inheritance-and-polymorphism/

On the other hand, when the meta-model mandates the type of property as a concrete class without descendants, the deserializer needs no additional information as the deserialization method is given by the meta-model.
There is thus no need to include the discriminator in the serialization, and a redundant discriminator would only clutter the XML document.

We therefore distinguish two serializations of instances: one with discriminator, and one without, respectively.

#### Instances Serialized with Discriminator

We use the XML element named according to the concrete class at the serialization as the discriminator.
The properties of the instance are nested below this discriminator XML element.

Let us make an example.
The example will be agnostic of the particular meta-model version, so that it can age well across different versions.
We fantasize a meta-model class `SomeAbstractClass` and assume it has two descendant classes, `SomeConcreteClass` and `AnotherConcreteClass`.
Let us assume yet another class, `YetAnotherClass`, entails the property `someProperty` of type `SomeAbstractClass`.

Here is how the XML structure corresponding to `YetAnotherClass/someProperty` would look like in this fantasized case, where the value is an instance of `SomeConcreteClass`:

```xml

<someProperty>
    <SomeConcreteClass>
        <!-- 
            Serialized properties of SomeConcreteClass 
        -->
    </SomeConcreteClass>
</someProperty>
```

If the value is an instance of `AnotherConcreteClass`, the serialization becomes:

```xml

<someProperty>
    <AnotherConcreteClass>
        <!--
            Serialized properties of AnotherConcreteClass
        -->
    </AnotherConcreteClass>
</someProperty>
```

The abstract class, `SomeAbstractClass`, does not show up in the serialization at all, as it is redundant information.

While this approach is succinct in terms of additional XML elements, but it comes with a caveat.
Namely, if we introduce descendants to `AnotherConcreteClass`, the property `someProperty` becomes polymorph, and we need to introduce backwards-incompatible schema changes to allow for the [discriminator]. 

#### Instances Serialized without Discriminator

If the concrete type of the property at deserialization is unambiguous by the meta-model, we omit the discriminator to reduce the clutter.
The instance is simply serialized as a sequence of XML elements corresponding to its properties.

Let us fantasize yet another example, similar to the one in Section [Instances Serialized with Discriminator].
We will again draw an example such that it is agnostic of meta-model version for better evolution of this Readme.
Assume a class `SomeClass` with a property `SomeClass/someProperty`.
Now imagine the type of `someProperty` to be the class `AnotherClass`.
The class `AnotherClass` has properties `AnotherClass/anotherProperty` and `AnotherClass/yetAnotherProperty`.
The class `AnotherClass` has no descendants, so the concrete type of `SomeClass/someProperty` is unambiguous.

[Instances Serialized with Discriminator]: #Instances-Serialized-with-Discriminator

Here is how the XML structure would look like:

```xml

<someProperty>
    <anotherProperty>
        <!-- ... -->
    </anotherProperty>
    <yetAnotherProperty>
        <!-- ... -->
    </yetAnotherProperty>
</someProperty>
```

The type information about `AnotherClass` is omitted, as the type of the `SomeClass/someProperty` is fixed in the meta-model.

### Properties as Aggregations

Many properties in the meta-model do not represent a single value (be it primitive or structured as a class), but aggregate instances of meta-model classes.
For example, [Submodel/submodelElement] aggregates instances of [SubmodelElement]'s.

If we just concatenated all the properties of the instances, we would not know which property belongs to which instance (or such distinction would be complicated).
We need a delimiter!

Following the approach described in Section [Instances Serialized with Discriminator], we delimit the instances simply by nesting them beneath the discriminator elements.
If the type of the list items is a concrete class, we nest beneath the discriminator element regardless.

For example, here is an XML snippet of an example submodel elements, where the first element is a [Property], the second one is a [Range] and the third is a [Property]:

```xml

<submodel>
    <submodelElements>
        <!-- First element -->
        <property>
            <!-- ... some properties ... -->
        </property>

        <!-- Second element -->
        <range>
            <!-- ... another properties ... -->
        </range>

        <!-- Third element -->
        <property>
            <!-- ... yet another properties ... -->
        </property>
    </submodelElements>
</submodel>
```

We explicitly forbid empty lists in XML to avoid confusion about properties of cardinality ``0..*``.
Namely, an empty list is semantically equal to an omitted property (according to the meta-model).
Thus, the XML element representing an aggregation must be omitted if the aggregation is empty.

The following snippet is therefore invalid:

```xml

<submodel>
    <submodelElements/>
    <!-- other properties -->
</submodel>
```

... and should be written as:

```xml

<submodel>
    <!-- other properties -->
</submodel>
```

### Order of the Properties

We fixed the order of the properties to match the meta-model for readability.

This is reflected in usage of `xs:sequence` throughout the XML schema.

### Enumerations

Enumerations are serialized according to the exact values of enumeration literals in the meta-model as text.

For example, the enumeration literal [EntityType/CoManagedEntity] is serialized as ``CoManagedEntity``, while the literal [Direction/input] as ``input``.

[EntityType/CoManagedEntity]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=71

[Direction/input]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=66

### Embedded Data Specifications

There is an abstract definition of data specifications as templates in the meta-model ( see Section [6 Predefined Data Specification Templates]).
This definition does not specify, though, how to access them from within an [Environment], which is a requirement for many systems.
To address this practical issue, the meta-model indicates that they should be embedded in serializations (see Section [9.2.5 Embedded Data Specifications]).

[6 Predefined Data Specification Templates]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=106

[9.2.5 Embedded Data Specifications]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=150

We therefore add additional XML element, named `embeddedDataSpecifications`, in the XML representations of [HasDataSpecification] class, and omit `dataSpecification` property by design.
The embedded data specifications are serialized just as all the other classes of the meta-model, following the procedure outlined above.

[HasDataSpecification]: https://www.plattform-i40.de/IP/Redaktion/DE/Downloads/Publikation/Details_of_the_Asset_Administration_Shell_Part1_V3.pdf?__blob=publicationFile&v=10#page=56

### Namespace

The XML elements representing the AAS model are explicitly required to live in our namespace.
The namespace corresponds to the version of the meta-model.

For example, the serialization for the meta-model `V3.0RC02` lives in the namespace `https://admin-shell.io/aas/3/0/RC02`.

## Structure of the Schema

XML schemas tend to grow very complex, very quickly.
Our schema is no exception.
While we described so far how an XML document looks like for a concrete AAS model, let us briefly give you an overview of the schema beneath it.

At this point, we only outline its structure in broad brushes.
Please refer to the actual file [schema/xml/AAS.xsd](AAS.xsd) for more details.

For each class, we define a `xs:group` which lays out the order (as a nested `xs:sequence`) and type of the XML elements corresponding to the properties of the class.
The inheritance is dealt by nesting an additional `xs:group` element within the sequence with the `ref` attribute.

The individual properties are defined with `xs:element` in the `xs:sequence`.

For example:

```xml

<xs:group
        name="administrativeInformation">
    <xs:sequence>
        <xs:group
                ref="hasDataSpecification"/>
        <xs:element
                name="version"
                minOccurs="0"
                maxOccurs="1">
            <xs:simpleType>
                <xs:restriction
                        base="xs:string">
                    <xs:minLength
                            value="1"/>
                </xs:restriction>
            </xs:simpleType>
        </xs:element>
        <!-- ... More elements come here ... -->
    </xs:sequence>
</xs:group>
```

For each class, we define a `xs:complexType`, name it with an `_t` prefix and refer the complex type to the corresponding group.
The complex types are necessary so that we can use them to specify aggregations.

For example, here is the definition of `submodel_t`:

```xml

<xs:complexType
        name="submodel_t">
    <xs:sequence>
        <xs:group
                ref="submodel"/>
    </xs:sequence>
</xs:complexType>
```

Here it is used in the definition of the aggregation:

```xml

<xs:group
        name="environment">
    <!-- ... -->
    <xs:element
            name="submodels"
            minOccurs="0"
            maxOccurs="1">
        <xs:complexType>
            <xs:sequence>
                <xs:element
                        name="submodel"
                        type="submodel_t"
                        minOccurs="1"
                        maxOccurs="unbounded"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <!-- ... -->
</xs:group>
```

If a class has one or more descendants, we define an `xs:group` with the `_choice` suffix.
This is necessary so that we can enforce a closed set of concrete classes at the de/serialization.
In particular, we want to ensure that the discriminator is given correctly (see Section [Instances Serialized with Discriminator]).

Here is an example of a choice:

```xml

<xs:group
        name="submodelElement_choice">
    <xs:choice>
        <!-- ... -->
        <xs:element
                name="property"
                type="property_t"/>
        <xs:element
                name="range"
                type="range_t"/>
        <!-- ... -->
    </xs:choice>
</xs:group>
```

Here the choice is enforced in another group:

```xml

<xs:group
        name="submodel">
    <xs:sequence>
        <!-- ... -->
        <xs:element
                name="submodelElements"
                minOccurs="0"
                maxOccurs="1">
            <xs:complexType>
                <xs:sequence>
                    <xs:group
                            ref="submodelElement_choice"
                            minOccurs="1"
                            maxOccurs="unbounded"/>
                </xs:sequence>
            </xs:complexType>
        </xs:element>
    </xs:sequence>
</xs:group>
```

## Examples

Examples of the XML serializations can be found in [schemas/xml/examples/](examples) folder.

## Background

### Handwritten Schema

When we started with the project, the schema had been manually written.
One or two schema designers would sit down, follow the book and translate it into XML schema by best effort.
This allowed for a lot of artistic freedom, but eventually caused problems due to mismatches with other serializations or internal inconsistencies.
Especially as the meta-model evolved, maintaining the schema and keeping it up-to-date with the meta-model proved to be difficult.

### Generated Schema

While the handwritten schema is arguably elegant, the maintenance is too demanding.
Therefore, we developed a schema generator based on the machine-readable representation of the meta-model.
The generator is provided in [aas-core-codegen] project, while the meta-model lives in [aas-core-meta].

[aas-core-meta]: https://github.com/aas-core-works/aas-core-meta

[aas-core-codegen]: https://github.com/aas-core-works/aas-core-codegen

This allowed us to evolve the XML schema more quickly while keeping it in sync with other serialization schemas and SDKs.
However, we had to give up on elegant parts of the schema, and had to straightjacket the schema into form that can be programmatically generated.
For example, all properties are serialized as XML elements, and we could not use XML attributes.
