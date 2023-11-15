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
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*, com.service.*, com.model.*" %>
<%
String path                       = "";
String nomeFile                   = "";

IavService iavService = new IavService();
ReportService reportService = new ReportService();

Vector<IavModel> listaServices = iavService.getAllServiceIav();

Vector<PeriodModel> listPeriods = null;
Vector<AccountModel> accounts = null;
Vector<ValorPathModel> resultList = null;
ValorPathModel infoPath = null;

String servizio = null;
String descServizio = null;
String CodeFunz = null;
String period = null;
String accoundCode = null;
String descAccount = null;
String tipoReport = null;
String tipoDettaglio = null;

if(request.getParameter("servizio") != null){
    servizio = request.getParameter("servizio");
}

if(request.getParameter("descservizio") != null){
    descServizio = request.getParameter("descservizio");
}

if(request.getParameter("CodeFunz") != null) {
    CodeFunz = request.getParameter("CodeFunz");
}

if(request.getParameter("period") != null) {
    period = request.getParameter("period");
}

if(request.getParameter("accoundCode") != null) {
    accoundCode = request.getParameter("accoundCode");
}

if(request.getParameter("descaccount") != null) {
    descAccount = request.getParameter("descaccount");
}

if(request.getParameter("TipoReport") != null) {
    tipoReport = request.getParameter("TipoReport");
}

if(request.getParameter("TipoDettaglio") != null) {
    tipoDettaglio = request.getParameter("TipoDettaglio");
}

if(CodeFunz != null){
    infoPath = reportService.getInfoFromType(CodeFunz);
}else{
    infoPath = null;
    CodeFunz = null;
}

if(servizio != null && !"".equals(servizio)){
     accounts = iavService.getAllAccount(servizio);
     listPeriods = iavService.getAllPeriod();
     //ES: (String typeFiles,String codeServizio, String codeFunzione, String codeAccount, String codePeriodo)
     resultList = reportService.getResulListPathFiles(servizio, descServizio, CodeFunz, descAccount, period, tipoDettaglio, tipoReport);
}else {
    accounts = null;
    listPeriods = null;
}

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
        <script src="../js/jquery.min.js" type="text/javascript"></script>
          <script src="../js/download.js" type="text/javascript"></script>
         <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
 <script>
  
  var servizio = '<%=servizio%>';
  
  //alert(servizio);
    function inizializza(){
      orologio.style.visibility='hidden';
      orologio.style.display='none'  
    }

 function reloadPage(){
      orologio.style.visibility='visible';
      orologio.style.display='inline'  
  
      maschera.style.visibility='hidden';
      maschera.style.display='none' 
      
     changeDescServizio();
     changeDescAccount();
     document.formPag.submit();
 }
 
function changeDescServizio() {
    if (document.formPag.servizio.selectedIndex > 0) {
        var val = document.formPag.servizio.options[document.formPag.servizio.selectedIndex].text
        document.formPag.descservizio.value=val.substring(0,3).replace("Pro","Prov") + "_"+ val.replace("Assurance ","").replace("Provisioning ","").replace(" ","_");
    } else {
        document.formPag.descservizio.value="";
    }
}

function changeDescAccount() {
    if ( document.formPag.accoundCode.selectedIndex > 0 ) {
        var val = document.formPag.accoundCode.options[document.formPag.accoundCode.selectedIndex].text
        document.formPag.descaccount.value=val.substring(0,3);
    } else {
        document.formPag.descaccount.value="";
    }
}
 
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

function onDownload(){
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
  document.formPag.action="";
  document.formPag.method="GET";
}

function onReset(){
  ONRESET();
}

</script>       
        
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
</head>
<body onload="inizializza();">

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
</div>
<div name="orologio" id="orologio" >
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>
<div name="maschera" id="maschera" style="visibility:display;display:inline">
<form name="formPag" method="GET" action="ReportListaFileIav.jsp">

<% if(infoPath!=null) { %>

<input type="hidden" name="pathReportHidden" value="<%= infoPath.getPathStorico()%>" />
<input type="hidden" name="nomeFileCompressoHidden" value="<%= infoPath.getNameFile()%>" />
<input type="hidden" name="pathReportHidden" value="<%= infoPath.getPathStorico()%>" />
<input type="hidden" name="pathFileZipHidden" value="<%= infoPath.getPathZip()%>" />
<% } %>

<input type="hidden" id="descservizio" name="descservizio" value="<%=descServizio%>" />
<input type="hidden" id="descaccount" name="descaccount" value="<%=descAccount%>" />

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
      <table width="85%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        
        <!-- code_funz -->
        <tr>
          <td class="textB" width="5%" align="left" nowrap>Funzionalità</td>
          <td width="20%" align="left" nowrap>
          <select name="CodeFunz" class="text" onchange="reloadPage();">
          <option value="">Selezionare Funzionalità</option> 
          <option value="V" <%=("V".equals(CodeFunz)?"selected":"")%> >Report Valorizzazione IAV</option>
          <option value="R" <%=("R".equals(CodeFunz)?"selected":"")%> >Report Repricing</option>
          </select></td>
          <td class="textB" width="5%" align="left" nowrap>Periodo</td>
          <td width="20%" align="left" nowrap>
          <%
            String disPeriod="";
            if(servizio != null && listPeriods != null){ 
                disPeriod = "";
            } else { 
                disPeriod = "disabled";
            } %>
          <select name="period" class="text" <%=disPeriod%> onchange="reloadPage();">
           <option value="">Seleziona Periodo</option>
             <%  
             if(listPeriods != null) {
             
                for(int i=0;i < listPeriods.size();i++) {
                PeriodModel periodModel = new PeriodModel();
                periodModel=(PeriodModel)listPeriods.elementAt(i);

              String locPeriod = periodModel.getDescr().substring(0,3)+periodModel.getDescr().substring(periodModel.getDescr().length() - 4);
              if (locPeriod.equals(period)){ %>
               <option value="<%=periodModel.getDescr().substring(0,3)+periodModel.getDescr().substring(periodModel.getDescr().length() - 4) %>" selected><%=periodModel.getDescr()%></option>
            <% } else { %>
               <option value="<%=periodModel.getDescr().substring(0,3)+periodModel.getDescr().substring(periodModel.getDescr().length() - 4) %>"><%=periodModel.getDescr()%></option>
            <% } 
              }
            } %>
          </select></td>
        </tr>

        <!-- tipo_batch -->
        
        <!-- query_servizi -->
        <tr>
          <td class="textB" width="5%" align="left" nowrap>Servizi</td>
          <td width="20%" align="left" nowrap>
          <select onchange="reloadPage();" name="servizio" class="text">
          <option value="">Seleziona Servizio</option>
     <%  for(int i=0;i < listaServices.size();i++) {
     
        IavModel iavModel = new IavModel();
        iavModel=(IavModel)listaServices.elementAt(i);
                   
         String selectedServizio = "";       
         
        if (iavModel.getCodeTipoContr().equals(servizio)){
            selectedServizio = "selected";
         } else {
            selectedServizio = "";
         } 
        %>
            <option value="<%=iavModel.getCodeTipoContr()%>" <%=selectedServizio%> ><%=iavModel.getDescrTipoContr()%></option>
        <% } %>
        
          </select></td>
          <td class="textB" width="5%" align="left" nowrap>Account</td>
          <td width="20%" align="left" nowrap>
            <% 
                String disableCodeAccount ="";
                if(servizio != null && accounts != null && accounts.size() > 0) {
                    disableCodeAccount="";
                } else {
                    disableCodeAccount="disabled";
                } %>
            <select onchange="reloadPage()" name="accoundCode" class="text" <%=disableCodeAccount%> >
                <option value="">Seleziona Account</option>
                
            <%  
            if(accounts != null){
            String selectedAccount ="";
            for(int i=0;i < accounts.size();i++) {
                    AccountModel accountModel = new AccountModel();
                    accountModel=(AccountModel)accounts.elementAt(i);
                    if ( accountModel.getCodeAccount().equals(accoundCode)) {
                        selectedAccount = "selected";
                    } else {
                        selectedAccount = "";
                    }
             %>
                <option value="<%=accountModel.getCodeAccount()%>" <%=selectedAccount%> ><%=accountModel.getDescAccount()%></option>
            <% }
            } %>
          </select></td>
        </tr>
        
        <tr>
          <td class="textB" width="5%" align="left" nowrap>Tipo Report</td>
          <td width="20%" align="left" nowrap>
          <%
            String disableTipoReport="";
            if(servizio != null) {
                disableTipoReport="";
            } else { 
                disableTipoReport="disabled";
            } %>
            <select name="TipoReport" class="text" <%=disableTipoReport%> onchange="reloadPage();">
              <option value="">Selezionare Tipo Report</option>
              <option value="F" <%=("F".equals(tipoReport)?"selected":"")%> >Allegati Fattura</option>
              <option value="N" <%=("N".equals(tipoReport)?"selected":"")%> >Allegati Nota di Credito</option> 
            </select>
          </td>
            <td class="textB" width="5%" align="left" nowrap>Tipo Dettaglio</td>
          <td width="20%" align="left" nowrap>
           <% 
            String disableTipoDett = "";
            if(servizio != null) {
                disableTipoDett="";
             } else { 
                disableTipoDett="disabled";
             } %>
            <select name="TipoDettaglio" class="text" <%=disableTipoDett%> onchange="reloadPage();">
              <option value="">Selezionate Tipo Documento</option>
              <option value="Dett" <%=("Dett".equals(tipoDettaglio)?"selected":"")%> >Dettaglio</option>
              <option value="Sint" <%=("Sint".equals(tipoDettaglio)?"selected":"")%> >Sintesi</option> 
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
                  <Select name="comboDisponibili" multiple title="File Disponibili" id="comboDisponibili" size="20" class="textList">
                        <%  
                            if(resultList != null){
                            for(int i=0;i < resultList.size();i++) {
                                    ValorPathModel valorModel = new ValorPathModel();
                                    valorModel=(ValorPathModel)resultList.elementAt(i);
                             %>
                                    
                            <option value="<%=valorModel.getNameFile()%>"><%=valorModel.getNameFile()%></option>
                                    
                            <% } } %>
                  </select>
                </Td>
                <Td align="center" width="30" valign="middle">
                  <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboDisponibili,formPag.comboDaScaricare)">
                  <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToCombo(formPag.comboDisponibili,formPag.comboDaScaricare)">                  
                  <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToCombo(formPag.comboDaScaricare,formPag.comboDisponibili)">
                  <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboDaScaricare,formPag.comboDisponibili)">
                </Td>
                <Td class="text" widht="40%">
                  <Select name="comboDaScaricare" multiple title="File da Scaricare" id="comboDaScaricare" size="20" class="textList">
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
        <input type="button" onclick="onDownload()" value="DOWNLOAD" />
    </td>
  </tr>
</table>

</form>
</div>
</body>
</html>