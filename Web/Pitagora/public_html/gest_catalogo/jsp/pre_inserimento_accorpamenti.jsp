<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_accorpamenti.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>
<%
  int esito = 0;
  String messaggio = "";

  String operazione = Misc.nh(request.getParameter("operazione"));
  String data_accorpamento = Misc.nh(request.getParameter("data_accorpamento"));
  
  String strCodeServizio = Misc.nh(request.getParameter("comboServizi"));
  String strCodeGestore = Misc.nh(request.getParameter("comboGestori"));
  String strAccountAccorpante = Misc.nh(request.getParameter("comboAccorpanti"));  
  String strAccountAccorpati[] = request.getParameterValues("comboAccorpati");
  String strControllaAccorpati = Misc.nh(request.getParameter("controllaAccorpati"));
  
  String accorpatoDel = "";
  
  /* determino se effettuare la delete per gli accorpamenti non in esercizio eliminati */
  if(!operazione.equals("")){
    /* cancellazione vecchi accorpamenti */
    java.util.StringTokenizer deleteAccorpati = new java.util.StringTokenizer(strControllaAccorpati,"|");
    while(deleteAccorpati.hasMoreTokens()){
      accorpatoDel = deleteAccorpati.nextToken();
      /* effettuo la cancellazione del vecchio accorpato cancellabile */
      esito = remoteEnt_Catalogo.deleteAccorpamento(strCodeServizio,strAccountAccorpante,accorpatoDel);
      if(esito==0)
        messaggio = "Salvataggio Accorpamenti effettuato correttamente.";
      else
        messaggio = "Errore durante il salvataggio Accorpamenti.";
    }
    /* inserimento nuovi accorpamenti */
    if(strAccountAccorpati != null && strAccountAccorpati.length > 0){
      esito = remoteEnt_Catalogo.insAccorpamenti(strCodeServizio,strAccountAccorpante,strAccountAccorpati,data_accorpamento);
      if(esito==0)
        messaggio = "Salvataggio Accorpamenti effettuato correttamente.";
      else
        messaggio = "Errore durante il salvataggio Accorpamenti.";
    }
  }
%>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>

<SCRIPT LANGUAGE='Javascript'>

var step='';
var datiServ;
var datiGestori;
var datiAccAccorpanti;
var datiAccAccorpati;
var datiAccDisponibili;
var code_servizio='';
var code_gestore='';

var controlloAccorpati = '';

var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";

function initialize(){
    caricaServizi();
    divIns.style.display='none';
    divIns.style.visibility='hidden';
    step='accorpanti';
}

function caricaServizi()
{
  carica = function(dati){onCaricaServizi(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('codiceServizio=0','listaServizi',asyncFunz);
}

function onCaricaServizi(dati)
{
  riempiSelect('comboServizi',dati);
  divIns.style.visibility="visible";
  divIns.style.display="inline";
  if(dati.length==0)
  {
    document.formPag.comboServizi.style.visibility="hidden";
    document.formPag.comboServizi.style.display="none";
  }
  else
  {
    document.formPag.comboServizi.style.visibility="visible";
    document.formPag.comboServizi.style.display="inline";
  }
}


function onChangeServizio()
{
  indice= document.formPag.comboServizi.selectedIndex;
  if(indice>0)
  {
    code_servizio =document.formPag.comboServizi.options[indice].value;
    document.formPag.comboServizi.value=document.formPag.comboServizi.options[indice].text.toUpperCase();
    carica = function(dati){onCaricaGestori(dati)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('code_servizio='+code_servizio,'listaGestori',asyncFunz);
    document.formPag.comboServizi.value = code_servizio;
    ClearCombo(document.formPag.comboAccorpanti);
    ResetCombo(formPag.comboAccorpanti,'Selezionare Account Accorpante','');    
  }
  else
  {
    code_servizio='';
    document.formPag.comboServizi.value='';
    ClearCombo(document.formPag.comboGestori);
    ClearCombo(document.formPag.comboAccorpanti);
    ResetCombo(formPag.comboGestori,'Selezionare Gestore','');
    ResetCombo(formPag.comboAccorpanti,'Selezionare Account Accorpante','');    
  }
  
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboAccorpati);
}

/*  GESTORI - INIZIO */
function onChangeGestore()
{
  indice= document.formPag.comboGestori.selectedIndex;
  if(indice>0)
  {
    code_servizio =document.formPag.comboServizi.value;
    code_gestore = document.formPag.comboGestori.options[indice].value;
    document.formPag.comboGestori.value=document.formPag.comboGestori.options[indice].text.toUpperCase();
    carica = function(dati){onCaricaAccountAccorpanti(dati)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('code_servizio='+code_servizio+'&code_gestore='+code_gestore,'listaAccountAccorpanti',asyncFunz);
    document.formPag.comboGestori.value = code_gestore;
  }
  else
  {
    code_gestore='';
    document.formPag.comboGestori.value='';
    ClearCombo(document.formPag.comboAccorpanti);
    ResetCombo(formPag.comboAccorpanti,'Selezionare Account Accorpante','');    
  }
  
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboAccorpati);
}

function onCaricaGestori(dati)
{
  riempiSelect('comboGestori',dati);
  document.formPag.comboGestori.style.visibility="visible";
  document.formPag.comboGestori.style.display="inline";
  divIns.style.visibility="visible";
  divIns.style.display="inline";
}

/*  GESTORI - FINE */

function onCaricaAccountAccorpanti(dati)
{
  riempiSelect('comboAccorpanti',dati);
  document.formPag.comboAccorpanti.style.visibility="visible";
  document.formPag.comboAccorpanti.style.display="inline";
  divIns.style.visibility="visible";
  divIns.style.display="inline";
}

function onChangeAccorpante()
{
  indice= document.formPag.comboAccorpanti.selectedIndex;
  if(indice>0)
  {
    code_accorpante =document.formPag.comboAccorpanti.options[indice].value;
    document.formPag.comboAccorpanti.value=document.formPag.comboAccorpanti.options[indice].text.toUpperCase();    
    caricaDisponibili(code_accorpante);
    document.formPag.comboServizi.value = code_servizio;
    document.formPag.comboAccorpanti.value = code_accorpante;
  }
  else
  {
    code_accorpante='';        
    document.formPag.comboAccorpanti.value='';
    ClearCombo(document.formPag.comboDisponibili);
    ClearCombo(document.formPag.comboAccorpati);
  }
}

function caricaAccorpati(code_accorpante)
{
  carica = function(dati){onCaricaAccountAccorpati(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('code_accorpante='+code_accorpante,'listaAccountAccorpati',asyncFunz);
}

function caricaDisponibili(code_accorpante)
{
  carica = function(dati){onCaricaDisponibili(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('code_servizio='+code_servizio+'&code_accorpante='+code_accorpante,'listaAccountDisponibili',asyncFunz);
}

function onCaricaDisponibili(dati)
{
  riempiSelectWithClass('comboDisponibili',dati);
  caricaAccorpati(code_accorpante);
}

function onCaricaAccountAccorpati(dati)
{
  riempiSelectWithClass('comboAccorpati',dati);
}

function ONSALVA()
{
  if(document.formPag.comboServizi.value==''){
    alert('Selezionare il Servizio.');
    document.formPag.comboServizi.focus();
    return;
  }
  if(document.formPag.comboGestori.value==''){
    alert('Selezionare Gestore.');
    document.formPag.comboGestori.focus();
    return;
  }
  if(document.formPag.comboAccorpanti.value==''){
    alert('Selezionare Account Accorpante.');
    document.formPag.comboAccorpanti.focus();
    return;
  }
  if (formPag.comboAccorpati.length > 0){
    if(document.formPag.dataAccorpamento.value==''){
      alert('Selezionare la Data Accorpamento.');
      document.formPag.dataAccorpamento.focus();
      return;
    }
  }
  
  //submit su se stessa
  selectAllComboElements(formPag.comboAccorpati);
  
  
  document.formPag.action = "pre_inserimento_accorpamenti.jsp?operazione=1&data_accorpamento="+document.formPag.dataAccorpamento.value;
  document.formPag.submit();
}

function riempiSelectWithClass(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  controlloAccorpati = document.formPag.controllaAccorpati.value;
  for(a=0;a < dati.length;a++)
  {        
    eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
    eval('document.formPag.'+select+'.options[a].className=dati[a].classe;');
    if(select == 'comboAccorpati' && dati[a].classe == 'textListRosso'){
      controlloAccorpati = controlloAccorpati + dati[a].value + '|';
    }
  }
  document.formPag.controllaAccorpati.value = controlloAccorpati;
}

function addOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
	var myOpt = null;
  var classe = '';
  
  if(cboSource.name == 'comboDisponibili')
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

function removeOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
  if(cboSource.options[index].className == 'textListRosso')
  {
    var myOpt = null;
    if(index != -1)
    {
      myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
      myOpt.className == 'textList';
      DelOptionByIndex(cboSource,index);
    }
  }else{
    alert('\tAttenzione!!!\n\nIn questa release non è possibile eliminare accorpamento già presente in esercizio.');
  }
}

function selectAllComboElementsWithClasses(Field)
	{
		var len = Field.length;
		var x=0;
		for (x=0;x<len;x++)
		{
      alert('Field.className ['+Field.className+']');
      if (Field.className == 'textListRosso'){
  			Field.options[x].selected = true;
      }
		}
	}

function ONANNULLA(){
  code_servizio='';
  document.formPag.comboServizi.value='';
  ClearCombo(document.formPag.comboGestori);
  ClearCombo(document.formPag.comboAccorpanti);
  ResetCombo(formPag.comboAccorpanti,'Selezionare Account Accorpante','');
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboAccorpati);
}

function cancelCalendar (obj)
{
  obj.value="";
}

function formatDate(date)
{
  var m = date.getMonth();
  var d = date.getDate();
  var y = date.getFullYear();
  
  d = (d < 10) ? ("0" + d) : d;
  m = (m < 9) ? ("0" + (1+m)) : (1+m);
  str = d + '/' + m + '/' + y;
  return str;  
}

function selectAllComboElementsLocal(Field)
{
  alert('selectAllComboElementsLocal');
  var len = Field.length;
  var x=0;
  for (x=0;x<len;x++)
  {
    alert('Field ['+x+']');
    Field.options[x].selected = true;
    alert('Field.selected ['+Field.options[x].selected+']');
  }
}
	
</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>
PIPPO
</title>
</head>
<BODY onload=initialize();>

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>


<div name="maschera" id="maschera">
<form name="formPag" method="post">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="controllaAccorpati" id="controllaAccorpati" value="">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../images/catalogo.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Accorpamenti</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" heigth="100%">
            <div name="divIns" id="divIns" style="visibility:hidden;display:none;" >

              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

                <%-- SERVIZI E ACCORPANTI - INIZIO --%>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <tr>
                        <td class="textB" align="right" width="50%">Servizio:</td>
                        <td class="text" align="left" width="50%">
                          <select class="text" title="Servizio" id="comboServizi" name="comboServizi" onchange="onChangeServizio();">                                                  
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <tr>
                        <td class="textB" align="right" width="50%">Gestori:</td>
                        <td class="text" align="left" width="50%">
                          <select class="text" title="Gestore" id="comboGestori" name="comboGestori" onchange='onChangeGestore()' >
                            <option value="">Selezionare Gestore</option>
                          </select>
                        </td>
                      </tr>
                    </table>  
                  </td>
                </tr>
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <tr>
                        <td class="textB" align="right" width="50%">Account Accorpante:</td>
                        <td class="text" align="left" width="50%">
                          <select class="text" title="Account Accorpante" id="comboAccorpanti" name="comboAccorpanti" onchange='onChangeAccorpante()' >
                            <option value="">Selezionare Account Accorpante</option>
                          </select>
                        </td>
                      </tr>
                    </table>  
                  </td>
                </tr>
                <%-- SERVIZI E ACCORPANTI - FINE --%>
                
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>

                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
                
                <%-- DISPONIBILI E ACCORPATI - INIZIO --%>

                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <Td class="textB" align="center" widht="40%">Account Disponibili</Td>
                        <td class="text" widht="20%">&nbsp;</td>
                        <td class="textB" align="center" widht="40%">Account Accorpati</td>
                      </Tr>
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                        <Td  class="text"  widht="40%">
                          <Select name="comboDisponibili" title="Account Disponibili" id="comboDisponibili" size="20" class="textList" ondblclick="addOptionToCombo(formPag.comboDisponibili,formPag.comboAccorpati)">
                          </select>
                        </Td>
                        <Td align="center" width="30" valign="middle">
                          <%--<INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">--%>
                          <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">
                          <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpati,formPag.comboDisponibili)">
                          <%--<INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpati,formPag.comboDisponibili)">--%>
                        </Td>
                        <Td class="text" widht="40%">
                          <Select name="comboAccorpati" multiple title="Account Disponibili" id="comboAccorpati" size="20" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpati,frmDati.comboDisponibili)">
                          </select>
                        </Td>
                      </Tr>
                    </Table>
                  </td>
                </tr>
                <%-- DISPONIBILI E ACCORPATI - FINE --%>
                
              </TABLE>
            </div>
                
          </td>
        </tr>
      </table>
    </td>
  </tr>  
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td class="textB" align="right" nowrap>Data Accorpamento:&nbsp;</td>      
          <td class="text" align="left">
            <input type="text" class="text" size=12 maxlength="12" name="dataAccorpamento" title="Data Accorpamento" value="" onblur="handleblur('data_accorpamento');" readonly>
            <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
            <a href="javascript:cancelCalendar(document.formPag.dataAccorpamento);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
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

if(document.formPag.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>


<script language="JavaScript">
  // Calendario Data Inizio Validità
  var cal1 = new calendar1(document.forms['formPag'].elements['dataAccorpamento']);
  cal1.year_scroll = true;
  cal1.time_comp = false;
  document.formPag.dataAccorpamento.value = formatDate(new Date());
 </script>
</html>
