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
<sec:ChkUserAuth />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"elab_run.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_ELAB_ATT_JS%>ElabAttive.js" type="text/javascript"></script>
<title></title>
</head>
<body onfocus=" ControllaFinestra()" onmouseover="ControllaFinestra()" onload="f_calendarioDelib(document.frmDati.reprDel);" >
<form name="frmDati" method="post" action="" target="Action">
<table name="tblLoad" id="tblLoad" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <Tr>
    <Td align="center" valgn="middle" height="100%" width="100%" class="text">
      <IMG name="imgProgress" id="imgProgress" alt="Elaborazione in corso" src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif">
      <Br>
      Elaborazione in corso...
    </Td>
  </Tr>
</table>
<%out.flush();

    Vector vectRepr = new Vector();
    String testoDelib="";
    String testoRepr="";
    try {
        vectRepr.addAll(remoteCtr_Utility.getTestoRepr());
        DB_Param_Sap myElem1=new DB_Param_Sap();
        myElem1=(DB_Param_Sap)vectRepr.elementAt(0);    
        DB_Param_Sap myElem2=new DB_Param_Sap();
        myElem2=(DB_Param_Sap)vectRepr.elementAt(1);   
        

        if(myElem1.getNOME_CONST().equals("TESTO_REPRICING_DA_DELIB")){
            testoDelib=myElem1.getVALORE_CONST();
        }
        else{
            testoRepr=myElem1.getVALORE_CONST();
        }
        
            if(myElem2.getNOME_CONST().equals("TESTO_REPRICING_DA_DELIB")){
            testoDelib=myElem2.getVALORE_CONST();
        }
        else{
            testoRepr=myElem2.getVALORE_CONST();
        }
     } catch(Exception e) {
     } 

  Vector vctElabAttive = null;
  Vector vctPeriodoRif = null;
  DB_ElabAttive objElabAttiva = null;
  DB_ElabAttive objElabAttivaCombo = null;
  vctElabAttive = remoteCtr_ElabAttive.getElabAttive();
  DB_PeriodoRiferimento objPeriodoRif = null;
  String CodeFunz = Misc.nh(request.getParameter("CodeFunz"));
  String xmlServizi = "";
  String xmlAccount = "";
  String xmlGestore = "";
  String ServiziVisible = "S";
  String AccountVisible = "S";
  String GestoreVisible = "S";
  String PeriodoRiferimentoVisible = "N";
  String DataVisible = "N";
  String DataFinePeriodo = "";
  String checkAcquisizioneTLDdaFileVisible = "N";
/*mm01 23/01/2005 INIZIO*/
  String checkCongelamentoSpesaVisible = "N";
/*mm01 23/01/2005 FINE*/
/*mm01 04/05/2005 INIZIO*/
  String TextNomeFile = "N";
  String strDataFineCiclo = "";
/*mm01 04/05/2005 FINE*/    
/* QS 06/12/2007: INIZIO modifica per export GECOM */
  String NomeFunz = "";
/* QS 06/12/2007: FINE modifica per export GECOM */

  String PeriodoRif = "";
  String ParamFunz = "";
  String BatchPeriodoRif = "";
  int indexCodeFunz;

  if(!CodeFunz.equals("")){
    
    objElabAttiva = new DB_ElabAttive();
    objElabAttiva.setCODE_FUNZ(CodeFunz);
    indexCodeFunz = vctElabAttive.indexOf(objElabAttiva);
    objElabAttiva = (DB_ElabAttive)vctElabAttive.get(indexCodeFunz);

    ParamFunz = objElabAttiva.getFUNZ_PARAM();

    if(objElabAttiva.getPERIODO_RIFERIMENTO_VISIBLE().equals("S")){
        PeriodoRif = Misc.nh(request.getParameter("cboPeriodoRif" + CodeFunz));
        strDataFineCiclo = Misc.nh(request.getParameter("txtDataFineCiclo"));
        PeriodoRiferimentoVisible = "S";
        vctPeriodoRif = remoteCtr_ElabAttive.getPeriodoRiferimento(objElabAttiva.getQUERY_PERIODO_RIFERIMENTO());
    }

    if(objElabAttiva.getBATCH_NEED_PER_RIF().equals("S")){
      BatchPeriodoRif = PeriodoRif;
    }

    if(objElabAttiva.getSERVIZI_VISIBLE().equals("S")){
      if(objElabAttiva.getQUERY_SERVIZIO_NEED_PER_RIF().equals("S")){
        if(((objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_REPRICING) ||
             objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING)
            ) ||
            !PeriodoRif.equals("")
           )
           
          ){
          xmlServizi = remoteCtr_ElabAttive.getXmlServizi(objElabAttiva.getQUERY_SERVIZI(),PeriodoRif);
        }
      }
      else{
        xmlServizi = remoteCtr_ElabAttive.getXmlServizi(objElabAttiva.getQUERY_SERVIZI());
      }
    }
    else{
      ServiziVisible = "N";
    }
          
    if(objElabAttiva.getACCOUNT_VISIBLE().equals("S")){
      if(objElabAttiva.getQUERY_ACCOUNT_NEED_PER_RIF().equals("S")){
        if(!PeriodoRif.equals("")){      
          xmlAccount = remoteCtr_ElabAttive.getXmlAccount(objElabAttiva.getQUERY_ACCOUNT(),PeriodoRif);
        }
      }
      else{
        xmlAccount = remoteCtr_ElabAttive.getXmlAccount(objElabAttiva.getQUERY_ACCOUNT());
      }
    }
    else{
      AccountVisible = "N";
    }

    if(objElabAttiva.getGESTORE_VISIBLE().equals("S")){
      if (objElabAttiva.getQUERY_GESTORE_NEED_PER_RIF().equals("S")){
        if(!PeriodoRif.equals("")){      
          xmlGestore = remoteCtr_ElabAttive.getXmlGestori(objElabAttiva.getQUERY_GESTORE(),PeriodoRif);
        }
      }
      else{
        xmlGestore = remoteCtr_ElabAttive.getXmlGestori(objElabAttiva.getQUERY_GESTORE());
      }
    }
    else
      GestoreVisible = "N";
        
    if(objElabAttiva.getDATA_VISIBLE().equals("S")){
      DataFinePeriodo = Misc.nh(request.getParameter("txtData" + CodeFunz));
      DataVisible = "S";
      if(!objElabAttiva.getCODE_FUNZ().equals("ELABORAZIONE_PREINVENTARIO")){
        DataFinePeriodo = DataFinePeriodo.equals("") ? DataFormat.getDate() : DataFinePeriodo;
      }
    }

    checkAcquisizioneTLDdaFileVisible = objElabAttiva.getCHECK_ACQ_TLD_DA_FILE();
/*mm01 23/01/2005 INIZIO*/
    checkCongelamentoSpesaVisible = objElabAttiva.getCHECK_CONG_SPESA_COMPL();
/*mm01 23/01/2005 FINE*/
/*mm01 04/05/2005 INIZIO*/
    TextNomeFile = objElabAttiva.getTEXT_NOME_FILE();
/*mm01 04/05/2005 FINE*/

/* QS 06/12/2007: INIZIO modifica per export GECOM */
    NomeFunz = objElabAttiva.getCODE_FUNZ();
/* QS 06/12/2007: FINE modifica per export GECOM */
  }
  
%>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";
var attivaCalendario=true;
var attivaCalendarioSched=true;
var attivaCalendarioDelib=true;
var attivaCalendarioContab=true;

function f_calendarioDelib(obj)
{
  if (obj != undefined) {
      if(obj.checked){
        attivaCalendarioDelib=true;
        document.frmDati.dataDelib.value="";
        document.frmDati.dataChiusAnnoCont.value="";
        document.frmDati.testoRepr.value="<%=testoDelib%>";
        document.frmDati.reprDel.value="S";
        document.frmDati.motivazioneRepr.value = "";
        EnableLink(document.links[0],document.frmDati.calendarioDelib);
        EnableLink(document.links[1],document.frmDati.cancella_dataDelib);
        EnableLink(document.links[2],document.frmDati.calendarioDataChiusAnnoCont);
        EnableLink(document.links[3],document.frmDati.cancella_dataChiusAnnoCont); 
        msg1=message1;
        msg2=message2;
      }else{
        attivaCalendarioDelib=false;
        document.frmDati.dataDelib.value="";
        document.frmDati.dataChiusAnnoCont.value="";
        document.frmDati.testoRepr.value="<%=testoRepr%>";
        document.frmDati.reprDel.value="N";
        document.frmDati.motivazioneRepr.value = "";
        DisableLink(document.links[0],document.frmDati.calendarioDelib);
        DisableLink(document.links[1],document.frmDati.cancella_dataDelib);
        DisableLink(document.links[2],document.frmDati.calendarioDataChiusAnnoCont);
        DisableLink(document.links[3],document.frmDati.cancella_dataChiusAnnoCont);
        msg1=message1;
        msg2=message2;
      }
  }
}

function myFunc(dateField) 
{
        var dataIni = frmDati.dataChiusAnnoCont.value;
        if(dataIni == "" || dataIni.substring(6,10) == dateField.substring(6,10) || dataIni.substring(6,10) > dateField.substring(6,10)) {
            var annoNew = parseInt(dateField.substring(6,10),10);
            annoNew = annoNew + 1;
            if(!isNaN(annoNew)) { 
                frmDati.dataChiusAnnoCont.value = "30/04/" + annoNew;
                }
            }
}

  <%if(!CodeFunz.equals("")){%>
  var objXmlServ = null;
  var objXmlAcc  = null;
  var objXmlGest = null;

  objXmlServ = CreaObjXML();
  objXmlAcc  = CreaObjXML();
  objXmlGest = CreaObjXML();

  function cboElaborazioniChange(obj){
    window.location.replace('elab_run.jsp?CodeFunz=' + obj.value);
  }


  <%if(objElabAttiva.getSERVIZI_VISIBLE().equals("S")){%>
    objXmlServ.loadXML('<MAIN><%=xmlServizi%></MAIN>');
  <%}%>
  <%if(objElabAttiva.getACCOUNT_VISIBLE().equals("S")){%>
    objXmlAcc.loadXML('<MAIN><%=xmlAccount%></MAIN>');
  <%}%>
  <%if(objElabAttiva.getGESTORE_VISIBLE().equals("S")){%>
    objXmlGest.loadXML('<MAIN><%=xmlGestore%></MAIN>');
  <%}%>

  function caricaList(){
    <%if(objElabAttiva.getSERVIZI_VISIBLE().equals("S")){%>
    CaricaComboDaXML(frmDati.cboServiziDisp,objXmlServ.documentElement.selectNodes('SERVIZIO'));
    <%}%>
    <%if(objElabAttiva.getACCOUNT_VISIBLE().equals("S")){%>
    CaricaComboDaXML(frmDati.cboAccountDisp,objXmlAcc.documentElement.selectNodes('ACCOUNT'),'SERVIZIO');
    <%}%>
    <%if(objElabAttiva.getGESTORE_VISIBLE().equals("S")){%>
    CaricaComboDaXML(frmDati.cboGestoriDisp,objXmlGest.documentElement.selectNodes('GESTORE'));
    <%}%>
    document.all('tblElab').style.display = '';
    document.all('tblLoad').style.display = 'none';
	}
  <%}else{%>
  function caricaList(){
    document.all('tblElab').style.display = '';
    document.all('tblLoad').style.display = 'none';
	}
  <%}%>

 
  function ONLANCIOBATCH(){

    var checkSelect = false;
    if(validazioneCampi(frmDati)){
      if(document.all('cboServizi') != null || document.all('cboServizi') != undefined){
        if(frmDati.cboServizi.length>0) checkSelect = true;
        selectAllComboElements(frmDati.cboServizi);
      }
<%if(CodeFunz.compareToIgnoreCase("REPRICING")==0){%>
  
  
  /* if(document.getElementById("fcIva").checked) {
     frmDati.cinqueAnniHidden.disabled = false;
     frmDati.cinqueAnni.disabled = true;
     frmDati.cinqueAnniHidden.readOnly= false;
  } */
  if(!document.getElementById("cinqueAnni").checked) {
     frmDati.cinqueAnniHidden.disabled = false;
     frmDati.cinqueAnni.disabled = true;
     frmDati.cinqueAnniHidden.readOnly= false;
  } 
  
  if(!document.getElementById("richEmissRepr").checked) {
     frmDati.richEmissReprHidden.disabled = false;
     frmDati.richEmissRepr.disabled = true;
     frmDati.richEmissReprHidden.readOnly= false;
  }  
  
  
<%}%>
<%if(CodeFunz.compareToIgnoreCase("VALORIZ")==0){%>

     if(!document.getElementById("cinqueAnni").checked) {
        frmDati.cinqueAnniHidden.disabled = false;
        frmDati.cinqueAnni.disabled = true;
        frmDati.cinqueAnniHidden.readOnly= false;
     } 
<%}%>
    
  
      /* Se il flag Invio Gecom è selezionato */
      if ((frmDati.checkInvioGecom != null ) && (frmDati.checkInvioGecom.checked)){
        for (i=0; i<frmDati.cboServizi.length; i++) { 
          if (frmDati.cboServizi[i].value == 6){
            alert ('Attenzione! Il servizio ITC Reverse non è esportabile su GECOM');
            return;
            if (frmDati.cboServizi.length == 1)
               alert ('Nessun servizio esportabile è stato selezionato');
               return;
          }
        }
      }       
      
      if(document.all('cboAccount') != null || document.all('cboAccount') != undefined){
        if(frmDati.cboAccount.length>0) checkSelect = true;
        selectAllComboElements(frmDati.cboAccount);
      }
      if(document.all('cboGestori') != null || document.all('cboGestori') != undefined){
        if(frmDati.cboGestori.length>0) checkSelect = true;
        selectAllComboElements(frmDati.cboGestori);
      }

/*rm01 15/12/2005 INIZIO */
      if(document.all('cboElaborazioni') != null || document.all('cboElaborazioni') != undefined){
        /*if(frmDati.cboElaborazioni.value == 'ALL_PREINVE' || 
           frmDati.cboElaborazioni.value == 'ELABORAZIONE_PREINVENTARIO') {
          checkSelect = true;
        }*/
        if(frmDati.cboElaborazioni.value == 'ALL_PREINVE' ||
           frmDati.cboElaborazioni.value == 'ALL_PREINVE_OD' ||
           frmDati.cboElaborazioni.value == 'ALL_PRE_CATALOGO' ||
           frmDati.cboElaborazioni.value == 'ALL_PREINVE_CRM' ||
           frmDati.cboElaborazioni.value == 'ALL_PREINVE_CRM_JPUB') {
   /* MoS Aggiunta voce ALL_PREINVE_CRM_JPUB */       
          checkSelect = true;
        }
      }
      
      if(document.all('cboElaborazioni') != null || document.all('cboElaborazioni') != undefined){
        if(frmDati.cboElaborazioni.value == 'ELABORAZIONE_PREINVENTARIO') {
           var controllo = controllaDataFineCiclo();
           if (controllo){
              checkSelect = true;
           }else{
              alert("Attenzione!!! La Data Fine Elaborazione deve essere compresa nel Ciclo di Riferimento");
              return
           }   
        }
      }
      
/*rm01 15/12/2005 FINE */

      if(!checkSelect){
        alert('Occorre selezionare almeno un\'elemento dalle liste.');
        return;
      }
      /* mscatena 26/05/2008 INIZIO */
      else if(document.all('txtNomeFile') != null || document.all('txtNomeFile') != undefined){
        if(frmDati.txtNomeFile.value == ''){
          alert("Occorre Specificare il nome del file da produrre");
          return;
        }
        else if (!controllaNomeFile(frmDati.txtNomeFile.value)){
          alert("Nome del file non valido");
          return;
        }
      }
      /* mscatena 26/05/2008 FINE */
/*mm01 04/05/2005 FINE */
     if (document.frmDati.reprDel != undefined ) {
          if(document.frmDati.reprDel.checked)
          {
            document.frmDati.reprDel.value="S";
            if(document.frmDati.dataDelib.value == "" || document.frmDati.dataDelib.value == undefined)
            {
              alert("Inserire la Data Publicazione Delibera");
              return;
            }
            else
            {
                if(document.frmDati.dataChiusAnnoCont.value == "" || document.frmDati.dataChiusAnnoCont.value == undefined)
                {
                    alert("Inserire il Giorno chiusura dichiarazione IVA");
                    return;
                }
                else
                {
                    var appodataMin = document.frmDati.dataDelib.value;
                    var dataMin = appodataMin.substring(6,10) + appodataMin.substring(3,5) + appodataMin.substring(0,2);
                    var appodataIni = frmDati.dataChiusAnnoCont.value;
                    var dataIni = appodataIni.substring(6,10) + appodataIni.substring(3,5) + appodataIni.substring(0,2);
                    if(!(dataIni > dataMin)) {
                        alert("Attenzione: Giorno chiusura dichiarazione IVA minore o uguale della Data Pubblicazione Delibera");
                        return;  
                    }            
                }
            }
          }    
          else
          {
              document.frmDati.reprDel.value="N";
              document.frmDati.dataDelib.value="31/12/9999";
              document.frmDati.dataChiusAnnoCont.value="31/12/9999";
          }  
            
            if(document.frmDati.motivazioneRepr.value == "") {
                alert("Attenzione: Inserire la motivazione del Repricing!!");
                return;                
            }    
        }
      openCentral('about:blank','Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
      frmDati.action = 'ctr_elab.jsp';
      frmDati.submit();
    }
  }

  function controllaDataFineCiclo(){    
       var dataDB =  window.document.frmDati.elabPreinve_dataFineCiclo.value;
       var tokensDB = dataDB.split(" - ");
       var meseDB = tokensDB[0];
       var annoDB = tokensDB[1];
       var meseJS = getMeseJS(meseDB);
       var giornoJS = getGiornoJS(meseJS);
       var giornoDB = giornoJS;
       var meseDB = meseJS;     
       
       var dataIns =  window.document.frmDati.txtDataELABORAZIONE_PREINVENTARIO.value;
       var tokensIns = dataIns.split("/");
       var annoIns   = tokensIns[2];
       var meseIns   = tokensIns[1];
       var giornoIns = tokensIns[0];

       if(eval(annoIns) > eval(annoDB)){
         return false;
       }else if(eval(annoIns) < eval(annoDB)){
         return false;
       }else{
         if(eval(meseIns) > eval(meseDB)){
            return false;
         }else if(eval(meseIns) < eval(meseDB)){
            return false;
         }else{
            if(eval(giornoIns) > eval(giornoDB)){
              return false;
            }else{
              return true;
            }
         }
       }
    }

  function controllo(){
    var combo = window.document.frmDati.cboPeriodoRifELABORAZIONE_PREINVENTARIO.value;
    if(combo != ''){
       return true;
    }else{
       alert("Attenzione!! Selezionare il Ciclo di Riferimento");
       return false;
    }
  }

/* mscatena 26/05/2008 INIZIO */
  /* Restituisce 'false' se la stringa contiene caratteri non consentiti; 'true' altrimenti. */
  function controllaNomeFile(stringa){
    var ret = true;
    for(i=0; i<stringa.length; i++){
      if(stringa.charAt(i) == ' ' ||
         stringa.charAt(i) == '(' ||
         stringa.charAt(i) == ')' ||
         stringa.charAt(i) == '\''){
        ret = false;
        break;
      }
    }
    return ret;
  }
/* mscatena 26/05/2008 FINE */

  function settaCiclodiRiferimento(){
     var value = document.frmDati.cboPeriodoRifELABORAZIONE_PREINVENTARIO.value;
     document.frmDati.desc_ciclo.value = value;
  }
  
</SCRIPT>
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr height="30">
    <td>
    <table width="100%">
      <tr>
        <td><img src="../images/LancioElaborazione.GIF" alt="" border="0"></td>
        <td align="right">
            <Select name="cboElaborazioni" id="cboElaborazioni" class="text" onchange="cboElaborazioniChange(this);">
              <option value="">[Seleziona elaborazione]</option>
              <%
                for(int i=0;i<vctElabAttive.size();i++){
                  objElabAttivaCombo = (DB_ElabAttive)vctElabAttive.get(i);
                  %>
                  <option value="<%=objElabAttivaCombo.getCODE_FUNZ()%>"><%=objElabAttivaCombo.getDESC_FUNZ()%></option>
                  <%
                }
              %>
            </Select>
        </td>
      </tr>
    </table>
    </td>
  </tr>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
            Lancio elaborazioni
          </td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr  height="25" style="display:<%=(PeriodoRiferimentoVisible.equals("S") || DataVisible.equals("S")) ? "" : "none"%>">
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <Tr>
        <INPUT TYPE="hidden" name="ParamFunz" id="ParamFunz" value="<%=ParamFunz%>">
        <input TYPE="hidden" name="txtDataFineCiclo" value="<%=strDataFineCiclo%>">
        <INPUT TYPE="hidden" name="PeriodoRif" id="PeriodoRif" value="<%=BatchPeriodoRif%>">
        <input type="hidden" name="desc_ciclo" id="codice_ciclo">
        <%
        if(PeriodoRiferimentoVisible.equals("S")){%>
          <Td class="text" height="20" align="left">
          <%  
          if(CodeFunz.equals("ELABORAZIONE_PREINVENTARIO")){
            //for(int x=0;x<vctPeriodoRif.size();x++){
              objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(0);
              %>
              Ciclo di Riferimento:                  
                
              <Select class="text" name="cboPeriodoRif<%=CodeFunz%>" id="cboPeriodoRif<%=CodeFunz%>" class="text" label="Ciclo di riferimento" onchange="settaCiclodiRiferimento()">
              
                <option value="">[Seleziona ciclo riferimento]</option>
                <%
                for(int z=0;z<vctPeriodoRif.size();z++){
                    objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                    %>
                    <option value="<%=objPeriodoRif.getDESCRIZIONE_CICLO()%>">
                        <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                    </option>
                    <%--<input type="hidden" name="<%=objPeriodoRif.getDESCRIZIONE_CICLO()%>" value="<%= objPeriodoRif.getCODE_CICLO()%>">--%>
                    <%
                }
                %>
              </Select>
              <%
              for(int z=0;z<vctPeriodoRif.size();z++){
                 objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                 %>
                 <input type="hidden" name="<%=objPeriodoRif.getDESCRIZIONE_CICLO()%>" value="<%= objPeriodoRif.getCODE_CICLO()%>">
                 <%
              }

              %>
              
              <SCRIPT LANGUAGE="JavaScript" type="text/javascript">
                frmDati.cboPeriodoRif<%=CodeFunz%>.value = '<%=PeriodoRif%>';
              </SCRIPT>
              
              <SCRIPT LANGUAGE="JavaScript" type="text/javascript">
                settaCiclodiRiferimento();
              </SCRIPT>
              <input type="hidden" name="elabPreinve_dataFineCiclo" value="<%=objPeriodoRif.getTXT_DATA_FINE_CICLO().substring(0,10)%>">
              <%
            //}
          }else{
           %>
           <%--
            if  ( CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_CSV_REPR) || 
                  CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR) ||
                  CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_REPRICING)||
                  CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING)
                ) {
              %>
              Data di Elaborazione:
            <%
            } else {%>
              Ciclo di riferimento:
            <%
            }
            --%>
            <Select class="text" id="cboPeriodoRif<%=CodeFunz%>" name="cboPeriodoRif<%=CodeFunz%>" obbligatorio="si" tipocontrollo="data" label="Ciclo di riferimento" onchange="cboperiodoRifChange(this)">
              <%  
              if  ( CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_CSV_REPR) || 
                    CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR) ||
                    CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_REPRICING)||
                    CodeFunz.equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING)
                  ) {
                  %>
                  <option value="">[Data di Elaborazione]</option>
                  <%
              } else {%>
                  <option value="">[Seleziona ciclo riferimento]</option>
                  <%
              }
              for(int z=0;z<vctPeriodoRif.size();z++){
                objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                if(objPeriodoRif.getCODE_CICLO().equals("") && 
                   (!objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_REPRICING) &&
                    !objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING)
                   )
                  ){
                  %>
                  <option value="<%=objPeriodoRif.getDATA_AA_RIF_SPESA_COMPL()%>-<%=objPeriodoRif.getDATA_MM_RIF_SPESA_COMPL()%>">
                  <%=objPeriodoRif.getTXT_DATA_MM_RIF_SPESA_COMPL()%> - <%=objPeriodoRif.getDATA_AA_RIF_SPESA_COMPL()%>
                  </option>
                  <%
                }else{
                  if(objPeriodoRif.getCODE_CICLO().equals("")){
                    %>
                    <option value="Attuale" strDataFineCiclo = "<%=objPeriodoRif.getTXT_DATA_FINE_CICLO()%>" >
                    <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                    </option>
                    <%
                  }else{
                    %>
                    <option value="<%=objPeriodoRif.getCODE_CICLO()%>" strDataFineCiclo = "<%=objPeriodoRif.getTXT_DATA_FINE_CICLO()%>" >
                    <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                    </option>
                    <%
                  }
                }
              }
              %>
              </Select>

              <%
              System.out.println("PeriodoRif ["+PeriodoRif+"]");
              %>
              <SCRIPT LANGUAGE="JavaScript" type="text/javascript">
                frmDati.cboPeriodoRif<%=CodeFunz%>.value = '<%=PeriodoRif%>';
              </SCRIPT>
              </Td>
              <%
          }
        }%>
        <%if(DataVisible.equals("S") && CodeFunz.equals("ELABORAZIONE_PREINVENTARIO")){%>
        <Td class="text" height="20" align="right">
          Data Fine Periodo:
          <INPUT class="text" id="txtData<%=CodeFunz%>" name="txtData<%=CodeFunz%>" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="<%=DataFinePeriodo%>">
          <a href="javascript:if(controllo()){showCalendar('frmDati.txtData<%=CodeFunz%>','')};"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
          <!--a href="javascript:clearField(frmDati.txtData);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a-->
        </Td>
        <%}else{%>
        <%if(DataVisible.equals("S")){%>
        <Td class="text" height="20" align="right">
          Data Fine Periodo:
          <INPUT class="text" id="txtData<%=CodeFunz%>" name="txtData<%=CodeFunz%>" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="<%=DataFinePeriodo%>">
          <a href="javascript:showCalendar('frmDati.txtData<%=CodeFunz%>','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
          <!--a href="javascript:clearField(frmDati.txtData);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a-->
        </Td>
        <%}}%>
        <Tr></Tr>
      </table>
    </td>
  </tr>
  <%if(ServiziVisible.equals("S")){%>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Servizi</td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <Table width="100%" border="0" cellpadding="1" height="100%">
        <Tr>
          <Td>
            <Select size="8" name="cboServiziDisp" id="cboServiziDisp" class="list" ondblclick="addOptionToCombo(frmDati.cboServiziDisp,frmDati.cboServizi)">
            </Select>
          </Td>
          <Td align="center" width="30" valign="middle">
            <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(frmDati.cboServiziDisp,frmDati.cboServizi)">
            <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToCombo(frmDati.cboServiziDisp,frmDati.cboServizi)">
            <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="addOptionToCombo(frmDati.cboServizi,frmDati.cboServiziDisp)">
            <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(frmDati.cboServizi,frmDati.cboServiziDisp)">
          </Td>
          <Td>
            <Select size="8" multiple name="cboServizi" id="cboServizi" class="list" ondblclick="addOptionToCombo(frmDati.cboServizi,frmDati.cboServiziDisp)">
            </Select>
          </Td>
        </Tr>
      </Table>
    </td>
  </tr>
  <%}%>
  <%if(AccountVisible.equals("S")){%>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Account</td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <Table width="100%" border="0" cellpadding="1" height="100%">
        <Tr>
          <Td>
            <Select size="8" name="cboAccountDisp" id="cboAccountDisp" class="list">
            </Select>
          </Td>
          <Td align="center" width="30" valign="middle">
            <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(frmDati.cboAccountDisp,frmDati.cboAccount)">
            <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToCombo(frmDati.cboAccountDisp,frmDati.cboAccount)">
            <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="addOptionToCombo(frmDati.cboAccount,frmDati.cboAccountDisp)">
            <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(frmDati.cboAccount,frmDati.cboAccountDisp)">
          </Td>
          <Td>
            <Select size="8" multiple name="cboAccount" id="cboAccount" class="list">
            </Select>
          </Td>
        </Tr>
      </Table>
    </td>
  </tr>
  <%}%>
  <%if(CodeFunz.compareToIgnoreCase("REPRICING")==0){%>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Repricing da Delibera</td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
       <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="left">
               Repricing da Delibera:
               <input type='checkbox' name='reprDel' id='reprDel' value='N' onclick="f_calendarioDelib(document.frmDati.reprDel);">&nbsp;&nbsp;
               Data pubblicazione delibera:&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" readonly name="dataDelib" title="dataDelib" value="" onfocus="myFunc(frmDati.dataDelib.value);"> 
               <a href="javascript:showCalendar('frmDati.dataDelib','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true" onfocus="myFunc(frmDati.dataDelib.value);"><img name='calendarioDelib' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancellaCalendari();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataDelib' src="../../common/images/img/images7.gif" border="0"></a>
               &nbsp;
               Giorno chiusura dichiarazione IVA:&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" readonly name="dataChiusAnnoCont" title="dataChiusAnnoCont" value=""> 
               <a href="javascript:showCalendar('frmDati.dataChiusAnnoCont','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioDataChiusAnnoCont' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancelCalendar(document.frmDati.dataChiusAnnoCont);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataChiusAnnoCont' src="../../common/images/img/images7.gif" border="0"></a>
               &nbsp;             
             </td>             
            </tr>
           </table>
    </td>
  </tr>
  <tr height= "5px"><td ></td></tr>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
       <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="left">
               Motivazione Repricing:&nbsp;      
               <input type="text" class="text" size=30 readonly name="testoRepr" title="testoRepr" value="<%=testoRepr%>" >
               <input type="text" class="text" size=40 maxlength="20" name="motivazioneRepr" title="motivazioneRepr" value="" >              
               Richiesta emissione repricing entro mese in corso:
               <input type='checkbox' name='richEmissRepr' id='richEmissRepr' value='S' >&nbsp;&nbsp;
               <input id='richEmissReprHidden' type='hidden' value='N' name='richEmissRepr' disabled readonly>
             </td>
            </tr>
           </table>
    </td>
  </tr>  
  <tr height= "5px"><td ></td></tr>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">5 Anni</td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
       <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="left">
               NO 5 ANNI:
               <%--<input id='cinqueAnni' type='checkbox' value='N' name='cinqueAnni' checked> --%>
               <input id='cinqueAnni' type='checkbox' value='N' name='cinqueAnni' >
               <input id='cinqueAnniHidden' type='hidden' value='S' name='cinqueAnni' disabled readonly>
             </td>
            </tr>
           </table>
    </td>
  </tr>
  <%}%>
    <%if(CodeFunz.compareToIgnoreCase("VALORIZ")==0){%>
 
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">5 Anni</td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
       <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="left">
               NO 5 ANNI:
               <%--<input id='cinqueAnni' type='checkbox' value='N' name='cinqueAnni' checked> --%> 
               <input id='cinqueAnni' type='checkbox' value='N' name='cinqueAnni' >
               <input id='cinqueAnniHidden' type='hidden' value='S' name='cinqueAnni' disabled readonly>
             </td>
            </tr>
           </table>
    </td>
  </tr>
  <%}%>
  
  
  <%if(GestoreVisible.equals("S")){%>
  <tr height="20">
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Gestori</td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif" width="8" height="8"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <Table width="100%" border="0" cellpadding="1" height="100%">
        <Tr>
          <Td>
            <Select size="8" name="cboGestoriDisp" id="cboGestoriDisp" class="list" ondblclick="addOptionToCombo(frmDati.cboGestoriDisp,frmDati.cboGestori)">
            </Select>
          </Td>
          <Td align="center" width="30" valign="middle">
            <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(frmDati.cboGestoriDisp,frmDati.cboGestori)">
            <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToCombo(frmDati.cboGestoriDisp,frmDati.cboGestori)">
            <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="addOptionToCombo(frmDati.cboGestori,frmDati.cboGestoriDisp)">
            <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(frmDati.cboGestori,frmDati.cboGestoriDisp)">
          </Td>
          <Td>
            <Select size="8" multiple name="cboGestori" id="cboGestori" class="list" ondblclick="addOptionToCombo(frmDati.cboGestori,frmDati.cboGestoriDisp)">
            </Select>
          </Td>
        </Tr>
      </Table>
    </td>
  </tr>
  <%}%>
  <%if(checkAcquisizioneTLDdaFileVisible.equals("S")){%>
  <tr height="28">
    <td class="text">
      <Input type="checkbox" name="checkAcquisizioneTLDdaFile" id="checkAcquisizioneTLDdaFile" class="text">
      Acquisizione TLD da file
    </td>
  </tr>
  <%}%>
<!--mm01 23/01/2005 INIZIO*-->
  <%if(checkCongelamentoSpesaVisible.equals("S")){%>
  <tr height="28">
    <td class="text">
      <Input type="checkbox" name="checkCongelamentoSpesa" id="checkCongelamentoSpesa" class="text">
      Congelamento
    </td>
  </tr>
  <%}%>
<!--mm01 23/01/2005 FINE*-->
<!--mm01 04/05/2005 INIZIO*-->
  <%if(TextNomeFile.equals("S")){%>
  <tr height="28">
      <td class="text">
      Nome File Export :&nbsp;&nbsp;
          <input type='text' name='txtNomeFile' value='' class="text" maxlength=100>

           <!-- QS 06/12/2007: INIZIO modifica per export GECOM *-->
          <%if(NomeFunz.equals("EXPORT_MENSILE") ||  NomeFunz.equals("EXPORT_REPRICING")){%>
          Invio GECOM :&nbsp;&nbsp;
            <Input type="checkbox" name="checkInvioGecom" id="checkInvioGecom" class="text">
          <%}%>
<!--  QS 06/12/2007: FINE modifica per export GECOM -->
      </td>
   
  </tr>
  <%}%>
<!--mm01 04/05/2005 FINE*-->
  <tr height="28">
    <td >
    <sec:ShowButtons td_class="textB"/>
  </td>
 </tr>
</table>
</FORM>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  frmDati.cboElaborazioni.value = '<%=CodeFunz%>';
  caricaList();
  
function cancellaCalendari()
{
        cancelCalendar(document.frmDati.dataDelib);
        cancelCalendar(document.frmDati.dataChiusAnnoCont);

}

</SCRIPT>
</BODY>
</HTML>
