<!-- import delle librerie necessarie -->
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
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_ndc_cl.jsp")%>
</logtag:logData>

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
String strComboSize = "7";
int intAction;
int i=0;
int intFunzionalita;
String lstrCodeAccount="";
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
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));

String lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
Vector vctAccount = null;
%>
<html>
<head>
	<title>Lancio Batch Note di Credito</title>
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
		function initialize()
				{
			objForm = document.frmDati;
			//impostazione delle proprietà di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			setObjProp(objForm.txtDataFinePeriodo,"label=Data Fine Periodo|tipocontrollo=data|obbligatorio=si|disabilitato=si");
			clearAllSpaces(objForm.slcDatiCliente);
			clearAllSpaces(objForm.slcRiepilogo);
			setButtonStatus();
			DisableLink(document.links[0],objForm.imgCalendar)
			DisableLink(document.links[1],objForm.imgCancel)
		}
		
		function ONINSERISCI_SEL()
		{
			if(getComboIndex(objForm.slcDatiCliente) != -1)
			{
					addOption(objForm.slcRiepilogo,getComboText(objForm.slcDatiCliente),getComboValue(objForm.slcDatiCliente))
					DelOptionByIndex(objForm.slcDatiCliente,getComboIndex(objForm.slcDatiCliente));
					setButtonStatus();
					chkData();
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
				chkData();
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
				objForm.action = "cbn1_lancio_ndc_2_cl.jsp";
				preparePageFields();
				DisableAllControls(objForm);

        objForm.hidDataFinePeriodo.value=objForm.txtDataFinePeriodo.value;
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
	<form name="frmDati" method="POST" action="">
		<input type = "hidden" name = "intAction" value="<%=intAction%>">
		<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
		<input type = "hidden" name = "hidViewState" value="">
		<input type = "hidden" name = "codiceTipoContratto" value="<%=lstrCodiceTipoContratto%>">
		<input type = "hidden" name = "hidDescTipoContratto" value="<%=lstrDescTipoContratto%>">
		<input type = "hidden" name = "hidDataFinePeriodo" value="">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td align="left"><img src="<%=StaticContext.PH_NOTEDICREDITO_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
			<tr>
		</table>
			<!-- tabella intestazione -->
			<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
						<td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Note di Credito per tipologia di contratto: <%=lstrDescTipoContratto%></td>
						<td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
					</table>
				</td>
			</tr>
			 </table>
		 <br>
		 <!-- tabella CLIENTE -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
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
		 <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="30%">&nbsp;Account</td>
				<td class="text" align="left" width="70%">
					<select name="slcDatiCliente" size="<%=strComboSize%>" style="width: 80%;" class="text">
							
						 <%
              if (lstrCodiceTipoContratto.equalsIgnoreCase("6")) {
                vctAccount = remoteEnt_Contratti.getAccountNDC (intAction,
																																lstrCodiceTipoContratto,
																																StaticContext.RIBES_INFR_BATCH_VAL_ATTIVA_AQ,    //FC 10.12.2003
																																StaticContext.RIBES_INFR_BATCH_NOTE_CREDITO_AQ); //FC 10.12.2003
              } else {
                vctAccount = remoteEnt_Contratti.getAccountNDC (intAction,
									 																						 lstrCodiceTipoContratto,
																															 StaticContext.RIBES_INFR_BATCH_VAL_ATTIVA,    //FC 10.12.2003
																															 StaticContext.RIBES_INFR_BATCH_NOTE_CREDITO); //FC 10.12.2003
              }
						 for(i=0; i < vctAccount.size();i++){
							DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);%>
							<option value="<%=objDbAccount.getCODE_ACCOUNT()%>$"><%//=objDbAccount.getDATA_INIZIO_PERIODO()%><%=objDbAccount.getDESC_ACCOUNT()%></option>
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
		 </table>
		 
		 <!-- tabella RIEPILOGO -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
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
		 <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="30%">&nbsp;Account</td>
				<td class="text" align="left" width="70%">
					<select name="slcRiepilogo" size="<%=strComboSize%>" style="width: 80%;" class="text" >
						<%vctAccount = remoteEnt_Contratti.getAccountAnomali(intAction,
																																						 lstrCodiceTipoContratto,
																																						 lstrCodeAccount,
																																						 StaticContext.RIBES_INFR_BATCH_NOTE_CREDITO);
						 for(i=0; i < vctAccount.size();i++){
							DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);%>
							<option value="<%=objDbAccount.getCODE_ACCOUNT()%>$<%=objDbAccount.getCODE_PARAM()%>"><%=objDbAccount.getDESC_ACCOUNT()%></option>
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
				<td class="textB" width="30%" height="35" align="right">&nbsp;</td>
				<td class="text" align="center" height="35" width="70%" nowrap>
					&nbsp;Data Fine Periodo:
					<input type="text" name="txtDataFinePeriodo" class="text" maxlength="10" value = "" size="12">&nbsp;
					<a href="javascript:showCalendar('frmDati.txtDataFinePeriodo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
					<a href="javascript:clearField(objForm.txtDataFinePeriodo);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
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