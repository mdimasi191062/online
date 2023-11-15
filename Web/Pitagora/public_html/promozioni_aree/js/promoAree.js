var status='';
var codeAccountSel="";
var codeAreaSel="";
var datiAreeAccount;
var title='&nbsp;Selezione Aree Raccolta Operatori';

/*---------------------------------------------------EVENTI-------------------------------------------------------------*/
var currPage='';
var msgEvent='';
var prevPage='';

function caricaList(onAnnulla){
    title="&nbsp;Selezione Promozione Aree"
    document.getElementsByName("PageTitle")[0].innerHTML=title;

    divRicercaAreeOperatori.style.display='inline';
    divRicercaAreeOperatori.style.visibility='visible';
    
    divTabellaAreeOperatori.style.display='inline';
    divTabellaAreeOperatori.style.visibility='visible';
    divIns.style.display='none';
    divIns.style.visibility='hidden';

    divButtonList.style.display='inline';
    divButtonList.style.visibility='visible';
    
    divButtonNuovo.style.display='none';
    divButtonNuovo.style.visibility='hidden';
    var serviziIndex='undefined';
    var accountIndex='undefined';
    var testoRicerca='undefined';
    
    if(typeof onAnnulla !== 'undefined'){
     serviziIndex=0;
     accountIndex=0;
     testoRicerca=0;
    }
    carica = function(dati){onCaricaList(dati,serviziIndex,accountIndex,testoRicerca,10)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('','promoAree',asyncFunz);   
}
function ONDETTAGLIO()
{   
    changePage(currPage,'ONDETTAGLIO');
}

function ONNUOVO()
{
    msgEvent='';
    changePage(currPage,'ONNUOVO');
}

function ONANNULLA()
{
    msgEvent='';
    changePage(currPage,'ONANNULLA');
}

function ONSALVA()
{  
  changePage(currPage,'ONSALVA');
}
function nascondiErrore()
{
   maschera.style.visibility='visible';
   maschera.style.display='block';
   dvMessaggio.style.display='none';
   dvMessaggio.style.visibility='hidden';
  
   changePage('messaggio',msgEvent);
}

function ONELIMINA()
{
  var r = confirm("La promozione per l'area CODE_AREA = "+codeAreaSel+ " e CODE ACCOUNT= "+ codeAccountSel +" sara' eliminata definitivamente! Proseguire?");
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
    chiamaRichiesta('&codeAccount='+codeAccountSel+'&codeArea='+codeAreaSel,'eliminaPromoArea',asyncFunz);
  } 
}
/*----------------------------------------------------FINE EVENTI---------------------------------------------------------*/

function onCaricaList(dati,serviziIndex,accountIndex,testoRicerca,perPag)
{
  currPage='listini';
  datiAreeAccount=dati;  
  var headers=new Array("Codice Promozione Area","Account","Area Raccolta","Codice Area Raccolta");
  var valori = new Array("0");// rappresenta il numero di parametri della function onChangeListino
  
  riempiTabellaSelezionabilePagerEricercaCombo(divTabellaAreeOperatori,datiAreeAccount,headers,valori,'onChangePromoArea',0,perPag,null,'inputTxtRicerca','onRicercaList','onPagerList');

  if(datiAreeAccount.length==0){
    document.getElementsByName("ELIMINA")[0].className="textBHide";
  }
  else{
   document.getElementsByName("ELIMINA")[0].className="textB";
  }
  if(serviziIndex=='undefined' && accountIndex=='undefined' && testoRicerca=='undefined'){ 
    
      riempiTabellaRicerca(divRicercaAreeOperatori,datiAreeAccount,headers,valori,'onChangePromoArea',0,perPag,null,'inputTxtRicerca','onRicercaList','onPagerList');

      caricaServizi = function(datiServizi){onCaricaServizi(datiServizi,0,-1,null)};
      erroreServizi = function(datiServizi){gestisciMessaggio(datiServizi[0].messaggio);};
      asyncFunzServizi=  function(){ handler_generico(http,caricaServizi,erroreServizi);};
      //chiama la com.strutturaweb.action.ActionFactory.java
      chiamaRichiesta('','promoAreeServizi',asyncFunzServizi); 
  }
}

function onCaricaServizi(datiServizi,serviziIndex,accountIndex,testoRicerca,isnuovo)
{
  // currPage='listini';
   riempiSelectByElementName("Servizi",datiServizi);
   if(serviziIndex!=0 && accountIndex!=-1){
       document.getElementsByName("Servizi")[0].selectedIndex=serviziIndex;
       Servizio(accountIndex,isnuovo);
          document.getElementsByName("Account")[0].disabled = false;
   }else{
        document.getElementsByName("Account")[0].disabled = true;
   }
   
   if(testoRicerca!=null && testoRicerca!='undefined'){
        document.getElementsByName("inputTxtRicerca")[0].value=testoRicerca;
   }
 
   document.getElementsByName("Account")[0].style.width= 'auto';
}

function onCaricaAreeRaccolta(dati)
{
  riempiSelectByElementName("AreaRaccolta",dati);     
}
function onChangeListino(nomeListino_selezionato)
{
  nomeListino=nomeListino_selezionato;
}

function onChangePromoArea(codePromoArea)
{
    if(codePromoArea){
    var res = codePromoArea.split("-");
    codeAccountSel=res[0];
    codeAreaSel=res[1];
    }
}

function onRicercaList(txtRicerca)
{
 var serviziIndex= document.getElementsByName("Servizi")[0].selectedIndex;
 var accountLength = document.formPag.Account.options.length;
 
 if(accountLength!=0 && accountLength!="undefined"){
     var accountIndex= document.getElementsByName("Account")[0].selectedIndex;
     var codeAccount = document.getElementsByName("Account")[0].options[accountIndex].value;
 }
 else{
    accountIndex=0;
    codeAccount='';
 }
  var perPagIndex= document.getElementsByName("inputTxtRicerca_combo")[0].selectedIndex;
  var perPag = document.getElementsByName("inputTxtRicerca_combo")[0].options[perPagIndex].value;
 
 var descArea = document.getElementsByName("inputTxtRicerca")[0].value; 

  carica = function(dati){onCaricaList(dati,serviziIndex,accountIndex,descArea,perPag)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
    //chiama la com.strutturaweb.action.ActionFactory.java
  chiamaRichiesta('&codeAccount='+codeAccount+'&descArea='+descArea,'promoAree',asyncFunz);
}

function onPagerList(page)
{
 var serviziIndex= document.getElementsByName("Servizi")[0].selectedIndex;
 var accountIndex= document.getElementsByName("Account")[0].selectedIndex;
 var testoRicerca = document.getElementsByName("inputTxtRicerca")[0].value;
 
  var headers=new Array("Codice Promozione Area","Account","Area Raccolta","Codice Area Raccolta");
  var valori = new Array("0");
   riempiTabellaSelezionabilePagerEricercaCombo(divTabellaAreeOperatori,datiAreeAccount,headers,valori,'onChangePromoArea',page,10,1,'inputTxtRicerca','onRicercaList','onPagerList').length;
  ricaricaTabella(datiAreeAccount);
  caricaServizi = function(datiServizi){onCaricaServizi(datiServizi,serviziIndex,accountIndex,testoRicerca)};
  erroreServizi = function(datiServizi){gestisciMessaggio(datiServizi[0].messaggio);};
  asyncFunzServizi=  function(){ handler_generico(http,caricaServizi,erroreServizi);};
  //chiama la com.strutturaweb.action.ActionFactory.java
  chiamaRichiesta('','promoAreeServizi',asyncFunzServizi); 
}

function ricaricaTabella(dati)
{
  divTabellaAreeOperatori.style.display='block';
  divTabellaAreeOperatori.style.display='inline';
  divTabellaAreeOperatori.style.visibility='visible';
  maschera.style.display='inline';
  maschera.style.visibility='visible';
  divTabellaAreeOperatori.getElementsByTagName("table")[0].style.width='75%';
}

function cancelCalendar ()
{
   window.document.formPag.txtDataInizio.value="";
}


function showPageTitle()
{
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
     if(page=='listini'){
        if(event == 'ONDETTAGLIO'){
            currPage='listini';
            ONNUOVO();
        }
        else if(event == 'ONNUOVO'){
          currPage='nuovo';
          title='&nbsp;Nuova Promozione Area';  
          divRicercaAreeOperatori.style.display='none';
          divRicercaAreeOperatori.style.visibility='hidden';
          divTabellaAreeOperatori.style.display='none';
          divTabellaAreeOperatori.style.visibility='hidden';
          
          /* abilita area inserimento */
          divIns.style.display='inline';
          divIns.style.visibility='visible';
          
          var servizi=document.getElementsByName("Servizi")[0];
          var account=document.getElementsByName("Account")[0];
          account.selectedIndex=0;
          //divServizi.innerHTML="";
          //divAccount.innerHTML="";
          servizi.selectedIndex=0;
          account.disabled = true;        
          divServizi.appendChild(servizi);          
          divAccount.appendChild(account);
          
          divAccount.innerHTML='<select class="text" name="Account" id="Account" onchange="onAccount()"><option value="" selected disabled >Selezionare Account</option></select>';
          divAreaRaccolta.innerHTML='<select class="text" name="AreaRaccolta" id="AreaRaccolta" selected disabled onchange="onAreaRaccolta()" ><option value="" selected disabled >Selezionare Area Raccolta</option></select>';         
          divCheckAreaRaccolta.innerHTML='<input type="checkbox" name="checkAreaRaccolta" disabled onclick ="onAreaRaccoltacheck()"/>';
      
          divButtonList.style.display='none';
          divButtonList.style.visibility='hidden';
          
          divButtonNuovo.style.display='inline';
          divButtonNuovo.style.visibility='visible';
         
         var carica = function(dati){onCaricaAreeRaccolta(dati);};
         var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
         var asyncFunz=  function(){ handler_generico(http,carica,errore);};
         chiamaRichiesta('','promoAreeAreeRaccolta',asyncFunz);
         
         document.getElementsByName("PageTitle")[0].innerHTML=title;
        }        
     }
     else if(page=='nuovo'){
        if(event == 'ONANNULLA'){ 
     
         var servizi=document.getElementsByName("Servizi")[0];
         var account=document.getElementsByName("Account")[0];
         account.selectedIndex=0;          
         servizi.selectedIndex=0;
         account.disabled = true;                 
         tableRicerca.rows[1].cells[1].appendChild(servizi);
         tableRicerca.rows[2].cells[1].appendChild(account);
         tableRicerca.rows[1].cells[3].childNodes[0].value="";
         caricaList(true);
        }
        else if(event == 'ONSALVA')
        {   
            var codeServizio = document.getElementById("Servizi").value;
            var codeAccount = document.getElementById("Account").value;
            var codeArea= document.getElementsByName("AreaRaccolta")[0].value;
            var checkAllAree =document.getElementsByName("checkAreaRaccolta")[0].checked;
            if(validaFormInserimento(codeServizio,codeAccount, codeArea)){
            currPage='messaggio';
             carica = function(dati){
                        msgEvent='nuovoOK';
                        gestisciMessaggio(dati[0].text);
                      };
              errore = function(dati){
                        gestisciMessaggio(dati[0].messaggio);
                        msgEvent='nuovoKO';
                      };
              asyncFunz=  function(){ handler_generico(http,carica,errore);};  
              var action='inserisciPromoArea';
              chiamaRichiesta('&codeAccount='+codeAccount+'&codeArea='+codeArea+'&checkAllAree='+checkAllAree,action,asyncFunz);
              }            
           else{
           
           }
        } 
     }
     else if(page=='messaggio'){
        if(msgEvent == 'nuovoKO'){
          currPage="nuovo";
          divIns.style.display='inline';
          divIns.style.visibility='visible';        
         
          
          //changePage('listini','ONNUOVO');
        }
        else if(msgEvent == 'nuovoOK'){
         divIns.style.visibility= 'hidden'; 
         divIns.style.display= 'none';
         changePage('listini','ONDETTAGLIO');
         
          var servizi=document.getElementsByName("Servizi")[0];
          var account=document.getElementsByName("Account")[0];
          servizi.selectedIndex=0;
          account.disabled = true;        
        }
        else if(msgEvent == 'elimina')
        {
         var servizi=document.getElementsByName("Servizi")[0];
         var account=document.getElementsByName("Account")[0];
         account.selectedIndex=0;          
         servizi.selectedIndex=0;
         account.disabled = true;                 
         tableRicerca.rows[1].cells[1].appendChild(servizi);
         tableRicerca.rows[2].cells[1].appendChild(account);
         tableRicerca.rows[1].cells[3].childNodes[0].value="";
         caricaList(true);        
         }
     }     
}
function validaFormInserimento(codeServizio,codeAccount, codeArea){
   if(codeServizio==''){
        alert('Servizio non selezionato');
        return false;
   }
   
   if(codeAccount==''){
        alert('Account non selezionato');
        return false;
   }
   if(codeArea==''&& !document.getElementsByName("checkAreaRaccolta")[0].checked ){
        alert('Area Raccolta non selezionata');
        return false;
   }
   return true;
}
function Servizio(accountIndex,isnuovo)
{
  indice= document.getElementsByName("Servizi")[0].selectedIndex;
  var codeServizio=document.getElementsByName("Servizi")[0].options[indice].value;
   if(codeServizio != ''){
      Account(codeServizio,accountIndex);
        document.getElementsByName("Account")[0].disabled = false; 
        
  }else{
        document.getElementsByName("Account")[0].disabled = true;
        document.getElementsByName("Account")[0].selectedIndex=0;
        if(isnuovo!='undefined'&& isnuovo){
        setDisabledArea(true);
        }
 }
}
function Account(codeServizio,accountIndex)
{
  var carica = function(dati){onCaricaSelectAccount(dati,accountIndex);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  parametri = 'codeServizio='+codeServizio;
  chiamaRichiesta(parametri,'promoAreeAccount',asyncFunz);
  
}
function onCaricaSelectAccount(dati,accountIndex)
{
  riempiSelectByElementName("Account",dati);
   if(accountIndex!=null && accountIndex!='undefined'){
            document.getElementsByName("Account")[0].selectedIndex=accountIndex;
   }        
}
function onAccount(){
     setDisabledArea(false);
     if(document.getElementsByName("Account")[0].selectedIndex===0){
       setDisabledArea(true);        
     }
}

function setDisabledArea(_disabled){

   document.getElementsByName("checkAreaRaccolta")[0].disabled = _disabled;
   document.getElementsByName("AreaRaccolta")[0].disabled = _disabled;
    if(_disabled)
   {
     document.getElementsByName("AreaRaccolta")[0].selectedIndex= 0;
     document.getElementsByName("checkAreaRaccolta")[0].checked = !_disabled;

   }    
}
function onAreaRaccoltacheck(){
  if(document.getElementsByName("checkAreaRaccolta")[0].checked){
      document.getElementsByName("AreaRaccolta")[0].disabled = true;
      document.getElementsByName("AreaRaccolta")[0].selectedIndex= 0;
  }
  else{
     document.getElementsByName("AreaRaccolta")[0].disabled = false;
  }
  
}

function onAreaRaccolta(){
    if(document.getElementsByName("AreaRaccolta")[0].selectedIndex!=0){
      document.getElementsByName("checkAreaRaccolta")[0].checked= false;
      document.getElementsByName("checkAreaRaccolta")[0].disabled=true;
    }
    else{
        document.getElementsByName("checkAreaRaccolta")[0].disabled=false;
    }

}