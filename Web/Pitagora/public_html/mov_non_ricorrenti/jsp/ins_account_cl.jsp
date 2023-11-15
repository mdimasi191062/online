<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ins_account_cl.jsp")%>
</logtag:logData>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>
</TITLE>
</HEAD>
<BODY>
<% 
DatiAcc[] vettArray = null;
int CodSel = Integer.parseInt(request.getParameter("CodSel"));
vettArray = (DatiAcc[]) session.getAttribute("vettArray");
String CODE_ACCOUNT = vettArray[CodSel].get_codice();
String DESC_ACCOUNT = vettArray[CodSel].get_descrizione();
%>
<script language="JavaScript">

window.opener.document.frmSearch.txtCodeAccount.value="<%=CODE_ACCOUNT%>";
window.opener.document.frmSearch.txtDescAccount.value="<%=DESC_ACCOUNT%>";
window.opener.ControlloSeAbilit();
this.close();


</script>
</BODY>
</HTML>
