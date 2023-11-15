<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_rival_istat_sp.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    //Dichiarazioni
   //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");    
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
  sParametri = sParametri + "&sMessaggio=3";
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
  Vector indiciVector = null;
  int countBatch =0;  
  String pAnno  = request.getParameter("txtANNO");


    // Con l'oggetto indiciVector controllo che non ci sia nessun record
    // nella tabella I5_1ISTAT con anno di rivalutazione, l'anno che si 
    // sta inserendo.
  indiciVector = remote_ISTAT.ElencoIndici(pAnno); 
  if(!(indiciVector==null || indiciVector.size()==0))
  {
     response.sendRedirect("messaggio.jsp?a=1&messaggio=" + java.net.URLEncoder.encode("Per l'anno in esame è stata già effettuata la rivalutazione delle tariffe!",com.utl.StaticContext.ENCCharset));
  }
  else
  {
      // Con l'oggetto countBatch controllo che non ci sia nessuna
      // elaborazione in corso al momento dell'inserimento,
    countBatch = remote_ISTAT.checkBatch();  
    if(countBatch!=0 ) 
    {
       response.sendRedirect("messaggio.jsp?a=1&messaggio=" + java.net.URLEncoder.encode("Elaborazione Batch in corso!",com.utl.StaticContext.ENCCharset));
    }
    else
    {

      Float  pIndice_Istat =  new Float(request.getParameter("txtIndiceIstat").replace(',','.'));
  
      clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);  
      String pCode_Utente = aUserInfo.getUserName(); 
      String strOperazione = null;
      strOperazione = request.getParameter("strOperazione");       
      remote_ISTAT.AggTariffePerSito(pAnno, pIndice_Istat, pCode_Utente);
      remote_ISTAT.InsTabellaIstat(pAnno, pIndice_Istat);
    }
  }
%>
window.opener.document.location.href="lista_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";
window.close();
</script>
</BODY>
</HTML>
