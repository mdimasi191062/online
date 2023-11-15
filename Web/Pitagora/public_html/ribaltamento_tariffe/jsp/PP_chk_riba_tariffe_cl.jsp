<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>CARICAMENTO IN CORSO...</TITLE>
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
</HEAD>
<BODY onblur="self.focus();" onload="window.setTimeout(SubmitMe, 2000);">
<form name="frmDati" method="post">
	<center>
		<font class="red">CHECK TARIFFA IN CORSO...</font><br>
		<img src="<%=StaticContext.PH_CLASSIC_COMMON_IMAGES%>orologio.gif" width="60" height="50" alt="" border="0">
	</center>
</form>
</BODY>
</HTML>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.utl.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"PP_chk_riba_tariffe_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Riba_Tariffe" type="com.ejbSTL.Ctr_Riba_TariffeHome" location="Ctr_Riba_Tariffe" />
<EJB:useBean id="remoteCtr_Riba_Tariffe" type="com.ejbSTL.Ctr_Riba_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Riba_Tariffe.create()%>" />
</EJB:useBean>
<%
  System.out.println(request.getQueryString());
	String str_CodeContrOri  = Misc.nh(request.getParameter("CodeContrOri"));
	String str_CodeContrDest = Misc.nh(request.getParameter("CodeContrDest"));
	String str_CodePS = Misc.nh(request.getParameter("CodePS"));
	String str_CodePrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
	String str_CodeOggFattrz = Misc.nh(request.getParameter("CodeOggFatt"));
	
	String str_ReturnError = remoteCtr_Riba_Tariffe.chkRibaTariffa(str_CodeContrOri, 
								                                   str_CodeContrDest,
								                                   str_CodePS, 
								                                   str_CodePrestAgg, 
								                                   str_CodeOggFattrz );
%>
<SCRIPT LANGUAGE='Javascript'>
function SubmitMe()
{
	if (opener && !opener.closed) 
	{
		opener.dialogWin.returnedValue="<%=str_ReturnError%>";//seleziono il primo valore;
		opener.dialogWin.returnFunc();
	}
	else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
  	self.close();
}
</SCRIPT>