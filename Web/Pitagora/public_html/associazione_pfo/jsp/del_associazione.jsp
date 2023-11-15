<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"del_associazione.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  String strQueryString = request.getQueryString();
  String CODE_PROF_UTENTE = request.getParameter("txtCODE_PROF_UTENTE");
  String CODE_FUNZ = request.getParameter("txtCODE_FUNZ");
  String CODE_OP_ELEM = request.getParameter("txtCODE_OP_ELEM");  
%>
<EJB:useHome id="home" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_ELHome" location="I5_6MEM_FUNZ_PROF_OP_EL" />  
<EJB:useBean id="associa" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean> 
<%
    associa.removeAssociazione(CODE_PROF_UTENTE, CODE_FUNZ, CODE_OP_ELEM);
    response.sendRedirect("lista_associazioni.jsp?" + strQueryString);
%>
