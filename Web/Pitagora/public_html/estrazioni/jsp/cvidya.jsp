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
String strDataInizioCicloFatturazione="";
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

function ONESEGUI(){
  indice= document.formPag.comboTipoContr.selectedIndex;
  var tipoContr=document.formPag.comboTipoContr.options[indice].value;
  var sequence='null';
  var lancio=0;
  
  if(document.formPag.chkAccount.checked){
    account='null';
  }else{
    indice1= document.formPag.comboAccount.selectedIndex;
    if(indice1<0)
      alert("Selezionare un Account");
    var account=document.formPag.comboAccount.options[indice1].value; 
  }

  var dataInizioCicloFatturazione=document.formPag.txtDataInizioCicloFatturazione.value;
 
  
  
  if(document.formPag.chkUltimaEstrazione.checked)
  {
    if(document.formPag.comboTipoContr.selectedIndex==0)
    {
      alert("Selezionare un servizio");
      lancio=1;
    } else
    {
      sequence='ultimo';
      dataInizioCicloFatturazione='null';
    }
  }
  else if(dataInizioCicloFatturazione=="")
  {
    alert("Inserire la DATA INIZIO CICLO FATTURAZIONE!!");
    lancio=1;
  }
  
  if(lancio==0)
  {
    var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=3&codeTipoContr='+tipoContr+'&codeAccount='+account+'&dataInizioFatrz='+dataInizioCicloFatturazione+'&seq='+sequence;
    chiamaRichiesta(sendMessage,'lancioBatchRepricing',asyncFunz);
  }
    
}


function caricaTipoContr()
{
 document.formPag.comboAccount.disabled=true;
 document.formPag.comboAccount.style.visibility='hidden';
 document.formPag.comboAccount.style.display='none';
 document.formPag.chkAccount.checked=true;
 document.formPag.chkAccount.disabled=true;
 var carica = function(dati){riempiSelect('comboTipoContr',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('','listaTipiContrCVIDYA',asyncFunz);

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
 if(document.formPag.chkUltimaEstrazione.checked)
 {
    valore='null';
 }
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

function DisabilitaComboAccountUltimo()
{
  indice= document.formPag.comboTipoContr.selectedIndex;
  
  if(document.formPag.chkUltimaEstrazione.checked)
  {
    document.formPag.chkAccount.checked=true;
    document.formPag.chkAccount.disabled=true;
    document.formPag.comboAccount.style.visibility='hidden';
    document.formPag.comboAccount.style.display='none';
    document.formPag.txtDataInizioCicloFatturazione.value="";
    document.formPag.txtDataInizioCicloFatturazione.style.visibility='hidden';
    document.formPag.txtDataInizioCicloFatturazione.style.display='none';
    
  }
  else
  {
    document.formPag.chkAccount.checked=true;
    document.formPag.comboAccount.style.visibility='hidden';
    document.formPag.comboAccount.style.display='none';
    document.formPag.chkAccount.disabled=false;
    document.formPag.txtDataInizioCicloFatturazione.style.visibility='visible';
    document.formPag.txtDataInizioCicloFatturazione.style.display='inline';
     if(indice!=0)
     {
        caricaAccount();
     }
  }
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
<body onload="caricaTipoContr()">
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
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.GIF" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Consistenze per C-VIDYA</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <table width="85%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Tipo Contratto</td>
          <td width="80%"><select name="comboTipoContr" width="10px" class="text" onchange="caricaAccount()"></selct></td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Account</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Account</td>
          <td class=="text" width="80%"><select name="comboAccount" class="text" size="7" style="width: 100%;"></selct></td>
          <td class="textB">Tutti</td>
          <td class="textB">
            <input type='checkbox' name='chkAccount' value='<%=strCheckCess%>' onclick="DisabilitaComboAccount();">
          </td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Data Inizio Ciclo Fatturazione</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="30%">Data Inizio Ciclo Fatturazione</td>
          <td class="text">
            <input type='text' name='txtDataInizioCicloFatturazione' value='<%=strDataInizioCicloFatturazione%>' class="text" readonly="">
            <a href="javascript:showCalendar('formPag.txtDataInizioCicloFatturazione','');" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
            <a href="javascript:clearField(formPag.txtDataInizioCicloFatturazione);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
          </td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="60%">Rilancia ultima estrazione Jazzware</td>
          <td class="text">
            <input type='checkbox' name='chkUltimaEstrazione' value='<%=strCheckCess%>' onclick="DisabilitaComboAccountUltimo();">
          </td>
        </tr>
		 	</table>
</table>
<br>
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

