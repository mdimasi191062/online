<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*" %>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
//  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");


  String CODE_GEST_ORIG = request.getParameter("CODE_GEST_ORIG");
  String CODE_GEST = request.getParameter("CodSel");
  String FLAG_SYS = request.getParameter("FLAG_SYS");
  
                

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_3GEST_TLCejbHome" location="I5_3GEST_TLCejb" />  
<EJB:useBean id="gestori" type="com.ejbSTL.I5_3GEST_TLCejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean></HEAD>
<BODY>
<%
        try
        {
          gestori.associaNuovoGest(CODE_GEST_ORIG,FLAG_SYS,CODE_GEST);
        }  
        catch (Throwable e)
        { // da gestire meglio
            strMessaggioFunz = e.getMessage();
            response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
        }
%>
<SCRIPT LANGUAGE="JavaScript">
  window.location.href="lista_gestori.jsp?<%=strQueryString%>";
</SCRIPT>
</BODY>
</HTML>