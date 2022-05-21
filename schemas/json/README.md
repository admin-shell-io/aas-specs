# JSON
In the following repository an overview of the main concepts of the Asset Administration Shell [JSON](https://tools.ietf.org/html/rfc8259) serialization is presented. For import and export scenarios the metamodel of an Asset Administration Shell needs to be serialized. A serialization format is JSON (JavaScript Object Notation). The JSON files follow the schema version [2019-09](https://json-schema.org/specification-links.html#2019-09-formerly-known-as-draft-8).

## Top-Level Structure of Asset Administration Shell Environment
One serialization describes one AAS environment, that is, a collection of Administration Shells. The root element of the Asset Administration Shell environment has 5 aggregations. AssetAdministrationShells, Assets, Submodels, ConceptDescriptions and Data Specifications. For each identifiable class, one aggregation is provided, as required by rule 3.

![Top level structure of an AssetAdministration Shell environment mapped to JSON](https://user-images.githubusercontent.com/1814815/147122261-ac77deea-e83e-422d-bff5-f005feaf98d4.png)

## JSON Mapping Rules


**TBD:**

The concepts of the JSON definition and the derived JSON serialization of the AAS are explained by the mapping rules. 
These rules are implemented by the [generators](https://github.com/aas-core-works/aas-core-codegen) used to create the schemata based on the independet project [aas-core-works](https://github.com/aas-core-works/). 
The main design principals are documented in this section by the following rules:

- If present, names are taken from the information model. For comprehensibility reasons, the JSON key names should be the same as the representing Element in the metamodel. 
- Each *Referable*, *Qualifier* and *Formula* have an additional attribute “*modelType*” with the name of the corresponding object class as value This rule is needed for deserialization reasons. . 
- The schema definitions of the environment are separated by the main aspects in 3 files. AAS Metamodel with in AssetAdministrationShells, Submodels in AAS.json, Security of the AAS in AAS_ABAC.json, Semantics of the AAS with ConceptDescriptions and DataSpecifications conformant to IEC61360 in IEC61360.json.
- *Identifiable*s which are not in the top-level aggregations *Environment* are only references to the corresponding instances in one of the top-level aggregations.
There should be no redundant identifiable in the serialized metamodel. 
- **TBD:** *Submodel/submodelElements* and *SubmodelElementCollection/value* are realized as objects, not as sets to be conformant to the semantics of these elements.
- The concept of embedded Data Specifications is realized. This means, for elements inheriting from *hasDataSpecification* a new element *EmbeddedDataSpecification* is introduced that has two attributes: one for the global reference to the data specification template via its identifier and one for the content of the data specification.

The results of the mapping rules and environment definition for JSON is displayed in this [minimal valid JSON example.](examples/miniJsonExample.json) 
```JSON
{  
   "assetAdministrationShells":[  ],
   "submodels":[  ],
   "conceptDescriptions":[  ],
}
```  

More examples in the [example folder.](examples)


