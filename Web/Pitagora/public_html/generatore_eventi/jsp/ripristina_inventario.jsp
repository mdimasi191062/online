<%@ page contentType="text/html;charset=windows-1252"%>
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
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"ripristina_inventario.jsp")%>
</logtag:logData>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">

<title></title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
</head>
<BODY  onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">
<%
  // SCOMMENTARE  String srcIstanzaProd = Misc.nh(request.getParameter("srcIstanzaProd"));
  String srcIstanzaProd = "";
  session.setAttribute("hidTypeLoadProd", "0");
  session.setAttribute("hidTypeLoadCompo", "0");
  session.setAttribute("hidTypeLoadPrestAgg", "0");
  session.setAttribute("hidTypeLoadPP", "0");
  session.setAttribute("hidTypeLoadMP", "0");
  session.setAttribute("hidTypeLoadRPVD", "0");
  session.setAttribute("hidTypeLoadATM", "0");
  session.setAttribute("ableCreaEvento", "0");
  session.setAttribute("elemNonModif","0");
  int operazione = 0;
  if(request.getParameter("operazione") == null)
     operazione = 0;
  else
    operazione = Integer.parseInt(request.getParameter("operazione"));

  srcIstanzaProd = Misc.nh(request.getParameter("srcIstanzaProd"));

%>

  <EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
  <EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
  <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
  </EJB:useBean>
  
<%
String esito = null;
String messaggio = null;
if(operazione == 1){
  esito = remoteEnt_Inventari.getCodeIstanzaProd(srcIstanzaProd);
  if(esito.equals("")){
     messaggio = "Codice Istanza Prodotto presente.";
     response.sendRedirect("vis_storico_code_istanza_prod.jsp?srcIstanzaProd=" + srcIstanzaProd);
  }else{
     messaggio = esito;
  }
}else{
  srcIstanzaProd = "";
  messaggio = "";
}

%>

<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;

  function ONCERCA(){
    if(frmSearch.srcIstanzaProd.value==''){
      alert('Occorre Inserire un Identificativo Di Prodotto.');
      frmSearch.srcIstanzaProd.focus();
      return;
    }
    frmSearch.submit();
  }
</SCRIPT>


  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="../images/GeneratoreEventi.gif" alt="" border="0"></td>
    </tr>
  </table>
  <BR>
  	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">SELEZIONA INVENTARIO PER RIPRISTINO</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="ripristina_inventario.jsp?operazione=1">
<input type="hidden" name="messaggio" value="<%=messaggio%>">
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <br>
  <br>
    <br>
  <br>
    <br>
  <br>
  <br>
  <tr>
  </tr>
  <tr>
  </tr>
    <tr>
      <TD class="text" align="center">
        Codice Istanza Prodotto:
        <INPUT class="text" id="srcIstanzaProd" name="srcIstanzaProd" value='<%=srcIstanzaProd%>' >  
        <input class="textB" type="button" name="cmdCerca" value="Ricerca" onClick="ONCERCA();">
      </td>
    </tr>
    </table>
</form>

<script language="JavaScript">
  if(document.frmSearch.messaggio.value != "") 
    alert("<%=messaggio%>");
 </script>
</body>
</html>