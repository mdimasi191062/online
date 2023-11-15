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
<%=StaticMessages.getMessage(3006,"ProdottiDettaglio.jsp")%>
</logtag:logData>

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
    String strCodeOfferta    = Misc.nh(request.getParameter("Offerta"));
    String strCodeServizio   = Misc.nh(request.getParameter("Servizio"));
    String strCodeProdotto   = Misc.nh(request.getParameter("Prodotto"));
    String strCodeComponente = Misc.nh(request.getParameter("Componente"));
    String strCodePrestazione = Misc.nh(request.getParameter("Prestazione"));
    String strValoPrimoNol  =  Misc.nh(request.getParameter( "PrimoNol"   ));
    String strValoRinnNol   =  Misc.nh(request.getParameter( "TempoRinn"  ));
    String strValoPreaNol   =  Misc.nh(request.getParameter( "TempoPre"   ));
    String strModalApplEur  =  Misc.nh(request.getParameter( "ModalAppl"  ));
    String strDataFineNoleggio  =  Misc.nh(request.getParameter( "dataFineNoleggio"  ));
    String strSpesaComplessiva  =  Misc.nh(request.getParameter( "SpesaComplessiva"  ));
    String strApplicabilitaEuribor  =  Misc.nh(request.getParameter( "Euribor"  ));
    String strAggiorna    = Misc.nh(request.getParameter("Aggiorna"));
    String Elemento = "P";
    String messaggio = "";

  
   /*Aggiorno la base dati */
  if ( strAggiorna.equals("1") ) {
    
    int aggiornaCatalogo =  remoteEnt_Catalogo.aggiornaProdCompPrest(strCodeOfferta , strCodeServizio , strCodeProdotto, strCodeComponente, strCodePrestazione,strModalApplEur, strValoPrimoNol, strValoPreaNol, strValoRinnNol,  strDataFineNoleggio, strSpesaComplessiva, strApplicabilitaEuribor);
    if (aggiornaCatalogo == 1)
      messaggio = "Non è possibile aggiornare  il record perchè sono presenti più record della stessa occorrenza";
     if (aggiornaCatalogo < 0)
      messaggio = "Attenzione!!  ERRORE DB durante aggiornamento record - Controllare la tabella scarti_catalogo";
     if (aggiornaCatalogo == 0)
      messaggio = "Aggiornamento eseguito con successo";
  
  } 
     
      Vector vct_Info = null;
      int info_Euribor =0;
  
      //Se si tratta di un prodotto
      if ( strCodeComponente.equals("") ) 
        if ( strCodePrestazione .equals("") ){
          Elemento = "P";
          vct_Info = remoteEnt_Catalogo.getVisualizzaInfo( Elemento,  strCodeOfferta,  strCodeServizio,  strCodeProdotto,  "" , "" );    

          //QS: 04/03/2008 Prelevo l'informazione relativa all'applicabilita Euribor
         info_Euribor = remoteEnt_Catalogo.getApplicabilitaEuribor( strCodeProdotto,  "" , "" );
        }  
        
      //Se si tratta di una componente
      if ( !strCodeProdotto.equals(""))
        if ( !strCodeComponente .equals("") )
          if ( strCodePrestazione .equals("") ){
            Elemento = "C";
            vct_Info = remoteEnt_Catalogo.getVisualizzaInfo( Elemento,  strCodeOfferta,  strCodeServizio,  strCodeProdotto, strCodeComponente , "" );    

             //QS: 04/03/2008 Prelevo l'informazione relativa all'applicabilita Euribor
             info_Euribor = remoteEnt_Catalogo.getApplicabilitaEuribor(  strCodeProdotto, strCodeComponente , "" );
          }

      //Se si tratta di una prestazione aggiuntiva
      if ( !strCodePrestazione.equals(""))
        if ( !strCodeComponente.equals("") ) {
          Elemento = "PA-C";
          vct_Info = remoteEnt_Catalogo.getVisualizzaInfo( Elemento,  strCodeOfferta,  strCodeServizio,  strCodeProdotto, strCodeComponente , strCodePrestazione );    

          //QS: 04/03/2008 Prelevo l'informazione relativa all'applicabilita Euribor
          info_Euribor = remoteEnt_Catalogo.getApplicabilitaEuribor(  strCodeProdotto, strCodeComponente , strCodePrestazione );
        } else {
          Elemento = "PA-P";
          vct_Info = remoteEnt_Catalogo.getVisualizzaInfo( Elemento,  strCodeOfferta,  strCodeServizio,  strCodeProdotto, "" , strCodePrestazione );

          //QS: 04/03/2008 Prelevo l'informazione relativa all'applicabilita Euribor
          info_Euribor = remoteEnt_Catalogo.getApplicabilitaEuribor(  strCodeProdotto, "" , strCodePrestazione );
      }

      DB_VisualizzaInfo info_Compo = (DB_VisualizzaInfo)vct_Info.get(0);
     
      String checkSpesaComplessiva =  info_Compo.getFLAG_SPESA().equals("S") ? "Y" : "N";
    %>


<HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
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
<script language="Javascript">

var objWindows  = null;
var elementiCheck = '';
var param = '';
  
var objXmlModalNoleg = null;
var valCboModalNoleg = '';
  
function Initialize() {
  objXmlModalNoleg  = CreaObjXML();
  objXmlModalNoleg.loadXML ('<MAIN><%=remoteCtr_Catalogo.getModalitaApplicazioneNoleggioXml()%></MAIN>');
  CaricaComboDaXML(frmDatiDett.cboModalNoleg,objXmlModalNoleg.documentElement.selectNodes('NOLEGGIO'));
}


//Funzione che viene chiamata la prima volta che viene caricata la pagina
//Rispetto alla change_cboModalNoleg non re-inizializza i dati del form
function cboModalNoleg(){
  if (valCboModalNoleg!=frmDatiDett.cboModalNoleg.value){
    valCboModalNoleg=frmDatiDett.cboModalNoleg.value;
    if ( 1 == frmDatiDett.cboModalNoleg.value ) {
        Enable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );

        if (frmDatiDett.Elemento.value == 'P'){
          Enable ( frmDatiDett.chkSpesaComplessiva );
        }   
        else
        {
          Disable ( frmDatiDett.chkSpesaComplessiva );
        }
        
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );   
    } 
    else if (
      ( 2 ==  frmDatiDett.cboModalNoleg.value )
      ||
      ( 3 ==  frmDatiDett.cboModalNoleg.value ) 
      ||
      ( 6 ==  frmDatiDett.cboModalNoleg.value )       
      ){
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );

        if (frmDatiDett.Elemento.value == 'P'){
          Enable ( frmDatiDett.chkSpesaComplessiva );
        }   
        else
        {
          Disable ( frmDatiDett.chkSpesaComplessiva );
        }
        
        if(!frmDatiDett.calendario.disabled){
          DisableLink ( document.links[0], frmDatiDett.calendario);
        }
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );  
    } 
    else if ( 4 ==  frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        
        if (frmDatiDett.Elemento.value == 'P'){
          Enable ( frmDatiDett.chkSpesaComplessiva );
        }   
        else
        {
          Disable ( frmDatiDett.chkSpesaComplessiva );
        }
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );
    } 
    else if ( 5 == frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.dataFineNoleggio );
        
       if (frmDatiDett.Elemento.value == 'P'){
          Enable ( frmDatiDett.chkSpesaComplessiva );
        }   
        else
        {
          Disable ( frmDatiDett.chkSpesaComplessiva );
        }
          
        if(frmDatiDett.calendario.disabled)
          EnableLink ( document.links[0], frmDatiDett.calendario);
        if(frmDatiDett.cancella_data.disabled)
          EnableLink ( document.links[1], frmDatiDett.cancella_data);
        Enable ( frmDatiDett.calendario );
        Enable ( frmDatiDett.cancella_data );
    }
    else {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        Disable ( frmDatiDett.chkSpesaComplessiva );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );      
    }
  }else {
    Disable ( frmDatiDett.RinnovoNoleggio );
    Disable ( frmDatiDett.TempoPreavviso );
    Disable ( frmDatiDett.PrimoNoleggio );
    Disable ( frmDatiDett.dataFineNoleggio );
   
    Disable ( frmDatiDett.chkSpesaComplessiva );
          
    if(!frmDatiDett.calendario.disabled)
      DisableLink ( document.links[0], frmDatiDett.calendario);
    if(!frmDatiDett.cancella_data.disabled)
      DisableLink ( document.links[1], frmDatiDett.cancella_data);
    Disable ( frmDatiDett.calendario );
    Disable ( frmDatiDett.cancella_data );
  }
}

function change_cboModalNoleg(){

  frmDatiDett.TempoPreavviso.value = '';
  frmDatiDett.dataFineNoleggio.value = '';
  frmDatiDett.RinnovoNoleggio.value = '';
  frmDatiDett.PrimoNoleggio.value = ''; 
  frmDatiDett.chkApplicabilitaEuribor.checked = false;

  if (frmDatiDett.Elemento.value == 'P'){
    Enable ( frmDatiDett.chkSpesaComplessiva );
  }   
  else
  {
    Disable ( frmDatiDett.chkSpesaComplessiva );
  }
    
  if (valCboModalNoleg!=frmDatiDett.cboModalNoleg.value){
    valCboModalNoleg=frmDatiDett.cboModalNoleg.value;
    if ( 1 == frmDatiDett.cboModalNoleg.value ) {
        Enable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
   
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );    
    } 
    else if (
      ( 2 ==  frmDatiDett.cboModalNoleg.value )
      ||
      ( 3 ==  frmDatiDett.cboModalNoleg.value ) 
      ||
      ( 6 ==  frmDatiDett.cboModalNoleg.value ) 
      ){
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
        
        if(!frmDatiDett.calendario.disabled){
          DisableLink ( document.links[0], frmDatiDett.calendario);
        }
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );
    } 
    else if ( 4 ==  frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Disable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable ( frmDatiDett.dataFineNoleggio );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );
    } 
    else if ( 5 == frmDatiDett.cboModalNoleg.value ) {
        Disable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Disable ( frmDatiDett.PrimoNoleggio );
        Enable ( frmDatiDett.dataFineNoleggio );
          
        if(frmDatiDett.calendario.disabled)
          EnableLink ( document.links[0], frmDatiDett.calendario);
        if(frmDatiDett.cancella_data.disabled)
          EnableLink ( document.links[1], frmDatiDett.cancella_data);
        Enable ( frmDatiDett.calendario );
        Enable ( frmDatiDett.cancella_data );

        frmDatiDett.TempoPreavviso.value = '30';
        frmDatiDett.TempoPreavviso.readOnly = false; 
    }
    else {
        Enable ( frmDatiDett.RinnovoNoleggio );
        Enable ( frmDatiDett.TempoPreavviso );
        Enable ( frmDatiDett.PrimoNoleggio );
        Disable( frmDatiDett.dataFineNoleggio );
          
        if(!frmDatiDett.calendario.disabled)
          DisableLink ( document.links[0], frmDatiDett.calendario);
        if(!frmDatiDett.cancella_data.disabled)
          DisableLink ( document.links[1], frmDatiDett.cancella_data);
        Disable ( frmDatiDett.calendario );
        Disable ( frmDatiDett.cancella_data );                
    }
  }
  else {
    Disable ( frmDatiDett.RinnovoNoleggio );
    Disable ( frmDatiDett.TempoPreavviso );
    Disable ( frmDatiDett.PrimoNoleggio );
    Disable ( frmDatiDett.dataFineNoleggio );
   
    Disable ( frmDatiDett.chkSpesaComplessiva );
          
    if(!frmDatiDett.calendario.disabled)
      DisableLink ( document.links[0], frmDatiDett.calendario);
    if(!frmDatiDett.cancella_data.disabled)
      DisableLink ( document.links[1], frmDatiDett.cancella_data);
    Disable ( frmDatiDett.calendario );
    Disable ( frmDatiDett.cancella_data );
  }
}

function ONSALVA(){

        visualizza(document.frmDatiDett.imgOrologio);
        //document.all('elabCorso').innerText ="ELABORAZIONE IN CORSO...";

       Enable ( frmDatiDett.RinnovoNoleggio );
       Enable ( frmDatiDett.TempoPreavviso );
       Enable ( frmDatiDett.PrimoNoleggio );
       Enable ( frmDatiDett.dataFineNoleggio );
       Enable ( frmDatiDett.chkApplicabilitaEuribor );
       Enable ( frmDatiDett.chkSpesaComplessiva );
  
       if (frmDatiDett.chkSpesaComplessiva.checked)
        chkSpesa='S';
       else
        chkSpesa='N';

        if (frmDatiDett.chkApplicabilitaEuribor.checked)
        chkEuribor='S';
       else
        chkEuribor='N';
        
        URLParam = '?Aggiorna=1&Offerta=' + frmDatiDett.Offerta.value + '&Servizio=' + frmDatiDett.Servizio.value + '&Prodotto=' + frmDatiDett.Prodotto.value + '&Componente=' + frmDatiDett.Componente.value + '&Prestazione=' + frmDatiDett.Prestazione.value;
        URLParam = URLParam + '&ModalAppl=' + frmDatiDett.cboModalNoleg.value + '&PrimoNol=' + frmDatiDett.PrimoNoleggio.value +  '&TempoPre=' + frmDatiDett.TempoPreavviso.value + '&TempoRinn=' + frmDatiDett.RinnovoNoleggio.value + '&SpesaComplessiva=' + chkSpesa + '&DataFineNoleggio=' + frmDatiDett.dataFineNoleggio.value + '&Euribor=' + chkEuribor ;
        URL = 'NavigatoreCatalogo.jsp' + URLParam;
        frmDatiDett.action = 'pre_aggiornamento_prod_comp_prest.jsp' + URLParam;
        document.frmDatiDett.submit();
}

function redirect(linkid)
{
  parent.location.href=linkid;
  window.close();
}


function ONCHIUDI(){
  if ( frmDatiDett.messaggio.value != '')
    opener.document.Frame1.ltop.collapse(opener.document.Frame1.ltop.folderTree);
  window.close();
}


</script>
<title>Dettaglio Aggiornamento</title>
</head>
<body onload="Initialize()">


<form name = "frmDatiDett" method="post">
<input type="hidden" name="RepCaratt" id="RepCaratt" value="N">
<input type="hidden" name="Offerta" id="Offerta" value="<%=strCodeOfferta%>">
<input type="hidden" name="Servizio" id="Servizio" value="<%=strCodeServizio%>">
<input type="hidden" name="Prodotto" id="Prodotto" value="<%=strCodeProdotto%>">
<input type="hidden" name="Componente" id="Componente" value="<%=strCodeComponente%>">
<input type="hidden" name="Prestazione" id="Prestazione" value="<%=strCodePrestazione%>">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="Elemento" id="Elemento" value="<%=Elemento%>">


<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='5'></td>
  </tr>
  <tr>
	<td><img src="../images/catalogo.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Aggiornamento Dettaglio</td>
						  <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
						</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  </table>
  <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescOfferta" name="DescOfferta"> 
        Offerta:
      </font>
    </td>
    <td>
    <font id="DescrizioneOfferta" name="DescrizioneOfferta"> 
       <INPUT class="text" id="DescOfferta" name="DescOfferta" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Offerta" Update="false" size="20" value="<%=info_Compo.getDESC_OFFERTA()%>">
    </font>
    </TD>
  </tr>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescServizio" name="DescServizio">
        Servizio:
      </font>
    </td>
    <td>
     <font id="DescrizioneServizio" name="DescrizioneServizio">
      <INPUT class="text" id="DescServizio" name="DescServizio" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Servizio" Update="false" size="20" value="<%=info_Compo.getDESC_SERVIZIO()%>">       
      </font>
    </TD>
  </tr>
  <tr>
    <td class="text" nowrap>Modalità Applicazione Noleggio:</td>
    <td colspan="5">
      <select class="text" title="Noleggio" name="cboModalNoleg" value="<%=info_Compo.getCODE_MODAL_APPLICAB_NOLEG()%>"  onchange="change_cboModalNoleg();" >
        <option class="text"  value="<%=info_Compo.getCODE_MODAL_APPLICAB_NOLEG()%>"><%=info_Compo.getDESC_MODAL_APPLICAB_NOLEG()%></option>
      </select>
    </td>
  </td>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescPrimoNoleggio" name="DescPrimoNoleggio"> 
        Tempo Primo Noleggio (mm):
      </font>
    </td>
    <td>
     <INPUT class="text" style="text-align:right;" id="PrimoNoleggio" name="PrimoNoleggio"  tipocontrollo="intero" label="Primo Noleggio" size="10" value="<%=info_Compo.getPRIMO_NOL()%>" >
    </TD>
  </tr>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescRinnovoNoleggio" name="DescRinnovoNoleggio">
        Tempo Rinnovo Noleggio (mm):
      </font>
    </td>
    <td>
      <INPUT class="text"  style="text-align:right;" id="RinnovoNoleggio" name="RinnovoNoleggio" obbligatorio="si" tipocontrollo="intero" label="Rinnovo Noleggio" size="10" value="<%=info_Compo.getRINNOVO_NOL()%>" >
    </TD>
  </tr>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescTempoPreavviso" name="DescTempoPreavviso">
        Tempo Preavviso (gg):
      </font>
    </td>
    <td colspan="3">
       <INPUT class="text" style="text-align:right;" id="TempoPreavviso" name="TempoPreavviso" tipocontrollo="intero" label="Tempo Preavviso" size="10" value="<%=info_Compo.getTEMPO_PREAVVISO()%>">
    </TD>
  </tr>
  <tr>
    <td class="text" nowrap>
      <FONT id="DescSpesa" name="DescSpesa">
        Partecipa al Calcolo di Spesa complessiva:
      </FONT>
    </td>
    <td>
    <% if (info_Compo.getFLAG_SPESA().equals("S")) {%>
        <input type="checkbox" value="<%=info_Compo.getFLAG_SPESA()%>" name="chkSpesaComplessiva" checked>
    <% } else {%>
        <input type="checkbox" value="<%=info_Compo.getFLAG_SPESA()%>" name="chkSpesaComplessiva">
    <%  }%>
    </td>
  </tr>
  <tr>
    <td class="text" nowrap>
      <FONT id="DescEuribor" name="DescEuribor">
        Applicabilità Euribor:
      </FONT>
    </td>
    <td>
    <% if (info_Euribor == 1) {%>
        <input type="checkbox" value="1" name="chkApplicabilitaEuribor" checked>
    <% } else {%>
        <input type="checkbox" value="0" name="chkApplicabilitaEuribor">
    <%  }%>
    </td>
  </tr>
  <tr>
    <TD class="text" nowrap> 
      <font id="DescDataFineNoleggio" name="DescDataFineNoleggio">
        Data Fine Noleggio:
      </font>
    </td>
    <td  class="text" align="left" colspan="3" nowrap="nowrap">
       <input type="text" class="text" size=12 maxlength="12" name="dataFineNoleggio" id="dataFineNoleggio" title="dataFineNoleggio" value="<%=info_Compo.getDATA_FINE_NOL()%>" readonly> <!--  onblur="handleblur('dataFineNoleggio');" -->
       <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
       <a href="javascript:cancelCalendar(document.frmDatiDett.dataFineNoleggio);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
    </td>
  </tr>
</TABLE>
   <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='10'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
	      </tr>
	    </table>
    </td>
  </tr>
</form>
</body>
<script language="JavaScript">
       // Calendario Data Inizio Validità
       var cal1 = new calendar1(document.forms['frmDatiDett'].elements['dataFineNoleggio']);
			 cal1.year_scroll = true;
			 cal1.time_comp = false;
       cboModalNoleg();
 </script>

 <script language="JavaScript">
  if(document.frmDatiDett.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>

</HTML>