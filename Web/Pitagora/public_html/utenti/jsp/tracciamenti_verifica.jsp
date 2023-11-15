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
<%=StaticMessages.getMessage(3006,"tracciamenti_verifica.jsp")%>
</logtag:logData>
<%

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

function LanciaTracciamenti()
{
  //txtRadio0 -> Estrazione per D.lgs 196/03 
  //txtRadio1 -> Estrazione per Del. 152/02/CONS:

  if(!document.formPag.txtRadio0.checked && !document.formPag.txtRadio1.checked){
    alert('Selezionare il tipo di Estrazione da effettuare.');
  }else{
    if(document.formPag.txtRadio1.checked)
      tipo_tracciamento = 'DEL_152_02_CONS';
    else
      tipo_tracciamento = 'DLGS_196_03';

    var carica = function(dati){TipoEstrazione(dati[0].messaggio);};
    var errore = function(dati){TipoEstrazione(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('tipo_tracciamento='+tipo_tracciamento,'LanciaTracciamenti',asyncFunz);
  }
}

function ONESEGUI(){
  indice= document.formPag.comboNomeFile.selectedIndex;
  if (indice == null || indice < 0)
  {
    alert('Selezionare almeno un file dalla lista');
    return;
  }else{
    var nomeFile=document.formPag.comboNomeFile.options[indice].text;
    var pathFile=document.formPag.comboNomeFile.options[indice].value;
    document.formPag.nomeFileHidden.value=nomeFile;
    document.formPag.action="./tracciamenti_download.jsp";
    document.formPag.method="POST";
    document.formPag.submit();
  }
}

function onCaricaTracciamenti(dati)
{
  riempiSelect('TipoEstrazione',dati);
  selectTE=document.formPag.TipoEstrazione;
  for(i=0;i<selectTE.options.length;i++)
  {
      selectTE.options[i].path=dati[i].path;
  }
  ElencoFile();
}

function TipoEstrazione(msg)
{
  /*var carica = function(dati){onCaricaTracciamenti(dati);};*/
  var carica = function(dati){riempiSelect('comboNomeFile',dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('','ElencoFileTracciamenti',asyncFunz);
  if(msg != '' && msg != null){
    gestisciMessaggio(msg);
    document.formPag.txtRadio0.checked = false;
    document.formPag.txtRadio1.checked = false;
  }
}

function ElencoFile()
{
 indice2= document.formPag.TipoEstrazione.selectedIndex;
 var nomeFile=document.formPag.TipoEstrazione.options[indice2].value;
 var path=document.formPag.TipoEstrazione.options[indice2].path;
 document.formPag.comboNomeFile.length=0;
 var carica = function(dati){riempiSelect('comboNomeFile',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('path='+path+'&nomeFile='+nomeFile,'listaFile',asyncFunz);
}

function gestisciMessaggio(messaggio)
{
/*
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';
*/
  alert(messaggio);
}

function setTipoUser(tipoUser){
  if (tipoUser == '0'){
    document.formPag.txtRadio0.checked = true;
    document.formPag.txtRadio1.checked = false;
  }else{
    document.formPag.txtRadio1.checked = true;
    document.formPag.txtRadio0.checked = false;
  }
}

function setTipoUserStart(){
  document.formPag.txtRadio0.checked = true;
  document.formPag.txtRadio1.checked = false;
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

<body onload="TipoEstrazione('')">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tracciamenti</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
<%--
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
        <tr>
          <td>
            <table width="50%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
              <tr>
                <td class="textB" align="right" nowrap>Estrazione per D.lgs 196/03:</td>
                <td  width="10%" class="text" align="left">
                  <input type='radio' name='txtRadio0' value='0' onclick='setTipoUser(this.value);'>
                </td>
                <td class="textB" align="right" nowrap>Estrazione per Del. 152/02/CONS:</td>
                <td  width="10%" class="text" align="left">
                  <input type='radio' name='txtRadio1' value='1' onclick='setTipoUser(this.value);'>
                </td>
              </tr>              
            </table>
          </td>
        </tr>           
		 	</table>
--%>
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
        <tr>
          <td class="textB" width="20%">Seleziona File</td>
          <td width="80%"><select name="comboNomeFile" width="15px" class="text" size="12" style="width: 100%;"></select><input type="hidden" id="nomeFileHidden" name="nomeFileHidden"/></td>
        </tr>              
		 	</table>
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
        <tr>
          <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td>
            <table width="50%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
              <tr>
                <td class="textB" align="right" nowrap>Estrazione per D.lgs 196/03:</td>
                <td  width="10%" class="text" align="left">
                  <input type='radio' name='txtRadio0' value='0' onclick='setTipoUser(this.value);'>
                </td>
                <td class="textB" align="right" nowrap>Estrazione per Del. 152/02/CONS:</td>
                <td  width="10%" class="text" align="left">
                  <input type='radio' name='txtRadio1' value='1' onclick='setTipoUser(this.value);'>
                </td>
              </tr>              
            </table>
          </td>
        </tr>           
		 	</table>
    </td>
  </tr>
</table>
</form>

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <input type="button" class="textB" name="Download" value="Download" onclick="ONESEGUI()">
        &nbsp;&nbsp;&nbsp;
        <input type="button" class="textB" name="Genera" value="Genera" onclick="LanciaTracciamenti()">
    </td>
  </tr>
</table>

</div>
</body>
<script>
var http=getHTTPObject();
//setTipoUserStart();

</script>
</html>

