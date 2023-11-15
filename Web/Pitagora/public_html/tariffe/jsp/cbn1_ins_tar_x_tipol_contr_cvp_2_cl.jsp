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
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_cvp_2_cl.jsp")%>
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
    int intAction;
	int i = 0;
	Vector vctTipiOfferta = null;
	String strViewState = "";
	DB_ProdottiServizi objDbProdServ = null;
	String strCodeTipoCompo = "";
	boolean blnMascheraClassi = false;
	boolean blnImportoSingolo = false;
	String strParteMessaggio = "";
	
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
	//reperimento del campo "code_tipo_compo"
	objDbProdServ = (DB_ProdottiServizi)remoteEnt_ProdottiServizi.getPS(intAction,strCodePsCompFatt).elementAt(0);
	strCodeTipoCompo = objDbProdServ.getCODE_TIPO_COMPO();
		
	//stabilisco se visualizzare una riga o tre					
	if(strCodeClassPs.equalsIgnoreCase(StaticContext.CL_PS_BASSA01) 
    || strCodeClassPs.equalsIgnoreCase(StaticContext.CL_PS_BASSA02) 
	|| strCodePs.equalsIgnoreCase(Integer.toString(StaticContext.PS_FLUSSO_RPVD)))
	{
		blnMascheraClassi = false;
	}else{
		blnMascheraClassi = true;
	}

  // lp 09062004 in caso di tipologia contratto Accesso a Reta Dati non devono essere le classi di sconto
  if (strCodeTipoContratto.equals(Integer.toString(StaticContext.TPL_ACCESSO_RETE_DATI))) {
		blnMascheraClassi = false;
  }
  
	if( strCodeOggFatt.equals(Integer.toString(StaticContext.OF_CONTRIBUTO_DI_ATTIVAZIONE_PORTA_ATM))
	 ||	strCodeOggFatt.equals(Integer.toString(StaticContext.OF_CONTRIBUTO_PER_TRASLOCO_INTERNO))
	 || strCodeOggFatt.equals(Integer.toString(StaticContext.OF_CANONE_MENSILE_PORTA_ATM))
	 || strCodeOggFatt.equals(Integer.toString(StaticContext.OF_CONTRIBUTO_DI_ATTIVAZIONE_KIT_IMA))
	 || strCodeOggFatt.equals(Integer.toString(StaticContext.OF_CANONE_MENSILE_KIT_IMA))
	 )
	{
		blnImportoSingolo = true;
	}
	
	
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
	var blnImportoSingolo = <%=blnImportoSingolo%>;
	function Initialize()
	{
		
		objForm = document.frmDati;
		//impostazione delle proprietà dei controlli
		setDefaultProp(objForm);
		<%if(blnImportoSingolo){%>
			setObjProp(objForm.txtImportoPortaAtm1,"label=Importo non associato a classe di sconto|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		<%}%>
	<%
	    if(blnMascheraClassi){
	 		 strParteMessaggio = " per la classe di sconto Da 0 a 10 MILIARDI ";
	    }
	%>
		setObjProp(objForm.txtContributi1,"label=Contributi<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txtAccesso1,"label=Accesso<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txt0_60KM1,"label=0-60 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txt61_300KM1,"label=61-300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txtOltre300KM1,"label=Oltre 300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		
		setObjProp(objForm.txtDataInizioValidita,"label=Data Inizio Validità|tipocontrollo=data|obbligatorio=si");
		setObjProp(objForm.txtDescrizioneTariffa,"label=Descrizione Tariffa|obbligatorio=si");
		
		<%if(blnMascheraClassi){%>
			<%strParteMessaggio = " per la classe di sconto Da 10 a 50 MILIARDI ";%>
			
			setObjProp(objForm.txtContributi2,"label=Contributi<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txtAccesso2,"label=Accesso<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt0_60KM2,"label=0-60 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt61_300KM2,"label=61-300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txtOltre300KM2,"label=Oltre 300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			
			<%strParteMessaggio = " per la classe di sconto > di 50 MILIRDI ";%>
			setObjProp(objForm.txtContributi3,"label=Contributi<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txtAccesso3,"label=Accesso<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt0_60KM3,"label=0-60 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt61_300KM3,"label=61-300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txtOltre300KM3,"label=Oltre 300 Km.<%=strParteMessaggio%>|tipocontrollo=importo|maxnumericvalue=999999999999,999999|obbligatorio=no|maschera=<%=StaticContext.nfInputMask%>");
		<%}%>
		//disabilito tutti i controlli e abilito solo quelli necessari in base alle condizioni
		DisableAllControls(objForm);
		Enable(objForm.CHIUDI);
		
		//controllo per importo fisso
		if(blnImportoSingolo)
		{
			if(blnDebbug){
					alert("blnImportoSingolo = " + blnImportoSingolo);
			}
			EnableFieldImporto("IS"); //importo singolo
			objForm.txtUnitaMisura.value = "";
			objForm.hidCodeUnitaMisura.value = "";
			Enable(objForm.CONFERMA);
		}else{
			
			//altri controlli se non è importo singolo
			if(strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE%>" && strCodeClassOggFatt == "<%=StaticContext.CL_CONTRIBUTO%>")
			{
					 if(blnDebbug){
						alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeClassOggFatt=<%=strCodeClassOggFatt%>");
					 }
					 EnableFieldImporto("C");
			}
			
			if((strCodeTipoCompo == "<%=StaticContext.TC_TERMINAZIONE%>" 
			 		&& (strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_RACC_CENTRALE%>"
					 || strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_AGGIUNTIVO_PER_DIRAMAZIONE_ATTIVA%>"
					 || strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_AGGIUNTIVO_PER_PUNTO_DI_DERIVAZIONE%>"
					 || strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_PORTA_ATM%>"))){
					 if(blnDebbug){
						alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeOggFatt=<%=strCodeOggFatt%>");
					 }
					 EnableFieldImporto("A");
					 
			}
			
			if(strCodeTipoCompo == "<%=StaticContext.TC_PARTE_TRASMISSIVA%>" && strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>")
			{
				 if(blnDebbug){
						alert("strCodeTipoCompo = <%=strCodeTipoCompo%>" + " - " + "strCodeClassOggFatt=<%=strCodeClassOggFatt%>");
				 }
				 EnableFieldImporto("F");
			}
			Enable(objForm.cboTipoOfferta);
			//se il codice classe oggetto di fatturazione è canone
			
			/*if(strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>")
			{
				objForm.txtUnitaMisura.value = "Chilometro(KM)";
				objForm.hidCodeUnitaMisura.value = "<%=StaticContext.UM_KM%>";
			}else{
				objForm.txtUnitaMisura.value = "";
				objForm.hidCodeUnitaMisura.value = "";
			}*/
		}
		
		if(strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>")
		{
			objForm.txtUnitaMisura.value = "Chilometro(KM)";
			objForm.hidCodeUnitaMisura.value = "<%=StaticContext.UM_KM%>";
		}else{
			objForm.txtUnitaMisura.value = "";
			objForm.hidCodeUnitaMisura.value = "";
		}
		//impostazioni fisse
		Enable(objForm.ANNULLA);
		//Disable(objForm.txtDataInizioValidita);
		Enable(objForm.txtDescrizioneTariffa);
		objForm.txtDescrizioneTariffa.value = "<%=strDescPsCompFatt%>" + " - " + "<%=strDescOggFatt%>"; 
		if(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE%>")
		{
			objForm.rdoTipoImporto[1].checked = true; //variabile
		}else{
			objForm.rdoTipoImporto[0].checked = true; //fisso
		}
	}

function ONCHIUDI()
{
  window.close();
}
	
	function ONANNULLA()
	{
		//Disable(objForm.CONFERMA);
		clearField(objForm.cboTipoOfferta);
		clearField(objForm.txtDescrizioneTariffa);		
		clearField(objForm.txtContributi1);
		clearField(objForm.txtAccesso1);
		clearField(objForm.txt0_60KM1);
		clearField(objForm.txt61_300KM1);
		clearField(objForm.txtOltre300KM1);
		if(blnImportoSingolo){
			clearField(objForm.txtImportoPortaAtm1);
		}
		
		<%if(blnMascheraClassi){%>
			clearField(objForm.txtContributi2);
			clearField(objForm.txtAccesso2);
			clearField(objForm.txt0_60KM2);
			clearField(objForm.txt61_300KM2);
			clearField(objForm.txtOltre300KM2);
			
			clearField(objForm.txtContributi3);
			clearField(objForm.txtAccesso3);
			clearField(objForm.txt0_60KM3);
			clearField(objForm.txt61_300KM3);
			clearField(objForm.txtOltre300KM3);
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
			if(blnImportoSingolo){
				updVS(objForm.hidViewState,"vsMascheraClassi","false");
				updVS(objForm.hidViewState,"vsImportoPortaAtm",objForm.txtImportoPortaAtm1.value);
			}else{
				updVS(objForm.hidViewState,"vsImportoPortaAtm","");
			}
			objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_cvp_3_cl.jsp";
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
					
					setObjProp(objForm.txtContributi<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txtAccesso<%=strFieldIndex3%>,"<%=strOn%>");
					setObjProp(objForm.txt0_60KM<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txt61_300KM<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txtOltre300KM<%=strFieldIndex3%>,"<%=strOff%>");
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
					
					setObjProp(objForm.txtContributi<%=strFieldIndex3%>,"<%=strOn%>");
					setObjProp(objForm.txtAccesso<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txt0_60KM<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txt61_300KM<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txtOltre300KM<%=strFieldIndex3%>,"<%=strOff%>");
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
					
					setObjProp(objForm.txtContributi<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txtAccesso<%=strFieldIndex3%>,"<%=strOff%>");
					setObjProp(objForm.txt0_60KM<%=strFieldIndex3%>,"<%=strOn%>");
					setObjProp(objForm.txt61_300KM<%=strFieldIndex3%>,"<%=strOn%>");
					setObjProp(objForm.txtOltre300KM<%=strFieldIndex3%>,"<%=strOn%>");
				<%}%>
				break;
			case "IS":
					setObjProp(objForm.txtImportoPortaAtm1,"<%=strOn%>");
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO ACCESSO A RETE DATI</td>
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

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	<td width='15%' class="textB">Tipologia Contratto:&nbsp;</td>
	<td width='35%' class="text">
		&nbsp;<%=strDescTipoContratto%>
	</td>
	<td width='15%'>&nbsp;</td>
	<td width='35%'>&nbsp;</td>
</tr>
<tr>
    <td height="30" width="15%"class="textB">Prodotto/Servizio</td>
    <td height="30" width="85%" colspan="3" class="text">
		<%=strDescPs%>
	</td>
</tr>
<tr>
    <td height="30" width="15%"class="textB">P/S Componenti di Fatturazione</td>
    <td height="30" width="85%" colspan="3" class="text">
		<%=strDescPsCompFatt%>
	</td>
</tr>
<tr>
    <td height="30" width="15%" class="textB">Prest.Aggiuntiva</td>
	<td height="30" width="35%" class="text">
		<%=strDescPrestAgg%>
	</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td height="30" width="15%" class="textB">Tipo Causale</td>
	<td height="30" width="35%" nowrap class="text">
		 <%=strDescTipiCausali%>
	</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<tr>
    <td height="30" width="15%" class="textB">Oggetto di Fatturazione</td>
	<td height="30" width="35%" class="text">
		<%=strDescOggFatt%>
	</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
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
<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
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

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td class="textB" valign="top">
			Classi di Sconto
		</td>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td class="textB">&nbsp;</td>
					<td class="textB">Contributi</td>
					<td class="textB">Accesso</td>
					<td class="textB">0-60 Km.</td>
					<td class="textB">61-300 Km.</td>
					<td class="textB">Oltre 300 Km.</td>
				</tr>
				<tr>
					<td class="textB">
						<%if(blnMascheraClassi){%>
							Da 0 a 10 MILIARDI
						<%}%>
					</td>
					<td class="text">
						<input type="text" name="txtContributi1" class="text" value = "" size="12" maxlength="15">
					</td>
					<td class="text">
						<input type="text" name="txtAccesso1" class="text" value = "" size="12" maxlength="15">
					</td>
					<td class="text">
						<input type="text" name="txt0_60KM1" class="text" value = "" size="12" maxlength="15">
					</td>
					<td class="text">
						<input type="text" name="txt61_300KM1" class="text" value = "" size="12" maxlength="15">
					</td>
					<td class="text">
						<input type="text" name="txtOltre300KM1" class="text" value = "" size="12" maxlength="15">
					</td>
				</tr>
				<%if(blnMascheraClassi){%>
					<tr>
						<td class="textB">
							Da 10 a 50 MILIARDI
						</td>
						<td class="text">
							<input type="text" name="txtContributi2" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txtAccesso2" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txt0_60KM2" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txt61_300KM2" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txtOltre300KM2" class="text" value = "" size="12" maxlength="15">
						</td>
					</tr>
					<tr>
						<td class="textB">
							> di 50 MILIRDI
						</td>
						<td class="text">
							<input type="text" name="txtContributi3" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txtAccesso3" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txt0_60KM3" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txt61_300KM3" class="text" value = "" size="12" maxlength="15">
						</td>
						<td class="text">
							<input type="text" name="txtOltre300KM3" class="text" value = "" size="12" maxlength="15">
						</td>
					</tr>
				<%}%>
			</table>
		</td>
	</tr>
</table>
<table border="0" align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="15%" class="textB">Descrizione Tariffa</td>
		<%if(blnImportoSingolo){%>
			<td height="30" width="15%" class="textB">Importo non associato a classe di sconto</td>
		<%}%>
		<td height="30" width="15%" class="textB">Data Inizio Validità</td>
	</tr>
	<tr>
		<td height="30" width="35%"><input type="text" name="txtDescrizioneTariffa" class="text" value = "" size="45"></td>
		<%if(blnImportoSingolo){%>
			<td height="30" width="15%" >
				<input type="text" name="txtImportoPortaAtm1" class="text" value = "" maxlength="15" size="14">
			</td>
		<%}%>
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
	    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">
			<sec:ShowButtons td_class="textB"/>
	    </td>
	  </tr>
	</table>
</form>

</BODY>
</HTML>
