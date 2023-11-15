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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/Tar" prefix="tar" %>

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"istanza_dettaglio_prest_agg.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>

<%
  int Code_Offerta = 0;
  int Code_Prodotto = 0;
  int CompoSel = 0;

  /* PARAMETRO SELECTED */
  String strSELECTED = Misc.nh(request.getParameter("SELECTED"));
  int selected = 0;
  //System.out.println("COMPONENTE ["+strSELECTED+"]");
  if(strSELECTED.equals("")){
    selected = 0;
  }else{
    selected = Integer.parseInt(strSELECTED);
  }
  /* FINE PARAMETRO SELECTED */
  
  	//IMPOSTO L'ACTION DEL VIEWSTATE A VIS PER NON 
	String strViewStateDati = "";

  String strViewStateCostructor = "";
  DB_InventPrest data_InventariPrestAgg = null;
  DB_InventProd data_InventariProdotto=null;
  DB_InventCompo data_InventariCompo=null;
  DB_InventPrest ctrldata_InventariPrestAgg = null;

  strViewStateDati = Misc.nh(request.getParameter("viewStateDati"));
  
  String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));
  String Code_Ist_Prod = Misc.nh(request.getParameter("Istanza"));
  String Code_Servizio = Misc.nh(request.getParameter("Servizio"));

  String strtypeLoad;
  strtypeLoad = Misc.nh(request.getParameter("hidTypeLoadPrestAgg"));
  if ( strtypeLoad.equals("") )
      strtypeLoad = (String)session.getAttribute("hidTypeLoadPrestAgg");
 
  String strEnableRettifica = (String) session.getAttribute("elemNonModif");

//GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector vct_InventariPrestAgg = null;
  Vector vct_InventariProdotto = null;
  Vector vct_InventariCompo = null;
  Vector ctrlvct_InventariPrestAg = null;
  vct_InventariProdotto = (Vector) session.getAttribute("vct_Inventari");

  /* OTTENGO LE COMPONENTI ANCHE SE NON ESISTONO IN SESSIONE */
  if(session.getAttribute("vct_InventariCompo") != null){
    vct_InventariCompo = (Vector) session.getAttribute("vct_InventariCompo");

  }
  else
  {
    vct_InventariCompo = remoteEnt_Inventari.getInventarioComponenti(Code_Ist_Prod);
  }

  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0) {
    vct_InventariPrestAgg = (Vector) session.getAttribute("vct_InventariPrestAgg");
    vct_InventariProdotto = (Vector) session.getAttribute("vct_Inventari");
    ctrlvct_InventariPrestAg = (Vector) session.getAttribute("ctrlvct_InventariPrestAg");
  }
  else
  {
    vct_InventariPrestAgg = remoteEnt_Inventari.getInventarioPrestazioni(Code_Ist_Prod);
        /*MoS */
    ctrlvct_InventariPrestAg =  remoteEnt_Inventari.getInventarioPrestazioni(Code_Ist_Prod);
    if (vct_InventariPrestAgg!=null) {
       session.setAttribute("vct_InventariPrestAgg", vct_InventariPrestAgg);
       session.setAttribute("ctrlvct_InventariPrestAg", ctrlvct_InventariPrestAg);
       session.setAttribute("hidTypeLoadPrestAgg", "1");
    }
  }
//FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int elementoSelezionato = 0;

  /* Verifico se devo effettuare l'aggiornamento sul dato */
  if ( ( typeLoad == 0 )|| ( typeLoad == 1 ) ) {
    elementoSelezionato = selected;
    if (vct_InventariPrestAgg.size() != 0 ){
      data_InventariPrestAgg = (DB_InventPrest)vct_InventariPrestAgg.get(elementoSelezionato);
      for(int nCompo = 0; nCompo<vct_InventariCompo.size(); nCompo++){
        //System.out.println("GIRO ["+nCompo+"]");
        data_InventariCompo = (DB_InventCompo)vct_InventariCompo.get(nCompo);
          
        if((data_InventariCompo.getCODE_ISTANZA_COMPO() != null || data_InventariCompo.getCODE_ISTANZA_COMPO() != "") &&
            data_InventariCompo.getCODE_ISTANZA_COMPO().equals(data_InventariPrestAgg.getCODE_ISTANZA_COMPO())){
            /* LEGATA ALLA COMPONENTE */
            data_InventariPrestAgg.setCODE_COMPONENTE(data_InventariCompo.getCODE_COMPONENTE());
            data_InventariPrestAgg.setDESC_COMPONENTE(data_InventariCompo.getDESC_COMPONENTE());            
        }else{
          /* LEGATA AL PRODOTTO */
          /* NESSUNA COMPONENTE */
        }
      }
    }
    data_InventariProdotto = (DB_InventProd)vct_InventariProdotto.get(0);
  

  String strEnableCreaEvento = (String) session.getAttribute("ableCreaEvento");
  if ( strEnableCreaEvento == null )  session.setAttribute("ableCreaEvento", "0");


  //Controllo le abilitazione dell'upd e del del
  boolean EnableUpd = true;
  boolean EnableDel = true;

  String URLParam = "?Istanza=" + Code_Ist_Prod + "&Servizio=" + Code_Servizio;
  String PaginaRichiamata = "istanza_dettaglio_anagrafico_" + Code_Servizio;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Inventario Prestazione Aggiuntiva
</title>
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
</head>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
	var objForm = null ;

  var dialogWin = new Object();
    
	function Initialize(){
  		objForm = document.frmDati;
	}

  function ableCreaEvento () {
    <% if ( strEnableCreaEvento.equals("1") ) { %>
      Enable ( frmDati.CREAEVENTO );
      Enable ( frmDati.ANNULLAMODIFICHE);
      <% if ( strEnableRettifica.equals("1") ) { %>
        Disable ( frmDati.RETTIFICA);
      <% } %>
    <% } %>
  }

   function ONSALVA(pagina) {
      var Errore = 0;
      ONRETTIFICA_SALVA();
      if(frmDati.abilitaModifiche.value == "1" && !frmDati.RETTIFICA.disabled){
      
        if (frmDati.strCodePrestAgg.value == '') {
          Errore = 1;
          alert('Errore la Prestazione Aggiuntiva non è selezionata');
          frmDati.strCodePrestAgg.focus();
          return false;
        }

      }

      if (Errore == 0) {
        objForm.hidTypeLoadPrestAgg.value = '2';
        frmDati.paginaDestinazione.value = pagina;
        objForm.submit();
        DisabilitaPrestAgg();
        return true;
      }
  }

  function ONCHIUDI(){
    window.close();	
  }

   function ONANNULLAMODIFICHE() {
      frmDati.hidTypeLoadPrestAgg.value = '0';
      frmDati.submit();
   }  

  function cambiaPrestAgg ( obj ) {
    if ( '0' == frmDati.LinkAbilitato.value ) {
        return;
    } 
    else {
      if ( frmDati.srcCodeAccount.disabled == false ) 
        alert ('\t\t\t\tAttenzione!!!\n\n\nLe modifiche effettuate sui campi andranno perse..\nQuando si intende modificare i dati prima di effetuare il cambio di Elemento, a fine modifica cliccare sul pulsante SALVA ');

      visualizzaDettagli ( obj );
    }
  }

  function visualizzaDettagli( obj ) {
      frmDati.srcCodeStato.value        = getVS ( obj , "vsCODE_STATO_ELEM" );
      frmDati.strCodeComponente.value   = getVS ( obj , "vsCODE_COMPONENTE" );
      frmDati.strCodePrestAgg.value     = getVS ( obj , "vsCODE_PREST_AGG" );
      frmDati.srcDIF.value              = getVS ( obj , "vsDATA_INIZIO_FATRZ" );
      frmDati.srcQNTA.value             = getVS ( obj , "vsQNTA_VALO" );
      frmDati.srcCicloVal.value         = getVS ( obj , "vsCODE_ULTIMO_CICLO_FATRZ" );
      frmDati.strDataFineFatrz.value    = getVS ( obj , "vsDATA_FINE_FATRZ" );
      frmDati.strTipoCausaleAtt.value   = getVS ( obj , "vsTIPO_CAUSALE_ATT" );
      frmDati.strDataCessazPrest.value       = getVS ( obj , "vsDATA_CESSAZ");
      frmDati.strDataInizioValid.value  = getVS ( obj , "vsDATA_INIZIO_VALID" );
      frmDati.strDataFineValid.value    = getVS ( obj , "vsDATA_FINE_VALID" );
      frmDati.strTipoCausaleCes.value   = getVS ( obj , "vsTIPO_CAUSALE_CES" );
      frmDati.strDataFineNol.value      = getVS ( obj , "vsDATA_FINE_NOL" );
      frmDati.strDescStato.value        = getVS ( obj , "vsDESC_STATO" );
      frmDati.strDescCausaleAtt.value   = getVS ( obj , "vsDESC_CAUSALE_ATT" );
      frmDati.strDescCausaleCes.value   = getVS ( obj , "vsDESC_CAUSALE_CES" );
      frmDati.strDescCiclo.value        = getVS ( obj , "vsDESC_CICLO" );
      frmDati.strDescComponente.value   = getVS ( obj , "vsDESC_COMPONENTE" );
      frmDati.strIstanzaPrestAgg.value  = getVS ( obj , "vsCODE_ISTANZA_PREST_AGG" );
      frmDati.strDescPrestAgg.value     = getVS ( obj , "vsDESC_PREST_AGG" );
      frmDati.strDataInizioNol.value    = getVS ( obj , "vsDATA_INIZIO_NOL" );
      frmDati.elementoSelezionato.value = getVS ( obj , "vsIndice" );
      frmDati.strDataCreaz.value        = getVS ( obj , "vsDATA_CREAZ" );
      DisabilitaPrestAgg();
  }

  function caricaDati(){
      frmDati.LinkAbilitato.value = '1';
      
      <%if (strEnableRettifica.equals("1")) {%>
        Disable(frmDati.RETTIFICA);
        Disable(frmDati.CREA_EVENTO);
      <%}%>
      
    <%if ( data_InventariPrestAgg != null ) {%>
      frmDati.elementoSelezionato.value = '<%=elementoSelezionato%>';

      frmDati.srcCodeStato.value        = '<%=data_InventariPrestAgg.getCODE_STATO_ELEM()%>';
      frmDati.strCodeComponente.value   = '<%=data_InventariPrestAgg.getCODE_COMPONENTE()%>';
      frmDati.strCodePrestAgg.value     = '<%=data_InventariPrestAgg.getCODE_PREST_AGG()%>';
      frmDati.srcDIF.value              = '<%=data_InventariPrestAgg.getDATA_INIZIO_FATRZ()%>';
      frmDati.srcQNTA.value             = '<%=data_InventariPrestAgg.getQNTA_VALO()%>';
      frmDati.srcCicloVal.value         = '<%=data_InventariPrestAgg.getCODE_ULTIMO_CICLO_FATRZ()%>';
      frmDati.strDataFineFatrz.value    = '<%=data_InventariPrestAgg.getDATA_FINE_FATRZ()%>';
      frmDati.strTipoCausaleAtt.value   = '<%=data_InventariPrestAgg.getTIPO_CAUSALE_ATT()%>';
      frmDati.strDataCessazPrest.value       = '<%=data_InventariPrestAgg.getDATA_CESSAZ()%>';
      frmDati.strDataInizioValid.value  = '<%=data_InventariPrestAgg.getDATA_INIZIO_VALID()%>';
      frmDati.strDataFineValid.value    = '<%=data_InventariPrestAgg.getDATA_FINE_VALID()%>';
      frmDati.strTipoCausaleCes.value   = '<%=data_InventariPrestAgg.getTIPO_CAUSALE_CES()%>';
      frmDati.strDataFineNol.value      = '<%=data_InventariPrestAgg.getDATA_FINE_NOL()%>';
      frmDati.strIstanzaPrestAgg.value  = '<%=data_InventariPrestAgg.getCODE_ISTANZA_PREST_AGG()%>';
      frmDati.strDataInizioNol.value    = '<%=data_InventariPrestAgg.getDATA_DIN()%>';
      frmDati.strDataCreaz.value        = '<%=data_InventariPrestAgg.getDATA_CREAZ()%>';

      frmDati.strDescStato.value        = '<%=data_InventariPrestAgg.getDESC_STATO_ELEM()%>';
      frmDati.strDescCausaleAtt.value   = '<%=data_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT()%>';
      frmDati.strDescCausaleCes.value   = '<%=data_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES()%>';

      frmDati.strDescCiclo.value        = '<%=data_InventariPrestAgg.getDESCRIZIONE_CICLO()%>';
      frmDati.strDescComponente.value   = '<%=data_InventariPrestAgg.getDESC_COMPONENTE()%>';
      frmDati.strDescPrestAgg.value     = '<%=data_InventariPrestAgg.getDESC_PREST_AGG()%>';      
      frmDati.strDataRicezOrdine.value  = '<%=data_InventariPrestAgg.getDATA_DRO()%>';

      swapClass(frmDati.elementoSelezionato.value);
      <%
      System.out.println("abilitaModifiche prest_agg ["+data_InventariPrestAgg.eMODIFICATO()+"]");
      %>
      frmDati.abilitaModifiche.value    = '<%=data_InventariPrestAgg.eMODIFICATO()%>';

      <%} else { %>
          alert('Non esistono Prestazioni Aggiuntive Legate alla Istanza Prodotto Selezionata');
          Disable(frmDati.RETTIFICA);
      <%}%>
      
      frmDati.srcCodeServizio.value     = '<%=session.getAttribute("parsrcCodeServizio")%>';
      frmDati.strDescServizio.value     = '<%=session.getAttribute("parstrDescServizio")%>';
      frmDati.srcCodeAccount.value      = '<%=session.getAttribute("parsrcCodeAccount")%>';
      frmDati.strDescAccount.value      = '<%=session.getAttribute("parstrDescAccount")%>';
      frmDati.srcCodeOfferta.value      = '<%=session.getAttribute("parsrcCodeOfferta")%>';
      frmDati.strDescOfferta.value      = '<%=session.getAttribute("parstrDescOfferta")%>';
      frmDati.strCodeProdotto.value     = '<%=session.getAttribute("parstrCodeProdotto")%>';
      frmDati.strDescProdotto.value     = '<%=session.getAttribute("parstrDescProdotto")%>';

  }

   function ONRETTIFICA() {
        Enable(frmDati.srcCodeAccount);
        Enable(frmDati.srcCodeOfferta);
        Enable(frmDati.srcCodeServizio);
        Enable(frmDati.strCodeProdotto);
        Enable(frmDati.srcDIF);
        Enable(frmDati.srcQNTA);
        Enable(frmDati.strDataFineFatrz);
        Enable(frmDati.strTipoCausaleAtt);
        Enable(frmDati.strDataCessazPrest);
       // Enable(frmDati.strDataInizioValid);
        Enable(frmDati.strTipoCausaleCes);
        Enable(frmDati.strDataFineValid);
        Enable(frmDati.strCodeComponente);
        Enable(frmDati.strDescComponente);
        Enable(frmDati.strCodePrestAgg);
        Enable(frmDati.strDataRicezOrdine);
        Enable(frmDati.strDataInizioNol);

        Enable(frmDati.strDescAccount);
        Enable(frmDati.strDescOfferta);
        Enable(frmDati.strDescServizio);
        Enable(frmDati.strDescCausaleAtt);
        Enable(frmDati.strDescCausaleCes);
        Enable(frmDati.strDescProdotto);
        Enable(frmDati.strDescPrestAgg);

        Enable(frmDati.cmdProdotto);
        Enable(frmDati.cmdComponente);
        Enable(frmDati.cmdPrestazione);

        //Enable ( frmDati.SALVA);
        Enable ( frmDati.CREAEVENTO);
        Enable ( frmDati.ANNULLAMODIFICHE);

        
        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCancelDCE);
        EnableLink(document.links[2],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[3],document.frmDati.imgCancelDIF);
        EnableLink(document.links[11],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[12],document.frmDati.imgCancelDIN);
        EnableLink(document.links[13],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[14],document.frmDati.imgCancelDRO);
        
        frmDati.abilitaModifiche.value = "1";

    }

    function ONRETTIFICA_SALVA() {
        Enable(frmDati.srcCodeAccount);
        Enable(frmDati.srcCodeOfferta);
        Enable(frmDati.srcCodeServizio);
        Enable(frmDati.strCodeProdotto);
        Enable(frmDati.srcDIF);
        Enable(frmDati.srcQNTA);
        Enable(frmDati.strDataFineFatrz);
        Enable(frmDati.strTipoCausaleAtt);
        Enable(frmDati.strDataCessazPrest);        
       // Enable(frmDati.strDataInizioValid);
        Enable(frmDati.strTipoCausaleCes);
        Enable(frmDati.strDataFineValid);
        Enable(frmDati.strCodeComponente);
        Enable(frmDati.strDescComponente);
        Enable(frmDati.strCodePrestAgg);
        Enable(frmDati.strDataRicezOrdine);
        Enable(frmDati.strDataInizioNol);

        Enable(frmDati.strDescAccount);
        Enable(frmDati.strDescOfferta);
        Enable(frmDati.strDescServizio);
        Enable(frmDati.strDescCausaleAtt);
        Enable(frmDati.strDescCausaleCes);
        Enable(frmDati.strDescProdotto);
        Enable(frmDati.strDescPrestAgg);

        Enable(frmDati.cmdProdotto);
        Enable(frmDati.cmdComponente);
        Enable(frmDati.cmdPrestazione);

        //Enable ( frmDati.SALVA);  

        EnableLink(document.links[0],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[1],document.frmDati.imgCancelDIF);
        EnableLink(document.links[10],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[11],document.frmDati.imgCancelDIN);
        EnableLink(document.links[12],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[13],document.frmDati.imgCancelDRO);
    }

    function ONSALVA_EVENTO(){
      if(ONSALVA(frmDati.paginaSorgente.value)){
           inserisciNote(); 
        ONCREAEVENTO();
      }
    }
    
    function swapClass(td) {
      document.getElementById(td).className = 'textBold';
    }
 function ChiudiCallParentWindowFunction()
{
  //alert('ChiudiCallParentWindowFunction');
  setTimeout("window.opener.CallAlert(); window.close();",6000);
 
}       
 
</SCRIPT>
<body onLoad="Initialize();resizeTo(screen.width,screen.height)" onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()" >
<FORM name="frmDati" id="frmDati" action="" method="post">
<input type="hidden" name="hidTypeLoadPrestAgg" value="">
<input type="hidden" name="elementoSelezionato" value="">
<input type="hidden" name="paginaDestinazione" value="">
<input type="hidden" name="abilitaModifiche" value="<%=strEnableCreaEvento%>">
<input type="hidden" name="rettifica" value="0">
<input type="hidden" name="LinkAbilitato" value="">
<input type="hidden" name="paginaSorgente" value="istanza_dettaglio_prest_agg.jsp?Istanza=<%=Code_Ist_Prod%>">
<TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0"height="100%">
  <TR height="35">
    <TD>
      <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
        <TR>
          <TD align="left">
            <IMG alt="" src="../images/GeneratoreEventi.gif" border="0" width="266" height="35">
          </TD>
          <TD colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="center" width="682">
            <U>Istanza Prestazione Aggiuntiva Selezionata : </U>
            <input class="textSel" title="strIstanzaPrestAgg" name="strIstanzaPrestAgg" size="20" readonly>
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="center">
            <U>Istanza Prodotto Selezionato : <%=Code_Ist_Prod%></U>
          </TD>
        </TR>
      </TABLE>
    </TD>
  </TR>
  <TR height="20">
    <TD>
      <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>" rules="rows" frame="box" bordercolor="<%=StaticContext.bgColorHeader%>" height="100%">
        <TR align="center">
          <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('istanza_dettaglio_prodotto.jsp<%=URLParam%>');">
            Prodotto
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('istanza_dettaglio_componente.jsp<%=URLParam%>');">
            Componente
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorTabellaForm%>" class="blackB" width="150">
            Prestazioni Aggiuntive
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('<%=PaginaRichiamata%>.jsp<%=URLParam%>');">
            Anagrafica
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
            &nbsp;
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
            <IMG alt="immagini" src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28">
          </TD>
        </TR>
      </TABLE>
    </TD>
  </TR>
  <TR>
     <TD>
        <HR>
     </TD>
  </TR>
  <TR>
    <TD>
      <TABLE width="100%" height="100%" border="1" cellspacing="0" cellpadding="1" rules="cols" frame="vsides" bordercolor="#0A6B98">
        <TR>
          <!--Frame sinistro-->
          <TD width="15%" valign="top">
            <DIV>
            <TABLE width="100%" border="0" cellspacing="1" cellpadding="0">
              <!-- INIZIO Visualizzazione Prodotto -->
              <TR bgcolor="#0A6B98" align="center">
                <TD class="white">
                  Prodotto
                </TD>
              </TR>
              <%
              //Caricamento dei Prodotti
              String objBgColorProd = StaticContext.bgColorRigaPariTabella;

                for (int i = 0;i < vct_InventariPrestAgg.size();i++){
                  if (objBgColorProd == StaticContext.bgColorRigaPariTabella) objBgColorProd = StaticContext.bgColorRigaDispariTabella;
                  else objBgColorProd = StaticContext.bgColorRigaPariTabella; 
                  data_InventariPrestAgg = (DB_InventPrest)vct_InventariPrestAgg.get(i);
                                                  /*MoS*/
                   //================================================================
                   if ( ctrlvct_InventariPrestAg != null){
                           ctrldata_InventariPrestAgg = null;
                       ctrldata_InventariPrestAgg = (DB_InventPrest)ctrlvct_InventariPrestAg.get(i) ;
                       if ( !(data_InventariPrestAgg.getCODE_SERVIZIO().equals(ctrldata_InventariPrestAgg.getCODE_SERVIZIO())) ||
                        !(data_InventariPrestAgg.getDESC_SERVIZIO().equals(ctrldata_InventariPrestAgg.getDESC_SERVIZIO())) ||
                        !(data_InventariPrestAgg.getCODE_ACCOUNT().equals(ctrldata_InventariPrestAgg.getCODE_ACCOUNT())) ||
                        !(data_InventariPrestAgg.getDESC_ACCOUNT().equals(ctrldata_InventariPrestAgg.getDESC_ACCOUNT())) ||
                        !(data_InventariPrestAgg.getCODE_OFFERTA().equals(ctrldata_InventariPrestAgg.getCODE_OFFERTA())) ||
                        !(data_InventariPrestAgg.getDESC_OFFERTA().equals(ctrldata_InventariPrestAgg.getDESC_OFFERTA())) ||
                        !(data_InventariPrestAgg.getCODE_PRODOTTO().equals(ctrldata_InventariPrestAgg.getCODE_PRODOTTO())) ||
                        !(data_InventariPrestAgg.getDESC_PRODOTTO().equals(ctrldata_InventariPrestAgg.getDESC_PRODOTTO())) ||
                        !(data_InventariPrestAgg.getCODE_COMPONENTE().equals(ctrldata_InventariPrestAgg.getCODE_COMPONENTE())) ||
                        !(data_InventariPrestAgg.getDESC_COMPONENTE().equals(ctrldata_InventariPrestAgg.getDESC_COMPONENTE())) ||
                        !(data_InventariPrestAgg.getTIPO_CAUSALE_ATT().equals(ctrldata_InventariPrestAgg.getTIPO_CAUSALE_ATT())) ||
                        !(data_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT().equals(ctrldata_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT())) ||
                        !(data_InventariPrestAgg.getTIPO_CAUSALE_CES().equals(ctrldata_InventariPrestAgg.getTIPO_CAUSALE_CES())) ||
                        !(data_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES().equals(ctrldata_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES())) ||
                        !(data_InventariPrestAgg.getDATA_INIZIO_VALID().equals(ctrldata_InventariPrestAgg.getDATA_INIZIO_VALID())) ||
                        !(data_InventariPrestAgg.getDATA_FINE_VALID().equals(ctrldata_InventariPrestAgg.getDATA_FINE_VALID())) ||
                        !(data_InventariPrestAgg.getQNTA_VALO().equals(ctrldata_InventariPrestAgg.getQNTA_VALO())) ||
                        !(data_InventariPrestAgg.getDATA_INIZIO_FATRZ().equals(ctrldata_InventariPrestAgg.getDATA_INIZIO_FATRZ())) ||
                        !(data_InventariPrestAgg.getDATA_FINE_FATRZ().equals(ctrldata_InventariPrestAgg.getDATA_FINE_FATRZ())) ||
                        !(data_InventariPrestAgg.getDATA_DRO().equals(ctrldata_InventariPrestAgg.getDATA_DRO())) ||
                        !(data_InventariPrestAgg.getDATA_DIN().equals(ctrldata_InventariPrestAgg.getDATA_DIN())) ){
                              objBgColorProd=StaticContext.bgColorRigaPariErroreTabella ;
                        }
                   }
                   //================================================================
                  %>
                <% if ( data_InventariPrestAgg.getCODE_COMPONENTE().equals("") ) { %>
                  <TR bgcolor="<%=objBgColorProd%>" align="center">
                  <% /* Memorizzazione delle anagrafiche */
                        strViewStateCostructor = "";
                        strViewStateCostructor += "vsCODE_INVENT="+ 							data_InventariPrestAgg.getCODE_INVENT()						+ "|";
                        strViewStateCostructor += "vsCODE_INVENT_RIF="+						data_InventariPrestAgg.getCODE_INVENT_RIF()        + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_ATT="+  				data_InventariPrestAgg.getTIPO_CAUSALE_ATT()       + "|";
                        strViewStateCostructor += "vsDATA_CESSAZ="+       				data_InventariPrestAgg.getDATA_CESSAZ()            + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_CES="+  				data_InventariPrestAgg.getTIPO_CAUSALE_CES()       + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_ATT_HD="+ 			data_InventariPrestAgg.getTIPO_CAUSALE_ATT_HD()    + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_CES_HD="+ 			data_InventariPrestAgg.getTIPO_CAUSALE_CES_HD()    + "|";
                        strViewStateCostructor += "vsCODE_STATO_ELEM="+		  			data_InventariPrestAgg.getCODE_STATO_ELEM()        + "|";
                        strViewStateCostructor += "vsCODE_ACCOUNT="+ 							data_InventariProdotto.getCODE_ACCOUNT()           + "|";
                        strViewStateCostructor += "vsCODE_OFFERTA="+ 							data_InventariProdotto.getCODE_OFFERTA()           + "|";
                        strViewStateCostructor += "vsCODE_SERVIZIO="+   					data_InventariProdotto.getCODE_SERVIZIO()          + "|";
                        strViewStateCostructor += "vsCODE_PRODOTTO="+   					data_InventariProdotto.getCODE_PRODOTTO()          + "|";
                        strViewStateCostructor += "vsCODE_COMPONENTE="+ 					data_InventariPrestAgg.getCODE_COMPONENTE()        + "|";
                        strViewStateCostructor += "vsCODE_PREST_AGG="+ 		    		data_InventariPrestAgg.getCODE_PREST_AGG()         + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_PROD="+ 				data_InventariPrestAgg.getCODE_ISTANZA_PROD()      + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_COMPO="+  			data_InventariPrestAgg.getCODE_ISTANZA_COMPO()     + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_PREST_AGG="+  	data_InventariPrestAgg.getCODE_ISTANZA_PREST_AGG() + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_VALID="+ 				data_InventariPrestAgg.getDATA_INIZIO_VALID()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_VALID="+ 					data_InventariPrestAgg.getDATA_FINE_VALID()        + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_FATRZ="+					data_InventariPrestAgg.getDATA_INIZIO_FATRZ()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_FATRZ="+ 					data_InventariPrestAgg.getDATA_FINE_FATRZ()        + "|";
                        strViewStateCostructor += "vsCODE_ULTIMO_CICLO_FATRZ="+		data_InventariPrestAgg.getCODE_ULTIMO_CICLO_FATRZ()+ "|";
                        strViewStateCostructor += "vsDATA_FINE_NOL="+							data_InventariPrestAgg.getDATA_FINE_NOL()          + "|";
                        strViewStateCostructor += "vsDATA_CESSAZ="+								data_InventariPrestAgg.getDATA_CESSAZ()            + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_FATRB="+					data_InventariPrestAgg.getDATA_INIZIO_FATRB()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_FATRB="+						data_InventariPrestAgg.getDATA_FINE_FATRB()        + "|";
                        strViewStateCostructor += "vsQNTA_VALO="+									data_InventariPrestAgg.getQNTA_VALO()              + "|";
                        strViewStateCostructor += "vsTIPO_FLAG_CONG="+						data_InventariPrestAgg.getTIPO_FLAG_CONG()         + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_CREAZ="+					data_InventariPrestAgg.getCODE_UTENTE_CREAZ()      + "|";
                        strViewStateCostructor += "vsDATA_CREAZ="+								data_InventariPrestAgg.getDATA_CREAZ()             + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_MODIF="+					data_InventariPrestAgg.getCODE_UTENTE_MODIF()      + "|";
                        strViewStateCostructor += "vsDATA_MODIF="+								data_InventariPrestAgg.getDATA_MODIF()             + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_CREAZ_HD="+    	data_InventariPrestAgg.getCODE_UTENTE_CREAZ_HD()   + "|";
                        strViewStateCostructor += "vsDATA_CREAZ_HD="+ 						data_InventariPrestAgg.getDATA_CREAZ_HD()          + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_MODIF_HD="+     	data_InventariPrestAgg.getCODE_UTENTE_MODIF_HD()   + "|";
                        strViewStateCostructor += "vsDATA_MODIF_HD="+   					data_InventariPrestAgg.getDATA_MODIF_HD()          + "|";
                        strViewStateCostructor += "vsELAB_VALORIZ="+ 							data_InventariPrestAgg.getELAB_VALORIZ()           + "|";
                        strViewStateCostructor += "vsTIPO_FLAG_MIGRAZIONE="+			data_InventariPrestAgg.getTIPO_FLAG_MIGRAZIONE()   + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_NOL="+						data_InventariPrestAgg.getDATA_DIN()               + "|";
                        strViewStateCostructor += "vsDATA_RICEZ_ORDINE="+         data_InventariPrestAgg.getDATA_DRO()               + "|";
                        strViewStateCostructor += "vsIndice="+	              		i   + "|";

                         /* Selezione delle descrizioni*/
                        strViewStateCostructor += "vsDESC_CAUSALE_ATT="+	data_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT  () + "|" ;
                        strViewStateCostructor += "vsDESC_CAUSALE_CES="+  data_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES  () + "|" ;
                        strViewStateCostructor += "vsDESC_ACCOUNT="+			data_InventariProdotto.getDESC_ACCOUNT       () + "|" ;
                        strViewStateCostructor += "vsDESC_OFFERTA="+ 			data_InventariProdotto.getDESC_OFFERTA       () + "|" ;
                        strViewStateCostructor += "vsDESC_SERVIZIO="+ 		data_InventariProdotto.getDESC_SERVIZIO      () + "|" ;
                        strViewStateCostructor += "vsDESC_STATO="+ 				data_InventariPrestAgg.getDESC_STATO_ELEM    () + "|" ;
                        strViewStateCostructor += "vsDESC_PRODOTTO="+			data_InventariProdotto.getDESC_PRODOTTO      () + "|" ;
                        strViewStateCostructor += "vsDESC_COMPONENTE="+		data_InventariPrestAgg.getDESC_COMPONENTE    () + "|" ;
                        strViewStateCostructor += "vsDESC_PREST_AGG="+		data_InventariPrestAgg.getDESC_PREST_AGG     () + "|" ;
                        strViewStateCostructor += "vsDESC_CICLO="+ 				data_InventariPrestAgg.getDESCRIZIONE_CICLO  () + "|" ;

                  %>
                      <%--<TD class="text" style="CURSOR: hand" id="<%=i%>" name="<%=i%>" onclick="cambiaPrestAgg(viewStateDatiProd<%=i%>)">--%>
                      <TD class="text" style="CURSOR: hand" id="<%=i%>" name="<%=i%>" onclick="ONSALVA('istanza_dettaglio_prest_agg.jsp?SELECTED=<%=i%>&Istanza=<%=Code_Ist_Prod%>')">                      
                      <input type="hidden" id="viewStateDatiProd<%=i%>" name="viewStateDatiProd<%=i%>" value="<%=strViewStateCostructor%>">
                      <%=data_InventariPrestAgg.getCODE_ISTANZA_PREST_AGG()%>
                    </TD>
                  </TR>
                    <%}%>
                <%}%>
<!-- FINE   Visualizzazione Prodotto -->
<!-- INIZIO Visualizzazione Componente -->
              <TR bgcolor="#0A6B98" align="center">
                <TD class="white">
                  Componente
                </TD>
              </TR>
              <%
              //Caricamento delle componenti
              String objBgColor = StaticContext.bgColorRigaPariTabella;

                for (int i = 0;i < vct_InventariPrestAgg.size();i++){
                  if (objBgColor == StaticContext.bgColorRigaPariTabella) objBgColor = StaticContext.bgColorRigaDispariTabella;
                  else objBgColor = StaticContext.bgColorRigaPariTabella; 
                  data_InventariPrestAgg = (DB_InventPrest)vct_InventariPrestAgg.get(i);
                   /*MoS*/
                   //================================================================
                   if ( ctrlvct_InventariPrestAg != null){
                       ctrldata_InventariPrestAgg = null;
                       ctrldata_InventariPrestAgg = (DB_InventPrest)ctrlvct_InventariPrestAg.get(i) ;
 /*
 !(data_InventariPrestAgg.getCODE_SERVIZIO().equals(ctrldata_InventariPrestAgg.getCODE_SERVIZIO())) ||
                        !(data_InventariPrestAgg.getDESC_SERVIZIO().equals(ctrldata_InventariPrestAgg.getDESC_SERVIZIO())) ||
                        !(data_InventariPrestAgg.getCODE_ACCOUNT().equals(ctrldata_InventariPrestAgg.getCODE_ACCOUNT())) ||
                        !(data_InventariPrestAgg.getDESC_ACCOUNT().equals(ctrldata_InventariPrestAgg.getDESC_ACCOUNT())) ||
                        !(data_InventariPrestAgg.getCODE_OFFERTA().equals(ctrldata_InventariPrestAgg.getCODE_OFFERTA())) ||
                        !(data_InventariPrestAgg.getDESC_OFFERTA().equals(ctrldata_InventariPrestAgg.getDESC_OFFERTA())) ||
                        !(data_InventariPrestAgg.getCODE_PRODOTTO().equals(ctrldata_InventariPrestAgg.getCODE_PRODOTTO())) ||
                        !(data_InventariPrestAgg.getDESC_PRODOTTO().equals(ctrldata_InventariPrestAgg.getDESC_PRODOTTO())) ||
 */                       
           
                       if ( 
                        !(data_InventariPrestAgg.getCODE_COMPONENTE().equals(ctrldata_InventariPrestAgg.getCODE_COMPONENTE())) ||
                        !(data_InventariPrestAgg.getDESC_COMPONENTE().equals(ctrldata_InventariPrestAgg.getDESC_COMPONENTE())) ||
                        !(data_InventariPrestAgg.getTIPO_CAUSALE_ATT().equals(ctrldata_InventariPrestAgg.getTIPO_CAUSALE_ATT())) ||
                        !(data_InventariPrestAgg.getDATA_CESSAZ().equals(ctrldata_InventariPrestAgg.getDATA_CESSAZ())) ||
                        !(data_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT().equals(ctrldata_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT())) ||
                        !(data_InventariPrestAgg.getTIPO_CAUSALE_CES().equals(ctrldata_InventariPrestAgg.getTIPO_CAUSALE_CES())) ||
                        !(data_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES().equals(ctrldata_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES())) ||
                        !(data_InventariPrestAgg.getDATA_INIZIO_VALID().equals(ctrldata_InventariPrestAgg.getDATA_INIZIO_VALID())) ||
                        !(data_InventariPrestAgg.getDATA_FINE_VALID().equals(ctrldata_InventariPrestAgg.getDATA_FINE_VALID())) ||
                        !(data_InventariPrestAgg.getQNTA_VALO().equals(ctrldata_InventariPrestAgg.getQNTA_VALO())) ||
                        !(data_InventariPrestAgg.getDATA_INIZIO_FATRZ().equals(ctrldata_InventariPrestAgg.getDATA_INIZIO_FATRZ())) ||
                        !(data_InventariPrestAgg.getDATA_FINE_FATRZ().equals(ctrldata_InventariPrestAgg.getDATA_FINE_FATRZ())) ||
                        !(data_InventariPrestAgg.getDATA_DRO().equals(ctrldata_InventariPrestAgg.getDATA_DRO())) ||
                        !(data_InventariPrestAgg.getDATA_DIN().equals(ctrldata_InventariPrestAgg.getDATA_DIN())) ){
                              objBgColor=StaticContext.bgColorRigaPariErroreTabella ;
                        }
                   }
                   //================================================================
                  %>
                  <TR bgcolor="<%=objBgColor%>" align="center">
                <% if ( !data_InventariPrestAgg.getCODE_COMPONENTE().equals("") ) { %>
                  <% /* Memorizzazione delle anagrafiche */
                        strViewStateCostructor = "";
                        strViewStateCostructor += "vsCODE_INVENT="+ 							data_InventariPrestAgg.getCODE_INVENT()						+ "|";
                        strViewStateCostructor += "vsCODE_INVENT_RIF="+						data_InventariPrestAgg.getCODE_INVENT_RIF()        + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_ATT="+  				data_InventariPrestAgg.getTIPO_CAUSALE_ATT()       + "|";
                        strViewStateCostructor += "vsDATA_CESSAZ="+       				data_InventariPrestAgg.getDATA_CESSAZ()            + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_CES="+  				data_InventariPrestAgg.getTIPO_CAUSALE_CES()       + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_ATT_HD="+ 			data_InventariPrestAgg.getTIPO_CAUSALE_ATT_HD()    + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_CES_HD="+ 			data_InventariPrestAgg.getTIPO_CAUSALE_CES_HD()    + "|";
                        strViewStateCostructor += "vsCODE_STATO_ELEM="+		  			data_InventariPrestAgg.getCODE_STATO_ELEM()        + "|";
                        strViewStateCostructor += "vsCODE_ACCOUNT="+ 							data_InventariPrestAgg.getCODE_ACCOUNT()           + "|";
                        strViewStateCostructor += "vsCODE_OFFERTA="+ 							data_InventariPrestAgg.getCODE_OFFERTA()           + "|";
                        strViewStateCostructor += "vsCODE_SERVIZIO="+   					data_InventariPrestAgg.getCODE_SERVIZIO()          + "|";
                        strViewStateCostructor += "vsCODE_PRODOTTO="+   					data_InventariPrestAgg.getCODE_PRODOTTO()          + "|";
                        strViewStateCostructor += "vsCODE_COMPONENTE="+ 					data_InventariPrestAgg.getCODE_COMPONENTE()        + "|";
                        strViewStateCostructor += "vsCODE_PREST_AGG="+   					data_InventariPrestAgg.getCODE_PREST_AGG()         + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_PROD="+ 				data_InventariPrestAgg.getCODE_ISTANZA_PROD()      + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_COMPO="+  			data_InventariPrestAgg.getCODE_ISTANZA_COMPO()     + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_PREST_AGG="+  	data_InventariPrestAgg.getCODE_ISTANZA_PREST_AGG() + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_VALID="+ 				data_InventariPrestAgg.getDATA_INIZIO_VALID()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_VALID="+ 					data_InventariPrestAgg.getDATA_FINE_VALID()        + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_FATRZ="+					data_InventariPrestAgg.getDATA_INIZIO_FATRZ()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_FATRZ="+ 					data_InventariPrestAgg.getDATA_FINE_FATRZ()        + "|";
                        strViewStateCostructor += "vsCODE_ULTIMO_CICLO_FATRZ="+		data_InventariPrestAgg.getCODE_ULTIMO_CICLO_FATRZ()+ "|";
                        strViewStateCostructor += "vsDATA_FINE_NOL="+							data_InventariPrestAgg.getDATA_FINE_NOL()          + "|";
                        strViewStateCostructor += "vsDATA_CESSAZ="+								data_InventariPrestAgg.getDATA_CESSAZ()            + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_FATRB="+					data_InventariPrestAgg.getDATA_INIZIO_FATRB()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_FATRB="+						data_InventariPrestAgg.getDATA_FINE_FATRB()        + "|";
                        strViewStateCostructor += "vsQNTA_VALO="+									data_InventariPrestAgg.getQNTA_VALO()              + "|";
                        strViewStateCostructor += "vsTIPO_FLAG_CONG="+						data_InventariPrestAgg.getTIPO_FLAG_CONG()         + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_CREAZ="+					data_InventariPrestAgg.getCODE_UTENTE_CREAZ()      + "|";
                        strViewStateCostructor += "vsDATA_CREAZ="+								data_InventariPrestAgg.getDATA_CREAZ()             + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_MODIF="+					data_InventariPrestAgg.getCODE_UTENTE_MODIF()      + "|";
                        strViewStateCostructor += "vsDATA_MODIF="+								data_InventariPrestAgg.getDATA_MODIF()             + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_CREAZ_HD="+    	data_InventariPrestAgg.getCODE_UTENTE_CREAZ_HD()   + "|";
                        strViewStateCostructor += "vsDATA_CREAZ_HD="+ 						data_InventariPrestAgg.getDATA_CREAZ_HD()          + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_MODIF_HD="+     	data_InventariPrestAgg.getCODE_UTENTE_MODIF_HD()   + "|";
                        strViewStateCostructor += "vsDATA_MODIF_HD="+   					data_InventariPrestAgg.getDATA_MODIF_HD()          + "|";
                        strViewStateCostructor += "vsELAB_VALORIZ="+ 							data_InventariPrestAgg.getELAB_VALORIZ()           + "|";
                        strViewStateCostructor += "vsTIPO_FLAG_MIGRAZIONE="+			data_InventariPrestAgg.getTIPO_FLAG_MIGRAZIONE()   + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_NOL="+						data_InventariPrestAgg.getDATA_DIN()               + "|";
                        strViewStateCostructor += "vsDATA_RICEZ_ORDINE="+         data_InventariPrestAgg.getDATA_DRO()               + "|";
                        strViewStateCostructor += "vsIndice="+	              		i   + "|";

                         /* Selezione delle descrizioni*/
                        strViewStateCostructor += "vsDESC_CAUSALE_ATT="+	data_InventariPrestAgg.getDESC_TIPO_CAUSALE_ATT  () + "|" ;
                        strViewStateCostructor += "vsDESC_CAUSALE_CES="+  data_InventariPrestAgg.getDESC_TIPO_CAUSALE_CES  () + "|" ;
                        strViewStateCostructor += "vsDESC_ACCOUNT="+			data_InventariPrestAgg.getDESC_ACCOUNT           () + "|" ;
                        strViewStateCostructor += "vsDESC_OFFERTA="+ 			data_InventariPrestAgg.getDESC_OFFERTA           () + "|" ;
                        strViewStateCostructor += "vsDESC_SERVIZIO="+ 		data_InventariPrestAgg.getDESC_SERVIZIO          () + "|" ;
                        strViewStateCostructor += "vsDESC_STATO="+ 				data_InventariPrestAgg.getDESC_STATO_ELEM        () + "|" ;
                        strViewStateCostructor += "vsDESC_PRODOTTO="+			data_InventariPrestAgg.getDESC_PRODOTTO          () + "|" ;
                        strViewStateCostructor += "vsDESC_COMPONENTE="+		data_InventariPrestAgg.getDESC_COMPONENTE        () + "|" ;
                        strViewStateCostructor += "vsDESC_PREST_AGG="+		data_InventariPrestAgg.getDESC_PREST_AGG         () + "|" ;
                        strViewStateCostructor += "vsDESC_CICLO="+ 				data_InventariPrestAgg.getDESCRIZIONE_CICLO      () + "|" ;
                  %>
                      <TD class="text" style="CURSOR: hand" id="<%=i%>" name="<%=i%>" onclick="ONSALVA('istanza_dettaglio_prest_agg.jsp?SELECTED=<%=i%>&Istanza=<%=Code_Ist_Prod%>')">
                      <input type="hidden" id="viewStateDatiCompo<%=i%>" name="viewStateDatiCompo<%=i%>" value="<%=strViewStateCostructor%>">
                      <%=data_InventariPrestAgg.getCODE_ISTANZA_PREST_AGG()%>
                    </TD>
                    <%}%>
                  </TR>
                <%}%>
<!-- FINE   Visualizzazione componente -->
            </TABLE>
            </DIV>
          </TD><!--Frame destro-->
          <TD valign="top">
            <!--DIV!-->

            <!-- DATI COMUNI -->
            <TABLE ALIGN=center BORDER=1 WIDTH=800 HEIGHT=9>
              <tr>
                <TD class="text" width="109"> Servizio:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCodeServizio" name="srcCodeServizio" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="13">
                  <INPUT class="text" id="strDescServizio" name="strDescServizio" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Codice Account: </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCodeAccount" name="srcCodeAccount" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13">
                  <INPUT class="text" id="strDescAccount" name="strDescAccount" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Account" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Offerta:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCodeOfferta" name="srcCodeOfferta" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13">
                  <INPUT class="text" id="strDescOfferta" name="strDescOfferta" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Prodotto: </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strCodeProdotto" name="strCodeProdotto" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Prodotto" Update="false" size="13">
                  <INPUT class="text" id="strDescProdotto" name="strDescProdotto" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Prodotto" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Componente: </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strCodeComponente" name="strCodeComponente" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Componente" Update="false" size="13">
                  <INPUT class="text" id="strDescComponente" name="strDescComponente" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Componente" Update="false" size="35">
                </TD>
              </tr>
            </table>
            <!-- FINE DATI COMUNI -->
            <br>
            <!-- PRESTAZIONE AGGIUNTIVA -->
            <TABLE ALIGN=center BORDER=1 WIDTH=800 HEIGHT=9>
              <tr>
                <TD class="text" width="109"> Prestazione Aggiuntiva: </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strCodePrestAgg" name="strCodePrestAgg" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Prestazione" Update="false" size="13">
                  <INPUT class="text" id="strDescPrestAgg" name="strDescPrestAgg" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Prestazione" Update="false" size="35">
                  <input class="text" title="Selezione Prestazione Aggiuntiva" type="button" maxlength="30" name="cmdPrestazione" value="..." onClick="click_cmdPrestazione();">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Ciclo Valorizzazione:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCicloVal" name="srcCicloVal" readonly obbligatorio="si" tipocontrollo="intero" label="Ciclo Val" Update="false" size="13">
                  <INPUT class="text" id="strDescCiclo" name="strDescCiclo" readonly obbligatorio="si" tipocontrollo="intero" label="Ciclo Val" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Stato:      </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCodeStato" name="srcCodeStato" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="13">
                  <INPUT class="text" id="strDescStato" name="strDescStato" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Casuale Attivazione:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strTipoCausaleAtt" name="strTipoCausaleAtt" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="13">
                  <INPUT class="text" id="strDescCausaleAtt" name="strDescCausaleAtt" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="35">
                </TD>
              </tr>
                <TR>
              <TD class="text"> Data Cessazione :  </TD>
              <TD colspan =3 >
              <INPUT class="text" id="strDataCessazPrest" name="strDataCessazPrest" readonly obbligatorio="si" tipocontrollo="data" label="Data Cessazione" Update="false" size="13">
              <a href="javascript:showCalendar('frmDati.strDataCessazPrest','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDCE" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataCessazPrest);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDCE" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
             </TD>     
            
           </TR>
              <tr>
                <TD class="text" width="109"> Causale Cessazione:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strTipoCausaleCes" name="strTipoCausaleCes" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13">
                  <INPUT class="text" id="strDescCausaleCes" name="strDescCausaleCes" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Data Fine Noleggio:  </TD>
                <TD width="153">
                  <INPUT class="text" id="strDataFineNol" name="strDataFineNol" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13">
                </TD>
                <TD class="text" width="159"> Distanza/Capacità:   </TD>
                <TD>
                  <INPUT class="text" id="srcQNTA" name="srcQNTA"  obbligatorio="si" tipocontrollo="intero" label="Qnta Valo" Update="false" size="13" maxlength="11">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Data Inizio Fatturazione:  </TD>
                <TD width="153">
                  <INPUT class="text" id="srcDIF" name="srcDIF" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Fatrz" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.srcDIF','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.srcDIF);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
                <TD class="text" width="159"> Data Fine Fatturazione:  </TD>
                <TD>
                  <INPUT class="text" id="strDataFineFatrz" name="strDataFineFatrz" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Fatrz" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataFineFatrz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDFF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataFineFatrz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Data Inizio Validita:  </TD>
                <TD width="153">
                  <INPUT class="text" id="strDataInizioValid" name="strDataInizioValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Validita" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataInizioValid','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIV" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataInizioValid);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIV" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
                <TD class="text" width="159"> Data Fine Validita:  </TD>
                <TD>
                  <INPUT class="text" id="strDataFineValid" name="strDataFineValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Validita" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataFineValid','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDFV" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataFineValid);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFV" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
              </tr>
              <TR>
                <TD class="text"> Data Creazione :  </TD>
                <TD>
                  <INPUT class="text" id="strDataCreaz" name="strDataCreaz" readonly obbligatorio="si" tipocontrollo="data" label="Data Creaz" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataCreaz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDataCreaz" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataCreaz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDataCreaz" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
                <TD class="text"> Data Inizio Noleggio :  </TD>
                <TD>
                  <INPUT class="text" id="strDataInizioNol" name="strDataInizioNol" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Noleggio" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataInizioNol','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIN" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataInizioNol);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIN" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>             
              </TR>
              <TR>
                <TD class="text"> Data Ricezione Ordine :  </TD>
                <TD>
                  <INPUT class="text" id="strDataRicezOrdine" name="strDataRicezOrdine" readonly obbligatorio="si" tipocontrollo="data" label="Data Ricezione Ordine" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataRicezOrdine','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDRO" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataRicezOrdine);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDRO" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>             
              </TR>
            </table>
          </TD>
          <!--/DIV!-->
        </TR>
      </TABLE>
    </TD>
  </TR>
     
  <TR>
    <TD colspan="4">
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
</FORM>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  caricaDati();
  DisabilitaPrestAgg();
</SCRIPT>

<%
       

}
  else { /*Aggiornamento*/
      String elemSelected = Misc.nh(request.getParameter("elementoSelezionato"));
      if(elemSelected.equals("")){
        System.out.println("Nessuna prestazione aggiuntiva");
      }else{
        elementoSelezionato = Integer.parseInt(elemSelected);

        data_InventariPrestAgg = (DB_InventPrest)vct_InventariPrestAgg.get(elementoSelezionato);
        
        System.out.println("ABILITAMODIFICHE ["+Misc.nh(request.getParameter("abilitaModifiche"))+"]");
        if(Misc.nh(request.getParameter("abilitaModifiche")).equals("1")){
          data_InventariPrestAgg.Modifica();
          session.setAttribute("ableCreaEvento", "1");          
        }else{
          data_InventariPrestAgg.annullaModifica();
        }

        data_InventariPrestAgg.setCODE_SERVIZIO    (Misc.nh(request.getParameter("srcCodeServizio")));
        data_InventariPrestAgg.setDESC_SERVIZIO    (Misc.nh(request.getParameter("strDescServizio")));
        data_InventariPrestAgg.setCODE_ACCOUNT     (Misc.nh(request.getParameter("srcCodeAccount")));
        data_InventariPrestAgg.setDESC_ACCOUNT     (Misc.nh(request.getParameter("strDescAccount")));
        data_InventariPrestAgg.setCODE_OFFERTA     (Misc.nh(request.getParameter("srcCodeOfferta")));
        data_InventariPrestAgg.setDESC_OFFERTA     (Misc.nh(request.getParameter("strDescOfferta")));
        data_InventariPrestAgg.setCODE_PRODOTTO    (Misc.nh(request.getParameter("strCodeProdotto")));
        data_InventariPrestAgg.setDESC_PRODOTTO    (Misc.nh(request.getParameter("strDescProdotto")));
        data_InventariPrestAgg.setCODE_COMPONENTE  (Misc.nh(request.getParameter("strCodeComponente")));
        data_InventariPrestAgg.setDESC_COMPONENTE  (Misc.nh(request.getParameter("strDescComponente")));
        data_InventariPrestAgg.setCODE_PREST_AGG   (Misc.nh(request.getParameter("strCodePrestAgg")));
        data_InventariPrestAgg.setDESC_PREST_AGG   (Misc.nh(request.getParameter("strDescPrestAgg")));
        data_InventariPrestAgg.setTIPO_CAUSALE_ATT (Misc.nh(request.getParameter("strTipoCausaleAtt")));
        data_InventariPrestAgg.setDATA_CESSAZ      (Misc.nh(request.getParameter("strDataCessazPrest")));
        data_InventariPrestAgg.setTIPO_CAUSALE_CES (Misc.nh(request.getParameter("strTipoCausaleCes")));
        data_InventariPrestAgg.setDESC_TIPO_CAUSALE_ATT(Misc.nh(request.getParameter("strDescCausaleAtt")));
        data_InventariPrestAgg.setDESC_TIPO_CAUSALE_CES (Misc.nh(request.getParameter("strDescCausaleCes")));
        data_InventariPrestAgg.setQNTA_VALO         (Misc.nh(request.getParameter("srcQNTA")));
        data_InventariPrestAgg.setDATA_INIZIO_FATRZ(Misc.nh(request.getParameter("srcDIF")));
        //QS 21/05/2008: Nel passaggio da componente a prest_agg si perdeva il valore di strDataFineFatrz
        data_InventariPrestAgg.setDATA_FINE_FATRZ  (Misc.nh(request.getParameter("strDataFineFatrz")));
        data_InventariPrestAgg.setDATA_DIN         (Misc.nh(request.getParameter("strDataInizioNol")));
        data_InventariPrestAgg.setDATA_DRO         (Misc.nh(request.getParameter("strDataRicezOrdine")));
        
        
      }

      session.setAttribute("hidTypeLoadPrestAgg", "1");
      
      //String pagina_destinazione = request.getParameter("paginaDestinazione");
      String pagina_destinazione = request.getParameter("paginaDestinazione")+"&Servizio="+Code_Servizio+"&CodeCausale="+Code_Causale+"&Istanza"+Code_Ist_Prod;
      
      response.sendRedirect(pagina_destinazione);
  }
%>
</body>
</html>