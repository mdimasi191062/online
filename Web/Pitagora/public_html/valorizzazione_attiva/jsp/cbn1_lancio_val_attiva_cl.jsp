
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.utl.DataFormat"%>
<%@ page import="com.utl.DB_Fatture"%>

<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_val_attiva_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Fatture" type="com.ejbSTL.Ent_FattureHome" location="Ent_Fatture" />
<EJB:useBean id="remoteEnt_Fatture" type="com.ejbSTL.Ent_Fatture" scope="session">
    <EJB:createBean instance="<%=homeEnt_Fatture.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Contratti" type="com.ejbSTL.Ctr_ContrattiHome" location="Ctr_Contratti" />
<EJB:useBean id="remoteCtr_Contratti" type="com.ejbSTL.Ctr_Contratti" scope="session">
    <EJB:createBean instance="<%=homeCtr_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
int intNumSpace=100;
int intAction;
int i=0;
int intFunzionalita;
boolean blnError = false;
boolean blnOpenDialogFattureProvvisorie = false;
boolean blnOpenDialogFattureDefinitive = false;
String strComboSize = "7";
String lstrCodeAccount="";
String strCicloDiFatturazione = "";
String strSelected = "";
String strDataInizioCiclo = "";
String strDataFineCiclo = "";
String strValoInizioCiclo = "";
String strIstanzaCiclo = "";
String strPageAction = "";
String strViewState = "";
String strLastErrorMessage = "";
Vector vctIstanzaCiclo = null;
GregorianCalendar gcData = null;
Vector vctAccount = null;

//RESET VARIABILE DEGLI STEPS X IL LANCIO BATCH
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));

if(request.getParameter("intAction") == null){
    intAction = StaticContext.LIST;
}else{
    intAction = Integer.parseInt(request.getParameter("intAction"));
}
if(request.getParameter("intFunzionalita") == null){
	intFunzionalita = StaticContext.FN_TARIFFA;
}else{
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
}

String lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
strViewState = Misc.nh(request.getParameter("hidViewState"));
strPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
strCicloDiFatturazione = Misc.nh(request.getParameter("cboCicloDiFatturazione"));
if(!strCicloDiFatturazione.equals("")){
	vctIstanzaCiclo = remoteEnt_Fatture.getMinDateCicliFatrz (intAction,
                               								  lstrCodiceTipoContratto,
                               								  strCicloDiFatturazione);
    strDataInizioCiclo = (String)vctIstanzaCiclo.elementAt(0);
    strValoInizioCiclo = (String)vctIstanzaCiclo.elementAt(1);
    Vector vctAppo = Misc.split(strDataInizioCiclo,"/");
    String strGGInizioCiclo = (String)vctAppo.elementAt(0);
    if(Integer.parseInt(strGGInizioCiclo) != Integer.parseInt(strValoInizioCiclo)){
        //errore
		strLastErrorMessage = "Data inizio ciclo di fatturazione non congruente!!";
		blnError = true;
    }else{
        gcData = DataFormat.setData(strDataInizioCiclo,StaticContext.FORMATO_DATA);
        gcData = DataFormat.rollData(gcData.getTime().getTime(),0,1,-1);
        strDataFineCiclo = DataFormat.convertiData(gcData,StaticContext.FORMATO_DATA);
		strIstanzaCiclo = strDataInizioCiclo + "-" + strDataFineCiclo;
		vctAccount = remoteEnt_Contratti.getAccountValAttiva (intAction,
                                                              lstrCodiceTipoContratto,
                                                              strCicloDiFatturazione,
                         									  strIstanzaCiclo,
                         									  "");
    }
}%>

<%String strLogMessage = "remoteCtr_Contratti.insAccountParamValoriz()";%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
		<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>
<%String strResult = remoteCtr_Contratti.insAccountParamValoriz();
if(strResult.equals(""))
{
	strLogMessage += ": Successo";
}
else
{
	strLogMessage += ": " + strResult;
}
%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
		<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>
<%
//carica la combo dei cicli di fatturazione
Vector vctCicliFatt = remoteEnt_Fatture.getAnagCicliFatrz(intAction);
%>
<html>
<head>
	<title></title>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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
	<SCRIPT LANGUAGE='Javascript'>
		var objForm = null;
		var blnError = <%=blnError%>;
		var blnOpenDialogFattureProvvisorie = <%=blnOpenDialogFattureProvvisorie%>;
		var blnOpenDialogFattureDefinitive = <%=blnOpenDialogFattureDefinitive%>;
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle propriet� di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			setObjProp(objForm.txtDataFinePeriodo,"label=Data Fine Periodo|tipocontrollo=data|obbligatorio=si|disabilitato=si");
			//setObjProp(objForm.txtDataInizioPeriodo,"label=Data Inizio Periodo|tipocontrollo=data|obbligatorio=si|disabilitato=si");
			clearAllSpaces(objForm.slcDatiCliente);
			clearAllSpaces(objForm.slcRiepilogo);
			if(objForm.txtIstanzaCicloDiFatt.value == ""){
				Disable(objForm.cmdCambiaCiclo);
			}else{
				Enable(objForm.cmdCambiaCiclo);
			}
			Disable(objForm.txtIstanzaCicloDiFatt);
			if(blnError){
				alert("<%=strLastErrorMessage%>");
			}
			setButtonStatus();
			DisableLink(document.links[0],objForm.imgCalendar)
			DisableLink(document.links[1],objForm.imgCancel)
			
			/*if(blnOpenDialogFattureProvvisorie){
				//apro la dialog
				  var strURL="cbn_dg_lancio_val_attiva_1_cl.jsp";
		          strURL+="?messaggio=Per i seguenti account esistono fatture provvisorie.<br>E' necessario cancellarle per cambiare ciclo di fatturazione.";
		          strURL+="&strAction=<%=intAction%>";
				  strURL+="&strCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
				  strURL+="&strCicloDiFatturazione=<%=strCicloDiFatturazione%>";
                  strURL+="&strIstanzaCiclo=<%=strIstanzaCiclo%>";
				  strURL+="&strMode=<%=StaticContext.FATTURE_PROVVISORIE%>";
		          openDialog(strURL, 569, 400,handleReturnedFP);
			}*/
			
			/*if(blnOpenDialogFattureDefinitive){
				//apro la dialog
				  var strURL="cbn_dg_lancio_val_attiva_1_cl.jsp";
		          strURL+="?messaggio=Per i seguenti account non � stata congelata la fattura del ciclo di fatturazione corrente.<br>Procedere con il cambio di ciclo";
		          strURL+="&strAction=<%=intAction%>";
				  strURL+="&strCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
				  strURL+="&strCicloDiFatturazione=<%=strCicloDiFatturazione%>";
                  strURL+="&strIstanzaCiclo=<%=strIstanzaCiclo%>";
				  strURL+="&strMode=<%=StaticContext.FATTURE_DEFINITIVE%>";
		          openDialog(strURL, 569, 400,handleReturnedFD);
			}*/
		}
		
		/*function handleReturnedFP(){
				//apro la dialog
				  var strURL="cbn_dg_lancio_val_attiva_1_cl.jsp";
		          strURL+="?messaggio=Per i seguenti account non � stata congelata la fattura del ciclo di fatturazione corrente.<br>Procedere con il cambio di ciclo";
		          strURL+="&strAction=<%=intAction%>";
				  strURL+="&strCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
				  strURL+="&strCicloDiFatturazione=<%=strCicloDiFatturazione%>";
                  strURL+="&strIstanzaCiclo=<%=strIstanzaCiclo%>";
				  strURL+="&strMode=<%=StaticContext.FATTURE_DEFINITIVE%>";
		          openDialog(strURL, 569, 400,handleReturnedFD);
		}*/
		
		function handleReturnedFD(){
			objForm.action = "cbn1_lancio_val_attiva_cl.jsp";
			objForm.submit();
		}
		function ONINSERISCI_SEL()
		{
			if(getComboIndex(objForm.slcDatiCliente) != -1)
			{
					addOption(objForm.slcRiepilogo,getComboText(objForm.slcDatiCliente),getComboValue(objForm.slcDatiCliente))
					DelOptionByIndex(objForm.slcDatiCliente,getComboIndex(objForm.slcDatiCliente));
					setButtonStatus();
					chkData()
			}
			
		}
		
	    function ONINSERISCI_TUTTI()
		{
			var i = 0;
			var intLen = objForm.slcDatiCliente.length;
			if (intLen > 0)
			{
				for (i=0; i < intLen; i++)
				{
					addOption(objForm.slcRiepilogo,getComboTextByIndex(objForm.slcDatiCliente,i),getComboValueByIndex(objForm.slcDatiCliente,i));
				}
				clearAll(objForm.slcDatiCliente);
				setButtonStatus();
				chkData()
			}
		}
		
		function ONELIMINA()
		{
			if(getComboIndex(objForm.slcRiepilogo) != -1)
			{
					addOption(objForm.slcDatiCliente,getComboText(objForm.slcRiepilogo),getComboValue(objForm.slcRiepilogo))
					DelOptionByIndex(objForm.slcRiepilogo,getComboIndex(objForm.slcRiepilogo));
					setButtonStatus();
					chkData();
			}
		}
		
		function ONLANCIOBATCH()
		{
			if(validazioneCampi(objForm))
			{
				if(dateToInt(objForm.txtDataFinePeriodo.value) >= dateToInt('<%=DataFormat.getDate()%>'))
				{
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3017")%>");
					return;
				}
				if(objForm.slcRiepilogo.length == 0){
					alert("Nessun elemento selezionato!!");
					return;
				}
				objForm.action = "cbn1_lancio_val_attiva_2_cl.jsp";
				preparePageFields();
				EnableAllControls(objForm);
				objForm.submit();
			}
		}
		
		function preparePageFields()
		{
			var strAppo = "";
			var i = 0;
			for(i=0;i<objForm.slcRiepilogo.length;i++)
			{
				if(strAppo != ""){
					strAppo +=  "|" + getComboValueByIndex(objForm.slcRiepilogo,i) ;
				}else{
					strAppo += getComboValueByIndex(objForm.slcRiepilogo,i) ;
				}
			}
			objForm.hidViewState.value = strAppo;
		}
		
		function change_cboCicloDiFatturazione(){
			if(getComboValue(objForm.cboCicloDiFatturazione)!=""){
				objForm.action = "cbn1_lancio_val_attiva_cl.jsp";
				objForm.submit();
			}
		}
		function click_cmdCambiaCiclo()
		{
			//apro la dialog
			  var strURL="cbn_dg_lancio_val_attiva_1_cl.jsp";
	          strURL+="?messaggio=Per i seguenti account esistono fatture provvisorie.<br>E' necessario cancellarle per cambiare ciclo di fatturazione.";
	          strURL+="&strAction=<%=intAction%>";
			  strURL+="&strCodiceTipoContratto=<%=lstrCodiceTipoContratto%>";
			  strURL+="&strCicloDiFatturazione=<%=strCicloDiFatturazione%>";
              strURL+="&strIstanzaCiclo=<%=strIstanzaCiclo%>";
			  strURL+="&strMode=";
        openDialog(strURL, 400, 5,handleReturnedFD,'resize');
		}
		
		function setButtonStatus()
		{
			if(getComboCount(objForm.slcDatiCliente) > 0){
				Enable(objForm.INSERISCI_SEL);
				Enable(objForm.INSERISCI_TUTTI);
			}else{
				Disable(objForm.INSERISCI_SEL);
				Disable(objForm.INSERISCI_TUTTI);
			}
			
			if(getComboCount(objForm.slcRiepilogo) > 0){
				Enable(objForm.ELIMINA);
				Enable(objForm.LANCIOBATCH);
			}else{
				Disable(objForm.ELIMINA);
				Disable(objForm.LANCIOBATCH);
			}
		}
		function chkData(){
			if(getComboCount(objForm.slcRiepilogo) > 0){
				EnableLink(document.links[0],objForm.imgCalendar)
				EnableLink(document.links[1],objForm.imgCancel)
			}else{
				DisableLink(document.links[0],objForm.imgCalendar)
				DisableLink(document.links[1],objForm.imgCancel)
			}
		}
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<input type = "hidden" name = "intAction" value="<%=intAction%>">
		<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
		<input type = "hidden" name = "hidViewState" value="">
		<input type = "hidden" name = "codiceTipoContratto" value="<%=lstrCodiceTipoContratto%>">
		<input type = "hidden" name = "hidDescTipoContratto" value="<%=lstrDescTipoContratto%>">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_VALORIZZAZIONEATTIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Valorizzazione Attiva per tipologia di contratto: <%=lstrDescTipoContratto%></td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td width="20%" height="30" class="textB">&nbsp;Ciclo di fatturazione:</td>
				<td width="30%" height="30" class="text" align="left">
					<select name="cboCicloDiFatturazione" class="text" onchange="change_cboCicloDiFatturazione()">
						<option value="">[Seleziona Opzione]</option>
						<%for(i=0; i < vctCicliFatt.size();i++){
							DB_Fatture objDbFatture = (DB_Fatture)vctCicliFatt.elementAt(i);
							if(objDbFatture.getCODE_CICLO_FATRZ().equals(strCicloDiFatturazione)){
								strSelected = "selected";
							}else{
								strSelected = "";
							}
							%>
							<option <%=strSelected%> value="<%=objDbFatture.getCODE_CICLO_FATRZ()%>"><%=objDbFatture.getDESC_CICLO_FATRZ()%></option>
						<%}%>
					</select>
				</td>
				<td width="30%" height="30" class="text" align="left">
					<input type="text" name="txtIstanzaCicloDiFatt" class="text" maxlength="30" value = "<%=strIstanzaCiclo%>" size="30">
				</td>
				<td width="20%" height="30" colaspan="3" class="text" align="center">
					<input class="textB" type="button" name="cmdCambiaCiclo" value="Cambia Ciclo" onClick="click_cmdCambiaCiclo();">
				</td>
			</tr>
			<tr>
				<td colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
			</tr>
		 </table>
		  
		 <!-- tabella CLIENTE -->
		 <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Cliente:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <!--CORPO CLIENTE-->
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="30%">&nbsp;Account</td>
				<td class="text" align="left" width="70%">
					<select name="slcDatiCliente" size="<%=strComboSize%>" style="width: 80%;" class="text">
							
					   <%
					   if(vctAccount != null){
							 for(i=0; i < vctAccount.size();i++){
								DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);
								if(!objDbAccount.getTIPO_FLAG_STATO_CONG().equals("A")){%>
									<option value="<%=objDbAccount.getCODE_ACCOUNT()%>"><%=objDbAccount.getDATA_INIZIO_PERIODO()%> - <%=objDbAccount.getDESC_ACCOUNT()%></option>
							  <%}%>
							<%}%>
					  <%}%>
						<option value="">
							<%
							for (i=0;i<intNumSpace;i++){
								out.print("&nbsp;");
							}
							%>
						</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
			</tr>
		 </table>
		 <!-- tabella RIEPILOGO -->
		 <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <!--CORPO RIEPILOGO-->
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="30%">&nbsp;Account</td>
				<td class="text" align="left" width="70%">
					<select name="slcRiepilogo" size="<%=strComboSize%>" style="width: 80%;"  class="text">
						<%
						if(vctAccount != null){
							 for(i=0; i < vctAccount.size();i++){
								DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);
								if(objDbAccount.getTIPO_FLAG_STATO_CONG().equals("A")){%>
									<option value="<%=objDbAccount.getCODE_ACCOUNT()%>$<%=objDbAccount.getCODE_PARAM()%>"><%=objDbAccount.getDATA_INIZIO_PERIODO()%> - <%=objDbAccount.getDESC_ACCOUNT()%></option>
							  <%}%>
							<%}%>
						<%}%>
						<option value="">
							<%
							for (i=0;i<intNumSpace;i++){
								out.print("&nbsp;");
							}
							%>
						</option>
					</select>
				</td>
			</tr>
			<tr>
				<td height="45" width="100%" colspan="2">
					<table width="100%">
						<tr>
							<td width="25%" class="text" align="right"><!-- Data Inizio Periodo:&nbsp; --></td>
							<td width="25%" nowrap>
								<!-- <input type="text" name="txtDataInizioPeriodo" class="text" maxlength="10" value = "" size="12">&nbsp;
								<a href="javascript:showCalendar('frmDati.txtDataInizioPeriodo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
								<a href="javascript:clearField(frmDati.txtDataInizioPeriodo);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a> -->
							</td> 
							<td width="25%" class="text" align="right">Data Fine Periodo:&nbsp;</td>
							<td width="25%" nowrap>
								<input type="text" name="txtDataFinePeriodo" class="text" maxlength="10" value = "" size="12">&nbsp;
								<a href="javascript:showCalendar('frmDati.txtDataFinePeriodo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
								<a href="javascript:clearField(objForm.txtDataFinePeriodo);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		 	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
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
</body>
</html>