# Examples of the AAS meta model

**TODO (@mristin, 2022-04-09)**: We need to update this README once the schema has been fixed.
In particular, we have to update the references to the examples.

## Example for Top-Level Structures
One serialization describes one Asset Administration Shell environment, that is, a collection of Administration Shells. The root element of the Asset Administration Shell environment has 4 aggregations. For each identifiable class, one aggregation is provided, as required by rule 3.

![Top level structure of an AssetAdministration Shell environment mapped to JSON](https://user-images.githubusercontent.com/1814815/147122261-ac77deea-e83e-422d-bff5-f005feaf98d4.png)

The resulting JSON is the [minimal valid JSON.](miniJsonExample.json)

##	Examples for References to Identifiables
As required by rule 4, Identifiables are only allowed to be located in the top-level aggregations. In deeper parts of the structure only References to the corresponding Identifiable must be taken. 
In the Asset Administration Shell AAS1, the submodel S1 is only a Reference to the Submodel S1 instance in the top level Submodels aggregation. 

![Submodel reference in AssetAdministrationShell for JSON](https://user-images.githubusercontent.com/1814815/147664807-91ff8c36-6ddd-4b25-88bb-8048483ff30f.png)

This results in the [exemplary JSON.](ReferencesJsonExample.json)

A ReferenceElement has a Reference as value. This Reference has an aggregation of keys which represents a key chain. The resolved key chain points to an element. In this example the ReferenceElement’s value points to a property of another submodel in another Asset Administration Shell environment. The first key is a global key with “local”-attribute set to false, i.e. the reference is not part of the own environment. The second key is a model key which is used to define the corresponding property in the other environment by its IdShort. It is best practice to use the shortest key chain if there are multiple options. 

![Usage of ReferenceElement in JSON](https://user-images.githubusercontent.com/1814815/147664989-3f76ac5d-3c4b-4854-afe8-3e1e2d0db527.png)

This results in an [exemplary JSON.](ReferenceElement.json)

##	Examples for GlobalReference
Sometimes it is useful to refer to another standard or something that is not provided by the own Asset Administration Shell environment. In this example the semantics of a Property refers to ECLASS. 

![Usage of GlobalReference in JSON](https://user-images.githubusercontent.com/1814815/147665086-1727a769-8a76-4b10-b22e-6d30beae6486.png)

This results in an [exemplary JSON.](GlobalReference.json)
