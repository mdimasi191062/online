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
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"NavigatoreAggiungi.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Catalogo" type="com.ejbSTL.Ctr_CatalogoHome" location="Ctr_Catalogo" />
<EJB:useBean id="remoteCtr_Catalogo" type="com.ejbSTL.Ctr_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeCtr_Catalogo.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<%
  /* PARAMETRI PASSATI */
  String strQueryString = Misc.nh(request.getQueryString());
  session.setAttribute("strQueryString", strQueryString);
  String strNodoSelezionato = Misc.nh(request.getParameter("NodoSelezionato"));
  session.setAttribute("strNodoSelezionato", strNodoSelezionato);
  String strCodeOfferta  = Misc.nh(request.getParameter("Offerta"));
  session.setAttribute("strCodeOfferta", strCodeOfferta);
  String strCodeServizio = Misc.nh(request.getParameter("Servizio"));
  session.setAttribute("strCodeServizio", strCodeServizio);
  String strCodeProdotto = Misc.nh(request.getParameter("Prodotto"));
  session.setAttribute("strCodeProdotto", strCodeProdotto);
  String strCodeComponente = Misc.nh(request.getParameter("Componente"));
  session.setAttribute("strCodeComponente", strCodeComponente); 
  String strCodePrestazione = Misc.nh(request.getParameter("Prestazione"));
  session.setAttribute("strCodePrestazione", strCodePrestazione);
  String strNodo = Misc.nh(request.getParameter("nodo"));
  session.setAttribute("strNodo", strNodo);

  /* URL PARAMETRI COMPLETA */
  String URLParam = "?NodoSelezionato="+ strNodoSelezionato +"&nodo="+strNodo+"&Offerta="+strCodeOfferta+"&Servizio="+strCodeServizio+"&Prodotto="+strCodeProdotto+"&Componente="+strCodeComponente+"&Prestazione="+strCodePrestazione;
  session.setAttribute("URLParam", URLParam);

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
  } else if ( strNodo.equals("COMPONENTI") ) {
           strTitolo    = "Associa Componente";
           strTipo      = "COMPONENTE";
           strPaginaNuovoDaRichiamare = "pre_inserimento_componenti.jsp?navigatore=1";
           strFileXml   =  "../xml_xsl/Prodotto" + strCodeProdotto + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlComponenti(strCodeProdotto);
  } else if ( strNodo.equals("PRODOTTI") ) {
           strTitolo    = "Associa Prodotto";
           strTipo      = "PRODOTTO";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prodotto.jsp?navigatore=1";
           strFileXml   = "../xml_xsl/Off" + strCodeOfferta + "-Serv" + strCodeServizio + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlProdotti(strCodeOfferta,strCodeServizio);
  }
%>

<HTML>
<script src="<%=StaticContext.PH_CATALOGO_JS%>window.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>Skill.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>Albero.js" type="text/javascript"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>Navigatore Catalogo - Aggiungi Elemento - <%=strTitolo%></title>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_EVENTI_JS%>generatoreEventi.js" type="text/javascript"></script>

</head>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  var elementiCheck = '';
  var param = '';
  
  function ONNUOVO () {
    var URL = '<%=strPaginaNuovoDaRichiamare%>';
    objWindows = window.openCentral(URL,'Nuovo','toolbar=0,location=0,directories=0,status=0,menubar=no,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0',900,500);
  }

  function ONSELEZIONA(){
    /* acquisisco i dati dall'iframe dell'albero */
    var tree = Frame1.ONSELEZIONA();

        
    /* acquisisco i dati dall'iframe dei dettagli */    
    var dettagli = Frame3.ONSELEZIONA();

     if(tree){
      if(dettagli){
        if(frmDati.cboModalNoleg.value == '5' && frmDati.dataFineNoleggio.value == ''){
          alert ('\tAttenzione!!!\n\n\nSelezionare Data Fine Noleggio\n');
        }else
          aggiungiElemento();
      }else{
        if(frmDati.cboModalNoleg.value == ''){
          alert ('\tAttenzione!!!\n\n\nSelezionare Modalità Applicazione Noleggio\n');
        }else{
          if(frmDati.cboPreCaratteristica.value == ''){
            alert ('Attenzione!!!\n\n\nSelezionare Caratteristica\n');
          }
        }
      }
    }else{
      alert ('\tAttenzione!!!\n\n\nSelezionare almeno un elemento da associare\n');
    }
  }

  function aggiungiElemento(){
    param = '&Tipo=' + frmDati.Tipo.value + '&PrimoNol=' + frmDati.PrimoNoleggio.value + '&dataFineNoleggio=' + frmDati.dataFineNoleggio.value;
    param = param + '&TempoRinn=' + frmDati.RinnovoNoleggio.value + '&TempoPre=' + frmDati.TempoPreavviso.value;
    param = param + '&SpesaComplessiva=' +frmDati.chkSpesaComplessiva.value + '&Euribor=' + frmDati.chkEuribor.value;
    param = param + '&Flusso=' + frmDati.chkFlusso.value + '&ModalAppl=' + frmDati.cboModalNoleg.value + '&Colocato=' + frmDati.chkColocato.value;
    param = param + '&RepCaratt=' + frmDati.chkReplicaCaratteristiche.value;
    param = param + '&ProdottoRif=' + frmDati.ProdottoRif.value + '&ComponenteRif=' + frmDati.ComponenteRif.value + '&Caratteristica=' + frmDati.cboPreCaratteristica.value;
    opener.frmDati.elemSelezionati.value = frmDati.elementiCheck.value + param;

    opener.frmDati.strServizio.value = '<%=strCodeServizio%>';
    parametri = frmDati.elementiCheck.value + param
    URL_caratteristiche = 'controllaCaratteristiche.jsp?param=ok&'+parametri;
    Frame4.location = URL_caratteristiche;


  }

  function verificaAssenzaAccorpamenti () {
    if(frmDati.assenzaCaratt.value != '' && frmDati.assenzaCaratt.value != null){
      var URL = '';
      URL='pre_inserimento_associaCaratteristiche.jsp?elementi='+frmDati.assenzaCaratt.value;
      URL=URL + '&tipo='+document.frmDati.assenzaCarattTipo.value;
      URL=URL + '&ProdottoRif='+document.frmDati.ProdottoRif.value;
      URL=URL + '&ComponenteRif='+document.frmDati.ComponenteRif.value;
      var retVal = window.showModalDialog( URL, '', 'dialogHeight:750px;dialogWidth:1000px' );
      if( retVal == undefined || retVal.ritorno == null){
        alert('Associazione non disponibile senza caratteristiche');
        return false;
      }else{
        /*alert('retVal.ritorno ['+retVal.ritorno+']');*/
      }
    }
    /* Richiamo aggiornamento dati dell'opener */
    opener.aggiornaDati();
    /* Effettuo la chiusura della finestra */
    window.close();
  }

  

  
</SCRIPT>

<BODY  onLoad="resizeTo(screen.width,screen.height);"  topmargin="0" leftmargin="0" onfocus="ControllaFinestra()" onclick="ControllaFinestra()" >

<FORM name="frmDati" method="post" action="">
    <input type="hidden" name="entitySelezionato" value="">
    <input type="hidden" id="viewStateDati" name="viewStateDati" value="">
<%-- Parametri provenienti dall'iframe dell'albero --%>    
    <input type="hidden" id="elemSelezionati" name="elemSelezionati" value="">
    <input type="hidden" id="elementiCheck" name="elementiCheck" value="">
    <input type="hidden" id="param" name="param" value="">
    <input type="hidden" id="Tipo" name="Tipo" value="">
    <input type="hidden" id="ProdottoRif" name="ProdottoRif" value="">
    <input type="hidden" id="ComponenteRif" name="ComponenteRif" value="">
    <input type="hidden" id="strServizio" name="strServizio" value="">

<%-- Parametri provenienti dall'iframe dei dati di dettaglio --%>
    <input type="hidden" id="cboModalNoleg" name="cboModalNoleg" value="">
    <input type="hidden" id="cboPreCaratteristica" name="cboPreCaratteristica" value="">
    <input type="hidden" id="PrimoNoleggio" name="PrimoNoleggio" value="">
    <input type="hidden" id="RinnovoNoleggio" name="RinnovoNoleggio" value="">
    <input type="hidden" id="TempoPreavviso" name="TempoPreavviso" value="">    
    <input type="hidden" id="chkSpesaComplessiva" name="chkSpesaComplessiva" value="">
    <input type="hidden" id="chkFlusso" name="chkFlusso" value="">
    <input type="hidden" id="chkEuribor" name="chkEuribor" value="">
    <input type="hidden" id="chkColocato" name="chkColocato" value="">
    <input type="hidden" id="chkReplicaCaratteristiche" name="chkReplicaCaratteristiche" value="">    
    <input type="hidden" id="dataFineNoleggio" name="dataFineNoleggio" value="">  
    
<%-- Parametri provenienti dal controllo assenza caratteristiche --%>
    <input type="hidden" id="assenzaCaratt" name="assenzaCaratt" value="">
    <input type="hidden" id="assenzaCarattTipo" name="assenzaCarattTipo" value="">

    <input type="hidden" id="nodo" name="nodo" value="">
    <input type="hidden" name="parametri" value="<%=strQueryString%>">
    
    <iframe src="" frameborder=0 width=0% height=0% scrolling=no name="Frame4"></iframe>

    
<table height="100%" width="100%" cellspacing="0" cellpadding="0" class="Generale" border="0">
  <tr>
    <td>
      <table width="100%" height=100% cellspacing="0" cellpadding="0" align=center border=0>
        <TR height="25">
          <TD>
            <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
              <TR>
                <TD>
                  <%
                  if(strNodo.equals("PRODOTTI") ) {
                  %>
                  <IMG alt="" src="../images/associaProdotti.gif" border="0">
                  <%}else if(strNodo.equals("COMPONENTI") ) {
                  %>
                  <IMG alt="" src="../images/associaComponenti.gif" border="0">
                  <%}else if(strNodo.equals("PRESTAZIONI") ) {
                  %>
                  <IMG alt="" src="../images/associaPrestazioni.gif" border="0">
                  <%}%>
                </TD>
                <TD>
                  <font align="center" class="text" id="elabCorso" name="elabCorso" >ELABORAZIONE IN CORSO...</font><br>
                  <img align="center" id="imgOrologio" name="imgOrologio" src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
                </TD>
              </TR>
            </table>
          </td>
        </tr>
        <tr>
          <td valign="top" height=100%>
            <table border=0 cellspacing=0 cellpadding=0 align=center width=100% height=100%>
              <tr height=100%>
                <td>
                  <iframe src="tree_aggiungi.jsp" frameborder=0 width=100% height=100% scrolling=auto name="Frame1"></iframe>
                </td>
              </tr>
            </table>				
          </td>
        </tr>	
      </table>
    </td>
  </tr>
  <TR height=1%>
    <TD>
      <HR>
    </TD>
  </TR>
  <%-- DETTAGLIO PARAMETRI - INIZIO--%>
  <tr height=38%>
    <td valign="button" >
      <table border=0 cellspacing=0 cellpadding=0 align=center width=100% height=100%>
        <tr height=100%>
          <td>
            <iframe src="parametri_aggiungi.jsp" frameborder=0 width=100% height=100% scrolling=auto name="Frame3"></iframe>
          </td>
        </tr>
      </table>				
    </td>
  </tr>	
  <%-- DETTAGLIO PARAMETRI - FINE--%>  
  
  <tr height=5%>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">
            <sec:ShowButtons td_class="textB"/>
          </td>
        </tr>
      </table>
    </TD>
  </TR>
</table>

</form>
</body>
</HTML>
<script>
	SetDivPos(140);
	SetDivPos2(140);
  nascondi(document.frmDati.imgOrologio);
  document.all('elabCorso').innerText ="";
</script>
