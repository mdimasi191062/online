<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
<%=StaticMessages.getMessage(3006,"integritySpec.jsp")%>
</logtag:logData>
<%
String strCheckCess ="";
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

function ONESEGUI(){
  var j=0; 
  var listaServizi="";
  var dataCongelamento=document.formPag.codeDataCongelamento.value;

  var lancio=0;
  selectAllComboElements(formPag.comboAccorpatiServizi);
  cboSourceServizi=formPag.comboAccorpatiServizi;

  var checkAntePost = '1';
  var checkCessate = '1';
  var checkHD = '1';
  var checkAnagrafica = '1';  
  var checkRegXDSL = '1';  

    for(var i=0;i<document.formPag.optRegXDSL.length;i++){
      if(document.formPag.optRegXDSL[i].checked){
        checkRegXDSL = document.formPag.optRegXDSL[i].value;
        break;
      }
    }
    
    for(var i=0;i<document.formPag.optAntePost.length;i++){
      if(document.formPag.optAntePost[i].checked){
        checkAntePost = document.formPag.optAntePost[i].value;
        break;
      }
    }

  if(lancio==0)
  {
    var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=11&checkAntePost='+checkAntePost+'&checkRegXDSL='+checkRegXDSL; 
    chiamaRichiesta(sendMessage,'lancioBatchRepricing',asyncFunz);
  } 
}

function caricaTipoContr() {
    ClearCombo(document.formPag.comboDisponibiliServizi);
    ClearCombo(document.formPag.comboAccorpatiServizi);

    /*document.formPag.comboDisponibiliServizi.style.visibility='visible';
    document.formPag.comboDisponibiliServizi.style.display='inline';
    document.formPag.comboAccorpatiServizi.style.visibility='visible';
    document.formPag.comboAccorpatiServizi.style.display='inline';
*/
  
   var carica = function(dati){riempiSelectServizi('comboDisponibiliServizi','txtDataCongelamento', 'codeDataCongelamento', dati); dataCongelamento();};
   var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
   var asyncFunz=  function(){ handler_generico(http,carica,errore);};
   chiamaRichiesta('','listaTipiServiziAssurance',asyncFunz);    
}

   function dataCongelamento() {     
           if(document.formPag.codeDataCongelamento.value == '0')  {
                 document.formPag.comboAccorpatiServizi.disabled=true;
                 document.formPag.comboDisponibiliServizi.disabled=true;
                 document.formPag.chkAntePost.disabled=true;
                 document.formPag.chkRegXDSL.disabled=true;
                 document.formPag.Button1.disabled=true;
                 document.formPag.Button2.disabled=true;
                 document.formPag.Button3.disabled=true;
                 document.formPag.Button4.disabled=true;
                 document.formPag.ESEGUI.disabled=true;
         }
   }


function gestisciMessaggio(messaggio) {
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';  
}

//NEW MAX
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
	}
  	
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Revenue Integrity Special</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <table width="85%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr></tr>
        <tr HEIGHT='35px'style="visibility:hidden;display:none">
          <td class="textB" width="10%" align="center"></td>
          <td width="90%"> 
                <div class="textB" name="txtDataCongelamento" id="txtDataCongelamento" align='left' style="visibility:display;display:inline;margin-top: 6px;" align="left"> 
                </div> 
                <INPUT type="Hidden" name="codeDataCongelamento" value="0">
          </td>
        </tr>  
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro XDSL / Regolatorio</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr>
          <TD class="text" nowrap align="left" colspan="4">
              <INPUT  type="radio" name="optRegXDSL" value="1" checked >XDSL             
            </TD>
        </tr>
        <tr>
            <TD class="text" nowrap align="left" colspan="4">
              <INPUT  type="radio" name="optRegXDSL" value="0"  >Regolatorio
            </TD>
        </tr>
       <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Ante / Post congelamento</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr>
          <TD class="text" nowrap align="left" colspan="4">
              <INPUT  type="radio" name="optAntePost" value="1" checked >Ante             
            </TD>
        </tr>
        <tr>
            <TD class="text" nowrap align="left" colspan="4">
              <INPUT  type="radio" name="optAntePost" value="0"  >Post
            </TD>
        </tr>
       
                          <tr  style="visibility:hidden;display:none">
                  <td colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <td class="text" align="center" widht="49%">Elenco Servizi disponibili</td>
                        <td class="text" widht="2%">&nbsp;</td>
                        <td class="text" align="center" widht="49%">Elenco Servizi da lanciare</td>
                      </Tr>
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>" style="visibility:hidden;display:none">
                        <Td  class="text"  widht="25%">
                          <Select name="comboDisponibiliServizi" title="Tipo Contratto Disponibili" id="comboDisponibiliServizi" size="10" class="textList" ondblclick="addOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)" visible="false">                     
                          </select>
                        </Td>
                        <Td align="center" width="2%" valign="middle">
                          <INPUT  type="button" name=Button1 value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">                        
                          <INPUT  type="button" name=Button2 value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibiliServizi,formPag.comboAccorpatiServizi)">
                          <INPUT  type="button" name=Button3 value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpatiServizi,formPag.comboDisponibiliServizi)">
                          <INPUT  type="button" name=Button4 value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboAccorpatiServizi,formPag.comboDisponibiliServizi)">
                        </Td>
                        <Td class="text" widht="25%">
                          <Select name="comboAccorpatiServizi" multiple title="Servizi Disponibili" id="comboAccorpatiServizi" size="10" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpatiServizi,frmDati.comboDisponibiliServizi)">
                          </select>
                        </Td>
                      </Tr>

                    </Table>
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

