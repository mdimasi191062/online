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
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_cdn_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferteHome" location="Ent_TipiOfferte" />
<EJB:useBean id="remoteEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferte" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiOfferte.create()%>" />
</EJB:useBean>


<%
    int intAction;
	int i = 0;
	Vector vctTipiOfferta = null;
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
  var strCodePs = "";
	var strCodePsCompFatt = "";
	var strCodeClassPs = "";
	var strDescEsPs = "";
	var strCodiciTipiCausali = "";
	var strDescrizioniTipiCausali = "";
	var lstrPageAction = "<%=lstrPageAction%>";
  
	function Initialize() {
  
		objForm = document.frmDati;
		DisableAllControls(objForm);
		Enable(objForm.cmdPs);

	}

	function click_cmdPs() {

		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_x_tipo_contr_cl.jsp";
		strURL+="?nomeCombo=document.frmDati.cboPrestAgg";
		strURL+="&intAction=<%=StaticContext.INSERT%>";
		strURL+="&intFunzionalita=<%=StaticContext.FN_TARIFFA_CDN%>";
		strURL+="&hidCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
		strURL+="&hidDescTipoContratto=<%=request.getParameter("hidDescTipoContratto")%>";
		strURL+="&parMostraCliente=no&parMostraContratto=no";
  		
		openDialog(strURL, 569, 400,handleReturnedValuePsPadre);
    
  }
  
	function handleReturnedValuePsPadre() {

		var field = dialogWin.returnedValue.split("$");
		strCodePs = field[0];
		strCodeClassPs = field[1];
	  strDescEsPs = field[2];
		objForm.txtPs.value = strDescEsPs;

		//gestisco le abilitazioni
		DisableAllControls(objForm);
		Enable(objForm.cmdPs);
		Enable(objForm.cmdPsCompFatt);

		//svuoto i campi
		clearField(objForm.txtPsCompFatt);
		setFirstCboElement(objForm.cboPrestAgg);
		clearField(objForm.txtTipoCausale);
		setFirstCboElement(objForm.cboOggettoFatturazione);
	}
	
	function click_cmdPsCompFatt() {
  
		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_cl.jsp";
		strURL+="?nomeCombo=document.frmDati.cboPrestAgg";
		strURL+="&intAction=<%=StaticContext.INSERT%>";
		strURL+="&intFunzionalita=<%=StaticContext.FN_TARIFFA_PS_FIGLI_CDN%>";
		strURL+="&hidCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
		strURL+="&hidDescTipoContratto=<%=request.getParameter("hidDescTipoContratto")%>";
		strURL+="&parPsPadre=" + strCodePs;
		strURL+="&parMostraCliente=no&parMostraContratto=no";
  		
		openDialog(strURL, 569, 400,handleReturnedValuePsCompFatt);
	}
  
	function handleReturnedValuePsCompFatt() {

		Enable(objForm.cboPrestAgg);
		var field = dialogWin.returnedValue.split("|");
		objForm.txtPsCompFatt.value=field[1];
		strCodePsCompFatt = field[0];

		//gestisco le abilitazioni
		DisableAllControls(objForm);
		Enable(objForm.cmdPs);
		Enable(objForm.cmdPsCompFatt);
		Enable(objForm.cboPrestAgg);

		//svuoto i campi
		setFirstCboElement(objForm.cboPrestAgg);
		clearField(objForm.txtTipoCausale);
		setFirstCboElement(objForm.cboOggettoFatturazione);

	}
	
	function click_cmdTipoCausale() {
    
 		//popup cha carica i tipi causali
		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_Tipo_Causale_cl.jsp";
		strURL+="?intAction=<%=intAction%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
		strURL+="&CodeTipoContratto=<%=lstrCodiceTipoContratto%>";
		strURL+="&CodeCliente=";
		strURL+="&CodeContr="
		strURL+="&CodePs=" + strCodePsCompFatt;
		strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg);
		strURL+="&CodeOggFatt="+getComboValue(objForm.cboOggettoFatturazione).split("$")[0];
			
    openDialog(strURL, 569, 400,handleReturnedValueTipoCausale);

	}
	
	function handleReturnedValueTipoCausale() {
        
    strCodiciTipiCausali = dialogWin.returnedValue;
    strDescrizioniTipiCausali = dialogWin.returnedValue1;

    //Abilito i campi
    DisableAllControls(objForm);
    Enable(objForm.cmdPs);
    Enable(objForm.cboPrestAgg);
    Enable(objForm.cmdTipoCausale);
    Enable(objForm.cboOggettoFatturazione);
    Enable(objForm.cmdPsCompFatt);

    //svuoto i campi
    objForm.txtTipoCausale.value=strDescrizioniTipiCausali;
    Enable(objForm.CONTINUA);
    
	}
	
	function change_cboPrestAgg() {

		if(getComboIndex(objForm.cboPrestAgg)!= 0) {
      
			var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_OggettiFatturazione_cl.jsp";
			strURL+="?intAction=<%=intAction%>";
			strURL+="&intFunzionalita=<%=intFunzionalita%>";
			strURL+="&nomeComboOggFat=objForm.cboOggettoFatturazione";
			strURL+="&CodeTipoContratto=<%=lstrCodiceTipoContratto%>";
			strURL+="&CodeCliente=";
			strURL+="&CodeContr=";
      strURL+="&CodePs=" + strCodePsCompFatt;
			strURL+="&CodePrestAgg=" + getComboValue(objForm.cboPrestAgg);
			strURL+="&CodeClasse=";
      openDialog(strURL, 400, 5,handleReturnedValuePrestAgg);
			Enable(objForm.cboOggettoFatturazione);
      
		} else {
    
			//gestisco le abilitazioni
			DisableAllControls(objForm);
			Enable(objForm.cmdPs);
			Enable(objForm.cmdPsCompFatt);
			Enable(objForm.cboPrestAgg);

			//svuoto i campi
			clearField(objForm.txtTipoCausale);
			setFirstCboElement(objForm.cboOggettoFatturazione);
		}
    
	}
  
	function handleReturnedValuePrestAgg() {
	}
	
	function change_cboOggettoFatturazione() {
  
    clearField(objForm.txtTipoCausale);
		if(getComboIndex(objForm.cboOggettoFatturazione) != 0) {
			Enable(objForm.cmdTipoCausale);
		} else {
			Disable(objForm.cmdTipoCausale);
			Disable(objForm.CONTINUA);
		}
    
	}
  
	function ONCONTINUA() {

		//aggiungo tutti i parametri che servono al viewState

		//codici
		updVS(objForm.hidViewState,"vsCodiciTipiCausali",strCodiciTipiCausali);
		updVS(objForm.hidViewState,"vsCodePs",strCodePs);
		updVS(objForm.hidViewState,"vsCodePsCompFatt",strCodePsCompFatt);
		updVS(objForm.hidViewState,"vsCodePrestAgg",getComboValue(objForm.cboPrestAgg));
		updVS(objForm.hidViewState,"vsCodeOggFatt",getComboValue(objForm.cboOggettoFatturazione).split("$")[0]); // prendo il codeOggFatt
		updVS(objForm.hidViewState,"vsCodeClassOggFatt",getComboValue(objForm.cboOggettoFatturazione).split("$")[1]); // prendo il codeClassOggFatt
		updVS(objForm.hidViewState,"vsCodeClassPs",strCodeClassPs); // prendo il codeClassPs

		//descrizioni
		updVS(objForm.hidViewState,"vsDescTipiCausali",objForm.txtTipoCausale.value);
		updVS(objForm.hidViewState,"vsDescPs",objForm.txtPs.value);
		updVS(objForm.hidViewState,"vsDescPsCompFatt",objForm.txtPsCompFatt.value);
		updVS(objForm.hidViewState,"vsDescPrestAgg",getComboText(objForm.cboPrestAgg));
		updVS(objForm.hidViewState,"vsDescOggFatt",getComboText(objForm.cboOggettoFatturazione));
		
    // MODIFICA DEL 26/04/2004
    /*switch(lstrPageAction)
        {
          case "UPD":
            objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_cdn_2_cl.jsp";
            break;
          case "INS":
            objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_cdn_2_cl.jsp";
            break;
          case "DEL":
            objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_del_tar_x_tipol_contr_cdn_2_cl.jsp";
            break;
        }*/
        
		//abilito tutti i campi per evitare che alcuni fossero disabilitati e non venisse spedito il proprio valore
    
		//imposta l'azione da eseguire
		updVS(objForm.hidViewState,"vsPageAction",lstrPageAction);

    //apre il popup
    // window.open("<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_cdn_2_cl.jsp?hidViewState=" + objForm.hidViewState.value ,"_blank","width=800 height=600 SCROLLBARS=YES");
    var stringa="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_cdn_2_cl.jsp?hidViewState=" + objForm.hidViewState.value ;
    openDialog(stringa, 800, 600, null);
		//EnableAllControls(objForm);
		//objForm.submit();

    //FINE MODIFICA
	}
  
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="hidViewState" size="100" value="vsCodeTipoContratto=<%=lstrCodiceTipoContratto%>|vsDescTipoContratto=<%=lstrDescTipoContratto%>">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=lstrTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO CDN</td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Oggetto di Fatturazione</td>
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
		<input class="text" title="P/S"  type="text" size="60" maxlength="100" name="txtPs" value="">
        <input class="text" title="P/S"  type="button" name="cmdPs" value="..." onClick="click_cmdPs();">	
	</td>
</tr>
<tr>
    <td height="30" width="25%"class="textB" align="right">P/S Componenti&nbsp;&nbsp;<BR>di Fatturazione&nbsp;&nbsp;</td>
    <td height="30" width="75%" colspan="3">
		<input class="text" title="P/S"  type="text" size="60" maxlength="100" name="txtPsCompFatt" value="">
        <input class="text" title="P/S"  type="button" name="cmdPsCompFatt" value="..." onClick="click_cmdPsCompFatt();">	
	</td>
</tr>
<tr>
    <td height="30" width="25%" class="textB" align="right">Prestazione Aggiuntiva&nbsp;&nbsp;</td>
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
    <td height="30" width="25%" class="textB" align="right">Oggetto di Fatturazione&nbsp;&nbsp;</td>
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
	<td height="30" width="25%" class="textB" align="right">Tipo Causale&nbsp;&nbsp;</td>
	<td height="30" width="75%" nowrap>
		 <input class="text" title="Cliente" type="text" maxlength="100" name="txtTipoCausale" value="" size="60">
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
    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
		<sec:ShowButtons td_class="textB"/>
    </td>
  </tr>
</table>
</form>

</BODY>
</HTML>

