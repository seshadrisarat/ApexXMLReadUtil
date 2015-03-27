public class XMLReadUtil {
	
	    public static String GetValueForXMLElement(String label, HttpResponse pRes)
    {
    	String theReturn = 'N/A';

    	if(pRes.getStatus() == 'OK')
		{
			Dom.Document doc = pRes.getBodyDocument();
			if(doc != null)
			{
				Dom.XMLNode root = doc.getRootElement(); 
				theReturn = XMLReadUtil.FindValueInXML(label, root);
			}
    	}

    	return theReturn;
    }

    public static String FindValueInXML(String label, Dom.XMLNode xmlNode)
    {
    	if(xmlNode != null)
    	{   
    		
	    	if(xmlNode.getChildElements().size() == 0)
	    	{
	    		System.debug('Looking at: '+xmlNode.getName());
	    		if(xmlNode.getName() == label)
	    			return xmlNode.getText();
	    		else
	    			return 'N/A';
	    	}
	    	else
	    	{
	    	
		    	for(Dom.XMLNode child: xmlNode.getChildElements())
		    	{
		    		System.debug('Looking at: '+child.getName());
		    		System.debug('With these childs: '+child.getChildElements());
		    		if(child.getName() == label)
		    			return child.getText();
		    		else
		    			for(Dom.XMLNode grandChild: child.getChildElements())
		    				if(XMLReadUtil.FindValueInXML(label, grandchild) != 'N/A')
		    					return XMLReadUtil.FindValueInXML(label, grandchild);
		    	}
		    }
		}

    	return 'N/A';
    }

    public static String GetAttributeValueForXMLElement(String label, String attribute, HttpResponse pRes)
    {
    	String theReturn = 'N/A';

    	if(pRes.getStatus() == 'OK')
		{
			Dom.Document doc = pRes.getBodyDocument();
			if(doc != null)
			{
				Dom.XMLNode root = doc.getRootElement(); 
				theReturn = XMLReadUtil.FindAttributeInXML(label, attribute, root);
			}
    	}

    	if(theReturn == null)
    		theReturn = 'N/A';

    	return theReturn;
    }

     public static String FindAttributeInXML(String label, String attribute, Dom.XMLNode xmlNode)
    {
    	
    	if(xmlNode.getChildElements().size() == 0)
    	{
    		if(xmlNode.getName() == label)
    			return xmlNode.getAttribute(attribute, null);
    		else
    			return 'N/A';
    	}
    	else
    	{
    	
    		for(Dom.XMLNode child: xmlNode.getChildElements())
    		{
    		if(child.getName() == label)
    			return child.getAttribute(attribute, null);
    		else
    			for(Dom.XMLNode grandChild: child.getChildElements())
    				if(XMLReadUtil.FindAttributeInXML(label, attribute, grandchild) != 'N/A')
    					return XMLReadUtil.FindAttributeInXML(label, attribute, grandchild);
    		}
    	}
    	return 'N/A';
    }

    public static Dom.XMLNode GetChildsForMatchingLabelAndAttribute(String label, String attribute, String attValue, Dom.XMLNode xmlNode)
    {
    	System.debug('Entering GetChildsForMatching...');

    	if(xmlNode != null && xmlNode.getName() == label && xmlNode.getAttribute(attribute, null) == attValue)
    		return xmlNode; 
    	else
    	 	{
    	 		for(Dom.XMLNode child: xmlNode.getChildElements())
    	 		{
    	 			if(GetChildsForMatchingLabelAndAttribute(label, attribute, attValue, child) != null)
    	 				return GetChildsForMatchingLabelAndAttribute(label, attribute, attValue, child);
    	 		}
    	 	}
    	
    	return null;
    }

    public static String FindExactValueInXML(String parentLabel, String parentAttribute, String parentAttValue, String childLabel, Dom.XMLNode xmlNode)
    {
    	return FindValueInXML(childLabel, XMLReadUtil.GetChildsForMatchingLabelAndAttribute(parentLabel, parentAttribute, parentAttValue, xmlNode));
    	
    }

    public static String FindExactValueInResponse(String parentLabel, String parentAttribute, String parentAttValue, String childLabel, HttpResponse res)
    {
    	if(res != null)
    	{    	
    		Dom.Document doc = res.getBodyDocument();
    		Dom.XMLNode xmlNode = doc.getRootElement();
			return FindValueInXML(childLabel, XMLReadUtil.GetChildsForMatchingLabelAndAttribute(parentLabel, parentAttribute, parentAttValue, xmlNode));
   		}
   		else
   			return 'N/A';
    }
}