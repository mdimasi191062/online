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
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_itc_cl.jsp")%>
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
<%
    int intAction;
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
	String lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	String lstrPageAction = Misc.nh(request.getParameter("PageAction"));
	String lstrTitoloPagina = "";
	if(lstrPageAction.equals("INS")){
		lstrTitoloPagina = "INSERIMENTO";
	}
	if(lstrPageAction.equals("DEL")){
		lstrTitoloPagina = "ELIMINAZIONE";
	}
	if(lstrPageAction.equals("UPD")){
		lstrTitoloPagina = "MODIFICA";
	}
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	Inserimento Tariffe ITC
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

	function Initialize()
	{
		objForm = document.frmDati;
		//inizializzazione attributi campi per la validazione
		setDefaultProp(objForm);

		setObjProp(objForm.txtPs,"label=Prodotto/Servizio|obbligatorio=si");
		setObjProp(objForm.cboPrestAgg,"label=Prestazione Aggiuntiva|obbligatorio=si");
		setObjProp(objForm.cboOggettoFatturazione,"label=Oggetto di Fatturazione|obbligatorio=si");
		setObjProp(objForm.txtTipoCausale,"label=Tipo Causale|obbligatorio=si");

		DisableAllControls(objForm);
		Enable(objForm.cmdPs);
		//reset dei campi del form
		objForm.reset();
	}

	function click_cmdPs(){
		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_cl.jsp";
		strURL+="?nomeCombo=objForm.cboPrestAgg";
		strURL+="&intAction=<%=StaticContext.INSERT%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
		strURL+="&hidCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
		strURL+="&hidDescTipoContratto=<%=request.getParameter("hidDescTipoContratto")%>";
		strURL+="&parMostraCliente=no&parMostraContratto=no";
  		
		openDialog(strURL, 569, 400,handleReturnedValuePs);
  	}
	function handleReturnedValuePs(){
		var field = dialogWin.returnedValue.split("|");
		objForm.txtPs.value=field[1];
		//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			//svuoto i campi
			updVS(objForm.hidViewState,"vsCodePs",field[0]);
			setFirstCboElement(objForm.cboPrestAgg);
			objForm.txtTipoCausale.value="";
			setFirstCboElement(objForm.cboOggettoFatturazione);
	}

	function change_cboPrestAgg(){
		if(getComboValue(objForm.cboPrestAgg)==""){
			//Abilito i campi
			DisableAllControls(objForm);
			Enable(objForm.cmdPs);
			Enable(objForm.cboPrestAgg);
			//svuoto i campi
			objForm.txtTipoCausale.value="";
			setFirstCboElement(objForm.cboOggettoFatturazione);
		}else{
			var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_OggettiFatturazione_cl.jsp";
			strURL+="?intAction=<%=intAction%>";
			strURL+="&intFunzionalita=<%=intFunzionalita%>";
			strURL+="&nomeComboOggFat=objForm.cboOggettoFatturazione";
			strURL+="&CodeTipoContratto=<%=lstrCodiceTipoContratto%>";
			strURL+="&CodeCliente=";
			strURL+="&CodeContr=";
		    strURL+="&CodePs="+getVS(objForm.hidViewState,"vsCodePs");
			strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg).split("$")[0];
			strURL+="&CodeClasse=";
		    openDialog(strURL, 400, 5,handleReturnedValuePrestAgg);
		}
	}
	function handleReturnedValuePrestAgg(){
		Enable(objForm.cboOggettoFatturazione);
	}

	function change_cboOggettoFatturazione(){
		//Abilito i campi
		DisableAllControls(objForm);
		Enable(objForm.cmdPs);
		Enable(objForm.cboPrestAgg);
		Enable(objForm.cmdTipoCausale);
		Enable(objForm.cboOggettoFatturazione);

		//svuoto i campi
    clearField(objForm.txtTipoCausale);    
	}

	function click_cmdTipoCausale(){
		//popup cha carica i tipi causali
			var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_Tipo_Causale_cl.jsp";
			strURL+="?intAction=<%=intAction%>";
			strURL+="&intFunzionalita=<%=intFunzionalita%>";
			strURL+="&CodeTipoContratto=<%=lstrCodiceTipoContratto%>";
			strURL+="&CodeCliente=";
			strURL+="&CodeContr="
			strURL+="&CodePs="+getVS(objForm.hidViewState,"vsCodePs");
		    strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg);//.split("$")[0];
			strURL+="&CodeOggFatt="+getComboValue(objForm.cboOggettoFatturazione).split("$")[0];
			
		    openDialog(strURL, 569, 400,handleReturnedValueTipoCausale);
	}
	function handleReturnedValueTipoCausale(){
			EnableAllControls(objForm);
			var strCodiciTipiCausali = dialogWin.returnedValue;
			var strDescrizioniTipiCausali = dialogWin.returnedValue1;
			updVS(objForm.hidViewState,"vsCodiciTipiCausali",strCodiciTipiCausali);
			objForm.txtTipoCausale.value=strDescrizioniTipiCausali;
	}

	//GESTIONE PULSANTI
	function ONCONTINUA(){
		if(validazioneCampi(objForm)){
			//objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_itc_2_cl.jsp";
			//aggiorno il campo viewState con i valori dei campi
			//codici
			updVS(objForm.hidViewState,"vsCodePrestAgg",getComboValue(objForm.cboPrestAgg));
			updVS(objForm.hidViewState,"vsCodeOggFatt",getComboValue(objForm.cboOggettoFatturazione).split("$")[0]);
			//descrizioni
			updVS(objForm.hidViewState,"vsDescTipoContratto","<%=lstrDescTipoContratto%>");
			updVS(objForm.hidViewState,"vsDescTipiCausali",objForm.txtTipoCausale.value);
			updVS(objForm.hidViewState,"vsDescPs",objForm.txtPs.value);
			updVS(objForm.hidViewState,"vsDescPrestAgg",getComboText(objForm.cboPrestAgg));
			updVS(objForm.hidViewState,"vsDescOggFatt",getComboText(objForm.cboOggettoFatturazione));
			//imposta l'azione da eseguire
			updVS(objForm.hidViewState,"vsPageAction","<%=lstrPageAction%>");
			/*
      EnableAllControls(objForm);
			objForm.submit();
      */
      openDialog("<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_itc_2_cl.jsp?hidViewState=" + objForm.hidViewState.value,800,600,"");
		}
	}
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="hidViewState" size="100" value="vsCodeTipoContratto=<%=lstrCodiceTipoContratto%>">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=lstrTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO <%=lstrDescTipoContratto.toUpperCase()%></td>
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

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	<td height="30" width='25%' class="textB" align="right">Tipologia Contratto:&nbsp;&nbsp;</td>
	<td height="30" width='75%' class="text">
		<%=request.getParameter("hidDescTipoContratto")%>
	</td>
</tr>
<tr>
    <td height="30" width="25%"class="textB" align="right">Prodotto/Servizio&nbsp;&nbsp;</td>
    <td height="30" width="75%" colspan="3">
		<input class="text" title="P/S"  type="text" size="45" maxlength="100" name="txtPs" value="">
        <input class="text" title="P/S"  type="button" name="cmdPs" value="..." onClick="click_cmdPs();">	
	</td>
</tr>
<tr>
    <td height="30" width="25%" class="textB" align="right">Prestazione Aggiuntiva:&nbsp;&nbsp;</td>
	<td height="30" width="75%">
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
</tr>
<tr>
    <td height="30" width="25%" class="textB" align="right">Oggetto di Fatturazione:&nbsp;&nbsp;</td>
	<td height="30" width="75%">
		<select class="text" title="Oggetto di Fatturazione" name="cboOggettoFatturazione" onchange="change_cboOggettoFatturazione();">
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
	<td height="30" width="25%" class="textB" align="right">Tipo Causale:&nbsp;&nbsp;</td>
	<td height="30" width="75%" nowrap>
		 <input class="text" title="Cliente" type="text" maxlength="100" name="txtTipoCausale" value="" size="45">
         <input class="text" title="Cliente" type="button" name="cmdTipoCausale" value="..." onClick="click_cmdTipoCausale();">
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