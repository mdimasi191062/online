<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.ejb.*,com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_funz.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz=null;
  int operazione = Integer.parseInt(request.getParameter("strOperazione"));
  
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
//  strQueryString += "&txtCodRicerca=" + request.getParameter("txtCodRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");

  String strAppo=null;
  String pCODE_FUNZ = request.getParameter("txtCodiceFunz");
  String desc_funz = request.getParameter("txtDescFunz");
  String tipo_funz = request.getParameter("Tipo_Funzione");
  String flag_sys = request.getParameter("flag_sys");

  int ret=0;

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">

</HEAD>
<BODY>
<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_FUNZHome" location="I5_6ANAG_FUNZ" />
<EJB:useBean id="funzioni" type="com.ejbSTL.I5_6ANAG_FUNZ" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean> 
<%
  switch (operazione){
  case 0:
    strMessaggioFunz =  funzioni.creaFunz(pCODE_FUNZ,desc_funz,tipo_funz,flag_sys);  
    break;
  case 1:   
    funzioni.updateFunz(pCODE_FUNZ,desc_funz,tipo_funz,flag_sys);
    break;
  case 2:   
    strMessaggioFunz =  funzioni.DeleteFunz(pCODE_FUNZ);  
    break;    
  } 
  if (strMessaggioFunz!=null)
  {
    response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
  }    
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="lista_anag_funz.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>