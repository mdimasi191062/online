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
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"listini.jsp")%>
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

<iframe id='target_upload' name='target_upload' src='' style="display:none">  
</iframe>

<SCRIPT LANGUAGE='Javascript'>

 var objForm = null;
 objForm = document.formPag;
 String.prototype.endsWith = function(str){return (this.match(str+'$')==str)}
  function onUploadFile()
  {
      
      mascheraFileLoad.style.display='inline';
      mascheraFile.style.display='none';
  document.formPag.action='../../servletStrutturaWeb?action=uploadFile';
document.formPag.txtRisorse.value="";
  document.formPag.encoding='multipart/form-data';
  document.formPag.method='post';
  document.formPag.target='target_upload';
  document.formPag.submit();
  window.setTimeout("checkEndUpload()", 2000);
  }
  
  function checkEndUpload()
 {
    var riga=window["target_upload"].document.body.innerHTML;
      if(riga.endsWith(";</PRE>"))
      {
        riga=riga.replace('<pre>','');
        riga=riga.replace('</pre>','');
        riga=riga.replace('<PRE>','');
        riga=riga.replace('</PRE>','');
        eval(riga);
        
        document.formPag.txtRisorse.value=dati[0].text;
         
        window["target_upload"].document.body.innerHTML='';
        mascheraFileLoad.style.display='none';
          mascheraFile.style.display='inline';           
    }
    else
    {
        window.setTimeout("checkEndUpload()", 2000);
    }
   
 }


function ONESEGUI(){

 indiceTipoEstr = document.formPag.comboTipoEstraz.selectedIndex;
 var tipoEstrazione = document.formPag.comboTipoEstraz.options[indiceTipoEstr].value; 

 indicePeriodoEstr = document.formPag.comboPeriodoEstraz.selectedIndex;
 var periodoEstrazione = document.formPag.comboPeriodoEstraz.options[indicePeriodoEstr].value; 
 
 indiceTipoContr = document.formPag.comboTipoContr.selectedIndex;
 var tipoContr = document.formPag.comboTipoContr.options[indiceTipoContr].value; 
 
  if(document.formPag.chkAccount.checked){
      account='null';
  }else{
      indice1= document.formPag.comboAccount.selectedIndex;
      var account=document.formPag.comboAccount.options[indice1].value; 
  }
 
 var risorse = document.formPag.txtRisorse.value;

 var minCiclo=document.formPag.txtMinCiclo.value;
 var maxCiclo=document.formPag.txtMaxCiclo.value;
 
 if(document.formPag.chkCiclo.checked){
   minCiclo="01/01/1000"
   maxCiclo="01/01/9999"   
 }

 var TempminCiclo=minCiclo;
 var TempmaxCiclo=maxCiclo;

 var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};

 var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=6&codeTipoContr='+tipoContr+'&codeAccount='+account+'&tipoEstrazione='+tipoEstrazione+'&periodoEstrazione='+periodoEstrazione+'&minCiclo='+TempminCiclo+'&maxCiclo='+TempmaxCiclo+'&aryRisorse='+risorse;
 chiamaRichiesta(sendMessage,'TracciabilitaListini',asyncFunz);
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

function controllaTesto()
{
  if(document.formPag.txtRisorse.value=="Inserire un ID Risorsa per riga (manualmente o tramite caricamento di un file txt) .")
  {
    document.formPag.txtRisorse.value="";
  }
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
 chiamaRichiesta('','listaTipiContr',asyncFunz);

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

function DataCicloVisibile()
{
  if(document.formPag.chkCiclo.checked)
  {
    document.formPag.imgCalendar1.style.visibility='hidden';
    document.formPag.imgCalendar1.style.display='none';
 
    document.formPag.imgCancel1.style.visibility='hidden';
    document.formPag.imgCancel1.style.display='none';
 
    document.formPag.imgCalendar2.style.visibility='hidden';
    document.formPag.imgCalendar2.style.display='none';
    
    document.formPag.imgCancel2.style.visibility='hidden';
    document.formPag.imgCancel2.style.display='none';

    clearField(document.formPag.txtMinCiclo);
    clearField(document.formPag.txtMaxCiclo);
    document.formPag.txtMinCiclo.value="Tutte le Date";
    document.formPag.txtMaxCiclo.value="Tutte le Date";
  }
 else 
 {
    document.formPag.imgCalendar1.style.visibility='visible';
    document.formPag.imgCalendar1.style.display='inline';
 
    document.formPag.imgCancel1.style.visibility='visible';
    document.formPag.imgCancel1.style.display='inline';
  
    document.formPag.imgCalendar2.style.visibility='visible';
    document.formPag.imgCalendar2.style.display='inline';
    
    document.formPag.imgCancel2.style.visibility='visible';
    document.formPag.imgCancel2.style.display='inline';
    clearField(document.formPag.txtMinCiclo);
    clearField(document.formPag.txtMaxCiclo);
 }
}


function dateFatturaVisibile()
{
  if(1 != 1)
  {
    document.formPag.chkCiclo.checked=true;
    document.formPag.chkCiclo.disabled=true;
  
    document.formPag.imgCalendar1.style.visibility='hidden';
    document.formPag.imgCalendar1.style.display='none';
 
    document.formPag.imgCancel1.style.visibility='hidden';
    document.formPag.imgCancel1.style.display='none';
 
    document.formPag.imgCalendar2.style.visibility='hidden';
    document.formPag.imgCalendar2.style.display='none';
    
    document.formPag.imgCancel2.style.visibility='hidden';
    document.formPag.imgCancel2.style.display='none';

    clearField(document.formPag.txtMinCiclo);
    clearField(document.formPag.txtMaxCiclo);
    document.formPag.txtMinCiclo.value="Tutte le Date";
    document.formPag.txtMaxCiclo.value="Tutte le Date";
  }
 else 
 {
    document.formPag.chkCiclo.checked=false;
    document.formPag.chkCiclo.disabled=false;
 
    document.formPag.imgCalendar1.style.visibility='visible';
    document.formPag.imgCalendar1.style.display='inline';
 
    document.formPag.imgCancel1.style.visibility='visible';
    document.formPag.imgCancel1.style.display='inline';
  
    document.formPag.imgCalendar2.style.visibility='visible';
    document.formPag.imgCalendar2.style.display='inline';
    
    document.formPag.imgCancel2.style.visibility='visible';
    document.formPag.imgCancel2.style.display='inline';
    clearField(document.formPag.txtMinCiclo);
    clearField(document.formPag.txtMaxCiclo);
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
<body onload="caricaTipoContr();dateFatturaVisibile();">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio" >
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Listini</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
       <table width="85%" border="0" cellspacing="0" cellpadding="3" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
									<tr HEIGHT='35px'>
                    <td class="textB" width="20%">Tipo Estrazione</td>
                    <td width="80%">
                      <select name="comboTipoEstraz" width="10px" class="text" >
                        <option value="FATTURA">Fattura</option>
                        <option value="NOTACREDITO">Nota di Credito</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Estrazione</td>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                  <tr HEIGHT='35px'>
                    <td class="textB" width="20%">Periodo Estrazione</td>
                    <td width="80%">
                      <select name="comboPeriodoEstraz" width="10px" class="text" >
                        <option value="STORICO">Storico</option>
                        <option value="CORRENTE">Ciclo corrente</option>
                      </select>
                    </td>
                  </tr>
                   <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Risorsa</td>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                  <tr >
                    <td class="textB" width="20%">Risorse</td>
                    <td width="80%">
                      <textarea NAME="txtRisorse" onclick="controllaTesto()" id="txtRisorse" COLS="40" ROWS="6" class="text">Inserire un ID Risorsa per riga (manualmente o tramite caricamento di un file txt) .</textarea>
                      <br />
                       <div id="mascheraFile">
                       <input class="textB" type="file" name="datafileshown" id="datafileshown" >
                       <input class="textB" type="button" name="btnInvioFile" id="btnInvioFile" onclick="onUploadFile();" value="Carica"></input>
                       </div>
                       
                       <div id="mascheraFileLoad" class="textB" style="display:none">
                           Attendere prego. Leggo il file... <img src="../../common/images/body/loading.gif" width="30px" height="30px" id="imgLoading" />
                        </div>
                    </td>
                  </tr>
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Contratto</td>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
                  <tr HEIGHT='35px'>
                    <td class="textB" width="20%">Tipo Contratto</td>
                    <td width="80%"><select name="comboTipoContr" width="10px" class="text" onchange="caricaAccount()"></select></td>
                  </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Account</td>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
                  <tr HEIGHT='35px'>
                    <td class="textB" width="20%">Account</td>
                    <td class=="text" width="80%"><select name="comboAccount" class="text" size="7" style="width: 100%;"></select></td>
                     <td class="textB">Tutti</td>
                     <td class="textB">
                      <input type='checkbox' name='chkAccount' value='<%=strCheckCess%>' onclick="DisabilitaComboAccount();">
                    </td>
              </tr>
               <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="41%">&nbsp;Filtro Valorizzazione</td>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="40%"></td>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="10%"></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
                  <tr HEIGHT='35px'>
										<td class="textB">Min ciclo di valorizzazione</td>
                    <td class="text">
											<input type='text' name='txtMinCiclo' value='<%=strMinCiclo%>' class="text" readonly="">
											<a href="javascript:showCalendar('formPag.txtMinCiclo','');" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
											<a href="javascript:clearField(formPag.txtMinCiclo);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
										</td>
                    <td class="textB">Tutti</td>
                     <td class="textB">
                      <input type='checkbox' name='chkCiclo' value='<%=strCheckCiclo%>' onclick="DataCicloVisibile();">
                    </td>
                  </tr>
                  <tr HEIGHT='35px'>
										<td class="textB">Max ciclo di valorizzazione</td>
                    <td class="text">
											<input type="text" name='txtMaxCiclo' value='<%=strMaxCiclo%>' class="text" readonly="">
											<a href="javascript:showCalendar('formPag.txtMaxCiclo','');" onMouseOut="status='';return true" ><img name='imgCalendar2' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
											<a href="javascript:clearField(formPag.txtMaxCiclo);"  onMouseOut="status='';return true"><img name='imgCancel2'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
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
