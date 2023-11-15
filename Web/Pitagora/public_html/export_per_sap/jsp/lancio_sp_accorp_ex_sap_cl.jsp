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
<%=StaticMessages.getMessage(3006,"lancio_sp_accorp_ex_sap_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSapHome" location="Ent_ExportPerSap" />
<EJB:useBean id="remoteEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSap" scope="session">
    <EJB:createBean instance="<%=homeEnt_ExportPerSap.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<%
int intNumSpace=100;
String strComboSize = "7";
int i=0;
Vector vctClienti = null;
%>
<html>
<head>
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
			clearAllSpaces(objForm.slcDatiCliente);
			clearAllSpaces(objForm.slcRiepilogo);
			setButtonStatus();
		}
		
		function ONINSERISCI_SEL()
		{
			if(getComboIndex(objForm.slcDatiCliente) != -1)
			{
					addOption(objForm.slcRiepilogo,getComboText(objForm.slcDatiCliente),getComboValue(objForm.slcDatiCliente))
					DelOptionByIndex(objForm.slcDatiCliente,getComboIndex(objForm.slcDatiCliente));
					setButtonStatus();
					
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
				
			}
		}
		
		function ONELIMINA()
		{
			if(getComboIndex(objForm.slcRiepilogo) != -1)
			{
					addOption(objForm.slcDatiCliente,getComboText(objForm.slcRiepilogo),getComboValue(objForm.slcRiepilogo))
					DelOptionByIndex(objForm.slcRiepilogo,getComboIndex(objForm.slcRiepilogo));
					setButtonStatus();
					
			}
		}
		
		function ONLANCIOBATCH()
		{
			if(validazioneCampi(objForm))
			{
				if(objForm.slcRiepilogo.length == 0){
					alert("Nessun elemento selezionato!!");
					return;
				}
				
				if(countElem(objForm.slcRiepilogo)==false){
					alert("Si deve scegliere un numero di gestori compreso tra 2 e 6!");
					return;
				}
				objForm.action = "lancio_sp_accorp_ex_sap_2_cl.jsp";
				preparePageFields();
				EnableAllControls(objForm);
				objForm.submit();
			}
		}
		//la funzione conta gli elementi preseni nella Select passata e torna true se il range è compreso tra 2 e 6
		function countElem(objSlc)
		{
		  	if (objSlc.length >= 2 && objSlc.length <= 6){ 
				return true;
			}else{
		  		return false;
		  	}			
		}   
		
		function preparePageFields(){
			var strAppo = "";
			var i = 0;
			for(i=0;i<objForm.slcRiepilogo.length;i++)
			{
				if(strAppo != ""){
					strAppo +=  "|" + getComboValueByIndex(objForm.slcRiepilogo,i) + "$" + getComboTextByIndex(objForm.slcRiepilogo,i);
				}else{
					strAppo += getComboValueByIndex(objForm.slcRiepilogo,i) + "$" + getComboTextByIndex(objForm.slcRiepilogo,i);
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
		
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
	<input type="Hidden" name="hidViewState" value="">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_EXPORT_PER_SAP_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio SP Accorpamento</td>
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
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Gestori:</td>
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
			</tr>
			<tr>
				<td class="text" align="center" width="70%">
					<select name="slcDatiCliente" size="<%=strComboSize%>" style="width: 80%;" class="text">
							
					   <%vctClienti = remoteEnt_ExportPerSap.getClientiValidiSap();
						 for(i=0; i < vctClienti.size();i++){
							DB_Clienti objDBClienti = (DB_Clienti)vctClienti.elementAt(i);%>
							<option value="<%=objDBClienti.getCODE_GEST()%>"><%=objDBClienti.getNOME_RAG_SOC_GEST()%></option>
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
			</tr>
			<tr>
				<td class="text" align="center" width="70%">
					<select name="slcRiepilogo" size="<%=strComboSize%>" style="width: 80%;" class="text" >
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