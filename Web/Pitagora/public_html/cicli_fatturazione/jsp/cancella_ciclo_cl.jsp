<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cancella_ciclo_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

    //Dichiarazioni
  String CodiceCiclo = "";
  String strMessaggioFunz = "";

    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
//  sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
  CodiceCiclo = request.getParameter("CodSel");
  sParametri= sParametri + "&CodSel=" + CodiceCiclo;
  
%> 
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
</title>
<EJB:useHome id="home2" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />  
<EJB:useBean id="eur" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=home2.create()%>" />
</EJB:useBean>

<EJB:useHome id="home" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJBHome" location="I5_2ANAG_CICLI_FATRZEJB" />
<EJB:useBean id="ciclo" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJB" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />  
</EJB:useBean>
<%
  if(eur.checkBatch()>0)
  {
        strMessaggioFunz = "Elaborazione Batch in corso. Impossibile continuare!";
        response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));    
  }
  if(ciclo.controlloAccount(CodiceCiclo)==0)
  {
    ciclo.removeCiclo(CodiceCiclo);    
  }
  else
  {
        strMessaggioFunz = "Non è possibile cancellare un ciclo a cui è associato un Account.";
        response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));    
  }

%>

</head>
<body>
  <script language="javascript">
  window.document.location.href="cbn1_lista_cicli_cl.jsp?txtTypeLoad=0<%=sParametri%>";
</script>
</BODY>
</HTML>

