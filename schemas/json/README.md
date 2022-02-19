# JSON
In the following repository an overview of the main concepts of the Asset Administration Shell [JSON](https://tools.ietf.org/html/rfc8259) serialization is presented. For import and export scenarios the metamodel of an Asset Administration Shell needs to be serialized. A serialization format is JSON (JavaScript Object Notation). The JSON files follow the schema version [2019-09](https://json-schema.org/specification-links.html#2019-09-formerly-known-as-draft-8).

## Top-Level Structure of Asset Administration Shell Environment
One serialization describes one AAS environment, that is, a collection of Administration Shells. The root element of the Asset Administration Shell environment has 5 aggregations. AssetAdministrationShells, Assets, Submodels, ConceptDescriptions and Data Specifications. For each identifiable class, one aggregation is provided, as required by rule 3.

![Top level structure of an AssetAdministration Shell environment mapped to JSON](https://user-images.githubusercontent.com/1814815/147122261-ac77deea-e83e-422d-bff5-f005feaf98d4.png)

## JSON Mapping Rules
The main concepts of the JSON serialization are explained by the following rules. 
- If present, names are taken from the information model. For comprehensibility reasons, the JSON key names should be the same as the representing Element in the metamodel. 
- Each Referable, Qualifier and Formula have an additional attribute “modelType” with the name of the corresponding object class as value, This rule is needed for deserialization reasons. 
- All identifiables have an aggregation on the root level of the enviorment. The identifiables are AssetAdministrationShells, Assets, Submodels ConceptDescriptions and Data Specifications. To reduce redundancy of instances, they are located exclusively in the top-level aggregation.
- The schema definitions of the environment are separated by the main aspects in 3 files. AAS Metamodel with in AssetAdministrationShells, Assets, Submodels in AAS.json, Security of the AAS in AAS_ABAC.json, Semantics of the AAS with ConceptDescriptions and DataSpecifications in IEC61360.json.
- Identifiables which are not in the top-level aggregations are only references to the corresponding instances in one of the top-level aggregations.
There should be no redundant identifiable in the serialized metamodel. 
- Data Specifications in the environment is a set of either references to the Data Specification Content of the corresponding Data Specification Templete or arbitrary Data Specification as json objects.

The results of the mapping rules and environment definition for XML is displayed in this [minimal valid JSON example.](examples/miniJsonExample.json) 
```JSON
{  
   "assetAdministrationShells":[  ],
   "assets":[  ],
   "submodels":[  ],
   "conceptDescriptions":[  ],
   "dataSpecifications":[  ]
}
```  

More examples in the [example folder.](examples)