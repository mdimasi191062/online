var objWindows = null;
var conta_promozioni = 0; //numero di promozioni associate....necessario per differenziare il tag hidden delle promozioni
var conta_righe_prom = 0; //numero di promozioni associate....necessario per differenziare il tag hidden delle promozioni
var datiContr;
var datiPs;
var datiOF;
var datiPROM;
var datiUM=new Array();
var code_contr;
var code_ps;
var tipo_importo='F';
var code_of;
var importo;
var code_tipo_caus='';
var unitadimisura='';
var data_inizio_tariffa='';
var repricing='N';
var datiAccount;
var step='';
var nomeListino;
var descrizione_ps;

var code_promozione='';
var data_da='';
var data_a='';
var data_da_can='';
var data_a_can='';
var num_Mesi='';
var codice_prog_bill='';
var flag_attiva='1';
var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";

var colorRow = 'row2';	

var arrayPromozioniAss = new Array();

var indiceApp = '';

function showMascheraCanone(isCanone)
{
  if(isCanone)
  {
    divCanone.style.visibility='visible';
    divCanone.style.display='inline';
  }
  else
  {
    divCanone.style.visibility='hidden';
    divCanone.style.display='none';
  }
}

function cancelCalendar (obj)
{
  obj.value="";
}

function showMessage (field)
{
    if (field=='seleziona1')
    self.status=msg1;
  else
    self.status=msg2;
}

function disableLink (link)
{
  if (link.onclick)
    link.oldOnClick = link.onclick;
  link.onclick = cancelLink;
  if (link.style)
    link.style.cursor = 'default';
}

function enableLink (link)
{
  link.onclick = link.oldOnClick ? link.oldOnClick : null;
  if (link.style)
    link.style.cursor = document.all ? 'hand' : 'pointer';
}

function dis_calendario()
{
     attivaCalendario=false;
     DisableLink(document.links[0],document.formPag.calendario);
     DisableLink(document.links[1],document.formPag.cancella_data);
     msg1=message1;
     msg2=message2;
}

function abi_calendario()
{
      attivaCalendario=true;
      EnableLink(document.links[0],document.formPag.calendario);
      EnableLink(document.links[1],document.formPag.cancella_data);
      msg1=message1;
      msg2=message2;
}

function onChangeContratto(nomeListino_selezionato,code_contr_selezionato)
{
  code_contr=code_contr_selezionato;
  nomeListino=nomeListino_selezionato;

}

function onChangePs(desc_ps_selezionato,ps_selezionato)
{
  code_ps=ps_selezionato;
  descrizione_ps=desc_ps_selezionato;
  document.formPag.btnAvanti.disabled=false;
}

function onChangeCausale()
{
    var indice= document.formPag.comboCausale.selectedIndex;
    code_tipo_caus =document.formPag.comboCausale.options[indice].value;
    document.formPag.desc_listino_applicato.value='';
    document.formPag.desc_listino_applicato_old.value='';
    caricaTariffe();
}

function onMessaggioTariffa(messaggio)
{
  caricaTariffe();
  gestisciMessaggio(messaggio);
}

function onInseritaTariffa(messaggio)
{
  gestisciMessaggioConFunzioneRitorno(messaggio,'caricaTariffe();');
  deleteTableRowAll();
}

function trim(stringa){    
while (stringa.substring(0,1) == ' ')
{        
stringa = stringa.substring(1, stringa.length);    
}    
while (stringa.substring(stringa.length-1, stringa.length) == ' ')
{        stringa = stringa.substring(0,stringa.length-1);    
}    
return stringa;}

function ONSALVA()
{
  /*check parametri tariffa*/
  var data_tariffa = '';
  var impt_tariffa = '';
  var desc_tariffa = '';
  var desc_listino = '';
  var desc_listino_old = '';
  var continua=true;
      
  desc_tariffa = document.formPag.desc_tariffa.value;
  data_tariffa = document.formPag.data_ini.value;
  impt_tariffa = document.formPag.importo_tariffa.value;
 if( isNaN(impt_tariffa) )
  {
    alert('Attenzione! Importo non valido!');
    return;
  }
  desc_listino = trim(document.formPag.desc_listino_applicato.value);
  desc_listino_old = trim(document.formPag.desc_listino_applicato_old.value);
  
  if(data_tariffa == '')
  {
    alert('La data inizio validità della tariffa è obbligatoria.');
    return;
  }
  
  if(impt_tariffa == '')
  {
    alert('Importo tariffa obbligatorio.');
    return;
  }
  
  if(desc_tariffa == '')
  {
    alert('La descrizione della tariffa è obbligatoria.');
    return;
  }
  
  if(desc_listino=='')
  {
    alert('Descrizione OR obbligatoria');
    return;
  }
  
  if(desc_listino.toUpperCase()==desc_listino_old.toUpperCase())
  {
    var risposta = confirm ("Descrizione OR già utilizzata! Continuare?")
    if (risposta)
      continua=true;
    else
      continua=false;
  }
  
  if(continua)
  {
      var entrato=false;
      if(arrayPromozioniAss.length > 0){
        for(i = 0; i<arrayPromozioniAss.length; i++){
          if(arrayPromozioniAss[i] != undefined){
            entrato=true;
            var objPromo = document.getElementById(arrayPromozioniAss[i]);
            indiceApp = i;
            salvaTmpDatiPromozione(objPromo);
          }
        }
        if (!entrato) {
          salvaDatiTariffa(); 
        }
      }else{
        salvaDatiTariffa();  
      }
    }
}

function onCaricaCausale(dati)
{
  riempiSelect('comboCausale',dati);
  if(dati.length==0)
  {
    document.formPag.comboCausale.style.visibility="hidden";
    document.formPag.comboCausale.style.display="none";
    causale.style.visibility="hidden";
    causale.style.display="none";
    code_tipo_caus='';
    caricaTariffe();
  }
  else
  {
    document.formPag.comboCausale.style.visibility="visible";
    document.formPag.comboCausale.style.display="inline";
    causale.style.visibility="visible";
    causale.style.display="inline";
    onChangeCausale();
  }
}

function onCaricaOF(dati)
{
  datiOF=dati;
  riempiSelect('comboOggFatt',datiOF);
  onChangeOF();
}

function onCaricaPromozioni(dati)
{
    datiPROM=dati;
    riempiSelect('comboPromozioni',datiPROM);
    /*controllare se esistono promozioni già associate da eliminare*/
}

function onCaricaAccount(dati)
{
  datiContr=dati;
  var headers=new Array("Contratto");
  var valori = new Array("0","1");
  riempiTabellaSelezionabilePagerEricerca(divTabella,dati,headers,valori,'onChangeContratto',0,10,0,'txtRicercaContratti','onRicercaAccount','onPagerAccount');
  ricaricaTabella(dati,code_contr);
}

function onCaricaPs(dati)
{
  var headers=new Array("Descrizione Ps");
  var valori = new Array("0","1");
  datiPs=dati;
  document.formPag.btnAvanti.disabled=true;
  document.formPag.btnIndietro.disabled=false;
  riempiTabellaSelezionabilePagerEricerca(divTabella,datiPs,headers,valori,'onChangePs',0,10,0,'txtRicercaPs','onRicercaPs','onPagerPs');
  ricaricaTabella(dati,code_ps);
}

function onChangeTipoImporto(isVariabile)
{
  if(isVariabile)
  {
    tipo_importo='V';
    if(datiUM.length==0)
      caricaUnitaDiMisura();
    divTabellaTariffa.style.display='inline';
    divUnitaDiMisura.style.visibility='visible';
    divUnitaDiMisura.style.display='inline';
    divTabellaTariffa.style.visibility='visible';
    divIns.style.display='inline';
    divIns.style.visibility='visible';
    maschera.style.display='inline';
    maschera.style.visibility='visible';
  }
  else
  {   

    tipo_importo='F';
    divUnitaDiMisura.style.visibility='hidden';
    divUnitaDiMisura.style.display='none';
    divTabellaTariffa.style.display='inline';
    divTabellaTariffa.style.visibility='visible';
    divIns.style.display='inline';
    divIns.style.visibility='visible';
    maschera.style.display='inline';
    maschera.style.visibility='visible';
  }
}

function salvaDatiTariffa()
{
  
  carica = function(dati){onInseritaTariffa(dati[0].messaggio)};
  errore = function(dati){onInseritaTariffa(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};

  chiamaRichiesta('code_ogg_fatrz='+code_of+
                  '&data_inizio_tariffa='+document.formPag.data_ini.value+
                  '&desc_tariffa='+document.formPag.desc_tariffa.value+
                  '&impt_tariffa='+document.formPag.importo_tariffa.value+
                  '&tipo_flag_modal_appl_tariffa='+tipo_importo+
                  '&code_ps='+code_ps+
                  '&code_unita_di_misura='+unitadimisura+
                  '&flag_repricing='+repricing+
                  '&code_tipo_caus='+code_tipo_caus+
                  '&code_contr='+code_contr+
                  '&listino_applicato='+document.formPag.desc_listino_applicato.value
                  ,'inserisciTariffa',asyncFunz);
}

function onRicercaAccount(txtRicerca)
{
  var headers=new Array("Contratto");
  var valori = new Array("0","1");
  riempiTabellaSelezionabilePagerEricerca(divTabella,datiContr,headers,valori,'onChangeContratto',0,10,0,'txtRicercaContratti','onRicercaAccount','onPagerAccount');
  ricaricaTabella(datiContr,code_contr);
}

function onChangeRepricing(isRepricing)
{
  if(isRepricing)
    repricing='R'
  else
    repricing ='N';
}

function onChangeUnitaDiMisura()
{
  indice= document.formPag.comboUnitaMisura.selectedIndex;
  if(indice>=0)
    unitadimisura =document.formPag.comboUnitaMisura.options[indice].value;
}

function onPagerAccount(page)
{
  var headers=new Array("Contratto");
  var valori = new Array("0","1");
  riempiTabellaSelezionabilePagerEricerca(divTabella,datiContr,headers,valori,'onChangeContratto',page,10,0,'txtRicercaContratti','onRicercaAccount','onPagerAccount');
  ricaricaTabella(datiContr,code_contr);
}

function onRicercaPs(txtRicerca)
{
  var headers=new Array("Descrizione Ps");
  var valori = new Array("0","1");
  riempiTabellaSelezionabilePagerEricerca(divTabella,datiPs,headers,valori,'onChangePs',0,10,0,'txtRicercaPs','onRicercaPs','onPagerPs');
  ricaricaTabella(datiPs,code_ps);
}

function onPagerPs(page)
{
  var headers=new Array("Descrizione Ps");
  var valori = new Array("0","1");
  riempiTabellaSelezionabilePagerEricerca(divTabella,datiPs,headers,valori,'onChangePs',page,10,0,'txtRicercaPs','onRicercaPs','onPagerPs');
  ricaricaTabella(datiPs,code_ps);
}

function ricaricaTabella(dati,valore)
{
  divTabella.style.display='block';
  divTabella.style.display='inline';
  divTabella.style.visibility='visible';
  maschera.style.display='inline';
  maschera.style.visibility='visible';
  if(!valore)
    document.formPag.btnAvanti.disabled=true;
  else
    document.formPag.btnAvanti.disabled=false;
}

function onCaricaTariffe(dati)
{
  var headers=new Array("Tariffa","Prog.","Imp.Tariffa","Tipo Imp.","Data Inizio","Data Creaz","Promozioni","Desc. OR");
  var campiFunction=new Array("Tariffa","Prog.","Promozioni");
  riempiTabellaLink(divTabellaTariffa,dati,headers,'Promozioni',campiFunction,'openPromozione');
  divTabellaTariffa.style.display='inline';
  divTabellaTariffa.style.visibility='visible';
  divIns.style.display='inline';
  divIns.style.visibility='visible';
  maschera.style.display='inline';
  maschera.style.visibility='visible';
  caricaPromozioni();
}

function onCaricaUnitaDiMisura(dati)
{
  datiUM=dati;
  riempiSelect('comboUnitaMisura',datiUM);
  onChangeUnitaDiMisura();
}

function caricaUnitaDiMisura()
{
  carica = function(dati){onCaricaUnitaDiMisura(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('','listaUnitaMisura',asyncFunz); 
}

function caricaPromozioni()
{
  carica = function(dati){onCaricaPromozioni(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  
  //R1I-13-0124 Servizi Promozioni 
  chiamaRichiesta('code_classe_of='+document.formPag.code_classe_of.value+'&codiceTipoContratto='+document.formPag.codiceTipoContratto.value+'&code_contr='+code_contr,'listaPromozioni',asyncFunz);
}

function vaiIndietro()
{
  if(step=='ps')
  {
    step='contratti';
    onCaricaAccount(datiContr);
    document.formPag.btnIndietro.disabled=true;
  }
  else if(step=='of')
  {
    step='ps';
    divTabella.style.display='inline';
    divTabella.style.visibility='visible';
    divIns.style.visibility='hidden';
    divIns.style.display='none';
    onCaricaPs(datiPs);
  }
}

function vaiAvanti()
{
  if(step=='')
  {
    document.formPag.btnIndietro.disabled=true;
    caricaContratti();
    step='contratti';
    divIns.style.display='none';
    divIns.style.visibility='hidden';
  }
  else  if(step=='contratti')
  {
    caricaPs();
    step='ps';
  }
  else if (step=='ps')
  {
    riepilogoListino.innerHTML=nomeListino;
    riepilogoPS.innerHTML=descrizione_ps;
    document.formPag.btnAvanti.disabled=true;
    caricaOF();
    divIns.style.display='inline';
    divIns.style.visibility='visible';
    divTabella.style.visibility='hidden';
    divTabella.style.display='none';
    step='of';
    resetPromozioni();
  }
}


function openPromozione(codeTariffa,codePrTariffa,codePromozione){
  var URLParam = '?CodeTariffa=' + codeTariffa + '&CodePrTariffa=' + codePrTariffa;
  var URL = 'dettaglioPromozione.jsp' + URLParam;
  //openDialog(URL, 950, 400, "", "");
  objWindows = window.openCentral(URL,'Dettaglio','toolbar=0,location=0,directories=0,status=0,menubar=no,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0',950,450);
}

function openPromozioneAdd(campoDatiPromozione){
  var descPromozione = document.getElementById(campoDatiPromozione).value;
  var div = document.getElementById(campoDatiPromozione).div;
  var dfv = document.getElementById(campoDatiPromozione).dfv;
  var divc = document.getElementById(campoDatiPromozione).divc;
  var dfvc = document.getElementById(campoDatiPromozione).dfvc;
  var cpb = document.getElementById(campoDatiPromozione).cpb;
  var numMesi = document.getElementById(campoDatiPromozione).numMesiCanoni;  
   
  var URLParam = '?descPromozione=' +descPromozione;
  URLParam = URLParam + '&div=' +div+ '&dfv=' +dfv+ '&divc=' +divc+ '&dfvc=' +dfvc+ '&cpb=' +cpb+ '&numMesi=' +numMesi;
  var URL = 'dettaglioPromozioneAdd.jsp' + URLParam;
  //openDialog(URL, 950, 400, "", "");
  objWindows = window.openCentral(URL,'Dettaglio','toolbar=0,location=0,directories=0,status=0,menubar=no,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0',950,450);
  
}

function showCalendarValid(dateField,dateInitial)
{
  if(document.formPag.data_ini_prom.value == '')
    alert('Selezionare prima la data inizio validità della promozione');
  else  
    showCalendar(dateField,dateInitial);
}

function showCalendarCanoni(dateField,dateInitial)
{
  document.formPag.mesi_canoni.value = '';
  showCalendar(dateField,dateInitial);
}

function cancelCanoni()
{
  document.formPag.data_ini_can.value = '';
  document.formPag.data_fine_can.value = '';
}

function showPromozioni(codePromozione)
{
  if(codePromozione!=0)
  {
    var indice3= document.formPag.comboOggFatt.selectedIndex;
    var code_ogg_fatrz_text3 =document.formPag.comboOggFatt.options[indice3].text;
    if(code_ogg_fatrz_text3 == 'Canone'){
      divPromozioneCanoni.style.visibility='visible';
      divPromozioneDate.style.visibility='hidden';
    }else{
      divPromozioneCanoni.style.visibility='hidden';
      divPromozioneDate.style.visibility='visible';
    }
  }
  else
  {
    divPromozioneDate.style.visibility='hidden';
    divPromozioneCanoni.style.visibility='hidden';
  }
}

function resetPromozioni()
{
  document.formPag.comboPromozioni.value = '0';
  deleteTableRowAll();
}

function AddPromoOpener(){
  var indice = document.formPag.comboPromozioni.selectedIndex;
  if(indice > 0){
    var nome_promozione =document.formPag.comboPromozioni.options[indice].text;
    var code_promozione =document.formPag.comboPromozioni.options[indice].value;
    
    var indice3= document.formPag.comboOggFatt.selectedIndex;
    var code_ogg_fatrz_text3 =document.formPag.comboOggFatt.options[indice3].text;
    var dataInizioTariffa = document.formPag.data_ini.value;
    //if(dataInizioTariffa != '' && dataInizioTariffa != null && dataInizioTariffa != undefined){
      if(PromozioneExist(code_promozione)){
      
        var URLParam = '?nome_promozione=' + nome_promozione;
        URLParam = URLParam + '&comboOggFatt=' + code_ogg_fatrz_text3;
        URLParam = URLParam + '&code_promozione=' + code_promozione;
        URLParam = URLParam + '&dataInizioTariffa=' + dataInizioTariffa;
        
        var URL = 'promozioneParamAdd.jsp' + URLParam;
        //objWindows = openDialog(URL, 950, 400, "", "");
        objWindows = window.openCentral(URL,'Aggiungi','toolbar=0,location=0,directories=0,status=0,menubar=no,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0',950,450);
      }else{
        alert('Promozione già associata.');
      }
    /*}else{
        alert('Inserire la data inizio validità della tariffa.');
    }*/
  }else{
    alert('Selezionare la promozione da associare.');
  }
}
/*controlla se la promozione è già stata inserita*/
function checkPromozione(codePromozione,descPromozione,div,dfv,divc,dfvc,codeProgBill,numMesi){
  var objTxtPromozioni = document.all.tags('INPUT');
	var strName = '';
	
	for(i=0;i<objTxtPromozioni.length;i++){
		if(objTxtPromozioni[i].typeTxt == 'PROMOZIONE'){
			strName = objTxtPromozioni[i].name.split('-');
      if(!chkDatePromozioni(div,dfv,objTxtPromozioni[i].div,objTxtPromozioni[i].dfv)){
          return false;
      }
		}
	}
	return true;
}

/*controllo se la promozione è già associata*/
function PromozioneExist(codePromozione){
	var objTxtPromozioni = document.all.tags('INPUT');
	var strName = '';
  for(i=0;i<objTxtPromozioni.length;i++){
    if(objTxtPromozioni[i].typeTxt == 'PROMOZIONE'){
			strName = objTxtPromozioni[i].promozioneId;
			if(strName==codePromozione){
				return false;
			}
		}
	}
	return true;
}

function chkDatePromozioni(strDataInizioNew, strDataFineNew, strDataInizioOld, strDataFineOld){
  var dataInizioNew = new Date(strDataInizioNew.substring(6,10),strDataInizioNew.substring(3,5)-1,strDataInizioNew.substring(0,2));
  var dataFineNew   = new Date(strDataFineNew.substring(6,10),strDataFineNew.substring(3,5)-1,strDataFineNew.substring(0,2));
  var dataInizioOld = new Date(strDataInizioOld.substring(6,10),strDataInizioOld.substring(3,5)-1,strDataInizioOld.substring(0,2));
  var dataFineOld   = new Date(strDataFineOld.substring(6,10),strDataFineOld.substring(3,5)-1,strDataFineOld.substring(0,2));
  
  if(dataInizioNew<dataInizioOld && dataFineNew<dataInizioOld){
    return true;
  }else  if(dataInizioNew>dataFineOld){
    return true;
  }
  return false;
}

function salvaTmpDatiPromozione(objPromo)
{
  carica = function(dati){onSalvaTmpDatiPromozione(dati[0].messaggio)};
  errore = function(dati){onSalvaTmpDatiPromozione(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};

  chiamaRichiesta('user_name='+document.formPag.userName.value+
                  '&code_promozione='+objPromo.promozioneId+
                  '&data_da='+objPromo.div+
                  '&data_a='+objPromo.dfv+
                  '&data_da_can='+objPromo.divc+
                  '&data_a_can='+objPromo.dfvc+
                  '&num_Mesi='+objPromo.numMesiCanoni+
                  '&codice_prog_bill='+objPromo.cpb+
                  '&flag_attiva='+flag_attiva
                  ,'addPromozioniSession',asyncFunz);
}

function onSalvaTmpDatiPromozione(dati)
{
  delete arrayPromozioniAss[indiceApp];
  var checkVettorePromozioni = false;
  for(i = 0; i<arrayPromozioniAss.length; i++){
    if(arrayPromozioniAss[i] != undefined){
      checkVettorePromozioni = true;
    }
  }
  
  if(checkVettorePromozioni)
    ONSALVA();
  else
    salvaDatiTariffa();
}

function removeSessionPromozioni(){
  carica = function(dati){onRemoveSessionPromozioni(dati[0].messaggio)};
  errore = function(dati){onRemoveSessionPromozioni(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};

  chiamaRichiesta('user_name='+document.formPag.userName.value
                  ,'removePromozioniSession',asyncFunz);
}

function onRemoveSessionPromozioni(dati)
{
  /*niente*/
}