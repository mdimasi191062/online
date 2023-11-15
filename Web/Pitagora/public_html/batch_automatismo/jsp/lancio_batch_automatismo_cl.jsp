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
<%=StaticMessages.getMessage(3006,"lancio_batch_automatismo_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Batch_PRE" type="com.ejbSTL.Ent_Batch_PREHome" location="Ent_Batch_PRE" />
<EJB:useBean id="remoteEnt_Batch_PRE" type="com.ejbSTL.Ent_Batch_PRE" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch_PRE.create()%>" />
</EJB:useBean>
<%
int i = 0;
String strBgColor = "";
Vector vctBatchPref = new Vector();
vctBatchPref = (Vector)remoteEnt_Batch_PRE.getAnagBatchPre ();
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
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle proprietà di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			setObjProp(objForm.txtData,"label=Data|tipocontrollo=data|obbligatorio=si|disabilitato=si");			
		}
		
		function ONLANCIOBATCH()
		{
			var blnSubmit = true;
			if(validazioneCampi(objForm))
			{
				objForm.action = "lancio_batch_automatismo_2_cl.jsp?txtData=" + objForm.txtData.value + "&txtCodeAccount=" + objForm.txtCodeAccount.value;
						
				if(objForm.txtCodeAccount.value == ""){
					blnSubmit = window.confirm("Il Batch verrà lanciato per tutti gli Account.\nConfermi l'operazione?");
				}
				if(blnSubmit){
					objForm.submit();
				}
			}
			
		}
		function onClick_cmdAccount()
		{
			var strURL="sel_Account_Lancio_cl.jsp";
			strURL+="?Funzionalita=<%=StaticContext.RIBES_TOOL_AUTOMATISMO%>";
			
			openDialog(strURL, 600, 400,handleReturned);
	  	}
		function handleReturned(){
			if(dialogWin.state=="ANNULLA"){
				objForm.txtCodeAccount.value="";
				objForm.txtDescAccount.value="";
			}else{
				var field = "";
				if(dialogWin.returnedValue!=undefined){
					field = dialogWin.returnedValue.split("|");
					strCodeAccount = field[0];
					strDescAccount = field[1];
				}else{
					strCodeAccount = "";
					strDescAccount = "";
				}
				objForm.txtCodeAccount.value = strCodeAccount;
				objForm.txtDescAccount.value = strDescAccount;
			}
		}
	
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_TOOL_PREF_BATCH_AUTOMATISMO_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Automatismo OF-PS</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td height="30" class="textB">&nbsp;</td>
			</tr>
			<tr>
				<td align="center">
					<table width="80%">
							<tr>
								<td class="textB" align="right">Data Inizio Validità OF-PS:</td>
								<td>
									<input type='text' name='txtData' value=''>
									<a href="javascript:showCalendar('frmDati.txtData','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
									<a href="javascript:clearField(objForm.txtData);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
								</td>
							</tr>
							<tr>
								<td class="textB" align="right">Account:</td>
								<td>
									<input type='hidden' name='txtCodeAccount' value='' readonly="">
									<input type='text' class="text" name='txtDescAccount' value='' readonly="">
									<input class="textB" type="button" name="cmdAccount" value="Scelta Account" onClick="onClick_cmdAccount();">
									<a href="javascript:clearField(objForm.txtCodeAccount);clearField(objForm.txtDescAccount)" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
								</td>
							</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td colspan="2" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
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