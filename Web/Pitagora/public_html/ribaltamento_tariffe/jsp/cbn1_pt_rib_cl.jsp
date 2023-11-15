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
<%=StaticMessages.getMessage(3006,"cbn1_pt_rib_cl.jsp")%>
</logtag:logData>

<!-- instanziazione degli oggetti remoti-->
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<!-- instanziazione degli oggetti remoti-->
<EJB:useHome id="homeCtr_Riba_Tariffe" type="com.ejbSTL.Ctr_Riba_TariffeHome" location="Ctr_Riba_Tariffe" />
<EJB:useBean id="remoteCtr_Riba_Tariffe" type="com.ejbSTL.Ctr_Riba_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Riba_Tariffe.create()%>" />
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
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
Ribaltamento Parametri Tariffari
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
		setObjProp(objForm.txtClienteOr,"label=Cliente Origine|obbligatorio=si");
		setObjProp(objForm.cboContrattoOr,"label=Contratto Origine|obbligatorio=si");
		setObjProp(objForm.txtClienteDest,"label=Cliente Destinazione|obbligatorio=si");
		setObjProp(objForm.cboContrattoDest,"label=Contratto Destinazione|obbligatorio=si");
		//FINE inizializzazione attributi campi per la validazione
		
		Disable(objForm.txtClienteOr);
		Disable(objForm.cboContrattoOr);
		Disable(objForm.txtPsOr);
		Disable(objForm.cmdPsOr);
		Disable(objForm.cboPrestAggOr);
		Disable(objForm.cboOggFatOr);
		Disable(objForm.txtClienteDest);
		Disable(objForm.cmdClienteDest);
		Disable(objForm.cboContrattoDest);
		Disable(objForm.txtPsDest);
		Disable(objForm.txtPrestAggDest);
		Disable(objForm.txtOggFatDest);
		//reset dei campi del form
		objForm.reset();
		//focus
		setFocus(objForm.cmdClienteOr);
	}
	//GESTIONE EVENTI CAMPI
	//+++++CLIENTE OR++++++
	function click_cmdClienteOr(){
		
		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
		strURL+="?nomeCombo=objForm.cboContrattoOr";
		strURL+="&codiceTipoContratto="+objForm.hidCodeTipologiaContratto.value
		strURL+="&intAction=<%=intAction%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
  		openDialog(strURL, 569, 400, handleReturnedValueClienteOr);
	}
	function handleReturnedValueClienteOr(){
		var strReturnValue = dialogWin.returnedValue.split("|");
		
		
			//salvataggio descrizione cliente
			objForm.txtClienteOr.value = strReturnValue[0];
			//salvataggio codice cliente
			objForm.hidCodeClienteOr.value = strReturnValue[1];
			//abilito la combo cboContrattoOr riempita dal popup
			Enable(objForm.cboContrattoOr);
			objForm.txtClienteDest.value="";
			objForm.hidCodeClienteDest.value="";
			setFirstCboElement(objForm.cboContrattoDest);
			objForm.hidDescContrattoDest.value="";
		//}
		//Disabilito i campi
			Disable(objForm.cmdPsOr);
			Disable(objForm.cboPrestAggOr);
			Disable(objForm.cboOggFatOr);
			Disable(objForm.cmdClienteDest);
			Disable(objForm.cboContrattoDest);
		//svuoto i campi
			objForm.hidDescContrattoOr.value="";
			objForm.hidCodePsOr.value="";
			objForm.txtPsOr.value="";
			setFirstCboElement(objForm.cboPrestAggOr);
			objForm.hidDescPrestAggOr.value="";
			setFirstCboElement(objForm.cboOggFatOr);
			objForm.hidDescOggFatOr.value="";
	}
	//+++++CLIENTE DEST++++++
	function click_cmdClienteDest(){
		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
		strURL+="?nomeCombo=objForm.cboContrattoDest";
		strURL+="&codiceTipoContratto="+objForm.hidCodeTipologiaContratto.value;
		strURL+="&intAction=<%=intAction%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
  		
  		openDialog(strURL, 569, 400, handleReturnedValueClienteDest);
	}
	function handleReturnedValueClienteDest(){
		var strReturnValue = dialogWin.returnedValue.split("|");
		//salvataggio descrizione cliente
		objForm.txtClienteDest.value = strReturnValue[0];
		//salvataggio codice cliente
		objForm.hidCodeClienteDest.value = strReturnValue[1];
		//abilito la combo cboContrattoDest riempita dal popup
		Enable(objForm.cboContrattoDest);
	}
	//+++++CONTRATTO OR++++++
	function change_cboContrattoOr(){
		if(getComboValue(objForm.cboContrattoOr)==""){
			//Disabilito i campi
			Disable(objForm.cmdPsOr);
			Disable(objForm.cboPrestAggOr);
			Disable(objForm.cboOggFatOr);
			Disable(objForm.cmdClienteDest);
			Disable(objForm.cboContrattoDest);
			//svuoto i campi
			objForm.hidDescContrattoOr.value="";
			objForm.hidCodePsOr.value="";
			objForm.txtPsOr.value="";
			setFirstCboElement(objForm.cboPrestAggOr);
			objForm.hidDescPrestAggOr.value="";
			setFirstCboElement(objForm.cboOggFatOr);
			objForm.hidDescOggFatOr.value="";
			objForm.txtClienteDest.value="";
			objForm.hidCodeClienteDest.value="";
			setFirstCboElement(objForm.cboContrattoDest);
			objForm.hidDescContrattoDest.value="";
		}else{
			if(getComboValue(objForm.cboContrattoOr)==getComboValue(objForm.cboContrattoDest)){
				alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"CCB9EU15")%>");
				setFirstCboElement(objForm.cboContrattoOr);
				//Disabilito i campi
				Disable(objForm.cmdPsOr);
				Disable(objForm.cboPrestAggOr);
				Disable(objForm.cboOggFatOr);
				Disable(objForm.cmdClienteDest);
				Disable(objForm.cboContrattoDest);
				//svuoto i campi
				objForm.hidDescContrattoOr.value="";
				objForm.hidCodePsOr.value="";
				objForm.txtPsOr.value="";
				setFirstCboElement(objForm.cboPrestAggOr);
				objForm.hidDescPrestAggOr.value="";
				setFirstCboElement(objForm.cboOggFatOr);
				objForm.hidDescOggFatOr.value="";
				objForm.txtClienteDest.value="";
				objForm.hidCodeClienteDest.value="";
				setFirstCboElement(objForm.cboContrattoDest);
				objForm.hidDescContrattoDest.value="";
			}else{
				//Abilito i campi
				Enable(objForm.cmdPsOr);
				Enable(objForm.cmdClienteDest);
				Disable(objForm.cboPrestAggOr);
				Disable(objForm.cboOggFatOr);
				Disable(objForm.cboContrattoDest);
				//svuoto i campi
				objForm.hidDescContrattoOr.value=getComboText(objForm.cboContrattoOr);
				objForm.hidCodePsOr.value="";
				objForm.txtPsOr.value="";
				setFirstCboElement(objForm.cboPrestAggOr);
				objForm.hidDescPrestAggOr.value="";
				setFirstCboElement(objForm.cboOggFatOr);
				objForm.hidDescOggFatOr.value="";
				objForm.txtClienteDest.value="";
				objForm.hidCodeClienteDest.value="";
				setFirstCboElement(objForm.cboContrattoDest);
				objForm.hidDescContrattoDest.value="";
			}
		}
	}
	//+++++CONTRATTO DEST++++++
	function change_cboContrattoDest(){
		if(getComboValue(objForm.cboContrattoDest)==""){
			objForm.hidDescContrattoDest.value="";
		}else{
			if(getComboValue(objForm.cboContrattoDest)==getComboValue(objForm.cboContrattoOr)){
				alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"CCB9EU15")%>");
				setFirstCboElement(objForm.cboContrattoDest);
				objForm.hidDescContrattoDest.value="";
			}else{
				objForm.hidDescContrattoDest.value=getComboText(objForm.cboContrattoDest);
			}
		}
	}
	//+++++P/S OR++++++++++++++
	function click_cmdPsOr(){
  		var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_cl.jsp";
		strURL+="?funzionalita=Contratto"
		strURL+="&nomeCombo=objForm.cboPrestAggOr";
		strURL+="&intAction=<%=intAction%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
		strURL+="&CodeContr="+getComboValue(objForm.cboContrattoOr);
		strURL+="&Cliente="+objForm.txtClienteOr.value;
		strURL+="&CodeCliente="+objForm.hidCodeClienteOr.value;
		strURL+="&Contratto="+getComboText(objForm.cboContrattoOr);
		strURL+="&hidCodiceTipoContratto=<%=request.getParameter("codiceTipoContratto")%>";
		strURL+="&hidDescTipoContratto=<%=request.getParameter("hidDescTipoContratto")%>";
		strURL+="&parMostraCliente=si";
  		openDialog(strURL, 569, 400,handleReturnedValuePsOr);
  	}
	function handleReturnedValuePsOr(){
		var field = dialogWin.returnedValue.split("|");
  		objForm.hidCodePsOr.value=field[0];
  		objForm.txtPsOr.value=field[1];
		Enable(objForm.cboPrestAggOr);
		//pulisce l'ogg fatt OR
		setFirstCboElement(objForm.cboOggFatOr);
		Disable(objForm.cboOggFatOr);
	}
	function change_cboPrestAggOr(){
		if(getComboValue(objForm.cboPrestAggOr)==""){
			//svuoto
			objForm.hidDescPrestAggOr.value="";
			setFirstCboElement(objForm.cboOggFatOr);
			objForm.hidDescOggFatOr.value="";
			//disabilito
			Disable(objForm.cboOggFatOr);
			Disable(objForm.cboContrattoDest);
		}else{
			//popup cha carica gli oggetti di fatturazione

			var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_OggettiFatturazione_cl.jsp";
			strURL+="?intAction=<%=intAction%>";
			strURL+="&intFunzionalita=<%=intFunzionalita%>";
			strURL+="&nomeComboOggFat=objForm.cboOggFatOr";
			strURL+="&CodeTipoContratto=<%=request.getParameter("codiceTipoContratto")%>";
			strURL+="&CodeCliente="+objForm.hidCodeClienteOr.value;
			strURL+="&CodeContr="+getComboValue(objForm.cboContrattoOr);
		    strURL+="&CodePs="+objForm.hidCodePsOr.value;
			strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAggOr)//.split("$")[0];
			strURL+="&CodeClasse=";
			openDialog(strURL, 400, 5,handleReturnedValuePrestAggOr);
		}
	
	}
	function handleReturnedValuePrestAggOr(){
		//controllo lo stato d'esito assegnato al popup
		if(dialogWin.state=="0"){
			Enable(objForm.cboOggFatOr);
			objForm.hidDescPrestAggOr.value = getComboText(objForm.cboPrestAggOr);
			eval('objForm.cboOggFatOr.options['+dialogWin.returnedValue+'].selected=true');
		}else{
			Enable(objForm.cboOggFatOr);
		}
	}
	function change_cboOggFatOr(){
		if(getComboIndex(objForm.cboOggFatOr)==-1){
			objForm.hidDescOggFatOr.value="";
		}else{
			objForm.hidDescOggFatOr.value=getComboText(objForm.cboOggFatOr);
		}
	}
	//GESTIONE PULSANTI
	function ONCONFERMA()
	{
		if(validazioneCampi(objForm)){
			//popup che fa chkRibaTariffa
			var strURL="<%=StaticContext.PH_RIBALTAMENTOTARIFFE_JSP%>PP_chk_riba_tariffe_cl.jsp";
			strURL+="?CodeContrOri="+getComboValue(objForm.cboContrattoOr);
			strURL+="&CodeContrDest="+getComboValue(objForm.cboContrattoDest);
			strURL+="&CodePS="+objForm.hidCodePsOr.value;
			strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAggOr);
			strURL+="&CodeOggFatt="+objForm.cboOggFatOr.value.split("$")[0];
			openDialog(strURL, 400, 5,handleReturnedValueChkRibaTariffa);
		}
	}
	function handleReturnedValueChkRibaTariffa(){
		if(dialogWin.returnedValue==""){
			//Valorizzazione Campi Destinazione.
			objForm.hidCodePsDest.value=objForm.hidCodePsOr.value;
			objForm.txtPsDest.value=objForm.txtPsOr.value;
			objForm.hidCodePrestAggDest.value=getComboValue(objForm.cboPrestAggOr);
			objForm.txtPrestAggDest.value=objForm.hidDescPrestAggOr.value;
			objForm.hidCodeOggFatDest.value=objForm.cboOggFatOr.value;
			objForm.txtOggFatDest.value=objForm.hidDescOggFatOr.value;
			EnableAllControls(objForm);
			Disable(objForm.CONFERMA);
			objForm.action="<%=StaticContext.PH_RIBALTAMENTOTARIFFE_JSP%>cbn1_dett_rib_cl.jsp";
			objForm.submit();
		}else{
			alert(dialogWin.returnedValue);
		}
	}
	function ONANNULLA()
	{
		objForm.reset();
	}
	
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="intAction" value="<%=intAction%>">
	<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
	<input type="hidden" name="hidCodeTipologiaContratto" value="<%=request.getParameter("codiceTipoContratto")%>">
	<!--CAMPI NASCOSTI CODE PER I TEXT E DESC PER LE COMBO-->
	<!--ORIGINE-->
    <input type="hidden" name="hidCodeClienteOr" value="">
    <input type="hidden" name="hidDescContrattoOr" value="">
	<input type="hidden" name="hidCodePsOr" value="">
	<input type="hidden" name="hidDescPrestAggOr" value="">
    <input type="hidden" name="hidDescOggFatOr" value="">
	<!--DESTINAZIONE-->
	<input type="hidden" name="hidCodeClienteDest" value="">
	<input type="hidden" name="hidDescContrattoDest" value="">
	<input type="hidden" name="hidCodePsDest" value="">
	<input type="hidden" name="hidCodePrestAggDest" value="">
	<input type="hidden" name="hidCodeOggFatDest" value="">
	<!-- Immagine Titolo -->
	<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td align="left"><img src="<%=StaticContext.PH_RIBALTAMENTOTARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
	  <tr>
	</table>
	<!--Tabella superiore per Contratto di Origine-->
    <table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Contratto di Origine: <%=request.getParameter("hidDescTipoContratto")%></td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                        </tr>
                      </table>
                    </td>
                </tr>
            </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
            <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                <tr>
                    <td width='30%' class="textB" align="right">Cliente:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                        <input class="text" title="Cliente" type="text" size="58" maxlength="30" name="txtClienteOr" value="">
                        <input class="text" title="Cliente" type="button" name="cmdClienteOr" value="..." onClick="click_cmdClienteOr();">
                    </td>
				</tr>
				<tr>
                    <td width='30%' class="textB" align="right">Contratto:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                        <select class="text" title="Contratto" name="cboContrattoOr" onchange="change_cboContrattoOr();">
                            <option value="">[Seleziona Opzione]</option>
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
                    <td width='30%' class="textB" align="right">P/S:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                          <input class="text" title="P/S"  type="text" maxlength="30" size="58" name="txtPsOr" value="">
                          <input class="text" title="P/S"  type="button" maxlength="30" name="cmdPsOr" value="..." onClick="click_cmdPsOr();">
                    </td>
				</tr>
				<tr>
                    <td width='30%' class="textB" align="right">Prestazione Aggiuntiva:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                          <select class="text" title="Prestazione Aggiuntiva" name="cboPrestAggOr" onchange="change_cboPrestAggOr();">
                            <option value="">[Seleziona Opzione]</option>
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
                    <td width='30%' class="textB" align="right">Oggetto Fatturazione:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                          <select class="text" title="Ogg.Fatturazione" name="cboOggFatOr" onchange="change_cboOggFatOr();">
                            <option value="">[Seleziona Opzione]</option>
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
            </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">&nbsp;</td>
              </tr>
            </table> 
        </td>
      </tr>
    </table>

    <!--Tabella inferiore per Contratto di Destinazione-->
    <table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>">&nbsp;</td>
      </tr>
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Contratto di Destinazione: <%=request.getParameter("hidDescTipoContratto")%></td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                        </tr>
                      </table>
                    </td>
                </tr>
            </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
            <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                <tr>
                    <td width='30%' class="textB" align="right">Cliente:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                        <input class="text" title="Cliente" size="58" type="text" maxlength="30" name="txtClienteDest" value="">
                        <input class="text" title="Cliente" type="button" name="cmdClienteDest" value="..." onClick="click_cmdClienteDest();">
                    </td>
				</tr>
				<tr>
                    <td width='30%' class="textB" align="right">Contratto:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                        <select class="text" title="Contratto" name="cboContrattoDest" onchange="change_cboContrattoDest();">
                            <option value="">[Seleziona Opzione]</option>
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
                    <td width='30%' class="textB" align="right">P/S:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                          <input type="text" class="text" size="58" title="P/S" maxlength="30" name="txtPsDest" value="">
                    </td>
				</tr>
				<tr>
                    <td width='30%' class="textB" align="right">Prestazione Aggiuntiva:&nbsp;&nbsp;</td>
                    <td width='70%' class="text" nowrap>
                          <input type="text" class="text" title="Prestazione Aggiuntiva" maxlength="30" name="txtPrestAggDest" value="">
                    </td>
                </tr>
                <tr>
                    <td width='15%' class="textB" align="right">Oggetto Fatturazione:&nbsp;&nbsp;</td>
                    <td width='35%' class="text" nowrap>
                          <input type="text" class="text" title="Ogg.Fatturazione" maxlength="30" name="txtOggFatDest" value="">
                    </td>
                </tr>
            </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
    </table>
	
	 <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
       <tr>
         <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
             <sec:ShowButtons td_class="textB"/>
         </td>
       </tr>
     </table> 
</form>

</BODY>
</HTML>