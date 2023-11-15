<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
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
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"estrazioni.jsp")%>
</logtag:logData>
<%
String strMinCiclo = "";
String strMaxCiclo = "";
String strMinDataCess = "";
String strMaxDataCess = "";
String strCheckCiclo ="";
String strCheckCess ="";
String strCheckAsimm = "0";
%>

  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

 var objForm = null;
 objForm = document.formPag;


function riempiSelectWithClass(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length;a++)
  {        
    eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
    eval('document.formPag.'+select+'.options[a].className=dati[a].classe;');
  }
}

function addAllOptionToComboWithClass(cboSource,cboDestination){

	var myOpt = null;
	var i = 0;
  if(cboSource.name == 'comboDisponibili' || cboSource.name == 'comboDisponibiliServizi')
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
}

function addOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
	var myOpt = null;
  var classe = '';
  
  if(cboSource.name == 'comboDisponibili' || cboSource.name == 'comboDisponibiliServizi')
    classe = 'textListRosso';
  else
    classe = 'textList';
  
	if(index != -1)
	{
		myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource));
		myOpt.className = classe;
		DelOptionByIndex(cboSource,index);
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


function caricaCLLIdaProg()
{
    if(document.formPag.chkCLLI.checked){
      document.formPag.comboDisponibili.style.visibility='hidden';
      document.formPag.comboDisponibili.style.display='none';
      document.formPag.comboAccorpati.style.visibility='hidden';
     document.formPag.comboAccorpati.style.display='none';
  }else
  {
  
     document.formPag.comboDisponibili.style.visibility='visible';
     document.formPag.comboDisponibili.style.display='inline';
     document.formPag.comboAccorpati.style.visibility='visible';
     document.formPag.comboAccorpati.style.display='inline';
     
    indice= document.formPag.comboCLLIProg.selectedIndex;
    indiceAnno= document.formPag.comboAnni.selectedIndex;
    var CLLIProg;
    var anno;
    anno=document.formPag.comboAnni.options[indiceAnno].value;
    CLLIProg=document.formPag.comboCLLIProg.options[indice].value;
     var carica = function(dati){riempiSelect('comboDisponibili',dati);};
     var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
     var asyncFunz=  function(){ handler_generico(http,carica,errore);};
     chiamaRichiesta('prog='+CLLIProg+'&anno='+anno,'listaCLLI',asyncFunz);

   }
}


function caricaTipoContr()
{

ClearCombo(document.formPag.comboDisponibiliServizi);
ClearCombo(document.formPag.comboDisponibili);

ClearCombo(document.formPag.comboAccorpatiServizi);
ClearCombo(document.formPag.comboAccorpati);


document.formPag.comboDisponibiliServizi.style.visibility='visible';
document.formPag.comboDisponibiliServizi.style.display='inline';
document.formPag.comboAccorpatiServizi.style.visibility='visible';
document.formPag.comboAccorpatiServizi.style.display='inline';

document.formPag.comboDisponibili.style.visibility='hidden';
document.formPag.comboDisponibili.style.display='none';
document.formPag.comboAccorpati.style.visibility='hidden';
document.formPag.comboAccorpati.style.display='none';

 document.formPag.comboMesePartenza.style.visibility='visible';
    document.formPag.comboMesePartenza.style.display='inline';
    document.formPag.comboMeseArrivo.style.visibility='visible';
    document.formPag.comboMeseArrivo.style.display='inline';

document.formPag.chkCLLI.checked=true;


  indice= document.formPag.comboAnni.selectedIndex;
  var anno;
  anno=document.formPag.comboAnni.options[indice].value;
  var carica = function(dati){riempiSelect('comboDisponibiliServizi',dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('anno='+anno,'listaAnniTipoContr',asyncFunz);
   
}

//R1I-13-0066 Digital Divide
function checkAsimmetrici() {
  if(document.formPag.chkAsimm.checked)
    document.formPag.chkAsimm.value = '1';
    else 
       document.formPag.chkAsimm.value = '0';     
}

function ONESEGUI(){
var onlyAsimm = document.formPag.chkAsimm.value;
var esegui=0;
selectAllComboElements(formPag.comboAccorpati);
selectAllComboElements(formPag.comboAccorpatiServizi);
cboSource=formPag.comboAccorpati;
cboSourceServizi=formPag.comboAccorpatiServizi;
var i = 0;
var j=0;
var listaClli="";
var listaServizi="";



var indiceProg=document.formPag.comboCLLIProg.selectedIndex;
var CLLIProg="";

if(indiceProg<0)
{
  alert('Selezionare un progetto!');
  esegui=1;
} else
{
  CLLIProg=document.formPag.comboCLLIProg.options[indiceProg].value;
} 

indiceAnno=document.formPag.comboAnni.selectedIndex;
if(indiceAnno<1)
{
  if(esegui!=1)
    alert('Selezionare l’anno di riferimento!');
  esegui=1;
} else
{
  var anno=document.formPag.comboAnni[indiceAnno].value;
}


indiceMesePartenza= document.formPag.comboMesePartenza.selectedIndex;
indiceMeseArrivo=document.formPag.comboMeseArrivo.selectedIndex;
var mesePartenza=document.formPag.comboMesePartenza[indiceMesePartenza].value;
var meseArrivo=document.formPag.comboMesePartenza[indiceMeseArrivo].value;


var giorniMeseArrivo="";

if (meseArrivo=='04'||meseArrivo=='06'||meseArrivo=='09'||meseArrivo=='11'){
   giorniMeseArrivo='30';
} else if(meseArrivo=='02'){
        if(bisestile(anno))
            giorniMeseArrivo="29";
        else
            giorniMeseArrivo="28";
       } else{ 
          giorniMeseArrivo="31";
  }

    
var minData="01/"+mesePartenza+"/"+anno;
var maxData=giorniMeseArrivo+"/"+meseArrivo+"/"+anno;

if(mesePartenza>meseArrivo)
{ 
  if(esegui!=1)
    alert('Il mese di inizio deve essere precedente al mese di fine');
  esegui=1;
}

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

if(document.formPag.chkCLLI.checked){
      listaClli='null';
  }else
  {
 
      if(cboSource.length==0)
      {
        if(esegui!=1)
          alert("Selezionare almeno un CLLI!");
        esegui=1;
      } else if(cboSource.length>100)
      {
        if(esegui!=1)
          alert("E' possibile selezione al MASSIMO 100 CLLI!");
        esegui=1;
      }
      
      while (cboSource.length > i)
      {
          if(i==0)
          {
            listaClli=getComboValueByIndex(cboSource,i);
          } else
          {
            listaClli=listaClli+'#'+getComboValueByIndex(cboSource,i);
          }
          i++;
      }
 }






if(esegui==0)
{
 var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 //var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=2&codeCLLI='+CLLI+'&codeTipoContr='+tipoContr+'&codeAccount='+account+'&minCiclo='+TempminCiclo+'&maxCiclo='+TempmaxCiclo;
 var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=2&codeCLLIProg='+CLLIProg+'&codeCLLI='+listaClli+'&codeTipoContr='+listaServizi+'&minCiclo='+minData+'&maxCiclo='+maxData+'&onlyAsimm='+onlyAsimm;
 chiamaRichiesta(sendMessage,'ControllaDateRicaviAC',asyncFunz);
 } 
 
}


function convertimindata(dataDaConvertire){

var tokens = dataDaConvertire.split("/");
var anno = tokens[2];
var mese = tokens[1];
var giorno = tokens[0];

var data=new Date(anno,mese-1,giorno);
var gg, mm, aaaa;
gg = data.getDate();
mm = data.getMonth() + 1;
aaaa = data.getFullYear();


if(aaaa>2006){
if(mm<10){
  if(gg<10)
   ritorno="01/0"+mm+"/"+aaaa;
  else 
    ritorno="01/0"+mm+"/"+aaaa;
} else{
  if(gg<10)
   ritorno="01/"+mm+"/"+aaaa;
  else
    ritorno="01/"+mm+"/"+aaaa;
}

}
else {
     if(aaaa==2006){
          if(mm<6){
            mm=6;
           ritorno="01/0"+mm+"/2006";
          } else{
                if(mm<10)
                    ritorno="01/0"+mm+"/2006";
                else
                    ritorno="01/"+mm+"/2006";                    
          }
    } else
   ritorno="01/06/2006";
}

return ritorno;
}


function convertimaxdata(dataDaConvertire){


var tokens = dataDaConvertire.split("/");
var anno = tokens[2];
var mese = tokens[1];
var giorno = tokens[0];

var data=new Date(anno,mese-1,giorno);
var gg, mm, aaaa;
gg = data.getDate();
mm = data.getMonth() + 1;
aaaa = data.getFullYear();
var ritorno;
if (mm==4||mm==6||mm==9||mm==11){
   gg='30';
} else if(mm==2){
        if(bisestile(aaaa))
            gg="29";
        else
            gg="28";
      } else{ 
          gg="31";
    }

if(mm<10){
  if(gg<10)
   ritorno="0"+gg+"/0"+mm+"/"+aaaa;
  else 
    ritorno=gg+"/0"+mm+"/"+aaaa;
} else{
  if(gg<10)
   ritorno="0"+gg+"/"+mm+"/"+aaaa;
  else
    ritorno=gg+"/"+mm+"/"+aaaa;
}
return ritorno;
}


function bisestile (year) {

  if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
  {
    return true
  }
  else
  {
    return false
  }
}

function inizializza(){
orologio.style.visibility='hidden';
orologio.style.display='none';


document.formPag.comboAnni.style.visibility='hidden';
document.formPag.comboAnni.style.display='none';
document.formPag.comboMesePartenza.style.visibility='hidden';
document.formPag.comboMesePartenza.style.display='none';
document.formPag.comboMeseArrivo.style.visibility='hidden';
document.formPag.comboMeseArrivo.style.display='none';

document.formPag.comboDisponibiliServizi.style.visibility='hidden';
document.formPag.comboDisponibiliServizi.style.display='none';
document.formPag.comboAccorpatiServizi.style.visibility='hidden';
document.formPag.comboAccorpatiServizi.style.display='none';

document.formPag.comboDisponibili.style.visibility='hidden';
document.formPag.comboDisponibili.style.display='none';
document.formPag.comboAccorpati.style.visibility='hidden';
document.formPag.comboAccorpati.style.display='none';

caricaCLLIProgchk();

}


/*
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
*/
/*
function caricaCLLI(lettera)
{
document.formPag.comboCLLI.length=0;
 var carica = function(dati){riempiSelect1(dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('lettera='+lettera,'listaCLLI',asyncFunz);
 //caricaCLLIProg();
 
}
*/
function caricaCLLIProgchk(){
document.formPag.comboCLLIProg.length=0;
 var carica = function(dati){riempiSelect('comboCLLIProg',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('ciao=0','listaCLLIProg',asyncFunz);
}

function caricaAnniEstrazione()
{

  ClearCombo(document.formPag.comboDisponibiliServizi);
  ClearCombo(document.formPag.comboDisponibili);

  ClearCombo(document.formPag.comboAccorpatiServizi);
  ClearCombo(document.formPag.comboAccorpati);

    document.formPag.comboAnni.style.visibility='visible';
    document.formPag.comboAnni.style.display='inline';
    document.formPag.comboMesePartenza.style.visibility='hidden';
    document.formPag.comboMesePartenza.style.display='none';
    document.formPag.comboMeseArrivo.style.visibility='hidden';
    document.formPag.comboMeseArrivo.style.display='none';

 var carica = function(dati){riempiSelect('comboAnni',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('ciao=0','listaAnniEstrazione',asyncFunz);


}

function caricaCLLIProg()
{

document.formPag.comboCLLIProg.length=0;
 var carica = function(dati){riempiSelect('comboCLLIProg',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('ciao=0','listaCLLIProg',asyncFunz);

}

function riempiSelectchk(datiV)
{
  riempiSelect('comboCLLIProg',datiV);
  document.formPag.comboCLLIProg.options[0].selected=true; 
}

function riempiSelect1(datiV)
{
  riempiSelect('comboCLLI',datiV);
  caricaCLLIProg();
}




function DisabilitaComboAccount()
{
  if(document.formPag.chkAccount.checked)
  {
    document.formPag.comboAccount.style.visibility='hidden';
    document.formPag.comboAccount.style.display='none';
    
  }
 else 
 {  caricaAccount();
    document.formPag.comboAccount.style.visibility='visible';
    document.formPag.comboAccount.style.display='inline';
 
 }
}


function DisabilitaComboCLLI()
{
  if(document.formPag.chkCLLI.checked)
  {
    document.formPag.comboCLLI.style.visibility='hidden';
    document.formPag.comboCLLI.style.display='none';
  }
 else 
 {
    document.formPag.comboCLLI.style.visibility='visible';
    document.formPag.comboCLLI.style.display='inline';
 
 }
}

function AbilitaComboCLLIProg()
{
 /* if(document.formPag.chkCLLIProg.checked)
  {
    //document.formPag.comboCLLIProg.style.visibility='hidden';
    //document.formPag.comboCLLIProg.style.display='none';
    //document.formPag.comboCLLIProg.disabled=false;
    document.formPag.comboCLLI.style.visibility='visible';
    document.formPag.comboCLLI.style.display='inline';
    document.formPag.chkCLLI.disabled=false;
    document.formPag.chkCLLI.checked=false;
    caricaCLLI("A");
    //document.formPag.lettere.disable=false;
  }
 else 
 {
    document.formPag.comboCLLIProg.style.visibility='visible';
    document.formPag.comboCLLIProg.style.display='inline';
    caricaCLLIProg();
    document.formPag.comboCLLI.style.visibility='hidden';
    document.formPag.comboCLLI.style.display='none';
    document.formPag.chkCLLI.checked=true;
    document.formPag.chkCLLI.disabled=true;
    //document.formPag.lettere.disable=true;
    
 }*/
}

function DisabilitaComboContratti()
{
  if(document.formPag.chkContratti.checked)
  {
    document.formPag.comboAccount.style.visibility='hidden';
    document.formPag.comboAccount.style.display='none';
    document.formPag.chkAccount.checked=true;
    document.formPag.chkAccount.disabled=true;
    document.formPag.comboTipoContr.style.visibility='hidden';
    document.formPag.comboTipoContr.style.display='none';
  }
 else 
 {  
    document.formPag.comboAccount.style.visibility='visible';
    document.formPag.comboAccount.style.display='inline';
    document.formPag.chkAccount.checked=false;
    document.formPag.chkAccount.disabled=false;
    document.formPag.comboTipoContr.style.visibility='visible';
    document.formPag.comboTipoContr.style.display='inline';
    caricaAccount();
    

 }
}

function ChkCLLIProg(){
//document.formPag.chkCLLIProg.checked=false;
document.formPag.comboCLLI.style.visibility='hidden';
document.formPag.comboCLLI.style.display='none';
document.formPag.chkCLLI.checked=true;
document.formPag.chkCLLI.disabled=true;
}

function caricaListaContrattiInAmbito(dataIn)
{
  var tokens = dataIn.split("/");
  var anno = tokens[2];
  var mese = tokens[1];
  var giorno = tokens[0];

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
<body onload=inizializza();>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Ricavi per Area di Centrale</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
       <table width="90%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                  <tr HEIGHT='35px'>
                    <td class="textB" width="10%">Progetto</td>
                    <td width="80%"><select name="comboCLLIProg" class="text" size="2" style="width: 100%;" onchange="caricaAnniEstrazione();"></selct></td>
                  </tr>
                  
                  <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Fatturazione</td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                    <tr HEIGHT='35px'>
                    <td class="textB" width="20%">Anno Estrazione</td>
                    <td width="80%"><select name="comboAnni" width="10px" class="text" onchange="caricaTipoContr()">
                                                                                                              
                    </selct></td>
                  </tr>
                  <tr HEIGHT='35px'>
                    <td class="textB" width="20%">Mese Inizio</td>
                    <td width="80%">
                    <select name="comboMesePartenza" width="10px" class="text">
                                      <option value="01" selected=true>Gennaio</option>
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
                    </selct></td>
                  </tr>
                <tr HEIGHT='35px'>
                    <td class="textB" width="20%">Mese fine</td>
                    <td width="80%">
                    <select name="comboMeseArrivo" width="10px" class="text">
                                      <option value="01" selected=true>Gennaio</option>
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
                    </selct></td>
                  </tr>
                   <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Servizi</td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
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
                          <Select name="comboDisponibiliServizi" title="Tipo Contratto Disponibili" id="comboDisponibiliServizi" size="10" class="textList" ondblclick="addOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">                     
                          </select>
                        </Td>
                        <Td align="center" width="2%" valign="middle">
                          <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">                        
                          <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">
                          <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpatiServizi,formPag.comboDisponibiliServizi)">
                          <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboAccorpatiServizi,formPag.comboDisponibiliServizi)">
                        </Td>
                        <Td class="text" widht="25%">
                          <Select name="comboAccorpatiServizi" multiple title="Servizi Disponibili" id="comboAccorpatiServizi" size="10" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpatiServizi,frmDati.comboDisponibiliServizi)">
                          </select>
                        </Td>
                      </Tr>

                    </Table>
                  </td>
                </tr>
                 <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro CLLI</td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                <tr>
                    <td class="textB">Tutti i CLLI del progetto selezionato</td>
                    <td class="textB">
                      <input type='checkbox' name='chkCLLI' value='<%=strCheckCess%>' onclick="caricaCLLIdaProg();" checked="checked" >
                    </td>
                </tr>
                  <tr>
                  <td colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <td class="text" align="center" width="49%">Elenco CLLI disponibili</td>
                        <td class="text" widht="2%">&nbsp;</td>
                        <td class="text" align="center" widht="49%">Elenco CLLI da lanciare(max 100)</td>
                      </Tr>
                      
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                        <Td  class="text"  widht="25%">
                          <Select name="comboDisponibili" title="Account Disponibili" id="comboDisponibili" size="10" class="textList" ondblclick="addOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">                     
                          </select>
                        </Td>
                        <Td align="center" width="2%" valign="middle">
                          <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">                        
                          <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">
                          <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpati,formPag.comboDisponibili)">
                          <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboAccorpati,formPag.comboDisponibili)">
                        </Td>
                        <Td class="text" widht="25%">
                          <Select name="comboAccorpati" multiple title="Account Disponibili" id="comboAccorpati" size="10" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpati,frmDati.comboDisponibili)">
                          </select>
                        </Td>
                      </Tr>

                    </Table>
                  </td>
                </tr>
                <!-- R1I-13-0066 Digital Divide -->
                <tr>
                  <td class="textB">Escludere risorse di tipo simmetrico</td>
                    <td class="textB">
                      <input type='checkbox' name='chkAsimm' value='<%=strCheckAsimm%>'  onclick="checkAsimmetrici();">
                    </td>
                </tr>    
		 	</table>
</table><br>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
<tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <sec:ShowButtons VectorName="vectorButton" />
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
