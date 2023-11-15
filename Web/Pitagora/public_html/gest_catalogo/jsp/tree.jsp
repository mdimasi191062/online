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

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>
<%
   DataFormat dataOdierna = new DataFormat();
   String strPercorso = "../xml_xsl/";
   String strVarNameXml = (String) session.getAttribute("strVarNameXml");
   String strXsl = strPercorso + "tree.xsl";
%>

<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>tree.css" TYPE="text/css">
<script src="<%=StaticContext.PH_CATALOGO_JS%>tree.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>css.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
</HEAD>


<BODY ONLOAD="initProgetto()" ONSELECTSTART="return false" TOPMARGIN="0" LEFTMARGIN="0">


<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
    <TD style="border-top: 1px solid black;border-bottom: 1px solid black;"><DIV CLASS="bOut" ONMOUSEOVER="swapClass(this, 'bOver')" ONMOUSEOUT="swapClass(this, 'bOut')" ONCLICK="expandAll(folderTree)">Expand</DIV></TD>
    <TD style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black"><DIV CLASS="bOut" ONMOUSEOVER="swapClass(this, 'bOver')" ONMOUSEOUT="swapClass(this, 'bOut')" ONCLICK="collapse(folderTree); expandTo(folderTree, 4);">Minimize</DIV></TD>
    <TD WIDTH="100%">&nbsp;</TD>
  </TR>
</TABLE>

<!-- Folder Tree Container -->
<DIV id="folderTree" name="folderTree" ></DIV>

<form name = "frmDatiTree">
    <input type="hidden" name="entitySelezionato" value="">
</form>
<SCRIPT LANGUAGE=javascript>
function initProgetto() {
  var xmlDoc
  var xslDoc

  xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
  xmlDoc.async = false;

  xslDoc = new ActiveXObject('Microsoft.XMLDOM');
  xslDoc.async = false;

  xmlDoc.load("<%=strVarNameXml%>");
  xslDoc.load("<%=strXsl%>");

  folderTree.innerHTML = xmlDoc.documentElement.transformNode(xslDoc);

  // mscatena 19-06-2008 inizio
  // Expand dei primi 4 figli dell'albero
  expandTo(folderTree, 4);
  // mscatena 19-06-2008 fine
}

function Replace(s)
{
	alert(s);
	var r;
	alert(r);
	r = s.replace('§','&');
	
return(r);
}
</SCRIPT>
</BODY>
</HTML>