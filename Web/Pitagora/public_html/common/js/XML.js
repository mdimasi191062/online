function CaricaComboDaXML(Combo,objNodes,Attr){
    ClearCombo(Combo);
    var myOpt = null;
    for(i=0;i<objNodes.length;i++){
      myOpt = addOption(Combo,objNodes[i].selectSingleNode('DESC').text ,objNodes[i].attributes[0].text);
      if(Attr!=undefined){
	     myOpt.Attributo = objNodes[i].selectSingleNode(Attr).text
      }
    }
}

function CreaObjXML(){
    var objXml = new ActiveXObject('MSXML.DomDocument');
    objXml.setProperty('SelectionLanguage', 'XPath');	
    return objXml;
}

function CaricaComboDaXMLFiltro(Combo,objNodes,filtro){
    ClearCombo(Combo);
    var myOpt = null;
    isEmpty = true;
    for(i=0;i<objNodes.length;i++){
      if(objNodes[i].selectSingleNode('SERV').text == filtro){
        myOpt = addOption(Combo,objNodes[i].selectSingleNode('DESC').text ,objNodes[i].attributes[0].text);
        isEmpty=false;
      }
    }
    Combo.disabled=isEmpty;
}
