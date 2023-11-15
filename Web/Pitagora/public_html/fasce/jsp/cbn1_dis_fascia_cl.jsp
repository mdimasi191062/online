<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Iterator" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_dis_fascia_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

    //Dichiarazioni
  I5_2FASCIE remote = null;   
    //Codice della fascia che stiamo inserendo/modificando
  String CODE_FASCIA = null;
  Collection collection = null;
  Iterator iterator = null;
  boolean bAssociazioneTariffe=false;
    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
//  if (txtCodRicerca!=null){
//    sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
//  }
   
  CODE_FASCIA = request.getParameter("CODE_FASCIA");
%>  
<EJB:useHome id="home" type="com.ejbBMP.I5_2FASCIEHome" location="I5_2FASCIE" />    
<%  
   // Try to convert it to an instance of I5_2ProcedureEmittentiBean, the home interface for our bean.        
  collection = home.findAllByCodeFascia(CODE_FASCIA);              
  iterator = collection.iterator();
  while (iterator.hasNext())
  {
    remote = (I5_2FASCIE) iterator.next();        
    if (remote.AssociazioneTariffe()!=0){
      bAssociazioneTariffe=true;
      break;
    }
    remote.remove();
  }
  if (bAssociazioneTariffe){
    response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Attenzione! Impossibile cancellare una fascia associata a una o più tariffe attive!",com.utl.StaticContext.ENCCharset));
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
window.document.location.href="cbn1_lista_fascia_cl.jsp?txtTypeLoad=0<%=sParametri%>";
</script>
</BODY>
</HTML>
