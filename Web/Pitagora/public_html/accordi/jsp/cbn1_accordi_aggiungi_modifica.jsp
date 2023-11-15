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
<!--
<EJB:useHome id="homeEnt_OggettoFatturazioneNew" type="com.ejbSTL.Ent_OggettoFatturazioneNewHome" location="Ent_OggettoFatturazioneNew" />
<EJB:useBean id="remoteEnt_OggettoFatturazioneNew" type="com.ejbSTL.Ent_OggettoFatturazioneNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_OggettoFatturazioneNew.create()%>" />
</EJB:useBean>
-->
<EJB:useHome id="homeEnt_RegoleTariffe" type="com.ejbSTL.Ent_RegoleTariffeHome" location="Ent_RegoleTariffe" />
<EJB:useBean id="remoteEnt_RegoleTariffe" type="com.ejbSTL.Ent_RegoleTariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_RegoleTariffe.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioniHome" location="Ent_TipoRelazioni" />
<EJB:useBean id="remoteEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioni" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipoRelazioni.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Accordo" type="com.ejbSTL.Ent_AccordoHome" location="Ent_Accordo" />
<EJB:useBean id="remoteEnt_Accordo" type="com.ejbSTL.Ent_Accordo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Accordo.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Offerte" type="com.ejbSTL.Ent_OfferteHome" location="Ent_Offerte" />
<EJB:useBean id="remoteEnt_Offerte" type="com.ejbSTL.Ent_Offerte" scope="session">
    <EJB:createBean instance="<%=homeEnt_Offerte.create()%>" />
</EJB:useBean>
<%
   Vector vctClass = null;
   Vector vctAccordo = null;
//   Vector vctTariffaRif = null;   
  Vector vctTariffa = null;
   Vector vctTariffaRif = null;  
   Vector vctRegoleTariffa = null;   
   String strIntestazione = "";
   DB_Accordo clsAccordo = null;
   DB_TariffeNew clsTariffa=null;
   DB_RegolaTariffa clsRegolaTariffa = null;
   String Response = null;
   String classRow = "";
   String Code_Tariffa ="";
  String Code_Pr_Tariffa ="";
  String strOperazione = "";
   String strSelected ="";
   int tipo_Tariffa  = 0;
  String pstrDATA_FINE_FATRZ="";
  String pstrDATA_FINE_VALID="";
  String pstrDATA_FINE_TARIFFA="";
   
 String URLParamAnnulla = "cbn1_accordi_aggiungi_modifica.jsp";   
 Vector vctOfferte = remoteEnt_Accordo.getOfferte();
 Vector vctAccount = remoteEnt_TipoRelazioni.getAccount();   
  


 String pstrStatoAccordo = Misc.nh(request.getParameter("StatoAccordo"));
 String pstrCodeAccordo = Misc.nh(request.getParameter("optCodeAccordo"));
 String pNuovo = Misc.nh(request.getParameter("nuovo"));
String strFlagCong="";

   if (pstrCodeAccordo.equals("")){
        strOperazione = "Ins";
        pstrCodeAccordo = remoteEnt_Accordo.getSequenceAccordo();
 
   }else{
       strOperazione = "Upd";
       vctAccordo = remoteEnt_Accordo.getAccordo(pstrCodeAccordo);
       clsAccordo = (DB_Accordo)vctAccordo.get(0);
       Code_Tariffa=clsAccordo.getCODE_TARIFFA();    
       Code_Pr_Tariffa= clsAccordo.getCODE_PR_TARIFFA() ;  
       strFlagCong= clsAccordo.getTIPO_FLAG_CONG();
      session.setAttribute("ProdottoAccordo", clsAccordo.getCODE_PRODOTTO()); 
   }    

 
 
 URLParamAnnulla +="?optCodeAccordo=" + pstrCodeAccordo;
   
 session.setAttribute("CodeTariffa", Code_Tariffa);
 session.setAttribute("PrCodeTariffa", Code_Pr_Tariffa);
 session.setAttribute("CodeAccordo", pstrCodeAccordo);
 session.setAttribute("tipo_tariffa", tipo_Tariffa);
 session.setAttribute("SourcePage", URLParamAnnulla);


 
          

/*  if (!pstrCodeAccordo.equals("") && (pNuovo.equals(""))) {
     URLParamAnnulla += !pstrCodeAccordo.equals("") ? "&CodeAccordo=" + pstrCodeAccordo : "";
  }


   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
        tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
   }
*/   
    
    //String Code_Offerta = request.getParameter("CodeOfferta");





 //String Code_Tariffa = Misc.nh(request.getParameter("CodeTariffa"));
/*
   int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
        tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
   }
   int Code_Servizio = Integer.parseInt(request.getParameter("CodeServizio"));
  
   int Code_Prodotto = Integer.parseInt(request.getParameter("CodeProdotto"));
   String Code_Componente = Misc.nh(request.getParameter("CodeComponente"));
   String Code_PrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
   String Code_Teriffa = Misc.nh(request.getParameter("CodeTariffa"));
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
   
//   Controllo se stanno girando i programmi batch
 */ 
 
//   if (!remoteCtr_TariffeNew.RunningBatch()){
 /*  
   }
   strIntestazione = "Servizio : " + Desc_Servizio; 
   strIntestazione += ", Offerta : " + Desc_Offerta;
   strIntestazione += ", Prodotto : " + Desc_Prodotto;

   if(!Desc_Componente.equals("")) strIntestazione += ", Componente : " + Desc_Componente;
   if(!Desc_PrestAgg.equals("")) strIntestazione += ", Prest.Agg. : " + Desc_PrestAgg;
*/


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
<title>
Aggiunta-Modifica Accordo
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
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="../js/Accordi.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"  type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/Acc_ListaTariffeSp.js"  type="text/javascript"></SCRIPT>

<script language="javascript" type="text/javascript">

  var objClassiScontoXml = CreaObjXML();
  var objFasceXml = CreaObjXML();
  var valCboUM = '';
  var pathImg = '<%=StaticContext.PH_COMMON_IMAGES%>';
  var maschera_2 = '<%=StaticContext.nfInputMask%>';
  nomeCampoTariffa = new Array();
  var valCboOfferta = ''; 

    function change_cboOfferta(){
    if (valCboOfferta!=frmDati.cboOfferta.value){
      valCboOfferta=frmDati.cboOfferta.value;
  
    }
  }
function CallParentWindowFunction()
{
  window.opener.CallAlert();
   window.close();
}   
  
  
/*
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
 */

//  function change_cboModalitaApplicazione(bolDelTarRif){
//    var cbo = document.frmDati.cboModalitaApplicazione;
//    var opt = cbo.options[cbo.selectedIndex];
/*
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
   */ 
//  }


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
    if (opt.value=='U'){
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
 /* 
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
*/
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
        EnableLink(document.links[3],document.frmDati.imgCalendar2);
        EnableLink(document.links[4],document.frmDati.imgCancel2);
        DisableLink(document.links[3],document.frmDati.imgCalendar2);
        DisableLink(document.links[4],document.frmDati.imgCancel2);

        frmDati.txtParamRegola.disabled = 'true';
        frmDati.txtParamRegola.value = '';
        document.all('DescParam').innerText = 'La regola non prevede parametro';
        Disable(document.frmDati.txtDataParametro);    
        document.frmDati.txtDataParametro.value = '';  
    }
    if (objRegola.typeParam == 'D') {
        EnableLink(document.links[3],document.frmDati.imgCalendar2);
        EnableLink(document.links[4],document.frmDati.imgCancel2);

        Disable(document.frmDati.txtParamRegola);    
        document.frmDati.txtParamRegola.value = ''; 
        document.frmDati.txtDataParametro.value = '01/01/2005';
        visualizza(document.frmDati.txtDataParametro);
        visualizza(document.frmDati.imgCalendar2);
        visualizza(document.frmDati.imgCancel2);

    } else 
    if (objRegola.typeParam == 'N') {
          /*Abilito e disabilito il link perchè il link puo' gia essere disabilitato*/
          EnableLink(document.links[3],document.frmDati.imgCalendar2);
          EnableLink(document.links[4],document.frmDati.imgCancel2);
          DisableLink(document.links[3],document.frmDati.imgCalendar2);
          DisableLink(document.links[4],document.frmDati.imgCancel2);

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
          EnableLink(document.links[3],document.frmDati.imgCalendar2);
          EnableLink(document.links[4],document.frmDati.imgCancel2);
          DisableLink(document.links[3],document.frmDati.imgCalendar2);
          DisableLink(document.links[4],document.frmDati.imgCancel2);

          Disable(document.frmDati.txtDataParametro);    
          document.frmDati.txtDataParametro.value = '';
          visualizza(document.frmDati.txtParamRegola);
    }

    if ('' == objRegola.value || objRegola.value == undefined){
      document.all('DescParam').innerText = 'Parametro (Descr.)';
    }
    
  }
  function ONCESSA(){
    <%if(!pstrStatoAccordo.equals("1") ){%> 
          alert('Non è possibile cessare accordi non valorizzati');
    <%}else{%>
    if(validazioneCampi(frmDati)){
  // Controllo DATE 
  			if(frmDati.txtDataFineValidita.value == "")
					{
						alert("Il campo Data Fine Validità e' obbligatorio!");
						// do il fuoco all'oggetto corrente
						setFocus(frmDati.txtDataFineValidita);
						return false;
					}

  	//		if(frmDati.txtDataFineFattura.value == "")
		//			{
		//				alert("Il campo Data Fine Fattura e' obbligatorio!");
						// do il fuoco all'oggetto corrente
		//				setFocus(frmDati.txtDataFineValidita);
		//				return false;
		//			}
  
     <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
         EnableAllControls(document.frmDati);
    <%}%>
    openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
    frmDati.action = 'cbn1_controller_accordi.jsp?Operazione=Ces';
    frmDati.submit();
    <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
       DisabledControlForUpdate(frmDati);
    <%}%>
    }
    
    <%}%> 
  }
    function ONELIMINA(){
    
  <%if(pstrStatoAccordo.equals("1") ){%>
       alert('Non è possibile eliminare accordi precedentemente valorizzati');
  <%}else if (strOperazione.equals("Ins")){%>
        alert('Accordo non ancora inserito non è possibile elimnare.');
  <%}else{%>
     <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
         EnableAllControls(document.frmDati);
    <%}%>
    openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
    frmDati.action = 'cbn1_controller_accordi.jsp?Operazione=Eli';
    frmDati.submit();
    <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
       DisabledControlForUpdate(frmDati);
    <%}%>
  <%}%>
 
  }
  
  function ONSALVA(){
    
    /*QS 5.2 Aggiunta in or condizione su cboModalitaApplicazione.value = 13 relativa a tariffa variabile con abbattimento iniziale*/
 //   if(frmDati.cboModalitaApplicazione.value ==2 || frmDati.cboModalitaApplicazione.value == 13 ){
 //     frmDati.cboUnitaMisura.obbligatorio = 'no';
 //     frmDati.cboFasce.obbligatorio = 'no';
 //   }
 
 
  if (document.frmDati.txtDataFineValidita.value!= "" ){
     var inizio=document.frmDati.txtDataInizioValidita.value;
         var fine=document.frmDati.txtDataFineValidita.value;
   // alert (inizio.substring(0, 2));
   //  alert (inizio.substring(3, 5));
   //  alert (inizio.substring(6,10));
     dateObjInizio = new Date( inizio.substring(6,10), inizio.substring(3, 5), inizio.substring(0, 2))
dateObjFine = new Date( fine.substring(6,10), fine.substring(3, 5), fine.substring(0, 2))
  // alert (document.frmDati.txtDataFineValidita.value);
  //   if (document.frmDati.txtDataInizioValidita.value > document.frmDati.txtDataFineValidita.value){
     if (dateObjInizio > dateObjFine){
          alert ("Data inizio validità non può essere maggiore della data fine validità");
          return;
     }
  }
    if(validazioneCampi(frmDati)){
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
     
     <% if (strOperazione.equals("Ins")){%>  
         checkCodeAccordo();  
     <%}else{%>
         openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
         frmDati.action = 'cbn1_controller_accordi.jsp?Operazione='+ '<%=strOperazione%>';
         Enable(document.frmDati.txtCodeAccordo);
         frmDati.submit();
         <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
            DisabledControlForUpdate(frmDati);
        <%}%>
    <%}%>
      
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
  
  function checkCodeAccordo() 
  {
   
    carica = function(dati){ONRITORNO(dati[0].messaggio);};
    errore = function(dati){ONRITORNO(dati[0].messaggio);};  
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
   
 //   alert('checkCodeAccordo');
    chiamaRichiesta('pstrCodeAccordo='+document.frmDati.txtCodeAccordo.value,'CheckCodeAccordo',asyncFunz);
 
  }
  
  function ONRITORNO(messaggio){
 //    alert('@'+ messaggio+'@');
  if(messaggio != 'OK'){
      alert('Questo Code Accordo è già presente.');
  }else{
      <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
          EnableAllControls(document.frmDati);
   <%}%>
      openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
      frmDati.action = 'cbn1_controller_accordi.jsp?Operazione='+ '<%=strOperazione%>';
      frmDati.submit();
      <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
         DisabledControlForUpdate(frmDati);
     <%}%>
  }
}


/* CONTROLLO SE TARIFFA E' DI REPRICING - FINE */

  
  function ONANNULLA(){


   window.close();
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

      <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals("")) ){
      
             //Svuoto le date da valori fittizzi
        pstrDATA_FINE_FATRZ =Misc.nh( clsAccordo.getDATA_FINE_FATRZ());
        pstrDATA_FINE_VALID =Misc.nh( clsAccordo.getDATA_FINE_VALID() );
        pstrDATA_FINE_TARIFFA =Misc.nh( clsAccordo.getDATA_FINE_TARIFFA() );
       if (pstrDATA_FINE_VALID.equals("31/12/2099") ){
           pstrDATA_FINE_VALID="";
       }
       if (pstrDATA_FINE_FATRZ.equals("31/12/2099") ){
          pstrDATA_FINE_FATRZ="";
       }
         if (pstrDATA_FINE_TARIFFA.equals("31/12/2099") ){
           pstrDATA_FINE_TARIFFA="";
       }
      
      %>
    
    
      frmDati.txtDescAccordo.value    = '<%=clsAccordo.getDESC_ACCORDO() %>';
      frmDati.txtCodeAccordo.value    = '<%=clsAccordo.getCODE_ACCORDO()%>';
    //  frmDati.txtDataInizioFattura.value    = '<%=clsAccordo.getDATA_INIZIO_FATRZ()%>';
    //  frmDati.txtDataFineFattura.value    = '<%=pstrDATA_FINE_FATRZ%>';
      // frmDati.txtDataInizioValidita.value    = '<%=clsAccordo.getDATA_INIZIO_VALID()%>';
      //MoS 17/11/2010 data validita è data DIF
      frmDati.txtDataInizioValidita.value    = '<%=clsAccordo.getDATA_INIZIO_FATRZ()%>';
      frmDati.txtDataInizioValiditaOld.value = '<%=clsAccordo.getDATA_INIZIO_FATRZ()%>';    
   //MoS 22-11-2010
   <%if( pstrStatoAccordo.equals("2") ){%>
      frmDati.txtDataFineValidita.value    = '<%=clsAccordo.getDATA_FINE_FATRZ()%>';
   <%}else{%>
      frmDati.txtDataFineValidita.value    = '<%=pstrDATA_FINE_VALID%>';
   <%}%>
    //  frmDati.txtDataInizioValiditaTariffa.value    = '<%=clsAccordo.getDATA_INIZIO_TARIFFA()%>';
     // frmDati.txtDataFineValiditaTariffa.value    = '<%=pstrDATA_FINE_TARIFFA%>';
      
      
      frmDati.txtFrequenzaCanone.value       = '<%=clsAccordo.getVALO_FREQ_APPL()%>';
      frmDati.cboOggettoFatturazione.value   = '<%=clsAccordo.getCODE_OGGETTO_FATRZ()%>';
      
      frmDati.cboAccountDisp.value   = '<%=clsAccordo.getCODE_ACCOUNT()%>';
      frmDati.cboOfferta.value   = '<%=clsAccordo.getCODE_OFFERTA()%>';
      
      setOptTipoTariffa('<%=clsAccordo.getTIPO_FLAG_ANT_POST()%>');
      frmDati.txtFrequenzaCanone.value       = '<%=clsAccordo.getVALO_FREQ_APPL()%>';
      frmDati.txtShiftCanone.value           = '<%=clsAccordo.getQNTA_SHIFT_CANONI()%>';
    //  frmDati.cboModalitaApplicazione.value  = '<%=clsAccordo.getCODE_MODAL_APPL_TARIFFA()%>';
       frmDati.txtMaterialeSAP.value  = '<%=clsAccordo.getCODE_MATERIALE_SAP()%>';
      
      
      
     
      <%}%>
  
//  alert('caricaDati');
  
  
  
  }
   function  caricaMaterialeSAP(val){
      var c = lstrCodeAccordo.length;
      var numfill = 13-c;
      var fill = '';
	    for (i=0 ; i < numfill;i++)
	    {
          fill = fill + '0';  
	     }
    //  alert(fill);
      frmDati.txtMaterialeSAP.value = 'AC///' + fill + val;
  
   }
  function caricaImporti(){
     <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){
        String objInputBox = "";
        String valInputBox = "";
        objInputBox = "TAR-tcf";
        valInputBox = CustomNumberFormat.setToCurrencyFormat(clsAccordo.getIMPT_TARIFFA(),2,6);
          
      %>
        document.all('<%=objInputBox%>').value = '<%=valInputBox%>';
        document.all('<%=objInputBox%>').name += '-PRT=<%=clsAccordo.getCODE_PR_TARIFFA()%>';

        nomeCampoTariffa['0'] = '<%=objInputBox%>';
    <%
         }
    %>
 
 //  alert('caricaImporti');
    }
function disableAnchor(id, disable){

var obj = document.getElementById(id); 

  if(disable){
    var href = obj.getAttribute("href");
    if(href && href != "" && href != null){
       obj.setAttribute('href_bak', href);
    }
    obj.removeAttribute('href');
 
  }
  else{
    obj.setAttribute('href', obj.attributes['href_bak'].nodeValue);
//   alert( obj.getAttribute("href"+ '  else'));
  }
}      
 

</script>




<body onfocus=" ControllaFinestra()" onmouseover="ControllaFinestra()" >


<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>

<div name="orologio" id="orologio"  style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="overflow:hidden" >
<form name="frmDati" id="frmDati" method="post" action="" target="Action"> 
              
             <!-- <INPUT type="Hidden" name="CodeTariffa" value="Code_Tariffa">
              <INPUT type="Hidden" name="PrCodeTariffa" value="Code_Pr_Tariffa">
              <INPUT type="Hidden" name="CodeAccordo" value="pstrCodeAccordo">
              <INPUT type="Hidden" name="tipo_tariffa" value="tipo_Tariffa">
              <INPUT type="Hidden" name="DataCreazione"> 
              <INPUT type="Hidden" name="SourcePage" value="URLParamAnnulla">   
              <INPUT type="Hidden" name="TipoProvvisoria" value="N">-->
 
  <TABLE align="center" width="100%" border="0"  cellspacing="0" cellpadding="0"  height="100%">
   <TR height="35">
      <TD>
        <TABLE align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
          <TR>
            <TD align="left">
           <!--   <IMG height=35 alt="" src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" border=0>-->
              &nbsp;
            </TD>
            <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB" align="middle">
              
            
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
                          Accordi
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
        <TABLE align="center" width="90%" border="0" cellspacing="0" cellpadding="0"  >
          <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>
          <TR >
             <TD class="text" nowrap align="center" colspan="2">
              Descrizione Accordo : 
              <INPUT class="text" id="txtDescAccordo" name="txtDescAccordo" obbligatorio="si"  label="Descrizione"  size="80" Update="false">
            </TD>
            <TD class="text" nowrap align="center" colspan="2">
              Codice Accordo :
             <INPUT class="text" id="txtCodeAccordo" name="txtCodeAccordo"  value='<%=pstrCodeAccordo%>' obbligatorio="si" label="Code Accordo"  size="5" Update="false">
           </TD>
          </TR>
           <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>

          <TR>
            <TD class="text" nowrap align="center" colspan="4">
              Oggetto Fatturazione :
      
              <SELECT class="text" id="cboOggettoFatturazione" name="cboOggettoFatturazione" obbligatorio="si" tipocontrollo="" label="Oggetto Fatturazione" Update="false" > 
                <option class="text"  value="">[Oggetto Fatturazione]</option>
                <%
                DB_OggettoFatturazioneNew lcls_OggFatt = null;
                vctClass = remoteEnt_Accordo.getOggettiFatturazione();
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
              <INPUT  type="radio" name="optTipoTariffa" value="R" onchange="checkOptTipoTariffa()" Update="false">Rata
            </TD>
          </TR>

          <TR>
            <TD class="text" >
              Frequenza canone :
              <!-- </TD>
            <TD>-->
              <INPUT class="text" id="txtFrequenzaCanone" name="txtFrequenzaCanone" obbligatorio="si" tipocontrollo="intero" label="Frequenza canone" Update="false" size="20">
            </TD>
            <TD class="text" colspan="3">
              Shift canone :
           <!-- </TD>
            <TD>-->
              <INPUT class="text" id="txtShiftCanone" name="txtShiftCanone" obbligatorio="si" tipocontrollo="intero" label="Shift canone" Update="false" size="20">
            </TD>
          </TR>
           <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>

         <!--  <TR >
            <TD class="text" nowrap align="center" colspan="4">
              Modalità applicazione :
           
              <SELECT class="text" id="cboModalitaApplicazione" name="cboModalitaApplicazione" onchange="change_cboModalitaApplicazione(true)" obbligatorio="si" label="Modalita applicazione"  Update="false">
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

          </TR>-->
          <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>
      <!--    <TR>
            <TD class="text" >
              Data inizio Fatturazione :&nbsp;
                  </TD>
            <TD>
              <INPUT class="text" id="txtDataInizioFattura" name="txtDataInizioFattura" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="" size="20" Update="false">
              <a href="javascript:showCalendar('frmDati.txtDataInizioFattura','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.txtDataInizioFattura);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
              <input type="hidden" id="txtDataInizioFatturaOld">
            </TD>
          
            <TD class="text" >
              Data fine Fatturazione :&nbsp;
          
              <INPUT class="text" id="txtDataFineFattura" name="txtDataFineFattura" readonly  tipocontrollo="data" label="Data Fine validità" value="" size="20" >
              <a name="calDFF" id="calDFF" class="disLink" href="javascript:showCalendar('frmDati.txtDataFineFattura','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true" ><img name="imgCalendarDFF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a name="cancDFF" id="cancDFF" class="disLink" href="javascript:clearField(frmDati.txtDataFineFattura);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"  ></a>
              <input type="hidden" id="txtDataFineFatturaOld">
            </TD>
              <TD colspan="1" width= "30px" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>-->
          <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>

             <TR>
            <TD  class="text" >
              Data inizio Validità Accordo :&nbsp;
           
              <INPUT class="text" id="txtDataInizioValidita" name="txtDataInizioValidita" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="" size="20" Update="false">
              <a name="calDIV" id="calDIV "href="javascript:showCalendar('frmDati.txtDataInizioValidita','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a name="cancDIV" id="cancDIV" href="javascript:clearField(frmDati.txtDataInizioValidita);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
              <input type="hidden" id="txtDataInizioValiditaOld">
            </TD>
      
            <TD  class="text"  >
              Data fine Validità Accordo :&nbsp;
          
              <INPUT class="text" id="txtDataFineValidita" name="txtDataFineValidita" readonly  tipocontrollo="data" label="Data Fine validità" value="" size="20" Update="false">
              <a  name="calDFV" id="calDFV" href="javascript:showCalendar('frmDati.txtDataFineValidita','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a name="cancDFV" id="cancDFV"  href="javascript:clearField(frmDati.txtDataFineValidita);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
              <input type="hidden" id="txtDataFineValiditaOld">
            </TD>
            
             <TD colspan="1" width= "30px" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>
     
           <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>

          <TR>
            <TD colspan="4">
              <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="<%=StaticContext.bgColorHeader%>" name="MasterTableTariffe" id="MasterTableTariffe" >
                <TR>
                  <TD colspan="4">
                    <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <TR>
                        <TD >
                          <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" name="HeadTableTariffe" id="HeadTableTariffe" >
                            <TR align="center">
                              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">&nbsp;Importo Tariffe per Accordo</TD>
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
              <TD  >
               <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" name="BodyTableTariffe" id="BodyTableTariffe" bordercolor="#ffffff">
               </TABLE>
                </TD>
           <!--        <TD class="row1" align= "center">
          
             Data inizio Validità Tariffa :
           
              <INPUT class="text" id="txtDataInizioValiditaTariffa" name="txtDataInizioValiditaTariffa" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="" size="20" Update="false">
              <a href="javascript:showCalendar('frmDati.txtDataInizioValiditaTariffa','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.txtDataInizioValiditaTariffa);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
              <input type="hidden" id="txtDataInizioValiditaTariffaOld">
            </TD>
              </TR>
           <TR>
            <TD >
            <TABLE width="100%" border="0" bordercolor="red" cellspacing="0" cellpadding="0" name="dateTariffe" id="dateTariffe" >
                
          
             <TD class="row1">
              Data fine Validità Tariffa:
            </TD>
            <TD class="row1" >
              <INPUT class="text" id="txtDataFineValiditaTariffa" name="txtDataFineValiditaTariffa" readonly  tipocontrollo="data" label="Data Fine validità" value="" size="20" Update="false">
              <a href="javascript:showCalendar('frmDati.txtDataFineValiditaTariffa','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.txtDataFineValiditaTariffa);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
              <input type="hidden" id="txtDataFineValiditaTariffaOld">
            </TD>
            
            </TABLE>
            </TD>
          </TR>-->
               
              </TABLE>
            </TD>
          </TR>
          
       

          <TR name="trTariffaPerc" id="trTariffaPerc" style="display:none" height="35">
             <TD colspan="4">
            <!--  <HR> -->
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
             <!-- <TR>
            <TD>&nbsp;</td>
           </TR>
        <TR>
            <TD colspan="4">
              <HR>
            </TD>
          </TR>-->
           <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>

          <TR>
               <TD class="text" nowrap colspan= "4" >Account:&nbsp;
           
           <!--</td>
                   <td colspan= "3" >-->
                    <Select class="text" name="cboAccountDisp" id="cboAccountDisp" Update="false" >
                    <option class="text"  value="">[Seleziona Account]</option>
                      <%
                      //Caricamento combo offerte in base al parametro della querystring
                       DB_Account lcls_Account = null;
                      for (int i = 0;i < vctAccount.size();i++){
                        lcls_Account = (DB_Account)vctAccount.get(i);
                      /*  if (lcls_Account. getCODE_ACCOUNT().equals(strAccount)){
                             strSelected = "selected";
                        }else{
                            strSelected = "";
                         }
                       */  
                         %><OPTION value="<%=lcls_Account.getCODE_ACCOUNT()%>" <%=strSelected%> ><%=lcls_Account.getDESC_ACCOUNT()%>  </OPTION><%
                      }%>
                          </Select>
                      </TD>
                  
                    </TR>
             <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>

          <tr>
           <TD class="text" nowrap colspan= "4" >Offerta :&nbsp;
           
           <!--</td>
                   <td colspan= "3" >-->
               		<select class="text" title="Offerta" name="cboOfferta" id="cboOfferta" onchange="change_cboOfferta();"  Update="false">
                        
                          <option class="text"  value="">[Seleziona Offerta]</option>
                                 <%
                                //Caricamento combo offerte in base al parametro della querystring
                                DB_Offerta lcls_Offerta = null;
                                for (int i = 0;i < vctOfferte.size();i++){
                                  lcls_Offerta = (DB_Offerta)vctOfferte.get(i);
                               /*   if (lcls_Offerta.getCODE_OFFERTA().equals(clsAccordo.getCODE_OFFERTA())){
                                      strSelected = "selected";
                                  }else{
                                      strSelected = "";
                                  }
                               */  
                               if (!lcls_Offerta.getCODE_OFFERTA().equals("10000") ){
                                  %><OPTION value="<%=lcls_Offerta.getCODE_OFFERTA()%>" <%=strSelected%> ><%=lcls_Offerta.getDESC_OFFERTA()%>  </OPTION><%
                                }  
                                }%>
     
                      
                        </select>
                      </td>
               </tr>
      <!--    <TR>
            <TD colspan="4">
              <HR>
            </TD>
          </TR>-->
                    <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
            </TD>
          </TR>
           <TR >  
           <TD class="text" nowrap colspan= "4" > Materiale SAP : &nbsp;
           <!--</td>
             <TD class="text" nowrap align="center" colspan="3">
            --> 
              <INPUT class="text" id="txtMaterialeSAP" name="txtMaterialeSAP" obbligatorio="si"  label="Materiale SAP"  size="20" Update="false">
            </TD>
          
          </TR>

                   <TR >
            <TD colspan="4" height="5" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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
                    <SELECT class="text" id="cboRegola" name="cboRegola" onchange="change_cboRegola()" obbligatorio="no" Update="false">
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
                    <INPUT class="text" size="10" id="txtParamRegola" name="txtParamRegola" obbligatorio="no">
                    <img align="center" height="50" width="50" name="imgGruppo" alt="Seleziona Gruppo"  src="<%=StaticContext.PH_TARIFFE_IMAGES%>Gruppo.gif" style="cursor:hand" onclick="selezionaGruppo()" border="0">                    
                    <INPUT class="text" id="txtDataParametro" name="txtDataParametro" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="<%="01/01/2005"%>" size="11">
                    <a href="javascript:showCalendar('frmDati.txtDataParametro','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar2" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                    <a href="javascript:clearField(frmDati.txtDataParametro);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel2" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
                  </TD>
                  <TD align="right">
                    <INPUT class="textB" type="button" name="btnAggiungiRegola" id="btnAggiungiRegola" value="Aggiungi" onclick="AggiungiRegola()" Update="false">
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
                    <TABLE width="100%" border="0"  cellspacing="1" cellpadding="0" name="TableRegole" id="TableRegole">
                    <%
                      if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){
                        vctRegoleTariffa = remoteEnt_Accordo.getRegoleTariffa(Integer.parseInt(clsAccordo.getCODE_TARIFFA()),0);
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
                                <%=clsRegolaTariffa.getPARAMETRO()%>
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
        <TABLE align="center"  width="90%" border="0" cellspacing="0" cellpadding="0">
          <TR>
            <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"></td> 
            <td class="text" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
              <sec:ShowButtons td_class="textB"/>
            </td>
            <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"></td> 
          </TR>
        </TABLE>
      </TD>
    </TR>
  </TABLE>
</form>
</div>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
 var lstrCodeAccordo = '<%=pstrCodeAccordo%>';

    CaricaTabellaTariffe();
    caricaDati();
 //   change_cboModalitaApplicazione(false);
    checkOptTipoTariffa();
    caricaImporti();
    <%if(!pstrCodeAccordo.equals("") && (pNuovo.equals(""))){%>
        Disable(document.frmDati.txtCodeAccordo);
      
    <%}%>
   <%if(!(pNuovo.equals(""))){%>
  
      caricaMaterialeSAP(lstrCodeAccordo);
   <%}%>   
   <%if(pstrStatoAccordo.equals("1") || pstrStatoAccordo.equals("2") ){%>
        DisabledControlForUpdate(frmDati);
        disableAnchor('cancDFV',true);
        disableAnchor('calDFV',true);  
        disableAnchor('cancDIV',true);
        disableAnchor('calDIV',true);  
      
    <%}%>
    //SE L'ACCORDO é CESSATO NON può CESSARE nuovamente
    <%if(pstrStatoAccordo.equals("2") ){%> 
      Disable(document.frmDati.ACCORDI);
    <%}%> 
       //SE NUOVO non POSSO impostare DFF
       

    //Posso solo cessare per questo abilito solo la DFV
    <%if((strOperazione.equals("Upd") && pstrStatoAccordo.equals("1")) || 
        (strOperazione.equals("Upd") && pstrStatoAccordo.equals("2") && !strFlagCong.equals("C") )
        ){%> 

         Enable(document.frmDati.txtDataFineValidita);
         disableAnchor('cancDFV',false);
         disableAnchor('calDFV',false);  
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