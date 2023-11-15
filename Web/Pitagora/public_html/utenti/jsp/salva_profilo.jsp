<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_profilo.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  int operazione = Integer.parseInt(request.getParameter("operazione"));
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
//  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");


  String CODE_PROF_UTENTE = request.getParameter("CODE_PROF_UTENTE");
  String DESC_PROF_UTENTE = request.getParameter("DESC_PROF_UTENTE");

  String error = null;
  int ret=0;

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
 

</HEAD>
<BODY>
<EJB:useHome id="home" type="com.ejbSTL.I5_6PROF_UTENTEejbHome" location="I5_6PROF_UTENTEejb" />
<EJB:useBean id="profili" type="com.ejbSTL.I5_6PROF_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
      if (operazione==2) //cancellazione
      {
        strMessaggioFunz = profili.deleteProfilo(CODE_PROF_UTENTE);
      }
      else if (operazione==1)//aggiornamento
      {
            strMessaggioFunz = profili.updateProfilo(CODE_PROF_UTENTE,DESC_PROF_UTENTE);
      }
      else if (operazione==0)//inserimento
      {
            strMessaggioFunz = profili.creaProfilo(CODE_PROF_UTENTE,DESC_PROF_UTENTE);
      }
      if (strMessaggioFunz!=null)
      {
        response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
      }        
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="lista_profili.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>