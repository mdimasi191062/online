<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"canc_proc_emitt_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

    //Dichiarazioni
  I5_2ProcedureEmittenti remote = null;   
    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
//  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
//  sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
  
%>  
<EJB:useHome id="home" type="com.ejbBMP.I5_2ProcedureEmittentiHome" location="I5_2ProcedureEmittenti" />    
<%  
  String CODE_PROC_EMITT = request.getParameter("CODE_PROC_EMITT");      
  remote = home.findByPrimaryKey(CODE_PROC_EMITT);
  remote.remove();
  if (remote.getCasiParticolari().equals(new Integer(0))) 
  {
    response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Alla Procedura Emittente selezionata è associato un importo complessivo. Non è possibile procedere alla sua cancellazione.!",com.utl.StaticContext.ENCCharset));    
  } 
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
</title>
</head>
<body>
  <script language="javascript">
  window.document.location.href="cbn4_lista_proc_emitt_cl.jsp?txtTypeLoad=0<%=sParametri%>";
</script>
</BODY>
</HTML>