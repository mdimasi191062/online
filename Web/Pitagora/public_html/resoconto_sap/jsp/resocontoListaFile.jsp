<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"resocontoListaFile.jsp")%>
</logtag:logData>

<%
String path       = "";
String nomeFile   = "";
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
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE='Javascript' type="text/javascript">

 var objForm = null;
 objForm = document.formPag;

function ONESEGUI(){
  indice= document.formPag.comboNomeFile.selectedIndex;
  if (indice == null || indice < 0)
  {
    alert('Selezionare almeno un file dalla lista');
    return;
  }else{
    var nomeFile=document.formPag.comboNomeFile.options[indice].text;
    document.formPag.nomeFileHidden.value=nomeFile;
    document.formPag.action="./resocontoDownload.jsp";
    document.formPag.method="POST";
    document.formPag.submit();
  }
}

function ElencoFile(codiceFunzione)
{
 document.formPag.comboNomeFile.length=0;
 var carica = function(dati){riempiSelect('comboNomeFile',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('codiceFunzione='+codiceFunzione,'ElencoFileDownload',asyncFunz);
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

<body onload="ElencoFile('DOWNLOAD_SAP')">
<div id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio" action="">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div id="maschera" style="visibility:hidden;display:none">
<form name="formPag" method="post" action="" target="_blank">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../../common/images/body/download.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3" alt=""></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Resoconti SAP</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28" alt=""></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
          <td class="textB" width="20%">Seleziona File</td>
          <td width="80%"><select name="comboNomeFile" class="text" size="12" style="width: 100%;"></select><input type="hidden" id="nomeFileHidden" name="nomeFileHidden"/></td>
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
    </td>
  </tr>
</table>

</div>
<script language="javascript" type="text/javascript">
var http=getHTTPObject();
</script>
</body>
</html>

