<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_associazione.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strQueryString = "";
  String ret =null;
  strQueryString = "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&txtTypeLoad=0"; 

  String CODE_PROF_UTENTE = request.getParameter("CODE_PROF_UTENTE");
  String CODE_FUNZ = request.getParameter("CODE_FUNZ");
  String CODE_OP_ELEM = request.getParameter("CODE_OP_ELEM");  
    //Richiesta Variabili 
  String txtCODE_PROF_UTENTE=request.getParameter("txtCODE_PROF_UTENTE");    
  String txtCODE_FUNZ=request.getParameter("txtCODE_FUNZ");      
  String txtCODE_OP_ELEM=request.getParameter("txtCODE_OP_ELEM");        
  int operazione=Integer.parseInt(request.getParameter("operazione"));          
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_ELHome" location="I5_6MEM_FUNZ_PROF_OP_EL" />  
<EJB:useBean id="associa" type="com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean> 
</HEAD>
<BODY>
<%
  switch (operazione){
  case 0:
     ret = associa.insertAssociazione(CODE_PROF_UTENTE, CODE_FUNZ, CODE_OP_ELEM);
     if(!ret.equals(CODE_PROF_UTENTE))
     {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(ret,com.utl.StaticContext.ENCCharset));
     }   
     break;
  case 1:
     ret = associa.modifyAssociazione(txtCODE_PROF_UTENTE, txtCODE_FUNZ, txtCODE_OP_ELEM,CODE_PROF_UTENTE, CODE_FUNZ, CODE_OP_ELEM);
     if(ret != null)
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(ret,com.utl.StaticContext.ENCCharset));
     break;       
  case 2:  
    associa.removeAssociazione(txtCODE_PROF_UTENTE, txtCODE_FUNZ, txtCODE_OP_ELEM);  
  }
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="lista_associazioni.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>