	//GESTIONE EVENTI CAMPI
	//+++++ACCOUNT ++++++
	function click_cmdAccount(){
			var URL = '';
      var URLParam = '?Servizio=' + frmDati.srcCodeServizio.value;
      URL='seleziona_account.jsp' + URLParam;
      openCentral(URL,'Account','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
	}

  //++++OFFERTA++++++++
  function click_cmdOfferta() {

			var URL = '';
      var URLParam = '?Servizio=' + frmDati.srcCodeServizio.value;
      URL = 'seleziona_offerta.jsp' + URLParam ;
			openCentral(URL,'Offerta','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  }

  //++++SERVIZIO+++++++
  function click_cmdServizio() {

  	  var URL = '';
      URL = 'seleziona_servizio.jsp';
			openCentral(URL,'Servizio','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  }

  //++++PRODOTTO++++++
  function click_cmdProdotto() {
 
  	 	var URL = '';
      var URLParam = '?Servizio=' + frmDati.srcCodeServizio.value + '&Offerta=' + frmDati.srcCodeOfferta.value;
      URL = 'seleziona_prodotto.jsp' + URLParam;
			openCentral(URL,'Prodotto','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  }

  function reloadPageCompo(p_strTypeLoad,p_strUrl)
  {
 
   document.frmDati.hidTypeLoad.value = p_strTypeLoad;
   document.frmDati.CodeIstProd.value = document.frmDati.CodeIstProd.value;
   document.frmDati.action = p_strUrl;
   document.frmDati.submit();
  }

  //++++COMPONENTE++++
  function click_cmdComponente() {


  	 	var URL = '';
      var URLParam = '?Servizio=' + frmDati.srcCodeServizio.value + '&Offerta=' + frmDati.srcCodeOfferta.value + '&Prodotto=' + frmDati.strCodeProdotto.value;
      URL = 'seleziona_componente.jsp' + URLParam;
      openCentral(URL,'Componente','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  }

  
  //++++PRESTAZIONE++++
  function click_cmdPrestazione() {
  	 	var URL = '';
      var URLParam = '?Servizio=' + frmDati.srcCodeServizio.value + '&Offerta=' + frmDati.srcCodeOfferta.value + '&Prodotto=' + frmDati.strCodeProdotto.value + '&Componente=' +frmDati.strCodeComponente.value;
      URL = 'seleziona_prestazione_aggiuntiva.jsp' + URLParam;
      openCentral(URL,'Prestazione','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);
  }

    //++++PRESTAZIONE++++
  function click_cmdCausale (tipo) {
    	var URL = '';
      var URLParam = '?tipo=' + tipo;
      URL = 'seleziona_causale.jsp'+URLParam;
			openCentral(URL,'Causale','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  }

  //++++DISABILITA I CAMPI DEL PRODOTTO++++
  function DisabilitaProdotto (statoElem) {
        Disable(frmDati.srcCodeAccount);
        Disable(frmDati.srcCodeStato);
        Disable(frmDati.srcCodeOfferta);
        Disable(frmDati.srcCodeServizio);
        Disable(frmDati.strCodeProdotto);
        Disable(frmDati.srcDIF);
        Disable(frmDati.srcQNTA);
        Disable(frmDati.srcCicloVal);
        Disable(frmDati.strDataFineFatrz);
        Disable(frmDati.strTipoCausaleAtt);
        Disable(frmDati.strDataInizioValid);
        Disable(frmDati.strTipoCausaleCes);
        Disable(frmDati.strDataCessaz);

        Disable(frmDati.strDataFineValid);
        Disable(frmDati.strDataFineNol);
        Disable(frmDati.strDescAccount);
        Disable(frmDati.strDescOfferta);
        Disable(frmDati.strDescServizio);
        Disable(frmDati.strDescStato);
        Disable(frmDati.strDescCausaleAtt);
        Disable(frmDati.strDescCausaleCes); 
        Disable(frmDati.strDescProdotto);
        Disable(frmDati.strDescCiclo);
        Disable(frmDati.cmdServizio);
        Disable(frmDati.cmdAccount);
        Disable(frmDati.cmdOfferta);
        Disable(frmDati.cmdProdotto);
        Disable(frmDati.cmdCausaleAtt);
        Disable(frmDati.cmdCausaleCes);
        Disable(frmDati.strDataRicezOrdine);
        Disable(frmDati.strDataCreaz);
        Disable(frmDati.strDataInizioNol);
        //Disable ( frmDati.SALVA);  
        Disable ( frmDati.CREAEVENTO);
        Disable ( frmDati.ANNULLAMODIFICHE);
        Disable ( frmDati.srcCodeProgetto);



        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCancelDCE);

        EnableLink(document.links[2],document.frmDati.imgCalendarDFN);
        EnableLink(document.links[3],document.frmDati.imgCancelDFN);

        
        EnableLink(document.links[4],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[5],document.frmDati.imgCancelDIF);
        EnableLink(document.links[6],document.frmDati.imgCalendarDFF);
        EnableLink(document.links[7],document.frmDati.imgCancelDFF);
        EnableLink(document.links[8],document.frmDati.imgCalendarDIV);
        EnableLink(document.links[9],document.frmDati.imgCancelDIV);
        EnableLink(document.links[10],document.frmDati.imgCalendarDFV);
        EnableLink(document.links[11],document.frmDati.imgCancelDFV);
        EnableLink(document.links[12],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[13],document.frmDati.imgCancelDIN);
        EnableLink(document.links[14],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[15],document.frmDati.imgCancelDRO);
        EnableLink(document.links[16],document.frmDati.imgCalendarDataCreaz);
        EnableLink(document.links[17],document.frmDati.imgCancelDataCreaz);


        DisableLink(document.links[0],document.frmDati.imgCalendarDCE);
        DisableLink(document.links[1],document.frmDati.imgCancelDCE);

        DisableLink(document.links[2],document.frmDati.imgCalendarDFN);
        DisableLink(document.links[3],document.frmDati.imgCancelDFN);

       
        DisableLink(document.links[4],document.frmDati.imgCalendarDIF);
        DisableLink(document.links[5],document.frmDati.imgCancelDIF);
        DisableLink(document.links[6],document.frmDati.imgCalendarDFF);
        DisableLink(document.links[7],document.frmDati.imgCancelDFF);
        DisableLink(document.links[8],document.frmDati.imgCalendarDIV);
        DisableLink(document.links[9],document.frmDati.imgCancelDIV);
        DisableLink(document.links[10],document.frmDati.imgCalendarDFV);
        DisableLink(document.links[11],document.frmDati.imgCancelDFV);
        DisableLink(document.links[12],document.frmDati.imgCalendarDIN);
        DisableLink(document.links[13],document.frmDati.imgCancelDIN);
        DisableLink(document.links[14],document.frmDati.imgCalendarDRO);
        DisableLink(document.links[15],document.frmDati.imgCancelDRO);
        DisableLink(document.links[16],document.frmDati.imgCalendarDataCreaz);
        DisableLink(document.links[17],document.frmDati.imgCancelDataCreaz);

  
        ableCreaEvento (); 
    }   

  //++++DISABILITA I CAMPI DELLE COMPONENTI++++
  function DisabilitaComponente () {
        Disable(frmDati.srcCodeAccount);
        Disable(frmDati.srcCodeStato);
        Disable(frmDati.srcCodeOfferta);
        Disable(frmDati.srcCodeServizio);
        Disable(frmDati.strCodeProdotto);
        Disable(frmDati.srcDIF);
        Disable(frmDati.srcQNTA);
        Disable(frmDati.srcCicloVal);
        Disable(frmDati.strDataFineFatrz);
        Disable(frmDati.strTipoCausaleAtt);
        Disable(frmDati.strDataInizioValid);
        Disable(frmDati.strTipoCausaleCes);
        Disable(frmDati.strDataFineValid);
        Disable(frmDati.strDataFineNol);
        Disable(frmDati.strCodeComponente);
        Disable(frmDati.strDataCessaz);
        Disable(frmDati.strDescAccount);
        Disable(frmDati.strDescOfferta);
        Disable(frmDati.strDescServizio);
        Disable(frmDati.strDescStato);
        Disable(frmDati.strDescCausaleAtt);
        Disable(frmDati.strDescCausaleCes); 
        Disable(frmDati.strDescProdotto);
        Disable(frmDati.strDescCiclo);
        Disable(frmDati.strDescComponente);
        Disable(frmDati.cmdServizio);
        Disable(frmDati.cmdAccount);
        Disable(frmDati.cmdOfferta);
        Disable(frmDati.cmdProdotto);
        Disable(frmDati.cmdComponente);
//        Disable(frmDati.cmdCausaleAtt);
//        Disable(frmDati.cmdCausaleCes);
        Disable(frmDati.strDataInizioNol);
        Disable(frmDati.strDataRicezOrdine);
        Disable(frmDati.strDataCreaz);
        //Disable ( frmDati.SALVA);  
        Disable ( frmDati.CREAEVENTO);
        Disable ( frmDati.ANNULLAMODIFICHE);

        EnableLink(document.links[0],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[1],document.frmDati.imgCancelDIF);
        EnableLink(document.links[2],document.frmDati.imgCalendarDFF);
        EnableLink(document.links[3],document.frmDati.imgCancelDFF);
        EnableLink(document.links[4],document.frmDati.imgCalendarDIV);
        EnableLink(document.links[5],document.frmDati.imgCancelDIV);
        EnableLink(document.links[6],document.frmDati.imgCalendarDFV);
        EnableLink(document.links[7],document.frmDati.imgCancelDFV);
        EnableLink(document.links[8],document.frmDati.imgCalendarDataCreaz);
        EnableLink(document.links[9],document.frmDati.imgCancelDataCreaz);
        EnableLink(document.links[10],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[11],document.frmDati.imgCancelDIN);
        EnableLink(document.links[12],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[13],document.frmDati.imgCancelDRO);

        DisableLink(document.links[0],document.frmDati.imgCalendarDIF);
        DisableLink(document.links[1],document.frmDati.imgCancelDIF);
        DisableLink(document.links[2],document.frmDati.imgCalendarDFF);
        DisableLink(document.links[3],document.frmDati.imgCancelDFF);
        DisableLink(document.links[4],document.frmDati.imgCalendarDIV);
        DisableLink(document.links[5],document.frmDati.imgCancelDIV);
        DisableLink(document.links[6],document.frmDati.imgCalendarDFV);
        DisableLink(document.links[7],document.frmDati.imgCancelDFV);
        DisableLink(document.links[8],document.frmDati.imgCalendarDataCreaz);
        DisableLink(document.links[9],document.frmDati.imgCancelDataCreaz);
        DisableLink(document.links[10],document.frmDati.imgCalendarDIN);
        DisableLink(document.links[11],document.frmDati.imgCancelDIN);
        DisableLink(document.links[12],document.frmDati.imgCalendarDRO);
        DisableLink(document.links[13],document.frmDati.imgCancelDRO);
        ableCreaEvento (); 
    }   

  //++++DISABILITA I CAMPI DELLE PRESTAZIONI AGGIUNTIVE++++
  function DisabilitaPrestAgg () {
        Disable(frmDati.srcCodeAccount);
        Disable(frmDati.srcCodeStato);
        Disable(frmDati.srcCodeOfferta);
        Disable(frmDati.srcCodeServizio);
        Disable(frmDati.strCodeProdotto);
        Disable(frmDati.srcDIF);
        Disable(frmDati.srcQNTA);
        Disable(frmDati.srcCicloVal);
        Disable(frmDati.strDataFineFatrz);
        Disable(frmDati.strTipoCausaleAtt);
        Disable(frmDati.strDataCessaz);
        Disable(frmDati.strDataInizioValid);
        Disable(frmDati.strTipoCausaleCes);
        Disable(frmDati.strDataFineValid);
        Disable(frmDati.strDataFineNol);
        Disable(frmDati.strCodeComponente);
        Disable(frmDati.strCodePrestAgg);
        //Disable(frmDati.strIstanzaPrestAgg);
        Disable(frmDati.strDataRicezOrdine);
        Disable(frmDati.strDataInizioNol);

        Disable(frmDati.strDescAccount);
        Disable(frmDati.strDescOfferta);
        Disable(frmDati.strDescServizio);
        Disable(frmDati.strDescStato);
        Disable(frmDati.strDescCausaleAtt);
        Disable(frmDati.strDescCausaleCes); 
        Disable(frmDati.strDescProdotto);
        Disable(frmDati.strDescCiclo);
        Disable(frmDati.strDescComponente);
        Disable(frmDati.strDescPrestAgg);
        Disable(frmDati.cmdServizio);
        Disable(frmDati.cmdAccount);
        Disable(frmDati.cmdOfferta);
        Disable(frmDati.cmdProdotto);
        Disable(frmDati.cmdComponente);
        Disable(frmDati.cmdPrestazione);
//        Disable(frmDati.cmdCausaleAtt);
//        Disable(frmDati.cmdCausaleCes);
        Disable(frmDati.strDataCreaz);
        
        //Disable ( frmDati.SALVA); 
        Disable ( frmDati.CREAEVENTO);
        Disable ( frmDati.ANNULLAMODIFICHE);

        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCancelDCE);
        EnableLink(document.links[2],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[3],document.frmDati.imgCancelDIF);
        EnableLink(document.links[4],document.frmDati.imgCalendarDFF);
        EnableLink(document.links[5],document.frmDati.imgCancelDFF);
        EnableLink(document.links[6],document.frmDati.imgCalendarDIV);
        EnableLink(document.links[7],document.frmDati.imgCancelDIV);
        EnableLink(document.links[8],document.frmDati.imgCalendarDFV);
        EnableLink(document.links[9],document.frmDati.imgCancelDFV);
        EnableLink(document.links[10],document.frmDati.imgCalendarDataCreaz);
        EnableLink(document.links[11],document.frmDati.imgCancelDataCreaz);
        EnableLink(document.links[12],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[13],document.frmDati.imgCancelDIN);
        EnableLink(document.links[14],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[15],document.frmDati.imgCancelDRO);

        DisableLink(document.links[0],document.frmDati.imgCalendarDCE);
        DisableLink(document.links[1],document.frmDati.imgCancelDCE);
        DisableLink(document.links[2],document.frmDati.imgCalendarDIF);
        DisableLink(document.links[3],document.frmDati.imgCancelDIF);
        DisableLink(document.links[4],document.frmDati.imgCalendarDFF);
        DisableLink(document.links[5],document.frmDati.imgCancelDFF);
        DisableLink(document.links[6],document.frmDati.imgCalendarDIV);
        DisableLink(document.links[7],document.frmDati.imgCancelDIV);
        DisableLink(document.links[8],document.frmDati.imgCalendarDFV);
        DisableLink(document.links[9],document.frmDati.imgCancelDFV);
        DisableLink(document.links[10],document.frmDati.imgCalendarDataCreaz);
        DisableLink(document.links[11],document.frmDati.imgCancelDataCreaz);
        DisableLink(document.links[12],document.frmDati.imgCalendarDIN);
        DisableLink(document.links[13],document.frmDati.imgCancelDIN);
        DisableLink(document.links[14],document.frmDati.imgCalendarDRO);
        DisableLink(document.links[15],document.frmDati.imgCancelDRO);
        ableCreaEvento (); 
    }  

   function ONANNULLAMODIFICHE () {
      frmDati.hidTypeLoad.value = '0';
      frmDati.submit();
   }  

  function funzioneVuota () {
  }

  function onCliccaSulLink( obj ){
            
    if ( '0' == frmDati.LinkAbilitato.value ) {
        return;
    }
    else {
        location.replace(obj);
    }
  }

  function ONCREAEVENTO () {

    //Disable ( frmDati.SALVA); 
    Disable ( frmDati.CREAEVENTO);
    Disable ( frmDati.RETTIFICA); 
    Disable ( frmDati.CREAEVENTO);
    Disable ( frmDati.ANNULLAMODIFICHE);
    selezionaData() ;
    frmDati.LinkAbilitato.value = '0';

  
  }

  function selezionaData () {

    var URLstringa = "seleziona_data.jsp";
    dialogWin.returnFunc = funzioneVuota;
    dialogWin.win = openCentral(URLstringa,'SelezionaData','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);

  }

  function inserisciNote () {
//  alert( 'inserisciNote');
    var URLstringa = "rettifica_note.jsp";
    window.showModalDialog(URLstringa,"Note","dialogWidth:400px;dialogHeight:270px");

//    dialogWin.returnFunc = funzioneVuota;
//    dialogWin.win = openCentral(URLstringa,'Note','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);

  }

   function refreshListe() {
//   alert('refreshListe');
//    var stringa="";
//    objForm.action = "seleziona_inventario.jsp";
//    objForm.submit();
    }
