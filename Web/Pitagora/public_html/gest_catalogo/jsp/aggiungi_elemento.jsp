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
<%=StaticMessages.getMessage(3006,"aggiungi_elemento.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Catalogo" type="com.ejbSTL.Ctr_CatalogoHome" location="Ctr_Catalogo" />
<EJB:useBean id="remoteCtr_Catalogo" type="com.ejbSTL.Ctr_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeCtr_Catalogo.create()%>" />
</EJB:useBean>

<%
  String strQueryString = request.getQueryString();
  String strNodoSelezionato = Misc.nh(request.getParameter("NodoSelezionato"));
  String strCodeOfferta  = Misc.nh(request.getParameter("Offerta"));
  String strCodeServizio = Misc.nh(request.getParameter("Servizio"));
  String strCodeProdotto = Misc.nh(request.getParameter("Prodotto"));
  String strCodeComponente = Misc.nh(request.getParameter("Componente"));
  String strCodePrestazione = Misc.nh(request.getParameter("Prestazione"));
  String strNodo = Misc.nh(request.getParameter("nodo"));

  String xmlReturn = null;
  String strPaginaNuovoDaRichiamare = null;
  String strFileXml = null;
  String strTitolo = null;
  String strTipo = null;
  String strPercorso = "../xml_xsl/";
  String strXsl = strPercorso + "tree_aggiungi.xsl";
//  if ( !strCodeOfferta.equals("") )
//    if ( !strCodeServizio.equals("") )
//      if ( !strCodeProdotto.equals("") ) {
//        if ( !strCodePrestazione.equals("") ) {

  if ( strNodo.equals("OFFERTE") ) {
           strTitolo    = "Associa Offerte";
           strTipo      = "OFFERTA";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prestazioni.jsp";
           strFileXml   =  "../xml_xsl/Prestazioni" + "P" + strCodeProdotto + "C" + strCodeComponente + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlPrestazioni(strCodeProdotto,strCodeComponente);
//        }
//        else {
  } else  if ( strNodo.equals("SERVIZI") ) {
           strTitolo    = "Associa Servizio";
           strTipo      = "SERVIZIO";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prestazioni.jsp";
           strFileXml   =  "../xml_xsl/Prestazioni" + "P" + strCodeProdotto + "C" + strCodeComponente + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlPrestazioni(strCodeProdotto,strCodeComponente);
//        }
//        else {
  } else  if ( strNodo.equals("PRESTAZIONI") ) {
           strTitolo    = "Associa Prestazione";
           strTipo      = "PRESTAZIONE";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prestazioni.jsp?navigatore=1";
           strFileXml   =  "../xml_xsl/Prestazioni" + "P" + strCodeProdotto + "C" + strCodeComponente + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlPrestazioni(strCodeProdotto,strCodeComponente);
//        }
//        else {
  }
  else if ( strNodo.equals("COMPONENTI") ) {
           strTitolo    = "Associa Componente";
           strTipo      = "COMPONENTE";
           strPaginaNuovoDaRichiamare = "pre_inserimento_componenti.jsp?navigatore=1";
           strFileXml   =  "../xml_xsl/Prodotto" + strCodeProdotto + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlComponenti(strCodeProdotto);
//        }
//      }
//      else {
      }  else if ( strNodo.equals("PRODOTTI") ) {
           strTitolo    = "Associa Prodotto";
           strTipo      = "PRODOTTO";
           strPaginaNuovoDaRichiamare = "pre_inserimento_prodotto.jsp?navigatore=1";
           strFileXml   = "../xml_xsl/Off" + strCodeOfferta + "-Serv" + strCodeServizio + "tree.xml";
           xmlReturn    = remoteCtr_Catalogo.createTreeCatalogoXmlProdotti(strCodeOfferta,strCodeServizio);
//      }
      }
%>


<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>tree.css" TYPE="text/css">
<script src="<%=StaticContext.PH_CATALOGO_JS%>tree.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>css.js" type="text/javascript"></script>
<title><%=strTitolo%></title>
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
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
</HEAD>

<BODY ONLOAD="resizeTo(screen.width,screen.height);initProgetto()" ONSELECTSTART="return false" TOPMARGIN="0" LEFTMARGIN="0" onfocus="ControllaFinestra()">

<form name = "frmDatiTree" method="post" >
      <input type="hidden" name="entitySelezionato" value="">
      <input type="hidden" name="parametri" value="<%=strQueryString%>">
<TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0"height="100%">
<TR>
  <TD>


<!-- Folder Tree Container -->
<tr>
  <td>
    <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR>
        <TD style="border-top: 1px solid black;border-bottom: 1px solid black;"><DIV CLASS="bOut" ONMOUSEOVER="swapClass(this, 'bOver')" ONMOUSEOUT="swapClass(this, 'bOut')" ONCLICK="expandAll(folderTree)">Expand</DIV></TD>
        <TD style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black"><DIV CLASS="bOut" ONMOUSEOVER="swapClass(this, 'bOver')" ONMOUSEOUT="swapClass(this, 'bOut')" ONCLICK="collapse(folderTree)">Minimize</DIV></TD>
        <TD WIDTH="100%">&nbsp;</TD>
        <TD> <font align="center" class="text" id="elabCorso" name="elabCorso" >ELABORAZIONE IN CORSO...</font> </TD>
        <TD> <img align="center" id="imgOrologio" name="imgOrologio" src="../../common/images/body/orologio.gif" width="40" height="30" alt="" border="0"> </TD>
        <TD WIDTH="100%">&nbsp;</TD>
        <td class="text">Modalità Applicazione Noleggio&nbsp;&nbsp; <br>
          <select class="text" title="Noleggio" name="cboModalNoleg" onchange="change_cboModalNoleg();" >
          <option class="text"  value="">[Seleziona Modalità Applicazione Noleggio]</option>
          </select>
        </td>
      </TR>
    </TABLE>
  </td>
</tr>
<tr>
  <td>
    <TABLE width="100%" height="100%" border="1" cellspacing="2" cellpadding="2" rules="cols" frame="vsides" bordercolor="#0A6B98">
      <TR>
        <!--Frame sinistro-->
        <TD width="85%" valign="top">
          <DIV id="folderTree" ></DIV>
        </TD><!--Frame destro-->
        <TD valign="top">
        <!--DIV!-->
          <TABLE ALIGN=center BORDER=10 CELLPADDING=5 CELLSPACING=5 WIDTH=20 HEIGHT=9>
              <tr>
                  <TD class="text"> 
                   <font id="DescPrimoNoleggio" name="DescPrimoNoleggio"> Tempo<br>Primo Noleggio (mm): </font>
                    <INPUT class="text" style="text-align:right;" id="PrimoNoleggio" name="PrimoNoleggio"  obbligatorio="si" tipocontrollo="intero" label="Primo Noleggio" Update="false" size="10" maxlength=3  value="">
                  </TD>
              </tr>
              <tr>
                 <TD class="text" > 
                 <font id="DescRinnovoNoleggio" name="DescRinnovoNoleggio" > Tempo Rinnovo Noleggio (mm):  </font>
                    <INPUT class="text" style="text-align:right;" id="RinnovoNoleggio" name="RinnovoNoleggio"  obbligatorio="si" tipocontrollo="intero" label="Rinnovo Noleggio" Update="false" size="10" maxlength=9 value="" align="center" >
                    
                  </TD>
                </tr>
              <tr>
                  <TD class="text"> 
                  <font id="DescTempoPreavviso" name="DescTempoPreavviso"> Tempo Preavviso (gg): </font>
                    <INPUT class="text" style="text-align:right;" id="TempoPreavviso" name="TempoPreavviso"  obbligatorio="si" tipocontrollo="intero" label="Tempo Preavviso" Update="false" size="10" maxlength=9 value="">
                  </TD>
              </tr>
              <tr>
                <td class="text" > 
                  <FONT id="DescSpesa" name="DescSpesa"> Partecipa al Calcolo di Spesa complessiva
                  </FONT>
                  <input type="checkbox" value="Y" name="chkSpesaComplessiva">
                </td>
              </tr>
              <tr>
                <td class="text" > 
                  <font id="DescFlusso" name="DescFlusso">Flusso Trasmissivo</font>
                    <input type="checkbox" value="Y" name="chkFlusso">
                </td>
              </tr>
              <tr>
                <td class="text" > Applicazione Euribor
                    <input type="checkbox" value="Y" name="chkEuribor">
                </td>
              </tr>
          </TABLE>
      </TD>
      <!--/DIV!-->
    </tr>
  </TABLE>
  </TD>
</TR>
<TR>
  <TD>
     <HR>
  </TD>
</TR>
      
<TR height="15">
  <TD>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">
        <sec:ShowButtons td_class="textB"/>
      </td>
    </tr>
  </table>
  </TD>
</TR>
</TABLE>

</form>
<SCRIPT LANGUAGE=javascript>
  var objWindows  = null;
  var elementiCheck = '';
  var param = '';
  var objXmlModalNoleg = null;
  var valCboModalNoleg = '';
  var check = false;

  function ONCHIUDI(){
    window.close();	
  }

  function aggiornaDati() {
    alert ( 'aggiorna dati' );
  }

 function ONSELEZIONA(){

    /* Controllo sulla combo */
    if (   ( valCboModalNoleg != '1' ) &&
           ( valCboModalNoleg != '2' ) && 
           ( valCboModalNoleg != '3' ) && 
           ( valCboModalNoleg != '4' )
        ) {
       alert ('\t\tAttenzione!!!\n\n\nPer Associare occorre specificare la Modalità Applicazione Noleggio\n');
       return;
    }
   
    /* Verifico quali elementi sono stati checkati*/
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
   /* Controllo che siamo stai inseriti gli elementi*/
   if(!elementiCheck){
          alert ('\tAttenzione!!!\n\n\nSelezionare almeno un elemento dal catalogo\n');
       return;
}
    /* Controllo sulla selezione di almeno un elemento */
    if(!check) {
       alert ('\tAttenzione!!!\n\n\nSelezionare almeno un elemento\n');
       return;
    }

    if(!CheckNum(document.frmDatiTree.PrimoNoleggio.value,3,0,false)){
      alert('Valore Primo Noleggio deve essere un numero e non deve superare le 3 cifre.');
      document.frmDatiTree.PrimoNoleggio.focus();
      return;
    }

    if(!CheckNum(document.frmDatiTree.RinnovoNoleggio.value,9,0,false)){
      alert('Valore Rinnovo Noleggio deve essere un numero e non deve superare le 9 cifre.');
      document.frmDatiTree.RinnovoNoleggio.focus();
      return;
    }

    if(!CheckNum(document.frmDatiTree.TempoPreavviso.value,9,0,false)){
      alert('Valore Tempo Preavviso deve essere un numero e non deve superare le 9 cifre.');
      document.frmDatiTree.TempoPreavviso.focus();
      return;
    } 
    /*Controllo che riempia solo i campi necessari*/
     if (valCboModalNoleg==2 || valCboModalNoleg==3){
     frmDatiTree.PrimoNoleggio.value='';
     frmDatiTree.RinnovoNoleggio.value='';
     frmDatiTree.TempoPreavviso.value='';
     }
     if (valCboModalNoleg==4){
     frmDatiTree.RinnovoNoleggio.value='';
     frmDatiTree.TempoPreavviso.value='';
     }

    /* Creo la stringa dei parametri */
    
    param = '&Tipo=<%=strTipo%>'  + '&PrimoNol=' + frmDatiTree.PrimoNoleggio.value + '&TempoRinn=' + frmDatiTree.RinnovoNoleggio.value + '&TempoPre=' + frmDatiTree.TempoPreavviso.value + '&Spesa=' +frmDatiTree.chkSpesaComplessiva.checked + '&Euribor=' + frmDatiTree.chkEuribor.checked + '&Flusso=' + frmDatiTree.chkFlusso.checked + '&ModalAppl=' + valCboModalNoleg + '&ProdottoRif=<%=strCodeProdotto%>' + '&ComponenteRif=<%=strCodeComponente%>' ;    
    opener.frmDati.elemSelezionati.value = elementiCheck + param;

    opener.frmDati.strServizio.value = '<%=strCodeServizio%>';

    /* Richiamo aggiornamento dati dell'opener */
    opener.aggiornaDati();

    /* Effettuo la chiusura della finestra */
    window.close();
  }
  
  function ONNUOVO () {
      var URL = '<%=strPaginaNuovoDaRichiamare%>';
      objWindows = window.openCentral(URL,'Nuovo','toolbar=0,location=0,directories=0,status=0,menubar=no,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0',900,500);
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
    Initialize ();
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

    objXmlModalNoleg  = CreaObjXML();
    objXmlModalNoleg.loadXML ('<MAIN><%=remoteCtr_Catalogo.getModalitaApplicazioneNoleggioXml()%></MAIN>');
    CaricaComboDaXML(frmDatiTree.cboModalNoleg,objXmlModalNoleg.documentElement.selectNodes('NOLEGGIO'));

    /* Verifica campi da Abilitare*/
    <%if ( strTipo.equals("COMPONENTE") ) { %>
      document.all('DescSpesa').innerText ="";
      nascondi(frmDatiTree.chkSpesaComplessiva);
    <%}
    else if ( strTipo.equals("PRODOTTO")) {%>
      document.all('DescFlusso').innerText ="";
      nascondi(frmDatiTree.chkFlusso);
    <%} else if ( strTipo.equals("PRESTAZIONE")) {%>
      document.all('DescSpesa').innerText ="";
      nascondi(frmDatiTree.chkSpesaComplessiva);
    <%}%>
	}

  function change_cboModalNoleg(){
    if (valCboModalNoleg!=frmDatiTree.cboModalNoleg.value){
      valCboModalNoleg=frmDatiTree.cboModalNoleg.value;
//      alert(frmDatiTree.cboModalNoleg.value);

      if (
        ( 2 ==  frmDatiTree.cboModalNoleg.value )
        ||
        ( 3 ==  frmDatiTree.cboModalNoleg.value ) 
      ){
        document.all('DescRinnovoNoleggio').innerText ="";
        document.all('DescTempoPreavviso').innerText ="";
        document.all('DescPrimoNoleggio').innerText ="";
        nascondi ( frmDatiTree.RinnovoNoleggio );
        nascondi ( frmDatiTree.TempoPreavviso );
        nascondi ( frmDatiTree.PrimoNoleggio );
      } else if ( 4 ==  frmDatiTree.cboModalNoleg.value ) {
        document.all('DescRinnovoNoleggio').innerText ="Tempo\nRinnovo\nNoleggio (mm):\n";
        document.all('DescTempoPreavviso').innerText  ="Tempo\nPreavviso (gg):\n";
        document.all('DescPrimoNoleggio').innerText   ="Tempo\nPrimo\nNoleggio (mm):\n";
        visualizza ( frmDatiTree.RinnovoNoleggio );
        visualizza ( frmDatiTree.TempoPreavviso );
        visualizza ( frmDatiTree.PrimoNoleggio );
        nascondi   ( frmDatiTree.RinnovoNoleggio );
        nascondi   ( frmDatiTree.TempoPreavviso );
        document.all('DescRinnovoNoleggio').innerText ="";
        document.all('DescTempoPreavviso').innerText ="";
      }
      else {
        document.all('DescRinnovoNoleggio').innerText ="Tempo\nRinnovo\nNoleggio (mm):\n";
        document.all('DescTempoPreavviso').innerText  ="Tempo\nPreavviso (gg):\n";
        document.all('DescPrimoNoleggio').innerText   ="Tempo\nPrimo\nNoleggio (mm):\n";
        visualizza ( frmDatiTree.RinnovoNoleggio );
        visualizza ( frmDatiTree.TempoPreavviso );
        visualizza ( frmDatiTree.PrimoNoleggio );
      }
    }
  }  

  nascondi(document.frmDatiTree.imgOrologio);
  document.all('elabCorso').innerText ="";
</SCRIPT>

</body>
</HTML>