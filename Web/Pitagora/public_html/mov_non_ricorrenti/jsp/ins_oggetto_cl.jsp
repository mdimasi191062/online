<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ins_oggetto_cl.jsp")%>
</logtag:logData>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>
</TITLE>
</HEAD>
<BODY>
<% 
DatiOgg[] vettArray = null;
int CodSel = Integer.parseInt(request.getParameter("CodSel"));
vettArray = (DatiOgg[]) session.getAttribute("vettArray");
String CODE_OGGETTO = vettArray[CodSel].get_codice();
String DESC_OGGETTO = vettArray[CodSel].get_descrizione();
java.util.Date DATA_VALID = vettArray[CodSel].get_data_inizio();
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
%>
<script language="JavaScript">

window.opener.document.frmSearch.txtCodeOggetto.value="<%=CODE_OGGETTO%>";
window.opener.document.frmSearch.txtDescOggetto.value="<%=DESC_OGGETTO%>";
window.opener.document.frmSearch.txtDataOggetto.value="<%=df.format(DATA_VALID)%>";
this.close();


</script>
</BODY>
</HTML>
