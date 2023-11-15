var status='';
var codeAccountSel="";
var codeProgettoSel = "";
var codePromozioneSel = "";
var datiPromoAccount;
var title='&nbsp;Selezione Promozione Codice Progetto';

/*---------------------------------------------------EVENTI-------------------------------------------------------------*/
var currPage='';
var msgEvent='';
var prevPage='';

function caricaList(onAnnulla){

    title = "&nbsp;Selezione Promozione Codice Progetto" 
    
    document.getElementsByName("PageTitle")[0].innerHTML=title;

    divRicercaAreeOperatori.style.display = 'inline';
    divRicercaAreeOperatori.style.visibility = 'visible';
    
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
    carica = function(dati){onCaricaList(dati,serviziIndex,accountIndex,testoRicerca,10)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('','promoProgetto',asyncFunz);   
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
  var r = confirm("Associazione ACCOUNT = "+ codeAccountSel + " e CODE PROGETTO = "+ codeProgettoSel +" sara' eliminata definitivamente! Proseguire?");
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
    
    chiamaRichiesta('&codeAccount='+codeAccountSel+'&codeProgetto='+codeProgettoSel+'&codePromozione='+codePromozioneSel,'eliminaPromoProgetto',asyncFunz);
  } 
}
/*----------------------------------------------------FINE EVENTI---------------------------------------------------------*/

function onCaricaList( dati, serviziIndex, accountIndex, testoRicerca, perPag ){
  currPage = 'listini';
  datiPromoAccount = dati;
  var headers = new Array("Codice   Account ","Descrizione Account ","Codice    Progetto ", "Codice    Promozione ", "Data             Inizio ", "Data              Fine ");
  var valori = new Array("0", "1", "2", "3", "4", "5");// rappresenta il numero di parametri della function onChangeListino
  
  riempiTabellaSelezionabilePagerEricercaCombo(divTabellaAreeOperatori,datiPromoAccount,headers,valori,'onChangePromoProgetto',0,perPag,null,'inputTxtRicerca','onRicercaList','onPagerList');

  if( datiPromoAccount.length == 0 ){
    document.getElementsByName("ELIMINA")[0].className = "textBHide";
  }else{
    document.getElementsByName("ELIMINA")[0].className = "textB";
  }
  
  if( serviziIndex == 'undefined' && accountIndex == 'undefined' && testoRicerca == 'undefined' ){ 
    
      riempiTabellaRicercaPromozioniProgetto(divRicercaAreeOperatori,datiPromoAccount,headers,valori,'onChangePromoProgetto',0,perPag,null,'inputTxtRicerca','onRicercaList','onPagerList');

      caricaServizi = function(datiServizi){onCaricaServizi(datiServizi,0,-1,null)};
      erroreServizi = function(datiServizi){gestisciMessaggio(datiServizi[0].messaggio);};
      asyncFunzServizi=  function(){ handler_generico(http,caricaServizi,erroreServizi);};
      //chiama la com.strutturaweb.action.ActionFactory.java
      chiamaRichiesta('','promoProgettoServizi',asyncFunzServizi); 
  }
}

function onCaricaServizi( datiServizi, serviziIndex, accountIndex, testoRicerca, isnuovo){
    riempiSelectByElementName("Servizi",datiServizi);
    
    if( serviziIndex != 0 && accountIndex != -1 ){
        document.getElementsByName("Servizi")[0].selectedIndex = serviziIndex;
        Servizio( accountIndex, isnuovo );
        document.getElementsByName("Account")[0].disabled = false;
        document.getElementsByName("Promozioni")[0].disabled = false;
    }else{
        document.getElementsByName("Account")[0].disabled = true;
        document.getElementsByName("Promozioni")[0].disabled = true;
    }
 
    document.getElementsByName("Account")[0].style.width = 'auto';
    document.getElementsByName("Promozioni")[0].style.width = 'auto';
}

function onCaricaAreeRaccolta(dati){
 // riempiSelectByElementName("AreaRaccolta",dati);     
}

function onChangeListino( nomeListinoSelezionato ){
  nomeListino = nomeListinoSelezionato;
}

function onChangePromoProgetto(codeAccount, codeAccountDesc, codeProgetto, codePromozione){
    if( codeAccount && codeProgetto ){
        codeAccountSel = codeAccount;
        codeProgettoSel = codeProgetto; 
        codePromozioneSel = codePromozione;
    }
}

function onRicercaList(txtRicerca){
    //var serviziIndex = document.getElementsByName("Servizi")[0].selectedIndex;
    var accountLength = document.formPag.Account.options.length;
    var serviziLengh = document.formPag.Servizi.options.length;
    var promozioniLengh = document.formPag.Promozioni.options.length;
    
    if( accountLength !=0 && accountLength != "undefined" ){
        var accountIndex = document.getElementsByName("Account")[0].selectedIndex;
        var codeAccount = document.getElementsByName("Account")[0].options[accountIndex].value;
    } else {
        accountIndex = 0;
        codeAccount = '';
    }
    
    if ( serviziLengh != 0 && serviziLengh != "undefined" )  {
        var serviziIndex = document.getElementsByName("Servizi")[0].selectedIndex;
        var codeServizio = document.getElementsByName("Servizi")[0].options[serviziIndex].value;
    } else {
        serviziIndex = 0;
        codeServizio = '';
    }
 
     if ( promozioniLengh != 0 && promozioniLengh != "undefined" )  {
        var promozioniIndex = document.getElementsByName("Promozioni")[0].selectedIndex;
        var codePromozione = document.getElementsByName("Promozioni")[0].options[promozioniIndex].value;
    } else {
        promozioniIndex = 0;
        codePromozione = '';
    }
    
    var perPagIndex = document.getElementsByName("inputTxtRicerca_combo")[0].selectedIndex;
    var perPag = document.getElementsByName("inputTxtRicerca_combo")[0].options[perPagIndex].value;
 
    var codeProgetto = document.getElementsByName("inputTxtRicerca")[0].value; 

    carica = function(dati){onCaricaList(dati,serviziIndex,accountIndex,codeProgetto,perPag)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    //chiama la com.strutturaweb.action.ActionFactory.java
     chiamaRichiesta('&codeAccount='+codeAccount+'&codeProgetto='+codeProgetto+'&codeServizio='+codeServizio+'&codePromozione='+codePromozione,'promoProgetto',asyncFunz);
}

function onPagerList(page){
    var serviziIndex= document.getElementsByName("Servizi")[0].selectedIndex;
    var accountIndex= document.getElementsByName("Account")[0].selectedIndex;
    var testoRicerca = document.getElementsByName("inputTxtRicerca")[0].value;
 
    var headers = new Array("Codice   Account ","Descrizione Account ","Codice   Progetto ", "Codice   Promozione ", "Data            Inizio ", "Data               Fine ");
    var valori = new Array("0", "1", "2", "3", "4", "5");
    
    riempiTabellaSelezionabilePagerEricercaCombo(divTabellaAreeOperatori,datiPromoAccount,headers,valori,'onChangePromoProgetto',page,10,1,'inputTxtRicerca','onRicercaList','onPagerList').length;
    
    ricaricaTabella(datiPromoAccount);
    
    caricaServizi = function(datiServizi){onCaricaServizi(datiServizi,serviziIndex,accountIndex,testoRicerca)};
    erroreServizi = function(datiServizi){gestisciMessaggio(datiServizi[0].messaggio);};
    asyncFunzServizi =  function(){ handler_generico(http,caricaServizi,erroreServizi);};
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('','promoProgettoServizi',asyncFunzServizi);
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
    
    //|            | ONDETTAGLIO  |  ONNUOVO  |  ONANNULLA  |  ONAGGIORNA  |  ONSALVA             |    aggiornaKO        |    nuovoKO           |    OK     |
    //|-----------------------------------------------------------------------------------------------------------------------------------------------------|
    //|  listini   | dettaglio    |  nuovo    |      X      |       X      |     X                |                      |                      |           |  
    //|  dettaglio |     X        |     X     |  listini    |  aggiorna    |     X                |                      |                      |           |
    //|  aggiorna  |     X        |     X     |  dettaglio  |       X      |    messaggio         |                      |                      |           |
    //|  nuovo     |     X        |     X     |  listini    |       X      |    dettaglio         |                      |                      |           |
    //|  error     |     X        |     X     |      X      |       X      |     X                |                      |                      |           |
    //|  messaggio |     X        |     X     |      X      |       X      |     X                |       aggiorna       |     nuovo            | dettaglio |
     
     prevPage=page;
     if( page == 'listini' ){
        if(event == 'ONDETTAGLIO'){
            currPage = 'listini';
            ONNUOVO();
        }
        else if( event == 'ONNUOVO' ){
            currPage = 'nuovo';
            
            title = '&nbsp;Nuova Promozione Progetto';  
            
            divRicercaAreeOperatori.style.display = 'none';
            divRicercaAreeOperatori.style.visibility = 'hidden';
            divTabellaAreeOperatori.style.display = 'none';
            divTabellaAreeOperatori.style.visibility = 'hidden';
            
            /* abilita area inserimento */
            divIns.style.display = 'inline';
            divIns.style.visibility = 'visible';
            
            var servizi = document.getElementsByName("Servizi")[0];
            var account = document.getElementsByName("Account")[0];
            var promozioni = document.getElementsByName("Promozioni")[0];
            var dtIni = document.getElementsByName("txtDataIni")[0];
            var dtFin = document.getElementsByName("txtDataFin")[0];
            
            account.selectedIndex = 0;
            promozioni.selectedIndex = 0;
            //divServizi.innerHTML="";
            //divAccount.innerHTML="";
            servizi.selectedIndex = 0;
            account.disabled = true;    
            promozioni.disabled = true;
            dtIni.value = "";
            dtFin.value = "";
            divServizi.appendChild( servizi );          
            divAccount.appendChild( account );
            divCodicePromozione.appendChild( promozioni );
            
            divAccount.innerHTML = '<select class="text" name="Account" id="Account" onchange="onAccount()"><option value="" selected disabled >Selezionare Account</option></select>';
            divCodiceProgetto.innerHTML = '<input class="text" name="CodiceProgetto" id="CodiceProgetto" selected disabled onchange="onCodiceProgetto()" style="text-transform: uppercase" value="Inserire Codice Progetto" maxlength="10">';
            divCodicePromozione.innerHTML = '<select class="text" name="Promozioni" id="Promozioni" ><option value="" selected disabled >Selezionare Promozione</option></select>';
            
            divButtonList.style.display = 'none';
            divButtonList.style.visibility = 'hidden';
            
            divButtonNuovo.style.display = 'inline';
            divButtonNuovo.style.visibility = 'visible';
            
            var carica = function(dati){onCaricaAreeRaccolta(dati);};
            var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
            var asyncFunz=  function(){ handler_generico(http,carica,errore);};
            
            chiamaRichiesta('','promoProgettoAccount',asyncFunz);
            
            document.getElementsByName("PageTitle")[0].innerHTML = title;
        }        
     }
     else if(page=='nuovo'){
        if(event == 'ONANNULLA'){ 
             var servizi = document.getElementsByName("Servizi")[0];
             var account = document.getElementsByName("Account")[0];
             var promozioni = document.getElementsByName("Promozioni")[0];
             
             account.selectedIndex = 0;          
             servizi.selectedIndex = 0;
             promozioni.selectedIndex = 0;
             
             account.disabled = true;
             promozioni.disables = true;
             
             tableRicerca.rows[1].cells[1].appendChild(servizi);
             tableRicerca.rows[2].cells[1].appendChild(account);
             tableRicerca.rows[3].cells[1].appendChild(promozioni);
             tableRicerca.rows[1].cells[3].childNodes[0].value="";
             
             caricaList(true);
        }
        else if(event == 'ONSALVA'){   
            var codeServizio = document.getElementById("Servizi").value;
            var codeAccount = document.getElementById("Account").value;
            var codeProgetto= document.getElementsByName("CodiceProgetto")[0].value;
            var codePromozione = document.getElementById("Promozioni").value;
            var dataIni = document.getElementsByName("txtDataIni")[0].value;
            var dataFin = document.getElementsByName("txtDataFin")[0].value;

            if(validaFormInserimento( codeServizio, codeAccount, codeProgetto, codePromozione, dataIni, dataFin )){
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
                var action = 'inserisciPromoProgetto';

                chiamaRichiesta('&codeAccount='+codeAccount+'&codeProgetto='+codeProgetto+'&codePromozione='+codePromozione+
                                '&dataIni='+dataIni+'&dataFin='+dataFin,action,asyncFunz);
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
            divIns.style.visibility = 'hidden'; 
            divIns.style.display = 'none';
         
            changePage( 'listini', 'ONDETTAGLIO' );
         
            var servizi = document.getElementsByName("Servizi")[0];
            var account = document.getElementsByName("Account")[0];
            var promozioni = document.getElementsByName("Promozioni")[0];
            
            servizi.selectedIndex = 0;
            account.disabled = true;  
            promozioni.disabled = true;
        }
        else if(msgEvent == 'elimina'){
            var servizi = document.getElementsByName("Servizi")[0];
            var account = document.getElementsByName("Account")[0];
            var promozioni = document.getElementsByName("Promozioni")[0];
            
            account.selectedIndex = 0;          
            servizi.selectedIndex = 0;
            promozioni.selectedIndex = 0;
            
            account.disabled = true;
            promozioni.disabled = true;
            
            tableRicerca.rows[1].cells[1].appendChild(servizi);
            tableRicerca.rows[2].cells[1].appendChild(account);
            tableRicerca.rows[3].cells[1].appendChild(promozioni);
            tableRicerca.rows[1].cells[3].childNodes[0].value = "";
            
            caricaList(true);        
         }
     }     
}

function validaFormInserimento(codeServizio,codeAccount, codeProgetto, codePromozione, dataIni, dataFin){
    if( codeServizio == '' ){
        alert('Servizio non selezionato');
        return false;
    }
    if( codeAccount == '' ){
        alert('Account non selezionato');
        return false;
    }
    if( codeProgetto == '' ){
        alert('Codice Progetto non specificato');
        return false;
    }

    if( codePromozione == '' ){
        alert('Codice Promozione non specificato');
        return false;
    }

    if( dataIni == '' ){
        alert('Data inizio non specificata');
        return false;
    }

    if( dataFin == '' ){
        alert('Data Fine non specificata');
        return false;
    }    
    return true;
}

function Servizio(accountIndex,isnuovo){
    indice = document.getElementsByName("Servizi")[0].selectedIndex;
    var codeServizio = document.getElementsByName("Servizi")[0].options[indice].value;
    
    if(codeServizio != ''){
        Account(codeServizio,accountIndex);
        document.getElementsByName("Account")[0].disabled = false; 
        document.getElementsByName("Promozioni")[0].disabled = false; 
    }else{
        document.getElementsByName("Account")[0].disabled = true;
        document.getElementsByName("Account")[0].selectedIndex=0;
        document.getElementsByName("Promozioni")[0].disabled = true;
        document.getElementsByName("Promozioni")[0].selectedIndex=0;

        setDisabledCodiceProgetto(true,currPage);
    }
}

function Account( codeServizio, accountIndex ){
    var carica = function(dati){onCaricaSelectAccount(dati,accountIndex);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    parametri = 'codeServizio='+codeServizio;
    chiamaRichiesta(parametri,'promoProgettoAccount',asyncFunz);
}

function Promozioni(){
    var carica = function(dati2){onCaricaSelectPromozioni(dati2);};
    var errore = function(dati2){gestisciMessaggio(dati2[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('','promoProgettoPromozioni',asyncFunz);
}


function onCaricaSelectPromozioni(dati2){
    riempiSelectByElementName( "Promozioni", dati2 );
}


function onCaricaSelectAccount(dati,accountIndex){
    riempiSelectByElementName( "Account", dati );
    if( accountIndex != null && accountIndex != 'undefined' ){
        document.getElementsByName("Account")[0].selectedIndex = accountIndex;
    }        
}

function onAccount(){
    if( document.getElementsByName("Account")[0].selectedIndex === 0 ){
        setDisabledCodiceProgetto( true, currPage ); 
    } else {
        setDisabledCodiceProgetto( false, currPage );
        Promozioni();
    }
}

function setDisabledCodiceProgetto( _disabled, currPage ){
    if ( currPage == 'nuovo' ) {
        document.getElementsByName("CodiceProgetto")[0].disabled = _disabled;
        if( _disabled ){
            document.getElementsByName("CodiceProgetto")[0].value = 'Inserire Codice Progetto';
        }else{
            document.getElementsByName("CodiceProgetto")[0].value = '';
        }
    }
}

function onCodiceProgetto(){}