var status='';
var codeServizioSel="";
var codeProgettoSel = "";
var datiCodiceProgetto;
var dataDiRiferimento = "";
var dataDiRiferimentoSel = "";
var codeTipologiaSel = "";
var codeAccountSel = "";
var title='&nbsp;Selezione Societa Intercompany';
var NO_SERVIZIO_LOGICO = "-9"
/*---------------------------------------------------EVENTI-------------------------------------------------------------*/
var currPage='';
var msgEvent='';
var prevPage='';

function caricaList(onAnnulla){

    title = "&nbsp;Selezione Societa Intercompany" 
    
    document.getElementsByName("PageTitle")[0].innerHTML=title;
    
    divTabellaAreeOperatori.style.display = 'inline';
    divTabellaAreeOperatori.style.visibility = 'visible';
    divIns.style.display = 'none';
    divIns.style.visibility = 'hidden';

    divButtonList.style.display = 'inline';
    divButtonList.style.visibility = 'visible';
    
    divButtonNuovo.style.display = 'none';
    divButtonNuovo.style.visibility = 'hidden';
    var serviziIndex = 'undefined';
    var accountIndex = 'undefined';
    var testoRicerca = 'undefined';
    
           
    if( typeof onAnnulla !== 'undefined' ){
        serviziIndex = 0;
        accountIndex = 0;
        testoRicerca = 0;
    }
    
    carica = function(dati){onCaricaList(dati,serviziIndex,testoRicerca,10)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz =  function(){ handler_generico(http,carica,errore);};
 
    chiamaRichiesta('','Intercompany',asyncFunz);   
}
function ONDETTAGLIO(){   
    changePage( currPage, 'ONDETTAGLIO' );
}

function ONNUOVO(){
    msgEvent = '';
    changePage( currPage, 'ONNUOVO' );
}

function ONANNULLA(){
    msgEvent = '';
    changePage( currPage, 'ONANNULLA' );
}

function ONSALVA(){  
    changePage( currPage, 'ONSALVA' );
}

function nascondiErrore(){
   maschera.style.visibility = 'visible';
   maschera.style.display = 'block';
   
   dvMessaggio.style.display = 'none';
   dvMessaggio.style.visibility = 'hidden';
  
   changePage( 'messaggio', msgEvent );
}

function ONELIMINA(){
  var r = confirm("SOCIETA' INTERCOMPANY = "+ codeProgettoSel +" sara' eliminata definitivamente! Proseguire?");
  if (r == true) {
    carica = function(dati){
                      gestisciMessaggio(dati[0].text);
                      msgEvent='elimina';
                    };
    errore = function(dati){
              gestisciMessaggio(dati[0].messaggio);
              msgEvent='elimina';
            };
    asyncFunz=  function(){ handler_generico(http,carica,errore);};

    chiamaRichiesta('&codeCliente='+codeProgettoSel,'eliminaIntercompany',asyncFunz);
  } 
}
/*----------------------------------------------------FINE EVENTI---------------------------------------------------------*/

function onCaricaList( dati, serviziIndex, testoRicerca, perPag ){
  currPage = 'listini';
  datiCodiceProgetto = dati;
  //var headers = new Array("Code Account","Account","Tipologia","Servizio Logico","Societa Intercompany","Data Contrattualizzata");
  var headers = new Array("Code Cliente","Denominazione");
  var valori = new Array("0", "1");// rappresenta il numero di parametri della function onChangeCodiceCliente
  
  riempiTabellaSelezionabilePagerEricercaCombo(divTabellaAreeOperatori,datiCodiceProgetto,headers,valori,'onChangeCodiceCliente',0,perPag,null,'inputTxtRicerca','onRicercaList','onPagerList');

  if( datiCodiceProgetto.length == 0 ){
    document.getElementsByName("ELIMINA")[0].className = "textBHide";
  }else{
    document.getElementsByName("ELIMINA")[0].className = "textB";
  }
  
  if( (serviziIndex == 'undefined' ) && (testoRicerca == 'undefined' ) ){
    

            
      caricaServizi = function(datiServizi){onCaricaServizi(datiServizi,0,-1)};
      erroreServizi = function(datiServizi){gestisciMessaggio(datiServizi[0].messaggio);};
      asyncFunzServizi=  function(){ handler_generico(http,caricaServizi,erroreServizi);};
      //chiama la com.strutturaweb.action.ActionFactory.java
      chiamaRichiesta('','codiceProgettoServizi',asyncFunzServizi); 
  }
}

function onCaricaServizi( datiServizi, serviziIndex, accountIndex, testoRicerca ){
    riempiSelectByElementName("Servizi",datiServizi);
    
    if( serviziIndex != 0 && accountIndex != -1 ){
        document.getElementsByName("Servizi")[0].selectedIndex = serviziIndex;
        Servizio( accountIndex, isnuovo );
        document.getElementsByName("Account")[0].disabled = false;
    }else{
        document.getElementsByName("Account")[0].disabled = true;
    }
 
    document.getElementsByName("Account")[0].style.width = 'auto';
}

function onCaricaAreeRaccolta(dati){
 // riempiSelectByElementName("AreaRaccolta",dati);     
}

function onChangeListino( nomeListinoSelezionato ){
  nomeListino = nomeListinoSelezionato;
}

function onChangeCodiceCliente(codeCliente, denominazione) {
    if( codeCliente && denominazione ){

        codeProgettoSel = codeCliente;        
    }    
}

function onRicercaList(txtRicerca){
    var serviziIndex = document.getElementsByName("Servizi")[0].selectedIndex;
    var accountLength = document.formPag.Account.options.length;
 
    if( accountLength !=0 && accountLength != "undefined" ){
        var accountIndex = document.getElementsByName("Account")[0].selectedIndex;
        var codeAccount = document.getElementsByName("Account")[0].options[accountIndex].value;
    }else{
        accountIndex = 0;
        codeAccount = '';
    }
    
    var perPagIndex = document.getElementsByName("inputTxtRicerca_combo")[0].selectedIndex;
    var perPag = document.getElementsByName("inputTxtRicerca_combo")[0].options[perPagIndex].value;

    var serviziLogici = document.getElementsByName("Servizi")[0].options[serviziIndex].value;
    var codeProgetto = document.getElementsByName("inputTxtRicerca")[0].value; 
    
    carica = function(dati){onCaricaList(dati,serviziIndex,accountIndex,perPag)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz =  function(){ handler_generico(http,carica,errore);};
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('&codeServizioLogico='+serviziLogici+'&codeProgetto='+codeProgetto+'&codeAccount='+codeAccount,'codiceProgetto',asyncFunz); //TODO Da aggiungere parametri
}

function onPagerList(page){
    var serviziIndex= document.getElementsByName("Servizi")[0].selectedIndex;
    var accountIndex= document.getElementsByName("Account")[0].selectedIndex;
    var testoRicerca = document.getElementsByName("inputTxtRicerca")[0].value;
 
    //var headers = new Array("Code Account","Account","Tipologia","Servizio Logico","Societa Intercompany","Data Contrattualizzata");
    var headers = new Array("Code Cliente","Denominazione");
    var valori = new Array("0", "1");// rappresenta il numero di parametri della function onChangeCodiceCliente
    
    riempiTabellaSelezionabilePagerEricercaCombo(divTabellaAreeOperatori,datiCodiceProgetto,headers,valori,'onChangeCodiceCliente',page,10,1,'inputTxtRicerca','onRicercaList','onPagerList').length;
    
    ricaricaTabella(datiCodiceProgetto);
    
    caricaServizi = function(datiServizi){onCaricaServizi(datiServizi,serviziIndex,accountIndex,testoRicerca)};
    erroreServizi = function(datiServizi){gestisciMessaggio(datiServizi[0].messaggio);};
    asyncFunzServizi =  function(){ handler_generico(http,caricaServizi,erroreServizi);};
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('','codiceProgettoServizi',asyncFunzServizi);
}

function ricaricaTabella(dati){
    divTabellaAreeOperatori.style.display = 'block';
    divTabellaAreeOperatori.style.display = 'inline';
    divTabellaAreeOperatori.style.visibility = 'visible';
    divTabellaAreeOperatori.getElementsByTagName("table")[0].style.width = '75%';
    
    maschera.style.display = 'inline';
    maschera.style.visibility = 'visible';
}

function showPageTitle(){
  return title;
}

function changePage(page,event){
     prevPage=page;
     if( page == 'listini' ){
        if(event == 'ONDETTAGLIO'){
            currPage = 'listini';
            ONNUOVO();
        }
        else if( event == 'ONNUOVO' ){
            currPage = 'nuovo';

            title = '&nbsp;Nuova Societa Intercompany';  
            
            divTabellaAreeOperatori.style.display = 'none';
            divTabellaAreeOperatori.style.visibility = 'hidden';
            //alert('sono qui 2 '); 
            /* abilita area inserimento */
            divIns.style.display = 'inline';
            divIns.style.visibility = 'visible';
            /*
            var servizi = document.getElementsByName("Servizi")[0];
            var account = document.getElementsByName("Account")[0];
            account.selectedIndex = 0;
            servizi.selectedIndex = 0;
     
            divServizi.appendChild( servizi );          
            divAccount.appendChild( account );
            
            divAccount.innerHTML = '<select class="text" name="Account" id="Account" ><option value="-9" selected disabled >Nessun Account</option></select>';
            divCodiceProgetto.innerHTML = '<input class="text" name="CodiceProgetto" id="CodiceProgetto" style="text-transform: uppercase" maxlength="10">';
            divTipologia.innerHTML = '<select class="text" name="Tipologia" id="Tipologia" ><option value="" selected disabled >Selezionare Tipologia</option></select>';
            alert('sono qui 3'); 
            document.getElementsByName("Account")[0].disabled = true; 
            
            var cancellaBt = "<a href=\"javascript:cancelCalendar();\" onMouseOver=\"javascript:showMessage('cancella'); return true;\" onMouseOut=\"status='';return true\"><img name='cancel' src=\"../../common/images/body/cancella.gif\" border=\"0\"></a>";
            var dataInputTxt ="<input type=\"text\" class=\"text\" name=\"txtDataDiRiferimento\" id=\"txtDataDiRiferimento\" maxlength=\"10\" size=\"10\" disabled=\"true\">";
            var calendario ="<a href=\"javascript:showCalendar('formPag.txtDataDiRiferimento','sysdate');\" onMouseOver=\"javascript:showMessage('seleziona'); return true;\" onMouseOut=\"status='';return true\">";
            var calendarioImg ="<img name=\"calendar\" src=\"../../common/images/body/calendario.gif\" border=\"no\"></a>";
            divDataDiRiferimento.innerHTML = "<table><tr><td>"+dataInputTxt+"</td><td>"+calendario+calendarioImg+"</td><td>"+cancellaBt+"</td></tr></table>";
         */
            
            var CodeClienteTxt ="<input type=\"text\" class=\"text\" name=\"txtCodeCliente\" id=\"txtCodeCliente\" maxlength=\"10\" size=\"30\" >";
            var DenominazioneTxt ="<input type=\"text\" class=\"text\" name=\"txtDenominazione\" id=\"txtDenominazione\" maxlength=\"100\" size=\"50\" >";
            divCodeCliente.innerHTML = "<table><tr><td>"+CodeClienteTxt+"</td></tr></table>";
            divDenominazione.innerHTML = "<table><tr><td>"+DenominazioneTxt+"</td></tr></table>";
            
            divButtonList.style.display = 'none';
            divButtonList.style.visibility = 'hidden';

            divButtonNuovo.style.display = 'inline';
            divButtonNuovo.style.visibility = 'visible';
            
            var carica = function(dati){onCaricaAreeRaccolta(dati);};
            var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
            var asyncFunz=  function(){ handler_generico(http,carica,errore);};

            chiamaRichiesta('','codiceProgettoAccount',asyncFunz);

            caricaCmbTipologia();

            document.getElementsByName("PageTitle")[0].innerHTML = title;
        }        
     }
     else if(page=='nuovo'){
        if(event == 'ONANNULLA'){ 
             /*var servizi = document.getElementsByName("Servizi")[0];
             var account = document.getElementsByName("Account")[0];
             
             account.selectedIndex = 0;          
             servizi.selectedIndex = 0;
             
             account.disabled = true;
             
             tableRicerca.rows[1].cells[1].appendChild(servizi);
             tableRicerca.rows[2].cells[1].appendChild(account);
             tableRicerca.rows[1].cells[3].childNodes[0].value="";
             */
             caricaList(true);
        }
        else if(event == 'ONSALVA'){   
            var codeCliente = document.getElementById("txtCodeCliente").value;
            var denominazione = document.getElementById("txtDenominazione").value;

            if(validaFormInserimento( codeCliente, denominazione )){
                currPage = 'messaggio';
                carica = function(dati){
                            msgEvent='nuovoOK';
                            gestisciMessaggio(dati[0].text);
                          };
                errore = function(dati){
                            gestisciMessaggio(dati[0].messaggio);
                            msgEvent='nuovoKO';
                          };
                asyncFunz = function(){ handler_generico(http,carica,errore);};  
                
                var action = 'inserisciIntercompany';
                
                chiamaRichiesta('&codeCliente='+codeCliente+'&denominazione='+denominazione,action,asyncFunz);

            }
        }
     }
     else if( page == 'messaggio' ){
        if( msgEvent == 'nuovoKO' ){
            currPage = "nuovo";
          
            divIns.style.display = 'inline';
            divIns.style.visibility = 'visible';        
        }
        else if(msgEvent == 'nuovoOK'){

            caricaList(true);
        }
        else if(msgEvent == 'elimina'){

            caricaList(true);        
         }
     }     
}

function validaFormInserimento(tipologia, codeProgetto ) {
    if( tipologia  == '' ){
        alert('Codice Cliente non specificato');
        return false;
    }
    if( codeProgetto == '' ){
        alert('Denominazione non specificata');
        return false;
    }
    
    return true;
}

function Servizio(accountIndex,isnuovo) {
    indice = document.getElementsByName("Servizi")[0].selectedIndex;
    var codeServizioLogico = document.getElementsByName("Servizi")[0].options[indice].value;
    
    if( codeServizioLogico != NO_SERVIZIO_LOGICO ){
        Account(codeServizioLogico,accountIndex);
        document.getElementsByName("Account")[0].disabled = false; 
        //setDisabledCodiceProgetto(false,currPage);
    }else{
        document.getElementsByName("Account")[0].disabled = true;
        document.getElementsByName("Account")[0].selectedIndex=0;
        //setDisabledCodiceProgetto(true,currPage);
    }
}

function Account( codeServizioLogico, accountIndex ) {
    var carica = function(dati){onCaricaSelectAccount(dati,accountIndex);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    var parametri = 'codeServizioLogico='+codeServizioLogico;
    chiamaRichiesta(parametri,'codiceProgettoAccount',asyncFunz);
}

function onCaricaSelectAccount(dati,accountIndex) {
    riempiSelectByElementName( "Account", dati );
    if( accountIndex != null && accountIndex != 'undefined' ) {
        document.getElementsByName("Account")[0].selectedIndex = accountIndex;
    }        
}

function setDisabledCodiceProgetto( _disabled, currPage ) {
    if ( currPage == 'nuovo' ) {
        document.getElementsByName("CodiceProgetto")[0].disabled = _disabled;
    }
}

function cancelCalendar() {
   window.document.formPag.txtDataDiRiferimento.value = "";
}

function onCaricaTipologia(dati){
    riempiSelectByElementName( "Tipologia", dati );
}

function caricaCmbTipologia(){
    var carica = function(dati){onCaricaTipologia(dati);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
            
    chiamaRichiesta('','codiceProgettoTipologia',asyncFunz);
}