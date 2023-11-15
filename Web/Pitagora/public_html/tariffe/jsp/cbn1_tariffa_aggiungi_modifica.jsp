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
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_tariffa_aggiungi_modifica.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_ModalitaApplicazione" type="com.ejbSTL.Ent_ModalitaApplicazioneHome" location="Ent_ModalitaApplicazione" />
<EJB:useBean id="remoteEnt_ModalitaApplicazione" type="com.ejbSTL.Ent_ModalitaApplicazione" scope="session">
    <EJB:createBean instance="<%=homeEnt_ModalitaApplicazione.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_TipoArrotondamento" type="com.ejbSTL.Ent_TipoArrotondamentoHome"  location="Ent_TipoArrotondamento" />
<EJB:useBean id="remoteEnt_TipoArrotondamento" type="com.ejbSTL.Ent_TipoArrotondamento" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipoArrotondamento.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_OggettoFatturazioneNew" type="com.ejbSTL.Ent_OggettoFatturazioneNewHome" location="Ent_OggettoFatturazioneNew" />
<EJB:useBean id="remoteEnt_OggettoFatturazioneNew" type="com.ejbSTL.Ent_OggettoFatturazioneNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_OggettoFatturazioneNew.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_TipoCausaleNew" type="com.ejbSTL.Ent_TipoCausaleNewHome" location="Ent_TipoCausaleNew" />
<EJB:useBean id="remoteEnt_TipoCausaleNew" type="com.ejbSTL.Ent_TipoCausaleNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipoCausaleNew.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ClassiScontoNew" type="com.ejbSTL.Ent_ClassiScontoNewHome" location="Ent_ClassiScontoNew" />
<EJB:useBean id="remoteEnt_ClassiScontoNew" type="com.ejbSTL.Ent_ClassiScontoNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_ClassiScontoNew.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_FasceNew" type="com.ejbSTL.Ent_FasceNewHome" location="Ent_FasceNew" />
<EJB:useBean id="remoteEnt_FasceNew" type="com.ejbSTL.Ent_FasceNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_FasceNew.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_RegoleTariffe" type="com.ejbSTL.Ent_RegoleTariffeHome" location="Ent_RegoleTariffe" />
<EJB:useBean id="remoteEnt_RegoleTariffe" type="com.ejbSTL.Ent_RegoleTariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_RegoleTariffe.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_TariffeNew" type="com.ejbSTL.Ent_TariffeNewHome" location="Ent_TariffeNew" />
<EJB:useBean id="remoteEnt_TariffeNew" type="com.ejbSTL.Ent_TariffeNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_TariffeNew.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_TariffeNew" type="com.ejbSTL.Ctr_TariffeNewHome" location="Ctr_TariffeNew" />
<EJB:useBean id="remoteCtr_TariffeNew" type="com.ejbSTL.Ctr_TariffeNew" scope="session">
    <EJB:createBean instance="<%=homeCtr_TariffeNew.create()%>" />
</EJB:useBean>
<%
   Vector vctClass = null;
   Vector vctTariffa = null;
   Vector vctTariffaRif = null;   
   Vector vctRegoleTariffa = null;   
   String strIntestazione = "";
   DB_TariffeNew clsTariffa = null;
   DB_RegolaTariffa clsRegolaTariffa = null;
   String Response = null;
   String classRow = "";

   String URLParamAnnulla = request.getParameter("SourcePage");

   int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
        tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
   }
   int Code_Servizio = Integer.parseInt(request.getParameter("CodeServizio"));
   int Code_Offerta = Integer.parseInt(request.getParameter("CodeOfferta"));
   int Code_Prodotto = Integer.parseInt(request.getParameter("CodeProdotto"));
   String Code_Componente = Misc.nh(request.getParameter("CodeComponente"));
   String Code_PrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
   String Code_Tariffa = Misc.nh(request.getParameter("CodeTariffa"));
   String Code_Pr_Tariffa = Misc.nh(request.getParameter("CodePrTariffa"));

   String Desc_Prodotto = Misc.nh(request.getParameter("DescProdotto"));
   String Desc_Servizio = Misc.nh(request.getParameter("DescServizio"));
   String Desc_Offerta = Misc.nh(request.getParameter("DescOfferta"));
   String Desc_Componente = Misc.nh(request.getParameter("DescComponente"));
   String Desc_PrestAgg = Misc.nh(request.getParameter("DescPrestAgg"));
   String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));

   URLParamAnnulla += !Code_Componente.equals("") ? "&CodeComponente=" + Code_Componente : "";
   URLParamAnnulla += !Code_PrestAgg.equals("") ? "&CodePrestAgg=" + Code_PrestAgg : "";
   URLParamAnnulla += "&CodeCausale=" + Code_Causale;
   
   //Controllo se stanno girando i programmi batch
   if (!remoteCtr_TariffeNew.RunningBatch()){
        %>
        <script language="javascript" type="text/javascript">
            alert('Attenzione : impossibile procedere alla modifica della struttura tariffaria per elaborazioni batch in corso.');
            location.replace('<%=URLParamAnnulla%>');
        </script>
        <%
   }

   strIntestazione = "Servizio : " + Desc_Servizio; 
   strIntestazione += ", Offerta : " + Desc_Offerta;
   strIntestazione += ", Prodotto : " + Desc_Prodotto;

   if(!Desc_Componente.equals("")) strIntestazione += ", Componente : " + Desc_Componente;
   if(!Desc_PrestAgg.equals("")) strIntestazione += ", Prest.Agg. : " + Desc_PrestAgg;

   if (!Code_Tariffa.equals("")){
     
      vctTariffa = remoteEnt_TariffeNew.getTariffa(Integer.parseInt(Code_Tariffa),tipo_Tariffa);
      vctTariffaRif = remoteEnt_TariffeNew.getListaTariffeRiferimXCode(Integer.parseInt(Code_Tariffa),tipo_Tariffa);
      clsTariffa = (DB_TariffeNew)vctTariffa.get(0);
      Code_Pr_Tariffa = clsTariffa.getCODE_PR_TARIFFA();
   }

%>
<%!private String getDettaglioTariffa(DB_TariffeNew objTariffa){
    String strDettaglio="";
    if(objTariffa.getTIPO_FLAG_ANT_POST().equals("U"))
      strDettaglio += "Una tantum";
    else if(objTariffa.getTIPO_FLAG_ANT_POST().equals("C"))
      strDettaglio += "Una tantum cessazione";    //DOR ADD
    else if(objTariffa.getTIPO_FLAG_ANT_POST().equals("A"))
      strDettaglio += "Anticipata";    
    else if(objTariffa.getTIPO_FLAG_ANT_POST().equals("P"))
      strDettaglio += "Posticipata";    
    if(!objTariffa.getVALO_FREQ_APPL().equals(""))
      strDettaglio += ",Frequenza:" + objTariffa.getVALO_FREQ_APPL();
    if(!objTariffa.getQNTA_SHIFT_CANONI().equals(""))
      strDettaglio += ",Shift:" + objTariffa.getQNTA_SHIFT_CANONI();
    return strDettaglio;
  }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<%
String  etichetta= "";
if (tipo_Tariffa != 0) { 
   etichetta= "        PER VERIFICA       ";
%>
   <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style1.css" TYPE="text/css">
<% } %>
<title>
Aggiunta-Modifica Tariffa
</title>
</head>

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
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/ListaTariffeSp.js"></SCRIPT>

<script language="javascript" type="text/javascript">

  var objClassiScontoXml = CreaObjXML();
  var objFasceXml = CreaObjXML();
  var valCboUM = '';
  var pathImg = '<%=StaticContext.PH_COMMON_IMAGES%>';
  var maschera_2 = '<%=StaticContext.nfInputMask%>';
  nomeCampoTariffa = new Array();

  objClassiScontoXml.loadXML('<MAIN><%=remoteEnt_ClassiScontoNew.getClassiDiScontoXml()%></MAIN>');
  objFasceXml.loadXML('<MAIN><%=remoteEnt_FasceNew.getFasceXml()%></MAIN>');

  function change_cboUnitaMisura(){
    if (valCboUM!=frmDati.cboUnitaMisura.value){

      valCboUM=frmDati.cboUnitaMisura.value;
      
      if(frmDati.cboUnitaMisura.value!=''){
        var objNodes = objFasceXml.documentElement.selectNodes('FASCIA[CODE_UM=' + frmDati.cboUnitaMisura.value + ']');
        CaricaComboDaXML(frmDati.cboFasce,objNodes);
        change_cboFasce();
      }
      else{
        ClearCombo(frmDati.cboFasce);   
        change_cboFasce();
      }
    }
  }
  function change_cboModalitaApplicazione(bolDelTarRif){
    var cbo = document.frmDati.cboModalitaApplicazione;
    var opt = cbo.options[cbo.selectedIndex];

    if(bolDelTarRif){
        for (i=document.all('tblTariffeRiferimento').rows.length;i>1;i--){
        document.all('tblTariffeRiferimento').deleteRow(i-1);  
        }
    }
    
    if(opt.flagFascia == 'S'){
      Enable(document.frmDati.cboFasce);
      Enable(document.frmDati.cboUnitaMisura);
      Enable(document.frmDati.cboTipoArrotondamento);  
      document.frmDati.cboFasce.obbligatorio = 'si';
      document.frmDati.cboUnitaMisura.obbligatorio = 'si';
      document.frmDati.cboTipoArrotondamento.obbligatorio = 'si';
    }
    else{
      document.frmDati.cboFasce.value='';
      document.frmDati.cboUnitaMisura.value='';
      document.frmDati.cboTipoArrotondamento.value='';
      Disable(document.frmDati.cboFasce);
      Disable(document.frmDati.cboUnitaMisura);
      Disable(document.frmDati.cboTipoArrotondamento);      
      document.frmDati.cboFasce.obbligatorio = 'no';
      document.frmDati.cboUnitaMisura.obbligatorio = 'no';
      document.frmDati.cboTipoArrotondamento.obbligatorio = 'no';      
      CaricaTabellaTariffe_agg_ins();
    }
    if(opt.flagSconto == 'S'){
      Enable(document.frmDati.cboClasseSconto);
      document.frmDati.cboClasseSconto.obbligatorio = 'si';
    }
    else{
      Disable(document.frmDati.cboClasseSconto);   
      document.frmDati.cboClasseSconto.value='';
      document.frmDati.cboClasseSconto.obbligatorio = 'no';
      CaricaTabellaTariffe();
    }
    if(opt.tipoflag == '<%=StaticContext.FLAG_MODALITA_PERCENTUALE%>')
       document.all('trTariffaPerc').style.display = '';
    else
       document.all('trTariffaPerc').style.display = 'none';
    caricaImporti();
  }

  function setOptTipoTariffa(val){
    for(var i=0;i<document.frmDati.optTipoTariffa.length;i++){
      if(document.frmDati.optTipoTariffa[i].value==val){
        document.frmDati.optTipoTariffa[i].checked=true;
        break;
      }
    }
  } 

  function checkOptTipoTariffa(){
    for(var i=0;i<document.frmDati.optTipoTariffa.length;i++){
      if(document.frmDati.optTipoTariffa[i].checked){
        opt = document.frmDati.optTipoTariffa[i];
        break;
      }
    }
    if (opt.value=='U' || opt.value=='C'){
      Disable(document.frmDati.txtShiftCanone);    
      document.frmDati.txtShiftCanone.value = '';
      Disable(document.frmDati.txtFrequenzaCanone);
      document.frmDati.txtFrequenzaCanone.value = '';
    }
    else{
      Enable(document.frmDati.txtShiftCanone);
      Enable(document.frmDati.txtFrequenzaCanone);
    }
  }
  
  function change_cboClasseSconto(){
    CaricaTabellaTariffe();
    caricaImporti();
  }
  function change_cboFasce(){
    CaricaTabellaTariffe();
    caricaImporti();    
  }

  function selezionaGruppo() {
    var URLParam = '?tipo_tariffa=' +  frmDati.tipo_tariffa.value;
    URL = '../../gruppi_tariffe/jsp/seleziona_gruppo.jsp' + URLParam ;
  	openCentral(URL,'Gruppo','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  }

  function change_cboRegola(){
    var objRegola = document.frmDati.cboRegola;	
  	objRegola = objRegola.options[objRegola.selectedIndex];
    document.all('DescParam').innerText = objRegola.descParam;
    nascondi(document.frmDati.txtDataParametro);
    nascondi(document.frmDati.imgCalendar2);
    nascondi(document.frmDati.imgCancel2);
    nascondi(document.frmDati.txtParamRegola);
    nascondi(document.frmDati.txtParamRegola);
    nascondi(document.frmDati.imgGruppo);

    if(objRegola.typeParam != '' && objRegola.typeParam != undefined) frmDati.txtParamRegola.disabled = '';
    else{
        /*Abilito e disabilito il link perchè il link puo' gia essere disabilitato*/
        EnableLink(document.links[2],document.frmDati.imgCalendar2);
        EnableLink(document.links[3],document.frmDati.imgCancel2);
        DisableLink(document.links[2],document.frmDati.imgCalendar2);
        DisableLink(document.links[3],document.frmDati.imgCancel2);

        frmDati.txtParamRegola.disabled = 'true';
        frmDati.txtParamRegola.value = '';
        document.all('DescParam').innerText = 'La regola non prevede parametro';
        Disable(document.frmDati.txtDataParametro);    
        document.frmDati.txtDataParametro.value = '';  
    }
    if (objRegola.typeParam == 'D') {
        EnableLink(document.links[2],document.frmDati.imgCalendar2);
        EnableLink(document.links[3],document.frmDati.imgCancel2);

        Disable(document.frmDati.txtParamRegola);    
        document.frmDati.txtParamRegola.value = ''; 
        document.frmDati.txtDataParametro.value = '01/01/2005';
        visualizza(document.frmDati.txtDataParametro);
        visualizza(document.frmDati.imgCalendar2);
        visualizza(document.frmDati.imgCancel2);

    } else 
    if (objRegola.typeParam == 'N') {
          /*Abilito e disabilito il link perchè il link puo' gia essere disabilitato*/
          EnableLink(document.links[2],document.frmDati.imgCalendar2);
          EnableLink(document.links[3],document.frmDati.imgCancel2);
          DisableLink(document.links[2],document.frmDati.imgCalendar2);
          DisableLink(document.links[3],document.frmDati.imgCancel2);

          Disable(document.frmDati.txtDataParametro);    
          document.frmDati.txtDataParametro.value = '';

          /* Verifico se la regola è per il gruppo di account*/
          if ( 13 == objRegola.value ) {
            visualizza (document.frmDati.imgGruppo);
          }
          else {
            visualizza(document.frmDati.txtParamRegola);
          }

    } else 
    if (objRegola.typeParam == 'S') {
          /*Abilito e disabilito il link perchè il link puo' gia essere disabilitato*/
          EnableLink(document.links[2],document.frmDati.imgCalendar2);
          EnableLink(document.links[3],document.frmDati.imgCancel2);
          DisableLink(document.links[2],document.frmDati.imgCalendar2);
          DisableLink(document.links[3],document.frmDati.imgCancel2);

          Disable(document.frmDati.txtDataParametro);    
          document.frmDati.txtDataParametro.value = '';
          visualizza(document.frmDati.txtParamRegola);
    }

    if ('' == objRegola.value || objRegola.value == undefined){
      document.all('DescParam').innerText = 'Parametro (Descr.)';
    }
    
  }

  function ONSALVA(){
    
    /*QS 5.2 Aggiunta in or condizione su cboModalitaApplicazione.value = 13 relativa a tariffa variabile con abbattimento iniziale*/
    if(frmDati.cboModalitaApplicazione.value ==2 || frmDati.cboModalitaApplicazione.value == 13 ){
      frmDati.cboUnitaMisura.obbligatorio = 'no';
      frmDati.cboFasce.obbligatorio = 'no';
    }
    
    if(validazioneCampi(frmDati)){
 //   alert(frmDati.taListAppl.title);
 //   alert(frmDati.taListAppl.value);
      if (frmDati.taListAppl.value ==  frmDati.taListAppl.title){
        if(!confirm('Attenzione. Il Listino applicato non è stato variato. Si vuole procedere?')){
        return;
        }
      }
      var txttaListAppl = frmDati.taListAppl.value;

      if (txttaListAppl.length >  512){
        alert('Attenzione.Il Listino applicato può essere max 512 carattteri.');
        return;
      }

      if(opt.tipoflag == '<%=StaticContext.FLAG_MODALITA_PERCENTUALE%>'){
        if(document.all('tblTariffeRiferimento').rows.length == 1){
          alert('Occorre selezionare almeno una tariffa di riferimento.');
          return;
        }
      }
      
      for(i=0; i<nomeCampoTariffa.length; i++){
        if(!checkTariffaValid(document.all(nomeCampoTariffa[i]).value)){
          alert("Il campo Tariffa non puo' avere piu' di sei cifre decimali.");
          return;
        }
      }
     
     

     if (frmDati.tipo_tariffa.value == '0') { 
             controllaRepricing();
     }else{
          <%if(!Code_Tariffa.equals("")){%>
          EnableAllControls(document.frmDati);
          <%}%>
          openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
          frmDati.action = 'cbn1_controller_tariffe.jsp?Operazione=InsUpd';
          frmDati.submit();
          <%if(!Code_Tariffa.equals("")){%>
          DisabledControlForUpdate(frmDati);
          <%}%>
    }  
    }
  }

/* CONTROLLO SE TARIFFA E' DI REPRICING - INIZIO */

  function checkTariffaValid(strTariffa){
     var tariffa_array  = strTariffa.split(",");
     if(tariffa_array[1]>999999){
      return false;
     }
     else{
      return true;
     }   
  }
  
  function controllaRepricing() 
  {
   
    carica = function(dati){ONRITORNO(dati[0].messaggio);};
    errore = function(dati){ONRITORNO(dati[0].messaggio);};  
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
   
        /*ms*/
     var impVariato = 0;   
     for(i=0; i<nomeCampoTariffa.length; i++){
        if(document.all(nomeCampoTariffa[i]).value != document.all(nomeCampoTariffa[i]).title){
         /* alert("Importo variato");*/
          impVariato= '1';
        }
      } 
     if (frmDati.txtDataInizioValidita.value    !=  frmDati.txtDataInizioValiditaOld.value) {
        impVariato = impVariato + '1';
     } else{
        impVariato = impVariato + '0';
     }
     
      
    /************************************++++*/ 
/*chiamaRichiesta('code_tariffa='+document.frmDati.Tariffa.value+'&code_pr_tariffa='+document.frmDati.PR_Tariffa.value+'&DataInizioValidita='+document.frmDati.txtDataInizioValidita.value+'&DataInizioValiditaOld='+document.frmDati.txtDataInizioValiditaOld.value+'&CodeOggFatrz='+document.frmDati.cboOggettoFatturazione.value,'checkTariffaRepricing',asyncFunz); */
 chiamaRichiesta('code_tariffa='+document.frmDati.Tariffa.value+'&code_pr_tariffa='+document.frmDati.PR_Tariffa.value+'&DataInizioValidita='+document.frmDati.txtDataInizioValidita.value+'&DataInizioValiditaOld='+impVariato+'&CodeOggFatrz='+document.frmDati.cboOggettoFatturazione.value,'checkTariffaRepricing',asyncFunz);
  }
  
  function ONRITORNO(messaggio){
   
    if(messaggio == 'REPRICING'){
      if(confirm('La tariffa che si stà per inserire è di Repricing si vuole procedere?')){
        <%if(!Code_Tariffa.equals("")){%>
          EnableAllControls(document.frmDati);
        <%}%>
        openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
        frmDati.action = 'cbn1_controller_tariffe.jsp?Operazione=InsUpd&Repricing=S';
        frmDati.submit();
        <%if(!Code_Tariffa.equals("")){%>
          DisabledControlForUpdate(frmDati);
        <%}%>  
      }
    }else if(messaggio == 'OK'){
      <%if(!Code_Tariffa.equals("")){%>
        EnableAllControls(document.frmDati);
      <%}%>
      openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
      frmDati.action = 'cbn1_controller_tariffe.jsp?Operazione=InsUpd&Repricing=N';
      frmDati.submit();
      <%if(!Code_Tariffa.equals("")){%>
        DisabledControlForUpdate(frmDati);
      <%}%>  
    }else {
      alert('Non è stato possibile aggiungere/modificare la tariffa ');
    }
  }

/* CONTROLLO SE TARIFFA E' DI REPRICING - FINE */

  
  function ONANNULLA(){

    location.replace('<%=URLParamAnnulla%>');    
  }

  function helpRegola(){
    if(frmDati.cboRegola.value==''){
      alert('Occorre selezionare una regola.');
      frmDati.cboRegola.focus();
      return;
    }
    openCentral('cbn1_helpRegola.jsp?CodeRegola=' + frmDati.cboRegola.value,'helpRegola','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
  }
  
  function caricaDati(){
    <%if(!Code_Tariffa.equals("")){%>
      frmDati.cboOggettoFatturazione.value   = '<%=clsTariffa.getCODE_OGGETTO_FATRZ()%>';
      setOptTipoTariffa('<%=clsTariffa.getTIPO_FLAG_ANT_POST()%>');
      frmDati.txtFrequenzaCanone.value       = '<%=clsTariffa.getVALO_FREQ_APPL()%>';
      frmDati.txtShiftCanone.value           = '<%=clsTariffa.getQNTA_SHIFT_CANONI()%>';
      frmDati.txtDataInizioValidita.value    = '<%=clsTariffa.getDATA_INIZIO_VALID()%>';
      frmDati.txtDataInizioValiditaOld.value = '<%=clsTariffa.getDATA_INIZIO_VALID()%>';      
      frmDati.cboModalitaApplicazione.value  = '<%=clsTariffa.getCODE_MODAL_APPL_TARIFFA()%>';
      frmDati.cboTipoCausale.value           = '<%=clsTariffa.getCODE_TIPO_CAUSALE()%>';
      frmDati.TipoProvvisoria.value          = '<%=clsTariffa.getTIPO_FLAG_PROVVISORIA()%>';
      frmDati.cboUnitaMisura.value           = '<%=clsTariffa.getCODE_UNITA_MISURA()%>';
      frmDati.DataCreazione.value            = '<%=clsTariffa.getDATA_CREAZ_TARIFFA()%>';
      change_cboUnitaMisura();
      frmDati.cboClasseSconto.value          = '<%=clsTariffa.getCODE_CLAS_SCONTO()%>';
      change_cboClasseSconto();
      frmDati.cboFasce.value                 = '<%=clsTariffa.getCODE_FASCIA()%>';
      frmDati.cboTipoArrotondamento.value = '<%=clsTariffa.getCODE_TIPO_ARROTONDAMENTO()%>';
      frmDati.taListAppl.value = '<%=clsTariffa.getDESC_LISTINO_APPLICATO().trim()%>';
      frmDati.taListAppl.title = '<%=clsTariffa.getDESC_LISTINO_APPLICATO().trim()%>';
      
      change_cboFasce();
      <%if(clsTariffa.getCODE_PRODOTTO().equals(""))%>
          frmDati.chkAllObj.checked = 'true';
/*  martino 08-03-2004 INIZIO */
    <%if(!Code_Componente.equals("") && !Code_PrestAgg.equals("") && (clsTariffa.getCODE_COMPONENTE().equals("")) ) %>
          frmDati.chkAllCompo.checked = 'true';
/*  martino 08-03-2004 FINE   */          
      <%}%>
  }

  function caricaImporti(){
    <%if(!Code_Tariffa.equals("")){%> 
      if(frmDati.cboFasce.value == '<%=clsTariffa.getCODE_FASCIA()%>'
        && frmDati.cboClasseSconto.value == '<%=clsTariffa.getCODE_CLAS_SCONTO()%>'){
      <%
        String objInputBox = "";
        String valInputBox = "";
        for(int i=0;i<vctTariffa.size();i++){
          objInputBox = "";
          clsTariffa = (DB_TariffeNew)vctTariffa.get(i);
          if(!clsTariffa.getCODE_FASCIA().equals(""))
            objInputBox = "F=" + clsTariffa.getCODE_FASCIA();    
          if(!clsTariffa.getCODE_PR_FASCIA().equals(""))
            objInputBox += "-PRF=" + clsTariffa.getCODE_PR_FASCIA();        
          if(!clsTariffa.getCODE_CLAS_SCONTO().equals("")){
            if(!objInputBox.equals(""))
              objInputBox += "-";  
            objInputBox += "S=" + clsTariffa.getCODE_CLAS_SCONTO();        
            }
          if(!clsTariffa.getCODE_PR_CLAS_SCONTO().equals(""))
            objInputBox += "-PRS=" + clsTariffa.getCODE_PR_CLAS_SCONTO();        
          if(objInputBox.equals(""))
            objInputBox = "tcf";  

          objInputBox = "TAR-" + objInputBox;
          /*valInputBox = CustomNumberFormat.setToNumberFormat(clsTariffa.getIMPT_TARIFFA(),false);*/
          valInputBox = CustomNumberFormat.setToCurrencyFormat(clsTariffa.getIMPT_TARIFFA(),2,6);
          
      %>
        document.all('<%=objInputBox%>').value = '<%=valInputBox%>';
        document.all('<%=objInputBox%>').title = '<%=valInputBox%>';
        document.all('<%=objInputBox%>').name += '-PRT=<%=clsTariffa.getCODE_PR_TARIFFA()%>';

        nomeCampoTariffa['<%=i%>'] = '<%=objInputBox%>';
      <%
      }
      %>
     }
    <%
    }
    %>
  }

</script>




<body onfocus=" ControllaFinestra()" onmouseover="ControllaFinestra()">


<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>

<div name="orologio" id="orologio"  style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera">



<form name="frmDati" id="frmDati" method="post" action="" target="Action"> 
  <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    <TR height="35">
      <TD>
        <TABLE align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
          <TR>
            <TD align="left">
              <IMG height=35 alt="" src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" border=0>
            </TD>
            <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="middle">
              <U><%=strIntestazione%></U>
              <INPUT type="Hidden" name="Servizio" value="<%=Code_Servizio%>">
              <INPUT type="Hidden" name="Offerta" value="<%=Code_Offerta%>">
              <INPUT type="Hidden" name="Prodotto" value="<%=Code_Prodotto%>">
              <INPUT type="Hidden" name="Componente" value="<%=Code_Componente%>">
              <INPUT type="Hidden" name="PrestAgg" value="<%=Code_PrestAgg%>">
              <INPUT type="Hidden" name="Tariffa" value="<%=Code_Tariffa%>"> 
              <INPUT type="Hidden" name="PR_Tariffa" value="<%=Code_Pr_Tariffa%>">
              <INPUT type="Hidden" name="tipo_tariffa" value="<%=tipo_Tariffa%>">
              <INPUT type="Hidden" name="DataCreazione"> 
              <INPUT type="Hidden" name="SourcePage" value="<%=URLParamAnnulla%>">   
              <INPUT type="Hidden" name="TipoProvvisoria" value="N">
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR height="15">
      <TD>
        <TABLE align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
          <TR>
            <TD>
              <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <TR>
                  <TD>
                    <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <TR align="center">
                        <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                          Tariffa
                        </TD>
                        <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="middle" width="9%">
                          <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR valign="top">
      <TD>
        <TABLE align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
          <TR height="5">
            <TD colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="text" align="middle">
              &nbsp;
            </TD>
          </TR>
          <TR>
            <TD class="text" nowrap align="center" colspan="4">
              Oggetto Fatturazione :
            <!--/TD>
            <TD colspan="3"-->
              <SELECT class="text" id="cboOggettoFatturazione" name="cboOggettoFatturazione" obbligatorio="si" tipocontrollo="" label="Oggetto Fatturazione"  Update="false"> 
                <option class="text"  value="">[Oggetto Fatturazione]</option>
                <%
                DB_OggettoFatturazioneNew lcls_OggFatt = null;
                vctClass = remoteEnt_OggettoFatturazioneNew.getOggettiFatturazione(Code_Servizio);
                for (int i = 0;i < vctClass.size();i++){
                  lcls_OggFatt = (DB_OggettoFatturazioneNew)vctClass.get(i);
                  %><OPTION value="<%=lcls_OggFatt.getCODE_OGGETTO_FATRZ()%>"><%=lcls_OggFatt.getDESC_OGGETTO_FATRZ()%></OPTION><%
                }
                %>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD class="text" nowrap align="center" colspan="4">
              <INPUT  type="radio" name="optTipoTariffa" value="U" checked onchange="checkOptTipoTariffa()" Update="false">Una tantum
              <INPUT  type="radio" name="optTipoTariffa" value="C" onchange="checkOptTipoTariffa()" Update="false">Una tantum cessazione
              <INPUT  type="radio" name="optTipoTariffa" value="A" onchange="checkOptTipoTariffa()" Update="false">Anticipata
              <INPUT  type="radio" name="optTipoTariffa" value="P" onchange="checkOptTipoTariffa()" Update="false">Posticipata
            </TD>
          </TR>
          <TR align="center">
            <TD colspan="4" class="text">
              <HR>
            </TD>
          </TR>
          <TR>
            <TD class="text">
              Frequenza canone :
            </TD>
            <TD>
              <INPUT class="text" id="txtFrequenzaCanone" name="txtFrequenzaCanone" obbligatorio="si" tipocontrollo="intero" label="Frequenza canone" Update="false" size="20">
            </TD>
            <TD class="text">
              Shift canone :
            </TD>
            <TD>
              <INPUT class="text" id="txtShiftCanone" name="txtShiftCanone" obbligatorio="si" tipocontrollo="intero" label="Shift canone" Update="false" size="20">
            </TD>
          </TR>
          <TR>
            <TD class="text">
              Data inizio validità :
            </TD>
            <TD>
              <INPUT class="text" id="txtDataInizioValidita" name="txtDataInizioValidita" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="" size="20">
              <a href="javascript:showCalendar('frmDati.txtDataInizioValidita','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.txtDataInizioValidita);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
              <input type="hidden" id="txtDataInizioValiditaOld" id="txtDataInizioValiditaOld">
            </TD>
            <TD class="text">
              Modalità applicazione :
            </TD>
            <TD>
              <SELECT class="text" id="cboModalitaApplicazione" name="cboModalitaApplicazione" onchange="change_cboModalitaApplicazione(true)" obbligatorio="si" label="Modalita applicazione" Update="false">
                <option class="text"  value="">[Modalità Applicazione]</option>
                <%
                DB_ModalitaApplicazione lcls_ModApp = null;
                vctClass = remoteEnt_ModalitaApplicazione.getModalitaApplicazione();
                for (int i = 0;i < vctClass.size();i++){
                  lcls_ModApp = (DB_ModalitaApplicazione)vctClass.get(i);
                  %><OPTION value="<%=lcls_ModApp.getCODE_MODAL_APPL_TARIFFA()%>" tipoflag="<%=lcls_ModApp.getTIPO_FLAG_MODAL_APPL_TARIFFA()%>" flagSconto="<%=lcls_ModApp.getFLAG_SCONTO()%>" flagFascia="<%=lcls_ModApp.getFLAG_FASCIA()%>"><%=lcls_ModApp.getDESC_MODAL_APPL_TARIFFA()%></OPTION><%
                }
                %>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD class="text">
              Causale :
            </TD>
            <TD>
              <SELECT class="text" id="cboTipoCausale" name="cboTipoCausale" obbligatorio="no" Update="false">
                <option class="text"  value="">[Causale]</option>
                <%
                DB_TipoCausaleNew lcls_TipCausale = null;
                vctClass = remoteEnt_TipoCausaleNew.getTipiCausale();
                for (int i = 0;i < vctClass.size();i++){
                  lcls_TipCausale = (DB_TipoCausaleNew)vctClass.get(i);
                  %><OPTION value="<%=lcls_TipCausale.getCODE_TIPO_CAUSALE()%>"><%=lcls_TipCausale.getDESC_TIPO_CAUSALE()%></OPTION><%
                }
                %>
              </SELECT>
            </TD>
<!-- martino 08-03-2004 INIZIO-->
            <%if(!Code_Componente.equals("") || !Code_PrestAgg.equals("")){%>
              <TD class="text" colspan="2">
              &nbsp;&nbsp;&nbsp;&nbsp;
              <INPUT id="chkAllObj" type="checkbox" name="chkAllObj" Update="false" value="on">
                 Applica a tutti i prodotti
              <br>
              <%if(!Code_Componente.equals("") && !Code_PrestAgg.equals("") ) {%>
              &nbsp;&nbsp;&nbsp;&nbsp;             
              <INPUT id="chkAllCompo" type="checkbox" name="chkAllCompo" Update="false" value="on">
                 Applica a tutte le componenti
              <%}%>
<!-- martino 08-03-2004 FINE -->
              </TD>
            <%}else{%>
              <TD colspan="2"></TD>
            <%}%>
          </TR>
          <TR>
            <TD colspan="4">
              <HR>
            </TD>
          </TR>
          <TR>
            <TD class="text" colspan="4">
              <TABLE align="center">
                <TR>
                  <TD class="text" nowrap colspan="2">
                    Fascia di spesa : <SELECT class="text" id="cboClasseSconto" name="cboClasseSconto" onchange="change_cboClasseSconto()" obbligatorio="no" Update="false" label="Fascia di spesa">
                      <option class="text"  value="">[Classe di Sconto]</option>
                      <%
                      DB_ClasseScontoNew lcls_Cs = null;
                      vctClass = remoteEnt_ClassiScontoNew.getAnagrafica();
                      for (int i = 0;i < vctClass.size();i++){
                        lcls_Cs = (DB_ClasseScontoNew)vctClass.get(i);
                        %><OPTION value="<%=lcls_Cs.getCODE_CLAS_SCONTO()%>"><%=lcls_Cs.getDESC_CLAS_SCONTO()%></OPTION><%
                      }
                      %>
                    </SELECT>
                  </TD>
                </TR>
                <TR>
                  <TD class="text" nowrap>
                    Unita di misura : <SELECT class="text" id="cboUnitaMisura" name="cboUnitaMisura" onchange="change_cboUnitaMisura()" obbligatorio="no" Update="false" label="Unità di misura">
                      <option class="text"  value="">[Unita di Misura]</option>
                      <%
                      DB_UnitaMisura lcls_Um = null;
                      vctClass = remoteEnt_FasceNew.getUnitaDiMisura();
                      for (int i = 0;i < vctClass.size();i++){
                        lcls_Um = (DB_UnitaMisura)vctClass.get(i);
                        %><OPTION value="<%=lcls_Um.getCODE_UNITA_MISURA()%>"><%=lcls_Um.getDESC_UNITA_MISURA()%></OPTION><%
                      }
                      %>
                    </SELECT>
                  </TD>
                  <TD class="text" nowrap>
                    Fascia : <SELECT class="text" id="cboFasce" name="cboFasce" onchange="change_cboFasce()" obbligatorio="no" Update="false" label="Fascia">
                      <option class="text"  value="">[Fascia]</option>
                    </SELECT>
                  </TD>
                </TR>
              </TABLE>
              <TABLE align="center">
                <TR>
                  <TD class="text" nowrap colspan="2">
                    Tipo Arrotondamento QNTA_VALO: 
                     <SELECT class="text" id="cboTipoArrotondamento" name="cboTipoArrotondamento" obbligatorio="si" label="Tipo Arrotondamento" Update="false">
                      <option class="text"  value="">[Tipo Arrotondamento]</option>
                       <%
                         DB_TipoArrotondamento lcls_TipoArr = null;
                         vctClass = remoteEnt_TipoArrotondamento.getTipoArrotondamento();%>

                          <%for (int i = 0;i < vctClass.size();i++){
                            lcls_TipoArr = (DB_TipoArrotondamento)vctClass.get(i);
                          
                           %><OPTION value="<%=lcls_TipoArr.getCODE_TIPO_ARROTONDAMENTO()%>"><%=lcls_TipoArr.getDESC_TIPO_ARROTONDAMENTO()%></OPTION><%
                          
                         }
                        %>
                      </SELECT>
                 </TD>
                </TR>
              </TABLE>
              <HR>
              
            </TD>
          </TR>
          <TR>
            <TD colspan="4" height="10"></TD>
          </TR>
          <TR>
            <TD colspan="4">
              <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="<%=StaticContext.bgColorHeader%>" name="MasterTableTariffe" id="MasterTableTariffe">
                <TR>
                  <TD>
                    <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <TR>
                        <TD>
                          <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" name="HeadTableTariffe" id="HeadTableTariffe" >
                            <TR align="center">
                              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white"></TD>
                              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="middle" width="9%">
                                <IMG height=8 alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif" width=8>
                              </TD>
                            </TR>
                          </TABLE>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                </TR>
                <TR>
                  <TD>
                    <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" name="BodyTableTariffe" id="BodyTableTariffe" >
                    </TABLE>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR name="trTariffaPerc" id="trTariffaPerc" style="display:none" height="35">
            <TD colspan="4">
              <HR>
              <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
                  <TR>
                    <TD class="textB" nowrap>
                      Tariffe di riferimento : 
                    </TD>
                    <TD align="right">
                      <INPUT type="Button" value="Seleziona tariffe" class="textB" id="cmdTariffaRiferimento" name="cmdTariffaRiferimento" onClick="cmdTariffaRiferimento_click()" >
                    </TD>
                  </TR>
                  <TR>
                    <TD colspan="2"> 
                        <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" name="tblTariffeRiferimento" id="tblTariffeRiferimento">
                          <TR bgcolor="<%=StaticContext.bgColorHeader%>" align="center"   height="20" class="white">
                            <TD nowrap>
                              Prod.-Comp.-Prest.Agg.
                            </TD>
                            <TD nowrap>
                              Oggetto fatturazione
                            </TD>
                            <TD nowrap>
                              Mod.Appl.
                            </TD>
                            <TD nowrap>
                              Dettaglio
                            </TD>
                            <TD nowrap>
                              Causale
                            </TD>
                            <TD nowrap>
                              Data Inzio
                            </TD>
                          </TR>
                          <%
                            if(vctTariffaRif!=null && vctTariffaRif.size()>0){
                              for(int i=0;i<vctTariffaRif.size();i++){
                                clsTariffa = (DB_TariffeNew)vctTariffaRif.get(i);
                                if((i%2)>0)classRow = "row1"; else classRow = "row2";
                                %>
                                <TR class="<%=classRow%>" align="center">
                                  <TD>
                                      <%=clsTariffa.getDESC_PRODOTTO()%><br>                                 
                                      <%=clsTariffa.getDESC_COMPONENTE()%><br>                                      
                                      <%=clsTariffa.getDESC_PREST_AGG()%>
                                      <INPUT type="hidden" name="TARRIF-<%=i+1%>" value="<%=clsTariffa.getCODE_TARIFFA()%>">
                                  </TD>
                                  <TD>
                                      <%=clsTariffa.getDESC_OGGETTO_FATRZ()%>
                                  </TD>
                                  <TD>
                                      <%=clsTariffa.getDESC_MODAL_APPL_TARIFFA()%>
                                  </TD>
                                  <TD>
                                      <%=getDettaglioTariffa(clsTariffa)%>
                                  </TD>
                                  <TD>
                                      <%=clsTariffa.getDESC_TIPO_CAUSALE()%>
                                  </TD>
                                  <TD>
                                      <%=clsTariffa.getDATA_INIZIO_VALID()%>
                                  </TD>
                                </TR>
                                <%
                              }
                            }
                          %>
                       </TABLE>
                    </TD>
                  </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD colspan="4">
              <HR>
            </TD>
          </TR>
          <TR>
            <TD colspan="4">
            <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#0a6b98" >
                <TR>
                  <TD>
            <TABLE width="100%" border="0"  cellspacing="1" cellpadding="1">
              <TR bgcolor="#0a6b98" align="center">
                <TD class="white" width="46%">
                  Listino Applicato 
                </TD>
                <TD class="white">
                   &nbsp;
                </TD>
                <TD class="white" bgcolor="#ffffff" width="8%">
                  <IMG height=8 alt="immagine " src="../../common/images/body/quad_blu.gif" width=8 >
                </TD>
              </TR>
              <TR class="row1">
                  <TD  colspan="3" >
                  <textarea id="taListAppl" name="taListAppl" class="text" style="width:60%;height:40px"></textarea>
                  </TD>
               </TR>   
            </TABLE>
               </TD>
            </TR>
            </TABLE>
             </TD>
            </TR>
        <TR>
            <TD colspan="4">
              <HR>
            </TD>
          </TR> 
          <TR>
            <TD colspan="4">
              <TABLE align="center" width="100%" border="0">
                <TR>
                  <TD class="textB" width="30%">
                    Regola
                  </TD>
                  <TD class="textB" select="">
                    &nbsp;
                  </TD>
                  <TD class="textB" select="" align="left">
                    <FONT id="DescParam" name="DescParam">Parametro (Descr.)</FONT>
                  </TD>
                  <TD>
                    &nbsp;
                  </TD>
                </TR>
                <TR>
                  <TD>
                    <SELECT class="text" id="cboRegola" name="cboRegola" onchange="change_cboRegola()" obbligatorio="no">
                        <option class="text" value="">[Regola]</option>
                        <%
                        DB_RegolaTariffa lcls_Rt = null;                        
                        vctClass = remoteEnt_RegoleTariffe.getAnagraficaRegoleTariffe();
                        for (int i = 0;i < vctClass.size();i++){
                          lcls_Rt = (DB_RegolaTariffa)vctClass.get(i);
                          %><OPTION value="<%=lcls_Rt.getCODE_REGOLA()%>"
                          typeParam="<%=lcls_Rt.getTIPO_PARAMETRO()%>"
                          descParam="<%=lcls_Rt.getDESC_PARAMETRO()%>"
                          ><%=lcls_Rt.getDESC_REGOLA()%></OPTION><%
                        }
                        %>                        
                    </SELECT>
                  </TD>
                  <TD class="textB" select="" align="left">
                    <IMG alt="help regola" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOHelp.gif" style="cursor:hand" onclick="helpRegola()">
                  </TD>

                  <TD class="textB" select="">
                    <input type="hidden" name="txtDataGruppo" id="txtDataGruppo" value="">
                    <input type="hidden" name="txtDescrGruppo" id="txtDescrGruppo" value="">
                    <INPUT class="text" size="10" id="txtParamRegola" name="txtParamRegola" obbligatorio="no">
                    <img align="center" height="50" width="50" name="imgGruppo" alt="Seleziona Gruppo"  src="<%=StaticContext.PH_TARIFFE_IMAGES%>Gruppo.gif" style="cursor:hand" onclick="selezionaGruppo()" border="0"></a>                    
                    <INPUT class="text" id="txtDataParametro" name="txtDataParametro" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="<%="01/01/2005"%>" size="11">
                    <a href="javascript:showCalendar('frmDati.txtDataParametro','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar2" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                    <a href="javascript:clearField(frmDati.txtDataParametro);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel2" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                  </TD>
                  <TD align="right">
                    <INPUT class="textB" type="button" name="btnAggiungiRegola" id="btnAggiungiRegola" value="Aggiungi" onclick="AggiungiRegola()">
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
           <TD colspan="4">
				 
             <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="<%=StaticContext.bgColorHeader%>">
               <TR>
                  <TD>
                    <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
                      <TR bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
                        <TD class="white" width="46%">
                          Nome regola
                        </TD>
                        <TD class="white" width="46%">
                          Parametro
                        </TD>
                        <TD class="white" bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="8%">
                          <IMG height=8 alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif" width=8 >
                        </TD>
                      </TR>
                   </TABLE>
                 </TD>
               </TR>
               <TR>
                  <TD>
                    <DIV>
                    <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" name="TableRegole" id="TableRegole">
                    <%
                      if(!Code_Tariffa.equals("")){
                        vctRegoleTariffa = remoteEnt_RegoleTariffe.getRegoleTariffa(Integer.parseInt(Code_Tariffa),tipo_Tariffa);
                        for(int i=0;i<vctRegoleTariffa.size();i++){
                          clsRegolaTariffa = (DB_RegolaTariffa)vctRegoleTariffa.get(i);
                          if((i%2)>0)classRow = "row1"; else classRow = "row2";
                          %>
                            <TR class="<%=classRow%>" height="20">
                              <TD align="center" width="46%">
                                <%=clsRegolaTariffa.getDESC_REGOLA()%>
                                <INPUT typeTxt="REGOLA" type="hidden" name="REG-<%=clsRegolaTariffa.getCODE_REGOLA()%>" id="REG-<%=clsRegolaTariffa.getCODE_REGOLA()%>" value="<%=clsRegolaTariffa.getPARAMETRO()%>">
                              </TD>
                              <TD align="center" width="46%">
                                <!--modifica 10032014 -->
                                <% String parametro = "";
                                     if(clsRegolaTariffa.getCODE_REGOLA().equals("13")) 
                                         parametro = clsRegolaTariffa.getDESC_ACCOUNT();
                                       else
                                            parametro = clsRegolaTariffa.getPARAMETRO();
                                  %>          
                                     <%=parametro%>
                              </TD>
                              <TD align="center" width="8%">
                                <%//if(clsTariffa.getTIPO_FLAG_PROVVISORIA().equals("N")){%>      
                                <IMG alt="Cancella" onclick="DeleteRow('TableRegole',this)" src="<%=StaticContext.PH_COMMON_IMAGES%>delete.gif" style="CURSOR: hand">
                                <%//}%>                                
                              </TD>
                            </TR>
                          <%
                        }                        
                      }
                    %>
                    </TABLE>
                    </DIV>
                  </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR height="30">
      <TD>
        <TABLE align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
          <TR>
            <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"><%=etichetta%></td> 
            <td class="text" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
              <sec:ShowButtons td_class="textB"/>
            </td>
            <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"><%=etichetta%></td> 
          </TR>
        </TABLE>
      </TD>
    </TR>
  </TABLE>

</div>

</form>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
    CaricaTabellaTariffe();
    caricaDati();
    change_cboModalitaApplicazione(false);
    checkOptTipoTariffa();
    caricaImporti();
    <%if(!Code_Tariffa.equals("")){%>
    DisabledControlForUpdate(frmDati);
    <%}%>
    nascondi(document.frmDati.txtDataParametro);
    nascondi(document.frmDati.imgCalendar2);
    nascondi(document.frmDati.imgCancel2);
    nascondi(document.frmDati.txtParamRegola);
    nascondi(document.frmDati.imgGruppo)
</SCRIPT>

<script>
var http=getHTTPObject();
</script>

</body>
</html>