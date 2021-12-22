In the following repository an overview of the main concepts of the Asset Administration Shell [JSON](https://tools.ietf.org/html/rfc8259) serialization is presented. For import and export scenarios the metamodel of an Asset Administration Shell needs to be serialized. A serialization format is JSON  (JavaScript Object Notation).

The main concepts of the JSON serialization are explained by the following rules. 
1.	If present, names are taken from the information model. For comprehensibility reasons the JSON key names should be the same as the representing Element in the metamodel. 
2.	Each Referable, Qualifier and Formula have an additional attribute “modelType” with the name of the corresponding object class as value This rule is needed for deserialization reasons. 
3. All identifiables have an aggregation on root level. The identifiables are AssetAdministrationShells, Assets, Submodels and ConceptDescriptions. To reduce redundancy instances, they are located exclusively in the top-level aggregation. 
4. Identifiables which are not in the top-level aggregations are only references to the corresponding instances in one of the top-level aggregations.
This rule completes the concept of rule 3. There should be no redundant identifiable in the serialized metamodel. 
5.	Data Specification Templates are directly added to the Concept Description. Additionally, a new element EmbeddedDataSpecification is introduced that has two attributes: one for the global reference to the data specification identifier and one for the content of the data specification.
