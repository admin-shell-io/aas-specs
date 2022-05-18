# XML 

**TODO (@mristin, 2022-04-09)**: We need to update this README once the schema has been fixed.

For plain data transfer via import and export the metamodel of an Asset Administration Shell needs to be serialized. One possible serialization format is XML. 

## Introduction
eXtensible Markup Language ([XML](https://www.w3.org/TR/2008/REC-xml-20081126/)) is very well suited to deriving information from an IT system, perhaps to process it manually, and then to feed it into another IT system. It therefore meets the needs of the information sharing scenarios. XML provides for the possibilities of scheme definitions which can be used to syntactically validate the represented information in each step. For this reason, this document provides basic scheme definitions to permit a validation of information which is shared.

The XML schema definitions are divided into three different files:
- Core definitions for the AssetAdministration Shell and its export container: aas.xsd
  - Namespace: "http://www.admin-shell.io/aas/3/0"
- IEC61360 datatype definition: iec61360.xsd
  - Namespace: "http://www.admin-shell.io/IEC61360/3/0"
- Attributed based access control definition: aas_abac.xsd
  - Namespace: "http://www.admin-shell.io/aas/abac/3/0"

The namespace reflects the current version (3.0) of the specification.

## Top-Level Structure of Asset Administration Shell Environment

## XML MappingRules
The concepts of the XML schema and the derived XML serialization of the AAS are explained by the mapping rules. These rules are implemented by the [generartors](https://github.com/aas-core-works/aas-core-codegen) used to create the schemata based on the idependet project [aas-core-works](https://github.com/aas-core-works/). The main design princials are dokumentes in this section by folloing rules. The first 6 Rules are general rules, while the following rules specific to References.

- XSD global Types are used for modeling. For reusability XSD global types will be used for modeling. There will be a naming convention <informationModelName>+’_t’
- If present, names are taken from the information model. For comprehensibility reasons the XML key names should be the same as the representing Element in the metamodel. 
- All identifiables have an aggregation on root level of the enviorment. The identifiables are *AssetAdministrationShell*s, *Submodel*s and *ConceptDescription*s. They are located exclusively in the top-level aggregation *Environment*. 
- The schema definitions of the environment are separated by the main aspects in 3 files. AAS Metamodel with in *AssetAdministrationShell*s, *Submodel*s in aas.xsd, Security/ABAC (attribute based access control) of the AAS in AAS_ABAC.xsd, Semantics of the AAS with ConceptDescriptions and DataSpecifications conformant to IEC61360 in IEC61360.xsd.
- Repeating elements and their types will get the same names of their instances in plural. Exception: *SubmodelElementCollection*, here the name remains “value”. If the element has a cardinality of n>1 a parent element will be used with the name of the element in plural. For example, each element in the aggregation *Environment/submodels* needs to be a *submodel*. 
- Identifiables which are not in the top-level aggregation *Environment* are only references to the corresponding instances in one of the top-level aggregations. There should be no redundant identifiable in the serialized metamodel. 
- For elements with type *LangStringSet* an aggregation element called *langStringSet_t* is added. For the single element a language tag “*lang*” is added. For internationalization purposes this rule is necessary.
- The attributes of a key in a reference except for the value itself are realized as XML attributes.
- The concept of embedded Data Specifications is realized. Data Specification Templates are embedded as choice of data specification to all elements inheriting from abstract class *HasDataSpecification*. Note: In Future data specifications should be added to the elements they are allowed for, e.g. data specification IEC61360 is allowed for Concept Descriptions only
- For *Formula*s a mixed type is used because text and references can be mixed


The results of the mapping rules and environment definition for XML is displayed in this [minimal XML example](examples/minimum.xml):
```XML
<?xml version="1.0" encoding="UTF-8"?>
<aas:aasenv xmlns:aas="http://www.admin-shell.io/aas/3/0"
	xmlns:abac="http://www.admin-shell.io/aas/abac/3/0" xmlns:aas_common="http://www.admin-shell.io/aas_common/3/0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:IEC="http://www.admin-shell.io/IEC61360/3/0"
	xsi:schemaLocation="http://www.admin-shell.io/aas/3/0 AAS.xsd http://www.admin-shell.io/IEC61360/3/0 IEC61360.xsd http://www.admin-shell.io/aas/abac/3/0 AAS_ABAC.xsd">
	<aas:assetAdministrationShells></aas:assetAdministrationShells>
	<aas:conceptDescriptions></aas:conceptDescriptions>
	<aas:submodels></aas:submodels>
</aas:aasenv>
```  
  
Further examples are in the [example folder](examples)
	
## Adding Data Specification Templates
	
In this section it is described how to extend the schema with new data specification templates. 
Please note: proprietary extensions should be avoided. Proprietary extensions can only be used if the user or receiver of the AAS bilaterally knows about the extensions and can support them as well. The other way around there is no problem: Internally, extensions can be used if senders only provide AAS without these proprietary extensions.
	
For extensions the following three steps need to be done (compare with data specification template for IEC61360):
1.	Create schema with data type for new data specification (example yourDataSpecification_t). For proprietary data specifications an own name space (example: http://yournamespace with prefix yourNS) needs to be defined and all data specifications of the same name space should be added to this file (example yourNS.xsd). 

2.	Extend complex type dataSpecificationContent_t in AAS_dataSpecificationContent.xsd with new type defined in step 1. 

```XML
<complexType name="dataSpecificationContent_t">
  <choice>
    <element name="dataSpecificationIEC61360" type="IEC61360:dataSpecificationIEC61630_t"/>
    <element name="yourDataSpecification" type="yourNS:yourDataSpecification_t">
  </choice>
</complexType>
``` 
	
3.	Add new schema (if not yet contained) to the schema declaration section of AAS_dataSpecificationConent.xsd 

```XML
<?xml version="1.0" encoding="UTF-8"?>
<schema targetNamespace="http://www.admin-shell.io/AAS/dataSpecificationContent/x/y" elementFormDefault="qualified" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:tns="http://www.admin-shell.io/AAS/dataSpecificationContent/x/y" xmlns:IEC61360="http://www.admin-shell.io/IEC61360/3/0" xmlns:yourNS="http://yournamespace" xmlns:Q1="http://www.admin-shell.io/aas/3/0">
<import namespace="http://www.admin-shell.io/IEC61360/3/0" schemaLocation="IEC61360.xsd"/>
<import namespace="http://yournamespace" schemaLocation="yourNS.xsd"/>
....
``` 

