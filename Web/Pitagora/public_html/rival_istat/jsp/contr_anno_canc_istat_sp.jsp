<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.io.*,java.util.*,java.text.*,javax.naming.*,javax.rmi.*,javax.ejb.*,java.sql.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"contr_anno_canc_istat_sp.jsp")%>
</logtag:logData>
<%
// Questa Jsp, che viene chiamata dalla pagina lista_rival_istat_sp 
// controlla che non ci siano elaborazioni batch in corso e l'anno relativo al quale
// si sta inserendo l'indice istat non sia stata gia effettuata la rivalutazione delle 
// tariffe  effettuando  un controllo sulla tabelle I5_2TARIFFA_X_SITO

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

<EJB:useHome id="home" type="com.ejbSTL.ISTATHome" location="ISTAT"/>
<EJB:useBean id="remote" type="com.ejbSTL.ISTAT" scope="request">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<% 
      
  String pAnno  = request.getParameter("txtANNO");
  sParametri= sParametri + "&txtANNO=" + pAnno;       
  // Tramite l'oggetto countFlag viene effettuato un controllo
  // su un flag della tabella I5_2TARIFFA_X_SITO che indica
  // per l' anno relativo al quale  si sta inserendo l'indice istat non 
  // sia stata gia effettuata la rivalutazione delle  tariffe      
  countFlag = remote.checkTipoFlag(pAnno);
  countBatch = remote.checkBatch();
  if (!(countFlag==0 )){ 
    sParametri = sParametri + "&sMessaggio=1";
  %>
    <script language="javascript">
      window.document.location.href="lista_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";  
    </script>
  <%
  }else{ 
    if (!(countBatch==0 )){
      sParametri = sParametri + "&sMessaggio=2";
  %>
    <script language="javascript">
      window.document.location.href="lista_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";       
    </script>
  <%
    } else {
  %>
    <script language="javascript">
      window.document.location.href="cbn1_canc_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";
    </script>
  <%
    }
  } 
  %>
</BODY>
</HTML>