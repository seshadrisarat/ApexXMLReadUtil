# ApexXMLReadUtil
XML Parser for Salesforce Apex

XMLReadUtil is a simlpe utility class that provides an easy way to parse XML documents. The sample XML Doc below will be used to explain how the utility class works. 

```
--- Sample XML Doc -- 
<Root>
  <Node id="node1">
    <Street>1 Node</Street>
    <City>Node1</City>
    <State>N1</State>
    <Residents>
      <Person1>Resident1</Person1>
      <Person2>Resident2</Person2>
    </Residents>
  </Node>
  <Node id="node2">
    <Street>2 Node</Street>
    <City>Node2</City>
    <State>N2</State>
  </Node>
  <OutsideNode id="isOut">Out</OutsideNode>
</Root>
```

Methods available in XMLReadUtil:

1. String GetValueForXMLElement(String label, HttpResponse pRes)
    * pRes = HttpResponse with a XML Doc in the Response Body
    * label = The name of the node
    
    **Usage:** 
    ```
    System.assertEquals('Out', XMLReadUtil.GetValueForXMLElement('OutsideNode', res));
    ```
    
2.  String FindValueInXML(String label, Dom.XMLNode xmlNode)
    * xmlNode = XML Node / Doc
    * label = The name of the Node 
    
    **Usage:** 
    ```
    System.assertEquals('Out', XMLReadUtil.FindValueInXML('OutsideNode', xmlDoc));
    ```
    
3. String GetAttributeValueForXMLElement(String label, String attribute, HttpResponse pRes) 
    * pRes = HttpResponse with a XML Doc in the Response Body
    * label = The name of the node
    * attribute = The attribute that we are searching for
    
    **Usage:** 
    ```
    System.assertEquals('isOut', XMLReadUtil.GetAttributeValueForXMLElement('OutsideNode','id', res));
    ```
    
4. String FindAttributeInXML(String label, String attribute, Dom.XMLNode xmlNode) 
    * xmlNode = XML Node / Doc
    * label = The name of the node
    * attribute = The attribute that we are searching for
    
    **Usage:** 
    ```
    System.assertEquals('isOut', XMLReadUtil.FindAttributeInXML('OutsideNode','id', xmlNode));
    ```
    
5. String FindExactValueInXML(String parentLabel, String parentAttribute, String parentAttValue, String childLabel, Dom.XMLNode xmlNode)
    * xmlNode = XML Node / Doc
    * parentLabel = the name of the parent label
    * parentAttribute = the attribute for the parent label
    * parentAttValue = the value of the attribute for the parent label
    * childLabel = the name of the node that we are looking for
    
    **Usage:**
    ```
    System.assertEquals('N2',XMLReadUtil.FindExactValueInXML('Node','id','node2','State', xmlnode));
    ```
6. String FindExactValueInResponse(String parentLabel, String parentAttribute, String parentAttValue, String childLabel, HttpResponse res)
    * res = HttpResponse with an XML Doc in the Body
    * parentLabel = the name of the parent label
    * parentAttribute = the attribute for the parent label
    * parentAttValue = the value of the attribute for the parent label
    * childLabel = the name of the node that we are looking for
    **Usage:**
    ```
    System.assertEquals('N2',XMLReadUtil.FindExactValueInResponse('Node','id','node2','State', res));
    ```
All methods return 'N/A' if label is not found. 
    


