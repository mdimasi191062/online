<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import=",com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_canc_rival_istat_sp.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

    //Dichiarazioni
  int countBatch =0;
  int countFlag =0;
    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
  sParametri = sParametri + "&sMessaggio=3";
  String pAnno  = request.getParameter("txtANNO");
  if (txtCodRicerca!=null){
//    sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
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
<EJB:useHome id="home" type="com.ejbSTL.ISTATHome" location="ISTAT"/>
<EJB:useBean id="remote_ISTAT" type="com.ejbSTL.ISTAT" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  countFlag = remote_ISTAT.checkTipoFlag(pAnno);
  countBatch = remote_ISTAT.checkBatch();
  if(countFlag!=0)
  { 
    response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Esistono Tariffe definitive per l'anno in esame!",com.utl.StaticContext.ENCCharset));
  }
  else
  {
    if (countBatch!=0)
    {
      response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Elaborazione Batch in corso!",com.utl.StaticContext.ENCCharset));
    }
    else
    {
      pAnno  = request.getParameter("txtANNO");
      remote_ISTAT.RemoveTariffaXSito(pAnno);
      remote_ISTAT.RemoveIstat(pAnno);
    }
  }
%> 
  window.document.location.href="lista_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";
</script>
</BODY>
</HTML>
