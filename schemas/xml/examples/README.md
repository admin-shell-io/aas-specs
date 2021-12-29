# XML examples of the AAS meta model

## Example for Top-Level Structures
One serialization describes one asset Administration Shell environment that is a collection of Administration Shells. The root element of the AssetAdministration Shell environment has 4 aggregations. For each identifiable class, one aggregation is featured, as required by rule 3.
  
![Top level structure of an AssetAdministration Shell environment mapped to XML Schema](https://user-images.githubusercontent.com/1814815/147119644-81e19bbf-86cb-41f8-bc56-2f8aca4fb60e.png) 

Note: XSD structuring was done with Eclipse tool chain
  
The resulting XML is the [minimal XML](examples/minimum.xml)

## XSD Model Groups
There are a number of attribute groups in the UML model – i.e. identifiable or hasSemantics. These groups are modelled as XSD model groups so they could be reused as anonymous groups in different places. 

Note: Identifier/id is not modelled as attribute but a typical identification looks like this: <aas:identification idType="IRI">www.admin-shell.io/aas-sample/3/0</aas:identification>

![XSD Model Groups](https://user-images.githubusercontent.com/1814815/147664086-fdc4223c-b389-4d30-9b34-ec066f0ca0fd.png)

This is realized in the according XSD as in the [example.](ModelGroups.xml)
Note: 	due to XSD group mechanism, hasDataSpecification maps to an element of embeddedDataSpecification_t and identifiable maps to multiple elements in Figure 81.

##	Keys and References
Keys and References (see Clause 4.7.11) are mapped on the same XML schema construct. Some of the attributes have enumerations defined – these are mapped on string constraints.

![XSD Keys and References](https://user-images.githubusercontent.com/1814815/147664192-0b2dbc09-178f-4bf2-98c4-3980febc1b6e.png)

![XSD Constraints and Qualifiers](https://user-images.githubusercontent.com/1814815/147664214-c2b562e5-836f-4c9e-b752-d009d16ba29e.png)

##	Asset Administration Shell Mapping
Asset Administration Shells are mapped using the following XML Schema construct – it consists of a set of meta data parameters and mostly links to other parts of the XML document or to external elements (based on keys and references).

![Overview XSD assetAdministrationShell_t ](https://user-images.githubusercontent.com/1814815/147664319-e33d2d9a-5de5-4a26-8486-db19962bdd78.png)

##	ConceptDescriptions and EmbeddedDataSpecifications Mapping
As described above, the definition of a concept comprises of an according reference and a content, which is realized by a data specification.

![XSD Concept Description](https://user-images.githubusercontent.com/1814815/147664356-3e5b9dc7-339f-474b-a3e3-4fc3bb80ac6f.png)

The data specification can be e.g. along of an IEC 61360 property:
![XSD Data specification via IEC 61360 property attributes ](https://user-images.githubusercontent.com/1814815/147664411-582eefc9-0786-402b-844e-434333f612ed.png)




