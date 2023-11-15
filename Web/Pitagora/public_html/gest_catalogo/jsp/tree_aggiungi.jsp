<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%--<%@ taglib uri="/webapp/sec" prefix="sec" %>--%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Catalogo" type="com.ejbSTL.Ctr_CatalogoHome" location="Ctr_Catalogo" />
<EJB:useBean id="remoteCtr_Catalogo" type="com.ejbSTL.Ctr_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeCtr_Catalogo.create()%>" />
</EJB:useBean>

<%
/* PARAMETRI PASSATI */
  String strQueryString = (String)session.getAttribute("strQueryString");
  String strNodoSelezionato = (String)session.getAttribute("strNodoSelezionato");
  String strCodeOfferta  = (String)session.getAttribute("strCodeOfferta");
  String strCodeServizio = (String)session.getAttribute("strCodeServizio");
  String strCodeProdotto = (String)session.getAttribute("strCodeProdotto");
  String strCodeComponente = (String)session.getAttribute("strCodeComponente"); 
  String strCodePrestazione = (String)session.getAttribute("strCodePrestazione");
  String strNodo = (String)session.getAttribute("strNodo");
%>

<%
  /* determino i parametri per la presentazione della pagina aggiungi elemento */
  String xmlReturn = null;
  String strPaginaNuovoDaRichiamare = null;
  String strFileXml = null;
  String strTitolo = null;
  String strTipo = null;
  String strPercorso = "../xml_xsl/";
  String strXsl = strPercorso + "tree_aggiungi.xsl";
  if ( strNodo.equals("OFFERTE") ) {
           strTitolo    = "Associa Offerte";
           strTipo      = "OFFERTA";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prestazioni.jsp";
           strFileXml   =  "../xml_xsl/Prestazioni" + "P" + strCodeProdotto + "C" + strCodeComponente + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlPrestazioni(strCodeProdotto,strCodeComponente);
  } else  if ( strNodo.equals("SERVIZI") ) {
           strTitolo    = "Associa Servizio";
           strTipo      = "SERVIZIO";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prestazioni.jsp";
           strFileXml   =  "../xml_xsl/Prestazioni" + "P" + strCodeProdotto + "C" + strCodeComponente + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlPrestazioni(strCodeProdotto,strCodeComponente);
  } else  if ( strNodo.equals("PRESTAZIONI") ) {
           strTitolo    = "Associa Prestazione";
           strTipo      = "PRESTAZIONE";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prestazioni.jsp?navigatore=1";
           strFileXml   =  "../xml_xsl/Prestazioni" + "P" + strCodeProdotto + "C" + strCodeComponente + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlPrestazioni(strCodeProdotto,strCodeComponente);
  }
  else if ( strNodo.equals("COMPONENTI") ) {
           strTitolo    = "Associa Componente";
           strTipo      = "COMPONENTE";
           strPaginaNuovoDaRichiamare = "pre_inserimento_componenti.jsp?navigatore=1";
           strFileXml   =  "../xml_xsl/Prodotto" + strCodeProdotto + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlComponenti(strCodeProdotto);
      }  else if ( strNodo.equals("PRODOTTI") ) {
           strTitolo    = "Associa Prodotto";
           strTipo      = "PRODOTTO";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prodotto.jsp?navigatore=1";
           strFileXml   = "../xml_xsl/Off" + strCodeOfferta + "-Serv" + strCodeServizio + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlProdotti(strCodeOfferta,strCodeServizio);
      }
%>

<%
  /* mscatena 19-06-2008 INIZIO */
  /* determino i parametri per la creazione del path di navigazione */
  String strPathNavigazione = "";
  String strDescrizione = "";
  
  if(!strCodeOfferta.equals("")){
    strDescrizione = remoteEnt_Catalogo.getDescOfferta(strCodeOfferta);
    strPathNavigazione += strDescrizione;
  }  
  if(!strCodeServizio.equals("")){
    strDescrizione = remoteEnt_Catalogo.getDescServizio(strCodeServizio);
    strPathNavigazione += " - " + strDescrizione;
  }
  if(!strCodeProdotto.equals("")){
    strDescrizione = remoteEnt_Catalogo.getDescProdotto(strCodeProdotto);
    strPathNavigazione += " - " + strDescrizione;
  }
  if(!strCodeComponente.equals("")){
    strDescrizione = remoteEnt_Catalogo.getDescComponente(strCodeComponente);
    strPathNavigazione += " - " + strDescrizione;
  }
  /* mscatena 19-06-2008 FINE */
%>

<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>tree.css" TYPE="text/css">
<script src="<%=StaticContext.PH_CATALOGO_JS%>tree.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>css.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
</HEAD>

<BODY ONLOAD="initProgetto()" ONSELECTSTART="return false" TOPMARGIN="0" LEFTMARGIN="0">

<form name = "frmDatiTree" method="post" >
  <input type="hidden" name="entitySelezionato" value="">
  <input type="hidden" name="parametri" value="<%=strQueryString%>">
      
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
    <TD colspan=3 class="text"><%=strPathNavigazione%></TD>
  </TR>
  <TR>
    <TD colspan=3>&nbsp;</TD>
  </TR>
  <TR>
    <TD style="border-top: 1px solid black;border-bottom: 1px solid black;"><DIV CLASS="bOut" ONMOUSEOVER="swapClass(this, 'bOver')" ONMOUSEOUT="swapClass(this, 'bOut')" ONCLICK="expandAll(folderTree)">Expand</DIV></TD>
    <TD style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black"><DIV CLASS="bOut" ONMOUSEOVER="swapClass(this, 'bOver')" ONMOUSEOUT="swapClass(this, 'bOut')" ONCLICK="collapse(folderTree)">Minimize</DIV></TD>
    <TD WIDTH="100%">&nbsp;</TD>
  </TR>
</TABLE>

<!-- Folder Tree Container -->
<DIV id="folderTree" name="folderTree" ></DIV>

<form name = "frmDatiTree">
    <input type="hidden" name="entitySelezionato" value="">    
</form>
<SCRIPT LANGUAGE=javascript>
  var objWindows  = null;
  var elementiCheck = '';
  var param = '';
    
  var check = false;

  function ONCHIUDI(){
    window.close();	
  }

  function aggiornaDati() {
    alert ( 'aggiorna dati' );
  }

  function ONSELEZIONA(){
    /* Verifico quali elementi sono stati checkati*/
    elementiCheck = '';
    for(j=0; j<document.forms.length; j++) {
      for(k=0; k<document.forms[j].elements.length; k++) {
        if ( true == document.forms[j].elements[k].checked ) {
          check = true;
          if (( 'chkSpesaComplessiva' != document.forms[j].elements[k].name )
              &&
              ( 'chkEuribor' != document.forms[j].elements[k].name )
              &&
              ( 'chkFlusso' != document.forms[j].elements[k].name )
            ){
            elementiCheck = elementiCheck + document.forms[j].elements[k].name + '|';
          }
        }
      }
    }
    
    /* Creo la stringa dei parametri */
    if(check){
      param = '&Tipo=<%=strTipo%>' + '&ProdottoRif=<%=strCodeProdotto%>' + '&ComponenteRif=<%=strCodeComponente%>';
      parent.frmDati.elementiCheck.value = elementiCheck;
      /*parent.frmDati.param.value = param;*/
      parent.frmDati.Tipo.value = '<%=strTipo%>';
      parent.frmDati.ProdottoRif.value = '<%=strCodeProdotto%>';
      parent.frmDati.ComponenteRif.value = '<%=strCodeComponente%>';
      parent.frmDati.strServizio.value = '<%=strCodeServizio%>';
      return true;      
    }else{
/*      alert ('\tAttenzione!!!\n\n\nSelezionare almeno un elemento\n');*/
      return false;
    }
  }
  
  function initProgetto() {

    var xmlDoc;
    var xslDoc;

    xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
    xmlDoc.async = false;

    xslDoc = new ActiveXObject('Microsoft.XMLDOM');
    xslDoc.async = false;

    xmlDoc.load('<%=strFileXml%>');
    xslDoc.load("<%=strXsl%>");

    folderTree.innerHTML = xmlDoc.documentElement.transformNode(xslDoc);
    /*Initialize ();*/
  }

  function Replace(s)
  {
    alert(s);
    var r;
    alert(r);
    r = s.replace('§','&');
	
  return(r);
  }

  function Initialize() {
    /* pippo pluto */
    var pippo;
	}

</SCRIPT>
</form>
</BODY>
</HTML>