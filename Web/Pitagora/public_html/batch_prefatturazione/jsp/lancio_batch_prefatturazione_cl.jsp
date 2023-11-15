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
<%=StaticMessages.getMessage(3006,"lancio_batch_prefatturazione_cl.jsp")%>
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
			if(typeof(objForm.chkBatchPref) == 'undefined'){
				Disable(objForm.LANCIOBATCH);
			}else{
				if(typeof(objForm.chkBatchPref.length)== 'undefined'){
					objForm.chkBatchPref.checked=true;
				}else{
					objForm.chkBatchPref[0].checked=true;
				}
				Enable(objForm.LANCIOBATCH);
			}
		}
		
		function ONLANCIOBATCH()
		{
			if(validazioneCampi(objForm))
			{
				objForm.action = "lancio_batch_prefatturazione_2_cl.jsp";
				objForm.submit();
			}
		}
		function change_cboBatchPref(){
			
		}
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_TOOL_PREF_BATCH_PREFATTURAZIONE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Prefatturazione</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td height="30" class="textB">&nbsp;Fasi:</td>
			</tr>
			<tr>
				<td align="center">
					<table width="80%">
							<!-- <tr bgcolor='<%=StaticContext.bgColorHeader%>' class='white' >
								<td>&nbsp;</td>
								<td class="">Descrizione</td>
							</tr> -->
						<%if( vctBatchPref.size() > 0){%>
							<%for(i=0; i < vctBatchPref.size();i++){%>
								<%if ((i%2)==0){
						        	strBgColor=StaticContext.bgColorRigaPariTabella;
						        }else{
						        	strBgColor=StaticContext.bgColorRigaDispariTabella;
								}%>
								<%DB_Batch_Pre objDB_Batch_Pre = (DB_Batch_Pre)vctBatchPref.elementAt(i);%>
								
								<tr>
									<td><input type='radio' name='chkBatchPref' value='<%=objDB_Batch_Pre.getCODE_ANAG_BATCH_PRE()%>'></td>
									<td bgcolor="<%=strBgColor%>" width="99%" class="text"><%=objDB_Batch_Pre.getDESC_ANAG_BATCH_PRE()%></td>
								</tr>
							<%}%>
						<%}else{%>
							<tr>
								<td class="text" bgcolor="<%=StaticContext.bgColorRigaPariTabella%>" align="center">
									Nessun Batch Prefatturazione Disponibile!
								</td>
							</tr>
						<%}%>
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