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
<%=StaticMessages.getMessage(3006,"istanza_dettaglio_anagrafico_2.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>

<%
  int Code_Offerta = 0;
  int Code_Prodotto = 0;

  String strViewStateCostructor = "";

  String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));
  String Code_Ist_Prod = Misc.nh(request.getParameter("Istanza"));
  String Code_Servizio = Misc.nh(request.getParameter("Servizio"));
  String strEnableRettifica = (String) session.getAttribute("elemNonModif");
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
  
  String strtypeLoad;

  strtypeLoad = Misc.nh(request.getParameter("hidTypeLoadMP"));
  if ( strtypeLoad.equals("") )
      strtypeLoad = (String)session.getAttribute("hidTypeLoadMP");

//GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector vct_InventariAnag = null;
  Vector ctrlvct_InventariAnag = null;
  
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0) {
    vct_InventariAnag = (Vector) session.getAttribute("vct_InventariAnag");
    ctrlvct_InventariAnag = (Vector) session.getAttribute("ctrlvct_InventariAnag");
  }
  else
  {
    vct_InventariAnag =  remoteEnt_Inventari.getInventarioAnagraficoMP(Code_Ist_Prod);
           /*MoS */
    ctrlvct_InventariAnag =  remoteEnt_Inventari.getInventarioAnagraficoMP(Code_Ist_Prod);
    if (vct_InventariAnag!=null) {
      session.setAttribute("vct_InventariAnag", vct_InventariAnag);
      session.setAttribute("ctrlvct_InventariAnag", ctrlvct_InventariAnag);
      session.setAttribute("hidTypeLoadMP", "1");
    }
  }
//FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int elementoSelezionato;
  DB_Invent_MP data_InventariAnag = null;
  DB_Invent_MP ctrldata_InventariAnag = null; 
  
   String strparsrcDescSede1 = (String) session.getAttribute("parsrcDescSede1");

  
  /* Verifico se devo effettuare l'aggiornamento sul dato */
  if ( ( typeLoad == 0 )|| ( typeLoad == 1 ) ) {
    elementoSelezionato = selected; 
    data_InventariAnag = (DB_Invent_MP)vct_InventariAnag.get(elementoSelezionato);
  

  String strEnableCreaEvento = (String) session.getAttribute("ableCreaEvento");
  if ( strEnableCreaEvento == null )  session.setAttribute("ableCreaEvento", "0");

  //Controllo le abilitazione dell'upd e del del
  boolean EnableUpd = true;
  boolean EnableDel = true;

  String URLParam = "?Istanza=" + Code_Ist_Prod + "&Servizio=" + Code_Servizio;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Inventario Anagrafico ( Servizio Multi - Punto )
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

  function ONCHIUDI(){
    window.close();	
  }

  function ableCreaEvento () {
    <% if ( strEnableCreaEvento.equals("1") ) { %>
      Enable ( frmDati.CREAEVENTO );
      Enable ( frmDati.ANNULLAMODIFICHE);
    <% } %>
  }

  function ONSALVA(pagina) {
    var Errore = 0;
    ONRETTIFICA_SALVA();
    if (Errore == 0) {
      objForm.hidTypeLoadMP.value = '2';
      objForm.paginaDestinazione.value = pagina;
      objForm.submit();
      DisabilitaAnagrafica();
      return true;
    }
  }

  function ONANNULLAMODIFICHE() {
      frmDati.hidTypeLoadMP.value = '0';
      frmDati.submit();
  }  

  function cambiaAnagrafica ( obj ) {

    if ( '0' == frmDati.LinkAbilitato.value ) {
        return;
    } 
    else {
      if ( frmDati.srcDescNumOrdineCliente.disabled == false ) 
        alert ('\t\t\t\tAttenzione!!!\n\n\nLe modifiche effettuate sui campi andranno perse..\nQuando si intende modificare i dati prima di effetuare il cambio di Elemento, a fine modifica cliccare sul pulsante SALVA ');

      visualizzaAnagrafica ( obj );
    }
  }

  function visualizzaAnagrafica( obj ) {

      var getTab;
      frmDati.srcDescNumOrdineCliente.value       = getVS ( obj , "vsDESC_NUM_ORDINE_CLIENTE" );
      frmDati.srcDescNumOrdineClienteCessaz.value = getVS ( obj , "vsDESC_NUM_ORDINE_CLIENTE_CESSAZ" );
      frmDati.srcDescTipoRete.value               = getVS ( obj , "vsDESC_TIPO_RETE" );
      frmDati.srcDescSede1.value                  = getVS ( obj , "vsDESC_SEDE_1" );
      frmDati.srcDescImpiantoSede1.value          = getVS ( obj , "vsDESC_IMPIANTO_SEDE_1" );
      frmDati.srcDescComuneSede1.value            = getVS ( obj , "vsDESC_COMUNE_SEDE_1" );
      frmDati.srcDescProvinciaSede1.value         = getVS ( obj , "vsDESC_PROVINCIA_SEDE_1" );        
      frmDati.srcDescDtrtSede1.value              = getVS ( obj , "vsDESC_DTRT_SEDE_1" );
      frmDati.srcDescCentraleSede1.value          = getVS ( obj , "vsDESC_CENTRALE_SEDE_1" );


      frmDati.srcDescSede2.value                  = getVS ( obj , "vsDESC_SEDE_2" );
      frmDati.srcDescImpiantoSede2.value          = getVS ( obj , "vsDESC_IMPIANTO_SEDE_2" );
      frmDati.srcDescComuneSede2.value            = getVS ( obj , "vsDESC_COMUNE_SEDE_2" );
      frmDati.srcDescProvinciaSede2.value         = getVS ( obj , "vsDESC_PROVINCIA_SEDE_2" );         
      frmDati.srcDescDtrtSede2.value              = getVS ( obj , "vsDESC_DTRT_SEDE_2" );
      frmDati.srcDescCentraleSede2.value          = getVS ( obj , "vsDESC_CENTRALE_SEDE_2" );
      frmDati.strElemento.value                   = getVS ( obj , "vsCODE_ELEMENTO" );
      
      
      
      
      frmDati.elementoSelezionato.value           = getVS ( obj , "vsIndice" );
      getTab                                      = getVS ( obj , "vsGetTab" );

      if ( getTab == 'P' ) {
             Enable(frmDati.RETTIFICA);
      } else {
          <%if ( strEnableRettifica.equals("1") ) {%>
             Disable(frmDati.RETTIFICA);
          <%} else {%>
             Enable(frmDati.RETTIFICA);
          <%}%>
      }
      DisabilitaAnagrafica ();
  }

  function caricaDati(){

      var str_Tipo_Elemento ;

      frmDati.LinkAbilitato.value = '1';
      frmDati.elementoSelezionato.value           = '<%=elementoSelezionato%>';
      frmDati.srcDescNumOrdineCliente.value       = '<%=data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE()%>';
      frmDati.srcDescNumOrdineClienteCessaz.value = '<%=data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ()%>';

      frmDati.srcDescTipoRete.value               = '<%=data_InventariAnag.getDESC_TIPO_RETE()%>';
      
      frmDati.srcDescSede1.value                  = '<%=data_InventariAnag.getDESC_SEDE_1()%>';
  
      frmDati.srcDescImpiantoSede1.value          = '<%=data_InventariAnag.getDESC_IMPIANTO_SEDE_1()%>';
      frmDati.srcDescComuneSede1.value            = '<%=data_InventariAnag.getDESC_COMUNE_SEDE_1()%>';
      frmDati.srcDescProvinciaSede1.value         = '<%=data_InventariAnag.getDESC_PROVINCIA_SEDE_1()%>';         
      frmDati.srcDescDtrtSede1.value              = '<%=data_InventariAnag.getDESC_DTRT_SEDE_1()%>';
      frmDati.srcDescCentraleSede1.value          = '<%=data_InventariAnag.getDESC_CENTRALE_SEDE_1()%>';


      frmDati.srcDescSede2.value                  = '<%=data_InventariAnag.getDESC_SEDE_2()%>';
      frmDati.srcDescImpiantoSede2.value          = '<%=data_InventariAnag.getDESC_IMPIANTO_SEDE_2()%>';
      frmDati.srcDescComuneSede2.value            = '<%=data_InventariAnag.getDESC_COMUNE_SEDE_2()%>';
      frmDati.srcDescProvinciaSede2.value         = '<%=data_InventariAnag.getDESC_PROVINCIA_SEDE_2()%>';         
      frmDati.srcDescDtrtSede2.value              = '<%=data_InventariAnag.getDESC_DTRT_SEDE_2()%>';
      frmDati.srcDescCentraleSede2.value          = '<%=data_InventariAnag.getDESC_CENTRALE_SEDE_2()%>';

      //Evidenza dell'elemento selezionato
      swapClass(frmDati.elementoSelezionato.value);
      frmDati.abilitaModifiche.value              = '<%=data_InventariAnag.eMODIFICATO()%>';      

      str_Tipo_Elemento                           = '<%=data_InventariAnag.getTAB()%>';

     if ( str_Tipo_Elemento == 'A' ) 
        frmDati.strElemento.value                   = '<%=data_InventariAnag.getPREST_AGG()%>';
     else if ( str_Tipo_Elemento == 'C' ) 
            frmDati.strElemento.value                   = '<%=data_InventariAnag.getCOMPO()%>';
          else
            frmDati.strElemento.value                   = '<%=data_InventariAnag.getPROD()%>';
     
	    <%if ( strEnableRettifica.equals("1") && !data_InventariAnag.getTAB().equals("P")) {%>
        Disable(frmDati.RETTIFICA);
      <%}%>

  }

   function ONRETTIFICA() {
      Enable ( frmDati.srcDescNumOrdineCliente );
      Enable ( frmDati.srcDescNumOrdineClienteCessaz );
      Enable ( frmDati.srcDescSede1 );
      Enable ( frmDati.srcDescSede2 );
      Enable ( frmDati.srcDescImpiantoSede1 );
      Enable ( frmDati.srcDescImpiantoSede2 );
      Enable ( frmDati.srcDescComuneSede1 );
      Enable ( frmDati.srcDescComuneSede2 );
      Enable ( frmDati.srcDescProvinciaSede1 );
      Enable ( frmDati.srcDescProvinciaSede2 );
      Enable ( frmDati.srcDescDtrtSede1 );
      Enable ( frmDati.srcDescDtrtSede2 );
      Enable ( frmDati.srcDescCentraleSede1 );
      Enable ( frmDati.srcDescCentraleSede2 );
      Enable ( frmDati.strElemento);
      Enable ( frmDati.srcDescTipoRete );
      //Enable ( frmDati.SALVA);
      Enable ( frmDati.CREAEVENTO);
      Enable ( frmDati.ANNULLAMODIFICHE);
      frmDati.abilitaModifiche.value = "1";
    }
    
    function ONRETTIFICA_SALVA() {
      Enable ( frmDati.srcDescNumOrdineCliente );
      Enable ( frmDati.srcDescNumOrdineClienteCessaz );
      Enable ( frmDati.srcDescSede1 );
      Enable ( frmDati.srcDescSede2 );
      Enable ( frmDati.srcDescImpiantoSede1 );
      Enable ( frmDati.srcDescImpiantoSede2 );
      Enable ( frmDati.srcDescComuneSede1 );
      Enable ( frmDati.srcDescComuneSede2 );
      Enable ( frmDati.srcDescProvinciaSede1 );
      Enable ( frmDati.srcDescProvinciaSede2 );
      Enable ( frmDati.srcDescDtrtSede1 );
      Enable ( frmDati.srcDescDtrtSede2 );
      Enable ( frmDati.srcDescCentraleSede1 );
      Enable ( frmDati.srcDescCentraleSede2 );
      Enable ( frmDati.strElemento);
      Enable ( frmDati.srcDescTipoRete );
      //Enable ( frmDati.SALVA);
    }  
    
  function DisabilitaAnagrafica () {

      Disable ( frmDati.srcDescNumOrdineCliente );
      Disable ( frmDati.srcDescNumOrdineClienteCessaz );
      Disable ( frmDati.srcDescSede1 );
      Disable ( frmDati.srcDescSede2 );
      Disable ( frmDati.srcDescImpiantoSede1 );
      Disable ( frmDati.srcDescImpiantoSede2 );
      Disable ( frmDati.srcDescComuneSede1 );
      Disable ( frmDati.srcDescComuneSede2 );
      Disable ( frmDati.srcDescProvinciaSede1 );
      Disable ( frmDati.srcDescProvinciaSede2 );
      Disable ( frmDati.srcDescDtrtSede1 );
      Disable ( frmDati.srcDescDtrtSede2 );
      Disable ( frmDati.srcDescCentraleSede1 );
      Disable ( frmDati.srcDescCentraleSede2 );
      //Disable ( frmDati.strElemento);
      Disable ( frmDati.srcDescTipoRete );
      //Disable ( frmDati.SALVA);
      Disable ( frmDati.CREAEVENTO);
      Disable ( frmDati.ANNULLAMODIFICHE);
      ableCreaEvento ();
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
    
        function annullaswapClass(td) {
        
      document.getElementById(td).className = 'text';
    }
    
      function segnalaPropaga(){
      if (frmDati.srcDescCentraleSede1.value != frmDati.srcDescCentraleSede1.title) {
      if (window.confirm('La variazione della Desc. Sede sarà propagata su tutte le anagrafiche collegate.'))
      {
         frmDati.hidTypeLoadDescSede.value=frmDati.srcDescCentraleSede1.value
        // alert(frmDati.hidTypeLoadDescSede.value);
      }
      }
    }
function AggiornaDescSede1(){
//alert('@' + frmDati.hidTypeLoadDescSede.value + '@');
if (frmDati.hidTypeLoadDescSede.value!='0'){
//alert('AggiornaDescSede1');
frmDati.srcDescCentraleSede1.value = frmDati.hidTypeLoadDescSede.value;
//alert('AggiornaDescSede1 ' + frmDati.hidTypeLoadDescSede.value);
}
}

function ChiudiCallParentWindowFunction()
{
//alert('ChiudiCallParentWindowFunction');
  setTimeout("window.opener.CallAlert(); window.close();",6000);
 
}    
</SCRIPT>
<body onLoad="Initialize();resizeTo(screen.width,screen.height)" onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()" >
    <FORM name="frmDati" id="frmDati" action="" method="post">
    <input type="hidden" name="hidTypeLoadMP" value="">
    <input type="hidden" name="paginaDestinazione" value="">
    <input type="hidden" name="abilitaModifiche" value="<%=strEnableCreaEvento%>">
    <input type="hidden" name="rettifica" value="0">
    <input type="hidden" name="elementoSelezionato" value="">
    <input type="hidden" name="hidTypeLoadDescSede" value="<%=strparsrcDescSede1%>">
    <input type="hidden" name="LinkAbilitato" value="">
    <input type="hidden" name="paginaSorgente" value="istanza_dettaglio_anagrafico_2.jsp?Istanza=<%=Code_Ist_Prod%>">    
    <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0"height="100%">
      <TR height="35">
          <TD>
             <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
             <TR>
              <TD align="left">
                <IMG alt="" src="../images/GeneratoreEventi.gif" border="0" width="266" height="35">
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
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('istanza_dettaglio_prest_agg.jsp<%=URLParam%>');">
                Prestazioni Aggiuntive
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorTabellaForm%>" class="blackB" width="150">
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
                  String strCodeIstanzaProd = null;

                    for (int i = 0;i < vct_InventariAnag.size();i++){
                      if (objBgColorProd == StaticContext.bgColorRigaPariTabella) objBgColorProd = StaticContext.bgColorRigaDispariTabella;
                      else objBgColorProd = StaticContext.bgColorRigaPariTabella; 
                      data_InventariAnag = (DB_Invent_MP)vct_InventariAnag.get(i);
                      strCodeIstanzaProd = data_InventariAnag.getPROD();
                                                  /*MoS*/
                   //================================================================
                   if ( ctrlvct_InventariAnag != null){
                       ctrldata_InventariAnag = null;
                       ctrldata_InventariAnag = (DB_Invent_MP)ctrlvct_InventariAnag.get(i) ;
                       if ( !(data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE().equals(ctrldata_InventariAnag.getDESC_NUM_ORDINE_CLIENTE())) ||
                        !(data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ().equals(ctrldata_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_TERMINAZIONE().equals(ctrldata_InventariAnag.getDESC_TIPO_TERMINAZIONE())) ||
                    //    !(data_InventariAnag.getDESC_FRAZIONAMENTO().equals(ctrldata_InventariAnag.getDESC_FRAZIONAMENTO())) ||
                        !(data_InventariAnag.getDESC_SEDE_1().equals(ctrldata_InventariAnag.getDESC_SEDE_1())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_RETE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_TIPO_RETE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_IMPIANTO_SEDE_1().equals(ctrldata_InventariAnag.getDESC_IMPIANTO_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_COMUNE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_COMUNE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_PROVINCIA_SEDE_1().equals(ctrldata_InventariAnag.getDESC_PROVINCIA_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_DTRT_SEDE_1().equals(ctrldata_InventariAnag.getDESC_DTRT_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_CENTRALE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_CENTRALE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_SEDE_2().equals(ctrldata_InventariAnag.getDESC_SEDE_2())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_RETE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_TIPO_RETE_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_IMPIANTO_SEDE_2().equals(ctrldata_InventariAnag.getDESC_IMPIANTO_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_COMUNE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_COMUNE_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_PROVINCIA_SEDE_2().equals(ctrldata_InventariAnag.getDESC_PROVINCIA_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_DTRT_SEDE_2().equals(ctrldata_InventariAnag.getDESC_DTRT_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_CENTRALE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_CENTRALE_SEDE_2())))
                        {
                              objBgColorProd=StaticContext.bgColorRigaPariErroreTabella ;
                        }
                   }
                   //================================================================
                      %>
                 
                    <% if ( data_InventariAnag.getTAB().equals("P") ) { %>
                      <TR bgcolor="<%=objBgColorProd%>" align="center">
                      <% /* Memorizzazione delle anagrafiche */
                           strViewStateCostructor = "";
                           strViewStateCostructor += "vsCODE_INVENT="                    + data_InventariAnag.getCODE_INVENT()                    + "|" ;
                           strViewStateCostructor += "vsDESC_NUM_ORDINE_CLIENTE="        + data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE()        + "|" ;
                           strViewStateCostructor += "vsDESC_NUM_ORDINE_CLIENTE_CESSAZ=" + data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ() + "|" ;
                           strViewStateCostructor += "vsDESC_TIPO_RETE="                 + data_InventariAnag.getDESC_TIPO_RETE()                 + "|" ;
                           strViewStateCostructor += "vsDESC_SEDE_1="                    + data_InventariAnag.getDESC_SEDE_1()                    + "|" ;
                           strViewStateCostructor += "vsDESC_IMPIANTO_SEDE_1="           + data_InventariAnag.getDESC_IMPIANTO_SEDE_1()           + "|" ;
                           strViewStateCostructor += "vsDESC_COMUNE_SEDE_1="             + data_InventariAnag.getDESC_COMUNE_SEDE_1()             + "|" ;
                           strViewStateCostructor += "vsDESC_PROVINCIA_SEDE_1="          + data_InventariAnag.getDESC_PROVINCIA_SEDE_1()          + "|" ;
                           strViewStateCostructor += "vsDESC_DTRT_SEDE_1="               + data_InventariAnag.getDESC_DTRT_SEDE_1()               + "|" ;
                           strViewStateCostructor += "vsDESC_CENTRALE_SEDE_1="           + data_InventariAnag.getDESC_CENTRALE_SEDE_1()           + "|" ;
                           strViewStateCostructor += "vsDESC_SEDE_2="                    + data_InventariAnag.getDESC_SEDE_2()                    + "|" ;
                           strViewStateCostructor += "vsDESC_IMPIANTO_SEDE_2="           + data_InventariAnag.getDESC_IMPIANTO_SEDE_2()           + "|" ;
                           strViewStateCostructor += "vsDESC_COMUNE_SEDE_2="             + data_InventariAnag.getDESC_COMUNE_SEDE_2()             + "|" ;
                           strViewStateCostructor += "vsDESC_PROVINCIA_SEDE_2="          + data_InventariAnag.getDESC_PROVINCIA_SEDE_2()          + "|" ;
                           strViewStateCostructor += "vsDESC_DTRT_SEDE_2="               + data_InventariAnag.getDESC_DTRT_SEDE_2()               + "|" ;
                           strViewStateCostructor += "vsDESC_CENTRALE_SEDE_2="           + data_InventariAnag.getDESC_CENTRALE_SEDE_2()           + "|" ;
                           strViewStateCostructor += "vsCODE_ELEMENTO="                  + data_InventariAnag.getPROD()                           + "|" ;
                           strViewStateCostructor += "vsIndice="                         + i                                                      + "|";
                           strViewStateCostructor += "vsGetTab="                         + data_InventariAnag.getTAB()                            + "|" ;

                      %>
                          <TD class="text" style="CURSOR: hand" id="<%=i%>" name="<%=i%>" onclick="ONSALVA('istanza_dettaglio_anagrafico_2.jsp?SELECTED=<%=i%>&Istanza=<%=Code_Ist_Prod%>&Servizio=<%=Code_Servizio%>')">
                          <input type="hidden" id="viewStateDatiProd<%=i%>" name="viewStateDatiProd<%=i%>" value="<%=strViewStateCostructor%>">
                          <%=strCodeIstanzaProd%>
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
                  String strCodeIstanzaCompo = null;

                    for (int i = 0;i < vct_InventariAnag.size();i++){
                      if (objBgColor == StaticContext.bgColorRigaPariTabella) objBgColor = StaticContext.bgColorRigaDispariTabella;
                      else objBgColor = StaticContext.bgColorRigaPariTabella; 
                      data_InventariAnag = (DB_Invent_MP)vct_InventariAnag.get(i);
                      strCodeIstanzaCompo = data_InventariAnag.getCOMPO();
                                                                        /*MoS*/
                   //================================================================
                   if ( ctrlvct_InventariAnag != null){
                           ctrldata_InventariAnag = null;
                       ctrldata_InventariAnag = (DB_Invent_MP)ctrlvct_InventariAnag.get(i) ;
                       if ( !(data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE().equals(ctrldata_InventariAnag.getDESC_NUM_ORDINE_CLIENTE())) ||
                        !(data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ().equals(ctrldata_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_TERMINAZIONE().equals(ctrldata_InventariAnag.getDESC_TIPO_TERMINAZIONE())) ||
                    //    !(data_InventariAnag.getDESC_FRAZIONAMENTO().equals(ctrldata_InventariAnag.getDESC_FRAZIONAMENTO())) ||
                        !(data_InventariAnag.getDESC_SEDE_1().equals(ctrldata_InventariAnag.getDESC_SEDE_1())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_RETE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_TIPO_RETE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_IMPIANTO_SEDE_1().equals(ctrldata_InventariAnag.getDESC_IMPIANTO_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_COMUNE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_COMUNE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_PROVINCIA_SEDE_1().equals(ctrldata_InventariAnag.getDESC_PROVINCIA_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_DTRT_SEDE_1().equals(ctrldata_InventariAnag.getDESC_DTRT_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_CENTRALE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_CENTRALE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_SEDE_2().equals(ctrldata_InventariAnag.getDESC_SEDE_2())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_RETE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_TIPO_RETE_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_IMPIANTO_SEDE_2().equals(ctrldata_InventariAnag.getDESC_IMPIANTO_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_COMUNE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_COMUNE_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_PROVINCIA_SEDE_2().equals(ctrldata_InventariAnag.getDESC_PROVINCIA_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_DTRT_SEDE_2().equals(ctrldata_InventariAnag.getDESC_DTRT_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_CENTRALE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_CENTRALE_SEDE_2())))
                        {
                              objBgColor=StaticContext.bgColorRigaPariErroreTabella ;
                        }
                   }
                   //================================================================
                      %>
                    <% if ( data_InventariAnag.getTAB().equals("C") ) { %>
                      <TR bgcolor="<%=objBgColor%>" align="center">
                      <% /* Memorizzazione delle anagrafiche */
                           strViewStateCostructor = "";
                           strViewStateCostructor += "vsCODE_INVENT="                    + data_InventariAnag.getCODE_INVENT()                    + "|" ;
                           strViewStateCostructor += "vsDESC_NUM_ORDINE_CLIENTE="        + data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE()        + "|" ;
                           strViewStateCostructor += "vsDESC_NUM_ORDINE_CLIENTE_CESSAZ=" + data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ() + "|" ;
                           strViewStateCostructor += "vsDESC_TIPO_RETE="                 + data_InventariAnag.getDESC_TIPO_RETE()                 + "|" ;
                           strViewStateCostructor += "vsDESC_SEDE_1="                    + data_InventariAnag.getDESC_SEDE_1()                    + "|" ;
                           strViewStateCostructor += "vsDESC_IMPIANTO_SEDE_1="           + data_InventariAnag.getDESC_IMPIANTO_SEDE_1()           + "|" ;
                           strViewStateCostructor += "vsDESC_COMUNE_SEDE_1="             + data_InventariAnag.getDESC_COMUNE_SEDE_1()             + "|" ;
                           strViewStateCostructor += "vsDESC_PROVINCIA_SEDE_1="          + data_InventariAnag.getDESC_PROVINCIA_SEDE_1()          + "|" ;
                           strViewStateCostructor += "vsDESC_DTRT_SEDE_1="               + data_InventariAnag.getDESC_DTRT_SEDE_1()               + "|" ;
                           strViewStateCostructor += "vsDESC_CENTRALE_SEDE_1="           + data_InventariAnag.getDESC_CENTRALE_SEDE_1()           + "|" ;
                           strViewStateCostructor += "vsDESC_SEDE_2="                    + data_InventariAnag.getDESC_SEDE_2()                    + "|" ;
                           strViewStateCostructor += "vsDESC_IMPIANTO_SEDE_2="           + data_InventariAnag.getDESC_IMPIANTO_SEDE_2()           + "|" ;
                           strViewStateCostructor += "vsDESC_COMUNE_SEDE_2="             + data_InventariAnag.getDESC_COMUNE_SEDE_2()             + "|" ;
                           strViewStateCostructor += "vsDESC_PROVINCIA_SEDE_2="          + data_InventariAnag.getDESC_PROVINCIA_SEDE_2()          + "|" ;
                           strViewStateCostructor += "vsDESC_DTRT_SEDE_2="               + data_InventariAnag.getDESC_DTRT_SEDE_2()               + "|" ;
                           strViewStateCostructor += "vsDESC_CENTRALE_SEDE_2="           + data_InventariAnag.getDESC_CENTRALE_SEDE_2()           + "|" ;
                           strViewStateCostructor += "vsCODE_ELEMENTO="                  + data_InventariAnag.getCOMPO()                          + "|" ;
                           strViewStateCostructor += "vsIndice="                         + i                                                      + "|" ;
                           strViewStateCostructor += "vsGetTab="                         + data_InventariAnag.getTAB()                            + "|" ;
                      %>
                          <TD class="text" style="CURSOR: hand" id="<%=i%>" name="<%=i%>" onclick="ONSALVA('istanza_dettaglio_anagrafico_2.jsp?SELECTED=<%=i%>&Istanza=<%=Code_Ist_Prod%>&Servizio=<%=Code_Servizio%>')">
                          <input type="hidden" id="viewStateDatiCompo<%=i%>" name="viewStateDatiCompo<%=i%>" value="<%=strViewStateCostructor%>">
                          <%=strCodeIstanzaCompo%>
                        </TD>
                        <%}%>
                      </TR>
                    <%}%>
<!-- FINE   Visualizzazione componente -->
<!-- INIZIO Visualizzazione Prestazioni Aggiuntive -->
                  <TR bgcolor="#0A6B98" align="center">
                    <TD class="white">
                      Prestazioni Aggiuntive
                    </TD>
                  </TR>
                  <%
                  //Caricamento dei Prodotti
                  String objBgColorPrest = StaticContext.bgColorRigaPariTabella;
                  String strCodeIstanzaPrestAgg = null;

                    for (int i = 0;i < vct_InventariAnag.size();i++){
                      if (objBgColorPrest == StaticContext.bgColorRigaPariTabella) objBgColorPrest = StaticContext.bgColorRigaDispariTabella;
                      else objBgColorPrest = StaticContext.bgColorRigaPariTabella; 
                      data_InventariAnag = (DB_Invent_MP)vct_InventariAnag.get(i);
                      strCodeIstanzaPrestAgg = data_InventariAnag.getPREST_AGG();
                                                                                              /*MoS*/
                   //================================================================
                   if ( ctrlvct_InventariAnag != null){
                           ctrldata_InventariAnag = null;
                       ctrldata_InventariAnag = (DB_Invent_MP)ctrlvct_InventariAnag.get(i) ;
                       if ( !(data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE().equals(ctrldata_InventariAnag.getDESC_NUM_ORDINE_CLIENTE())) ||
                        !(data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ().equals(ctrldata_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_TERMINAZIONE().equals(ctrldata_InventariAnag.getDESC_TIPO_TERMINAZIONE())) ||
                    //    !(data_InventariAnag.getDESC_FRAZIONAMENTO().equals(ctrldata_InventariAnag.getDESC_FRAZIONAMENTO())) ||
                        !(data_InventariAnag.getDESC_SEDE_1().equals(ctrldata_InventariAnag.getDESC_SEDE_1())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_RETE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_TIPO_RETE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_IMPIANTO_SEDE_1().equals(ctrldata_InventariAnag.getDESC_IMPIANTO_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_COMUNE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_COMUNE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_PROVINCIA_SEDE_1().equals(ctrldata_InventariAnag.getDESC_PROVINCIA_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_DTRT_SEDE_1().equals(ctrldata_InventariAnag.getDESC_DTRT_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_CENTRALE_SEDE_1().equals(ctrldata_InventariAnag.getDESC_CENTRALE_SEDE_1())) ||
                        !(data_InventariAnag.getDESC_SEDE_2().equals(ctrldata_InventariAnag.getDESC_SEDE_2())) ||
                    //    !(data_InventariAnag.getDESC_TIPO_RETE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_TIPO_RETE_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_IMPIANTO_SEDE_2().equals(ctrldata_InventariAnag.getDESC_IMPIANTO_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_COMUNE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_COMUNE_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_PROVINCIA_SEDE_2().equals(ctrldata_InventariAnag.getDESC_PROVINCIA_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_DTRT_SEDE_2().equals(ctrldata_InventariAnag.getDESC_DTRT_SEDE_2())) ||
                        !(data_InventariAnag.getDESC_CENTRALE_SEDE_2().equals(ctrldata_InventariAnag.getDESC_CENTRALE_SEDE_2())))
                        {
                              objBgColorPrest=StaticContext.bgColorRigaPariErroreTabella ;
                        }
                   }
                   //================================================================
                      %>
                    <% if ( data_InventariAnag.getTAB().equals("A") ) { %>
                      <TR bgcolor="<%=objBgColorPrest%>" align="center">
                      <% /* Memorizzazione delle anagrafiche */
                           strViewStateCostructor = "";
                           strViewStateCostructor += "vsCODE_INVENT="                    + data_InventariAnag.getCODE_INVENT()                    + "|" ;
                           strViewStateCostructor += "vsDESC_NUM_ORDINE_CLIENTE="        + data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE()        + "|" ;
                           strViewStateCostructor += "vsDESC_NUM_ORDINE_CLIENTE_CESSAZ=" + data_InventariAnag.getDESC_NUM_ORDINE_CLIENTE_CESSAZ() + "|" ;
                           strViewStateCostructor += "vsDESC_TIPO_RETE="                 + data_InventariAnag.getDESC_TIPO_RETE()                 + "|" ;
                           strViewStateCostructor += "vsDESC_SEDE_1="                    + data_InventariAnag.getDESC_SEDE_1()                    + "|" ;
                           strViewStateCostructor += "vsDESC_IMPIANTO_SEDE_1="           + data_InventariAnag.getDESC_IMPIANTO_SEDE_1()           + "|" ;
                           strViewStateCostructor += "vsDESC_COMUNE_SEDE_1="             + data_InventariAnag.getDESC_COMUNE_SEDE_1()             + "|" ;
                           strViewStateCostructor += "vsDESC_PROVINCIA_SEDE_1="          + data_InventariAnag.getDESC_PROVINCIA_SEDE_1()          + "|" ;
                           strViewStateCostructor += "vsDESC_DTRT_SEDE_1="               + data_InventariAnag.getDESC_DTRT_SEDE_1()               + "|" ;
                           strViewStateCostructor += "vsDESC_CENTRALE_SEDE_1="           + data_InventariAnag.getDESC_CENTRALE_SEDE_1()           + "|" ;
                           strViewStateCostructor += "vsDESC_SEDE_2="                    + data_InventariAnag.getDESC_SEDE_2()                    + "|" ;
                           strViewStateCostructor += "vsDESC_IMPIANTO_SEDE_2="           + data_InventariAnag.getDESC_IMPIANTO_SEDE_2()           + "|" ;
                           strViewStateCostructor += "vsDESC_COMUNE_SEDE_2="             + data_InventariAnag.getDESC_COMUNE_SEDE_2()             + "|" ;
                           strViewStateCostructor += "vsDESC_PROVINCIA_SEDE_2="          + data_InventariAnag.getDESC_PROVINCIA_SEDE_2()          + "|" ;
                           strViewStateCostructor += "vsDESC_DTRT_SEDE_2="               + data_InventariAnag.getDESC_DTRT_SEDE_2()               + "|" ;
                           strViewStateCostructor += "vsDESC_CENTRALE_SEDE_2="           + data_InventariAnag.getDESC_CENTRALE_SEDE_2()           + "|" ;
                           strViewStateCostructor += "vsCODE_ELEMENTO="                  + data_InventariAnag.getPREST_AGG()                      + "|" ;
                           strViewStateCostructor += "vsIndice="                         + i                                                      + "|" ;
                           strViewStateCostructor += "vsGetTab="                         + data_InventariAnag.getTAB()                            + "|" ;
                           
                      %>
                          <TD class="text" style="CURSOR: hand" id="<%=i%>" name="<%=i%>" onclick="ONSALVA('istanza_dettaglio_anagrafico_2.jsp?SELECTED=<%=i%>&Istanza=<%=Code_Ist_Prod%>&Servizio=<%=Code_Servizio%>')">
                          <input type="hidden" id="viewStateDatiPrest<%=i%>" name="viewStateDatiPrest<%=i%>" value="<%=strViewStateCostructor%>">
                          <%=strCodeIstanzaPrestAgg%>
                        </TD>
                   </TR>
                        <%}%>
                    <%}%>
<!-- FINE Visualizzazione Prestazioni Aggiuntive -->  
                 </TABLE>
              </DIV>
            </TD><!--Frame destro-->
            <TD valign="top">
             <!--DIV!-->
      
      <TABLE ALIGN=center BORDER=1 WIDTH=90% HEIGHT=9 >
      <tr>
         <TD colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="center" width="682">
                <U>Elemento Selezionato : </U>
                <input class="textSel" title="strElemento" name="strElemento" readonly size="20">
          </TD>
      </tr>
        <tr>
            <TD class="text"> Numero Ordine Cliente:  </TD>
             <TD>
              <INPUT class="text" id="srcDescNumOrdineCliente" name="srcDescNumOrdineCliente" obbligatorio="si" tipocontrollo="intero" label="Numero Ordine Cliente" Update="false" size="40">
            </TD>
            <TD class="text"> Numero Ordine Cliente di Cessazione:   </TD>
             <TD>
              <INPUT class="text" id="srcDescNumOrdineClienteCessaz" name="srcDescNumOrdineClienteCessaz" obbligatorio="si" tipocontrollo="intero" label="Numero Ordine Cliente di Cessazione" Update="false" size="40">
            </TD>
        </tr>
        <tr>
            <TD colspan="2" class="text"> Descrizione Sede 1:  
              <INPUT class="text" id="srcDescSede1" name="srcDescSede1" obbligatorio="si" tipocontrollo="intero" label="Descrizione Sede 1" Update="false" size="60"  >
            </TD>
            <TD class="text"> Descrizione Tipo Rete:   </TD>
             <TD>
              <INPUT class="text" id="srcDescTipoRete" name="srcDescTipoRete" obbligatorio="si" tipocontrollo="intero" label="Descrizione Tipo Rete" Update="false" size="40">
            </TD>
        </tr>
        <tr>
            <TD colspan="4" class="text"> Descrizione Sede 2:   
              <INPUT class="text" id="srcDescSede2" name="srcDescSede2" obbligatorio="si" tipocontrollo="intero" label="Descrizione Sede 2" Update="false" size="100">
            </TD>
        </tr>
        <tr>
            <TD class="text"> Descrizione Impianto Sede 1:  </TD>
             <TD>
              <INPUT class="text" id="srcDescImpiantoSede1" name="srcDescImpiantoSede1" obbligatorio="si" tipocontrollo="intero" label="Descrizione Impianto Sede 1" Update="false" size="40">
            </TD>
            <TD class="text"> Descrizione Impianto Sede 2:   </TD>
             <TD>
              <INPUT class="text" id="srcDescImpiantoSede2" name="srcDescImpiantoSede2" obbligatorio="si" tipocontrollo="intero" label="Descrizione Impianto Sede 2" Update="false" size="40">
            </TD>
        </tr>
        <tr>
            <TD class="text"> Descrizione Comune Sede 1:  </TD>
             <TD>
              <INPUT class="text" id="srcDescComuneSede1" name="srcDescComuneSede1" obbligatorio="si" tipocontrollo="intero" label="Descrizione Comune Sede 1" Update="false" size="40">
            </TD>
            <TD class="text"> Descrizione Comune Sede 2:   </TD>
             <TD>
              <INPUT class="text" id="srcDescComuneSede2" name="srcDescComuneSede2" obbligatorio="si" tipocontrollo="intero" label="Descrizione Comune Sede 2" Update="false" size="40">
            </TD>
        </tr>
        <tr>
            <TD class="text"> Descrizione Provincia Sede 1:  </TD>
             <TD>
              <INPUT class="text" id="srcDescProvinciaSede1" name="srcDescProvinciaSede1" obbligatorio="si" tipocontrollo="intero" label="Descrizione Provincia Sede 1" Update="false" size="40">
            </TD>
            <TD class="text"> Descrizione Provincia Sede 2:   </TD>
             <TD>
              <INPUT class="text" id="srcDescProvinciaSede2" name="srcDescProvinciaSede2" obbligatorio="si" tipocontrollo="intero" label="Descrizione Provincia Sede 2" Update="false" size="40">
            </TD>
        </tr>
        <tr>
            <TD class="text"> Descrizione Dtrt Sede 1:  </TD>
             <TD>
              <INPUT class="text" id="srcDescDtrtSede1" name="srcDescDtrtSede1" obbligatorio="si" tipocontrollo="intero" label="Descrizione Dtrt Sede 1" Update="false" size="40">
            </TD>
            <TD class="text"> Descrizione Dtrt Sede 2:   </TD>
             <TD>
              <INPUT class="text" id="srcDescDtrtSede2" name="srcDescDtrtSede2" obbligatorio="si" tipocontrollo="intero" label="Descrizione Dtrt Sede 2" Update="false" size="40">
            </TD>
        </tr>
        <tr>
            <TD class="text"> Descrizione Centrale Sede 1:  </TD>
             <TD>
              <INPUT class="text" id="srcDescCentraleSede1" name="srcDescCentraleSede1" obbligatorio="si" tipocontrollo="intero" label="Descrizione Centrale Sede 1" Update="false" size="40" title="<%=data_InventariAnag.getDESC_CENTRALE_SEDE_1() %>" onchange="segnalaPropaga();">
            </TD>
            <TD class="text"> Descrizione Centrale Sede 2:   </TD>
             <TD>
              <INPUT class="text" id="srcDescCentraleSede2" name="srcDescCentraleSede2" obbligatorio="si" tipocontrollo="intero" label="Descrizione Centrale Sede 2" Update="false" size="40">
            </TD>
        </tr>
     </table>
            </TD>
             <!--/DIV!-->
      </TD>
     </TABLE>

        </TD>
      </TR>
     
      <TR>
        <TD colspan="4">
           <HR>
        </TD>
      </TR>

      <TR height="30">
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

<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  caricaDati();
  DisabilitaAnagrafica();
  AggiornaDescSede1();
</SCRIPT>
<%
}
  else { /*Aggiornamento*/
      elementoSelezionato = Integer.parseInt(Misc.nh(request.getParameter("elementoSelezionato")));
      data_InventariAnag = (DB_Invent_MP)vct_InventariAnag.get(elementoSelezionato);

      if(Misc.nh(request.getParameter("abilitaModifiche")).equals("1")){
        data_InventariAnag.Modifica();
        session.setAttribute("ableCreaEvento", "1");
      }else{
        data_InventariAnag.annullaModifica();
      }
      
               %>  
 <SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  AggiornaDescSede1();
</SCRIPT> 

 <%      

      
      
      data_InventariAnag.setDESC_NUM_ORDINE_CLIENTE        ( Misc.nh(request.getParameter("srcDescNumOrdineCliente")));
      data_InventariAnag.setDESC_NUM_ORDINE_CLIENTE_CESSAZ ( Misc.nh(request.getParameter("srcDescNumOrdineClienteCessaz")));
      data_InventariAnag.setDESC_TIPO_RETE                 ( Misc.nh(request.getParameter("srcDescTipoRete")));
      data_InventariAnag.setDESC_SEDE_1                    ( Misc.nh(request.getParameter("srcDescSede1")));
      data_InventariAnag.setDESC_IMPIANTO_SEDE_1           ( Misc.nh(request.getParameter("srcDescImpiantoSede1")));
      data_InventariAnag.setDESC_COMUNE_SEDE_1             ( Misc.nh(request.getParameter("srcDescComuneSede1")));
      data_InventariAnag.setDESC_PROVINCIA_SEDE_1          ( Misc.nh(request.getParameter("srcDescProvinciaSede1")));
      data_InventariAnag.setDESC_DTRT_SEDE_1               ( Misc.nh(request.getParameter("srcDescDtrtSede1")));
      data_InventariAnag.setDESC_CENTRALE_SEDE_1           ( Misc.nh(request.getParameter("srcDescCentraleSede1")));
      data_InventariAnag.setDESC_SEDE_2                    ( Misc.nh(request.getParameter("srcDescSede2")));
      data_InventariAnag.setDESC_IMPIANTO_SEDE_2           ( Misc.nh(request.getParameter("srcDescImpiantoSede2")));
      data_InventariAnag.setDESC_COMUNE_SEDE_2             ( Misc.nh(request.getParameter("srcDescComuneSede2")));
      data_InventariAnag.setDESC_PROVINCIA_SEDE_2          ( Misc.nh(request.getParameter("srcDescProvinciaSede2")));
      data_InventariAnag.setDESC_DTRT_SEDE_2               ( Misc.nh(request.getParameter("srcDescDtrtSede2")));
      data_InventariAnag.setDESC_CENTRALE_SEDE_2           ( Misc.nh(request.getParameter("srcDescCentraleSede2")));
      
      session.setAttribute("hidTypeLoadMP", "1");

       if (!request.getParameter("hidTypeLoadDescSede").equals('0')){
        session.setAttribute("parsrcDescSede1",request.getParameter("hidTypeLoadDescSede"));
      }

      vct_InventariAnag.setElementAt(data_InventariAnag,elementoSelezionato);
      
      String pagina_destinazione = request.getParameter("paginaDestinazione");
      response.sendRedirect(pagina_destinazione);
  }
%>
</FORM>
</body>
</html>
