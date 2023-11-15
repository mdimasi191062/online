<%--@ include file="../../common/jsp/gestione_cache.jsp"--%>
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
<%=StaticMessages.getMessage(3006,"download.jsp")%>
</logtag:logData>
<%
String strMinCiclo = "";
String strMaxCiclo = "";
String strMinDataCess = "";
String strMaxDataCess = "";

String path                       = "";
String nomeFile                   = "";
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
<SCRIPT LANGUAGE='Javascript'>

 var objForm = null;
 objForm = document.formPag;
 var datiCsv;
 var headerTabCsv;
 var openPathFile;
 var openNomeFile;
var totrows=-1;
function onVisualizzaDati(dati,headerTab,page,maxPages,tot_rows)
{
//  riempiTabella(divTabella,dati,headerTab);
totrows=tot_rows;
   datiCsv=dati;
   headerTabCsv=headerTab;
  viewVisualizza.style.visibility='visible';
  viewVisualizza.style.display='block';
  allDownloadsDivs.style.visibility='hidden';
  allDownloadsDivs.style.display='none';
  riempiTabellaNoCache(divTabella,dati,headerTab,page,maxPages,'ricaricaTabella');

 
}
function nascondiVisualizzazione()
{
  viewVisualizza.style.visibility='hidden';
  viewVisualizza.style.display='none';
   allDownloadsDivs.style.visibility='visible';
  allDownloadsDivs.style.display='block';
}

function ricaricaTabella(page)
{
  carica = function(dati,headerTab,page,maxPages,tot_rows){onVisualizzaDati(dati,headerTab,page,maxPages,tot_rows)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_dinamicTable(http,carica,errore);};

  chiamaRichiesta('path='+openPathFile+'&nomeFile='+openNomeFile+'&page='+page+'&maxRow=50&totRows='+totrows,'mostraCsv',asyncFunz);
   
}

function visualizzaCsv()
{

 var indice   = document.formPag.comboNomeFile.selectedIndex;
  
  if(indice != -1)
  {  
    var pathFile =document.formPag.comboNomeFile.options[indice].value;
    var nomeFile = '';
    
    for(i=0; i<document.formPag.comboNomeFile.options.length; i++){
      if(document.formPag.comboNomeFile.options[i].selected){
        if(nomeFile == ''){
          nomeFile = document.formPag.comboNomeFile.options[i].text;
        }else{
          nomeFile = nomeFile + '|' + document.formPag.comboNomeFile.options[i].text;
        }
      }
    }
     openPathFile=pathFile;
  openNomeFile=nomeFile;
  totRows=-1;
 ricaricaTabella(1)
  }else{
    alert('Selezionare il file da scaricare!');
  }


  

}
function ONIVIAFILE()
{
  var indice   = document.formPag.comboNomeFile.selectedIndex;
  var nomeFile = '';
  var pathFile = '';

  if(indice != -1)
  {

    pathFile =document.formPag.comboNomeFile.options[indice].value;
    
    for(i=0; i<document.formPag.comboNomeFile.options.length; i++){
      if(document.formPag.comboNomeFile.options[i].selected){
        if(nomeFile == ''){
          nomeFile = document.formPag.comboNomeFile.options[i].text;
        }else{
          nomeFile = nomeFile + '|' + document.formPag.comboNomeFile.options[i].text;
        }
      }
    }
    
    document.formPag.nomeFileHidden.value=nomeFile;    
    
    var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('path='+pathFile+'&nomeFile='+nomeFile,'InvioFileSftp',asyncFunz);
 
  }else{
    alert('Selezionare il file da inviare!');
  }

}

function ONESEGUI(){
  
  var indice   = document.formPag.comboNomeFile.selectedIndex;
  
  if(indice != -1)
  {  
    var pathFile =document.formPag.comboNomeFile.options[indice].value;
    var nomeFile = '';
    
    for(i=0; i<document.formPag.comboNomeFile.options.length; i++){
      if(document.formPag.comboNomeFile.options[i].selected){
        if(nomeFile == ''){
          nomeFile = document.formPag.comboNomeFile.options[i].text;
        }else{
          nomeFile = nomeFile + '|' + document.formPag.comboNomeFile.options[i].text;
        }
      }
    }
    
        
    document.formPag.nomeFileHiddenDownload.value=nomeFile;
    document.formPag.action="./download_file.jsp";
    document.formPag.method="POST";
    document.formPag.submit();
  }else{
    alert('Selezionare il file da scaricare!');
  }
}

function onCaricaSelectTipoEstrazione(dati)
{
  riempiSelect('TipoEstrazione',dati);
  selectTE=document.formPag.TipoEstrazione;
  for(i=0;i<selectTE.options.length;i++)
  {
      
      selectTE.options[i].path=dati[i].path;
      
  }

  ElencoFile();
}

function TipoEstrazione()
{

 var carica = function(dati){onCaricaSelectTipoEstrazione(dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('funzioneCruscotto=20','EstrazioniConf',asyncFunz);

}


function ElencoFile()
{
  indice2= document.formPag.TipoEstrazione.selectedIndex;
  var nomeFile=document.formPag.TipoEstrazione.options[indice2].value;
  
  document.formPag.TipoEstrazioneHidden.value=nomeFile;
  
  var path=document.formPag.TipoEstrazione.options[indice2].path;
  
  document.formPag.comboNomeFile.length=0;
  var carica = function(dati){riempiSelect('comboNomeFile',dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('path='+path+'&nomeFile='+nomeFile,'listaFile',asyncFunz);

  controllaTipoEstrazione();
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



function controllaTipoEstrazione()
{
  if(document.formPag.TipoEstrazione.value == 'EasyIP'){
    /*da togliere con rilascio sherlock*/
    document.formPag.INVIAFILE.disabled = true;
    document.formPag.INVIAFILE.style.visibility='hidden';
    document.formPag.INVIAFILE.style.display='none';
    /*
    document.formPag.INVIAFILE.disabled = false;
    document.formPag.INVIAFILE.style.visibility='visible';
    document.formPag.INVIAFILE.style.display='inline';
    */
  }else{
    document.formPag.INVIAFILE.disabled = true;
    document.formPag.INVIAFILE.style.visibility='hidden';
    document.formPag.INVIAFILE.style.display='none';
  }
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
<body onload="TipoEstrazione()">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:hidden;display:none">
<form name="formPag" method="post" action="" target="_blank">
<div id="allDownloadsDivs" >
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../images/download.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Download Estrazioni</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
       <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
        <tr>
          <td class="textB" width="20%">Export CSV</td>
          <td width="80%"><select name="TipoEstrazione" width="10px" class="text" onchange="ElencoFile()"></select><input type="hidden" id="TipoEstrazioneHidden" name="nomeFileHidden"/></td>
        </tr>
        <tr>
          <td class="textB" width="20%">Seleziona File</td>
          <td width="80%"><select name="comboNomeFile" width="15px" class="text" size="12" style="width: 100%;"></select><input type="hidden" id="nomeFileHidden" name="nomeFileHidden"/>
        <!-- <button class="textB" type="button" id="btnVisualizza" onclick="visualizzaCsv()">Visualizza</button> -->

          <input  type="hidden" id="nomeFileHiddenDownload" name="nomeFileHiddenDownload"/>
      
          </td>
          
        </tr>       
		 	</table>
    </td>
  </tr>
</table>
<br>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <sec:ShowButtons VectorName="vectorButton" />

    </td>
  </tr>
</table>
</div>
 
 
 
 
 
 <table align=center width="90%" border="0" cellspacing="0" cellpadding="0" id="viewVisualizza" style="visibility:hidden;display:none">
  <tr>
    
    <td><img src="../images/download.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><a class="white" href="javascript:nascondiVisualizzazione()"><< Ritorna alla lista dei file</a><center>Visualizzatore Estrazioni</center> </td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
       <table width="100%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
        <tr>
         <td>
                   <div name="divTabella" id="divTabella" >
              </div>
          </td> 
        </tr>
        <tr>
          <td></td>
        </tr>       
		 	</table>
    </td>
  </tr>
</table>
<br>

 
</form>
</div>
</body>
<script>
var http=getHTTPObject();
</script>
</html>

