var status='';
var nomeListino="";
var datiListini;
var datiTariffe;
var dataInizioValidita="";
var dataFineValidita="";
var title='&nbsp;Selezione Listino';

/*---------------------------------------------------EVENTI-------------------------------------------------------------*/
var currPage='';
var msgEvent='';
var prevPage='';

function caricaListini(){
    divTabellaListini.style.display='inline';
    divTabellaListini.style.visibility='visible';
    divIns.style.display='none';
    divIns.style.visibility='hidden';
    
    divButtonTariffe.style.display='none';
    divButtonTariffe.style.visibility='hidden';
    divButtonListino.style.display='inline';
    divButtonListino.style.visibility='visible';
    
    divButtonModTariffe.style.display='none';
    divButtonModTariffe.style.visibility='hidden';
    
    carica = function(dati){onCaricaListini(dati)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('ciao','listinoOpereSpeciali',asyncFunz); //var dati = new Array({colonna0:'OR 2013'});
}
function ONDETTAGLIO()
{   
    changePage(currPage,'ONDETTAGLIO');
}

function ONAGGIORNA()
{
    msgEvent='';
    changePage(currPage,'ONAGGIORNA');
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
  var r = confirm("Il listino "+nomeListino+" sara' eliminato definitivamente! Proseguire?");
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
    chiamaRichiesta('&listino='+nomeListino,'eliminaListinoOpereSpeciali',asyncFunz);
  } 
}
/*----------------------------------------------------FINE EVENTI---------------------------------------------------------*/

function onCaricaListini(dati)
{
  currPage='listini';
  //changeStatus(currPage);
  datiListini=dati;
  var headers=new Array("Listino");
  var valori = new Array("0");// rappresenta il numero di parametri della function onChangeListino
  riempiTabellaSelezionabilePagerEricerca(divTabellaListini,datiListini,headers,valori,'onChangeListino',0,10,0,'txtRicercaListini','onRicercaListini','onPagerListini');
  divTabellaListini.getElementsByTagName("table")[0].style.width='75%';
    if(datiListini.length==0){
    document.getElementsByName("ELIMINA")[0].className="textBHide";
    document.getElementsByName("DETTAGLIO")[0].className="textBHide";
    }
}
function onChangeListino(nomeListino_selezionato)
{
  nomeListino=nomeListino_selezionato;
}

function onRicercaListini(txtRicerca)
{
  var headers=new Array("Listino");
  var valori = new Array("0");
  var len = riempiTabellaSelezionabilePagerEricerca(divTabellaListini,datiListini,headers,valori,'onChangeListino',0,10,0,'txtRicercaListini','onRicercaListini','onPagerListini');
  if(len==0){
    document.getElementsByName("ELIMINA")[0].className="textBHide";
    document.getElementsByName("DETTAGLIO")[0].className="textBHide";
  }
  else
  {
    document.getElementsByName("ELIMINA")[0].className="textB";
    document.getElementsByName("DETTAGLIO")[0].className="textB";
  }
  ricaricaTabella(datiListini);
}

function onPagerListini(page)
{
  var headers=new Array("Listino");
  var valori = new Array("0");
  riempiTabellaSelezionabilePagerEricerca(divTabellaListini,datiListini,headers,valori,'onChangeListino',page,10,0,'txtRicercaListini','onRicercaListini','onPagerListini');
  ricaricaTabella(datiListini);
}

function ricaricaTabella(dati)
{
  divTabellaListini.style.display='block';
  divTabellaListini.style.display='inline';
  divTabellaListini.style.visibility='visible';
  maschera.style.display='inline';
  maschera.style.visibility='visible';
  divTabellaListini.getElementsByTagName("table")[0].style.width='75%';
}

function cancelCalendar ()
{
   window.document.formPag.txtDataInizio.value="";
}

function onCaricaTariffe(dati)
{
  datiTariffe=dati;
  dataInizioValidita=datiTariffe[0].colonna7;  
  dataFineValidita=datiTariffe[0].colonna8;
  divDataInizioValidita.innerHTML=dataInizioValidita;
  divDataFineValidita.innerHTML=dataFineValidita;
  var nomiColonne=new Array("Prog.", "Code PS", "Imp.Tariffa", "Desc.Tariffa", "Unit&agrave; Misura");
  riempiTabella(divTabellaTariffa,datiTariffe,nomiColonne);
  //divTabellaTariffa.getElementsByTagName("table")[0].style.height='233px';
}

function showPageTitle()
{
  return title;
}

function getTableTariffeParameters(){

  var arr =new Array();
  // numero di righe
  var allDivTr = document.getElementById("divTabellaTariffa").getElementsByTagName("tr");
  // numero di colonne 
  var allDivTd = document.getElementById("divTabellaTariffa").getElementsByTagName("tr")[0].getElementsByTagName("td");
  //scorre righe
  for(i=0; i<allDivTr.length-1; i++){
     var tariffa = {};
     //scorre colonne
     for(j=0;j<allDivTd.length;j++){
       var collName = "colonna"+j;
       tariffa[collName] = document.getElementById(i+"_"+j).value;
    }
    arr.push(tariffa);
  }
  
  return arr;
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
          currPage='dettaglio';
          carica = function(dati){onCaricaTariffe(dati)};
          errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
          asyncFunz=  function(){ handler_generico(http,carica,errore);};
          chiamaRichiesta('listino='+nomeListino,'tariffeOpereSpeciali',asyncFunz);
          
          // modifica elementi grafici
          divTabellaListini.style.display='none';
          divTabellaListini.style.visibility='hidden';
          divIns.style.display='inline';
          divIns.style.visibility='visible';
          
          divDataFineValidita.parentElement.parentElement.style.display='inline';
          divDataFineValidita.parentElement.parentElement.style.visibility='visible';
          divButtonTariffe.style.display='inline';
          divButtonTariffe.style.visibility='visible';
          divButtonListino.style.display='none';
          divButtonListino.style.visibility='hidden';
          divButtonModTariffe.style.display='none';
          divButtonModTariffe.style.visibility='hidden';
          
          divRiepilogoListino.innerHTML=nomeListino;
          title='&nbsp;Dettaglio Listino';
        }
        else if(event == 'ONNUOVO'){
          currPage='nuovo';
          var tabMod1 = new tabMod("Prog.", false, true);
          var tabMod2 = new tabMod("Code PS", false, true);
          var tabMod3 = new tabMod("Imp.Tariffa", true, true);
          var tabMod4 = new tabMod("Desc.Tariffa", true, true);
          var tabMod5 = new tabMod("Unit&agrave; Misura", false, true);
          var tabMod6 = new tabMod("Cod.Tariffa", false, false);
          var tabMod7 = new tabMod("Cod.Pr.Tariffa.", false, false);
          var colonne=new Array(tabMod1, tabMod2, tabMod3, tabMod4, tabMod5, tabMod6, tabMod7); 
          carica = function(dati){riempiTabellaModificabile(divTabellaTariffa,dati,colonne);};
          errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
          asyncFunz=  function(){ handler_generico(http,carica,errore);};
          chiamaRichiesta('vuota=Y','tariffeOpereSpeciali',asyncFunz);

         // var dati = new Array();
          //for (i = 1; i < 11; i++) {
          //  var tariffa = {colonna0:i,colonna1:'',colonna2:'',colonna3:'',colonna4:'',colonna5:'',colonna6:''};
          //  dati.push(tariffa);
          //}
                 
          // modifica elementi grafici
          divTabellaListini.style.display='none';
          divTabellaListini.style.visibility='hidden';
          divIns.style.display='inline';
          divIns.style.visibility='visible';
          
          divDataFineValidita.parentElement.parentElement.style.display='none';
          divDataFineValidita.parentElement.parentElement.style.visibility='hidden';
          divButtonTariffe.style.display='none';
          divButtonTariffe.style.visibility='hidden';
          divButtonListino.style.display='none';
          divButtonListino.style.visibility='hidden';
          
          divButtonModTariffe.style.display='inline';
          divButtonModTariffe.style.visibility='visible';
        
         divRiepilogoListino.innerHTML="<input id=\"idNomeListino\" type=\"text\" maxlength='512' />"; 
         
         var cancellaBt = "<a href=\"javascript:cancelCalendar();\" onMouseOver=\"javascript:showMessage('cancella'); return true;\" onMouseOut=\"status='';return true\"><img name='cancel' src=\"../../common/images/body/cancella.gif\" border=\"0\"></a>";
         var dataInputTxt ="<input type=\"text\" class=\"text\" name=\"txtDataInizio\" id=\"txtDataInizio\" maxlength=\"10\" size=\"10\" disabled=\"true\">";
         var calendario ="<a href=\"javascript:showCalendar('formPag.txtDataInizio','sysdate');\" onMouseOver=\"javascript:showMessage('seleziona'); return true;\" onMouseOut=\"status='';return true\">";
         var calendarioImg ="<img name=\"calendar\" src=\"../../common/images/body/calendario.gif\" border=\"no\"></a>";
         divDataInizioValidita.innerHTML = "<table><tr><td>"+dataInputTxt+"</td><td>"+calendario+calendarioImg+"</td><td>"+cancellaBt+"</td></tr></table>";
         title='&nbsp;Nuovo Listino';  
         onChangeListino(document.getElementById("idNomeListino").value);
        }        
     }
     else if(page=='dettaglio'){       
         if(event == 'ONAGGIORNA'){
          currPage='aggiorna';          
          var tabMod1 = new tabMod("Prog.", false, true);
          var tabMod2 = new tabMod("Code PS", false, true);
          var tabMod3 = new tabMod("Imp.Tariffa", false, true);
          var tabMod4 = new tabMod("Desc.Tariffa", true, true);
          var tabMod5 = new tabMod("Unit&agrave; Misura", false, true);
          var tabMod6 = new tabMod("Cod.Tariffa", false, false);
          var tabMod7 = new tabMod("Cod.Pr.Tariffa.", false, false);
          var colonne=new Array(tabMod1, tabMod2, tabMod3, tabMod4, tabMod5, tabMod6, tabMod7); 
          riempiTabellaModificabile(divTabellaTariffa,datiTariffe,colonne);
          
          // modifica elementi grafici
          divTabellaListini.style.display='none';
          divTabellaListini.style.visibility='hidden';
          divIns.style.display='inline';
          divIns.style.visibility='visible';
          
         // divDataFineValidita.parentElement.parentElement.style.display='none';
         // divDataFineValidita.parentElement.parentElement.style.visibility='hidden';
          
          divButtonTariffe.style.display='none';
          divButtonTariffe.style.visibility='hidden';
          divButtonListino.style.display='none';
          divButtonListino.style.visibility='hidden';
          
          divButtonModTariffe.style.display='inline';
          divButtonModTariffe.style.visibility='visible';
          
          var escCol = nomeListino.split(' ').join('&#32;');
          divRiepilogoListino.innerHTML="<input value="+escCol+" id=\"idNomeListino\" type=\"text\" maxlength='512' />"; 
          divDataInizioValidita.innerHTML=dataInizioValidita;
          title='&nbsp;Dettaglio Listino';
         }
         if(event == 'ONANNULLA'){ 
          caricaListini();
        }
     }
     else if(page=='aggiorna'){
         if(event == 'ONANNULLA')
         { 
          changePage('listini','ONDETTAGLIO');
         }
         else if(event == 'ONSALVA')
         { 
            
            var action='';
            var newListinoDescr = document.getElementById("idNomeListino").value.toUpperCase();
            carica = function(dati){
                      msgEvent='aggiornaOK';
                      nomeListino=newListinoDescr;
                      gestisciMessaggio(dati[0].text);
                    };
            errore = function(dati){
                      gestisciMessaggio(dati[0].messaggio);
                      msgEvent='aggiornaKO';
                    };
            asyncFunz=  function(){ handler_generico(http,carica,errore);};              
            var descr0 = document.getElementById("0_3").value;
            var descr1 = document.getElementById("1_3").value;
            var descr2 = document.getElementById("2_3").value;
            var descr3 = document.getElementById("3_3").value;
            var descr4 = document.getElementById("4_3").value;
            var descr5 = document.getElementById("5_3").value;
            var descr6 = document.getElementById("6_3").value;
            var descr7 = document.getElementById("7_3").value;
            var descr8 = document.getElementById("8_3").value;
            var descr9 = document.getElementById("9_3").value;            
            
            if(!newListinoDescr){alert('nome listino obbligatorio');}            
            //ascii match
            else if(!newListinoDescr.match(/^[\x00-\x7F]*$/)){
                alert('carattere non consentito per nome listino');
            }
            else if(!descr0 || !descr0.match(/^[\x00-\x7F]*$/)){
                var row0 = document.getElementById("0_1").value;
                if(!descr0.match(/^[\x00-\x7F]*$/)){                
                 alert('descrizione tariffa con carattere non consentito per la voce '+ row0);}
                else{
                  alert('descrizione tariffa obbligatoria per la voce '+ row0);
                }
            }            
            else if(!descr1 || !descr1.match(/^[\x00-\x7F]*$/)){
                var row1 = document.getElementById("1_1").value;
                if(!descr1.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row1);}
                else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row1);
                }
            }            
            else if(!descr2 || !descr2.match(/^[\x00-\x7F]*$/)){
                var row2 = document.getElementById("2_1").value;
                if(!descr2.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row2);}
                else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row2);
                }
            }           
            else if(!descr3 || !descr3.match(/^[\x00-\x7F]*$/)){
                var row3 = document.getElementById("3_1").value;
                if(!descr3.match(/^[\x00-\x7F]*$/)){
                    alert('carattere non consentito per la voce '+ row3);}
                else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row3);
                }
            }            
            else if(!descr4 || !descr4.match(/^[\x00-\x7F]*$/)){
                var row4 = document.getElementById("4_1").value;                
                 if(!descr4.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row4);}
                 else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row4);
                 }
            }
            else if(!descr5 || !descr5.match(/^[\x00-\x7F]*$/)){
                var row5 = document.getElementById("5_1").value;            
                 if(!descr5.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row5);}
                 else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row5);
                 }
            }
            else if(!descr6 || !descr6.match(/^[\x00-\x7F]*$/)){
                var row6 = document.getElementById("6_1").value;            
                 if(!descr6.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row6);} 
                 else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row6);
                 }
            }
            else if(!descr7 || !descr7.match(/^[\x00-\x7F]*$/)){
                var row7 = document.getElementById("7_1").value;            
                  if(!descr7.match(/^[\x00-\x7F]*$/)){
                     alert('descrizione tariffa con carattere non consentito per la voce '+ row7);} 
                  else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row7);
                  }
            }
            else if(!descr8 || !descr8.match(/^[\x00-\x7F]*$/)){
                var row8 = document.getElementById("8_1").value;            
                if(!descr8.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row8);}
                else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row8);
                }
            }
            else if(!descr9 || !descr9.match(/^[\x00-\x7F]*$/)){
                var row9 = document.getElementById("9_1").value;            
                if(!descr9.match(/^[\x00-\x7F]*$/)){
                    alert('descrizione tariffa con carattere non consentito per la voce '+ row9);
                } 
                else{
                    alert('descrizione tariffa obbligatoria per la voce '+ row9);
                }
            }
            else{
                  currPage='messaggio';
                  if(newListinoDescr != nomeListino)
                  {
                    // verificare esistenza in db
                    action='checkAndUpdateListino';
                  }
                  else
                  {
                   action='updateListinoOpereSpeciali';
                  }
                  chiamaRichiesta('&descr0='+descr0+'&descr1='+descr1+'&descr2='+descr2+'&descr3='+descr3+'&descr4='+descr4+'&descr5='+descr5+'&descr6='+descr6+'&descr7='+descr7+'&descr8='+descr8+'&descr9='+descr9+'&newListinoDescr='+newListinoDescr+'&nomeListino='+nomeListino,action,asyncFunz);
            }
         }
     }
     else if(page=='nuovo'){
        if(event == 'ONANNULLA'){ 
          caricaListini();
        }
        else if(event == 'ONSALVA')
        {   
            var newListinoDescr = document.getElementById("idNomeListino").value.toUpperCase();
            var txtDataInizio = document.getElementById("txtDataInizio").value;
            var arr = getTableTariffeParameters();
            //nome colonne da validare
            var nomeColonne =new Array();
            nomeColonne.push('colonna2');
            nomeColonne.push('colonna3');
            if(validaFormInserimento(newListinoDescr,txtDataInizio,arr,nomeColonne)){
            currPage='messaggio';
              carica = function(dati){
                        msgEvent='nuovoOK';
                        gestisciMessaggio(dati[0].text);
  //                      nomeListino=document.getElementById("idNomeListino").value;
                      };
              errore = function(dati){
                        gestisciMessaggio(dati[0].messaggio);
                        msgEvent='nuovoKO';
  //                      nomeListino=document.getElementById("idNomeListino").value;
                      };
              asyncFunz=  function(){ handler_generico(http,carica,errore);};  
              var action='insertListinoOpereSpeciali';
              chiamaRichiesta('&tariffe='+JSON.stringify(arr)+'&newListinoDescr='+newListinoDescr+'&txtDataInizio='+txtDataInizio,action,asyncFunz);
              }
             
           else{
           
           }
           nomeListino=document.getElementById("idNomeListino").value.toUpperCase();
        } 
     }
     else if(page=='messaggio'){
        if(msgEvent == 'aggiornaKO'){
          currPage="aggiorna";
          divIns.style.display='inline';
          divIns.style.visibility='visible';
          //changePage('dettaglio','ONAGGIORNA');
        }
        else if(msgEvent == 'aggiornaOK'){ 
          divIns.style.visibility= 'hidden'; 
          divIns.style.display= 'none';
          changePage('listini','ONDETTAGLIO');
        }
        else if(msgEvent == 'nuovoKO'){
          currPage="nuovo";
          divIns.style.display='inline';
          divIns.style.visibility='visible';
          //changePage('listini','ONNUOVO');
        }
        else if(msgEvent == 'nuovoOK'){
         divIns.style.visibility= 'hidden'; 
         divIns.style.display= 'none';
         changePage('listini','ONDETTAGLIO');
        }
        else if(msgEvent == 'elimina')
        {
          caricaListini();
        }
     }     
}
function validaFormInserimento(nomeListino, dataInserimento, tariffeArr,nomeColonne){
      
      //controllo nome Listino esistente 
      if(nomeListino) {     
      //ascii match
        if(nomeListino.match(/^[\x00-\x7F]*$/)){
        for(i=0;i<datiListini.length;i++){
           if(datiListini[i].colonna0==nomeListino){
            alert('listino ' +nomeListino +' esistente');
           return false;            
          }            
        }
        }else{
            //ascii match
            alert('carattere non consentito nel nome listino');
            return false;
        }
      }
      else{
       alert('nome listino obbligatorio');
         return false; 
      }
      if(!dataInserimento)
      {
        alert('data inserimento non valida');
        return false;
      }
      for(i=0; i<tariffeArr.length; i++){
            var rigaTariffa = tariffeArr[i];
            for(j=0; j<nomeColonne.length; j++){
              var nomeColonna = nomeColonne[j];
              var tariffaElement =rigaTariffa[nomeColonna];                 
              //importo tariffa
              if(nomeColonna=='colonna2'){
                    if(tariffaElement!=null && tariffaElement!=''){
                    var res = tariffaElement.match(/^\d*(?:\.\d{0,2})?$/);
                    if(!res){
                      alert(' importo tariffa non valida per la voce '+ rigaTariffa['colonna1'] ); 
                      return false;
                    }                   
                    }
                    else{
                       alert(' importo tariffa non valida per la voce '+ rigaTariffa['colonna1'] + ' non può essere vuoto'); 
                     return false;
                    }
               }
              //descrizione tariffa
              else if (nomeColonna=='colonna3'){
                 if(!tariffaElement||tariffaElement==""||tariffaElement==0||tariffaElement==0.0){
                      alert('descrizione tariffa obbligatoria per la voce ' + rigaTariffa['colonna1']);
                       return false;
                 }
                 else if(!tariffaElement.match(/^[\x00-\x7F]*$/)){
                       //ascii match 
                       alert('descrizione tariffa con carattere non consentito per la voce ' + rigaTariffa['colonna1']);
                       return false;
                 }
              }
          }
      }
   return true;
}