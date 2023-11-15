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
<%=StaticMessages.getMessage(3006,"NavigatoreCatalogo.jsp")%>
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
  	//IMPOSTO L'ACTION DEL VIEWSTATE A VIS PER NON 
  String Offerta      =  Misc.nh(request.getParameter( "Offerta"   ));
  String Servizio     =  Misc.nh(request.getParameter( "Servizio"  ));
  String strAggiorna  =  Misc.nh(request.getParameter( "Aggiorna"  ));
  String strElementi  =  Misc.nh(request.getParameter( "elementi"  ));
  String strValoPrimoNol  =  Misc.nh(request.getParameter( "PrimoNol"   ));
  String strValoRinnNol   =  Misc.nh(request.getParameter( "TempoRinn"  ));
  String strValoPreaNol   =  Misc.nh(request.getParameter( "TempoPre"   ));
  String strModalApplEur  =  Misc.nh(request.getParameter( "ModalAppl"  ));
  String strDataFineNoleggio  =  Misc.nh(request.getParameter( "dataFineNoleggio"  ));
  String strTipo      = Misc.nh(request.getParameter( "Tipo"   ));
  String strSpesa     = (Misc.nh(request.getParameter( "SpesaComplessiva"   ))).equals("true")?"S":"N";
  String strEuribor   = (Misc.nh(request.getParameter( "Euribor" ))).equals("true")?"S":"N";
//  String     = (Misc.nh(request.getParameter( "Flusso"  ))).equals("true")?"S":"N";
//  String strColocato  = (Misc.nh(request.getParameter( "Colocato"  ))).equals("true")?"S":"N";
//  String strRepCaratt = (Misc.nh(request.getParameter( "RepCaratt"  ))).equals("true")?"S":"N";  
//  String strCaratteristica    = Misc.nh(request.getParameter( "Caratteristica" ));

  //QS 08-01-2008: Inizio modifica per eliminazione elemento da PreCatalogo
  String NodoSelezionato = Misc.nh(request.getParameter( "NodoSelezionato"   ));
  String Prodotto = Misc.nh(request.getParameter( "Prodotto"   ));
  String Componente = Misc.nh(request.getParameter( "Componente"   ));
  String Prestazione = Misc.nh(request.getParameter( "Prestazione"   ));
  String messaggio = "";
  //QS 08-01-2008: Fine modifica per eliminazione elemento da PreCatalogo

  
  String lvcs_Return = null;
  int insCatalogo = 0;

  /* Il campo Aggiorna può assumere tre valori
    1--> Inserisci nuovo elemento 
    2--> Elimina elemento */
    
  /*Inserisco in base dati */
  if ( strAggiorna.equals("1") ) {

    strElementi = Misc.replace(strElementi,"PROD=","");
    strElementi = Misc.replace(strElementi,"COMPO=","");
    strElementi = Misc.replace(strElementi,"PREST=","");
    System.out.println( "StrProdotto [" + strElementi + "]");
    StringTokenizer strElemento = new StringTokenizer( strElementi, "|" );

    /* Verifico se Sto associando un prodotto all'offerta richiesta */
    if ( strTipo.equals( "PRODOTTO" ) ){

      /* Inserisco il prodotto o gli n prodotti associati */
     do {
        String strProdotto = strElemento.nextToken();
        insCatalogo =  remoteEnt_Catalogo.inserisciProdottoAssociato( strValoPrimoNol , strValoRinnNol , strValoPreaNol , strEuribor , Offerta , Servizio , strProdotto , strSpesa , strModalApplEur, strDataFineNoleggio);
        //insCatalogo =  remoteEnt_Catalogo.inserisciProdottoAssociato( strValoPrimoNol , strValoRinnNol , strValoPreaNol , strEuribor , Offerta , Servizio , strProdotto , strSpesa , strModalApplEur , strCaratteristica);
     } while ( strElemento.hasMoreElements() );
    }
    else 
    /* Verifico se Sto associando una componente all'offerta richiesta */
    if (strTipo.equals( "COMPONENTE" ) ) {

      /* Inserisco la componente o le n componenti associate */
     do {
        String strProdotto = Misc.nh(request.getParameter( "ProdottoRif"  ));
        String strComponente = strElemento.nextToken();

        /* Inserisco la componente associato */
        insCatalogo =  remoteEnt_Catalogo.inserisciComponenteAssociato( strValoPrimoNol , strValoRinnNol , strValoPreaNol , strEuribor , Offerta , Servizio , strProdotto , strComponente, strSpesa , strModalApplEur, strDataFineNoleggio);
//        insCatalogo =  remoteEnt_Catalogo.inserisciComponenteAssociato( strValoPrimoNol , strValoRinnNol , strValoPreaNol , strEuribor , Offerta , Servizio , strProdotto , strComponente, strSpesa , strFlusso , strModalApplEur , strColocato , strRepCaratt , strCaratteristica );
      } while ( strElemento.hasMoreElements() );
    } 
    else 
    /* Verifico se Sto associando ua prestazione all'offerta richiesta */
    if ( strTipo.equals( "PRESTAZIONE" ) ) {

     do {
        String strProdotto = Misc.nh(request.getParameter( "ProdottoRif"  ));
        String strComponente = Misc.nh(request.getParameter( "ComponenteRif"  )).equals("")?"N":Misc.nh(request.getParameter( "ComponenteRif"  ));
        String strPrestazione = strElemento.nextToken();
        /* Inserisco la prestazione associato */    
        insCatalogo =  remoteEnt_Catalogo.inserisciPrestazioneAssociato( strValoPrimoNol , strValoRinnNol , strValoPreaNol , strEuribor , Offerta , Servizio , strProdotto , strComponente , strPrestazione, strSpesa , strModalApplEur, strDataFineNoleggio);
//        insCatalogo =  remoteEnt_Catalogo.inserisciPrestazioneAssociato( strValoPrimoNol , strValoRinnNol , strValoPreaNol , strEuribor , Offerta , Servizio , strProdotto , strComponente , strPrestazione, strSpesa , strFlusso , strModalApplEur , strColocato , strCaratteristica);
      } while ( strElemento.hasMoreElements() );    
    }
    /* Rigenerazione del file XML per l'offerta */
    lvcs_Return = remoteCtr_Catalogo.createTreeCatalogoXml( Offerta );

  }

  /*Elimino dalla base dati */
  if ( strAggiorna.equals("2") ) {
  
    StringTokenizer strElemento = new StringTokenizer( NodoSelezionato, "|" );
    String strAppoggio= strElemento.nextToken();
    StringTokenizer strElemento2 = new StringTokenizer( strAppoggio, "=" );
    String strVerifica= strElemento2.nextToken();

    int delCatalogo=0; 
    /* Verifico se Sto eliminando un prodotto */
    if ( strVerifica.equals( "PROD" ) ){
      delCatalogo =  remoteEnt_Catalogo.eliminaProdottoAssociato(  Offerta , Servizio , Prodotto );
      if (delCatalogo == 0)
          messaggio = "Operazione eseguita con successo";
      if (delCatalogo == 1)
          messaggio = "Errore durante la disaggregazione dell' associazione, controllare la tabella scarti_catalogo";
      if (delCatalogo == 2)
          messaggio = "Non è possibile disaggregare l'associazione perchè già eseguito l'allineamento preCatalogo";
    }
    else 
    /* Verifico se Sto eliminando una componente */
    if (strVerifica.equals( "COMPO" ) ) {
       delCatalogo =  remoteEnt_Catalogo.eliminaComponenteAssociato(  Offerta , Servizio , Prodotto, Componente);
      if (delCatalogo == 0)
          messaggio = "Operazione eseguita con successo";
      if (delCatalogo == 1)
          messaggio = "Errore durante la disaggregazione dell' associazione, controllare la tabella scarti_catalogo";
      if (delCatalogo == 2)
        messaggio = "Non è possibile disaggregare l'associazione perchè già eseguito l'allineamento preCatalogo";
   
    } 
    else 
    /* Verifico se Sto eliminando una prestazione aggiuntiva */
    if ( strVerifica.equals( "PREST" ) ) {
      delCatalogo =  remoteEnt_Catalogo.eliminaPrestazioneAssociata(  Offerta , Servizio , Prodotto, Componente, Prestazione);  
      
     if (delCatalogo == 0)
       messaggio = "Operazione eseguita con successo";
     if (delCatalogo == 1)
      messaggio = "Errore durante la disaggregazione dell' associazione, controllare la tabella scarti_catalogo";
     if (delCatalogo == 2)
       messaggio = "Non è possibile disaggregare l'associazione perchè già eseguito l'allineamento preCatalogo";
    }
    /* Rigenerazione del file XML per l'offerta */
    lvcs_Return = remoteCtr_Catalogo.createTreeCatalogoXml( Offerta );

  }

  
  String strVarNameXml = "../xml_xsl/" + Offerta + "tree.xml";
  session.setAttribute("strVarNameXml", strVarNameXml);
%>
<HTML>
<script src="<%=StaticContext.PH_CATALOGO_JS%>window.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>Skill.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_CATALOGO_JS%>Albero.js" type="text/javascript"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>Navigatore Catalogo</title>
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
<script src="<%=StaticContext.PH_EVENTI_JS%>generatoreEventi.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>

</head>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
	var objForm     = null;
  var objWindows  = null;
  var Offerta     = null;
  var Servizio    = null;
  var Prodotto    = null;
  var Componente  = null;
  var Prestazione = null;

  var lstrOfferta  = null;
  var lstrServizio = null;
  var lstrProdotto = null;
  var lstrComponente = null;
  var lstrPrestazione = null;

  function aggiornaDati() {
    nascondi(document.Frame1.ltop.folderTree);
    visualizza(document.frmDati.imgOrologio);
    document.all('elabCorso').innerText ="ELABORAZIONE IN CORSO...";
    var URLParam = '?Aggiorna=1' + '&Offerta=<%=Offerta%>' + '&Servizio=' + frmDati.strServizio.value + '&elementi=' + frmDati.elemSelezionati.value;
    frmDati.action = 'NavigatoreCatalogo.jsp' + URLParam;
    frmDati.submit();
  }

   // QS 08-01-2008 -  Inizio modifica per cancellazione/aggiornamento catalogo 
  function eliminaDati() {
    nascondi(document.Frame1.ltop.folderTree);
    visualizza(document.frmDati.imgOrologio);
    document.all('elabCorso').innerText ="ELABORAZIONE IN CORSO...";
    URLParam = '?Aggiorna=2&NodoSelezionato=' + frmDati.entitySelezionato.value + '&nodo=' + frmDati.nodo.value + '&Offerta=' + Offerta + '&Servizio=' + Servizio + '&Prodotto=' + Prodotto + '&Componente=' + Componente + '&Prestazione=' + Prestazione;
    URL = 'NavigatoreCatalogo.jsp' + URLParam;
    frmDati.action = 'NavigatoreCatalogo.jsp' + URLParam;
    //alert(URLParam);
    frmDati.submit();
  }
  // QS 08-01-2008 -  Fine modifica per cancellazione/aggiornamento catalogo 

  
  function assegnaVariabili () {
//    alert ( 'frmDati.elemSelezionati.value=' + frmDati.elemSelezionati.value );
//    alert ('aggiungi');
    frmDati.entitySelezionato.value = document.Frame1.ltop.frmDatiTree.entitySelezionato.value;
    frmDati.viewStateDati.value=frmDati.entitySelezionato.value;
 //   alert ('entitySelezionato=' + frmDati.entitySelezionato.value );

    // Controllo sulla pagina di apertura
    lstrOfferta     = getVS ( frmDati.viewStateDati , "OFFERTE" );
    lstrServizio    = getVS ( frmDati.viewStateDati , "SERVIZI" );
    lstrProdotto    = getVS ( frmDati.viewStateDati , "PRODOTTI" );
    lstrComponente  = getVS ( frmDati.viewStateDati , "COMPONENTI" );
    lstrPrestazione = getVS ( frmDati.viewStateDati , "PRESTAZIONI" );

    if ( 'missing' == lstrOfferta ) lstrOfferta = '';
    if ( 'missing' == lstrServizio ) lstrServizio = '';
    if ( 'missing' == lstrProdotto ) lstrProdotto = '';
    if ( 'missing' == lstrComponente ) lstrComponente = '';
    if ( 'missing' == lstrPrestazione ) lstrPrestazione = '';

    Offerta     = getVS ( frmDati.viewStateDati , "OFF" );
    Servizio    = getVS ( frmDati.viewStateDati , "SERV" );
    Prodotto    = getVS ( frmDati.viewStateDati , "PROD" );
    Componente  = getVS ( frmDati.viewStateDati , "COMPO" );
    Prestazione = getVS ( frmDati.viewStateDati , "PREST" );

    // QS 08-01-2008 -  Inizio modifica per cancellazione/aggiornamento catalogo 
    Stato       = getVS ( frmDati.viewStateDati , "STATO" );
    // QS 08-01-2008 -  Fine modifica per cancellazione/aggiornamento catalogo 

   
    if ( 'missing' == Offerta     ) Offerta = '';
    if ( 'missing' == Servizio    ) Servizio = '';
    if ( 'missing' == Prodotto    ) Prodotto = '';
    if ( 'missing' == Componente  ) Componente = '';
    if ( 'missing' == Prestazione ) Prestazione = '';

    // QS 08-01-2008 -  Inizio modifica per cancellazione/aggiornamento catalogo 
    if ( 'missing' == Stato ) Stato = '1';
    // QS 08-01-2008 -  Fine modifica per cancellazione/aggiornamento catalogo 
  }

  function ONAGGIUNGI() {

    assegnaVariabili ();
  //alert('nodo' + frmDati.nodo.value );

    if ( '' ==  frmDati.nodo.value  ) {
      if ( ( '' != Prodotto ) && ( '' == Componente ) && ( '' == lstrComponente ) && ( '' == lstrPrestazione ) && ( '' == Prestazione ) ){
      } else if ( '' != Componente ) {
              } else if ( '' != lstrOfferta ) {
                         alert ('\t\tAttenzione!!!\n\n\nPer Associare una offerta utilizzare la funzione di anagrafica\n');
                         return;
                      } else if ( '' != lstrServizio ) {
                           alert ('\t\tAttenzione!!!\n\n\nPer Associare un Servizio alla offerta utilizzare la funzione di anagrafica\n');
                           return;
                      } 
    }
    
    if ( '' ==  frmDati.nodo.value  ) {
      /* Verifica pagina di apertura */
      if ( ( '' != Prodotto ) && ( '' == Componente ) && ( '' == lstrComponente ) && ( '' == lstrPrestazione ) && ( '' == Prestazione ) ){
//          alert('sto qua');
          frmDati.nodo.value = '';
          objWindows = window.openCentral('seleziona_aggiungi.jsp','SelAgg','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0',350,220);
          return;
      } else if ( '' != Componente ) {
                frmDati.nodo.value = 'PRESTAZIONI';
              } else if ( '' != lstrOfferta ) {
                        frmDati.nodo.value = 'OFFERTE';
                      } else 
//momentaneamente non disponibile                      if ( '' != lstrServizio ) {
//                                frmDati.nodo.value = 'SERVIZI';
//                             } else 
                             if ( '' != lstrProdotto ) {
                                       frmDati.nodo.value = 'PRODOTTI';
                                    } else  if ( '' != lstrComponente ) {
                                               frmDati.nodo.value = 'COMPONENTI';
                                            } else if ( '' != lstrPrestazione ) {
                                               frmDati.nodo.value = 'PRESTAZIONI';
                                            } else if ( '' != Offerta &&
                                                        '' != Servizio) {
                                               frmDati.nodo.value = 'PRODOTTI';
                                            } 
                                            else {
                                                alert ('\t\tAttenzione!!!\n\n\nPer aggiungere elementi occorre selezionare i cappelli introduttivi\n');
                                                return;
                                            }
    }

    URLParam = '?NodoSelezionato=' + frmDati.entitySelezionato.value + '&nodo=' + frmDati.nodo.value + '&Offerta=' + Offerta + '&Servizio=' + Servizio + '&Prodotto=' + Prodotto + '&Componente=' + Componente + '&Prestazione=' + Prestazione;

    URL = 'NavigatoreAggiungi.jsp' + URLParam;
    objWindows = window.openCentral(URL,'AggEl','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
    frmDati.nodo.value = '';
  }

   //QS: 08/01/2008: Inizio gestione DISAGGREGAZIONE/MODIFICA ELEMENTO dal catalogo
  function ONCANCELLA() {
    assegnaVariabili ();
    if (( '' == Stato) & ( Prodotto != '')){
      var scelta = confirm ('Attenzione!!! Confermi la cancellazione? ');
      if (scelta == true){
        URLParam = '?NodoSelezionato=' + frmDati.entitySelezionato.value + '&nodo=' + frmDati.nodo.value + '&Offerta=' + Offerta + '&Servizio=' + Servizio + '&Prodotto=' + Prodotto + '&Componente=' + Componente + '&Prestazione=' + Prestazione;
        URL = 'NavigatoreCatalogo.jsp' + URLParam;
        eliminaDati();
        frmDati.nodo.value = '';    
    }
      else 
        return;
    }
    else{
       alert ('Attenzione!!!\n\n\nCancellazione non ammessa \n');
      return;
    }  
  }
   
   
  function ONAGGIORNA() {

    assegnaVariabili ();
      if (( '' == Stato) & ( Prodotto != '')){
     
        URLParam = '?Offerta=' + Offerta + '&Servizio=' + Servizio + '&Prodotto=' + Prodotto + '&Componente=' + Componente + '&Prestazione=' + Prestazione;
        URL = 'pre_aggiornamento_prod_comp_prest.jsp' + URLParam;
        openCentral(URL,'AggEl','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
        //objWindows = window.openCentral(URL,'AggEl','height=300, toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,copyhistory=0,top=0,left=0');
        frmDati.nodo.value = '';  
        assegnaVariabili();
    }
    else{
      alert ('Attenzione!!!\n\n\nAggiornamento non ammesso \n');
      return;
    }  

    
    
    

    //URLParam = '?NodoSelezionato=' + frmDati.entitySelezionato.value + '&nodo=' + frmDati.nodo.value + '&Offerta=' + Offerta + '&Servizio=' + Servizio + '&Prodotto=' + Prodotto + '&Componente=' + Componente + '&Prestazione=' + Prestazione;

    //URL = 'NavigatoreAggiungi.jsp' + URLParam;
    //objWindows = window.openCentral(URL,'AggEl','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
    //frmDati.nodo.value = '';
  }

  //QS: 08/01/2008: Fine gestione DISAGGREGAZIONE/MODIFICA ELEMENTO dal catalogo

  function ONCHIUDI(){
    window.close();
  }

  function prova(){
    alert('prova');
  }
</SCRIPT>

<%--<BODY  onLoad="resizeTo(screen.width,screen.height);"  topmargin="0" leftmargin="0" onfocus="ControllaFinestra()" onload="SetDivPos(140)" onresize="SetDivPos(140);SetDivPos2(140)" onclick="ControllaFinestra()" >--%>
<BODY  onLoad="resizeTo(screen.width,screen.height);"  topmargin="0" leftmargin="0" onfocus="ControllaFinestra()" onclick="ControllaFinestra()" >

<FORM name="frmDati" method="post" action="">
    <input type="hidden" name="entitySelezionato" value="">
    <input type="hidden" id="viewStateDati" name="viewStateDati" value="">
    <input type="hidden" id="elemSelezionati" name="elemSelezionati" value="">
    <input type="hidden" id="strServizio" name="strServizio" value="">
    <input type="hidden" id="nodo" name="nodo" value="">
    <input type="hidden" id="messaggio"  name="messaggio" value="<%=messaggio%>">

<table height="100%" width="100%" cellspacing="0" cellpadding="0" class="Generale" border="0">
  <tr>
    <td>
      <table width="100%" height=100% cellspacing="0" cellpadding="0" align=center border=0>
        <TR height="25">
          <TD>
            <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
              <TR>
                <TD>
                  <IMG alt="" src="../images/catalogo.gif" border="0">
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
                  <iframe src="DettaglioCatalogo.jsp" frameborder=0 width=100% height=100% scrolling=auto name="Frame1"></iframe>
                  <iframe src="PaginaVuota.jsp" frameborder=0 width=25% height=100% scrolling=auto name="Frame2"></iframe>
                </td>
              </tr>
            </table>				
          </td>
        </tr>	
      </table>
    </td>
  </tr>
  <TR height="5">
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
<script language="JavaScript">
  if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
