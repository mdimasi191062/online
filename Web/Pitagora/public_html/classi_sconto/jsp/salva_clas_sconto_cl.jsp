<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Iterator" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"CONF_DIS_sconto_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

    //Dichiarazioni
 
  I5_2CLAS_SCONTOEJB remote = null;   
  
    //Codice della fascia che stiamo inserendo/modificando
  String code_clas_sconto = null;
  I5_2CLAS_SCONTOPK PrimaryKey = null;
    //Data Inizio della fascia che stiamo inserendo/modificando
  String txtDataInizio = null;
  String txtDescrizioneIntervallo  = "";
  String txtValoreMinimo = "";      
  String txtValoreMassimo = "";
  java.math.BigDecimal ValoreMinimo = null;
  java.math.BigDecimal ValoreMassimo = null;
      //Numero delle righe presenti su tabella
  int iElementi=0;
  int j=0;
  Collection collection = null;
  Iterator iterator = null;
    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtnumPag=request.getParameter("txtnumPag");
  String txtTypeLoad = request.getParameter("txtTypeLoad");
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
  sParametri= sParametri + "&txtnumPag=" + txtnumPag; 
//  if (txtCodRicerca!=null){
//    sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
//  }
  %>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
</title>
</head>
<body>
<EJB:useHome id="home" type="com.ejbBMP.I5_2CLAS_SCONTOEJBHome" location="I5_2CLAS_SCONTOEJB" />
<%
      String Filtro =  request.getParameter("chkClsDisatt");
      code_clas_sconto = request.getParameter("CodiceClsSconto");
     
      String strOperazione = null;
      strOperazione = request.getParameter("strOperazione");      
      if (strOperazione.equals("1")){    
      
          collection = home.findAll(Filtro, code_clas_sconto);
          iterator = collection.iterator();
    	     while (iterator.hasNext())
    	     {
            remote = (I5_2CLAS_SCONTOEJB) iterator.next();
            remote.remove();
           }
      }
      iElementi = Integer.parseInt(request.getParameter("iElementi"));              
      txtDataInizio= request.getParameter("txtDataInizio");      
      for(j=0;j<=iElementi;j++){        
       PrimaryKey = new I5_2CLAS_SCONTOPK(code_clas_sconto, Integer.toString(j+1));
       txtDescrizioneIntervallo= request.getParameter("txtDescrizioneIntervallo" + Integer.toString(j));
       txtValoreMinimo =  request.getParameter("txtValoreMinimo" + Integer.toString(j));      
       txtValoreMassimo = request.getParameter("txtValoreMassimo" + Integer.toString(j));
       ValoreMinimo = null;
       ValoreMassimo = null;
       if (txtValoreMinimo!=null)
       {
          if (!txtValoreMinimo.equals(""))
            ValoreMinimo = new java.math.BigDecimal(txtValoreMinimo.replace(',','.'));
       }
       if (txtValoreMassimo!=null)
       {
          if (!txtValoreMassimo.equals(""))
            ValoreMassimo = new java.math.BigDecimal(txtValoreMassimo.replace(',','.'));
       }
       remote = home.create(PrimaryKey, txtDataInizio,txtDescrizioneIntervallo,ValoreMinimo,ValoreMassimo);
      }
%>


<script language="javascript">

  window.opener.document.location.href="cbn4_lista_clas_scon_cl.jsp?txtTypeLoad=0<%=sParametri%>";
  window.close();

</script>
</BODY>
</HTML>
