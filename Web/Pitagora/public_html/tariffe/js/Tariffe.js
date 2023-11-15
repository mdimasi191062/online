var objWindows = null;

function Expand(obj,me){
    
    if (document.all(obj).style.display=='none'){
        document.all(obj).style.display='';
    }
    else{
        document.all(obj).style.display='none';
    }
    
    if(me.innerText.indexOf('+')==0){
		me.innerText = '-';
	}
	else{
		me.innerText = '+';
	}
}


function ClearCombo(Combo){
    for(i=Combo.length -1;i>0;i--){
      DelOptionByIndex(Combo,i);
    }
    setFirstCboElement(Combo);
}


function CaricaTabellaTariffe(){
	
	var objRow = '';
	var objCell = '';
	var valFasce = frmDati.cboFasce.value;
	var valClasseSconto = frmDati.cboClasseSconto.value;
	var objNodeSconto = '';
	var objNodeFasce = '';
	var valUM = '';
	var widthRow = '';
	var colorRow = 'row2';	
	var inpuName = '';
	var propertyInput = '|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=' + maschera;
		
	//I nomi degli input box devono avere la seguente sintassi
	//TAR-F=CODE_FASCIA-PRF=CODE_PR_FASCIA-S=CODE_SCONTO-PRS=CODE_PR_SCONTO;
	
	objTableBody = 	document.all('BodyTableTariffe');
	//Cancello la tabella
	DeleteAllRows(objTableBody);
	//Se non è stato selezionato ne la classe di sconto ne la fascia		
	if(valFasce=='' && valClasseSconto==''){
		objRow = objTableBody.insertRow();
		objRow.className='row1';
		
		objCell = objRow.insertCell();
		objCell.innerHTML = 'Tariffa';
		objCell = objRow.insertCell();
		objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" id="TAR-tcf" name="TAR-tcf">';
		setObjProp(document.all('TAR-tcf'),'label=Tariffa' + propertyInput);
	}	
	else{
		//Se è stata selezionata la classe di sconto vado a riperire i dati dall'xml precedentemente caricato
		if(valClasseSconto!=''){
			objNodeSconto = objClassiScontoXml.documentElement.selectSingleNode('CLASSESCONTO[@ID=' + valClasseSconto + ']');
			objNodeSconto = objNodeSconto.selectNodes('DETTAGLIO');
			widthRow = 100 / (objNodeSconto.length + 1);
		}
		else{
			widthRow = 50;
		}
		//Se è stata selezionata la fascia vado a riperire i dati dall'xml precedentemente caricato
		if(valFasce!=''){
			objNodeFasce = objFasceXml.documentElement.selectSingleNode('FASCIA[@ID=' + valFasce + ']');
			valUM = objNodeFasce.selectSingleNode('DESC_UM').text;
			objNodeFasce = objNodeFasce.selectNodes('DETTAGLIO');
		}
				
		objRow = objTableBody.insertRow();
		objRow.className='rowHeader';

		objCell = objRow.insertCell();
		objCell.width = widthRow + '%';
		
		if (valFasce!=''){
			 objCell.innerHTML = 'Fascia ' + valUM;
		}
		
		if (valClasseSconto!=''){		
			//Creo l'intestazione delle colonne
		    for(i=0;i<objNodeSconto.length;i++){
				objCell = objRow.insertCell();
				objCell.align = 'center';
				objCell.width = widthRow + '%';
    			objCell.innerHTML = 'da €' + objNodeSconto[i].selectSingleNode('IMP_MIN').text ;
				if (objNodeSconto[i].selectSingleNode('IMP_MAX').text != ''){
					objCell.innerHTML += ' a €' + objNodeSconto[i].selectSingleNode('IMP_MAX').text ;
				}
			}
			if (valFasce!=''){
				//Creo l'intestazione delle Righe
				for(i=0;i<objNodeFasce.length;i++){
					if(colorRow=='row2')colorRow = 'row1'; else colorRow='row2';
					objRow = objTableBody.insertRow();
					objRow.className=colorRow;
					
					objCell = objRow.insertCell();
					objCell.innerHTML = 'da ' + valUM  + ' ' + objNodeFasce[i].selectSingleNode('VAL_MIN').text ;
											
					if (objNodeFasce[i].selectSingleNode('VAL_MAX').text != ''){
						objCell.innerHTML += ' a ' + valUM + ' ' + objNodeFasce[i].selectSingleNode('VAL_MAX').text ;
					}
					
				    for(z=0;z<objNodeSconto.length;z++){
						inputName = 'TAR-F=' + valFasce + '-PRF=' + objNodeFasce[i].selectSingleNode('PR').text
						inputName += '-S=' + valClasseSconto + '-PRS=' + objNodeSconto[z].selectSingleNode('PR').text
		
						objCell = objRow.insertCell();
						objCell.align = 'center';
						objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" name="' + inputName + '" id="' + inputName + '">';
						setObjProp(document.all(inputName),'label=Tariffa' + propertyInput);
					}
				}
			}
			else{
				objRow = objTableBody.insertRow();
				objRow.className='row1';
				
				objCell = objRow.insertCell();
				objCell.innerHTML = 'Tariffa';
						
				for(i=0;i<objNodeSconto.length;i++){
						inputName = 'TAR-S=' + valClasseSconto + '-PRS=' + objNodeSconto[i].selectSingleNode('PR').text
	    				objCell = objRow.insertCell();
						objCell.align = 'center';
						objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" name="' + inputName + '" id="' + inputName + '">';
						setObjProp(document.all(inputName),'label=Tariffa' + propertyInput);
				}
			}
		}
		else{
			objCell = objRow.insertCell();
			objCell.width = widthRow + '%';
			objCell.align = 'center';
			objCell.className = 'rowHeader';
			objCell.innerHTML = 'Tariffa'

			for(i=0;i<objNodeFasce.length;i++){

				if(colorRow=='row2')colorRow = 'row1'; else colorRow='row2';
				objRow = objTableBody.insertRow();
				objRow.className=colorRow;
				
				objCell = objRow.insertCell();
				objCell.innerHTML = 'da ' + valUM  + ' ' + objNodeFasce[i].selectSingleNode('VAL_MIN').text ;
									
				if (objNodeFasce[i].selectSingleNode('VAL_MAX').text != ''){
					objCell.innerHTML += ' a ' + valUM + ' ' + objNodeFasce[i].selectSingleNode('VAL_MAX').text ;
				}
				inputName = 'TAR-F=' + valFasce + '-PRF=' + objNodeFasce[i].selectSingleNode('PR').text;

				objCell = objRow.insertCell();
				objCell.align = 'center';
				objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" name="' + inputName + '" id="' + inputName + '">';
				setObjProp(document.all(inputName),'label=Tariffa' + propertyInput);
			}				
		}
	}
}

function DeleteAllRows(objTable){
	for (i=objTable.rows.length;i>0;i--){
		objTable.deleteRow(i-1);  
	}
}

function DeleteRow(Table,obj){
	//objTable = document.all(Table);
	//objTable.deleteRow(obj);
  var i=obj.parentNode.parentNode.rowIndex;
  document.getElementById(Table).deleteRow(i);
}

var colorRow = 'row2';

function AggiungiRegola(){
  var data_tariffa = document.frmDati.txtDataInizioValidita.value;
  var data_gruppo = document.frmDati.txtDataGruppo.value;
  
  if(!controllaData(data_tariffa,data_gruppo)){
    alert('Attenzione!!!La Data Inizio Validità Tariffa non può essere minore della Data Inizio Validità del Gruppo');
		return;	
  }
	var objRegola = document.all('cboRegola');	
	objRegola = objRegola.options[objRegola.selectedIndex];
	var paramRegola = document.all('txtParamRegola');
	//modifica 10032014
  var descrGruppo = document.all('txtDescrGruppo');
  /*mm79*/	var txtDataParametro = document.all('txtDataParametro');  
	var objTable = document.all('TableRegole');
	var objRow;
	var objCell; 
	
	//I nomi degli input box devono avere la seguente sintassi
	//REG-CODE_REGOLA
	if (!RegolaExist(objRegola.value)){
		alert('Regola già inserita');
		return;	
	}

	if(objRegola.value==''){
		alert('Occorre selezionare una regola.');
		objRegola.focus();	
	}
	else{
		if(objRegola.typeParam!='' && paramRegola.value == '' && txtDataParametro.value == '' ){
			alert('Occorre inserire il parametro richiesto.');
			objRegola.focus();	
			return;
		}

		if (paramRegola.value != '' || txtDataParametro.value != '' ){
			switch(objRegola.typeParam){
				case 'N': //Se è numerico

					if(isNaN(paramRegola.value)){
						alert('Occorre inserire un parametro di tipo numerico.');
						paramRegola.focus();
						return;				
					};

				break;			
				case 'S':
				//Se è stringa accetta qualsiasi valore
				break;			
				case 'D': // Se è data
          paramRegola.value = txtDataParametro.value;
				break;			
			}			
		}

		if(colorRow=='row1')colorRow = 'row2'; else colorRow='row1';
		objRow = objTable.insertRow();
		objRow.className=colorRow;
		objRow.height = '18';
		
		objCell = objRow.insertCell();
		objCell.innerHTML = objRegola.text;
		objCell.align = 'center';
		objCell.width = '46%';
    objCell.innerHTML += '<INPUT typeTxt="REGOLA" type="hidden" name="REG-' + objRegola.value + '" id="REG-' + objRegola.value + '" value="' + paramRegola.value + '">';
	
		objCell = objRow.insertCell();
		objCell.width = '46%';
		objCell.align = 'center';
    //modifica 10032014
    if(objRegola.value=='13')
       objCell.innerHTML = descrGruppo.value;
     else
   		   objCell.innerHTML = paramRegola.value;
       
		objCell = objRow.insertCell();
		objCell.width = '8%';
		objCell.align = 'center';
		objCell.innerHTML = '<IMG alt="Cancella" onclick="DeleteRow(\'TableRegole\',this)" src="' + pathImg + 'delete.gif" style="CURSOR: hand">';
		paramRegola.value = '';
	}
}

function RegolaExist(codeRegola){
	var objTxtRegole = document.all.tags('INPUT');
	var strName = '';
	
	for(i=0;i<objTxtRegole.length;i++){
		if(objTxtRegole[i].typeTxt == 'REGOLA'){
			//alert(objTxtRegole[i].name);
			strName = objTxtRegole[i].name.split('-');
			if(strName[1]==codeRegola){
				return false;
			}
		}
	}
	return true;
}

var myObj='';

function visualizzaTariffe(obj,me){
        if (document.all(obj).style.display=='none'){
                document.all(obj).style.display='';
                if(myObj!=''){
                        document.all(myObj).style.display='none';
                }
                myObj = obj;
        }
        var menu = document.all('menu')
        
        for(i=0;i<menu.length;i++){
			menu[i].className = 'text';
        }
        
        me.className = 'textSel';
        if (me.codeComponente != null){
        	frmDati.CodeComponente.value = me.codeComponente;
        	frmDati.DescComponente.value = me.descComponente;
    	}
    	//alert(me.codePrestAgg);
    	
        if (me.codePrestAgg != null){
        	frmDati.CodePrestAgg.value = me.codePrestAgg;
        	frmDati.DescPrestAgg.value = me.descPrestAgg;
        }
        //alert(frmDati.CodePrestAgg.value);
        //alert(frmDati.DescPrestAgg.value);
}

function CambiaTab(obj){
	var strTipoTar='';
	var strIdTar='';
	var arrTar = obj.split('-');
	
	strTipoTar = arrTar[0];
	strIdTar = arrTar[1];
	
	if(strTipoTar == 'TAR'){
		document.all('TARPC-' + strIdTar).style.display='none';
		document.all('TAR-' + strIdTar).style.display='';
		document.all('TD-' + strIdTar).bgColor = '#CFDBE9';
		document.all('TD-' + strIdTar).className = 'blackB';
		document.all('TDPC-' + strIdTar).className = 'white';
		document.all('TDPC-' + strIdTar).bgColor = '#0a6b98';
	}
	else{
		document.all('TAR-' + strIdTar).style.display='none';
		document.all('TARPC-' + strIdTar).style.display='';
		document.all('TDPC-' + strIdTar).bgColor = '#CFDBE9';
		document.all('TDPC-' + strIdTar).className = 'blackB';
		document.all('TD-' + strIdTar).className = 'white';
		document.all('TD-' + strIdTar).bgColor = '#0a6b98';
	}
}

 function ONAGGIUNGI(){
	//alert(myObj); 		
	if(document.all('CodePrestAgg')!=null){
    	if (frmDati.CodePrestAgg.value==''){
   			alert('Occorre selezionare una prestazione aggiuntiva per associargli una tariffa.');
   			return;
   		}
	}
    if(document.all('CodeComponente')!=null){
    	if (frmDati.CodeComponente.value=='' && document.all('CodePrestAgg')==null){ 
   			alert('Occorre selezionare un componente per associargli una tariffa.');
   			return;
		}
	}
	frmDati.CodeTariffa.value = '';
	frmDati.SourcePage.value += cboOfferta.value;
	if(tableIsForCausale())
	frmDati.SourcePage.value += '&CodeCausale=1';
	frmDati.CodeOfferta.value = cboOfferta.value;
	frmDati.DescOfferta.value = getComboText(cboOfferta);
	frmDati.action = 'cbn1_tariffa_aggiungi_modifica.jsp';
	frmDati.target = '_self';
	frmDati.submit();
  }
  
 function ApriDettaglio(Tariffa){
 	frmDati.CodeTariffa.value = Tariffa;
    frmDati.CodeOfferta.value = cboOfferta.value;
	frmDati.DescOfferta.value = getComboText(cboOfferta);
	frmDati.SourcePage.value += cboOfferta.value;
	if(tableIsForCausale())
	frmDati.SourcePage.value += '&CodeCausale=1';
	frmDati.target = '_self';
	frmDati.action = 'cbn1_tariffa_aggiungi_modifica.jsp';
	frmDati.submit();
 }
 
 function EliminaTariffa(Tariffa){
 	if(confirm('La tariffa verrà eliminata in modo permanente.\n\rContinuare?')){
	 	frmDati.CodeTariffa.value = Tariffa;
	 	frmDati.SourcePage.value += cboOfferta.value;
	 	
		if(document.all('CodePrestAgg')!=null){
	    	if (frmDati.CodePrestAgg.value!=''){
	   			frmDati.SourcePage.value += '&CodePrestAgg=' + frmDati.CodePrestAgg.value;
	   		}
		}
	    if(document.all('CodeComponente')!=null){
	    	if (frmDati.CodeComponente.value!=''){ 
				frmDati.SourcePage.value += '&CodeComponente=' + frmDati.CodeComponente.value;			
			}
		}

		if(tableIsForCausale())
			frmDati.SourcePage.value += '&CodeCausale=1';

	 	frmDati.target = 'Delete';
	    openCentral('about:blank','Delete','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
		frmDati.action = 'cbn1_controller_tariffe.jsp?Operazione=Del';
		frmDati.submit();
	}
 }                
 
 function StoricoTariffa(Tariffa){
 	frmDati.CodeTariffa.value = Tariffa;
 	//frmDati.SourcePage.value += cboOfferta.value;
 	frmDati.target = 'Storico';
    openCentral('about:blank','Storico','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);
	frmDati.action = 'cbn1_storico_tariffa.jsp';
	frmDati.submit();
 } 

 function cmdTariffaRiferimento_click(){
 	var URL = '';
 	
 	if((!frmDati.cboClasseSconto.disabled) && frmDati.cboClasseSconto.value==''){
 		alert('E\' necessario selezionare una opzione dal Combo Box:\'' + frmDati.cboClasseSconto.label + '\'!');
 		return;
 	}
 	if((!frmDati.cboFasce.disabled) && frmDati.cboFasce.value==''){
 		alert('E\' necessario selezionare una opzione dal Combo Box:\'' + frmDati.cboFasce.label + '\'!');
 		return;
 	}
 	
 	URL = 'cbn1_select_Tariffa_Rif.jsp';
 	URL += '?CodeServizio=' + frmDati.Servizio.value;
 	URL += '&CodeOfferta=' + frmDati.Offerta.value;
 	URL += '&CodeProdotto=' + frmDati.Prodotto.value;
 	URL += '&CodeComponente=' + frmDati.Componente.value;
 	URL += '&CodePrestAgg=' + frmDati.PrestAgg.value;
 	URL += '&CodeClasse=' + frmDati.cboClasseSconto.value;
 	URL += '&CodeFascia=' + frmDati.cboFasce.value;
 	URL += '&tipo_tariffa=' + frmDati.tipo_tariffa.value;
 	
    openCentral(URL,'TariffaRiferimento','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);
 } 
 
            
function DisabledControlForUpdate(objForm){
	var objCollectionInput = objForm.elements;
	
	//ciclo sugli elementi di input della form
	for (i=0 ; i < objCollectionInput.length;i++)
	{
		//non disabilito i campi nascosti!!!
		if(objCollectionInput[i].type.toUpperCase() != "HIDDEN" && objCollectionInput[i].Update=='false'){
			objCurrent = objCollectionInput[i];
			Disable(objCurrent);
		}
	}
}    


function ONCHIUDI(){
	window.close();	
}


function tableIsForCausale(){
	var strIdTar='';
	var arrTar;
	
	if(myObj!=''){
		arrTar = myObj.split('-');
		strIdTar = arrTar[1];
		//alert(strIdTar);
		if(document.all('TAR-' + strIdTar).style.display=='none'){
			return true;
		}
		else{
			return false;
		}
	}
	else{
		return false;
	}
}

  function caricaTabellaTariffeRif(objOpt,objTable,i){
  	var objRow = null;
    var objCell = null;

		if(colorRow=='row1')colorRow = 'row2'; else colorRow='row1';
		objRow = objTable.insertRow();
		objRow.className=colorRow;
		objRow.height = '18';

		objCell = objRow.insertCell();
		objCell.align = 'center';
		objCell.innerHTML = objOpt.Prodotto;    
		objCell.innerHTML += '<BR>';    
		objCell.innerHTML += objOpt.Componente;    
		objCell.innerHTML += '<BR>';    
		objCell.innerHTML += objOpt.PrestAgg;    

		objCell = objRow.insertCell();
		objCell.align = 'center';
		objCell.innerHTML = objOpt.OggettoFatturazione;    
		objCell.innerHTML += '<INPUT type="hidden" name="TARRIF-' + i + '" value="' + objOpt.value + '">';    
   
		objCell = objRow.insertCell();
		objCell.align = 'center';
		objCell.innerHTML = objOpt.ModalitaApplicazione;    

		objCell = objRow.insertCell();
		objCell.align = 'center';
		objCell.innerHTML = objOpt.Dettaglio;    

		objCell = objRow.insertCell();
		objCell.align = 'center';
		objCell.innerHTML = objOpt.TipoCausale;    

		objCell = objRow.insertCell();
		objCell.align = 'center';
		objCell.innerHTML = objOpt.DataInizio;    
    
  }

// Funzione per il confronto tra la DATA INIZIO VALIDITA' TARIFFA e DATA INIZIO VALIDITA' GRUPPO
function controllaData(data_tariffa,data_gruppo){
  //alert('data_tariffa ['+data_tariffa+']');
  //alert('data_gruppo ['+data_gruppo+']');
  
  var tokensT = data_tariffa.split("/");
  var annoT   = tokensT[2];
  var meseT   = tokensT[1];
  var giornoT = tokensT[0];
      
  var tokensG = data_gruppo.split("/");
  var annoG   = tokensG[2];
  var meseG   = tokensG[1];
  var giornoG = tokensG[0];
      
  if(eval(annoG) > eval(annoT)){
    return false;
  }else{
    if(eval(meseG) > eval(meseT)){
       return false;
    }else{
       if(eval(giornoG) > eval(giornoT)){
         return false;
       }else{
         return true;
       }
    }
  }
}

function CaricaTabellaTariffe_agg_ins(){
	
	var objRow = '';
	var objCell = '';
	var valFasce = frmDati.cboFasce.value;
	var valClasseSconto = frmDati.cboClasseSconto.value;
	var objNodeSconto = '';
	var objNodeFasce = '';
	var valUM = '';
	var widthRow = '';
	var colorRow = 'row2';	
	var inpuName = '';
	var propertyInput = '|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera_2=' + maschera_2;
		
	//I nomi degli input box devono avere la seguente sintassi
	//TAR-F=CODE_FASCIA-PRF=CODE_PR_FASCIA-S=CODE_SCONTO-PRS=CODE_PR_SCONTO;
	
	objTableBody = 	document.all('BodyTableTariffe');
	//Cancello la tabella
	DeleteAllRows(objTableBody);
	//Se non è stato selezionato ne la classe di sconto ne la fascia		
	if(valFasce=='' && valClasseSconto==''){
		objRow = objTableBody.insertRow();
		objRow.className='row1';
		
		objCell = objRow.insertCell();
		objCell.innerHTML = 'Tariffa';
		objCell = objRow.insertCell();
		objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" id="TAR-tcf" name="TAR-tcf">';
		setObjProp(document.all('TAR-tcf'),'label=Tariffa' + propertyInput);
	}	
	else{
		//Se è stata selezionata la classe di sconto vado a riperire i dati dall'xml precedentemente caricato
		if(valClasseSconto!=''){
			objNodeSconto = objClassiScontoXml.documentElement.selectSingleNode('CLASSESCONTO[@ID=' + valClasseSconto + ']');
			objNodeSconto = objNodeSconto.selectNodes('DETTAGLIO');
			widthRow = 100 / (objNodeSconto.length + 1);
		}
		else{
			widthRow = 50;
		}
		//Se è stata selezionata la fascia vado a riperire i dati dall'xml precedentemente caricato
		if(valFasce!=''){
			objNodeFasce = objFasceXml.documentElement.selectSingleNode('FASCIA[@ID=' + valFasce + ']');
			valUM = objNodeFasce.selectSingleNode('DESC_UM').text;
			objNodeFasce = objNodeFasce.selectNodes('DETTAGLIO');
		}
				
		objRow = objTableBody.insertRow();
		objRow.className='rowHeader';

		objCell = objRow.insertCell();
		objCell.width = widthRow + '%';
		
		if (valFasce!=''){
			 objCell.innerHTML = 'Fascia ' + valUM;
		}
		
		if (valClasseSconto!=''){		
			//Creo l'intestazione delle colonne
		    for(i=0;i<objNodeSconto.length;i++){
				objCell = objRow.insertCell();
				objCell.align = 'center';
				objCell.width = widthRow + '%';
    			objCell.innerHTML = 'da €' + objNodeSconto[i].selectSingleNode('IMP_MIN').text ;
				if (objNodeSconto[i].selectSingleNode('IMP_MAX').text != ''){
					objCell.innerHTML += ' a €' + objNodeSconto[i].selectSingleNode('IMP_MAX').text ;
				}
			}
			if (valFasce!=''){
				//Creo l'intestazione delle Righe
				for(i=0;i<objNodeFasce.length;i++){
					if(colorRow=='row2')colorRow = 'row1'; else colorRow='row2';
					objRow = objTableBody.insertRow();
					objRow.className=colorRow;
					
					objCell = objRow.insertCell();
					objCell.innerHTML = 'da ' + valUM  + ' ' + objNodeFasce[i].selectSingleNode('VAL_MIN').text ;
											
					if (objNodeFasce[i].selectSingleNode('VAL_MAX').text != ''){
						objCell.innerHTML += ' a ' + valUM + ' ' + objNodeFasce[i].selectSingleNode('VAL_MAX').text ;
					}
					
				    for(z=0;z<objNodeSconto.length;z++){
						inputName = 'TAR-F=' + valFasce + '-PRF=' + objNodeFasce[i].selectSingleNode('PR').text
						inputName += '-S=' + valClasseSconto + '-PRS=' + objNodeSconto[z].selectSingleNode('PR').text
		
						objCell = objRow.insertCell();
						objCell.align = 'center';
						objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" name="' + inputName + '" id="' + inputName + '">';
						setObjProp(document.all(inputName),'label=Tariffa' + propertyInput);
					}
				}
			}
			else{
				objRow = objTableBody.insertRow();
				objRow.className='row1';
				
				objCell = objRow.insertCell();
				objCell.innerHTML = 'Tariffa';
						
				for(i=0;i<objNodeSconto.length;i++){
						inputName = 'TAR-S=' + valClasseSconto + '-PRS=' + objNodeSconto[i].selectSingleNode('PR').text
	    				objCell = objRow.insertCell();
						objCell.align = 'center';
						objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" name="' + inputName + '" id="' + inputName + '">';
						setObjProp(document.all(inputName),'label=Tariffa' + propertyInput);
				}
			}
		}
		else{
			objCell = objRow.insertCell();
			objCell.width = widthRow + '%';
			objCell.align = 'center';
			objCell.className = 'rowHeader';
			objCell.innerHTML = 'Tariffa'

			for(i=0;i<objNodeFasce.length;i++){

				if(colorRow=='row2')colorRow = 'row1'; else colorRow='row2';
				objRow = objTableBody.insertRow();
				objRow.className=colorRow;
				
				objCell = objRow.insertCell();
				objCell.innerHTML = 'da ' + valUM  + ' ' + objNodeFasce[i].selectSingleNode('VAL_MIN').text ;
									
				if (objNodeFasce[i].selectSingleNode('VAL_MAX').text != ''){
					objCell.innerHTML += ' a ' + valUM + ' ' + objNodeFasce[i].selectSingleNode('VAL_MAX').text ;
				}
				inputName = 'TAR-F=' + valFasce + '-PRF=' + objNodeFasce[i].selectSingleNode('PR').text;

				objCell = objRow.insertCell();
				objCell.align = 'center';
				objCell.innerHTML = '<INPUT typeTxt="TARIFFA" class="textNumber" name="' + inputName + '" id="' + inputName + '">';
				setObjProp(document.all(inputName),'label=Tariffa' + propertyInput);
			}				
		}
	}
}
