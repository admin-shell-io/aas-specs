# XML 
For plain data transfair via import and export the metamodel of an AssetAdministration Shell needs to be serialized. One possible serialization format is XML. 

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

## Top-Level Structure of Asset Administration Shell Environment
One serialization describes one AAS environment that is a collection of Administration Shells. The root element of the AssetAdministration Shell environment has 5 aggregations. AssetAdministrationShells, Assets, Submodels, ConceptDescriptions and Data Specifications. For each identifiable class, one aggregation is featured.
  
![Top level structure of an AssetAdministration Shell environment mapped to XML Schema](https://user-images.githubusercontent.com/1814815/147119644-81e19bbf-86cb-41f8-bc56-2f8aca4fb60e.png) 

Note: XSD structuring was done with Eclipse tool chain

## XML MappingRules
The main concepts of the XML schema and the resulting XML serialization are explained by the following rules. The first 6 Rules are general rules, while the following rules specific to References.

- XSD global Types are used for modeling. For reusability XSD global types will be used for modeling. There will be a naming convention <informationModelName>+’_t’
- If present, names are taken from the information model. For comprehensibility reasons the XML key names should be the same as the representing Element in the metamodel. 
- All identifiables have an aggregation on root level of the enviorment. The identifiables are AssetAdministrationShells, Assets, Submodels, ConceptDescriptions and Data Specifications. To reduce redundant instances, they are located exclusively in the top-level aggregation. 
- The schema definitions of the environment are separated by the main aspects in 3 files. AAS Metamodel with in AssetAdministrationShells, Assets, Submodels in aas.xsd, Security of the AAS in AAS_ABAC.xsd, Semantics of the AAS with ConceptDescriptions and DataSpecifications in IEC61360.xsd
- Data Specifications in the environment is a collection of either references to the Data Specification Content of the corresponding Data Specification Templete or arbitrary Data Specification as xsd:anyType. 
- Repeating elements and their types will get the same names of their instances in plural. Exception: SubmodelElementCollection, here the name remains “value”. If the element has a cardinality of n>1 a parent element will be used with the name of the element in plural. For example, each element in the aggregation assets needs to be an asset. 
- Identifiables which are not in the top-level aggregations are only references to the corresponding instances in one of the top-level aggregations. There should be no redundant identifiable in the serialized metamodel. 
- For elements with type LangStringSet an aggregation element called langStringSet_t is added. For the single element a language tag “lang” is added. For internationalization purposes this rule is necessary.
- The attributes of a key in a reference except for the value itself are realized as XML attributes.
- Attribute based access control is added as a separate XML schema that is linked by AssetAdministrationShell/security


The results of the mapping rules and environment definition for XML is displayed in this [minimal XML example](examples/minimum.xml):
```XML
<?xml version="1.0" encoding="UTF-8"?>
<aas:aasenv xmlns:aas="http://www.admin-shell.io/aas/3/0"
	xmlns:abac="http://www.admin-shell.io/aas/abac/3/0" xmlns:aas_common="http://www.admin-shell.io/aas_common/3/0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:IEC="http://www.admin-shell.io/IEC61360/3/0"
	xsi:schemaLocation="http://www.admin-shell.io/aas/3/0 AAS.xsd http://www.admin-shell.io/IEC61360/3/0 IEC61360.xsd http://www.admin-shell.io/aas/abac/3/0 AAS_ABAC.xsd">
	<aas:assetAdministrationShells></aas:assetAdministrationShells>
	<aas:assets></aas:assets>
	<aas:conceptDescriptions></aas:conceptDescriptions>
	<aas:dataSpecifications></aas:dataSpecifications>
	<aas:submodels></aas:submodels>
</aas:aasenv>
```  
  
Further examples are in the [example folder](examples)
