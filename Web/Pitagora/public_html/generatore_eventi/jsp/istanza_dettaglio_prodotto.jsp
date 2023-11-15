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
<%=StaticMessages.getMessage(3006,"istanza_dettaglio_prodotto.jsp")%>
</logtag:logData>


<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>

<%
  int isCessaAttiva =0;
  int Code_Offerta = 0;
  int Code_Prodotto = 0;
  int Code_Servizio = 0;
  String Code_Causale = Misc.nh(request.getParameter("CodeCausale"));
  String Code_Ist_Prod = "";
  if(request.getParameter("Code_Ist_Prod_pagina") == null){
    Code_Ist_Prod = Misc.nh(request.getParameter("Istanza"));
  }else{
    Code_Ist_Prod = Misc.nh(request.getParameter("Code_Ist_Prod_pagina"));
  }
  String Code_Agg = Misc.nh(request.getParameter("aggiorna"));

  // se sono stato lanciato da seleziona_inventario
  if ( Code_Agg.equals("1") ) {
   session.setAttribute("hidTypeLoadProd", "0");
   session.setAttribute("hidTypeLoadCompo", "0");
   session.setAttribute("hidTypeLoadPrestAgg", "0");
   session.setAttribute("hidTypeLoadPP", "0");
   session.setAttribute("hidTypeLoadITC", "0");
   session.setAttribute("hidTypeLoadITC_REV", "0");
   session.setAttribute("hidTypeLoadRPVD", "0");
   session.setAttribute("hidTypeLoadATM", "0");
   session.setAttribute("ableCreaEvento", "0");
   session.setAttribute("elemNonModif","0");

   /* azzero i vettori di componenti e prest_agg */
   session.setAttribute("vct_InventariCompo",null);
   session.setAttribute("vct_InventariPrestAgg",null);
  }

  String strtypeLoad;
  strtypeLoad = Misc.nh(request.getParameter("hidTypeLoadProd"));
  if ( strtypeLoad.equals("") )
      strtypeLoad = (String)session.getAttribute("hidTypeLoadProd");

//GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector vct_Inventari = null;
  
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0) {
    vct_Inventari = (Vector) session.getAttribute("vct_Inventari");
  }
  else
  {
    vct_Inventari =  remoteEnt_Inventari.getInventarioProdotti(Code_Ist_Prod.trim());
    if (vct_Inventari!=null) {
      session.setAttribute("vct_Inventari", vct_Inventari);
      session.setAttribute("ctrlvct_Inventari", vct_Inventari);
      session.setAttribute("hidTypeLoadProd", "1");
    }
  }
//FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  DB_InventProd data_Inventari=null;
  String URLParam =null;
  String PaginaRichiamata = null;
  int intTrovato = vct_Inventari.size();
  if ( intTrovato == 0 ) {
  }
  else {
        data_Inventari = (DB_InventProd)vct_Inventari.get(0);
        URLParam = "?Istanza=" + Code_Ist_Prod + "&Servizio=" + data_Inventari.getCODE_SERVIZIO();
        
        PaginaRichiamata = "istanza_dettaglio_anagrafico_" + data_Inventari.getCODE_SERVIZIO();

      /* Se il prodotto risulta cessato faccio in modo che non si possa cambiare
          le componenti e le prestazioni ad esso associate*/
      if(  data_Inventari.getCODE_STATO_ELEM().equals("2") ) {
            session.setAttribute("elemNonModif", "1");
      }
      else session.setAttribute("elemNonModif", "0");


      /* Trasformazione!! 
        Se l'elemento è stato trasformato attualmente non viene data la possibilità
        all'utente di poter effettuare le modifiche su di esso in quanto la trasformazione per 
        rettifica sarà oggetto di nuovi sviluppi futuri
       */
      /*Successivamente eliminare Controllo INIZIO*/
      if ( data_Inventari.getCODE_STATO_ELEM_PREC().equals("4") ) {
        if (StaticContext.VERSIONE_JPUB.equals("1.9.1.2") ) {
            session.setAttribute("elemNonModif", "1");
        }
      }
      
     /*MoS VARIAZIONE x CESSA/ATTIVA*/
     //==========================================================================
       int CodeStatoElem = remoteEnt_Inventari.checkCodeStatoElem(Code_Ist_Prod);
      if (CodeStatoElem ==1 ) {
          isCessaAttiva=1;
       /*    int elemCess =0;
           int elemAtt =0;
        
           DB_InventCompo data_InventariCompo =null;
           Vector vct_InventariCompo =  remoteEnt_Inventari.getInventarioComponenti(data_Inventari.getCODE_ISTANZA_PROD());
             int i = 0;
                for (i = 0;i < vct_InventariCompo.size();i++){
                data_InventariCompo = (DB_InventCompo)vct_InventariCompo.get(i);
                //cessato
                 if  (data_InventariCompo.getCODE_STATO_ELEM().equals("2")){
                     elemCess= 1;
                 }
                 //attivato
                 if  (data_InventariCompo.getCODE_STATO_ELEM().equals("1")){
                     elemAtt= 1;
                 }
                 if (elemAtt== 1 ||  elemCess== 1){
                     isCessaAttiva=1;
                 }
                }
               */ 
      }
       //==========================================================================
   
   
   
      /*Successivamente eliminare Controllo FINE*/
      /* Verifico se devo effettuare l'aggiornamento sul dato */
      if ( ( typeLoad == 0 )|| ( typeLoad == 1 ) ) {
        /*NUOVO*/
      }
      else { 
        /*Aggiornamento*/
        data_Inventari.Modifica();

        /*Se la modifica effettuata sul prodotto comporta di rinviare tutto il prodotto comprensivo di
        Componenti e prestazioni aggiuntive, quindi
        se cambio l'offerta o il servizio o l'account o il prodotto INIZIO
        
        oppure se vario la causale attivazione e non è un cessaAttiva
        oppuere se vario la cessazione il prodotto non è cessato e non è un cessaAttiva
        
         && (!data_Inventari.getCODE_SERVIZIO().equals("3") && !data_Inventari.getCODE_SERVIZIO().equals("5") )
        */
        if ( !data_Inventari.getCODE_OFFERTA().equals(Misc.nh(request.getParameter("srcCodeOfferta")))
              ||
            !data_Inventari.getCODE_SERVIZIO().equals(Misc.nh(request.getParameter("srcCodeServizio")))
              ||
            !data_Inventari.getCODE_ACCOUNT ().equals(Misc.nh(request.getParameter("srcCodeAccount")))
             ||
            !data_Inventari.getCODE_PRODOTTO().equals(Misc.nh(request.getParameter("strCodeProdotto")))
            ||
            (!data_Inventari.getTIPO_CAUSALE_ATT() .equals(Misc.nh(request.getParameter("strTipoCausaleAtt"))) 
                  && isCessaAttiva!= 1 )
            ||
            (!data_Inventari.getTIPO_CAUSALE_CES().equals(Misc.nh(request.getParameter("strTipoCausaleCes")))
            && !data_Inventari.getCODE_STATO_ELEM().equals("2") && isCessaAttiva!= 1 )
       ) 
        {
              data_Inventari.ModificaFigli();
        }
        
        /* FINE */
        
        data_Inventari.setCODE_SERVIZIO    (Misc.nh(request.getParameter("srcCodeServizio")));
        data_Inventari.setDESC_SERVIZIO    (Misc.nh(request.getParameter("strDescServizio")));
        data_Inventari.setCODE_ACCOUNT     (Misc.nh(request.getParameter("srcCodeAccount")));
        data_Inventari.setDESC_ACCOUNT     (Misc.nh(request.getParameter("strDescAccount")));
        data_Inventari.setCODE_OFFERTA     (Misc.nh(request.getParameter("srcCodeOfferta")));
        data_Inventari.setDESC_OFFERTA     (Misc.nh(request.getParameter("strDescOfferta")));
        data_Inventari.setCODE_PRODOTTO    (Misc.nh(request.getParameter("strCodeProdotto")));
        data_Inventari.setDESC_PRODOTTO    (Misc.nh(request.getParameter("strDescProdotto")));
      

        data_Inventari.setTIPO_CAUSALE_ATT (Misc.nh(request.getParameter("strTipoCausaleAtt")));
        data_Inventari.setDESC_TIPO_CAUSALE_ATT(Misc.nh(request.getParameter("strDescCausaleAtt")));
        data_Inventari.setTIPO_CAUSALE_CES (Misc.nh(request.getParameter("strTipoCausaleCes")));
        data_Inventari.setDESC_TIPO_CAUSALE_CES(Misc.nh(request.getParameter("strDescCausaleCes")));
        data_Inventari.setDATA_INIZIO_VALID(Misc.nh(request.getParameter("strDataInizioValid")));
        data_Inventari.setDATA_FINE_VALID  (Misc.nh(request.getParameter("strDataFineValid")));
        data_Inventari.setQNTA_VALO        (Misc.nh(request.getParameter("srcQNTA")));
        data_Inventari.setDATA_INIZIO_FATRZ(Misc.nh(request.getParameter("srcDIF")));
        //data_Inventari.setDATA_FINE_FATRZ  (Misc.nh(request.getParameter("srcDFF")));
        //QS 21/05/2008: Nel passaggio da componente a prodotto si perdeva il valore di strDataFineFatrz
        data_Inventari.setDATA_FINE_FATRZ  (Misc.nh(request.getParameter("strDataFineFatrz")));
        data_Inventari.setDATA_DRO         (Misc.nh(request.getParameter("strDataRicezOrdine")));
        data_Inventari.setDATA_CREAZ       (Misc.nh(request.getParameter("strDataCreaz")));
        data_Inventari.setDATA_DIN         (Misc.nh(request.getParameter("strDataInizioNol")));
        data_Inventari.setCODICE_PROGETTO  (Misc.nh(request.getParameter("srcCodeProgetto")));
     
        data_Inventari.setDATA_CESSAZ (Misc.nh(request.getParameter("strDataCessaz")));
        
        //MoS 20/10/2010
          //NEL CASO DI CESSAZIONE QUESTE 2 DATE le prendo dallo STORICO
          //===========================================================
          if(  data_Inventari.getCODE_STATO_ELEM().equals("2") ) { 
             Vector vct_stInventProd = null;
             vct_stInventProd =  remoteEnt_Inventari.getstPrenvProdxCessazione(Code_Ist_Prod.trim());
             DB_InventProd data_stInventProd=null;
             data_stInventProd = (DB_InventProd)vct_stInventProd.get(0);
             
             data_Inventari.setDATA_DRO (data_stInventProd.getDATA_DRO());
             data_Inventari.setDATA_DEE (data_stInventProd.getDATA_DEE());
           //  data_Inventari.setDATA_CESSAZ (data_stInventProd.getDATA_CESSAZ());
            data_Inventari.setDATA_DIN (data_stInventProd.getDATA_DIN());
             //MoS 15/11/2010
             //se cambio la data cessazione reimposto la DEE
           //  if (request.getParameter("strDataCessaz") != null){
           //      if (!data_Inventari.getDATA_CESSAZ().equals( Misc.nh(request.getParameter("strDataCessaz")))){
           //          data_Inventari.setDATA_CESSAZ (Misc.nh(request.getParameter("strDataCessaz")));
           //          data_Inventari.setDATA_DEE (Misc.nh(request.getParameter("strDataCessaz")));
           //      }
           //  }
          
          
          } 
          //===========================================================

   
      
/*   Vector vct_stInventProd = null;
   vct_stInventProd =  remoteEnt_Inventari.getstPrenvProdxCessazione(Code_Ist_Prod.trim());
   DB_InventProd data_stInventProd=null;
   data_stInventProd = (DB_InventProd)vct_stInventProd.get(0);
   data_Inventari.setDATA_DIN(data_stInventProd.getDATA_DIN()); 
*/
        session.setAttribute("hidTypeLoadProd", "1");
        //session.setAttribute("hidTypeLoadCompo", "1");
        //session.setAttribute("hidTypeLoadPrestAgg", "1");
        //session.setAttribute("hidTypeLoadPP", "1");
        //session.setAttribute("hidTypeLoadMP", "1");
        //session.setAttribute("hidTypeLoadRPVD", "1");
        //session.setAttribute("hidTypeLoadATM", "1");
        vct_Inventari.setElementAt(data_Inventari,0);
        session.setAttribute("vct_Inventari", vct_Inventari);
        
        if (request.getParameter("abilitaModifiche").equals("1")){
          session.setAttribute("ableCreaEvento", "1");
        }else{
          session.setAttribute("ableCreaEvento", "0");
        }
        URLParam = URLParam + "&Code_Ist_Prod_pagina=" +Code_Ist_Prod;
        String pagina_destinazione = request.getParameter("paginaDestinazione");
        session.setAttribute("parsrcCodeServizio",request.getParameter("srcCodeServizio"));
        session.setAttribute("parstrDescServizio",request.getParameter("strDescServizio"));
        session.setAttribute("parsrcCodeAccount",request.getParameter("srcCodeAccount"));
        session.setAttribute("parstrDescAccount",request.getParameter("strDescAccount"));
        session.setAttribute("parsrcCodeOfferta",request.getParameter("srcCodeOfferta"));
        session.setAttribute("parstrDescOfferta",request.getParameter("strDescOfferta")); 
        session.setAttribute("parstrCodeProdotto",request.getParameter("strCodeProdotto"));
        session.setAttribute("parstrDescProdotto",request.getParameter("strDescProdotto"));

        response.sendRedirect(pagina_destinazione+URLParam);
     }

     
  }

  String strEnableCreaEvento = (String) session.getAttribute("ableCreaEvento");
  if ( strEnableCreaEvento == null )  session.setAttribute("ableCreaEvento", "0");

  //Controllo le abilitazione dell'upd e del del
  boolean EnableUpd = true;
  boolean EnableDel = true;

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Inventario Prodotto
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

  function ONANNULLAMODIFICHE() {
    frmDati.hidTypeLoadProd.value = '0';
    frmDati.submit();
  }  

  function ableCreaEvento () {
    <% if ( strEnableCreaEvento.equals("1") ) { %>
      Enable ( frmDati.CREAEVENTO );
      Enable ( frmDati.ANNULLAMODIFICHE);
      Enable ( frmDati.RETTIFICA);
    <% } %>
  }

  function ONSALVA(pagina) {
 
  
    ONRETTIFICA_SALVA();
    var Errore = 0;     
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
    
 
    if (Errore == 0) {
      frmDati.hidTypeLoadProd.value = '2';
//      alert(pagina);
//      pagina = pagina +  '?parstrDescServizio=' + frmDati.strDescServizio.value +'&' ;
//    alert(pagina);
      
      frmDati.paginaDestinazione.value = pagina;
   /*  frmDati.parametri.value ='&parsrcCodeServizio='+  frmDati.srcCodeServizio.value +
    '&strDescServizio=' + frmDati.strDescServizio.value  + 
    '&parsrcCodeAccount=' +  frmDati.srcCodeAccount.value  + 
    '&parstrDescAccount=' +  frmDati.strDescAccount.value   + 
    '&parsrcCodeOfferta=' + frmDati.srcCodeOfferta.value  + 
    '&parstrDescOfferta=' + frmDati.strDescOfferta.value  + 
    '&parstrCodeProdotto='  + frmDati.strCodeProdotto.value  + 
    '&parstrDescProdotto='  + frmDati.strDescProdotto.value    ;
*/
     //alert(frmDati.parametri.value );

       frmDati.submit();
      DisabilitaProdotto();
      return true;
    }
  }

function controllaVariazioneProd(objwind){
objwind.close(); 

   if (frmDati.strCodeProdotto.value != frmDati.strCodeProdotto.title) {
      window.setTimeout("alert('Le modifiche Prodotto saranno propagate a Componenti e Prest. Agg.');",300);
    }
}

  function caricaDati(){
    frmDati.LinkAbilitato.value = '1';
    <%
    if ( data_Inventari == null ) {%>
      alert('istanza prodotto ricercata non è presente in inventario');
      window.close();	
    <%
    } 
    else 
    {
    %>
      frmDati.srcCodeAccount.value      = '<%=data_Inventari.getCODE_ACCOUNT()%>';
      frmDati.srcCodeStato.value        = '<%=data_Inventari.getCODE_STATO_ELEM()%>';
      frmDati.srcCodeOfferta.value      = '<%=data_Inventari.getCODE_OFFERTA()%>';
      frmDati.srcCodeServizio.value     = '<%=data_Inventari.getCODE_SERVIZIO()%>';
      frmDati.strCodeProdotto.value     = '<%=data_Inventari.getCODE_PRODOTTO()%>';
      frmDati.srcDIF.value              = '<%=data_Inventari.getDATA_INIZIO_FATRZ()%>';
      frmDati.srcQNTA.value             = '<%=data_Inventari.getQNTA_VALO()%>';
      frmDati.srcCicloVal.value         = '<%=data_Inventari.getCODE_ULTIMO_CICLO_FATRZ()%>';
      frmDati.strDataFineFatrz.value    = '<%=data_Inventari.getDATA_FINE_FATRZ()%>';
      frmDati.strTipoCausaleAtt.value   = '<%=data_Inventari.getTIPO_CAUSALE_ATT()%>';
      frmDati.strDataInizioValid.value  = '<%=data_Inventari.getDATA_INIZIO_VALID()%>';
      frmDati.strDataFineValid.value    = '<%=data_Inventari.getDATA_FINE_VALID()%>';
      frmDati.strDataCessaz.value       = '<%=data_Inventari.getDATA_CESSAZ()%>';
      frmDati.strTipoCausaleCes.value   = '<%=data_Inventari.getTIPO_CAUSALE_CES()%>';
      frmDati.strDataFineNol.value      = '<%=data_Inventari.getDATA_FINE_NOL()%>';
      frmDati.strDescAccount.value      = '<%=data_Inventari.getDESC_ACCOUNT()%>';
      frmDati.strDescOfferta.value      = '<%=data_Inventari.getDESC_OFFERTA()%>';
      frmDati.strDescServizio.value     = '<%=data_Inventari.getDESC_SERVIZIO()%>';
      frmDati.strDescStato.value        = '<%=data_Inventari.getDESC_STATO_ELEM()%>';
      frmDati.strDescCausaleAtt.value   = '<%=data_Inventari.getDESC_TIPO_CAUSALE_ATT()%>';
      frmDati.strDescCausaleCes.value   = '<%=data_Inventari.getDESC_TIPO_CAUSALE_CES()%>';
      frmDati.strDescProdotto.value     = '<%=data_Inventari.getDESC_PRODOTTO()%>';
      frmDati.strDescCiclo.value        = '<%=data_Inventari.getDESCRIZIONE_CICLO()%>';
      frmDati.strDataInizioNol.value    = '<%=data_Inventari.getDATA_DIN()%>';
      frmDati.strDataRicezOrdine.value  = '<%=data_Inventari.getDATA_DRO()%>';
      frmDati.strDataCreaz.value        = '<%=data_Inventari.getDATA_CREAZ()%>';
      frmDati.srcCodeProgetto.value     = '<%=data_Inventari.getCODICE_PROGETTO()%>';
      <% /*Successivamente eliminare Controllo INIZIO*/
      if ( data_Inventari.getCODE_STATO_ELEM_PREC().equals("4") ) {
        /* Trasformazione!! 
        Se l'elemento è stato trasformato attualmente non viene data la possibilità
        all'utente di poter effettuare le modifiche su di esso in quanto la trasformazione per 
         sarà oggetto di nuovi sviluppi futuri
        */
        if (StaticContext.VERSIONE_JPUB.equals("1.9.1.2") ) {
          %>
          Disable(frmDati.RETTIFICA);
          Disable(frmDati.CREAEVENTO);
          alert('Attenzione!! la rettifica di una trasformazione è oggetto di futuri sviluppi. Impossibile modificare i dati');
          <% 
        } 
      } 
      /*Successivamente eliminare Controllo FINE*/
      %>
    <%
    } 
    %>
  }
  
   function ONRETTIFICA() {



<%/*
// se lo stato del prodotto è cessato o variato non sarà possibile cambiare le informazioni di catalogo
if  ((intTrovato != 0 )&& (data_Inventari.getCODE_STATO_ELEM_PREC().equals("4") || 
(data_Inventari.getCODE_STATO_ELEM().equals("1") && data_Inventari.getCODE_STATO_ELEM_PREC().equals("-1")))) {*/%>
<%
//attivazioni/variazioni/trasformazione
 if ( data_Inventari.getCODE_STATO_ELEM().equals("1") || data_Inventari.getCODE_STATO_ELEM().equals("3") || data_Inventari.getCODE_STATO_ELEM().equals("4")) {
%>

        Enable(frmDati.cmdServizio);
        Enable(frmDati.cmdAccount);
        Enable(frmDati.cmdOfferta);
        Enable(frmDati.cmdProdotto);
        Enable(frmDati.srcCodeAccount);
        Enable(frmDati.srcCodeOfferta);
        Enable(frmDati.srcCodeServizio);
        Enable(frmDati.strCodeProdotto);
        Enable(frmDati.srcDIF);
        Enable(frmDati.srcQNTA);
    //    Enable(frmDati.strDataFineFatrz);
        Enable(frmDati.strTipoCausaleAtt);
        Enable(frmDati.strDataCessaz);
        Enable(frmDati.strTipoCausaleCes);
//        Enable(frmDati.strDataFineValid);
        Enable(frmDati.strDescAccount);
        Enable(frmDati.strDescOfferta);
        Enable(frmDati.strDescServizio);
        Enable(frmDati.strDescCausaleAtt);
        Enable(frmDati.strDescCausaleCes);
        Enable(frmDati.strDescProdotto);
        Enable(frmDati.cmdCausaleCes);
        Enable(frmDati.cmdCausaleAtt);
   

        Enable(frmDati.strDataInizioNol);
        Enable(frmDati.strDataRicezOrdine);
        Enable(frmDati.srcCodeProgetto);

        //Enable ( frmDati.SALVA);
        Enable ( frmDati.CREAEVENTO);
        Enable ( frmDati.ANNULLAMODIFICHE);

        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCancelDCE);
        EnableLink(document.links[2],document.frmDati.imgCalendarDFN);
        EnableLink(document.links[3],document.frmDati.imgCancelDFN);
        EnableLink(document.links[4],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[5],document.frmDati.imgCancelDIF);
   //     EnableLink(document.links[6],document.frmDati.imgCalendarDFF);
   //     EnableLink(document.links[7],document.frmDati.imgCancelDFF);
   //     EnableLink(document.links[8],document.frmDati.imgCalendarDIV);
   //     EnableLink(document.links[9],document.frmDati.imgCancelDIV);
   //     EnableLink(document.links[10],document.frmDati.imgCalendarDFV);
  //      EnableLink(document.links[11],document.frmDati.imgCancelDFV);
        EnableLink(document.links[12],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[13],document.frmDati.imgCancelDIN);
        EnableLink(document.links[14],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[15],document.frmDati.imgCancelDRO);
        frmDati.abilitaModifiche.value = "1";
        
     
<% } %>   

<% 
//cessazione
if ( data_Inventari.getCODE_STATO_ELEM().equals("2")) {
%>

        Enable(frmDati.strTipoCausaleCes);
        Enable(frmDati.strDataCessaz);
        Enable(frmDati.strDescCausaleCes); 
        Enable(frmDati.cmdCausaleCes);

        EnableLink(document.links[0],document.frmDati.imgCalendarDCE);
        EnableLink(document.links[1],document.frmDati.imgCancelDCE);
        
        Enable ( frmDati.CREAEVENTO);
        Enable ( frmDati.ANNULLAMODIFICHE);
        
<% } %>   

   }

   function ONRETTIFICA_SALVA() {

// se lo stato del prodotto è cessato o variato non sarà possibile cambiare le informazioni di catalogo

<% if  ((intTrovato != 0 )&& (data_Inventari.getCODE_STATO_ELEM_PREC().equals("4") || 
(data_Inventari.getCODE_STATO_ELEM().equals("1") && data_Inventari.getCODE_STATO_ELEM_PREC().equals("-1")))) {%>
        Enable(frmDati.cmdServizio);
        Enable(frmDati.cmdAccount);
        Enable(frmDati.cmdOfferta);
<% } %>

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
        Enable(frmDati.strDescAccount);
        Enable(frmDati.strDescOfferta);
        Enable(frmDati.strDescServizio);
        Enable(frmDati.strDescCausaleAtt);
        Enable(frmDati.strDescCausaleCes);
        Enable(frmDati.strDescProdotto);
        Enable(frmDati.cmdProdotto);

        if ( frmDati.srcCodeStato.value == '2' ) {
          Enable(frmDati.cmdCausaleCes);
        } else {
          Enable(frmDati.cmdCausaleAtt);
        }

        Enable(frmDati.strDataInizioNol);
        Enable(frmDati.strDataRicezOrdine);
        Enable(frmDati.srcCodeProgetto);

        //Enable ( frmDati.SALVA);
        Enable ( frmDati.CREAEVENTO);
        Enable ( frmDati.ANNULLAMODIFICHE);

        EnableLink(document.links[4],document.frmDati.imgCalendarDIF);
        EnableLink(document.links[5],document.frmDati.imgCancelDIF);
        EnableLink(document.links[12],document.frmDati.imgCalendarDIN);
        EnableLink(document.links[13],document.frmDati.imgCancelDIN);
        EnableLink(document.links[14],document.frmDati.imgCalendarDRO);
        EnableLink(document.links[15],document.frmDati.imgCancelDRO);
   }

   function ONSALVA_EVENTO(){
     var ritorno = ONSALVA(frmDati.paginaSorgente.value);
     if(ritorno==true){
       inserisciNote();
        ONCREAEVENTO();
      }
   }
   
   
function lancioComponenti(elemCessaAttiva,paramTipo){
  // alert(paramTipo);
  // alert(elemCessaAttiva);

    if (elemCessaAttiva == 1){
        openCentral('elenco_componenti.jsp?CodeIstProd=' + frmDati.Code_Ist_Prod_pagina.value + '&paramTipo='+ paramTipo,'ElencoComponenti','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
    }

}
   
function CallParentWindowFunction()
{
  window.setTimeout("lancioComponenti(<%=isCessaAttiva%>,'C_A')", 200)
}   
function ChiudiCallParentWindowFunction()
{
//alert('ChiudiCallParentWindowFunction');
  setTimeout("window.opener.CallAlert(); window.close();",6000);
 
}      

   
</SCRIPT>
<body onLoad="resizeTo(screen.width,screen.height)" onfocus=" ControllaFinestra()" onmouseover=" ControllaFinestra()" >
    <FORM name="frmDati" id="frmDati" action="" method="post">
    <input type="hidden" name="paginaDestinazione" value="">
    <input type="hidden" name="abilitaModifiche" value="<%=strEnableCreaEvento%>">
    <input type="hidden" name="rettifica" value="0">
    <input type="hidden" name="hidTypeLoadProd" value="">
    <input type="hidden" name="LinkAbilitato" value="">
    <input type="hidden" name="paginaSorgente" value="istanza_dettaglio_prodotto.jsp?Istanza=<%=Code_Ist_Prod%>">
    <input type="hidden" name="Code_Ist_Prod_pagina" value="<%=Code_Ist_Prod%>">
    
    <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0"height="100%">
      <TR height="35">
          <TD>
             <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
             <TR>
              <TD align="left">
                <IMG alt="" src="../images/GeneratoreEventi.gif" border="0">
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
              <TD bgcolor="<%=StaticContext.bgColorTabellaForm%>" class="blackB" width="150">
                Prodotto
              </TD>
          <%         
          
          /*if(!(data_Inventari.getCODE_SERVIZIO().equals("5") || data_Inventari.getCODE_SERVIZIO().equals("6")))
          {*/

          %>              
         
              <TD id="TDComponente" id="TDComponente" bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('istanza_dettaglio_componente.jsp');">
                Componente
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('istanza_dettaglio_prest_agg.jsp');">
                Prestazioni Aggiuntive
              </TD>
          <%/*}*/%>
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="150" style="CURSOR: hand" onclick="ONSALVA('<%=PaginaRichiamata%>.jsp');">
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
          <TABLE ALIGN=center BORDER=1 CELLPADDING=1 CELLSPACING=1 WIDTH=80% HEIGHT=9>
           <TR>
            <TD class="text"> Servizio:  </TD>
            <TD colspan=3>
              <INPUT class="text" id="srcCodeServizio" name="srcCodeServizio" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Servizio" Update="false" size="13">
              <INPUT class="text" id="strDescServizio" name="strDescServizio" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Servizio" Update="false" size="35">
              <input class="text" title="Selezione Servizio" type="button" maxlength="30" id="cmdServizio" name="cmdServizio" value="..." onClick="click_cmdServizio();">
            </TD>
          </TR>
           <TR>
            <TD class="text"> Codice Account: </TD>
            <TD colspan="3">
              <INPUT class="text" id="srcCodeAccount" name="srcCodeAccount" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13">
              <INPUT class="text" id="strDescAccount" name="strDescAccount" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Account" Update="false" size="35">
              <input class="text" title="Selezione Account" type="button" maxlength="30" name="cmdAccount" value="..." onClick="click_cmdAccount();">
            </TD>
          </TR>
          <TR>
            <TD class="text"> Offerta:  </TD>
            <TD colspan="3">
              <INPUT class="text" id="srcCodeOfferta" name="srcCodeOfferta" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Offerta" Update="false" size="13">
              <INPUT class="text" id="strDescOfferta" name="strDescOfferta" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Offerta" Update="false" size="35">
              <input class="text" title="Selezione Offerta" type="button" maxlength="30" name="cmdOfferta" value="..." onClick="click_cmdOfferta();">
            </TD>
          </TR>
          <TR>
            <TD class="text"> Prodotto: </TD>
            <TD colspan="3">
              <INPUT class="text" id="strCodeProdotto" name="strCodeProdotto" readonly obbligatorio="si" tipocontrollo="intero" label="Codice Prodotto" Update="false" size="13"  title= "<%=data_Inventari.getCODE_PRODOTTO()%>" >
              <INPUT class="text" id="strDescProdotto" name="strDescProdotto" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Prodotto" Update="false" size="35">
              <input class="text" title="Selezione Prodotto" type="button" maxlength="30" name="cmdProdotto" value="..." onClick="click_cmdProdotto();" >
            </TD>
          </TR>
          <TR>
            <TD class="text"> Ciclo Valorizzazione:  </TD>
            <TD colspan="3">
              <INPUT class="text" id="srcCicloVal" name="srcCicloVal" readonly obbligatorio="si" tipocontrollo="intero" label="Ciclo Valorizzazione" Update="false" size="13">
              <INPUT class="text" id="strDescCiclo" name="strDescCiclo" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Ciclo" Update="false" size="35">
            </TD>
        </TR>
          <TR>
            <TD class="text"> Stato:      </TD>
            <TD colspan="3">
              <INPUT class="text" id="srcCodeStato" name="srcCodeStato"  readonly obbligatorio="si" tipocontrollo="intero" label="Codice Stato" Update="false" size="13">
              <INPUT class="text" id="strDescStato" name="strDescStato" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Stato" Update="false" size="35">
            </TD>
          </TR>
          <TR>
           <TD class="text"> Casuale Attivazione:  </TD>
             <TD colspan="3">
              <INPUT class="text" id="strTipoCausaleAtt" name="strTipoCausaleAtt" readonly obbligatorio="si" tipocontrollo="intero" label="Causale Attivazione" Update="false" size="13"  >
              <INPUT class="text" id="strDescCausaleAtt" name="strDescCausaleAtt" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Causale Attivazione" Update="false" size="35">
              <input class="text" title="Selezione Causale Attivazione" type="button" maxlength="30" name="cmdCausaleAtt" value="..." onClick="click_cmdCausale('A');">
            </TD>
          </TR>
          <TR>
             <TD class="text"> Data Cessazione :  </TD>
             <TD colspan =3 >
              <INPUT class="text" id="strDataCessaz" name="strDataCessaz" readonly obbligatorio="si" tipocontrollo="data" label="Data Cessazione" Update="false" size="13">
              <a href="javascript:showCalendar('frmDati.strDataCessaz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDCE" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataCessaz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDCE" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
             </TD>     
            
           </TR>
          <TR>
            <TD class="text"> Causale Cessazione:  </TD>
            <TD colspan="3">
              <INPUT class="text" id="strTipoCausaleCes" name="strTipoCausaleCes" readonly obbligatorio="si" tipocontrollo="intero" label="Causale Cessazione" Update="false" size="13" onchange="lancioComponenti(<%=isCessaAttiva%>,'C_A');">
              <INPUT class="text" id="strDescCausaleCes" name="strDescCausaleCes" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Cauale Cessazione" Update="false" size="35">
              <input class="text" title="Selezione Causale Cessazione" type="button" maxlength="30" name="cmdCausaleCes" value="..." onClick="click_cmdCausale('C');">
            </TD>
          </TR>
          <TR>
            <TD class="text"> Data Fine Noleggio:  </TD>
             <TD>
              <INPUT class="text" id="strDataFineNol" name="strDataFineNol" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Noleggio" Update="false" size="13">
                <a href="javascript:showCalendar('frmDati.strDataInizioNol','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDFN" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataInizioNol);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFN" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
            </TD>
            <TD class="text"> Distanza/Capacità:   </TD>
             <TD>
              <INPUT class="text" id="srcQNTA" name="srcQNTA" obbligatorio="si" tipocontrollo="intero" label="Qnta Valo" Update="false" size="13" maxlength="11">
            </TD>
          </TR>
          <TR>
             <TD class="text"> Data Inizio Fatturazione:  </TD>
             <TD>
              <INPUT class="text" id="srcDIF" name="srcDIF" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Fatrz" Update="false" size="13" onchange="lancioComponenti(<%=isCessaAttiva%>,'DIF');"  >
              <a href="javascript:showCalendar('frmDati.srcDIF','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.srcDIF);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
            </TD>
           <TD class="text"> Data Fine Fatturazione: </TD>
             <TD>
              <INPUT class="text" id="strDataFineFatrz" name="strDataFineFatrz" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Fatrz" Update="false" size="13">
              <a href="javascript:showCalendar('frmDati.strDataFineFatrz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDFF" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataFineFatrz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFF" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
            </TD>
          </TR>
          <TR>
           <TD class="text"> Data Inizio Validita:
             </TD>
             <TD>
              <INPUT class="text" id="strDataInizioValid" name="strDataInizioValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Validita" Update="false" size="13">
              <a href="javascript:showCalendar('frmDati.strDataInizioValid','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDIV" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataInizioValid);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDIV" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
            </TD>
            <TD class="text"> Data Fine Validita:
             </TD>
             <TD>
              <INPUT class="text" id="strDataFineValid" name="strDataFineValid" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Validita" Update="false" size="13">
              <a href="javascript:showCalendar('frmDati.strDataFineValid','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDFV" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataFineValid);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDFV" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
            </TD>
          </TR>
           <TR>
             <TD class="text"> Codice Progetto :  </TD>
             <TD>
              <INPUT class="text" id="srcCodeProgetto" name="srcCodeProgetto"  obbligatorio="si" tipocontrollo="intero" label="Codice Progetto" Update="false" size="13">
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
             <TD class="text"> Data Creazione :  </TD>
             <TD>
              <INPUT class="text" id="strDataCreaz" name="strDataCreaz" readonly obbligatorio="si" tipocontrollo="data" label="Data Creaz" Update="false" size="13">
              <a href="javascript:showCalendar('frmDati.strDataCreaz','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendarDataCreaz" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmDati.strDataCreaz);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancelDataCreaz" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
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
</FORM>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  caricaDati();
  DisabilitaProdotto(<%=data_Inventari.getCODE_STATO_ELEM()%>);
</SCRIPT>
</body>
</html>
