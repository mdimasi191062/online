function cboElaborazioniChange(obj){
	alert(window.location);
	window.location.replace('elab_run.jsp?CodeFunz=' + obj.value);
}

function cboperiodoRifChange(obj){
  var opt = obj.options[obj.selectedIndex];
	//alert('elab_run.jsp?CodeFunz=' + frmDati.cboElaborazioni.value + '&' + obj.name + '=' + obj.value);
	window.location.replace('elab_run.jsp?CodeFunz=' + frmDati.cboElaborazioni.value + '&' + obj.name + '=' + obj.value  + '&txtDataFineCiclo=' + opt.strDataFineCiclo );
}

function ClearCombo(Combo){
    for(i=Combo.length -1;i>=0;i--){
      DelOptionByIndex(Combo,i);
    }
    setFirstCboElement(Combo);
}

function addOptionToCombo(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
	var myOpt = null;
	if(index != -1)
	{
		if(getComboValue(cboSource)==''){
			switch(cboSource.name){
				case 'cboGestoriDisp' : 
					alert('Per il seguente gestore -' + getComboText(cboSource) + '- esistono elaborazioni batch di tipo Calcolo Cambi Tariffa non congelate.');
					return;
			}
		}
		myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
		myOpt.Attributo = cboSource.options[index].Attributo;
		DelOptionByIndex(cboSource,index);
		if (cboSource.name == 'cboServizi' || cboSource.name == 'cboServiziDisp'){
			serviziChange();
		}
		else{
			accountChange();
		}
	}
}

function addAllOptionsToCombo(cboSource,cboDestination){

	var myOpt = null;
	var i = 0;
	while (cboSource.length > i)
	{
		//alert(getComboValueByIndex(cboSource,i));
		if(getComboValueByIndex(cboSource,i)==''){
			switch(cboSource.name){
				case 'cboGestoriDisp' : 
					alert('Per il seguente gestore -' + getComboTextByIndex(cboSource,i) + '- esistono elaborazioni batch di tipo Calcolo Cambi Tariffa non congelate.');
					i++;
					continue;
			}
		}

		myOpt = addOption(cboDestination,getComboTextByIndex(cboSource,i),getComboValueByIndex(cboSource,i));
		myOpt.Attributo = cboSource.options[i].Attributo;
		DelOptionByIndex(cboSource,i);
	}
	if (cboSource.name == 'cboServizi' || cboSource.name == 'cboServiziDisp'){
		serviziChange();
	}
	else{
		accountChange();
	}
}

function serviziChange(){
	var PathQuery = '';
	PathQuery = 'ACCOUNT';
	if(document.all('cboAccount') != null){
		for(i=0;i<frmDati.cboServizi.length;i++){
			PathQuery += '[SERVIZIO!=' + getComboValueByIndex(frmDati.cboServizi,i) + ']';	
		}
		CaricaComboDaXML(frmDati.cboAccountDisp,objXmlAcc.documentElement.selectNodes(PathQuery),'SERVIZIO');
	}
}

function accountChange(){
	var PathQuery = '';
	PathQuery = 'SERVIZIO';
	if(document.all('cboServizi') != null){
		for(i=0;i<frmDati.cboAccount.length;i++){
			PathQuery += '[@ID!="' + frmDati.cboAccount.options[i].Attributo + '"]';	
		}
		for(i=0;i<frmDati.cboServizi.length;i++){
			PathQuery += '[@ID!="' + frmDati.cboServizi.options[i].value + '"]';	
		}
		CaricaComboDaXML(frmDati.cboServiziDisp,objXmlServ.documentElement.selectNodes(PathQuery));
	}
}	
var myObj = null;

function clickOptElab(obj){
  if(myObj != null){
    if(document.all('cboPeriodoRif' + myObj.value)!=null && document.all('cboPeriodoRif' + myObj.value)!='undefined'){
      document.all('cboPeriodoRif' + myObj.value).style.visibility = 'hidden';
			document.all('cboPeriodoRif' + myObj.value).disabled = true;
		}
	
		if(document.all('txtData' + myObj.value)!=null && document.all('txtData' + myObj.value)!='undefined'){
      document.all('txtData' + myObj.value).style.visibility = 'hidden';
			document.all('lblData' + myObj.value).style.visibility = 'hidden';
			document.all('imgData' + myObj.value).style.visibility = 'hidden';
			document.all('txtData' + myObj.value).disabled = true;
		}
	}
		
	if(document.all('cboPeriodoRif' + obj.value)!=null && document.all('cboPeriodoRif' + obj.value)!='undefined'){
    document.all('cboPeriodoRif' + obj.value).style.visibility = 'visible';
		document.all('cboPeriodoRif' + obj.value).disabled = false;
	}

	if(document.all('txtData' + obj.value)!=null && document.all('txtData' + obj.value)!='undefined'){
    document.all('txtData' + obj.value).style.visibility = 'visible';
		document.all('lblData' + obj.value).style.visibility = 'visible';
		document.all('imgData' + obj.value).style.visibility = 'visible';
		document.all('txtData' + obj.value).disabled = false;
	}
	
	myObj = obj;
}

function descError(CodeError){
    openCentral('elab_desc_error.jsp?CodeError=' + CodeError,'DescError','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
}
function getGiornoJS(mese){
    var giorno = "";
    switch(mese){
      case "4":
          giorno = "30";
          break;
      case "6":
          giorno = "30";
          break;
      case "9":
          giorno = "30";
          break;
      case "11":
          giorno = "30";
          break;
      case "2":
          giorno = "28";
          break;
      default:
          giorno = "31";
          break;
    }
    return giorno;
}
    
function getMeseJS(strMese){
    var mese = "";
    switch(strMese){
      case "Gennaio":
          mese = "1";
          break;
      case "Febbraio":
          mese = "2";
          break;
      case "Marzo":
          mese = "3";
          break;
      case "Aprile":
          mese = "4";
          break;
      case "Maggio":
          mese = "5";
          break;
      case "Giugno":
          mese = "6";
          break;
      case "Luglio":
          mese = "7";
          break;
      case "Agosto":
          mese = "8";
          break;
      case "Settembre":
          mese = "9";
          break;
      case "Ottobre":
          mese = "10";
          break;
      case "Novembre":
          mese = "11";
          break;
      case "Dicembre":
          mese = "12";
          break;
    }
    return mese;
}

