# Examples of the AAS meta model in RDF

##	Example Overview
RDF is often regarded as a graph model, as it provides the flexibility to interlink entities at any stage. In the following, the running example is originally provided in Turtle but accompanied with visualizations of the represented graph. Attributes referencing non-literal values are shown as directed links while Literal values are drawn together with the corresponding entity itself. In order to increase readability, the namespace declarating sections  are omitted. The instances of the core classes, the AssetAdministrationShell, the Asset, Submodels, and ConceptDescriptions are shown in the figure below. The AssetAdministrationShell is provided in the [RDF file](rdf-ontology.ttl). The RDF identifiers are visualized in a condensed format in the figure but represent complete URIs, as displayed in Table 18.One can see the additionally inserted triples for rdf:type (1), rdfs:label (2), and rdfs:comment (3) as determined by Rule 4. The first attribute states the instance’ class. The second provides its commonly used name, for instance based on the idShort attribute.  rdfs:comment supplies a short description about the regarded entity, based on the description value. The generally available tools, for instance the open source tool Protégé, interpret these attributes and display the correct class hierarchy, render the elements with their labels or supply short explanations based on the comments.

![Simplified graph of the core classes in the example](https://user-images.githubusercontent.com/1814815/147125320-3f8486d0-6269-48b6-b1ae-645db7a0bf33.png)

## Example Schema Shape
The Shapes Constraint Language (SHACL) [38] introduces a W3C recommendation for validation mechanisms on RDF graphs. The definition of required attributes, cardinality of relations or datatype restrictions in the form of shapes (see Table 19 for an example shape) is an important aspect to enable data quality assurance in any productive system. Some tools are already created to assist the creation of SHACL shapes, e.g. a Protégé plugin and as a part of TopBraid Composer. As SHACL shapes are also defined in RDF, they share the same format and thereby reduce the required technology stack and reduces the amount of necessary libraries.
The example can be found [here](AAS_Reference_shortExample.ttl).

##	IRI Mapping
Every enitiy in RDF is either a Resource or a Literal. While Literals present data values, like strings, numbers or any sequence of characters, Resources represent the nodes and edges in the data graph. As Resources must be identified through IRIs (preferable even URIs), the creation of suitable IRIs is fundamental for the mapping. Whenever resources of an AAS are already identified through IRIs (see also Section 4.4.6), these IRIs/URIs are also utilized in the RDF model. However, in cases where no IRI is given, a defined procedure has to be followed. The following decision steps determine the necessary steps in order to create an unambiguous IRI for every element of the AAS. 
These steps are only executed once per distinct element. If elements occur more than one time, always the same IRI identifier has to be used. This is especially relevant for the fallback solution (2b and 3) where the initial character sequence must be reused. Different elements must not get the same sequence under any circumstances.

1.	If the element has IdentifierType = "IRI":  
Use the value of the identification attribute, else: 
2.	If the enclosing AAS has an IdentifierType = "IRI":
  a.	If  the element inherits from Referable: Apply the template:   
  <AAS identification URI>/<path/to/element>/<idShort>, where the path to the element is the concatenation of the respective idShorts separated by slashes, else:
  b.	Apply the template:   <AAS identification URI>/<path/to/element>/<random characters>
3.	Use randomized character sequence: <scheme>://<random characters>

##	Example Mapping
Several mapping languages have been created in order to transform structured data into RDF graphs. Most prominently, R2RML (relational data only) and RML (relational data, XML, JSON, etc.) are used to specify the necessary mappings. A RML mapping can be used to transform a given Asset Administration Shell from its XML or JSON serialization to any potential RDF serialization. The snippet in Table 20 illustrates an RML TriplesMap used to convert the XML example from Annex E. The AssetAdministrationShell elements are iterated (rml:logicalSource) and, among others, all relations to referenced Submodels are extracted (rr:predicateObjectMap).
The example can be found [here](AssetAdministrationShell_Example.ttl).

##	Example Submodel with Property
Submodels contain the relevant information for a use case. Figure 93 shows the Identification Submodel with the Property containing the manufacturer of the asset. In the RDF terminology, every relation actually is called a property. In the data model of the Asset Administration Shell however, a Property is a defined sub class of the SubmodelElement. The distinction is made through the namespace: rdf:Property for every relation, aas:Property for certain SubmodelElements (see Table 20).

![Graph of the relations between a Submodel (F13E8576F6488342) and a Property (Manufacturer)](https://user-images.githubusercontent.com/1814815/147669163-c0147930-204c-40ed-aa32-9773795cb19d.png)

The example can be found [here](Submodel_SubmodelElement_Example.ttl).

##	Example MultiLanguage String
The Identification Submodel in Table 22 has two descriptions, one in English and one in German. RDF proposes the usage of LangStrings, typed Literals with a language tag. Table 23 illustrates, how Rule 7 leads to different object values.
The example can be found [here](AAS_Reference_shortExample.ttl).

##	Example Concept Description
A Concept Description defines the meaning of the entities used in the Asset Administration Shells, Assets, and Submodels. Table 24 illustrates a description for the organization name of a constant. The core building blocks of the example are the reference to the data specification key (1), the actual content conforming to IEC 61360 (2), and the reference to the actual identifier in the previously used elements (3).
The example can be found [here](ConceptDescriptionExample.ttl).
