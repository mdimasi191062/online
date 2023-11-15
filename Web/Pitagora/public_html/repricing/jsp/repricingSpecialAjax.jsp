<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,com.strutturaWeb.View.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"repricingSpecialAjax.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>

<%
    Vector vectRepr = new Vector();
    vectRepr.addAll(remoteCtr_Utility.getTestoRepr());
    DB_Param_Sap myElem1=new DB_Param_Sap();
    myElem1=(DB_Param_Sap)vectRepr.elementAt(0);    
    DB_Param_Sap myElem2=new DB_Param_Sap();
    myElem2=(DB_Param_Sap)vectRepr.elementAt(1);   
    
    String testoDelib="";
    String testoRepr="";
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
    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<link rel="body" type="text/html" href="orologio.html"/>
</head>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<script language="JavaScript" src="../../common/js/changeStatus.js"></script>


<SCRIPT>

var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";
var attivaCalendario=true;
var attivaCalendarioSched=true;
var attivaCalendarioDelib=true;
var attivaCalendarioContab=true;

function EnableObj(objElement)
{
	objElement.disabled = false;

}

function caricaAccount()
{
 var carica = function(dati){caricaAccountCallBack('comboAccount',dati);};
 var errore = function(dati){gestisciErroreBloccante(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 document.formPag.code_tipo_contr.value = '<%=request.getParameter("codiceTipoContratto")%>';
 chiamaRichiesta('codiceTipoContratto=<%=request.getParameter("codiceTipoContratto")%>','lanciaRepricing',asyncFunz);

}

function caricaAccountCallBack(combo,dati)
{
  riempiSelect(combo,dati);
  DisabilitaBottonRepricing();  
//  document.formPag.LANCIOBATCH.disabled="true";
}

function myFunc(dateField) 
{
        var dataIni = formPag.dataChiusAnnoCont.value;
        if(dataIni == "" || dataIni.substring(6,10) == dateField.substring(6,10) || dataIni.substring(6,10) > dateField.substring(6,10)) {
            var annoNew = parseInt(dateField.substring(6,10),10);
            annoNew = annoNew + 1;
            if(!isNaN(annoNew)) { 
                formPag.dataChiusAnnoCont.value = "30/04/" + annoNew;
                }
            }

}

function cancellaCalendari()
{
        cancelCalendar(document.formPag.dataDelib);
        cancelCalendar(document.formPag.dataChiusAnnoCont);

}

function BATCHMANUALE(){

  var carica = function(dati){caricaAccountCallBack('comboAccount',dati);};
  var errore = function(dati){gestisciErroreBloccante(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  var messaggio='';
  
  if (document.formPag.generaReport.checked)
    document.formPag.generaReport.value="1";
  else
    document.formPag.generaReport.value="0";

  //if (document.formPag.fcIva.checked)
  //  document.formPag.fcIva.value="N";
  //else
  //  document.formPag.fcIva.value="S";
    
  //var fcIva = document.formPag.fcIva.value;
  var generaReport = document.formPag.generaReport.value;
  var dataSched = document.formPag.dataSched.value;
  
  var select= document.formPag.comboRiepilogoAccount;
  var code_tipo_contr = document.formPag.code_tipo_contr.value;
  
  var reprDel = document.formPag.reprDel.value;   /*F: - R1I-19-0356 */
  var richEmissRepr = document.formPag.richEmissRepr.value;   /*F: - R1I-19-0356 */
  var dataDelib = document.formPag.dataDelib.value;
  var dataChiusAnnoCont = document.formPag.dataChiusAnnoCont.value;
  var motRepricing = document.formPag.testoRepr.value + " " + document.formPag.motivazioneRepr.value;  

  for(i=0;i <select.length ;i++)
    {
      messaggio+=select.options[i].value;
      if(i!=select.length-1)
        messaggio+='$';
    }
  var sendMessage='codiceTipoContratto=1&elencoAccount='+
                messaggio+
                '&codeTipoContr='+code_tipo_contr+
                '&generaReport='+generaReport+
                '&dataSched='+dataSched+
                '&fcIva='+fcIva+
                '&codeFunz=26'+
                '&reprDel='+reprDel+
                '&dataDelib='+dataDelib+
                '&dataChiusAnnoCont='+dataChiusAnnoCont+
                '&motRepricing='+motRepricing+
                '&richEmissRepr='+richEmissRepr;
 
  chiamaRichiesta(sendMessage,'lancioBatchRepricingManuale',asyncFunz);  
  
}

function ONLANCIOBATCH()
{
  var select= document.formPag.comboRiepilogoAccount;
  var code_tipo_contr = document.formPag.code_tipo_contr.value;

  if (document.formPag.generaReport.checked)
    document.formPag.generaReport.value="1";
  else
    document.formPag.generaReport.value="0";
  
  //if (document.formPag.fcIva.checked)
  //  document.formPag.fcIva.value="N";
  //else
  //  document.formPag.fcIva.value="S";
    
  /*I: F.Spiezia - Mod Parallelo 18-11-2015*/
  if (document.formPag.parallelo.checked)
    document.formPag.parallelo.value="S";
  else
    document.formPag.parallelo.value="N";
  /*F: F.Spiezia - 18-11-2015*/
  
    /*I: - Mod 5 anni 10-02-2016*/
  if (document.formPag.ant5Anni.checked)
    document.formPag.ant5Anni.value="S";
  else
    document.formPag.ant5Anni.value="N";
  /*F: Mod 5 anni 10-02-2016*/
  
    /*I: - R1I-19-0356 */
  if (document.formPag.reprDel.checked)
    document.formPag.reprDel.value="S";
  else
    document.formPag.reprDel.value="N";
    
  if (document.formPag.richEmissRepr.checked)
    document.formPag.richEmissRepr.value="S";
  else
    document.formPag.richEmissRepr.value="N";    
    /*F: - R1I-19-0356 */  
  
  //var fcIva = document.formPag.fcIva.value;
  var parallelo = document.formPag.parallelo.value; /*F.Spiezia - Mod Parallelo 18-11-2015*/
  var ant5Anni = document.formPag.ant5Anni.value;
  var reprDel = document.formPag.reprDel.value;   /*F: - R1I-19-0356 */
  var richEmissRepr = document.formPag.richEmissRepr.value;   /*F: - R1I-19-0356 */
  var generaReport = document.formPag.generaReport.value;
  var dataSched = document.formPag.dataSched.value;
  var dataDelib = document.formPag.dataDelib.value;
  var dataChiusAnnoCont = document.formPag.dataChiusAnnoCont.value;
  var motRepricing = document.formPag.testoRepr.value + " " + document.formPag.motivazioneRepr.value;
  var messaggio='';
  for(i=0;i <select.length ;i++)
  {
    messaggio+=select.options[i].value;
    if(i!=select.length-1)
    messaggio+='$';
  }
  
  var controlDate=true;
  if(document.formPag.reprDel.checked)
  {
    if(document.formPag.dataDelib.value == "" || document.formPag.dataDelib.value == undefined)
    {
      alert("Inserire la Data Publicazione Delibera");
      controlDate=false;
    }
    else
    {
        if(document.formPag.dataChiusAnnoCont.value == "" || document.formPag.dataChiusAnnoCont.value == undefined)
        {
            alert("Inserire il Giorno chiusura dichiarazione IVA");
            controlDate=false;
        }
        else
        {
            var appodataMin = document.formPag.dataDelib.value;
            var dataMin = appodataMin.substring(6,10) + appodataMin.substring(3,5) + appodataMin.substring(0,2);
            var appodataIni = formPag.dataChiusAnnoCont.value;
            var dataIni = appodataIni.substring(6,10) + appodataIni.substring(3,5) + appodataIni.substring(0,2);
            if(!(dataIni > dataMin)) {
                alert("Attenzione: Giorno chiusura dichiarazione IVA minore o uguale della Data Pubblicazione Delibera");
                controlDate=false;
            }
        }
    }        
  }
  else
  {
    dataDelib = "31/12/9999";
    dataChiusAnnoCont = "31/12/9999";
    
  }
  
  
 if(document.formPag.motivazioneRepr.value == "") {
     alert("Attenzione: Inserire la motivazione del Repricing!!");
     controlDate=false;                
 }
                
  if(controlDate) {
      if(document.formPag.schedulazione.checked){
        if(document.formPag.dataSched.value == "" || document.formPag.dataSched.value == undefined){
          alert("Inserire la Data/Ora Schedulazione");
        }else{
          var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
          var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
          var asyncFunz=  function(){ handler_generico(http,carica,errore);};
          var sendMessage='codiceTipoContratto=1&elencoAccount='+
                      messaggio+
                      '&codeTipoContr='+code_tipo_contr+
                      '&generaReport='+generaReport+
                      '&dataSched='+dataSched+
                      //'&fcIva='+fcIva+
                      '&fcIva=X'+
                      '&parallelo='+parallelo+ /*F: F.Spiezia - 18-11-2015*/
                      '&ant5Anni='+ant5Anni+
                      '&codeFunz=26'+
                      '&reprDel='+reprDel+
                      '&richEmissRepr='+richEmissRepr+
                      '&dataDelib='+dataDelib+
                      '&dataChiusAnnoCont='+dataChiusAnnoCont+
                      '&motRepricing='+motRepricing;
                      
                      
          //alert ("sendMessage= " + sendMessage);            
          chiamaRichiesta(sendMessage,'lancioBatchRepricing',asyncFunz);
        }
      }else{
        var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
        var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
        var asyncFunz=  function(){ handler_generico(http,carica,errore);};
        var sendMessage='codiceTipoContratto=1&elencoAccount='+
                    messaggio+
                    '&codeTipoContr='+code_tipo_contr+
                    '&generaReport='+generaReport+
                    '&dataSched='+dataSched+
                    //'&fcIva='+fcIva+
                    '&fcIva=X'+
                    '&parallelo='+parallelo+ /*F: F.Spiezia - 18-11-2015*/
                    '&ant5Anni='+ant5Anni+
                    '&codeFunz=26'+
                    '&reprDel='+reprDel+
                    '&richEmissRepr='+richEmissRepr+
                    '&dataDelib='+dataDelib+
                    '&dataChiusAnnoCont='+dataChiusAnnoCont+
                    '&motRepricing='+motRepricing;
                    
        //alert ("sendMessage= " + sendMessage);
        chiamaRichiesta(sendMessage,'lancioBatchRepricing',asyncFunz);  
    
      }
    }  
  
}

function gestisciErroreBloccante(messaggio)
{
  gestisciMessaggio(messaggio);
// document.formPag.LANCIOBATCH.disabled="true";
}

function gestisciMessaggio(messaggio)
{
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';
}

function ONINSERISCI_SEL()
{
  spostaElemento('comboAccount','comboRiepilogoAccount');
  if(document.formPag.comboRiepilogoAccount.options.length!=0)
    document.formPag.LANCIOBATCH.disabled="false";
  DisabilitaBottonRepricing();
}
function ONELIMINA()
{
  spostaElemento('comboRiepilogoAccount','comboAccount');
  if(document.formPag.comboRiepilogoAccount.options.length == 0)
//    document.formPag.LANCIOBATCH.disabled="true";
  DisabilitaBottonRepricing();
}

function ONINSERISCI_TUTTI()
{
  spostaElementi('comboAccount','comboRiepilogoAccount');
  if(document.formPag.comboRiepilogoAccount.options.length!=0)
    document.formPag.LANCIOBATCH.disabled="false";
  DisabilitaBottonRepricing();
}

function f_calendarioSched(obj)
{
  if(obj.checked){
    attivaCalendarioSched=true;
    document.formPag.dataSched.value="";
    EnableLink(document.links[4],document.formPag.calendarioSched);
    EnableLink(document.links[5],document.formPag.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.formPag.LANCIOBATCH.value = "Schedula Batch";
  }else{
    attivaCalendarioSched=false;
    document.formPag.dataSched.value="";
    DisableLink(document.links[4],document.formPag.calendarioSched);
    DisableLink(document.links[5],document.formPag.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.formPag.LANCIOBATCH.value = "Lancio Batch";
  }
}

function f_calendarioDelib(obj)
{
  document.formPag.motivazioneRepr.value = "";
  if(obj.checked){
    attivaCalendarioDelib=true;
    document.formPag.dataDelib.value="";
    document.formPag.dataChiusAnnoCont.value="";
    document.formPag.testoRepr.value="<%=testoDelib%>";
    EnableLink(document.links[0],document.formPag.calendarioDelib);
    EnableLink(document.links[1],document.formPag.cancella_dataDelib);
    EnableLink(document.links[2],document.formPag.calendarioDataChiusAnnoCont);
    EnableLink(document.links[3],document.formPag.cancella_dataChiusAnnoCont);    
    msg1=message1;
    msg2=message2;
  }else{
    attivaCalendarioDelib=false;
    document.formPag.dataDelib.value="";
    document.formPag.dataChiusAnnoCont.value="";
    document.formPag.testoRepr.value="<%=testoRepr%>";
    DisableLink(document.links[0],document.formPag.calendarioDelib);
    DisableLink(document.links[1],document.formPag.cancella_dataDelib);
    DisableLink(document.links[2],document.formPag.calendarioDataChiusAnnoCont);
    DisableLink(document.links[3],document.formPag.cancella_dataChiusAnnoCont);    
    msg1=message1;
    msg2=message2;
  }
}

function DisabilitaBottonRepricing()
{
  if(document.formPag.comboRiepilogoAccount.length!=0)
  {
    Enable(document.formPag.LANCIOBATCH);
    Enable(document.formPag.ELIMINA);
    Enable(document.formPag.generaReport);
    Enable(document.formPag.schedulazione);
    //Enable(document.formPag.fcIva);
    Enable(document.formPag.parallelo); /*F: F.Spiezia - 18-11-2015*/
    Enable(document.formPag.ant5Anni);    
    Enable(document.formPag.reprDel); /*I: - R1I-19-0356 */
    Enable(document.formPag.richEmissRepr); /*I: - R1I-19-0356 */
    Enable(document.formPag.testoRepr);  
    if(document.formPag.comboRiepilogoAccount.length==0){
      if (attivaCalendarioSched){
        f_calendarioSched(document.formPag.schedulazione);
      }
      if (attivaCalendarioDelib){
        f_calendarioDelib(document.formPag.reprDel);
      }      
    }
    if(document.formPag.reprDel.checked) {
        document.formPag.testoRepr.value="<%=testoDelib%>";
    }
    else {
        document.formPag.testoRepr.value="<%=testoRepr%>";
    }
  }
  else
  {
    document.formPag.LANCIOBATCH.disabled = true;
    document.formPag.ELIMINA.disabled = true;
    //document.formPag.fcIva.disabled = true;
    document.formPag.parallelo.disabled = true; /*F: F.Spiezia - 18-11-2015*/
    document.formPag.ant5Anni.disabled = true;
    document.formPag.reprDel.disabled = true;   /*I: - R1I-19-0356 */
    document.formPag.reprDel.checked=false; /*I: - R1I-19-0356 */
    document.formPag.reprDel.value="N"; /*I: - R1I-19-0356 */
    document.formPag.richEmissRepr.disabled = true;   /*I: - R1I-19-0356 */
    document.formPag.generaReport.disabled = true;
    document.formPag.schedulazione.disabled = true;
    document.formPag.testoRepr.disabled = true;
    document.formPag.motivazioneRepr.value = "";      
    document.formPag.generaReport.value="0";
    document.formPag.schedulazione.checked=false;
    document.formPag.schedulazione.value="N";
    document.formPag.dataSched.value="";
    if (attivaCalendarioSched){ 
      f_calendarioSched(document.formPag.schedulazione);
    }
    if (attivaCalendarioDelib){
      f_calendarioDelib(document.formPag.reprDel);
    }     
    document.formPag.testoRepr.value = ""; 
  }
  
  if(document.formPag.comboAccount.length==0) 
  {
    document.formPag.INSERISCI_SEL.disabled = "true";
    document.formPag.INSERISCI_TUTTI.disabled = "true";    
  }
  else
  {
    Enable(document.formPag.INSERISCI_SEL);
    Enable(document.formPag.INSERISCI_TUTTI);
  }
}

function DisableObj(objElement)
{
  objElement.disabled = true;
}

</script>
<body onload="caricaAccount()">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:hidden;display:none">
<form name="formPag" method="post">
<input type="hidden" name="code_tipo_contr">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.GIF" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Repricing&nbsp;  </td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
        
                </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
<!-- CARICO LISTA ACCOUNT -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
             <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Cliente</td>
             <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
            </tr>
            <tr>
             <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="#cfdbe9">
		 	          <tr>
           				<td <td colspan='2'>&nbsp;</td>
                </tr>
               <tr> 
                  <td class="textB" valign="top" width="30%">&nbsp;Account</td>
           				<td class="text" align="left" width="70%">

                    <Select name="comboAccount" size="7" style="width: 80%;" width="400px" class="text">
                   
                    </select>

                   </td>
               </tr>
                <tr>
           				<td colspan='2'>&nbsp;</td>
                </tr>
              </table>
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
       </td>
      </tr>
      <tr>
       <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
<!-- INSERISCO ISTRUZIONI PER LA 2 LISTA  -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
             <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo</td>
             <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
            </tr>
            <tr>
             <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="#cfdbe9">
                <tr>
           				<td <td colspan='2'>&nbsp;</td>
                </tr>
                <tr>
                  <td class="textB" valign="top" width="30%">&nbsp;Account</td>
           				<td class="text" align="left" width="70%">
                     <Select name="comboRiepilogoAccount" size="7" width="400px" style="width: 80%;" class="text"></select>
                 </td>
               </tr>
               <tr>
           				<td <td colspan='2'>&nbsp;</td>
               </tr>
              </table>
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
       </td>
      </tr>
      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>

      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>
      
<!-- inizio paolo -->
      <tr>
       <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="right">
               Repricing da Delibera:
               <input type=checkbox name=reprDel value="N" onclick="f_calendarioDelib(document.formPag.reprDel)">&nbsp;&nbsp;
               Data pubblicazione delibera:&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" readonly name="dataDelib" title="dataDelib" value="" onfocus="myFunc(formPag.dataDelib.value);"> 
               <a href="javascript:showCalendar('formPag.dataDelib','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true" onfocus="myFunc(formPag.dataDelib.value);"><img name='calendarioDelib' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancellaCalendari();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataDelib' src="../../common/images/img/images7.gif" border="0"></a>
               &nbsp;
               Giorno chiusura dichiarazione IVA:&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" readonly name="dataChiusAnnoCont" title="dataChiusAnnoCont" value=""> 
               <a href="javascript:showCalendar('formPag.dataChiusAnnoCont','');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioDataChiusAnnoCont' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancelCalendar(document.formPag.dataChiusAnnoCont);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataChiusAnnoCont' src="../../common/images/img/images7.gif" border="0"></a>
               &nbsp;             
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
			 </td>
      </tr>
      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>
      
      <tr>
       <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="right">
               Motivazione Repricing:&nbsp;      
               <input type="text" class="text" size=30 readonly name="testoRepr" title="testoRepr" value="<%=testoRepr%>" >
               <input type="text" class="text" size=40 maxlength="20" name="motivazioneRepr" title="motivazioneRepr" value="" >              
               Richiesta emissione repricing entro mese in corso:
               <input type=checkbox name=richEmissRepr value="N" >&nbsp;&nbsp;
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
			 </td>
      </tr>
      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>      
<!-- fine paolo -->
      
      <tr>
       <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="right">
               Dati Ant. 5 anni:
               <input type=checkbox name=ant5Anni value="S">&nbsp;&nbsp;
               PARALLELO:
               <input type=checkbox name=parallelo value="S">&nbsp;&nbsp;
               <!-- R1I-19-0356 
               NO FC IVA:
               <input type=checkbox name=fcIva value="S">&nbsp;&nbsp; R1I-19-0356 -->
               Genera Report:
               <input type=checkbox name=generaReport value="0">&nbsp;&nbsp;
               Schedulazione:
               <input type=checkbox name=schedulazione value="N" onclick="f_calendarioSched(document.formPag.schedulazione)"> &nbsp;
               Data/Ora Schedulazione :&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" name="dataSched" title="dataSched" value="" > 
               <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancelCalendar(document.formPag.dataSched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
               &nbsp;
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
			 </td>
      </tr>

      
      <tr>
       <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
 </table>
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <sec:ShowButtons VectorName="vectorButton" />
    </td>
  </tr>
</table>

 <script language="JavaScript">
       var cal3 = new calendar1(document.forms['formPag'].elements['dataSched']);
       cal3.year_scroll = true;
       cal3.time_comp = true;
 </script>
 
 </form>
</div>







</body>
<script>
var http=getHTTPObject();
</script>

</html>
