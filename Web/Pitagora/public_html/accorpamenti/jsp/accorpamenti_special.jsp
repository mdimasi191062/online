<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"accorpamenti_special.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  int esito = 0;
  String messaggio = "";

  String operazione = Misc.nh(request.getParameter("operazione"));
    
  String strCodeServizio = Misc.nh(request.getParameter("comboServizi"));
  String strCodeGestore = Misc.nh(request.getParameter("comboGestori"));
  String strAccountAccorpati[] = request.getParameterValues("comboAccorpati");
  String strControllaAccorpati = Misc.nh(request.getParameter("controllaAccorpati"));
  
  String accorpatoDel = "";
  
  /* determino se effettuare la delete per gli accorpamenti non in esercizio eliminati */
  if(!operazione.equals(""))
  {
    /* cancellazione vecchi accorpamenti */
    /* java.util.StringTokenizer deleteAccorpati = new java.util.StringTokenizer(strControllaAccorpati,"|");
    while(deleteAccorpati.hasMoreTokens()){
      accorpatoDel = deleteAccorpati.nextToken();
      /* effettuo la cancellazione del vecchio accorpato cancellabile */
      /* esito = remoteCtr_Utility.deleteAccorpamentoSpecial(strCodeServizio,strCodeGestore,accorpatoDel);
      if(esito==0)
        messaggio = "Salvataggio Accorpamenti effettuato correttamente.";
      else
        messaggio = "Errore durante il salvataggio Accorpamenti.";
    } */
    /* inserimento nuovi accorpamenti */
    if(strAccountAccorpati != null && strAccountAccorpati.length > 0){
      esito = remoteCtr_Utility.insAccorpamentiSpecial(strCodeServizio,strCodeGestore,strAccountAccorpati);
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
  chiamaRichiesta('codiceServizio=0','listaServizi_special',asyncFunz);
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
    chiamaRichiesta('code_servizio='+code_servizio,'listaGestori_special',asyncFunz);
    document.formPag.comboServizi.value = code_servizio;
  }
  else
  {
    code_servizio='';
    document.formPag.comboServizi.value='';
    ClearCombo(document.formPag.comboGestori);
    ResetCombo(formPag.comboGestori,'Selezionare Gestore','');
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
    code_accorpante =document.formPag.comboGestori.options[indice].value;
    document.formPag.comboGestori.value=document.formPag.comboGestori.options[indice].text.toUpperCase();    
    caricaDisponibili(code_accorpante);
    document.formPag.comboServizi.value = code_servizio;
    document.formPag.comboGestori.value = code_accorpante;
  }
  else
  {
    code_accorpante='';        
    document.formPag.comboGestori.value='';
    ClearCombo(document.formPag.comboDisponibili);
    ClearCombo(document.formPag.comboGestori);
  }
}
/*alf{
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
alf*/
function onCaricaGestori(dati)
{
  riempiSelect('comboGestori',dati);
  document.formPag.comboGestori.style.visibility="visible";
  document.formPag.comboGestori.style.display="inline";
  divIns.style.visibility="visible";
  divIns.style.display="inline";
}

/*  GESTORI - FINE */

/*function onCaricaAccountAccorpanti(dati)
{
  riempiSelect('comboAccorpanti',dati);
  document.formPag.comboAccorpanti.style.visibility="visible";
  document.formPag.comboAccorpanti.style.display="inline";
  divIns.style.visibility="visible";
  divIns.style.display="inline";
}*/

/*function onChangeAccorpante()
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
}*/

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
  chiamaRichiesta('code_servizio='+code_servizio+'&code_accorpante='+code_accorpante,'listaAccountDisponibili_special',asyncFunz);
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
  
  //submit su se stessa
  selectAllComboElements(formPag.comboAccorpati);
  
  
  document.formPag.action = "accorpamenti_special.jsp?operazione=1";
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
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboAccorpati);
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
    <td><img src="../images/accorpamenti.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Accorpamenti Special</td>
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
                        <td class="textB" align="right" width="50%">Gestori Accorpanti:</td>
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
                        <Td class="textB" align="center" widht="40%">Gestori Disponibili</Td>
                        <td class="text" widht="20%">&nbsp;</td>
                        <td class="textB" align="center" widht="40%">Gestori Accorpati</td>
                      </Tr>
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                        <Td  class="text"  widht="40%">
                          <Select name="comboDisponibili" title="Account Disponibili" id="comboDisponibili" size="20" class="textList" ondblclick="addOptionToCombo(formPag.comboDisponibili,formPag.comboAccorpati)">
                          </select>
                        </Td>
                        <Td align="center" width="30" valign="middle">
                          <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">
                          <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpati,formPag.comboDisponibili)">
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

</html>
