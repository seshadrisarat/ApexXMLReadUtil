@isTest
private class XMLReadTest {
	
	private static String get_basic_xml_node()
	{
		String theReturn = '';
		theReturn += '<Root>';
		theReturn += '<Node id="node1">';
		theReturn += '<Street>1 Node</Street>';
		theReturn += '<City>Node1</City>';
		theReturn += '<State>N1</State>';
		theReturn += '<Residents>';
		theReturn += '<Person1>Resident1</Person1>';
		theReturn += '<Person2>Resident2</Person2>';
		theReturn += '</Residents>';
		theReturn += '</Node>';
		theReturn += '<Node id="node2">';
		theReturn += '<Street>2 Node</Street>';
		theReturn += '<City>Node2</City>';
		theReturn += '<State>N2</State>';
		theReturn += '</Node>';
		theReturn += '<OutsideNode id="isOut">Out</OutsideNode>';
		theReturn += '</Root>';
		return theReturn;
	}
	
	@isTest static void should_find_node_value_in_http_response() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		HttpResponse res = new HttpResponse();
		res.setStatus('OK');
		res.setStatusCode(200);
		res.setBody(xml);
		System.assertEquals('Out',XMLReadUtil.GetValueForXMLElement('OutsideNode', res));
	}
	
	@isTest static void should_find_value_in_xml_node() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		Dom.Document doc = new Dom.Document();
		doc.load(xml);
		Dom.XMLNode xmlnode = doc.getRootElement();
		System.assertEquals('Out',XMLReadUtil.FindValueInXML('OutsideNode', xmlnode));
	}

	@isTest static void should_return_find_third_level_value_in_xml_node() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		Dom.Document doc = new Dom.Document();
		doc.load(xml);
		Dom.XMLNode xmlnode = doc.getRootElement();
		System.assertEquals('Resident1',XMLReadUtil.FindValueInXML('Person1', xmlnode));
	}

	@isTest static void should_find_attribute_value_in_http_response() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		HttpResponse res = new HttpResponse();
		res.setStatus('OK');
		res.setStatusCode(200);
		res.setBody(xml);
		System.assertEquals('isOut',XMLReadUtil.GetAttributeValueForXMLElement('OutsideNode','id', res));
	}

	@isTest static void should_find_attribute_value_in_xml_node() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		Dom.Document doc = new Dom.Document();
		doc.load(xml);
		Dom.XMLNode xmlnode = doc.getRootElement();
		System.assertEquals('isOut',XMLReadUtil.FindAttributeInXML('OutsideNode','id', xmlnode));
	}
	

	@isTest static void should_identify_nodes_based_on_attribute_values_from_xmlnode() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		Dom.Document doc = new Dom.Document();
		doc.load(xml);
		Dom.XMLNode xmlnode = doc.getRootElement();
		Dom.XMLNode child = XMLReadUtil.GetChildsForMatchingLabelAndAttribute('Node', 'id', 'node2', xmlnode);
		System.assertEquals('N2',XMLReadUtil.FindValueInXML('State', child));
	}

	@isTest static void should_find_exact_values_in_xml() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		Dom.Document doc = new Dom.Document();
		doc.load(xml);
		Dom.XMLNode xmlnode = doc.getRootElement();
		System.assertEquals('N2',XMLReadUtil.FindExactValueInXML('Node','id','node2','State', xmlnode));
	}	

	@isTest static void should_find_exact_values_in_http_response() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		HttpResponse res = new HttpResponse();
		res.setStatus('OK');
		res.setStatusCode(200);
		res.setBody(xml);
		System.assertEquals('N2',XMLReadUtil.FindExactValueInResponse('Node','id','node2','State', res));
	}

	@isTest static void should_return_NA_if_value_not_found_in_http_response() {
		// Implement test code
		String xml = XMLReadTest.get_basic_xml_node();
		HttpResponse res = new HttpResponse();
		res.setStatus('OK');
		res.setStatusCode(200);
		res.setBody(xml);
		System.assertEquals('N/A',XMLReadUtil.FindExactValueInResponse('Node','id','node2','Country', res));
	}
	
}