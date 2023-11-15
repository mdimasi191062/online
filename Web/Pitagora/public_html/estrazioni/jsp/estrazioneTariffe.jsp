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
<!--<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />-->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"estrazioneTariffe.jsp")%>
</logtag:logData>
<%
String strMinCiclo = "";
String strMaxCiclo = "";
String strMinDataCess = "";
String strMaxDataCess = "";
String strCheckCiclo ="";
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
<SCRIPT LANGUAGE='Javascript'>

var objForm = null;
var codeTipoContr = '';

objForm = document.formPag;

function ONESEGUI(){

  document.formPag.comboTipoContr.disabled=false;
  document.formPag.comboContr.disabled=false;
  document.formPag.comboProdotti.disabled=false;
  document.formPag.comboOggFatrz.disabled=false;
  document.formPag.comboCausali.disabled=false;
  
  var indiceTipoEstrazione= document.formPag.comboTipoEstrazione.selectedIndex;
  var tipoEstrazione=document.formPag.comboTipoEstrazione.options[indiceTipoEstrazione].value; 
  
  var indiceTipoContr= document.formPag.comboTipoContr.selectedIndex;
  var tipoContr=document.formPag.comboTipoContr.options[indiceTipoContr].value; 
  
  var indiceContr= document.formPag.comboContr.selectedIndex;
  var contr=document.formPag.comboContr.options[indiceContr].value; 
  
  var indiceProdotto= document.formPag.comboProdotti.selectedIndex;
  var prodotto=document.formPag.comboProdotti.options[indiceProdotto].value; 
  
  var indiceOggFatrz= document.formPag.comboOggFatrz.selectedIndex;
  var oggFatrz=document.formPag.comboOggFatrz.options[indiceOggFatrz].value; 
  
  var indiceCausale= document.formPag.comboCausali.selectedIndex;
  var causale=document.formPag.comboCausali.options[indiceCausale].value;
  
  if(tipoContr == undefined || tipoContr == '' || tipoContr == '0'){
    alert('Selezionare la tipologia estrazione.');
    return;
  }
  
  if(tipoEstrazione == undefined || tipoEstrazione == '' || tipoEstrazione == '0'){
    alert('Selezionare la tipologia di contratto.');
    return;
  }
  
  
  var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  var sendMessage='codiceTipoContratto=1&codeTipoContr='+tipoContr+'&codeFunz=30&id_funz='+tipoEstrazione+'&contr='+contr+'&prodotto='+prodotto+'&oggFatrz='+oggFatrz+'&causale='+causale;
  //alert('sendMessage ['+sendMessage+']');
  chiamaRichiesta(sendMessage,'lanciaEstrazioneTariffe',asyncFunz);
}

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none';
  document.formPag.comboTipoContr.disabled=true;
  document.formPag.comboContr.disabled=true;
  document.formPag.comboProdotti.disabled=true;
  document.formPag.comboOggFatrz.disabled=true;
  document.formPag.comboCausali.disabled=true;
}

function caricaContratti()
{
  indice= document.formPag.comboTipoContr.selectedIndex;
  valore= document.formPag.comboTipoContr.options[indice].value;
  if(valore==""){
    document.formPag.comboContr.disabled=true;
    document.formPag.comboProdotti.disabled=true;
    document.formPag.comboOggFatrz.disabled=true;
    document.formPag.comboCausali.disabled=true;
  }else{
    indice_tipoEstr= document.formPag.comboTipoEstrazione.selectedIndex;
    valore_tipoEstr= document.formPag.comboTipoEstrazione.options[indice_tipoEstr].value;
    if(valore_tipoEstr=="4"){
      document.formPag.comboContr.disabled=false;
      document.formPag.comboContr.length=0;
      codeTipoContr = valore;
      var carica = function(dati){onCaricaContratti(dati);};
      var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
      var asyncFunz=  function(){ handler_generico(http,carica,errore);};  
      chiamaRichiesta('codeTipoContr='+codeTipoContr,'listaContrXTipoContr',asyncFunz);
    }else{
      document.formPag.comboContr.disabled=true;
      caricaProdotti();
    }
  }
}

function abilitaCombo()
{
  indice= document.formPag.comboTipoEstrazione.selectedIndex;
  valore= document.formPag.comboTipoEstrazione.options[indice].value;
  if(valore == "0"){
    document.formPag.comboTipoContr.value='';
    document.formPag.comboTipoContr.disabled=true;
    document.formPag.comboContr.value='0'; 
    document.formPag.comboProdotti.value='0';
    document.formPag.comboOggFatrz.value='0';
    document.formPag.comboCausali.value='0';
    document.formPag.comboContr.disabled=true;    
    document.formPag.comboProdotti.disabled=true;
    document.formPag.comboOggFatrz.disabled=true;
    document.formPag.comboCausali.disabled=true;
  }else{
    document.formPag.comboTipoContr.value='';
    document.formPag.comboTipoContr.disabled=false;
    document.formPag.comboContr.value='0'; 
    document.formPag.comboProdotti.value='0';
    document.formPag.comboOggFatrz.value='0';
    document.formPag.comboCausali.value='0';
    document.formPag.comboContr.disabled=true;    
    document.formPag.comboProdotti.disabled=true;
    document.formPag.comboOggFatrz.disabled=true;
    document.formPag.comboCausali.disabled=true;
  }
}



function onCaricaContratti(dati)
{
  riempiSelect('comboContr',dati);
  caricaProdotti();
}

function caricaProdotti()
{
  indice= document.formPag.comboTipoContr.selectedIndex;
  valore= document.formPag.comboTipoContr.options[indice].value;
  
  if(valore != "0"){
    document.formPag.comboProdotti.disabled=false;
    document.formPag.comboProdotti.length=0;
    var carica = function(dati){onCaricaProdotti(dati);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};  
    chiamaRichiesta('codeTipoContr='+valore,'listaPsXTipoContr',asyncFunz);
  }else{
    document.formPag.comboProdotti.value=0;
    document.formPag.comboProdotti.disabled=true;
  }
}

function onCaricaProdotti(dati)
{
  riempiSelect('comboProdotti',dati);
  caricaOggFatrz();
}

function caricaOggFatrz()
{
  document.formPag.comboOggFatrz.disabled=false;
  document.formPag.comboOggFatrz.length=0;
  var carica = function(dati){onCaricaOggFatrz(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};  
  chiamaRichiesta('codeTipoContr='+codeTipoContr,'listaOggFatrzXTipoContr',asyncFunz);
  //caricaOggFatrz();
}

function onCaricaOggFatrz(dati)
{
  riempiSelect('comboOggFatrz',dati);
}

function caricaCausali()
{
  indice= document.formPag.comboOggFatrz.selectedIndex;
  valore= document.formPag.comboOggFatrz.options[indice].value;
  if(valore != "0" && valore != undefined){
    document.formPag.comboCausali.disabled=false;
    document.formPag.comboCausali.length=0;
    var carica = function(dati){onCaricaCausali(dati);};
    var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    var asyncFunz=  function(){ handler_generico(http,carica,errore);};  
    chiamaRichiesta('codeTipoContr='+codeTipoContr+'&codeOggFatrz='+valore,'listaCausaliXTipoContr',asyncFunz);
  }else{
    document.formPag.comboCausali.disabled=true;
  }
}

function onCaricaCausali(dati)
{
  riempiSelect('comboCausali',dati);
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Estrazioni Tariffe</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <br>
      <table width="90%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Tipo Estrazione</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Tipo Estrazione</td>
          <td width="80%">
            <select name="comboTipoEstrazione" width="10px" class="text" onchange="abilitaCombo()">
              <option value="0" selected=true>Selezionare Tipo Estrazione</option>
              <option value="5">Assenza OF/PS.</option>
              <option value="4">Presenza OF/PS, assenza tariffa associata</option>
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Tipo Contratti</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Tipo Contratto</td>
          <td width="80%">
            <select name="comboTipoContr" width="10px" class="text" onchange="caricaContratti()">
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
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Contratti</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Contratto</td>
          <td width="80%">
            <select name="comboContr" width="10px" class="text" onchange="caricaProdotti()">
            <option value="0" selected=true>Selezionare Contratto</option>
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Prodotti</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Prodotto</td>
          <td width="80%">
            <select name="comboProdotti" width="10px" class="text" onchange="caricaOggFatrz()">
            <option value="0" selected=true>Selezionare Prodotto</option>
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Oggetti di Fatturazione</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Oggetto Fatturazione</td>
          <td width="80%">
            <select name="comboOggFatrz" width="10px" class="text" onchange="caricaCausali()">
            <option value="0" selected=true>Selezionare Oggetto di Fatturazione</option>
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Causali</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Causale</td>
          <td width="80%">
            <select name="comboCausali" width="10px" class="text">
            <option value="0" selected=true>Selezionare Causale</option>
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        <%--
        <tr>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Tipo Listino</td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
        </tr>
        <tr HEIGHT='35px'>
          <td class="textB" width="20%">Tipo Listino</td>
          <td width="80%">
            <select name="comboTipoListino" width="10px" class="text">
              <option value="" selected=true>Selezionare Tipo Listino</option>
              <option value="0">Listino Standard</option>
              <option value="1">Listino Personalizzato</option>
            </select>
          </td>
          <td class="textB"><!-- Tutti--></td>
           <td class="textB">
            <!--<input type='checkbox' name='chkContratti' value='<%=strCheckCess%>' onclick="DisabilitaComboContratti();"> -->
          </td> 
        </tr>
        --%>
		 	</table>
      <br>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
            <sec:ShowButtons VectorName="vectorButton" />
          </td>
        </tr>
      </table>
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
