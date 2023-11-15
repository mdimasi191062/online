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
<%=StaticMessages.getMessage(3006,"istanza_dettaglio_componenti.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>

<%
  int Code_Offerta = 0;
  int Code_Prodotto = 0;
  int CompoSel = 0;
  int elementoSelezionato;
  DB_InventCompo data_InventariCompo = null;
  DB_InventCompo ctrldata_InventariCompo = null;
  DB_InventProd data_InventariProdotto=null;



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

  strViewStateDati = Misc.nh(request.getParameter("viewStateDati"));
  
  String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));
  String Code_Ist_Prod = Misc.nh(request.getParameter("Istanza"));
  String Code_Servizio = Misc.nh(request.getParameter("Servizio"));

  String strtypeLoad;
  strtypeLoad = Misc.nh(request.getParameter("hidTypeLoadCompo"));
  if ( strtypeLoad.equals("") )
      strtypeLoad = Misc.nh((String)session.getAttribute("hidTypeLoadCompo"));

  String strEnableRettifica = (String) session.getAttribute("elemNonModif");

//GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector vct_InventariCompo = null;
  Vector vct_InventariProdotto = null;
  Vector ctrlvct_InventariCompo = null;
   Vector vPropagaCodeCompo= new Vector();
 
 
  vct_InventariProdotto = (Vector) session.getAttribute("vct_Inventari");
  data_InventariProdotto = (DB_InventProd)vct_InventariProdotto.get(0);
  
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0) {
    vct_InventariCompo = (Vector) session.getAttribute("vct_InventariCompo");
    ctrlvct_InventariCompo = (Vector) session.getAttribute("ctrlvct_InventariCompo");
    vPropagaCodeCompo = (Vector) session.getAttribute("vPropagaCodeCompo");
    //vct_InventariProdotto = (Vector) session.getAttribute("vct_Inventari");
  }
  else
  {
  
    vct_InventariCompo =  remoteEnt_Inventari.getInventarioComponenti(Code_Ist_Prod);
    /*MoS */
    ctrlvct_InventariCompo =  remoteEnt_Inventari.getInventarioComponenti(Code_Ist_Prod);
   

    if (vct_InventariCompo!=null) {
      session.setAttribute("vct_InventariCompo", vct_InventariCompo);
      session.setAttribute("ctrlvct_InventariCompo", ctrlvct_InventariCompo);
       session.setAttribute("vPropagaCodeCompo", vPropagaCodeCompo);
      session.setAttribute("hidTypeLoadCompo", "1");
    }
  }

//FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  
  String Code_Ist_Compo = "";

  /* Verifico se devo effettuare l'aggiornamento sul dato - INIZIO IF*/
  if ( ( typeLoad == 0 )|| ( typeLoad == 1 ) ) {
    elementoSelezionato = selected;


    if (vct_InventariCompo.size() != 0 ){
      data_InventariCompo = (DB_InventCompo)vct_InventariCompo.get(elementoSelezionato);
      
      Code_Ist_Compo = data_InventariCompo.getCODE_ISTANZA_COMPO();
      
        //==========================================================
  
  //MoS 16/11/2010
  //NEL CASO DI CESSAZIONE prendo data_cessaz
  //===========================================================
 /* if(  data_InventariCompo.getCODE_STATO_ELEM().equals("2") ) { 
     Vector vct_stInventProd = null;
     vct_stInventProd =  remoteEnt_Inventari.getstPrenvCompoxCessazione(Code_Ist_Prod,data_InventariCompo.getCODE_ISTANZA_COMPO());
     DB_InventProd data_stInventProd=null;
     data_stInventProd = (DB_InventProd)vct_stInventProd.get(0);
     data_InventariCompo.setDATA_CESSAZ (data_stInventProd.getDATA_CESSAZ());
  
  }
 */ 
  //===========================================================
    }
    
  
  

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
Inventario Componenti
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
<script src="<%=StaticContext.PH_COMMON_JS%>tree.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>css.js" type="text/javascript"></script>
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

  function ONCHIUDI(){
    window.close();	
  }

  function cambiaComponente ( obj ) {
  
    if ( '0' == frmDati.LinkAbilitato.value ) {
        return;
    } 
    else {
      if ( frmDati.srcCodeAccount.disabled == false ) 
        alert ('\t\t\t\tAttenzione!!!\n\n\nLe modifiche effettuate sui campi andranno perse..\nQuando si intende modificare i dati prima di effetuare il cambio di Elemento, a fine modifica cliccare sul pulsante SALVA ');

      visualizzaComponente ( obj );
    }
  }

  function cambiaComponenteSubmit( obj ) {
    
  }



  function ONSALVA(pagina) {
    ONRETTIFICA_SALVA();

    
    var Errore = 0;
    if(frmDati.abilitaModifiche.value == "1" && !frmDati.RETTIFICA.disabled){
      if (frmDati.srcCodeServizio.value == '') {
        Errore = 1;
        alert('Errore il servizio non è selezionato');
        return false;
      }
      if (frmDati.srcCodeAccount.value == '') {
        Errore = 1;
        alert('Errore account non è selezionato');
        return false;
      }
      if (frmDati.srcCodeOfferta.value == '') {
        Errore = 1;
        alert('Errore offerta non è selezionato');
        return false;
      }

      if (frmDati.strCodeProdotto.value == '') {
        Errore = 1;
        alert('Errore il prodotto non è selezionato');
        return false;
      }

      if (frmDati.strCodeComponente.value == '') {
        Errore = 1;
        alert('Errore la Componente non è selezionata');
        frmDati.strCodeComponente.focus();
        return false;
      }
    }
    //if (Errore == 0) {
      objForm.hidTypeLoadCompo.value = '2';
      frmDati.paginaDestinazione.value = pagina;
      objForm.submit();
      DisabilitaComponente();
      return true;
    //}
  }

  function visualizzaComponente(obj) {
      frmDati.srcCodeStato.value        = getVS ( obj , "vsCODE_STATO_ELEM" );
      frmDati.strCodeComponente.value   = getVS ( obj , "vsCODE_COMPONENTE" );
      frmDati.srcDIF.value              = getVS ( obj , "vsDATA_INIZIO_FATRZ" );
      frmDati.srcQNTA.value             = getVS ( obj , "vsQNTA_VALO" );
      frmDati.srcCicloVal.value         = getVS ( obj , "vsCODE_ULTIMO_CICLO_FATRZ" );
      frmDati.strDataFineFatrz.value    = getVS ( obj , "vsDATA_FINE_FATRZ" );
      frmDati.strTipoCausaleAtt.value   = getVS ( obj , "vsTIPO_CAUSALE_ATT" );
      frmDati.strDataCessaz.value       = getVS ( obj , "vsDATA_CESSAZ" );
      frmDati.strDataInizioValid.value  = getVS ( obj , "vsDATA_INIZIO_VALID" );
      frmDati.strDataFineValid.value    = getVS ( obj , "vsDATA_FINE_VALID" );
      frmDati.strTipoCausaleCes.value   = getVS ( obj , "vsTIPO_CAUSALE_CES" );
      frmDati.strDataFineNol.value      = getVS ( obj , "vsDATA_FINE_NOL" );
      frmDati.strDescStato.value        = getVS ( obj , "vsDESC_STATO" );
      frmDati.strDescCausaleAtt.value   = getVS ( obj , "vsDESC_CAUSALE_ATT" );
      frmDati.strDescCausaleCes.value   = getVS ( obj , "vsDESC_CAUSALE_CES" );
      frmDati.strDescCiclo.value        = getVS ( obj , "vsDESC_CICLO" );
      frmDati.strDescComponente.value   = getVS ( obj , "vsDESC_COMPONENTE" );
      frmDati.strIstanzaComponente.value= getVS ( obj , "vsCODE_ISTANZA_COMPO" );
      frmDati.strDataInizioNol.value    = getVS ( obj , "vsDATA_INIZIO_NOL" );
      frmDati.strDataRicezOrdine.value  = getVS ( obj , "vsDATA_RICEZ_ORDINE" );
      frmDati.strDataCreaz.value        = getVS ( obj , "vsDATA_CREAZ" );
      frmDati.elementoSelezionato.value = getVS ( obj , "vsIndice" );
      DisabilitaComponente();
  }

  function caricaDati(){
      frmDati.LinkAbilitato.value = '1';
      <%if (strEnableRettifica.equals("1")) {%>
        Disable(frmDati.RETTIFICA);
        Disable(frmDati.CREAEVENTO);
      <%}%>

      <%if ( data_InventariCompo != null ) {%>
      frmDati.elementoSelezionato.value = '<%=elementoSelezionato%>';
      
      <!-- FINE DATI COMUNI -->

      <!-- COMPONENTE -->
      frmDati.srcCodeStato.value        = '<%=data_InventariCompo.getCODE_STATO_ELEM()%>';
      frmDati.strCodeComponente.value   = '<%=data_InventariCompo.getCODE_COMPONENTE()%>';
      frmDati.srcDIF.value              = '<%=data_InventariCompo.getDATA_INIZIO_FATRZ()%>';
      frmDati.srcQNTA.value             = '<%=data_InventariCompo.getQNTA_VALO()%>';
      frmDati.srcCicloVal.value         = '<%=data_InventariCompo.getCODE_ULTIMO_CICLO_FATRZ()%>';
      frmDati.strDataFineFatrz.value    = '<%=data_InventariCompo.getDATA_FINE_FATRZ()%>';
      frmDati.strTipoCausaleAtt.value   = '<%=data_InventariCompo.getTIPO_CAUSALE_ATT()%>';
      frmDati.strDataCessaz.value       = '<%=data_InventariCompo.getDATA_CESSAZ()%>';
      frmDati.strDataInizioValid.value  = '<%=data_InventariCompo.getDATA_INIZIO_VALID()%>';
      frmDati.strDataFineValid.value    = '<%=data_InventariCompo.getDATA_FINE_VALID()%>';
      frmDati.strTipoCausaleCes.value   = '<%=data_InventariCompo.getTIPO_CAUSALE_CES()%>';
      frmDati.strDataFineNol.value      = '<%=data_InventariCompo.getDATA_FINE_NOL()%>';
      frmDati.strIstanzaComponente.value= '<%=data_InventariCompo.getCODE_ISTANZA_COMPO()%>';
      frmDati.strDataInizioNol.value    = '<%=data_InventariCompo.getDATA_DIN()%>';
      frmDati.strDataRicezOrdine.value  = '<%=data_InventariCompo.getDATA_DRO()%>';
      frmDati.strDataCreaz.value        = '<%=data_InventariCompo.getDATA_CREAZ()%>';
      frmDati.strDescStato.value        = '<%=data_InventariCompo.getDESC_STATO_ELEM()%>';
      frmDati.strDescCausaleAtt.value   = '<%=data_InventariCompo.getDESC_TIPO_CAUSALE_ATT()%>';
      frmDati.strDescCausaleCes.value   = '<%=data_InventariCompo.getDESC_TIPO_CAUSALE_CES()%>';
      frmDati.strDescCiclo.value        = '<%=data_InventariCompo.getDESCRIZIONE_CICLO()%>';
      frmDati.strDescComponente.value   = '<%=data_InventariCompo.getDESC_COMPONENTE()%>';
      
      swapClass(frmDati.elementoSelezionato.value);
      <%
      System.out.println("caricaDati getDATA_DRO ["+ data_InventariCompo.getDATA_DRO()+"]");
      System.out.println("caricaDati getDATA_CESSAZ ["+ data_InventariCompo.getDATA_CESSAZ()+"]");

      System.out.println("abilitaModifiche componente ["+data_InventariCompo.eMODIFICATO()+"]");
      %>
      frmDati.abilitaModifiche.value    = '<%=data_InventariCompo.eMODIFICATO()%>';

      <%} else { %>
          alert('Non esistono Componenti Legate alla Istanza Prodotto Selezionata');
          Disable(frmDati.RETTIFICA);
      <%}%>
      
      <!-- DATI COMUNI -->
   
      frmDati.srcCodeServizio.value     = '<%=session.getAttribute("parsrcCodeServizio")%>';
      frmDati.strDescServizio.value     = '<%=session.getAttribute("parstrDescServizio")%>';
      frmDati.srcCodeAccount.value      = '<%=session.getAttribute("parsrcCodeAccount")%>';
      frmDati.strDescAccount.value      = '<%=session.getAttribute("parstrDescAccount")%>';
      frmDati.srcCodeOfferta.value      = '<%=session.getAttribute("parsrcCodeOfferta")%>';
      frmDati.strDescOfferta.value      = '<%=session.getAttribute("parstrDescOfferta")%>';
      frmDati.strCodeProdotto.value     = '<%=session.getAttribute("parstrCodeProdotto")%>';
      frmDati.strDescProdotto.value     = '<%=session.getAttribute("parstrDescProdotto")%>';

      
  }

   function ONANNULLAMODIFICHE() {
      frmDati.hidTypeLoadCompo.value = '0';
      frmDati.submit();
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
        Enable(frmDati.strDataCessaz);
        Enable(frmDati.strTipoCausaleCes);
        Enable(frmDati.strDataFineValid);
        Enable(frmDati.strCodeComponente);
        Enable(frmDati.strDescComponente);
        Enable(frmDati.strDataInizioNol);

        Enable ( frmDati.CREAEVENTO);
        Enable ( frmDati.ANNULLAMODIFICHE);

        Enable(frmDati.strDescAccount);
        Enable(frmDati.strDescOfferta);
        Enable(frmDati.strDescServizio);
        Enable(frmDati.strDescCausaleAtt);
        Enable(frmDati.strDescCausaleCes);
        Enable(frmDati.strDescProdotto);
        Enable(frmDati.cmdProdotto);
        Enable(frmDati.cmdComponente);
        Enable(frmDati.strDataRicezOrdine);
        
        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCalendarDCE);
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
        Enable(frmDati.strDataCessaz);
        Enable(frmDati.strDataInizioValid);
        Enable(frmDati.strTipoCausaleCes);
        Enable(frmDati.strDataFineValid);
        Enable(frmDati.strCodeComponente);
        Enable(frmDati.strDescComponente);
        Enable(frmDati.strDataInizioNol);

        //Enable ( frmDati.SALVA);
        Enable ( frmDati.CREAEVENTO);
        Enable ( frmDati.ANNULLAMODIFICHE);  

        Enable(frmDati.strDescAccount);
        Enable(frmDati.strDescOfferta);
        Enable(frmDati.strDescServizio);
        Enable(frmDati.strDescCausaleAtt);
        Enable(frmDati.strDescCausaleCes);
        Enable(frmDati.strDescProdotto);
        Enable(frmDati.cmdProdotto);
        Enable(frmDati.cmdComponente);
        Enable(frmDati.strDataRicezOrdine);
        
        
        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[0],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[1],document.frmDati.imgCancelDIF);
        EnableLink(document.links[10],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[11],document.frmDati.imgCancelDIN);
        EnableLink(document.links[12],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[13],document.frmDati.imgCancelDRO);
   }

  function swapComponenteTitle(bgcolor){
    var color = bgcolor.id;
    if (color == "#cfdbe9"){
      frmDati.strIstanzaComponente.className = "genEventi_dispari";
    }else{
      frmDati.strIstanzaComponente.className = "genEventi_pari";      
    }
  }

  function swapClass(td) {
    document.getElementById(td).className = 'textBold';
  }
  
  function ONSALVA_EVENTO(){
    if(ONSALVA(frmDati.paginaSorgente.value)){
        inserisciNote();
      ONCREAEVENTO();
      frmDati.creaevento.value="1";
    }
  }

  function variaColoreCompo(){
  
    var val=  frmDati.elementoSelezionato.value;
    document.getElementById(val).bgColor = '#FFFACD';
/*
    if (frmDati.indice.value != ''){
        frmDati.indice.value = frmDati.indice.value + val + ':';
    }else{
        if (val==null){
         val=0;
        }
         frmDati.indice.value =  val + ':';
    } 
    
    alert('variaColoreCompo ' + val);
*/
   // coloraModificati();
  
  }



function CallParentWindowFunction(objwind)
{
variaColoreCompo();
objwind.close(); 

   if (frmDati.strCodeComponente.value != frmDati.strCodeComponente.title) {
      window.setTimeout("   alert('Le modifiche Componente saranno propagate alle Prest. Agg.');",300);
    }
} 

function ChiudiCallParentWindowFunction()
{
//alert('ChiudiCallParentWindowFunction');
  setTimeout("window.opener.CallAlert(); window.close();",6000);
 
}    
/*  
 function coloraModificati()
 {
alert('coloraModificati'+frmDati.indice.value);
if (frmDati.indice.value != ''){
    
var foo=frmDati.indice.value;
var bar = foo.split(":");
for(var i = 0;i<bar.length-1;i++){
alert(bar[i]);
   document.getElementById(bar[i]).className = 'textBoldMod';;
}
}

} 
*/


 
</SCRIPT>

<body onLoad="Initialize();resizeTo(screen.width,screen.height)" onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()">
<FORM name="frmDati" id="frmDati" action="" method="post">
<input type="hidden" name="hidTypeLoadCompo" value="">
<input type="hidden" name="elementoSelezionato" value="">
<input type="hidden" name="rettifica" value="0">
<input type="hidden" name="creaevento" value="0">
<input type="hidden" name="paginaDestinazione" value="">
<input type="hidden" name="abilitaModifiche" value="<%=strEnableCreaEvento%>">
<input type="hidden" name="LinkAbilitato" value="">
<input type="hidden" name="paginaSorgente" value="istanza_dettaglio_componente.jsp?Istanza=<%=Code_Ist_Prod%>">
<TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0"height="100%">

  <TR height="35">
    <TD>
      <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
        <TR>
          <TD align="left">
            <IMG alt="" src="../images/GeneratoreEventi.gif" border="0" width="266" height="35">
          </TD>
          <TD colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="center" width="682">
            <U>Istanza Componente Selezionato : </U>
            <input class="textSel" title="strIstanzaComponente" name="strIstanzaComponente" size="24" readonly>
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
          <TD bgcolor="<%=StaticContext.bgColorTabellaForm%>" class="blackB" width="150">
            Componente
          </TD>
          <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('istanza_dettaglio_prest_agg.jsp<%=URLParam%>');">
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
              <TR bgcolor="#0A6B98" align="center">
                <TD class="white">
                  Componente
                </TD>
              </TR>
              <%
              //Caricamento delle componenti
              data_InventariCompo = null;
              String objBgColor = StaticContext.bgColorRigaPariTabella;
              String strCodeIstanzaCompo = null;
             
              int i = 0;
             
                for (i = 0;i < vct_InventariCompo.size();i++){
            
                  if (objBgColor == StaticContext.bgColorRigaPariTabella) objBgColor = StaticContext.bgColorRigaDispariTabella;
                  else objBgColor = StaticContext.bgColorRigaPariTabella; 
       
                  data_InventariCompo = (DB_InventCompo)vct_InventariCompo.get(i);
                  strCodeIstanzaCompo = data_InventariCompo.getCODE_ISTANZA_COMPO();
                   /*MoS*/
                   //================================================================
                   if ( ctrlvct_InventariCompo != null){
                       ctrldata_InventariCompo = null;
                       ctrldata_InventariCompo = (DB_InventCompo)ctrlvct_InventariCompo.get(i) ;
                         //NEL CASO DI CESSAZIONE prendo data_cessaz
                        //===========================================================
                     /*   if(  data_InventariCompo.getCODE_STATO_ELEM().equals("2") ) { 
                           Vector vct_stInventProd = null;
                           vct_stInventProd =  remoteEnt_Inventari.getstPrenvCompoxCessazione(Code_Ist_Prod,data_InventariCompo.getCODE_ISTANZA_COMPO());
                           DB_InventProd data_stInventProd=null;
                           data_stInventProd = (DB_InventProd)vct_stInventProd.get(0);
                           data_InventariCompo.setDATA_CESSAZ (data_stInventProd.getDATA_CESSAZ());
                           data_InventariCompo.setDATA_DRO (data_stInventProd.getDATA_DRO());
                           data_InventariCompo.setDATA_DEE(data_stInventProd.getDATA_DEE());
                           ctrldata_InventariCompo.setDATA_CESSAZ (data_stInventProd.getDATA_CESSAZ());
                           ctrldata_InventariCompo.setDATA_DRO (data_stInventProd.getDATA_DRO());
                           ctrldata_InventariCompo.setDATA_DEE(data_stInventProd.getDATA_DEE());
                           
                        } 
                       
                       
                       */ 
                        //===========================================================

/*
 !(data_InventariCompo.getCODE_SERVIZIO().equals(ctrldata_InventariCompo.getCODE_SERVIZIO())) ||
                        !(data_InventariCompo.getCODE_ACCOUNT().equals(ctrldata_InventariCompo.getCODE_ACCOUNT())) ||
                        !(data_InventariCompo.getCODE_OFFERTA().equals(ctrldata_InventariCompo.getCODE_OFFERTA())) ||
                        !(data_InventariCompo.getCODE_PRODOTTO().equals(ctrldata_InventariCompo.getCODE_PRODOTTO())) ||
 */                       
                       if (
                        !(data_InventariCompo.getCODE_COMPONENTE().equals(ctrldata_InventariCompo.getCODE_COMPONENTE())) ||
                        !(data_InventariCompo.getDESC_COMPONENTE().equals(ctrldata_InventariCompo.getDESC_COMPONENTE())) ||
                        !(data_InventariCompo.getTIPO_CAUSALE_ATT().equals(ctrldata_InventariCompo.getTIPO_CAUSALE_ATT())) ||
                        !(data_InventariCompo.getDATA_CESSAZ().equals(ctrldata_InventariCompo.getDATA_CESSAZ())) ||
                        !(data_InventariCompo.getDESC_TIPO_CAUSALE_ATT().equals(ctrldata_InventariCompo.getDESC_TIPO_CAUSALE_ATT())) ||
                        !(data_InventariCompo.getTIPO_CAUSALE_CES().equals(ctrldata_InventariCompo.getTIPO_CAUSALE_CES())) ||
                        !(data_InventariCompo.getDESC_TIPO_CAUSALE_CES().equals(ctrldata_InventariCompo.getDESC_TIPO_CAUSALE_CES())) ||
                        !(data_InventariCompo.getDATA_INIZIO_VALID().equals(ctrldata_InventariCompo.getDATA_INIZIO_VALID())) ||
                        !(data_InventariCompo.getDATA_FINE_VALID().equals(ctrldata_InventariCompo.getDATA_FINE_VALID())) ||
                        !(data_InventariCompo.getQNTA_VALO().equals(ctrldata_InventariCompo.getQNTA_VALO())) ||
                        !(data_InventariCompo.getDATA_INIZIO_FATRZ().equals(ctrldata_InventariCompo.getDATA_INIZIO_FATRZ())) ||
                        !(data_InventariCompo.getDATA_FINE_FATRZ().equals(ctrldata_InventariCompo.getDATA_FINE_FATRZ())) ||
                        !(data_InventariCompo.getDATA_DRO().equals(ctrldata_InventariCompo.getDATA_DRO())) ||
                        !(data_InventariCompo.getDATA_DIN().equals(ctrldata_InventariCompo.getDATA_DIN())) ){
                              objBgColor=StaticContext.bgColorRigaPariErroreTabella ;
                        }
                   }
                   //================================================================
                  %>
                  <TR bgcolor="<%=objBgColor%>" id="<%=objBgColor%>" align="center">
                  <input type="hidden" name="startColor" id="<%=objBgColor%>">
                  <%
                  
                        /* Memorizzo tutti i dati che ho estratto dall'inventario nella wiev state*/
                        strViewStateCostructor = "";
                        strViewStateCostructor += "vsCODE_INVENT="+ 							data_InventariCompo.getCODE_INVENT()						+ "|";
                        strViewStateCostructor += "vsCODE_INVENT_RIF="+						data_InventariCompo.getCODE_INVENT_RIF()        + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_ATT="+  				data_InventariCompo.getTIPO_CAUSALE_ATT()       + "|";
                        strViewStateCostructor += "vsDATA_CESSAZ="+  				      data_InventariCompo.getDATA_CESSAZ()            + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_CES="+  				data_InventariCompo.getTIPO_CAUSALE_CES()       + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_ATT_HD="+ 			data_InventariCompo.getTIPO_CAUSALE_ATT_HD()    + "|";
                        strViewStateCostructor += "vsTIPO_CAUSALE_CES_HD="+ 			data_InventariCompo.getTIPO_CAUSALE_CES_HD()    + "|";
                        strViewStateCostructor += "vsCODE_STATO_ELEM="+		  			data_InventariCompo.getCODE_STATO_ELEM()        + "|";
                        strViewStateCostructor += "vsCODE_ACCOUNT="+ 							data_InventariProdotto.getCODE_ACCOUNT()        + "|";
                        strViewStateCostructor += "vsCODE_OFFERTA="+ 							data_InventariProdotto.getCODE_OFFERTA()        + "|";
                        strViewStateCostructor += "vsCODE_SERVIZIO="+   					data_InventariProdotto.getCODE_SERVIZIO()       + "|";
                        strViewStateCostructor += "vsCODE_PRODOTTO="+   					data_InventariProdotto.getCODE_PRODOTTO()       + "|";
                        strViewStateCostructor += "vsCODE_COMPONENTE="+ 					data_InventariCompo.getCODE_COMPONENTE()        + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_PROD="+ 				data_InventariCompo.getCODE_ISTANZA_PROD()      + "|";
                        strViewStateCostructor += "vsCODE_ISTANZA_COMPO="+  			data_InventariCompo.getCODE_ISTANZA_COMPO()     + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_VALID="+ 				data_InventariCompo.getDATA_INIZIO_VALID()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_VALID="+ 					data_InventariCompo.getDATA_FINE_VALID()        + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_FATRZ="+					data_InventariCompo.getDATA_INIZIO_FATRZ()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_FATRZ="+ 					data_InventariCompo.getDATA_FINE_FATRZ()        + "|";
                        strViewStateCostructor += "vsCODE_ULTIMO_CICLO_FATRZ="+		data_InventariCompo.getCODE_ULTIMO_CICLO_FATRZ()+ "|";
                        strViewStateCostructor += "vsDATA_FINE_NOL="+							data_InventariCompo.getDATA_FINE_NOL()          + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_FATRB="+					data_InventariCompo.getDATA_INIZIO_FATRB()      + "|";
                        strViewStateCostructor += "vsDATA_FINE_FATRB="+						data_InventariCompo.getDATA_FINE_FATRB()        + "|";
                        strViewStateCostructor += "vsQNTA_VALO="+									data_InventariCompo.getQNTA_VALO()              + "|";
                        strViewStateCostructor += "vsTIPO_FLAG_CONG="+						data_InventariCompo.getTIPO_FLAG_CONG()         + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_CREAZ="+					data_InventariCompo.getCODE_UTENTE_CREAZ()      + "|";
                        strViewStateCostructor += "vsDATA_CREAZ="+								data_InventariCompo.getDATA_CREAZ()             + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_MODIF="+					data_InventariCompo.getCODE_UTENTE_MODIF()      + "|";
                        strViewStateCostructor += "vsDATA_MODIF="+								data_InventariCompo.getDATA_MODIF()             + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_CREAZ_HD="+    	data_InventariCompo.getCODE_UTENTE_CREAZ_HD()   + "|";
                        strViewStateCostructor += "vsDATA_CREAZ_HD="+ 						data_InventariCompo.getDATA_CREAZ_HD()          + "|";
                        strViewStateCostructor += "vsCODE_UTENTE_MODIF_HD="+     	data_InventariCompo.getCODE_UTENTE_MODIF_HD()   + "|";
                        strViewStateCostructor += "vsDATA_MODIF_HD="+   					data_InventariCompo.getDATA_MODIF_HD()          + "|";
                        strViewStateCostructor += "vsELAB_VALORIZ="+ 							data_InventariCompo.getELAB_VALORIZ()           + "|";
                        strViewStateCostructor += "vsTIPO_FLAG_MIGRAZIONE="+			data_InventariCompo.getTIPO_FLAG_MIGRAZIONE()   + "|";
                        strViewStateCostructor += "vsCODE_STATO_ELEM_PREC="+			data_InventariCompo.getCODE_STATO_ELEM_PREC()   + "|";
                        strViewStateCostructor += "vsDATA_INIZIO_NOL="+						data_InventariCompo.getDATA_DIN()               + "|";
                        strViewStateCostructor += "vsDATA_RICEZ_ORDINE="+         data_InventariCompo.getDATA_DRO()               + "|";
                        strViewStateCostructor += "vsIndice="+	              		i   + "|";
                            
                         /* Selezione delle descrizioni*/
                        strViewStateCostructor += "vsDESC_CAUSALE_ATT="+	data_InventariCompo.getDESC_TIPO_CAUSALE_ATT () + "|" ;
                        strViewStateCostructor += "vsDESC_CAUSALE_CES="+  data_InventariCompo.getDESC_TIPO_CAUSALE_CES () + "|" ;
                        strViewStateCostructor += "vsDESC_ACCOUNT="+			data_InventariProdotto.getDESC_ACCOUNT       () + "|" ;
                        strViewStateCostructor += "vsDESC_OFFERTA="+ 			data_InventariProdotto.getDESC_OFFERTA       () + "|" ;
                        strViewStateCostructor += "vsDESC_SERVIZIO="+ 		data_InventariProdotto.getDESC_SERVIZIO      () + "|" ;
                        strViewStateCostructor += "vsDESC_STATO="+ 				data_InventariCompo.getDESC_STATO_ELEM       () + "|" ;
                        strViewStateCostructor += "vsDESC_PRODOTTO="+			data_InventariProdotto.getDESC_PRODOTTO      () + "|" ;
                        strViewStateCostructor += "vsDESC_COMPONENTE="+		data_InventariCompo.getDESC_COMPONENTE       () + "|" ;
                        strViewStateCostructor += "vsDESC_CICLO="+ 				data_InventariCompo.getDESCRIZIONE_CICLO     () + "|" ;
                        
                  %>
                      <%--<TD class="text" style="CURSOR: hand" id="<%=i%>" onclick="cambiaComponente(viewStateDati<%=i%>);">--%>
                      <TD class="text" style="CURSOR: hand" id="<%=i%>" onclick="ONSALVA('istanza_dettaglio_componente.jsp?SELECTED=<%=i%>&Istanza=<%=Code_Ist_Prod%>&Servizio=<%=Code_Servizio%>')">
                      <input type="hidden" id="viewStateDati<%=i%>" name="viewStateDati<%=i%>" value="<%=strViewStateCostructor%>"  >
                      <%=strCodeIstanzaCompo%>
                    </TD>
                  </TR>
                <%}%>
                <input type="hidden" name="indice" value="<%=i-1%>" >
              
             </TABLE>
             </DIV>
          </TD>

          <!--Frame destro-->
          <TD valign="top">
          <!--DIV!-->
            <TABLE ALIGN=center BORDER=1  WIDTH=800 HEIGHT=9>
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
                  <INPUT class="text" id="strDescProdotto" name="strDescProdotto" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="35">
                </TD>
              </tr>
            </table>
            <br>

            <!-- DATI COMPONENTE -->
            <TABLE ALIGN=center BORDER=1 WIDTH=800 HEIGHT=9>            
              <tr>
                <TD class="text" width="109"> Componente: </TD>
                 <TD colspan="3">
                 <%if ( data_InventariCompo != null ){%>
                  <INPUT class="text" id="strCodeComponente" name="strCodeComponente" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Componente" title = "<%=data_InventariCompo.getCODE_COMPONENTE()%>" Update="false" size="13" onchange="variaColoreCompo();">
                  <%}else{%>
                  <INPUT class="text" id="strCodeComponente" name="strCodeComponente" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Componente"  Update="false" size="13" onchange="variaColoreCompo();">
                  <%}%>
                  <INPUT class="text" id="strDescComponente" name="strDescComponente" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Componente" Update="false" size="35">
                  <input class="text" title="Selezione Componente" type="button" maxlength="30" name="cmdComponente" value="..." onClick="click_cmdComponente();">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Ciclo Valorizzazione:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCicloVal" name="srcCicloVal" readonly obbligatorio="si" tipocontrollo="intero" label="Ciclo Val" Update="false" size="13" onchange="variaColoreCompo();">
                  <INPUT class="text" id="strDescCiclo" name="strDescCiclo" readonly obbligatorio="si" tipocontrollo="intero" label="Ciclo Val" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Stato:      </TD>
                <TD colspan="3">
                  <INPUT class="text" id="srcCodeStato" name="srcCodeStato" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="13" onchange="variaColoreCompo();">
                  <INPUT class="text" id="strDescStato" name="strDescStato" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Casuale Attivazione:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strTipoCausaleAtt" name="strTipoCausaleAtt" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="13" onchange="variaColoreCompo();">
                  <INPUT class="text" id="strDescCausaleAtt" name="strDescCausaleAtt" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="35">
                </TD>
              </tr>
            <TR>
             <TD class="text"> Data Cessazione :  </TD>
             <TD colspan =3 >
              <INPUT class="text" id="strDataCessaz" name="strDataCessaz" readonly obbligatorio="si" tipocontrollo="data" label="Data Cessazione" Update="false" size="13" >
              <a href="javascript:showCalendar('frmDati.strDataCessaz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDCE" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataCessaz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDCE" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
             </TD>     
           </TR>
              <tr>
                <TD class="text" width="109"> Causale Cessazione:  </TD>
                <TD colspan="3">
                  <INPUT class="text" id="strTipoCausaleCes" name="strTipoCausaleCes" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13" onchange="variaColoreCompo();">
                  <INPUT class="text" id="strDescCausaleCes" name="strDescCausaleCes" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="35">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Data Fine Noleggio:  </TD>
                <TD colspna="3">
                  <INPUT class="text" id="strDataFineNol" name="strDataFineNol" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13" onchange="variaColoreCompo();">
                </TD>
                <TD class="text" width="159"> Distanza/Capacità:   </TD>
                <TD>
                  <INPUT class="text" id="srcQNTA" name="srcQNTA"  obbligatorio="si" tipocontrollo="intero" label="Qnta Valo" Update="false" size="13" maxlength="11" onchange="variaColoreCompo();">
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Data Inizio Fatturazione:  </TD>
                <TD width="153">
                  <INPUT class="text" id="srcDIF" name="srcDIF" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Fatrz" Update="false" size="13" onchange="variaColoreCompo();">
                  <a href="javascript:showCalendar('frmDati.srcDIF','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.srcDIF);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
                <TD class="text" width="159"> Data Fine Fatturazione: </TD>
                <TD>
                  <INPUT class="text" id="strDataFineFatrz" name="strDataFineFatrz" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Fatrz" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataFineFatrz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDFF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataFineFatrz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
              </tr>
              <tr>
                <TD class="text" width="109"> Data Inizio Validita:</TD>
                <TD width="153">
                  <INPUT class="text" id="strDataInizioValid" name="strDataInizioValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Validita" Update="false" size="13">
                  <a href="javascript:showCalendar('frmDati.strDataInizioValid','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIV" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataInizioValid);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIV" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>
                <TD class="text" width="159"> Data Fine Validita:
                </TD>
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
                  <INPUT class="text" id="strDataRicezOrdine" name="strDataRicezOrdine" readonly obbligatorio="si" tipocontrollo="data" label="Data Ricezione Ordine" Update="false" size="13" >
                  <a href="javascript:showCalendar('frmDati.strDataRicezOrdine','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDRO" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <a href="javascript:clearField(frmDati.strDataRicezOrdine);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDRO" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                </TD>             
              </TR>
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
<%

%>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  caricaDati();
  DisabilitaComponente();
  ableCreaEvento();

</SCRIPT>

<%
}
  /* Verifico se devo effettuare l'aggiornamento sul dato - FINE IF*/
  else { /*Aggiornamento*/


 
  
      String elemSelected = Misc.nh(request.getParameter("elementoSelezionato"));
      if(elemSelected.equals("")){
        System.out.println("Nessuna componente");
      }else{
        elementoSelezionato = Integer.parseInt(elemSelected);
        
     


/*      elementoSelezionato = Integer.parseInt(Misc.nh(request.getParameter("elementoSelezionato")));*/
        data_InventariCompo = (DB_InventCompo)vct_InventariCompo.get(elementoSelezionato);

        //System.out.println("ABILITAMODIFICHE ["+Misc.nh(request.getParameter("abilitaModifiche"))+"]");
        if(Misc.nh(request.getParameter("abilitaModifiche")).equals("1")){
          data_InventariCompo.Modifica();
          session.setAttribute("ableCreaEvento", "1");
 
        }else{
          data_InventariCompo.annullaModifica();
        }
if  (!data_InventariCompo.getCODE_COMPONENTE().equals(request.getParameter("strCodeComponente"))){
      vPropagaCodeCompo.add(data_InventariCompo.getCODE_ISTANZA_COMPO());
      session.setAttribute("vPropagaCodeCompo", vPropagaCodeCompo);


}
      
        data_InventariCompo.setCODE_SERVIZIO    (Misc.nh(request.getParameter("srcCodeServizio")));
        data_InventariCompo.setDESC_SERVIZIO    (Misc.nh(request.getParameter("strDescServizio")));
        data_InventariCompo.setCODE_ACCOUNT     (Misc.nh(request.getParameter("srcCodeAccount")));
        data_InventariCompo.setDESC_ACCOUNT     (Misc.nh(request.getParameter("strDescAccount")));
        data_InventariCompo.setCODE_OFFERTA     (Misc.nh(request.getParameter("srcCodeOfferta")));
        data_InventariCompo.setDESC_OFFERTA     (Misc.nh(request.getParameter("strDescOfferta")));
        data_InventariCompo.setCODE_PRODOTTO    (Misc.nh(request.getParameter("strCodeProdotto")));
        data_InventariCompo.setDESC_PRODOTTO    (Misc.nh(request.getParameter("strDescProdotto")));
        data_InventariCompo.setCODE_COMPONENTE  (Misc.nh(request.getParameter("strCodeComponente")));
        data_InventariCompo.setDESC_COMPONENTE  (Misc.nh(request.getParameter("strDescComponente")));
        data_InventariCompo.setTIPO_CAUSALE_ATT (Misc.nh(request.getParameter("strTipoCausaleAtt")));
   
        data_InventariCompo.setDATA_CESSAZ      (Misc.nh(request.getParameter("strDataCessaz")));
        
        
        
        data_InventariCompo.setDESC_TIPO_CAUSALE_ATT(Misc.nh(request.getParameter("strDescCausaleAtt")));
        data_InventariCompo.setTIPO_CAUSALE_CES (Misc.nh(request.getParameter("strTipoCausaleCes")));
        data_InventariCompo.setDESC_TIPO_CAUSALE_CES(Misc.nh(request.getParameter("strDescCausaleCes")));
        data_InventariCompo.setDATA_INIZIO_VALID(Misc.nh(request.getParameter("strDataInizioValid")));
        data_InventariCompo.setDATA_FINE_VALID  (Misc.nh(request.getParameter("strDataFineValid")));
        data_InventariCompo.setQNTA_VALO        (Misc.nh(request.getParameter("srcQNTA")));
        data_InventariCompo.setDATA_INIZIO_FATRZ(Misc.nh(request.getParameter("srcDIF")));
        //data_InventariCompo.setDATA_FINE_FATRZ  (Misc.nh(request.getParameter("srcDFF")));
        //QS 21/05/2008: Nel passaggio da componente a prodotto si perdeva il valore di strDataFineFatrz
        data_InventariCompo.setDATA_FINE_FATRZ       (Misc.nh(request.getParameter("strDataFineFatrz")));
        data_InventariCompo.setDATA_DRO         (Misc.nh(request.getParameter("strDataRicezOrdine")));
        data_InventariCompo.setDATA_DIN         (Misc.nh(request.getParameter("strDataInizioNol")));
   
   
         System.out.println("getDATA_DRO ["+ data_InventariCompo.getDATA_DRO()+"]");
         System.out.println("getDATA_CESSAZ ["+ data_InventariCompo.getDATA_CESSAZ()+"]");
     
   
          /* MoS  */
                  //==========================================================
                 if ( ctrlvct_InventariCompo != null){
                        //ctrldata_InventariCompo = null;
                       ctrldata_InventariCompo = (DB_InventCompo)ctrlvct_InventariCompo.get(elementoSelezionato) ;
                       if ( !(data_InventariCompo.getCODE_SERVIZIO().equals(ctrldata_InventariCompo.getCODE_SERVIZIO())) ||
                        !(data_InventariCompo.getDESC_SERVIZIO().equals(ctrldata_InventariCompo.getDESC_SERVIZIO())) ||
                        !(data_InventariCompo.getCODE_ACCOUNT().equals(ctrldata_InventariCompo.getCODE_ACCOUNT())) ||
                        !(data_InventariCompo.getDESC_ACCOUNT().equals(ctrldata_InventariCompo.getDESC_ACCOUNT())) ||
                        !(data_InventariCompo.getCODE_OFFERTA().equals(ctrldata_InventariCompo.getCODE_OFFERTA())) ||
                        !(data_InventariCompo.getDESC_OFFERTA().equals(ctrldata_InventariCompo.getDESC_OFFERTA())) ||
                        !(data_InventariCompo.getCODE_PRODOTTO().equals(ctrldata_InventariCompo.getCODE_PRODOTTO())) ||
                        !(data_InventariCompo.getDESC_PRODOTTO().equals(ctrldata_InventariCompo.getDESC_PRODOTTO())) ||
                        !(data_InventariCompo.getCODE_COMPONENTE().equals(ctrldata_InventariCompo.getCODE_COMPONENTE())) ||
                        !(data_InventariCompo.getDESC_COMPONENTE().equals(ctrldata_InventariCompo.getDESC_COMPONENTE())) ||
                        !(data_InventariCompo.getTIPO_CAUSALE_ATT().equals(ctrldata_InventariCompo.getTIPO_CAUSALE_ATT())) ||
                        !(data_InventariCompo.getDATA_CESSAZ().equals(ctrldata_InventariCompo.getDATA_CESSAZ())) ||
                        !(data_InventariCompo.getDESC_TIPO_CAUSALE_ATT().equals(ctrldata_InventariCompo.getDESC_TIPO_CAUSALE_ATT())) ||
                        !(data_InventariCompo.getTIPO_CAUSALE_CES().equals(ctrldata_InventariCompo.getTIPO_CAUSALE_CES())) ||
                        !(data_InventariCompo.getDESC_TIPO_CAUSALE_CES().equals(ctrldata_InventariCompo.getDESC_TIPO_CAUSALE_CES())) ||
                        !(data_InventariCompo.getDATA_INIZIO_VALID().equals(ctrldata_InventariCompo.getDATA_INIZIO_VALID())) ||
                        !(data_InventariCompo.getDATA_FINE_VALID().equals(ctrldata_InventariCompo.getDATA_FINE_VALID())) ||
                        !(data_InventariCompo.getQNTA_VALO().equals(ctrldata_InventariCompo.getQNTA_VALO())) ||
                        !(data_InventariCompo.getDATA_INIZIO_FATRZ().equals(ctrldata_InventariCompo.getDATA_INIZIO_FATRZ())) ||
                        !(data_InventariCompo.getDATA_FINE_FATRZ().equals(ctrldata_InventariCompo.getDATA_FINE_FATRZ())) ||
                        !(data_InventariCompo.getDATA_DRO().equals(ctrldata_InventariCompo.getDATA_DRO())) ||
                        !(data_InventariCompo.getDATA_DIN().equals(ctrldata_InventariCompo.getDATA_DIN())) ){%>
                        <SCRIPT LANGUAGE="JavaScript" type="text/javascript">
                           variaColoreCompo();
                         </SCRIPT>
                         <%
                           
                        }
                   }
                  
                  //==========================================================
                  
                  //MoS 15/11/2010
                  //NEL CASO DI CESSAZIONE QUESTE 2 DATE le prendo dallo STORICO
                  //===========================================================
            /*      if(  data_InventariCompo.getCODE_STATO_ELEM().equals("2") ) { 
                     Vector vct_stInventProd = null;
                     vct_stInventProd =  remoteEnt_Inventari.getstPrenvCompoxCessazione(Code_Ist_Prod,data_InventariCompo.getCODE_ISTANZA_COMPO());
                     DB_InventProd data_stInventProd=null;
                     data_stInventProd = (DB_InventProd)vct_stInventProd.get(0);
                     
                     data_InventariCompo.setDATA_DRO (data_stInventProd.getDATA_DRO());
                     data_InventariCompo.setDATA_DEE(data_stInventProd.getDATA_DEE());
                     data_InventariCompo.setDATA_CESSAZ (data_stInventProd.getDATA_CESSAZ());
                     //se cambio la data cessazione reimposto la DEE
                     if (!data_InventariCompo.getDATA_CESSAZ().equals( Misc.nh(request.getParameter("strDataCessaz")))){
                         data_InventariCompo.setDATA_DEE (Misc.nh(request.getParameter("strDataCessaz")));
                     }
                  
                  } 
                */  
                  //===========================================================
   
      }

     
      session.setAttribute("hidTypeLoadCompo", "1");

      //session.setAttribute("hidTypeLoadProd", "1");
      //session.setAttribute("hidTypeLoadPrestAgg", "1");
      //session.setAttribute("hidTypeLoadPP", "1");
      //session.setAttribute("hidTypeLoadMP", "1");
      //session.setAttribute("hidTypeLoadRPVD", "1");
      //session.setAttribute("hidTypeLoadATM", "1");
      
     
      
      String pagina_destinazione = request.getParameter("paginaDestinazione")+"&Servizio="+Code_Servizio+"&CodeCausale="+Code_Causale+"&Istanza"+Code_Ist_Prod;
      response.sendRedirect(pagina_destinazione);
  }
%>

</body>
</html>