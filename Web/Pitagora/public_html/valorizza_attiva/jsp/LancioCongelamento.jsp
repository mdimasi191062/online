<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioCongelamento.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
%>

<EJB:useHome id="homeAccountElabSTL" type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
<EJB:useBean id="remoteAccountElabSTL" type="com.ejbSTL.AccountElabSTL" scope="session">
    <EJB:createBean instance="<%=homeAccountElabSTL.create()%>" />
</EJB:useBean>

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

function ONLANCIOBATCH()
{
  if (formPag.comboAccorpati.length < 1){
    alert('Selezionare almeno un servizio da congelare.');
    return;
  }
  
  selectAllComboElements(formPag.comboAccorpati);
  
  Disable(formPag.LANCIOBATCH);
  
  formPag.action = "LancioCongelamento2.jsp";
  formPag.submit();
}

function riempiSelectWithClass(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length;a++)
  {        
    eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
    eval('document.formPag.'+select+'.options[a].className=dati[a].classe;');
  }
}

function addAllOptionToComboWithClass(cboSource,cboDestination){

	var myOpt = null;
	var i = 0;
  if(cboSource.name == 'comboDisponibili')
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
  var myOpt = null;
  if(index != -1)
  {
    myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
    myOpt.className == 'textList';
    DelOptionByIndex(cboSource,index);
  }
}

function removeAllOptionToComboWithClass(cboSource,cboDestination){

	var myOpt = null;
	var i = 0;
  if(cboSource.name == 'comboDisponibili')
    classe = 'textListRosso';
  else
    classe = 'textList';
	
  while (cboSource.length > i)
	{
    myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
    myOpt.className == 'textList';
    DelOptionByIndex(cboSource,i);
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

function onChangeTipoBatch()
{
  indice= document.formPag.tipoBatch.selectedIndex;
  if(indice>0)
  {
    tipo_batch =document.formPag.tipoBatch.options[indice].value;
    carica = function(dati){onCaricaCongelamenti(dati)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('tipo_batch='+tipo_batch,'listaServiziDaCongelareSpecial',asyncFunz); 
  }
  else
  {
    ClearCombo(document.formPag.comboDisponibili);
    ClearCombo(document.formPag.comboAccorpati);   
  }

}

function onCaricaCongelamenti(dati)
{
  riempiSelectWithClass('comboDisponibili',dati);
}


</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>
Congelamento Special
</title>
</head>

<BODY>


<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio"  style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera">
<form name="formPag" method="post">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Congelamento Special</td>
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
            

              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <%-- TIPO ELABORAZIONE - inizio --%>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <tr>
                        <td class="textB" align="right" width="50%">Tipo Elaborazione:</td>
                        <td class="text" align="left" width="50%">
                          <select class="text" title="tipoBatch" id="tipoBatch" name="tipoBatch" onchange="onChangeTipoBatch();">                                                  
                            <option value="0" selected>Selezionare Tipo Elaborazione</option>
                            <option value="V">Valorizzazione</option>
                            <option value="R">Repricing</option>
                            <option value="M">Fattura/Nota credito Manuale</option>
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <%-- TIPO ELABORAZIONE - fine --%>
                
                
                
                
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
                
                <%-- Servizi da lanciare - INIZIO --%>

                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <Tr>
                        <td class="text" align="center" widht="49%">Elenco Servizi da congelare</td>
                        <td class="text" widht="2%">&nbsp;</td>
                        <td class="text" align="center" widht="49%">Elenco Servizi da lanciare</td>
                      </Tr>
                      
                      <Tr bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                        <Td  class="text"  widht="49%">
                          <Select name="comboDisponibili" title="Account Disponibili" id="comboDisponibili" size="20" class="textList" ondblclick="addOptionToCombo(formPag.comboDisponibili,formPag.comboAccorpati)">                     
                          </select>
                        </Td>
                        <Td align="center" width="2%" valign="middle">
                          <INPUT  type="button" value="&gt;&gt;" class="text" style="width:100%" onclick="addAllOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">                        
                          <INPUT  type="button" value="&gt;" class="text" style="width:100%" onclick="addOptionToComboWithClass(formPag.comboDisponibili,formPag.comboAccorpati)">
                          <INPUT  type="button" value="&lt;" class="text" style="width:100%" onclick="removeOptionToComboWithClass(formPag.comboAccorpati,formPag.comboDisponibili)">
                          <INPUT  type="button" value="&lt;&lt;" class="text" style="width:100%" onclick="addAllOptionsToCombo(formPag.comboAccorpati,formPag.comboDisponibili)">
                        </Td>
                        <Td class="text" widht="49%">
                          <Select name="comboAccorpati" multiple title="Account Disponibili" id="comboAccorpati" size="20" class="textList" ondblclick="addOptionToCombo(frmDati.comboAccorpati,frmDati.comboDisponibili)">
                          </select>
                        </Td>
                      </Tr>

                    </Table>
                  </td>
                </tr>
                <%-- DISPONIBILI E ACCORPATI - FINE --%>
                
              </TABLE>
                
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
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
	      </tr>
	    </table>
    </td>
  </tr>  
  
</table>
</div>
</form>

<script language="Javascript">
Enable(formPag.LANCIABATCH);
var http=getHTTPObject();
</script>

</body>
</html>
