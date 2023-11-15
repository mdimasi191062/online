<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_cdn_2_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->

<EJB:useHome id="homeEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferteHome" location="Ent_TipiOfferte" />
<EJB:useBean id="remoteEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferte" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiOfferte.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ProdottiServizi" type="com.ejbSTL.Ent_ProdottiServiziHome" location="Ent_ProdottiServizi" />
<EJB:useBean id="remoteEnt_ProdottiServizi" type="com.ejbSTL.Ent_ProdottiServizi" scope="session">
    <EJB:createBean instance="<%=homeEnt_ProdottiServizi.create()%>" />
</EJB:useBean>

<%
    int i = 0;
    int intAction;

    Vector vctTipiOfferta = null;
    String strViewState = "";
    DB_ProdottiServizi objDbProdServ = null;
    String strCodeTipoCompo = "";

    boolean blnMascheraClassi = false;
    boolean blnContributoTraslocoInterno = false;

    String strParteMessaggio = "";
    String strCodePSPadreGenerale = "";
    String strTitoloContributi = "";
	
	String strOn = "obbligatorio=si|disabilitato=no";
	String strOff = "obbligatorio=no|disabilitato=si";
	String strFieldIndex1 = "1" ;
	String strFieldIndex2 = "2" ;
	String strFieldIndex3 = "3" ;
	
    if(request.getParameter("intAction") == null){
        intAction = StaticContext.LIST;
    }else{
        intAction = Integer.parseInt(request.getParameter("intAction"));
    }

	int intFunzionalita;
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
	// reperimento dei parametri dal viewState
	strViewState = Misc.nh(request.getParameter("hidViewState"));

	//codici
	String strCodeTipoContratto = Misc.getParameterValue(strViewState,"vsCodeTipoContratto");
	String strCodiciTipiCausali = Misc.getParameterValue(strViewState,"vsCodiciTipiCausali");
	String strCodePs = Misc.getParameterValue(strViewState,"vsCodePs");
	String strCodePsCompFatt = Misc.getParameterValue(strViewState,"vsCodePsCompFatt");
	String strCodePrestAgg = Misc.getParameterValue(strViewState,"vsCodePrestAgg");
	String strCodeOggFatt = Misc.getParameterValue(strViewState,"vsCodeOggFatt");
	String strCodeClassOggFatt =  Misc.getParameterValue(strViewState,"vsCodeClassOggFatt");
	String strCodeClassPs = Misc.getParameterValue(strViewState,"vsCodeClassPs");

	//descrizioni
	String strDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
	String strDescTipiCausali = Misc.getParameterValue(strViewState,"vsDescTipiCausali");
	String strDescPs = Misc.getParameterValue(strViewState,"vsDescPs");
	String strDescPsCompFatt = Misc.getParameterValue(strViewState,"vsDescPsCompFatt");
	String strDescPrestAgg = Misc.getParameterValue(strViewState,"vsDescPrestAgg");
	String strDescOggFatt = Misc.getParameterValue(strViewState,"vsDescOggFatt");

    //lp 20040906 sostituisco, se presenti, i caratteri " e ' con lo spazio.
    strDescPs = StaticContext.replaceString(strDescPs,"\""," ");
    strDescPs = StaticContext.replaceString(strDescPs,"'"," ");
    	
    strDescPsCompFatt = StaticContext.replaceString(strDescPsCompFatt,"\""," ");
    strDescPsCompFatt = StaticContext.replaceString(strDescPsCompFatt,"'"," ");
    
	//reperimento del campo "code_tipo_compo"
	objDbProdServ = (DB_ProdottiServizi)remoteEnt_ProdottiServizi.getPS(intAction,strCodePsCompFatt).elementAt(0);
	strCodeTipoCompo = objDbProdServ.getCODE_TIPO_COMPO();

    //reperimento del codice ps del padre generale del ps selezionato
    strCodePSPadreGenerale = Misc.nh(remoteEnt_ProdottiServizi.getCodePSPadreGenerale(intAction,strCodePs));
  
	String strPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	String strTitoloPagina = "";

	if(strPageAction.equals("INS")){
		strTitoloPagina = "Inserimento";
	}
	if(strPageAction.equals("UPD")){
		strTitoloPagina = "MODIFICA";
	}
	if(strPageAction.equals("DEL")){
		strTitoloPagina = "ELIMINAZIONE";
	}
			
	//stabilisco se visualizzare una riga o tre					
	if(strCodeClassPs.equalsIgnoreCase(StaticContext.CL_PS_BASSA01) || 
       strCodeClassPs.equalsIgnoreCase(StaticContext.CL_PS_BASSA02) || 
       strCodePs.equalsIgnoreCase(Integer.toString(StaticContext.PS_FLUSSO_RPVD)))
	{
		blnMascheraClassi = false;
	}else{
		blnMascheraClassi = true;
	}
	
	if((strCodePs.equalsIgnoreCase(Integer.toString(StaticContext.PS_FLUSSO_RPVD)) && strCodeOggFatt.equalsIgnoreCase(Integer.toString(StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE))) 
	|| (strCodePs.equalsIgnoreCase(Integer.toString(StaticContext.PS_FLUSSO_RPVD)) && strCodeOggFatt.equalsIgnoreCase(Integer.toString(StaticContext.OF_CANONE_MENSILE_TRASM_FISSO))))
	{
		blnMascheraClassi = true;
	}else{
		if(strCodePs.equalsIgnoreCase(Integer.toString(StaticContext.PS_FLUSSO_RPVD))
		&& strCodeClassOggFatt.equalsIgnoreCase(StaticContext.CL_CANONE)  
        && !strCodeOggFatt.equalsIgnoreCase(Integer.toString(StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE))
		&& !strCodeOggFatt.equalsIgnoreCase(Integer.toString(StaticContext.OF_CANONE_MENSILE_TRASM_FISSO))){
			blnMascheraClassi = true;
		}
		if(strCodePs.equalsIgnoreCase(Integer.toString(StaticContext.PS_FLUSSO_RPVD)) && strCodeClassOggFatt.equalsIgnoreCase(StaticContext.CL_CONTRIBUTO)){
			blnMascheraClassi = true;
		}
	}

  // lp 25052004 inizio modifica
  //             le classi di sconto sono attive se il codePSPadre non è CDA,CDF,CDN MULTIPUNTO e CDN Backbone
  if (strCodePSPadreGenerale.equalsIgnoreCase(Integer.toString(StaticContext.PS_CDA)) || 
      strCodePSPadreGenerale.equalsIgnoreCase(Integer.toString(StaticContext.PS_CDF)) ||
      strCodePSPadreGenerale.equalsIgnoreCase(Integer.toString(StaticContext.PS_MULTIPUNTO)) ||
      strDescPs.indexOf("Backbone") > 0) {
        blnMascheraClassi = false;
  } else {
        blnMascheraClassi = true;
  }

  strTitoloContributi = "Contributi";  
  if (strCodeOggFatt.equalsIgnoreCase(Integer.toString(StaticContext.OF_CONTRIBUTO_PER_TRASLOCO_INTERNO))) {
    strTitoloContributi = strTitoloContributi + " *";
    blnContributoTraslocoInterno = true;
  }

  // lp 25052004 fine modifica
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	
</TITLE>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">

	var objForm = null;
  var strCodePs = "<%=strCodePs%>";
	var strCodePsCompFatt = "";
	var strCodeClassPs = "<%=strCodeClassPs%>";
	var strDescEsPs = "";
	var strCodeTipoCompo = "<%=strCodeTipoCompo%>";
	var strCodeClassOggFatt = "<%=strCodeClassOggFatt%>";
	var strCodeOggFatt = "<%=strCodeOggFatt%>";
	var blnDebbug = false;

	function Initialize()
	{
		objForm = document.frmDati;
		//impostazione delle proprietà dei controlli
		setDefaultProp(objForm);

    <%if(blnMascheraClassi){%>
      <%strParteMessaggio = " per la classe di sconto Da 0 a 3 MILIONI ";%>

      setObjProp(objForm.txtContributi1,"label=Contributi<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
      setObjProp(objForm.txtAccesso1,"label=Accesso<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
      setObjProp(objForm.txt0_60KM1,"label=0-60 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
      setObjProp(objForm.txt61_300KM1,"label=61-300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
      setObjProp(objForm.txtOltre300KM1,"label=Oltre 300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		
      setObjProp(objForm.txtDataInizioValidita,"label=Data Inizio Validità|tipocontrollo=data|obbligatorio=si");
      setObjProp(objForm.txtDescrizioneTariffa,"label=Descrizione Tariffa|obbligatorio=si");

    <%}%>
    
		<%if(blnMascheraClassi){%>
			<%strParteMessaggio = " per la classe di sconto Oltre i 3 MILIONI ";%>
			
			setObjProp(objForm.txtContributi2,"label=Contributi<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txtAccesso2,"label=Accesso<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt0_60KM2,"label=0-60 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt61_300KM2,"label=61-300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txtOltre300KM2,"label=Oltre 300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			
		<%}%>

		//disabilito tutti i controlli e abilito solo quelli necessari in base alle condizioni
		DisableAllControls(objForm);

   // GESTIONE ATTIVAZIONE/DISATTIVAZIONE CONTRIBUTO
   
		if((strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE%>" || 
        strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE_PIANIFICATA%>" ||
        strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE_SEDE_COLO %>" ||
        strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE_SEDE_COLO_P %>") && strCodeClassOggFatt == "<%=StaticContext.CL_CONTRIBUTO%>")
		{
				 if(blnDebbug){
					alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeClassOggFatt=<%=strCodeClassOggFatt%>");
				 }
				 EnableFieldImporto("C");
		}
		
    if (strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_SLA_PREMIUM%>" ||
        strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_PIANIFICAZIONE%>" || 
        strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_VOLTURA%>") {
				 if(blnDebbug){
					alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeClassOggFatt=<%=strCodeClassOggFatt%>");
				 }
				 EnableFieldImporto("C");
    }

   // GESTIONE ATTIVAZIONE/DISATTIVAZIONE ACCESSO

		if(((strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE%>" ||
         strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE_PIANIFICATA%>" ||
         strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE_SEDE_COLO%>" ||
         strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE_SEDE_COLO_P%>")
		 		&& (strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_RACC_CENTRALE%>"
				 || strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_AGGIUNTIVO_PER_DIRAMAZIONE_ATTIVA%>"
				 || strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_AGGIUNTIVO_PER_PUNTO_DI_DERIVAZIONE%>"
				 || strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_PORTA_ATM%>"))){
				 if(blnDebbug){
					alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeOggFatt=<%=strCodeOggFatt%>");
				 }
				 EnableFieldImporto("A");
		}

    if (strCodeOggFatt == "<%=StaticContext.OF_CANONE_SLA_DISP%>" ||
        strCodeOggFatt == "<%=StaticContext.OF_CANONE_SLA_SCONTO%>" || 
        strCodeOggFatt == "<%=StaticContext.OF_CANONE_SLA_RIPRI%>") {
				 if(blnDebbug){
					alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeOggFatt=<%=strCodeOggFatt%>");
				 }
				 EnableFieldImporto("A");
    }
        
   // GESTIONE ATTIVAZIONE/DISATTIVAZIONE FASCE

		if(strCodeTipoCompo == "<%=StaticContext.TC_PARTE_TRASMISSIVA%>" && strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>")
		{
			 if(blnDebbug){
					alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeClassOggFatt=<%=strCodeClassOggFatt%>");
			 }
			 EnableFieldImporto("F");
		}
		//******************************************************************* new
    
		//*******************************************************************
		if(strCodePs == "<%=StaticContext.PS_FLUSSO_RPVD%>" 
		&& strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>" 
		&& strCodeOggFatt != "<%=StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE%>"
		&& strCodeOggFatt != "<%=StaticContext.OF_CANONE_MENSILE_TRASM_FISSO%>")
		{
			 EnableFieldImporto("A");
		}
		if(strCodePs == "<%=StaticContext.PS_FLUSSO_RPVD%>" && strCodeClassOggFatt == "<%=StaticContext.CL_CONTRIBUTO%>"){
			 EnableFieldImporto("C");
		}
		//***********************************************************************
		//impostazioni fisse
		Enable(objForm.ANNULLA);
		Enable(objForm.CHIUDI);
		//Enable(objForm.txtDataInizioValidita);
		Enable(objForm.cboTipoOfferta);
		Enable(objForm.txtDescrizioneTariffa);
		objForm.txtDescrizioneTariffa.value = "<%=strDescPsCompFatt%>" + " - " + "<%=strDescOggFatt%>"; 
		if(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE%>")
		{
			objForm.rdoTipoImporto[1].checked = true; //variabile
		}else{
			objForm.rdoTipoImporto[0].checked = true; //fisso
		}
		//se il codice classe oggetto di fatturazione è canone
		if(strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>")
		{
			objForm.txtUnitaMisura.value = "Chilometro(KM)";
			objForm.hidCodeUnitaMisura.value = "<%=StaticContext.UM_KM%>";
		}else{
			objForm.txtUnitaMisura.value = "";
			objForm.hidCodeUnitaMisura.value = "";
		}
	}


		function ONCHIUDI()
		{
      window.close();
		}

	
	function ONANNULLA()
	{
		Disable(objForm.CONFERMA);
		clearField(objForm.cboTipoOfferta);
		clearField(objForm.txtDescrizioneTariffa);		
		clearField(objForm.txtContributi1);
		clearField(objForm.txtAccesso1);
		clearField(objForm.txt0_60KM1);
		clearField(objForm.txt61_300KM1);
		clearField(objForm.txtOltre300KM1);
		
		<%if(blnMascheraClassi){%>
			clearField(objForm.txtContributi2);
			clearField(objForm.txtAccesso2);
			clearField(objForm.txt0_60KM2);
			clearField(objForm.txt61_300KM2);
			clearField(objForm.txtOltre300KM2);
			
		<%}%>
	}
	function ONCONFERMA()
	{
		if(validazioneCampi(objForm))
		{
			//completo il view state
			updVS(objForm.hidViewState,"vsCodeTipoOfferta",getComboValue(objForm.cboTipoOfferta));
			updVS(objForm.hidViewState,"vsCodeTipoImporto",getRadioButtonValue(objForm.rdoTipoImporto));
			updVS(objForm.hidViewState,"vsCodeUnitaMisura",objForm.hidCodeUnitaMisura.value);
			updVS(objForm.hidViewState,"vsDescTariffa",objForm.txtDescrizioneTariffa.value);
			updVS(objForm.hidViewState,"vsDataInizioValidita",objForm.txtDataInizioValidita.value);
			<%if(blnMascheraClassi){%>
				updVS(objForm.hidViewState,"vsMascheraClassi","true");
			<%}else{%>
				updVS(objForm.hidViewState,"vsMascheraClassi","false");
			<%}%>
			objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_cdn_3_cl.jsp?intAction=<%=intAction%>&intFunzionalita=<%=intFunzionalita%>";
			EnableAllControls(objForm);
			objForm.submit();
		}
	}
	
	function change_cboTipoOfferta()
	{
		if(getComboIndex(objForm.cboTipoOfferta)!= 0)
		{
			Enable(objForm.CONFERMA);
		}else{
			Disable(objForm.CONFERMA);
		}
	}
	
	function EnableFieldImporto(p_strType)
	{
		switch(p_strType)
		{
			case "A": //accessi
				setObjProp(objForm.txtContributi<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txtAccesso<%=strFieldIndex1%>,"<%=strOn%>");
				setObjProp(objForm.txt0_60KM<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txt61_300KM<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txtOltre300KM<%=strFieldIndex1%>,"<%=strOff%>");
				<%if(blnMascheraClassi){%>
					setObjProp(objForm.txtContributi<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txtAccesso<%=strFieldIndex2%>,"<%=strOn%>");
					setObjProp(objForm.txt0_60KM<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txt61_300KM<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txtOltre300KM<%=strFieldIndex2%>,"<%=strOff%>");
					
				<%}%>
				break;
			case "C": //contributi
				setObjProp(objForm.txtContributi<%=strFieldIndex1%>,"<%=strOn%>");
				setObjProp(objForm.txtAccesso<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txt0_60KM<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txt61_300KM<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txtOltre300KM<%=strFieldIndex1%>,"<%=strOff%>");
				<%if(blnMascheraClassi){%>
					setObjProp(objForm.txtContributi<%=strFieldIndex2%>,"<%=strOn%>");
					setObjProp(objForm.txtAccesso<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txt0_60KM<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txt61_300KM<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txtOltre300KM<%=strFieldIndex2%>,"<%=strOff%>");
					
				<%}%>
				break;
			case "F": //fasce Km
				setObjProp(objForm.txtContributi<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txtAccesso<%=strFieldIndex1%>,"<%=strOff%>");
				setObjProp(objForm.txt0_60KM<%=strFieldIndex1%>,"<%=strOn%>");
				setObjProp(objForm.txt61_300KM<%=strFieldIndex1%>,"<%=strOn%>");
				setObjProp(objForm.txtOltre300KM<%=strFieldIndex1%>,"<%=strOn%>");
				<%if(blnMascheraClassi){%>
					setObjProp(objForm.txtContributi<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txtAccesso<%=strFieldIndex2%>,"<%=strOff%>");
					setObjProp(objForm.txt0_60KM<%=strFieldIndex2%>,"<%=strOn%>");
					setObjProp(objForm.txt61_300KM<%=strFieldIndex2%>,"<%=strOn%>");
					setObjProp(objForm.txtOltre300KM<%=strFieldIndex2%>,"<%=strOn%>");
					
				<%}%>
				break;
		}
	}
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="hidCodeUnitaMisura" value="">
	<input type="hidden" name="hidViewState" value="<%=request.getParameter("hidViewState")%>">
<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO CDN</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<br>
<!-- dati di riepilogo -->
<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Oggetto di Fatturazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	<td height="30" width='30%' class="textB" align="right">Tipologia Contratto:&nbsp;&nbsp;</td>
	<td height="30" width='70%' class="text">
		<%=strDescTipoContratto%>
	</td>
</tr>
<tr>
    <td height="30" width="30%"class="textB" align="right">Prodotto/Servizio:&nbsp;&nbsp;</td>
    <td height="30" width="70%" colspan="3" class="text">
		<%=strDescPs%>
	</td>
</tr>
<tr>
    <td height="30" width="30%"class="textB" align="right">P/S Componenti&nbsp;&nbsp;<BR>di Fatturazione:&nbsp;&nbsp;</td>
    <td height="30" width="70%" colspan="3" class="text">
		<%=strDescPsCompFatt%>
	</td>
</tr>
<tr>
    <td height="30" width="30%" class="textB" align="right">Prest.Aggiuntiva:&nbsp;&nbsp;</td>
	<td height="30" width="70%" class="text">
		<%=strDescPrestAgg%>
	</td>
</tr>
<tr>
	<td height="30" width="30%" class="textB" align="right">Tipo Causale:&nbsp;&nbsp;</td>
	<td height="30" width="70%" nowrap class="text">
		 <%=strDescTipiCausali%>
	</td>
</tr>
<tr>
    <td height="30" width="30%" class="textB" align="right">Oggetto di Fatturazione:&nbsp;&nbsp;</td>
	<td height="30" width="70%" class="text">
		<%=strDescOggFatt%>
	</td>
</tr>
</table>
<!-- fine dati di riepilogo-->

<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Tariffa</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
	    <td height="30" width="15%" class="textB">Tipo Offerta</td>
		<td width="35%">
		<% vctTipiOfferta = remoteEnt_TipiOfferte.getTipiOfferte(intAction);%>
			<select class="text" name="cboTipoOfferta" onchange="change_cboTipoOfferta()">
				<option  value="">[Seleziona Opzione]</option>
				<%for(i=0;i<vctTipiOfferta.size();i++)
				{
					DB_TipiOfferte objTipoOfferta = (DB_TipiOfferte)vctTipiOfferta.elementAt(i);%>
					<option  value="<%=objTipoOfferta.getCODE_TIPO_OFF()%>"><%=objTipoOfferta.getDESC_TIPO_OFF()%></option>
			  <%}%>
			</select>
		</td>
		<td height="30" width="15%" class="textB">&nbsp;</td>
		<td width="35%" class="textB" nowrap>&nbsp;</td>
	</tr>
	<tr>
		<td height="30" width="15%" class="textB">Unità di misura</td>
		<td width="35%">
			<input type="text" name="txtUnitaMisura" class="text" value = "" size="20" maxlength="20">
		</td>
		<td height="30" width="15%" class="textB">Tipo Importo</td>
		<td width="35%" class="textB" nowrap>
			<input class="text" checked type="radio" name="rdoTipoImporto" value="F">Fisso
			<input class="text"  type="radio" name="rdoTipoImporto" value="V">Variabile
			<input class="text"  type="radio" name="rdoTipoImporto" value="A">Scaglioni
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
    <%if(blnMascheraClassi){%>
		<td class="textB" valign="top">
			Classi di Sconto
		</td>
    <%}else{%>
		<td class="redB" valign="top">
			Non è possibile associare alcuna Classe di Sconto per la categoria del P/S selezionato.
		</td>
    <%}%>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td class="textB">&nbsp;</td>
					<td class="textB"><%=strTitoloContributi%></td>
					<td class="textB">Accesso</td>
					<td class="textB">0-60 Km.</td>
					<td class="textB">61-300 Km.</td>
					<td class="textB">Oltre 300 Km.</td>
				</tr>
				<tr>
					<td class="textB">
						<%if(blnMascheraClassi){%>
							Da 0 a 3 MILIONI
						<%}%>
					</td>
					<td class="text">
						<input type="text" name="txtContributi1" class="text" value = "" size="12">
					</td>
					<td class="text">
						<input type="text" name="txtAccesso1" class="text" value = "" size="12">
					</td>
					<td class="text">
						<input type="text" name="txt0_60KM1" class="text" value = "" size="12">
					</td>
					<td class="text">
						<input type="text" name="txt61_300KM1" class="text" value = "" size="12">
					</td>
					<td class="text">
						<input type="text" name="txtOltre300KM1" class="text" value = "" size="12">
					</td>
				</tr>
				<%if(blnMascheraClassi){%>
					<tr>
						<td class="textB">
							Oltre i 3 MILIONI
						</td>
						<td class="text">
							<input type="text" name="txtContributi2" class="text" value = "" size="12">
						</td>
						<td class="text">
							<input type="text" name="txtAccesso2" class="text" value = "" size="12">
						</td>
						<td class="text">
							<input type="text" name="txt0_60KM2" class="text" value = "" size="12">
						</td>
						<td class="text">
							<input type="text" name="txt61_300KM2" class="text" value = "" size="12">
						</td>
						<td class="text">
							<input type="text" name="txtOltre300KM2" class="text" value = "" size="12">
						</td>
					</tr>
				<%}%>
			</table>
		</td>
	</tr>
  <tr>
      <%if(blnContributoTraslocoInterno){%>
        <td class="redB" valign="top">
          (*) : Gli importi devono ammontare al 50% dell'importo del Contributo di allacciamento.
        </td>
      <%}%>
  </tr>
</table>
<table border="0" align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="15%" class="textB">Descrizione Tariffa</td>
		<td height="30" width="15%" class="textB">Data Inizio Validità</td>
	</tr>
	<tr>
		<td height="30" width="35%"><input type="text" name="txtDescrizioneTariffa" class="text" value = "" size="45"></td>
		<td height="30" width="35%" valign="" nowrap>
			<input type="text" name="txtDataInizioValidita" class="text" maxlength="10" value = "<%=DataFormat.getDate()%>" size="12">
			<a href="javascript:showCalendar('frmDati.txtDataInizioValidita','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
			<a href="javascript:clearField(objForm.txtDataInizioValidita);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
		</td>
	</tr>
</table>

 <!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
		</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	  <tr>
	    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">&nbsp;&nbsp;
			<sec:ShowButtons td_class="textB"/>
	    </td>
	  </tr>
	</table>
</form>

</BODY>
</HTML>
