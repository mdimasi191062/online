<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ins_classe_cl.jsp")%>
</logtag:logData>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>
</TITLE>
</HEAD>
<BODY>
<% 
DatiClass[] vettArray = null;
int CodSel = Integer.parseInt(request.getParameter("CodSel"));
vettArray = (DatiClass[]) session.getAttribute("vettArray");
String CODE_CLASSE = vettArray[CodSel].get_codice();
String DESC_CLASSE = vettArray[CodSel].get_descrizione();
%>
<script language="JavaScript">

window.opener.document.frmSearch.txtCodeClasse.value="<%=CODE_CLASSE%>";
window.opener.document.frmSearch.txtDescClasse.value="<%=DESC_CLASSE%>";
window.opener.document.frmSearch.txtDescOggetto.value="";
window.opener.document.frmSearch.txtCodeOggetto.value="";
window.opener.ControlloSeAbilit();
this.close();


</script>
</BODY>
</HTML>
