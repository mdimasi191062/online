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
<%@ page import="com.usr.*"%>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lancio_sp_accorp_ex_sap_3_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Batch" type="com.ejbSTL.Ctr_BatchHome" location="Ctr_Batch" />
<EJB:useBean id="remoteCtr_Batch" type="com.ejbSTL.Ctr_Batch" scope="session">
    <EJB:createBean instance="<%=homeCtr_Batch.create()%>" />
</EJB:useBean>

<%	String strCodeGestPrior = Misc.nh(request.getParameter("rdGestori"));
	String strGestori = Misc.nh(request.getParameter("hidViewState"));

	String lstr_Messagge = "";
	String strLogMessage = "";
	//String strParameterToLog = "";
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	String strCodeUtente = objInfoUser.getUserName();%>
	<% 	strLogMessage = "remoteCtr_Batch.LancioSpaAccorpamento(strCodeGestPrior : "+strCodeGestPrior+";strGestori : "+strGestori+";strCodeUtente : "+strCodeUtente+")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3501,strLogMessage)%>
	</logtag:logData>
	<%
	lstr_Messagge = remoteCtr_Batch.LancioSpaAccorpamento(strCodeGestPrior,
														                            strGestori,
	                                                       strCodeUtente);
	strLogMessage += " : " + lstr_Messagge ;
	
	%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3501,strLogMessage)%>
	</logtag:logData>
	

<HTML>
<HEAD>
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
	<script language="JavaScript">
		var objForm = null;
		
		function initialize()
		{
			objForm = document.frmDati;
		}
		
	</script>
</HEAD>
<BODY onload="initialize()">
	<form name="frmDati" action="" method="post">
	
	</form>
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_EXPORT_PER_SAP_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lancio Batch Accorpamento per Sap</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<center>
	<h1 class="textB">
		<%=lstr_Messagge%>
	</h1>
	
</center>
</BODY>
</HTML>
