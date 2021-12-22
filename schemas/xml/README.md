# XML 
For import and export scenarios the metamodel of an AssetAdministration Shell needs to be serialized. A serialization format is XML. 

## Introduction
eXtensible Markup Language ([XML](https://www.w3.org/TR/2008/REC-xml-20081126/)) is very well suited to deriving information from an IT system, perhaps to process it manually, and then to feed it into another IT system. It therefore meets the needs of the information sharing scenario defined in Section 0. XML provides for the possibilities of scheme definitions which can be used to syntactically validate the represented information in each step. For this reason, this document provides basic scheme definitions to permit a validation of information which is shared.

The XML schema definitions are divided into three different files:
- Core definitions for the AssetAdministration Shell and its export container: aas.xsd
  - Namespace: "http://www.admin-shell.io/aas/3/0"
- IEC61360 datatype definition: iec61360.xsd
  - Namespace: "http://www.admin-shell.io/IEC61360/3/0"
- Attributed based access control definition: aas_abac.xsd
  - Namespace: "http://www.admin-shell.io/aas/abac/3/0"

The namespace reflects the current version (3.0) of the specification.

## XML MappingRules
The main concepts of the XML schema and the resulting XML serialization are explained by the following rules. Rules 1 through 6 are general rules, while rules 7 through 11 are specific to References.

1. XSD global Types are used for modeling. For reusability XSD global types will be used for modeling. There will be a naming convention <informationModelName>+’_t’
2. If present, names are taken from the information model. For comprehensibility reasons the XML key names should be the same as the representing Element in the metamodel. 
3. All identifiables have an aggregation on root level. The identifiables are AssetAdministrationShells, Assets, Submodels, ConceptDescriptions. To reduce redundant instances, they are located exclusively in the top-level aggregation. 
4. Repeating elements and their types will get the same names of their instances in plural. Exception: SubmodelElementCollection, here the name remains “value”. If the element has a cardinality of n>1 a parent element will be used with the name of the element in plural. For example, each element in the aggregation assets needs to be an asset. 
5. Identifiables which are not in the top-level aggregations are only references to the corresponding instances in one of the top-level aggregations. This rule completes the concept of rule 3. There should be no redundant identifiable in the serialized metamodel. 
6. (6) For elements with type LangStringSet an aggregation element called langStringSet_t is added. For the single element a language tag “lang” is added. For internationalization purposes this rule is necessary.
7.	The attributes of a key in a reference except for the value itself are realized as XML attributes.
8.	Data Specification Templates are directly added to the Concept Description because up to now only property descriptions are supported. Additionally, a new element EmbeddedDataSpecification is introduced that has two attributes: one for the global reference to the data specification identifier and one for the content of the data specification.
9. Attribute based access control is added as a separate XML schema that is linked by AssetAdministrationShell/security

## Example for Top-Level Structures
One serialization describes one asset Administration Shell environment that is a collection of Administration Shells. The root element of the AssetAdministration Shell environment has 4 aggregations. For each identifiable class, one aggregation is featured, as required by rule 3.
  
![Top level structure of an AssetAdministration Shell environment mapped to XML Schema](https://user-images.githubusercontent.com/1814815/147119644-81e19bbf-86cb-41f8-bc56-2f8aca4fb60e.png) 

Note: XSD structuring was done with Eclipse tool chain
  
The resulting XML is the [minimal XML](examples/minimum.xml)
  
  
