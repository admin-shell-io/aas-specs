In this section it is described how to extend the schema with new data specification templates. 

Please note: proprietary extensions should be avoided. Proprietary extensions can only be used if the user or receiver of the AAS bilaterally knows about the extensions and can support them as well. The other way around there is no problem: Internally, extensions can be used if senders only provide AAS without these proprietary extensions.

For extensions the following three steps need to be done (compare with data specification template for IEC61360):

1.	**Create schema with data type for new data specification** (example yourDataSpecification_t). For proprietary data specifications an own name space (example: http://yournamespace with prefix yourNS) needs to be defined and all data specifications of the same name space should be added to this file (example yourNS.xsd). 
2.	**Extend complex type dataSpecificationContent_t in AAS_dataSpecificationContent.xsd with new type defined in step 1.** 
```XML
<complexType name="dataSpecificationContent_t">
  <choice>
    <element name="dataSpecificationIEC61360" type="IEC61360:dataSpecificationIEC61630_t"/>
    <element name="yourDataSpecification" type="yourNS:yourDataSpecification_t">
  </choice>
</complexType>
```
3.	**Add new schema** (if not yet contained) to the schema declaration section of AAS_dataSpecificationConent.xsd 
```XML
<?xml version="1.0" encoding="UTF-8"?>
<schema targetNamespace="http://www.admin-shell.io/AAS/dataSpecificationContent/x/y" elementFormDefault="qualified" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:tns="http://www.admin-shell.io/AAS/dataSpecificationContent/x/y" xmlns:IEC61360="http://www.admin-shell.io/IEC61360/3/0" xmlns:yourNS="http://yournamespace" xmlns:Q1="http://www.admin-shell.io/aas/3/0">
<import namespace="http://www.admin-shell.io/IEC61360/3/0" schemaLocation="IEC61360.xsd"/>
<import namespace="http://yournamespace" schemaLocation="yourNS.xsd"/>
....
</schema>
```
