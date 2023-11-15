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
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ReportListaFileCL.jsp")%>
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
  <script src="../../elab_attive/js/ElabAttive.js" type="text/javascript"></script>
  <script src="../js/Download.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

var objForm = null;
objForm = document.formPag;
 
var codeFunz = '';
var tipoBatch = '';
var queryServizi = '';
var queryPeriodi = '';
var queryAccount = '';
var estensioneFile = '';
var estensioneFileStorici = '';
var pathReport = '';
var pathReportStorici = '';
var pathFileZip = '';
var flagSys = '';

function ONESEGUI(){
  var nomeFile = "";
  var chkDaScaricare= document.formPag.comboDaScaricare.length;
  if (chkDaScaricare > 0){
    if(document.formPag.nomeFileCompresso.value != ''){
      selectAllComboElements(document.formPag.comboDaScaricare);
      nomeFile = Replace(document.formPag.nomeFileCompresso.value,' ','_');
      nomeFile = Replace(nomeFile,'|','_');
      nomeFile = Replace(nomeFile,'.','_');
      document.formPag.nomeFileCompressoHidden.value = nomeFile+'.zip';
      document.formPag.action="./ReportDownload.jsp";
      document.formPag.method="POST";
      document.formPag.submit();
    }else{
      alert('Inserire nome file compresso da generare!');
    }
  }else{
    alert('Nessun file da scaricare!');
  }
}

function ONDOWNLOADFILE(){
  ONRESET();
}
</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
</head>
<body onload="CodeFunzCL()">
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

<input type="hidden" name="codeFunzHidden">
<input type="hidden" name="tipoBatchHidden">
<input type="hidden" name="queryServiziHidden">
<input type="hidden" name="queryPeriodiHidden">
<input type="hidden" name="queryAccountHidden">
<input type="hidden" name="estensioneFileHidden">
<input type="hidden" name="estensioneFileStoriciHidden">
<input type="hidden" name="pathReportHidden">
<input type="hidden" name="pathReportStoriciHidden">
<input type="hidden" name="pathFileZipHidden">
<input type="hidden" name="servizioHidden">
<input type="hidden" name="cicloHidden">
<input type="hidden" name="accountHidden">
<input type="hidden" name="descAccountHidden">
<input type="hidden" name="tipoReportHidden">
<input type="hidden" name="tipoDettaglioHidden">
<input type="hidden" name="flagSysHidden">
<input type="hidden" name="nomeFileCompressoHidden">

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Download Reportistica</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
        
        <!-- code_funz -->
        <tr>
          <td class="textB" width="5%" align="left" nowrap>Funzionalità</td>
          <td width="20%" align="left" nowrap><select name="CodeFunz" class="text" onchange="TipoBatch()"></select></td>
          <td class="textB" width="5%" align="left" nowrap>Periodo</td>
          <td width="20%" align="left" nowrap><select name="Cicli" class="text" onchange="Ciclo()"></select></td>
        </tr>

        <!-- tipo_batch -->
        
        <!-- query_servizi -->
        <tr>
          <td class="textB" width="5%" align="left" nowrap>Servizi</td>
          <td width="20%" align="left" nowrap><select name="Servizi" class="text" onchange="Servizio()"></select></td>
          <td class="textB" width="5%" align="left" nowrap>Account</td>
          <td width="20%" align="left" nowrap><select name="Account" class="text" onchange="AccountSel()"></select></td>
        </tr>
        
        <tr>
          <td class="textB" width="5%" align="left" nowrap>Tipo Report</td>
          <td width="20%" align="left" nowrap>
            <select name="TipoReport" class="text" onchange="selectTipoReportDettaglio()">
              <option value="">Selezionate Tipo Documento</option>
              <option value="F">Fattura</option>
              <option value="N">Nota di Credito</option> 
              <option value="C">Nota di Credito FCI</option> 
            </select>
          </td>
            <td class="textB" width="5%" align="left" nowrap>Tipo Dettaglio</td>
          <td width="20%" align="left" nowrap>
           <select name="TipoDettaglio" class="text" onchange="selectTipoReportDettaglio()">
             <!--  <select name="TipoDettaglio" class="text" > -->
              <option value="">Selezionate Tipo Documento</option>
              <option value="D">Dettaglio</option>
              <option value="S">Sintesi</option> 
              
            </select>
          </td>
        </tr>
        
        <tr>
          <td colspan ="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
      </table>
      
      
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
       
        <%-- ELENCO FILE - INIZIO --%>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
              <Tr>
                <Td class="textB" align="center" widht="40%">File disponibili</Td>
                <td class="text" widht="20%">&nbsp;</td>
                <td class="textB" align="center" widht="40%">File da scaricare</td>
              </Tr>
              <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                <Td  class="text"  widht="40%">
                  <Select name="comboDisponibili" multiple title="File Disponibili" id="comboDisponibili" size="20" class="textList" ondblclick="addOptionToCombo(formPag.comboDisponibili,formPag.comboDaScaricare)">
                  </select>
                </Td>
                <Td align="center" width="30" valign="middle">
                  <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboDisponibili,formPag.comboDaScaricare)">
                  <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToCombo(formPag.comboDisponibili,formPag.comboDaScaricare)">                  
                  <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToCombo(formPag.comboDaScaricare,formPag.comboDisponibili)">
                  <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboDaScaricare,formPag.comboDisponibili)">
                </Td>
                <Td class="text" widht="40%">
                  <Select name="comboDaScaricare" multiple title="File da Scaricare" id="comboDaScaricare" size="20" class="textList" ondblclick="addOptionToCombo(frmDati.comboDaScaricare,frmDati.comboDisponibili)">
                  </select>
                </Td>
              </Tr>
            </Table>
          </td>
        </tr>
        <%-- ELENCO FILE - FINE --%>
		 	</table>
      
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" width="10%">
         
        <tr>
          <td class="textB" align="right" nowrap>Nome File:</td>
          <td class="text" align="left">
            <input type="text" class="text" name="nomeFileCompresso" id="nomeFileCompresso" maxlength="30" size="35" value="">
          </td> 
        </tr>
        <%-- ELENCO FILE - FINE --%>

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

</form>
</div>
</body>
<script>
var http=getHTTPObject();
</script>
</html>