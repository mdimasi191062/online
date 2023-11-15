var status = '';
var codeAccountSel = "";
var codeAreaSel = "";
var datiLista;
var title = '&nbsp;Selezione Gestione Cinque Anni';
var changeStatusMap = new Object();
/*---------------------------------------------------EVENTI-------------------------------------------------------------*/
var currPage = '';
var msgEvent = '';
var prevPage = '';

function caricaList(showTable) {
    title = "&nbsp;Selezione Gestione Cinque Anni";
    document.getElementsByName("PageTitle")[0].innerHTML = title;

    divRicercaAreeOperatori.style.display = 'inline';
    divRicercaAreeOperatori.style.visibility = 'visible';

    divTabellaAreeOperatori.style.display = 'inline';
    divTabellaAreeOperatori.style.visibility = 'visible';

    divButtonList.style.display = 'inline';
    divButtonList.style.visibility = 'visible';

    var serviziIndex = 'undefined';
    var accountIndex = 'undefined';
    var risorsaIndex = 'undefined';
    var dataDaIndex = 'undefined';
    carica = function(dati) {
        onCaricaList(dati, serviziIndex, accountIndex, risorsaIndex, dataDaIndex, 10)
    };
    errore = function(dati) {
        gestisciMessaggio(dati[0].messaggio);
    };
    asyncFunz = function() {
        handler_generico(http, carica, errore);
    };
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('', 'cinqueAnni', asyncFunz);
}

function nascondiErrore() {
    maschera.style.visibility = 'visible';
    maschera.style.display = 'block';
    dvMessaggio.style.display = 'none';
    dvMessaggio.style.visibility = 'hidden';

    changePage('messaggio', msgEvent);
}

function ONSALVA() {
    var r = confirm("Le modifiche effettuate saranno salvate! Proseguire?");
    if (r == true) {
        carica = function(dati) {
            gestisciMessaggio(dati[0].text);
            msgEvent = 'salva';
        };
        errore = function(dati) {
            gestisciMessaggio(dati[0].messaggio);
            msgEvent = 'salva';
        };
        asyncFunz = function() {
            handler_generico(http, carica, errore);
        };
        chiamaRichiesta('&changeStatusMap=' + JSON.stringify(changeStatusMap), 'updateCinqueAnni', asyncFunz);
    }
}
/*----------------------------------------------------FINE EVENTI---------------------------------------------------------*/

function onCaricaList(dati, serviziIndex, accountIndex, risorsaIndex, dataDaIndex, perPag) {
    currPage = 'listini';
    divTabellaAreeOperatori.style.display = 'inline';
    divTabellaAreeOperatori.style.visibility = 'visible';
    divButtonList.style.display = 'inline';
    divButtonList.style.visibility = 'visible';

    /*Select STATO,CODE_RIGA,CODE_OGG_FATRZ,DATA_DA,IMPORTO,CODE_ISTANZA,IVA,FLAG_FC_IVA,NR_FATTURA_SD TIPO_RIGA_DETT from*/
    //DOR - Begin - Modifica rimozione colonne OGG_FATRZ, IVA, FLAG_FC_IVA aggiunta colonna FATT/NDC
    //var headers = new Array("ESCLUDI", "CODE_RIGA", "OGG_FATRZ", "DATA_DA", "DATA_A", "IMPORTO", "CODE_ISTANZA", "IVA", "FC_IVA", "NR_FATTURA_SD");
    //var headers = new Array("ESCLUDI", "CODE_RIGA", "DATA_DA", "DATA_A", "IMPORTO", "CODE_ISTANZA", "NR_FATTURA_SD", "FATT/NDC");
    var headers = new Array("ESCLUDI", "CODE RIGA", "FINO A DATA DA", "DATA A", "IMPORTO", "CODE ISTANZA", "TIPO OGG FATT", "FATT/NDC", "ACCOUNT");
    
    //DOR - End -
    var valori = new Array("0"); // rappresenta il numero di parametri della function onChangeListino
    datiLista = dati;

    riempiTabellaSelezionabileCinqueAnni(divTabellaAreeOperatori, dati, headers, valori, 'onChangePromoArea', 0, perPag, null, 'inputTxtRicerca', 'onRicercaList', 'onPagerList');

    if (dati.length == 0) {
        document.getElementsByName("SALVA")[0].className = "textBHide";
    } else {
        document.getElementsByName("SALVA")[0].className = "textB";
    }

    var radioChecked = document.getElementsByName("statoAll");
    for (i = 0; i < document.getElementsByName("statoAll").length; i++) {
        if (dati.length == 0) {
            document.getElementsByName("statoAll")[i].disabled = true;
        } else {
            document.getElementsByName("statoAll")[i].disabled = false;
        }
    }
    if (serviziIndex == 'undefined' && accountIndex == 'undefined' && risorsaIndex == 'undefined' && dataDaIndex) {

        divTabellaAreeOperatori.style.display = 'none';
        divTabellaAreeOperatori.style.visibility = 'hidden';
        divButtonList.style.display = 'none';
        divButtonList.style.visibility = 'hidden';

        riempiTabellaRicercaCinqueAnni(divRicercaAreeOperatori, dati, headers, valori, 'onChangePromoArea', 0, perPag, null, 'inputTxtRicerca', 'onRicercaList', 'onPagerList');

        caricaServizi = function(datiServizi) {
            onCaricaServizi(datiServizi, 0, -1, null)
        };
        erroreServizi = function(datiServizi) {
            gestisciMessaggio(datiServizi[0].messaggio);
        };
        asyncFunzServizi = function() {
            handler_generico(http, caricaServizi, erroreServizi);
        };
        //chiama la com.strutturaweb.action.ActionFactory.java
        chiamaRichiesta('', 'cinqueAnniServizi', asyncFunzServizi);
    }
}

function onCaricaServizi(datiServizi, serviziIndex, accountIndex, testoRicerca, isnuovo) {
    // currPage='listini';
    riempiSelectByElementName("Servizi", datiServizi);
    if (serviziIndex != 0 && accountIndex != -1) {
        document.getElementsByName("Servizi")[0].selectedIndex = serviziIndex;
        Servizio(accountIndex, isnuovo);
        document.getElementsByName("Account")[0].disabled = false;
    } else {
        document.getElementsByName("Account")[0].disabled = true;
        caricaRisorse = function(datiRisorse) {
            onCaricaRisorse(datiRisorse, 0, -1, null)
        };
        erroreRisorse = function(datiRisorse) {
            gestisciMessaggio(datiRisorse[0].messaggio);
        };
        asyncFunzRisorse = function() {
            handler_generico(http, caricaRisorse, erroreRisorse);
        };
        //chiama la com.strutturaweb.action.ActionFactory.java
        chiamaRichiesta('', 'cinqueAnniRisorsa', asyncFunzRisorse);


    }

    if (testoRicerca != null && testoRicerca != 'undefined') {
        document.getElementsByName("inputTxtRicerca")[0].value = testoRicerca;
    }

    document.getElementsByName("Account")[0].style.width = 'auto';
}

function onCaricaRisorse(datiRisorse, serviziIndex, accountIndex, testoRicerca, isnuovo) {
    // currPage='listini';
    riempiSelectByElementName("risorsa", datiRisorse);
    caricaDataDa = function(datiDataDa) {
        onCaricaDataDa(datiDataDa, 0, -1, null)
    };
    erroreDataDa = function(datiDataDa) {
        gestisciMessaggio(datiDataDa[0].messaggio);
    };
    asyncFunzDataDa = function() {
        handler_generico(http, caricaDataDa, erroreDataDa);
    };
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('', 'cinqueAnniDataDa', asyncFunzDataDa);
}

function onCaricaDataDa(datiDataDa, serviziIndex, accountIndex, testoRicerca, isnuovo) {
    // currPage='listini';
    riempiSelectByElementName("dataDa", datiDataDa);
}

function onChangeStatus(idRiga, obj) {
    var i = 0;
    while (datiLista[i]) {
        if (datiLista[i].colonna1 === idRiga) {
            if (obj.checked) {
                changeStatusMap[idRiga] = 1;
                datiLista[i].colonna0 = 1;
            } else {
                changeStatusMap[idRiga] = 0;
                datiLista[i].colonna0 = 0;
            }
            break;
        } else {
            i++;
        }
    }
}

function onCaricaAreeRaccolta(dati) {
    riempiSelectByElementName("AreaRaccolta", dati);
}

function onChangeListino(nomeListino_selezionato) {
    nomeListino = nomeListino_selezionato;
}

function onChangePromoArea(codePromoArea) {
    if (codePromoArea) {
        var res = codePromoArea.split("-");
        codeAccountSel = res[0];
        codeAreaSel = res[1];
    }
}

function onRicercaList(txtRicerca) {
    var serviziIndex = document.getElementsByName("Servizi")[0].selectedIndex;
    var risorsaIndex = document.getElementsByName("risorsa")[0].selectedIndex;
    var dataDaIndex = document.getElementsByName("dataDa")[0].selectedIndex;
    var codeAccount = '';
    var accountIndex = 0;
    var accountLength = document.formPag.Account.options.length;

    if (accountLength != 0 && accountLength != "undefined") {
        accountIndex = document.getElementsByName("Account")[0].selectedIndex;
        codeAccount = document.getElementsByName("Account")[0].options[accountIndex].value;
    }

    document.getElementsByName("statoAll")[2].checked = true;
    var risorsaVal = "";
    var dataDaVal = "";

    if (risorsaIndex != 0) {
        risorsaVal = document.getElementsByName("risorsa")[0].options[risorsaIndex].value;
    }
    if (dataDaIndex != 0) {
        dataDaVal = document.getElementsByName("dataDa")[0].options[dataDaIndex].value;
    }
    var perPagIndex = document.getElementsByName("inputTxtRicerca_combo")[0].selectedIndex;
    var perPag = document.getElementsByName("inputTxtRicerca_combo")[0].options[perPagIndex].value;

    carica = function(dati) {
        onCaricaList(dati, serviziIndex, accountIndex, risorsaIndex, dataDaIndex, perPag)
    };
    errore = function(dati) {
        gestisciMessaggio(dati[0].messaggio);
    };
    asyncFunz = function() {
        handler_generico(http, carica, errore);
    };
    //chiama la com.strutturaweb.action.ActionFactory.java
    chiamaRichiesta('&codeAccount=' + codeAccount + '&risorsa=' + risorsaVal + '&dataDa=' + dataDaVal, 'cinqueAnni', asyncFunz);
}

function onPagerList(page) {
    var serviziIndex = document.getElementsByName("Servizi")[0].selectedIndex;
    var accountIndex = document.getElementsByName("Account")[0].selectedIndex;
    var risorsaIndex = document.getElementsByName("risorsa")[0].selectedIndex;
    var dataDaIndex = document.getElementsByName("dataDa")[0].selectedIndex;
    var radioChecked = document.getElementsByName("statoAll");
    var checkIndex;
    for (i = 0; i < radioChecked.length; i++) {
        if (radioChecked[i].checked) {
            checkIndex=radioChecked[i];
        }
    }
    //DOR - Begin - Modifica rimozione colonne OGG_FATRZ, IVA, FLAG_FC_IVA aggiunta colonna FATT/NDC
    //var headers = new Array("ESCLUDI", "CODE_RIGA", "OGG_FATRZ", "DATA_DA","DATA_A", "IMPORTO", "CODE_ISTANZA", "IVA", "FC_IVA", "NR_FATTURA_SD");
    //var headers = new Array("ESCLUDI", "CODE_RIGA", "DATA_DA","DATA_A", "IMPORTO", "CODE_ISTANZA", "NR_FATTURA_SD", "FATT/NDC");
    var headers = new Array("ESCLUDI", "CODE RIGA", "FINO A DATA DA", "DATA A", "IMPORTO", "CODE ISTANZA", "TIPO OGG FATT", "FATT/NDC", "ACCOUNT");
    //DOR - End -
    var valori = new Array("0");
    riempiTabellaSelezionabileCinqueAnni(divTabellaAreeOperatori, datiLista, headers, valori, 'onChangePromoArea', page, 10, 1, 'inputTxtRicerca', 'onRicercaList', 'onPagerList').length;
    for (i = 0; i < radioChecked.length; i++) {
        if (radioChecked[i].checked) {
            onRadio(checkIndex, true);
        }
    }
}

function ricaricaTabella(dati) {
    divTabellaAreeOperatori.style.display = 'block';
    divTabellaAreeOperatori.style.display = 'inline';
    divTabellaAreeOperatori.style.visibility = 'visible';
    maschera.style.display = 'inline';
    maschera.style.visibility = 'visible';
    divTabellaAreeOperatori.getElementsByTagName("table")[0].style.width = '75%';
}

function cancelCalendar() {
    window.document.formPag.txtDataInizio.value = "";
}


function showPageTitle() {
    return title;
}

function changePage(page, event) {

    prevPage = page;
    if (page == 'listini') {
        if (event == 'ONLISTA') {
            onRicercaList();
        }
    } else if (page == 'messaggio') {

        if (msgEvent == 'salva') {
            changePage('listini', 'ONLISTA');                   
        }
    }
}

function Servizio(accountIndex, isnuovo) {
    indice = document.getElementsByName("Servizi")[0].selectedIndex;
    var codeServizio = document.getElementsByName("Servizi")[0].options[indice].value;
    if (codeServizio != '') {
        Account(codeServizio, accountIndex);
        document.getElementsByName("Account")[0].disabled = false;

    } else {
        document.getElementsByName("Account")[0].disabled = true;
        document.getElementsByName("Account")[0].selectedIndex = 0;
        if (isnuovo != 'undefined' && isnuovo) {
            setDisabledArea(true);
        }
    }
}

function Account(codeServizio, accountIndex) {
    var carica = function(dati) {
        onCaricaSelectAccount(dati, accountIndex);
    };
    var errore = function(dati) {
        gestisciMessaggio(dati[0].messaggio);
    };
    var asyncFunz = function() {
        handler_generico(http, carica, errore);
    };
    parametri = 'codeServizio=' + codeServizio;
    chiamaRichiesta(parametri, 'cinqueAnniAccount', asyncFunz);

}

function Risorsa(codeServizio, accountIndex) {
    var carica = function(dati) {
        onCaricaSelectAccount(dati, accountIndex);
    };
    var errore = function(dati) {
        gestisciMessaggio(dati[0].messaggio);
    };
    var asyncFunz = function() {
        handler_generico(http, carica, errore);
    };
    parametri = 'codeServizio=' + codeServizio;
    chiamaRichiesta(parametri, 'cinqueAnniAccount', asyncFunz);
}

function onCaricaSelectAccount(dati, accountIndex) {
    riempiSelectByElementName("Account", dati);
    if (accountIndex != null && accountIndex != 'undefined') {
        document.getElementsByName("Account")[0].selectedIndex = accountIndex;
    }
}

function onAccount() {
    setDisabledArea(false);
    if (document.getElementsByName("Account")[0].selectedIndex === 0) {
        setDisabledArea(true);
    }
}

function onRadio(obj, isPager) {
   /* escludi tutti*/
    if (obj.value == 1) {
        changeStatusMap= {};
        for (i = 0; i < document.getElementsByName("options").length; i++) {
            document.getElementsByName("options")[i].disabled = true;
            document.getElementsByName("options")[i].checked = true;
        }
        for (i = 0; i < datiLista.length; i++) {
            changeStatusMap[datiLista[i].colonna1] = 1;
        }
    }
    /* selezione manuale*/
    if (obj.value == 2) {
       /* changeStatusMap= {};*/
       
        for (i = 0; i < document.getElementsByName("options").length; i++) {
            document.getElementsByName("options")[i].disabled = false;
            
        }
        if (!isPager) {
            onRicercaList();
            changeStatusMap= {};
        }
    }
    /* includi tutti*/
    if (obj.value == 0) {
        changeStatusMap= {};
        for (i = 0; i < document.getElementsByName("options").length; i++) {
            document.getElementsByName("options")[i].disabled = true;
            document.getElementsByName("options")[i].checked = false;
        }
        for (i = 0; i < datiLista.length; i++) {
            changeStatusMap[datiLista[i].colonna1] = 0;
        }
        
    }
    document.getElementsByName("statoAll")[obj.value].checked= true;

    
}

function checkRicercaButton(accountIndex, risorsaindex, dataDaIndex) {
    if (accountIndex != 0 || risorsaindex != 0 || dataDaIndex != 0) {
        document.getElementById("Ricerca").disabled = false;
    } else {
        document.getElementById("Ricerca").disabled = true;
    }
}

function onDataDaChange() {
    var accountIndex = document.getElementsByName("Account")[0].selectedIndex;
    var risorsaIndex = document.getElementsByName("risorsa")[0].selectedIndex;
    var dataDaIndex = document.getElementsByName("dataDa")[0].selectedIndex;

    checkRicercaButton(accountIndex, risorsaIndex, dataDaIndex);
}

function onAccountChange() {

    var accountIndex = document.getElementsByName("Account")[0].selectedIndex;
    var risorsaIndex = document.getElementsByName("risorsa")[0].selectedIndex;
    var dataDaIndex = document.getElementsByName("dataDa")[0].selectedIndex;

    checkRicercaButton(accountIndex, risorsaIndex, dataDaIndex);
}

function onRisorsaChange() {
    var accountIndex = document.getElementsByName("Account")[0].selectedIndex;
    var risorsaIndex = document.getElementsByName("risorsa")[0].selectedIndex;
    var dataDaIndex = document.getElementsByName("dataDa")[0].selectedIndex;

    checkRicercaButton(accountIndex, risorsaIndex, dataDaIndex);
}