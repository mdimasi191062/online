<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.io.*,java.util.*,java.text.*,javax.naming.*,javax.rmi.*,javax.ejb.*,java.sql.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"contr_anno_rival_istat_sp.jsp")%>
</logtag:logData>
<%
// Questa Jsp, che viene chiamata dalla pagina cbn1_ins_rival_istat_sp (Inserimento indice istat)
// controlla che non ci siano elaborazioni batch in corso e che per l'anno relativo al quale
// si sta inserendo l'indice istat, non sia stata gia effettuata la rivalutazione delle 
// tariffe accedendo alla tabella I5_1ISTAT.
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
 //Dichiarazioni
  Vector indiciVector = null;
  int countBatch =0;  
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
  Float  pIndice_Istat =  new Float(request.getParameter("txtIndiceIstat").replace(',','.'));
  String pAnno  = request.getParameter("txtANNO");
  sParametri= sParametri + "&txtIndiceIstat=" +  pIndice_Istat.toString();
  sParametri= sParametri + "&txtANNO=" + pAnno;
    // Con l'oggetto indiciVector controllo che non ci sia nessun record
    // nella tabella I5_1ISTAT con anno di rivalutazione, l'anno che si 
    // sta inserendo.
  indiciVector = remote.ElencoIndici(pAnno); 
    // Con l'oggetto countBatch controllo che non ci sia nessuna
    // elaborazione in corso al momento dell'inserimento,
  countBatch = remote.checkBatch();  
  if (!(indiciVector==null || indiciVector.size()==0)){ 
    sParametri = sParametri + "&sMessaggio=1";
  %>
  <script language="javascript">
    window.document.location.href="cbn1_ins_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";
  </script>
  <%
  }else{ 
    if (!(countBatch==0 )) {
      sParametri = sParametri + "&sMessaggio=2";
  %>
    <script language="javascript">
      window.document.location.href="cbn1_ins_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";
    </script>
  <%
    } else {
      sParametri = sParametri + "&sMessaggio=3";
  %>
    <script language="javascript">
      window.document.location.href="salva_rival_istat_sp.jsp?txtTypeLoad=0<%=sParametri%>";
    </script>
  <%
    }
  } 
  %>
</BODY>
</HTML>