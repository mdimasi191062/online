<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<EJB:useHome id="homeCtr_Catalogo" type="com.ejbSTL.Ctr_CatalogoHome" location="Ctr_Catalogo" />
<EJB:useBean id="remoteCtr_Catalogo" type="com.ejbSTL.Ctr_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeCtr_Catalogo.create()%>" />
</EJB:useBean>

<%
String offerta = Misc.nh(request.getParameter("offerta"));
String strCatalogo = "";
%>
<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
	<TITLE>ELABORAZIONE IN CORSO...</TITLE>
	<script src="../../common/js/calendar.js" type="text/javascript"></script>
  <script src="../../common/js/comboCange.js" type="text/javascript"></script>
  <script src="../../common/js/changeStatus.js" type="text/javascript"></script>
  <script src="../../common/js/validateFunction.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
  
<SCRIPT LANGUAGE='Javascript'>
function SubmitMe()
{
  self.close();
}
</SCRIPT>
</HEAD>

<BODY  onload="window.setTimeout(SubmitMe, 2000)">
<center>
<form name="frmDati" method="post">
	<center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
</center>
</form>
</BODY>
</HTML>


<%  String strLogMessage = "remoteCtr_Catalogo.createTreeCatalogoXml -> INIZIO"; %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
	<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>

<%

if (offerta.equals("")){
  System.out.println("Offerta non selezionata lancio la generazione di tutti gli xml");
  strCatalogo = remoteCtr_Catalogo.createTreeCatalogoXml(); 
}
else
{
  strCatalogo = remoteCtr_Catalogo.createTreeCatalogoXml(offerta); 
}


%>

<%  strLogMessage = "remoteCtr_Catalogo.createTreeCatalogoXml -> FINE"; %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
	<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>

<script language="Javascript">
window.opener.ONSELEZIONA_LANCIO();
</script>