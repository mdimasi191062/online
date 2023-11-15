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
<%=StaticMessages.getMessage(3006,"lancio_stor_ndc_fatt_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSapHome" location="Ent_ExportPerSap" />
<EJB:useBean id="remoteEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSap" scope="session">
    <EJB:createBean instance="<%=homeEnt_ExportPerSap.create()%>" />
</EJB:useBean>

<%

//////// inserimento del valore relativo alla radio button selezionata nella pagina precedente


    String codiceTipoContratto = ""; 
	codiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
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
		}
		
		function ONLANCIOBATCH()
		{
			var blnSubmit = true;
			if(validazioneCampi(objForm))
			{
				EnableAllControls(objForm);
				objForm.action = "lancio_stor_ndc_fatt_2_cl.jsp";
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
			var strURL="<%=StaticContext.PH_TOOL_PREF_BATCH_AUTOMATISMO_JSP%>sel_Account_Lancio_cl.jsp";
			strURL+="?Funzionalita=<%=StaticContext.RIBES_STORICIZ_NDC_FATT%>";
			strURL+="&codiceTipoContratto=" + objForm.codiceTipoContratto.value;
			
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
	<input type="Hidden" name="codiceTipoContratto" value="<%=codiceTipoContratto%>">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_STORICIZ_NDC_FATT_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Storicizzazione Ndc e Fatt</td>
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
					<table width="80%" border="0">
						<tr>
							<td class="text" align="right">
								<input type="Radio" name="rdTipoStoricizzazione" value="0" class="text" onclick="" checked>
							</td>
							<td class="text" align="left">
								Fatture
							</td>
						</tr>
						<tr>
							<td class="text" align="right">
								<input type="Radio" name="rdTipoStoricizzazione" value="1" class="text" onclick="">
							</td>
							<td class="text" align="left">
								Note di Credito
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
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