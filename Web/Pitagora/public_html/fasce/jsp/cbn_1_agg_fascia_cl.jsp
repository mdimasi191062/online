<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Iterator" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn_1_agg_fascia_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

    //Dichiarazioni
  I5_2FASCIE remote = null;   
    //Codice della fascia che stiamo inserendo/modificando
  String CODE_FASCIA = null;
  I5_2FASCIEPK PrimaryKey = null;
    //Data Inizio della fascia che stiamo inserendo/modificando
  String txtDataInizio = null;
  String txtDescrizioneIntervallo  = "";
  String txtValoreMinimo = "";      
  String txtValoreMassimo = "";        
      //Numero delle righe presenti su tabella
  int iElementi=0;
  int j=0;
  Collection collection = null;
  Iterator iterator = null;
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
<EJB:useHome id="home" type="com.ejbBMP.I5_2FASCIEHome" location="I5_2FASCIE" />    
<%  
  CODE_FASCIA = request.getParameter("CodiceFascia");
  String strOperazione = null;
  strOperazione = request.getParameter("strOperazione");      
  if (strOperazione.equals("1")){    
     // Try to convert it to an instance of I5_2ProcedureEmittentiBean, the home interface for our bean.        
    collection = home.findAllByCodeFascia(CODE_FASCIA);              
    iterator = collection.iterator();
    while (iterator.hasNext())
    {
      remote = (I5_2FASCIE) iterator.next();
      remote.remove();
    }
  }
  iElementi = Integer.parseInt(request.getParameter("iElementi"));              
  txtDataInizio= request.getParameter("txtDataInizio");      
  for(j=0;j<=iElementi;j++){        
   PrimaryKey = new I5_2FASCIEPK(CODE_FASCIA,Integer.toString(j+1));
   txtDescrizioneIntervallo= request.getParameter("txtDescrizioneIntervallo" + Integer.toString(j));
   txtValoreMinimo =  request.getParameter("txtValoreMinimo" + Integer.toString(j));      
   txtValoreMassimo = request.getParameter("txtValoreMassimo" + Integer.toString(j));             
   remote= home.create(PrimaryKey,txtDataInizio,txtDescrizioneIntervallo,txtValoreMinimo,txtValoreMassimo);
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

  window.opener.document.location.href="cbn1_lista_fascia_cl.jsp?txtTypeLoad=0<%=sParametri%>";
  window.close();

</script>
</BODY>
</HTML>
