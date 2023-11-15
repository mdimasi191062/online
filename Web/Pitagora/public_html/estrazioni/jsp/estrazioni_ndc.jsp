<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<!--%@ taglib uri="/webapp/pg" prefix="pg" %-->
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"estrazioni_ndc.jsp")%>
</logtag:logData>

<%
String strCheckCess ="";
String strMinDataCess = "";
String strMaxDataCess = "";
String strCheckCiclo ="";
String strMaxCiclo = "";
String strMinCiclo = "";
String strAnnoCessazione = "";
String strMeseCessazione = "";
%>

<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>


<SCRIPT LANGUAGE='Javascript'>

var objForm = null;
var codeTipoContr = '';
var minCiclo='';
var maxCiclo='';
var minCess='';
var maxCess='';

objForm = document.formPag;

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none';
}

function selectAllComboElementsWithClasses(Field)
	{
		var len = Field.length;
		var x=0;
		for (x=0;x<len;x++)
		{
      alert('Field.className ['+Field.className+']');
      if (Field.className == 'textListRosso'){
  			Field.options[x].selected = true;
      }
		}
	}

function ONESEGUI(){
var esegui=0;
var AnnoCessazione=document.formPag.AnnoCessazione.value;
var MeseCessazione=document.formPag.MeseCessazione.value;
var Ambiente=document.formPag.comboAmbiente.selectedIndex;
if (Ambiente < 1)
    {
        alert("Selezionare la tipologia di estrazione");
    }

selectAllComboElements(formPag.comboDisponibiliServizi);
selectAllComboElements(formPag.comboAccorpatiServizi);
cboSource=formPag.comboDisponibiliServizi;
cboSourceServizi=formPag.comboAccorpatiServizi;
cboSourceOperatori=formPag.comboAccorpatiOperatori;

var i = 0;
var j=0;
var k=0;
var listaClli="";
var listaServizi="";
var listaOperatori="";

    if(cboSourceServizi.length==0)
    {
      if(esegui!=1)
        alert("Selezionare almeno un servizio!");
      esegui=1;
    } else {
    
     while (cboSourceServizi.length > j)
          {
              if(j==0)
              {
                listaServizi=getComboValueByIndex(cboSourceServizi,j);
              } else
              {
                listaServizi=listaServizi+'#'+getComboValueByIndex(cboSourceServizi,j);
              }
              j++;
          }
    
    }
 
      while (cboSourceOperatori.length > k)
          {
              if(k==0)
              {
                listaOperatori=getComboValueByIndex(cboSourceOperatori,k);
              } else
              {
                listaOperatori=listaOperatori+'#'+getComboValueByIndex(cboSourceOperatori,k);
              }
              k++;
          }
 
 
    var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  
//    alert("Lista Operatori: " + listaOperatori);
    var sendMessage='codiceTipoContratto=1&codeTipoContr=41&codeFunz=30&id_funz=22&TipoEstrazione=30&Ambiente='+Ambiente+'&AnnoCessazione='+AnnoCessazione+'&MeseCessazione='+MeseCessazione+'&listaServizi='+listaServizi+'&listaOperatori='+listaOperatori;
    chiamaRichiesta(sendMessage,'EstrazioneNDCCessate',asyncFunz);

}

function riempiSelectNDCServizi(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length - 1;a++)
      {
         eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
      }
}

function riempiSelectOperatori(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length - 1;a++)
      {
         eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
      }
}

function caricaTipoContr()
{
 document.formPag.comboAccount.disabled=true;
 document.formPag.comboAccount.style.visibility='hidden';
 document.formPag.comboAccount.style.display='none';
 document.formPag.chkAccount.checked=true;
 document.formPag.chkAccount.disabled=true;
 //var carica = function(dati){riempiSelect('comboTipoContr',dati);};
 //var carica = function(dati){riempiSelect('comboAccorpatiServizi',dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 //chiamaRichiesta('','listaTipoContrRientriTI',asyncFunz);
     chiamaRichiesta('codeTipoContr=5','listaPsXTipoContr',asyncFunz);

}

function caricaAccount()
{
 document.formPag.comboAccount.disabled=false;
document.formPag.comboAccount.length=0;
 var carica = function(dati){riempiSelect('comboAccount',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 indice= document.formPag.comboTipoContr.selectedIndex;
 valore= document.formPag.comboTipoContr.options[indice].value;
  if(valore=="null"){
       document.formPag.comboAccount.style.visibility='hidden';
       document.formPag.comboAccount.style.display='none';
       document.formPag.chkAccount.checked=true;
       document.formPag.chkAccount.disabled=true;
       }
  else {
      chiamaRichiesta('codeTipoContr='+valore,'listaAccountXTipoContr',asyncFunz);
      document.formPag.comboAccount.style.visibility='visible';
      document.formPag.comboAccount.style.display='inline';
      document.formPag.chkAccount.checked=false;
      document.formPag.chkAccount.disabled=false;
      }
}


function abilitaTipologia() {

    if ( document.formPag.comboAmbiente.value == 2  ) {
        caricaServiziClassic();
    } else if ( document.formPag.comboAmbiente.value == 1 ) {
        caricaServiziRegolatorio();
    } else if ( document.formPag.comboAmbiente.value == 3 ) {
        caricaServiziXdsl();
    } else {
        ClearCombo(document.formPag.comboDisponibiliServizi);
        ClearCombo(document.formPag.comboAccorpatiServizi);
        ClearCombo(document.formPag.DisponibiliOperatori);
        ClearCombo(document.formPag.comboAccorpatiOperatori);
    }
}


function DisabilitaComboAccount()
{
  if(document.formPag.chkAccount.checked)
  {
    document.formPag.comboAccount.style.visibility='hidden';
    document.formPag.comboAccount.style.display='none';
  }
 else 
 {
    document.formPag.comboAccount.style.visibility='visible';
    document.formPag.comboAccount.style.display='inline';
 
 }
}

function DataCicloVisibile()
{
  if(document.formPag.chkCiclo.checked)
  {
    document.formPag.imgCalendar1.style.visibility='hidden';
    document.formPag.imgCalendar1.style.display='none';
 
    document.formPag.imgCancel1.style.visibility='hidden';
    document.formPag.imgCancel1.style.display='none';
 
    document.formPag.imgCalendar2.style.visibility='hidden';
    document.formPag.imgCalendar2.style.display='none';
    
    document.formPag.imgCancel2.style.visibility='hidden';
    document.formPag.imgCancel2.style.display='none';

    clearField(document.formPag.txtMinCiclo);
    clearField(document.formPag.txtMaxCiclo);
    document.formPag.txtMinCiclo.value="Tutte le Date";
    document.formPag.txtMaxCiclo.value="Tutte le Date";
  }
 else 
 {
    document.formPag.imgCalendar1.style.visibility='visible';
    document.formPag.imgCalendar1.style.display='inline';
 
    document.formPag.imgCancel1.style.visibility='visible';
    document.formPag.imgCancel1.style.display='inline';
  
    document.formPag.imgCalendar2.style.visibility='visible';
    document.formPag.imgCalendar2.style.display='inline';
    
    document.formPag.imgCancel2.style.visibility='visible';
    document.formPag.imgCancel2.style.display='inline';
    clearField(document.formPag.txtMinCiclo);
    clearField(document.formPag.txtMaxCiclo);
 }
}

function DataCicloVisibile2()
{
  if(document.formPag.chkCess.checked)
  {
    document.formPag.imgCalendar3.style.visibility='hidden';
    document.formPag.imgCalendar3.style.display='none';

    document.formPag.imgCancel3.style.visibility='hidden';
    document.formPag.imgCancel3.style.display='none';

    document.formPag.imgCalendar4.style.visibility='hidden';
    document.formPag.imgCalendar4.style.display='none';

    document.formPag.imgCancel4.style.visibility='hidden';
    document.formPag.imgCancel4.style.display='none';
 
    clearField(formPag.txtMinDataCess);
    clearField(formPag.txtMaxDataCess);
    document.formPag.txtMinDataCess.value="Tutte le Date";
    document.formPag.txtMaxDataCess.value="Tutte le Date";
  } 
  else 
  {
    document.formPag.imgCalendar3.style.visibility='visible';
    document.formPag.imgCalendar3.style.display='inline';
 
    document.formPag.imgCancel3.style.visibility='visible';
    document.formPag.imgCancel3.style.display='inline';

    document.formPag.imgCalendar4.style.visibility='visible';
    document.formPag.imgCalendar4.style.display='inline';
 
    document.formPag.imgCancel4.style.visibility='visible';
    document.formPag.imgCancel4.style.display='inline';
  
    clearField(formPag.txtMinDataCess);
    clearField(formPag.txtMaxDataCess);

  }
}

function addOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
	var myOpt = null;
  var classe = '';
  
  if(cboSource.name == 'comboDisponibiliServizi')
    classe = 'textListRosso';
  else
    classe = 'textList';
  
	if(index != -1)
	{
		myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource));
		myOpt.className = classe;
		DelOptionByIndex(cboSource,index);
                
                if(cboSource.name == 'comboDisponibiliServizi') {
                    if(document.formPag.comboAmbiente.value == 2) {
                        caricaOperatoreClassic();
                    } else {
                        caricaOperatoreSpecial();
                    } 
                }                    
	}

        var c = document.getElementById("comboAccorpatiOperatori");
        if (c.length > 0)
        {
            document.getElementById("AggiornaNew").disabled = false; 
        }
        else
        {
            document.getElementById("AggiornaNew").disabled = true; 
        }        
  	
}

function caricaOperatoreClassic() {

    cboSourceServizi=formPag.comboAccorpatiServizi;
    
    var j=0;
    var listaServizi="";
   
     while (cboSourceServizi.length > j)
          {
              if(j==0)
              {
                listaServizi=getComboValueByIndex(cboSourceServizi,j);
              } else
              {
                listaServizi=listaServizi+'#'+getComboValueByIndex(cboSourceServizi,j);
              }
              j++;
          }

    ClearCombo(document.formPag.comboDisponibiliOperatori);
    ClearCombo(document.formPag.comboAccorpatiOperatori);

    document.formPag.comboDisponibiliOperatori.style.visibility='visible';
    document.formPag.comboDisponibiliOperatori.style.display='inline';
    document.formPag.comboAccorpatiOperatori.style.visibility='visible';
    document.formPag.comboAccorpatiOperatori.style.display='inline';

    var carica = function(dati){riempiSelectOperatori('comboDisponibiliOperatori', dati); };
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('listaServizi='+listaServizi,'listaOperatoriClassic',asyncFunz);    
}

function caricaOperatoreSpecial() {

    cboSourceServizi=formPag.comboAccorpatiServizi;
    
    var j=0;
    var listaServizi="";
   
     while (cboSourceServizi.length > j)
          {
              if(j==0)
              {
                listaServizi=getComboValueByIndex(cboSourceServizi,j);
              } else
              {
                listaServizi=listaServizi+'#'+getComboValueByIndex(cboSourceServizi,j);
              }
              j++;
          }

    ClearCombo(document.formPag.comboDisponibiliOperatori);
    ClearCombo(document.formPag.comboAccorpatiOperatori);

    document.formPag.comboDisponibiliOperatori.style.visibility='visible';
    document.formPag.comboDisponibiliOperatori.style.display='inline';
    document.formPag.comboAccorpatiOperatori.style.visibility='visible';
    document.formPag.comboAccorpatiOperatori.style.display='inline';

    var carica = function(dati){riempiSelectOperatori('comboDisponibiliOperatori', dati); };
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('listaServizi='+listaServizi,'listaOperatoriSpecial',asyncFunz);    
}

function addAllOptionToComboWithClass(cboSource,cboDestination){
	var myOpt = null;
	var i = 0;
  if(cboSource.name == 'comboDisponibiliServizi')
    classe = 'textListRosso';
  else
    classe = 'textList';
	
  while (cboSource.length > i)
	{
    myOpt = addOption(cboDestination,getComboTextByIndex(cboSource,i),getComboValueByIndex(cboSource,i));
		myOpt.Attributo = cboSource.options[i].Attributo;
    myOpt.className = classe;
		DelOptionByIndex(cboSource,i);
  }  

                if(cboSource.name == 'comboDisponibiliServizi'){
                    if(document.formPag.comboAmbiente.value == 2) {
                        caricaOperatoreClassic();
                    } else {
                        caricaOperatoreSpecial();
                    } 
                }   
                
        var c = document.getElementById("comboAccorpatiOperatori");
        if (c.length > 0)
        {
            document.getElementById("AggiornaNew").disabled = false; 
        }
        else
        {
            document.getElementById("AggiornaNew").disabled = true; 
        }  
}

function removeOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
  var myOpt = null;
  if(index != -1)
  {
    myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
    myOpt.className == 'textList';
    DelOptionByIndex(cboSource,index); 
  }

                if(cboSource.name == 'comboAccorpatiServizi') {
                    if( document.formPag.comboAmbiente.value == 2) {
                        caricaOperatoreClassic();
                    } else {
                        caricaOperatoreSpecial();
                    } 
                }   

        var c = document.getElementById("comboAccorpatiOperatori");
        if (c.length > 0)
        {
            document.getElementById("AggiornaNew").disabled = false; 
        }
        else
        {
            document.getElementById("AggiornaNew").disabled = true; 
        }                
}

function addAllOptionsToComboNew(cboSource,cboDestination){
	var myOpt = null;
	var i = 0;
  while (cboSource.length > i)
	{
		myOpt = addOption(cboDestination,getComboTextByIndex(cboSource,i),getComboValueByIndex(cboSource,i));
    myOpt.path_file = cboSource.options[i].path_file;
		DelOptionByIndex(cboSource,i);
	}

                if(cboSource.name == 'comboAccorpatiServizi') {
                    if(document.formPag.comboAmbiente.value == 2) {
                        caricaOperatoreClassic();
                    } else {
                        caricaOperatoreSpecial();
                    } 
                }
                
        var c = document.getElementById("comboAccorpatiOperatori");
        if (c.length > 0)
        {
            document.getElementById("AggiornaNew").disabled = false; 
        }
        else
        {
            document.getElementById("AggiornaNew").disabled = true; 
        }
}

function caricaServiziClassic() {
    ClearCombo(document.formPag.comboDisponibiliServizi);
    ClearCombo(document.formPag.comboAccorpatiServizi);
    ClearCombo(document.formPag.comboDisponibiliOperatori);
    ClearCombo(document.formPag.comboAccorpatiOperatori);    

    document.formPag.comboDisponibiliServizi.style.visibility='visible';
    document.formPag.comboDisponibiliServizi.style.display='inline';
    document.formPag.comboAccorpatiServizi.style.visibility='visible';
    document.formPag.comboAccorpatiServizi.style.display='inline';

   var carica = function(dati){riempiSelectNDCServizi('comboDisponibiliServizi', dati); };
   var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
   var asyncFunz=  function(){ handler_generico(http,carica,errore);};
   chiamaRichiesta('','listaTipiServiziAssurance',asyncFunz);    
}

function caricaServiziRegolatorio() {
    ClearCombo(document.formPag.comboDisponibiliServizi);
    ClearCombo(document.formPag.comboAccorpatiServizi);
    ClearCombo(document.formPag.comboDisponibiliOperatori);
    ClearCombo(document.formPag.comboAccorpatiOperatori); 

    document.formPag.comboDisponibiliServizi.style.visibility='visible';
    document.formPag.comboDisponibiliServizi.style.display='inline';
    document.formPag.comboAccorpatiServizi.style.visibility='visible';
    document.formPag.comboAccorpatiServizi.style.display='inline';

   var carica = function(dati){riempiSelectNDCServizi('comboDisponibiliServizi', dati); };
   var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
   var asyncFunz=  function(){ handler_generico(http,carica,errore);};
   chiamaRichiesta('','listaTipiServiziAssuranceReg',asyncFunz);   
}

function caricaServiziXdsl() {
    ClearCombo(document.formPag.comboDisponibiliServizi);
    ClearCombo(document.formPag.comboAccorpatiServizi);
    ClearCombo(document.formPag.comboDisponibiliOperatori);
    ClearCombo(document.formPag.comboAccorpatiOperatori);     

    document.formPag.comboDisponibiliServizi.style.visibility='visible';
    document.formPag.comboDisponibiliServizi.style.display='inline';
    document.formPag.comboAccorpatiServizi.style.visibility='visible';
    document.formPag.comboAccorpatiServizi.style.display='inline';

   var carica = function(dati){riempiSelectNDCServizi('comboDisponibiliServizi', dati); };
   var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
   var asyncFunz=  function(){ handler_generico(http,carica,errore);};
   chiamaRichiesta('','listaTipiServiziAssuranceXDSL',asyncFunz);    
}
</SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
 <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>
<body onload="inizializza();caricaAccount();">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">
<form name="formPag" method="post">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.GIF" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
        <td>
          <table width="95%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Estrazioni NDC per risorse cessate</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
          </table>
        </td>
      </tr>
      </table>
      <br>
      <table width="90%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Estrazione JPUB</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>      
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Tipo Estrazione</td>
          <td width="80%">
            <select name="comboAmbiente" id="comboAmbiente" width="10px" class="text" onchange="abilitaTipologia();">
              <option value="0" selected=true>Selezionare Tipogia</option>
              <option value="2">CLASSIC</option>
              <option value="1">REGOLATORIO</option>
              <option value="3">XDSL</option>
              </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
        </tr>  
      <!-- table width="90%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" -->
<!--
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Contratto</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>     
        
        <tr HEIGHT='35px'>
            <td class="textB" width="20%">Tipo Contratto</td>
            <td width="80%"><select type="hidden" name="comboTipoContr" width="10px" class="text" onchange="caricaAccount()">
            
              <option value="" selected=true>Selezionare Tipo Contratto</option>
              <option value="9">ULL</option>
              <option value="37">ULL Dati</option>
              <option value="23">VULL</option>
              <option value="17">Shared Access</option>
              <option value="7">NP</option>
              <option value="8">CPS</option>
              <option value="41">WLR</option>     
              <option value="42">Bitstream ATM Parent/Distant</option>
              <option value="44">Bitstream GBE Parent/Distant</option>  
              <option value="13">E@SYIP ADSL</option>
              <option value="1">EASYIP WS S.L. FLAT</option>    
              <option value="18">CVP - ASIMMETRICO-SIMMETRICO</option>   
              <option value="21">ADSL WS S.L. FLAT</option>
              <option value="11">ADSL</option>
              <option value="38">Managed IP  ADSL a 20 Mbit/s flat</option>
              <option value="43">SLA Bistream ATM/GBE Parent/Distant</option>
            
            </select></td>
          <td class="textB"></td>
        </tr>
-->
        
          <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Servizi</td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                  <tr>
                  <td colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <td class="text" align="center" widht="49%">Elenco Servizi disponibili</td>
                        <td class="text" widht="2%">&nbsp;</td>
                        <td class="text" align="center" widht="49%">Elenco Servizi da lanciare</td>
                      </Tr>
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                        <Td  class="text"  widht="25%">
                          <Select name="comboDisponibiliServizi" title="Servizi disponibili" id="comboDisponibiliServizi" size="10" class="textList" ondblclick="addOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">                     
                          </select>
                        </Td>
                        <Td align="center" width="2%" valign="middle">
                          <INPUT  type="button" name=Button1 value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">                        
                          <INPUT  type="button" name=Button2 value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">
                          <INPUT  type="button" name=Button3 value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpatiServizi,formPag.comboDisponibiliServizi)">
                          <INPUT  type="button" name=Button4 value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToComboNew(formPag.comboAccorpatiServizi,formPag.comboDisponibiliServizi)">
                        </Td>
                        <Td class="text" widht="25%">
                          <Select  name="comboAccorpatiServizi" multiple title="Servizi selezionati" id="comboAccorpatiServizi" size="10" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpatiServizi,frmDati.comboDisponibiliServizi)">
                          </select>
                        </Td>
                      </Tr>

                    </Table>
                  </td>
                </tr> 
                
          <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Operatori</td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                  <tr>
                  <td colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <td class="text" align="center" widht="49%">Elenco Operatori disponibili</td>
                        <td class="text" widht="2%">&nbsp;</td>
                        <td class="text" align="center" widht="49%">Elenco Operatori da lanciare</td>
                      </Tr>
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                        <Td  class="text"  widht="25%">
                          <Select name="comboDisponibiliOperatori" title="Operatori disponibili" id="comboDisponibiliOperatori" size="10" class="textList" ondblclick="addOptionToComboWithClass(formPag.comboDisponibiliOperatori,formPag.comboAccorpatiOperatori)">                     
                          </select>
                        </Td>
                        <Td align="center" width="2%" valign="middle">
                          <INPUT  type="button" name=Button1 value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionToComboWithClass(formPag.comboDisponibiliOperatori,formPag.comboAccorpatiOperatori)">                        
                          <INPUT  type="button" name=Button2 value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibiliOperatori,formPag.comboAccorpatiOperatori)">
                          <INPUT  type="button" name=Button3 value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpatiOperatori,formPag.comboDisponibiliOperatori)">
                          <INPUT  type="button" name=Button4 value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToComboNew(formPag.comboAccorpatiOperatori,formPag.comboDisponibiliOperatori)">
                        </Td>
                        <Td class="text" widht="25%">
                          <Select  name="comboAccorpatiOperatori" multiple title="Operatori selezionati" id="comboAccorpatiOperatori" size="10" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpatiOperatori,frmDati.comboDisponibiliOperatori)">
                          </select>
                        </Td>
                      </Tr>

                    </Table>
                  </td>
                </tr>                
<!--
        <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Account</td>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
            <td class="textB" width="20%">Account</td>
            <td class=="text" width="80%"><select name="comboAccount" class="text" size="7" style="width: 100%;"></select></td>
            <td class="textB">Tutti</td>
            <td class="textB">
                <input type='checkbox' name='chkAccount' value='<%=strCheckCess%>' onclick="DisabilitaComboAccount();">
            </td>
        </tr>
 
        <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Fatturazione</td>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
            <td class="textB">Min ciclo di fatturazione</td>
            <td class="text">
                <input type='text' name='txtMinCiclo' value='<%=strMinCiclo%>' class="text" readonly="">
                <a href="javascript:showCalendar('formPag.txtMinCiclo','');" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                <a href="javascript:clearField(formPag.txtMinCiclo);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
            </td>
            <td class="textB">Tutti</td>
            <td class="textB">
                <input type='checkbox' name='chkCiclo' value='<%=strCheckCiclo%>' onclick="DataCicloVisibile();">
            </td>
        </tr>
        <tr HEIGHT='35px'>
            <td class="textB">Max ciclo di fatturazione</td>
            <td class="text">
		<input type="text" name='txtMaxCiclo' value='<%=strMaxCiclo%>' class="text" readonly="">
                <a href="javascript:showCalendar('formPag.txtMaxCiclo','');" onMouseOut="status='';return true" ><img name='imgCalendar2' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                <a href="javascript:clearField(formPag.txtMaxCiclo);"  onMouseOut="status='';return true"><img name='imgCancel2'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
            </td>
        </tr>

 -->       
        <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="31%">&nbsp;Filtro Cessazione</td>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="50%"></td>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
            <td class="textB">Anno</td>
            <td class="text">
            <!--
                <input type='text' name='txtMinDataCess' value='<%=strMinDataCess%>' class="text" readonly="">
		<a href="javascript:showCalendar('formPag.txtMinDataCess','');" onMouseOut="status='';return true"><img name='imgCalendar3' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
		<a href="javascript:clearField(formPag.txtMinDataCess);" onMouseOut="status='';return true"><img name='imgCancel3'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
            -->
<%
Date DataOggi = new Date();
SimpleDateFormat formatter=new SimpleDateFormat("yyyy");
String AnnoCorrente=formatter.format(DataOggi);
int Oggi = Integer.parseInt(AnnoCorrente);
%>
            <select type="hidden" name="AnnoCessazione" width="10px" class="text">
            
       <%
                    for (int i = Oggi; i >= 2000; i--) 
                    {
                %>
                        <option value="<%=i%>"><%=i%></option>
            <% } %>
            </select>
            </td>
            <td class="textB"></td>
            <td class="textB">
<!--                <input type='checkbox' name='chkCess' value='' onclick="DataCicloVisibile2();">
 -->
 </td>
        </tr>

        <tr HEIGHT='35px'>
            <td class="textB">Mese</td>
            <td class="text">
            <select type="hidden" name="MeseCessazione" width="10px" class="text">
                        <option value="01">Gennaio</option>
                        <option value="02">Febbraio</option>
                        <option value="03">Marzo</option>
                        <option value="04">Aprile</option>
                        <option value="05">Maggio</option>
                        <option value="06">Giugno</option>
                        <option value="07">Luglio</option>
                        <option value="08">Agosto</option>
                        <option value="09">Settembre</option>
                        <option value="10">Ottobre</option>
                        <option value="11">Novembre</option>
                        <option value="12">Dicembre</option>
            </select>
            </td>
            <td class="textB"></td>
            <td class="textB">
            </td>
        </tr>

 <!--  
        <tr HEIGHT='35px'>
            <td class="textB">Max data di cessazione </td>
            <td class="text">
                <input type='text' name='txtMaxDataCess' value='<%=strMaxDataCess%>' class="text" readonly="">
                <a href="javascript:showCalendar('formPag.txtMaxDataCess','');" onMouseOut="status='';return true"><img name='imgCalendar4' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                <a href="javascript:clearField(formPag.txtMaxDataCess);"  onMouseOut="status='';return true"><img name='imgCancel4'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
            </td>
        </tr>
 -->      
        </table>
       
    </td>
    </tr>
</table>
<br>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" Enabled="false" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <input type="button" class="textB" name="AggiornaNew" id="AggiornaNew"  Disabled value="Esegui" onclick="ONESEGUI()">
    </td>
  </tr>
</table>
</form>
</div>
</body>
<script>
var http=getHTTPObject();
</script>
</html>
