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
<%@ page import="com.ejbSTL.Ent_ClassOggFatt" %>
<%@ page import="com.ejbSTL.Ent_ClassOggFattHome" %>
<%@ page import="com.ejbSTL.Ent_Frequenze" %>
<%@ page import="com.ejbSTL.Ent_FrequenzeHome" %>
<%@ page import="com.ejbSTL.Ent_Map" %>
<%@ page import="com.ejbSTL.Ent_MapHome" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>


<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_ass_ofps_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->
<EJB:useHome id="homeEnt_ClassOggFatt" type="com.ejbSTL.Ent_ClassOggFattHome" location="Ent_ClassOggFatt" />
<EJB:useBean id="remoteEnt_ClassOggFatt" type="com.ejbSTL.Ent_ClassOggFatt" scope="session">
    <EJB:createBean instance="<%=homeEnt_ClassOggFatt.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Frequenze" type="com.ejbSTL.Ent_FrequenzeHome" location="Ent_Frequenze" />
<EJB:useBean id="remoteEnt_Frequenze" type="com.ejbSTL.Ent_Frequenze" scope="session">
    <EJB:createBean instance="<%=homeEnt_Frequenze.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Map" type="com.ejbSTL.Ent_MapHome" location="Ent_Map" />
<EJB:useBean id="remoteEnt_Map" type="com.ejbSTL.Ent_Map" scope="session">
    <EJB:createBean instance="<%=homeEnt_Map.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
    
    int intAction;
	int intFunzionalita;
	 if(request.getParameter("intFunzionalita") == null){
	  intFunzionalita = StaticContext.FN_TARIFFA;
	 }else{
	  intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	 }
    if(request.getParameter("intAction") == null){
        intAction = StaticContext.LIST;
    }else{
        intAction = Integer.parseInt(request.getParameter("intAction"));
    }
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	Inserimento Associazione OF a P/S e Contratto
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
	var lstrDataInizioValidOf_OGGFAT="";
	var lstrDataFineValidOf_OGGFAT="";
	function Initialize()
	{
		objForm = document.frmDati;
		//inizializzazione attributi campi per la validazione
		setDefaultProp(objForm);
		setObjProp(objForm.txtCliente,"label=Cliente|obbligatorio=si");
		setObjProp(objForm.cboContratto,"label=Contratto|obbligatorio=si");
		setObjProp(objForm.txtPs,"label=Prodotto/Servizio|obbligatorio=si");
		setObjProp(objForm.cboPrestAgg,"label=Prestazione Aggiuntiva|obbligatorio=si");
		setObjProp(objForm.cboTipoCausale,"label=Tipo Causale|obbligatorio=si");
		setObjProp(objForm.cboClasseFat,"label=Classe dell'oggetto di Fatturazione|obbligatorio=si");
		setObjProp(objForm.cboDescrizioneFat,"label=Descrizione dell'oggetto di Fatturazione|obbligatorio=si");
		setObjProp(objForm.txtDataInizioValidita, "label=Data Inizio Validità|tipocontrollo=data|obbligatorio=si");
		setObjProp(objForm.txtShiftCanoni,"label=Shift Canoni|tipocontrollo=intero|minnumericvalue=1");
		
		//l'obbligatorietà dei campi della MODALITA DI APPLICAZIONE viene impostata successivamente alla selezione 
		//della descrizione dell'oggetto di fatturazione!
		//FINE inizializzazione attributi campi per la validazione
		DisableAllControls(objForm);
		
		//disabilitazione delle date
		//DisableLink(document.links[0],objForm.imgCalendar)
		//DisableLink(document.links[1],objForm.imgCancel)
		//DisableLink(document.links[2],objForm.imgCalendar1)
		//DisableLink(document.links[3],objForm.imgCancel1)
		
		Enable(objForm.cmdCliente);
		Enable(objForm.ANNULLA);
		
		//reset dei campi del form
		objForm.reset();
		//focus
		setFocus(objForm.cmdCliente);
	}
	//GESTIONE EVENTI CAMPI
	//+++++CLIENTE ++++++
	function click_cmdCliente(){
		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp"
		strURL+="?nomeCombo=objForm.cboContratto"
		strURL+="&codiceTipoContratto="+getVS(objForm.viewState,'codeTipoContratto')
		strURL+="&intAction=<%=intAction%>";
  		openDialog(strURL, 569, 400, handleReturnedValueCliente);
	}
	function handleReturnedValueCliente(){
		var strReturnValue = dialogWin.returnedValue.split("|");
		//salvataggio descrizione cliente
		objForm.txtCliente.value = strReturnValue[0];
		//salvataggio codice cliente nel viewState
		updVS(objForm.viewState,"codeCliente",strReturnValue[1]);
		//abilito la combo cboContratto riempita dal popup
		Enable(objForm.cboContratto);
		
		//Disabilito i campi
			DisableAllControls(objForm);
			
			Enable(objForm.cmdCliente);
			Enable(objForm.cboContratto);
			//Enable(objForm.cmdIndietro);
			Enable(objForm.ANNULLA);
		//svuoto i campi
			delVS(objForm.viewState,"codePs");
			
			setFirstCboElement(objForm.cboContratto);
			objForm.txtPs.value="";
			setFirstCboElement(objForm.cboPrestAgg);
			setFirstCboElement(objForm.cboTipoCausale);
			setFirstCboElement(objForm.cboClasseFat);
			setFirstCboElement(objForm.cboDescrizioneFat);
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
	}
	//+++++CONTRATTO ++++++
	function change_cboContratto(){
		//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cboContratto);
			Enable(objForm.cmdPs);
			Enable(objForm.ANNULLA);
			//svuoto i campi
			delVS(objForm.viewState,"codePs");
			objForm.txtPs.value="";
			setFirstCboElement(objForm.cboPrestAgg);
			setFirstCboElement(objForm.cboTipoCausale);
			setFirstCboElement(objForm.cboClasseFat);
			setFirstCboElement(objForm.cboDescrizioneFat);
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
		if(getComboValue(objForm.cboContratto)==""){
			//Disabilito i campi
			Disable(objForm.cmdCliente);
		}else{
			Enable(objForm.cmdCliente);
		}
	}
	//+++++CONTRATTO DEST++++++
	function change_cboContrattoDest(){
		if(getComboValue(objForm.cboContrattoDest)==""){
			objForm.hidDescContrattoDest.value="";
		}else{
			objForm.hidDescContrattoDest.value=getComboText(objForm.cboContrattoDest);
		}
	}
	//+++++P/S OR++++++++++++++
	function click_cmdPs(){
  		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_cl.jsp"
//		strURL+="?funzionalita=Contratto"
		strURL+="?nomeCombo=objForm.cboPrestAgg"
		strURL+="&intAction=<%=intAction%>"
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
		strURL+="&CodeContr="+getComboValue(objForm.cboContratto);
		strURL+="&Cliente="+objForm.txtCliente.value;
		strURL+="&CodeCliente="+getVS(objForm.viewState,'codeCliente');
		strURL+="&Contratto="+escape(getComboText(objForm.cboContratto));
		strURL+="&hidCodiceTipoContratto=<%=request.getParameter("codiceTipoContratto")%>";
		strURL+="&hidDescTipoContratto=<%=request.getParameter("hidDescTipoContratto")%>";
		strURL+="&parMostraCliente=si&parMostraContratto=si";
  		openDialog(strURL, 569, 400,handleReturnedValuePs);
  	}
	function handleReturnedValuePs(){
		var field = dialogWin.returnedValue.split("|");
		objForm.txtPs.value=field[1];
		//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdCliente);
			Enable(objForm.cboContratto);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			//Enable(objForm.cmdIndietro);
			Enable(objForm.ANNULLA);
			
			//svuoto i campi
			updVS(objForm.viewState,"codePs",field[0]);
			setFirstCboElement(objForm.cboPrestAgg);
			setFirstCboElement(objForm.cboTipoCausale);
			setFirstCboElement(objForm.cboClasseFat);
			setFirstCboElement(objForm.cboDescrizioneFat);
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
	}
	function change_cboPrestAgg(){
		if(getComboValue(objForm.cboPrestAgg)==""){
			//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdCliente);
			Enable(objForm.cboContratto);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			//Enable(objForm.cmdIndietro);
			Enable(objForm.ANNULLA);
			
			//svuoto i campi
			setFirstCboElement(objForm.cboTipoCausale);
			setFirstCboElement(objForm.cboClasseFat);
			setFirstCboElement(objForm.cboDescrizioneFat);
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
		}else{
			//popup cha carica i tipi causali
			var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_TipiCausale_cl.jsp";
			strURL+="?nomeComboTipoCaus=objForm.cboTipoCausale";
			strURL+="&intAction=<%=intAction%>";
			strURL+="&intFunzionalita=<%=intFunzionalita%>";
			strURL+="&CodePs="+getVS(objForm.viewState,"codePs");
			strURL+="&CodeCliente="+getVS(objForm.viewState,'codeCliente');
			strURL+="&CodeContr="+getComboValue(objForm.cboContratto);
			strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg)//;.split("$")[0];
			strURL+="&CodeTipoContratto=<%=request.getParameter("codiceTipoContratto")%>";
			strURL+="&CodeOggFatt="+getComboValue(objForm.cboDescrizioneFat).split("$")[0];
		    openDialog(strURL, 400, 5,handleReturnedValuePrestAgg);
		}
	
	}
	function handleReturnedValuePrestAgg(){
		//controllo lo stato d'esito assegnato al popup
		if(dialogWin.state=="0"){//ESEGUITO
			Enable(objForm.cboTipoCausale);
		}else{//ANNULLATO
			Enable(objForm.cboTipoCausale);
		}
	}
	function change_cboTipoCausale(){
		//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdCliente);
			Enable(objForm.cboContratto);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			Enable(objForm.cboTipoCausale);
			//Enable(objForm.cmdIndietro);
			Enable(objForm.ANNULLA);
			//svuoto i campi
			setFirstCboElement(objForm.cboClasseFat);
			setFirstCboElement(objForm.cboDescrizioneFat);
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
		if(getComboValue(objForm.cboTipoCausale)==""){
			Disable(objForm.cboClasseFat);
		}else{
			Enable(objForm.cboClasseFat);
		}
	}
	function change_cboClasseFat(){
		//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdCliente);
			Enable(objForm.cboContratto);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			Enable(objForm.cboTipoCausale);
			Enable(objForm.cboClasseFat);
			//Enable(objForm.cmdIndietro);
			Enable(objForm.ANNULLA);
			//svuoto i campi
			setFirstCboElement(objForm.cboDescrizioneFat);
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			objForm.txtDISDataInizioValiditaOF.value="";
			objForm.txtDISDataFineValiditaOF.value="";
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
		if(getComboValue(objForm.cboClasseFat)==""){
			Disable(objForm.cboDescrizioneFat);
		}else{
			//popup cha carica gli oggetti di fatturazione
			var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_OggettiFatturazione_cl.jsp";
			strURL+="?intAction=<%=intAction%>";
			strURL+="&intFunzionalita=<%=intFunzionalita%>";
			strURL+="&nomeComboOggFat=objForm.cboDescrizioneFat";
			strURL+="&CodeTipoContratto="+getVS(objForm.viewState,"codeTipoContratto");
			strURL+="&CodeCliente="+getVS(objForm.viewState,"codeCliente");
			strURL+="&CodeContr="+getComboValue(objForm.cboContratto);
		    strURL+="&CodePs="+getVS(objForm.viewState,"codePs");
			strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg);//.split("$")[0];
			strURL+="&CodeClasse="+getComboValue(objForm.cboClasseFat);
			openDialog(strURL, 400, 5,handleReturnedClasseFat);
		}
	}
	function handleReturnedClasseFat(){
		Enable(objForm.cboDescrizioneFat);
	}
	function change_cboDescrizioneFat(){
		//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdCliente);
			Enable(objForm.cboContratto);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			Enable(objForm.cboTipoCausale);
			Enable(objForm.cboClasseFat);
			Enable(objForm.cboDescrizioneFat);
			//Enable(objForm.cmdIndietro);
			Enable(objForm.ANNULLA);
			//svuoto i campi
			setFirstCboElement(objForm.cboFrequenza);
			setFirstCboElement(objForm.cboModalitaProrata);
			setFirstCboElement(objForm.cboModalita);
			objForm.txtShiftCanoni.value="";
			objForm.txtDataInizioValidita.value="";
			objForm.txtDataFineValidita.value="";
		if(getComboValue(objForm.cboDescrizioneFat).split("$")[0]!=""){
			//Controllo l'item selezionato nella classe dell'oggetto di fatturazione
			switch (parseInt(getComboValue(objForm.cboClasseFat))){
				case 1://CONTRIBUTO
					setObjProp(objForm.cboFrequenza,"label=Frequenza della Modalita di Applicazione|obbligatorio=no");
					setObjProp(objForm.cboModalitaProrata,"label=Modalita di Applicazione Prorata|obbligatorio=no");
					setObjProp(objForm.cboModalita,"label=Modalita di Applicazione|obbligatorio=no");
					//seleziono una tantum (value=1)sulla Frequenza
					selectComboByValue(objForm.cboFrequenza,"1");
					//imposto a zero lo shift canoni
					objForm.txtShiftCanoni.value="0";
					//disablito il controllo su minnumericvalue perchè altrimenti 
					// mi darebbe un messaggio di errore
					setObjProp(objForm.txtShiftCanoni,"minnumericvalue=0");
				break;
				case 2://CANONE
					Enable(objForm.cboFrequenza);
					Enable(objForm.cboModalitaProrata);
					Enable(objForm.cboModalita);
					setObjProp(objForm.cboFrequenza,"label=Frequenza della Modalita di Applicazione|obbligatorio=si");
					setObjProp(objForm.cboModalitaProrata,"label=Modalita di Applicazione Prorata|obbligatorio=si");
					setObjProp(objForm.cboModalita,"label=Modalita di Applicazione|obbligatorio=si");
				break;
				case 3://ALTRO
					setObjProp(objForm.cboFrequenza,"label=Frequenza della Modalita di Applicazione|obbligatorio=no");
					setObjProp(objForm.cboModalitaProrata,"label=Modalita di Applicazione Prorata|obbligatorio=no");
					setObjProp(objForm.cboModalita,"label=Modalita di Applicazione|obbligatorio=no");
				break;
			}
			//Controllo sulla obbligatorietà della data di fine validità!
			lstrDataInizioValidOf_OGGFAT=getComboValue(objForm.cboDescrizioneFat).split("$")[2];
			lstrDataFineValidOf_OGGFAT=getComboValue(objForm.cboDescrizioneFat).split("$")[3];
			if(lstrDataFineValidOf_OGGFAT!=""){
				setObjProp(objForm.txtDataFineValidita, "label=Data Fine Validità|tipocontrollo=data|obbligatorio=si");
				//deve essere minore di lstrDataFineValidOf_OGGFAT
			}else{
				setObjProp(objForm.txtDataFineValidita, "label=Data Fine Validità|tipocontrollo=data|obbligatorio=no");
				//deve essere maggiore di lstrDataInizioValidOf_OGGFAT
			}
			//FINE Controllo sulla obbligatorietà della data di fine validità!
			Enable(objForm.CONFERMA);
			//VISUALIZZAZIONE DATE INIZIO/FINE VALID OF
			objForm.txtDISDataInizioValiditaOF.value=lstrDataInizioValidOf_OGGFAT;
			objForm.txtDISDataFineValiditaOF.value=lstrDataFineValidOf_OGGFAT;
		}else{
			objForm.txtDISDataInizioValiditaOF.value="";
			objForm.txtDISDataFineValiditaOF.value="";
		}
	}
	function change_cboFrequenza(){
	}
	function change_cboModalitaProrata(){
	}
	function change_cboModalita(){
			objForm.txtShiftCanoni.value="";
		if(getComboValue(objForm.cboModalita)==""||getComboValue(objForm.cboModalita)=="P"){
			Disable(objForm.txtShiftCanoni);
			setObjProp(objForm.txtShiftCanoni,"label=Shift Canoni della Modalita di Applicazione|obbligatorio=no|tipocontrollo=intero|minnumericvalue=1");
		}else{
			Enable(objForm.txtShiftCanoni);
			setObjProp(objForm.txtShiftCanoni,"label=Shift Canoni della Modalita di Applicazione|obbligatorio=si|tipocontrollo=intero|minnumericvalue=1");
		}
	}
	//GESTIONE PULSANTI
	function ONCONFERMA(){
		if(validazioneCampi(objForm)){
			//CONTROLLO DELLE DATA DI VALIDITA INSERITE CON QUELLE DELL' OGG FATT
			if(dateToInt(lstrDataInizioValidOf_OGGFAT) > dateToInt(objForm.txtDataInizioValidita.value)){
				alert("Data Inizio Validità Inferiore alla Data Inizio Validità dell'Oggetto di Fatturazione:\n" + lstrDataInizioValidOf_OGGFAT);
				return;
			}
			if(lstrDataFineValidOf_OGGFAT!=""){
				//deveno essere minori di lstrDataFineValidOf_OGGFAT
				
				if(dateToInt(lstrDataFineValidOf_OGGFAT)<dateToInt(objForm.txtDataInizioValidita.value)){
					alert("Data Inizio Validità Superiore alla Data Fine Validità dell'Oggetto di Fatturazione:\n" + lstrDataFineValidOf_OGGFAT);
					return;
				}
				
				if(objForm.txtDataFineValidita.value!=""){
					if(dateToInt(lstrDataFineValidOf_OGGFAT)<dateToInt(objForm.txtDataFineValidita.value)){
						alert("Data Fine Validità Superiore alla Data Fine Validità dell'Oggetto di Fatturazione:\n" + lstrDataFineValidOf_OGGFAT);
						return;
					}
				}
			}else{
				setObjProp(objForm.txtDataFineValidita, "label=Data Fine Validità|tipocontrollo=data|obbligatorio=no");
				//deve essere maggiore di lstrDataInizioValidOf_OGGFAT
				
				if(objForm.txtDataFineValidita.value!=""){
					if(dateToInt(lstrDataInizioValidOf_OGGFAT)>dateToInt(objForm.txtDataFineValidita.value)){
						alert("Data Inizio Validità Superiore alla Data Fine Validità dell'Oggetto di Fatturazione:\n" + lstrDataFineValidOf_OGGFAT);
						return;
					}
				}
			}
			//FINECONTROLLO DELLE DATA DI VALIDITA INSERITE CON QUELLE DELL' OGG FATT
			objForm.action="<%=StaticContext.PH_ASSOCIAZIONIOFPS_JSP%>cbn1_ins_ass_ofps_2_cl.jsp";
			if(objForm.txtDataFineValidita.value != ""){
				if(dateToInt(objForm.txtDataInizioValidita.value) >= dateToInt(objForm.txtDataFineValidita.value)){
					alert("La data di fine Validità deve essere maggiore della data Inizio!!");
					return;
				}
				if(dateToInt(objForm.txtDataFineValidita.value) < dateToInt("<%=DataFormat.getDate()%>"))
				{
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3129")%>");
					setFocus(objForm.txtDataFineValidita);
					return;
				}
			}
			
			/*MODIFICA POPUP*/
				var strURL_POPUP = "";
				strURL_POPUP = "<%=StaticContext.PH_ASSOCIAZIONIOFPS_JSP%>cbn1_ins_ass_ofps_2_cl.jsp"
				strURL_POPUP += "?viewState="+objForm.viewState.value
				strURL_POPUP += "&cboDescrizioneFat="+objForm.cboDescrizioneFat.value
				strURL_POPUP += "&cboTipoCausale="+objForm.cboTipoCausale.value
				strURL_POPUP += "&cboPrestAgg="+objForm.cboPrestAgg.value
				strURL_POPUP += "&cboClasseFat="+objForm.cboClasseFat.value
				strURL_POPUP += "&cboContratto="+objForm.cboContratto.value
				strURL_POPUP += "&txtDataInizioValidita="+objForm.txtDataInizioValidita.value
				strURL_POPUP += "&txtDataFineValidita="+objForm.txtDataFineValidita.value
				strURL_POPUP += "&cboModalita="+objForm.cboModalita.value
				strURL_POPUP += "&cboFrequenza="+objForm.cboFrequenza.value
				strURL_POPUP += "&cboModalitaProrata="+objForm.cboModalitaProrata.value
				strURL_POPUP += "&txtShiftCanoni="+objForm.txtShiftCanoni.value
				openDialog(strURL_POPUP, 600, 500,handleReturnedPopUp);
			/*FINE MODIFICA POPUP*/
			
			//abilito tutti i campi per evitare che alcuni fossero disabilitati e non venisse spedito
			//il proprio valore
			//EnableAllControls(objForm);
			//objForm.submit();
		}
	}
	
	//funzione richiamata dopo che è stato aperto il popup all'atto della conferma
	function handleReturnedPopUp(){
		objForm.cboClasseFat.selectedIndex=0;
		change_cboClasseFat();
	}

	function ONANNULLA(){
		objForm.reset();
		Initialize();
	}
	
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="viewState" size="100" value="codeTipoContratto=<%=request.getParameter("codiceTipoContratto")%>">
<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_ASSOCIAZIONIOFPS_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Inserimento associazione OF a P/S a Contratto: <%=request.getParameter("hidDescTipoContratto")%></td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<br>
	<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Prodotto/Servizio</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	<td height="30" width='25%' class="textB">&nbsp;Tipologia Contratto</td>
	<td height="30" width='75%' colspan="3" class="textB">
		<%=request.getParameter("hidDescTipoContratto")%>
	</td>
</tr>
<tr>
    <td height="30" width="25%" class="textB">&nbsp;Cliente</td>
	<td height="30" width="25%" nowrap>
		<input class="text" title="Cliente" type="text" maxlength="30" name="txtCliente" value="" size="20">
        <input class="text" title="Cliente" type="button" maxlength="30" name="cmdCliente" value="..." onClick="click_cmdCliente();">
	</td>
	<td height="30" width="25%" class="textB">&nbsp;Contratto</td>
	<td height="30" width="25%" class="text">&nbsp;
		<select class="text" title="Contratto" name="cboContratto" onchange="change_cboContratto();">
             <option class="text" value="">[Seleziona Opzione]</option>
             <option value="-2">&nbsp;</option>
             <option value="-3">&nbsp;</option>
             <option value="-4">&nbsp;</option>
             <option value="-5">&nbsp;</option>
             <option value="-6">&nbsp;</option>
             <option value="-7">&nbsp;</option>
             <option value="-8">&nbsp;</option>
             <option value="-9">&nbsp;</option>
             <option value="-10">&nbsp;</option>
         </select>
	</td>
</tr>
<tr>
    <td height="30" width="25%"class="textB">&nbsp;Prodotto/Servizio</td>
    <td height="30" width="25%" colspan="3">
		<input class="text" title="P/S"  type="text" size="60" maxlength="30" name="txtPs" value="">
        <input class="text" title="P/S"  type="button" name="cmdPs" value="..." onClick="click_cmdPs();">	
	</td>
</tr>
<tr>
    <td height="30" width="25%" class="textB">&nbsp;Prest. Aggiuntiva</td>
	<td height="30" width="25%" class="text">
		<select class="text" title="Prestazione Aggiuntiva" name="cboPrestAgg" onchange="change_cboPrestAgg();" >
          <option class="text"  value="">[Seleziona Opzione]</option>
          <option value="-2">&nbsp;</option>
          <option value="-3">&nbsp;</option>
          <option value="-4">&nbsp;</option>
          <option value="-5">&nbsp;</option>
          <option value="-6">&nbsp;</option>
          <option value="-7">&nbsp;</option>
          <option value="-8">&nbsp;</option>
          <option value="-9">&nbsp;</option>
          <option value="-10">&nbsp;</option>
        </select>
	</td>
	<td height="30" width="25%" class="textB">&nbsp;Tipo Causale</td>
	<td height="30" width="25%" class="text">&nbsp;
		<select class="text" title="Tipo Causale" name="cboTipoCausale" onchange="change_cboTipoCausale();">
           <option class="text" value="">[Seleziona Opzione]</option>
           <option value="-2">&nbsp;</option>
           <option value="-3">&nbsp;</option>
           <option value="-4">&nbsp;</option>
           <option value="-5">&nbsp;</option>
           <option value="-6">&nbsp;</option>
           <option value="-7">&nbsp;</option>
           <option value="-8">&nbsp;</option>
           <option value="-9">&nbsp;</option>
           <option value="-10">&nbsp;</option>
         </select>
	</td>
</tr>
<tr>
  <td  colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
</tr>
</table>


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

<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="25%" class="textB">&nbsp;Classe</td>
		<td height="30" width="75%" class="text" colspan="3">
			<select class="text" title="Classe Fatturazione" name="cboClasseFat" onchange="change_cboClasseFat();">
				<option class="text" value="">[Seleziona Opzione]</option>
				<%Vector lvct_ClassOggFatt = (Vector)remoteEnt_ClassOggFatt.getclassoggfatt(intAction);
			    remoteEnt_ClassOggFatt.remove();
			      for(int i=0;i<lvct_ClassOggFatt.size();i++)
			      {
			        DB_ClassOggFatt myelement=new DB_ClassOggFatt();
			        myelement=(DB_ClassOggFatt)lvct_ClassOggFatt.elementAt(i);%>
					<option value="<%=myelement.getCODE_CLAS_OGG_FATRZ()%>"><%=myelement.getDESC_CLAS_OGG_FATRZ()%></option>
				<%}%>
			</select>
		</td>
	</tr>
	<tr>
		<td height="30" width="25%" class="textB">&nbsp;Descrizione</td>
		<td height="30" width="75%" class="text" colspan="3">
			<select class="text" title="Descrizione Fatturazione" name="cboDescrizioneFat" onchange="change_cboDescrizioneFat();">
				<option class="text" value="">[Seleziona Opzione]</option>
				<option value="-2">&nbsp;</option>
				<option value="-3">&nbsp;</option>
				<option value="-4">&nbsp;</option>
				<option value="-5">&nbsp;</option>
				<option value="-6">&nbsp;</option>
				<option value="-7">&nbsp;</option>
				<option value="-8">&nbsp;</option>
				<option value="-9">&nbsp;</option>
				<option value="-10">&nbsp;</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="30" width="25%" class="textB" nowrap>&nbsp;Data Inizio Validità OF</td>
		<td height="30" width="25%" class="text"><input class="text" title="" type="text" maxlength="15" name="txtDISDataInizioValiditaOF" value="" size="10"></td>
		<td height="30" width="25%" class="textB" nowrap>&nbsp;Data Fine Validità OF</td>
		<td height="30" width="25%" class="text"><input class="text" title="" type="text" maxlength="15" name="txtDISDataFineValiditaOF" value="" size="10"></td>
	</tr>
	<tr>
	  <td  colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
	</tr>
</table>
<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Modalità Applicazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="25%" class="textB">&nbsp;Frequenza</td>
		<td height="30" width="25%" class="text">
			<select class="text" title="Frequenza" name="cboFrequenza" onchange="change_cboFrequenza();">
				<option class="text" value="">[Seleziona Opzione]</option>
				<%Vector lvct_Frequenze = (Vector)remoteEnt_Frequenze.getFrequenze(intAction);
			    remoteEnt_Frequenze.remove();
			      for(int i=0;i<lvct_Frequenze.size();i++)
			      {
			        DB_Frequenze myelement=new DB_Frequenze();
			        myelement=(DB_Frequenze)lvct_Frequenze.elementAt(i);%>
					<option value="<%=myelement.getCODE_FREQ_APPL()%>"><%=myelement.getDESC_FREQ_APPL()%></option>
				<%}%>
			</select>
		</td>
		<td height="30" width="25%" class="textB">&nbsp;Modalità appl.ne prorata</td>
		<td height="30" width="25%" class="text">
			<select class="text" title="Modalita applne prorata" name="cboModalitaProrata" onchange="change_cboModalitaProrata();">
				<option class="text" value="">[Seleziona Opzione]</option>
				<%Vector lvct_Map = (Vector)remoteEnt_Map.getMap(intAction);
			    remoteEnt_Map.remove();
			      for(int i=0;i<lvct_Map.size();i++)
			      {
			        DB_Map myelement=new DB_Map();
			        myelement=(DB_Map)lvct_Map.elementAt(i);%>
					<option value="<%=myelement.getCODE_MODAL_APPL()%>"><%=myelement.getDESC_MODAL_APPL()%></option>
				<%}%>
			</select>
		</td>
	</tr>
	<tr>
		<td height="30" width="25%" class="textB">&nbsp;Modalità appl.ne</td>
		<td height="30" width="25%" class="text">
			<select class="text" title="Modalita applne" name="cboModalita" onchange="change_cboModalita();">
				<option class="text" value="X">[Seleziona Opzione]</option>
				<option class="text" value="A">Anticipata</option>
				<option class="text" value="P">Posticipata</option>
			</select>
		</td>
		<td height="30" width="25%" class="textB">&nbsp;Shift canoni</td>
		<td height="30" width="25%"><input type="text" name="txtShiftCanoni" class="text" value = "" size="5" maxlength="2"></td>
	</tr>
	<tr>
	  <td  colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
	</tr>
</table>

<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Validità</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="25%" class="textB">&nbsp;Data Inizio Validità</td>
		<td height="30" width="25%" nowrap><input type="text" name="txtDataInizioValidita" class="text" value="" size="12">&nbsp;
			<a href="javascript:showCalendar('frmDati.txtDataInizioValidita','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>&nbsp;
			<a href="javascript:clearField(objForm.txtDataInizioValidita);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
		</td>
		<td height="30" width="25%" class="textB">&nbsp;Data Fine Validità</td>
		<td height="30" width="25%" nowrap><input type="text" name="txtDataFineValidita" class="text" value="" size="12">&nbsp;
			<a href="javascript:showCalendar('frmDati.txtDataFineValidita','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>&nbsp;
			<a href="javascript:clearField(objForm.txtDataFineValidita);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
		</td>
	</tr>
	<tr>
	  <td colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
	</tr>
</table>

 <!--PULSANTIERA-->
    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
      <tr>
        <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
			<sec:ShowButtons td_class="textB"/>
        </td>
      </tr>
	 
    </table> 
</form>
</BODY>
</HTML>