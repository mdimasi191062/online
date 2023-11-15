<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_pwd.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz=null;
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 

  String strChkScadPwd = request.getParameter("ChkScadPwd");  

//  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CODE_UTENTE");
  String CODE_PWD  = "";
  int verificato = 0;
  I5_6anag_utenteROW riga = null;

  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String CODE_UTENTE = aUserInfo.getUserName();
  String CODE_PWD_NEW = request.getParameter("CODE_PWD_NEW");
  String CODE_PWD_OLD = request.getParameter("CODE_PWD_OLD");

  String decodedPasswordFromClient=null;
  String decodedPasswordFromDB=null;

  String strUrl=null;

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_UTENTEejbHome" location="I5_6ANAG_UTENTEejb" />
<EJB:useBean id="utenti" type="com.ejbSTL.I5_6ANAG_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
</HEAD>
<BODY>
<%
  riga = utenti.loadUtente(CODE_UTENTE);
  //CODE_PWD         = riga.getCode_pwd();
  decodedPasswordFromClient=new com.utl.CustomDecode(CODE_PWD_OLD,CODE_UTENTE).decode();
  decodedPasswordFromDB=new com.utl.CustomDecode(CODE_PWD,CODE_UTENTE).decode();   

  //if (CODE_PWD.equals(CODE_PWD_OLD) 
  if(decodedPasswordFromClient.equals(decodedPasswordFromDB.toUpperCase()))
  { 
    verificato=1;
    //riga.setCode_pwd(CODE_PWD_NEW);
    strMessaggioFunz = utenti.updateUtente(riga);
  }  
  if (strMessaggioFunz!=null)
  {
    if ("Y".equals(strChkScadPwd))
      strUrl="messaggio.jsp?caso=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset);
    else
      strUrl="messaggio.jsp?caso=0&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset);
    response.sendRedirect(strUrl);
  }  

  if (verificato==0)
  {
    strMessaggioFunz ="La vecchia password non è corretta!";
    strUrl="messaggio.jsp?caso=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset);

    response.sendRedirect(strUrl);
  }
  else
  {
    strMessaggioFunz ="La modifica della password è andata a buon fine!";
    if ("Y".equals(strChkScadPwd))
      strUrl="messaggio.jsp?caso=2&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset);
    else
      strUrl="messaggio.jsp?caso=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset);
    response.sendRedirect(strUrl);
  }
%> 
</BODY>
</HTML>