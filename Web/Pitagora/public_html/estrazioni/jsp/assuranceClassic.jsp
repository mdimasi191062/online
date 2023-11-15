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
<%=StaticMessages.getMessage(3006,"assuranceClassic.jsp")%>
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

  if(!document.formPag.chkGestore.checked){
    gestore='null';
    
          if(cboSourceServizi.length==0) {
                if(lancio!=1)
                  alert("Selezionare almeno un servizio!");
                lancio=1;
              } else { 
                  while (cboSourceServizi.length > j) {
                        if(j==0) {
                          listaServizi=getComboValueByIndex(cboSourceServizi,j);
                        } else {
                          listaServizi=listaServizi+'#'+getComboValueByIndex(cboSourceServizi,j);
                        }
                        j++;
                    }
              }    
    
    
  } else {
    listaServizi='null';
    indice1= document.formPag.comboGestore.selectedIndex;
    if(indice1<0)
      alert("Selezionare un Gestore");
    var gestore=document.formPag.comboGestore.options[indice1].value; 
  }

  /*alf   var checkAttive = '1';
  var checkCessate = '1';
  if(!document.formPag.chkAttive.checked && !document.formPag.chkCessate.checked) {
       alert("Selezionare almeno una Consistenza!");
       lancio=1;
  } else {
       if(!document.formPag.chkAttive.checked)
            checkAttive = '0';
       if(!document.formPag.chkCessate.checked)
            checkCessate = '0';
  }*/
  
  var checkAttive = '1';
  var checkCessate = '1';
  var checkHD = '1';
  var checkAnagrafica = '1';  
  if(!document.formPag.chkAttive.checked && !document.formPag.chkCessate.checked && !document.formPag.chkHD.checked && !document.formPag.chkAnagrafica.checked) {
       alert("Selezionare almeno una Consistenza!");
       lancio=1;
  } else {
       if(!document.formPag.chkAttive.checked)
            checkAttive = '0';
       if(!document.formPag.chkCessate.checked)
            checkCessate = '0';
       if(!document.formPag.chkHD.checked)
            checkAttive = '0';
       if(!document.formPag.chkAnagrafica.checked)
            checkCessate = '0';
  }    

  if(lancio==0)
  {
    var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};
    //alfvar sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=15&codeTipoContr='+listaServizi+'&codeGestore='+gestore+'&dataCongelamento='+dataCongelamento+'&checkAttive='+checkAttive+'&checkCessate='+checkCessate; 
    var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=15&codeTipoContr='+listaServizi+'&codeGestore='+gestore+'&dataCongelamento='+dataCongelamento+'&checkAttive='+checkAttive+'&checkCessate='+checkCessate+'&checkHD='+checkHD+'&checkAnagrafica='+checkAnagrafica; 
  //var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=3&codeTipoContr='+tipoContr+'&codeAccount='+account+'&dataInizioFatrz='+dataInizioCicloFatturazione+'&seq='+sequence;
    //alert("lancioBatchAssuranceClassic: " + sendMessage);
    chiamaRichiesta(sendMessage,'lancioBatchRepricing',asyncFunz);
  } 
}

function caricaTipoContr() {
    ClearCombo(document.formPag.comboDisponibiliServizi);
    ClearCombo(document.formPag.comboAccorpatiServizi);

    document.formPag.comboDisponibiliServizi.style.visibility='visible';
    document.formPag.comboDisponibiliServizi.style.display='inline';
    document.formPag.comboAccorpatiServizi.style.visibility='visible';
    document.formPag.comboAccorpatiServizi.style.display='inline';

    document.formPag.chkGestore.checked=false;
    document.formPag.comboGestore.style.visibility='hidden';
    document.formPag.comboGestore.style.display='none';  
  
   var carica = function(dati){riempiSelectServizi('comboDisponibiliServizi','txtDataCongelamento', 'codeDataCongelamento', dati); dataCongelamento();};
   var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
   var asyncFunz=  function(){ handler_generico(http,carica,errore);};
   chiamaRichiesta('','listaTipiServiziAssurance',asyncFunz);    
   
}

   function dataCongelamento() {     
           if(document.formPag.codeDataCongelamento.value == '0')  {
                 document.formPag.chkGestore.disabled=true;
                 document.formPag.comboAccorpatiServizi.disabled=true;
                 document.formPag.comboDisponibiliServizi.disabled=true;
                 document.formPag.chkAttive.disabled=true;
                 document.formPag.chkCessate.disabled=true;   
                 document.formPag.chkHD.disabled=true;
                 document.formPag.chkAnagrafica.disabled=true;  
                 document.formPag.Button1.disabled=true;
                 document.formPag.Button2.disabled=true;
                 document.formPag.Button3.disabled=true;
                 document.formPag.Button4.disabled=true;
                 document.formPag.ESEGUI.disabled=true;
         }
   }

function caricaGestore() {
   document.formPag.comboGestore.length=0;
      document.formPag.comboGestore.style.visibility='visible';
      document.formPag.comboGestore.style.display='inline';
      document.formPag.chkGestore.checked=true;   
   var carica = function(dati){riempiSelect('comboGestore',dati);};
   var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
   var asyncFunz=  function(){ handler_generico(http,carica,errore);};
      chiamaRichiesta('','listaTipiGestoreAssurance',asyncFunz);
}

function DisabilitaComboGestore() {
  if(document.formPag.chkGestore.checked)
  {
    document.formPag.comboDisponibiliServizi.style.visibility='hidden';
    document.formPag.comboDisponibiliServizi.style.display='none';
    document.formPag.comboAccorpatiServizi.style.visibility='hidden';
    document.formPag.comboAccorpatiServizi.style.display='none';
    
    document.formPag.comboGestore.style.visibility='visible';
    document.formPag.comboGestore.style.display='inline'; 
    caricaGestore();  
  }
 else 
 {
    caricaTipoContr();
    document.formPag.comboGestore.style.visibility='hidden';
    document.formPag.comboGestore.style.display='none';  
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Assurance Classic</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <table width="85%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
          <td class="textB" width="10%" align="center"></td>
          <td width="90%"> 
                <div class="textB" name="txtDataCongelamento" id="txtDataCongelamento" align='left' style="visibility:display;display:inline;margin-top: 6px;" align="left"> 
                </div> 
                <INPUT type="Hidden" name="codeDataCongelamento" value="0">
          </td>
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
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Gestore</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%" align="right">Gestore &nbsp;&nbsp;&nbsp;
             <input type='checkbox' name='chkGestore' value='<%=strCheckCess%>' onclick="DisabilitaComboGestore();">&nbsp;&nbsp;&nbsp;
          </td>
          <td class=="text" width="80%"><select name="comboGestore" class="text" size="7" style="width: 70%;"></selct></td>
          <td class="textB"></td>
          <td class="textB">
          </td>
        </tr>
       <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Consistenza</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr>
          <td class="textB" width="20%">Attive
             <input type='checkbox' name='chkAttive' value='' checked ="checked">
          </td>
          <td class="textB" width="20%">Cessate
             <input type='checkbox' name='chkCessate' value='' checked ="checked">
          </td>          
        </tr>
       <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Anagrafica</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>        
        <tr>
          <td class="textB" width="20%">HD_ripr
             <input type='checkbox' name='chkHD' value='' checked ="checked">
          </td>
          <td class="textB" width="20%">Anagrafica
             <input type='checkbox' name='chkAnagrafica' value='' checked ="checked">
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

