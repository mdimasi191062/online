<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"Tariffe_sconti_cr.jsp")%>
</logtag:logData>
<%

	String strIntestazione="";
	int intFunzionalita;
  
	String strCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));

	int intAction;
	
	if(Integer.parseInt(request.getParameter("intAction")) == -1  || request.getParameter("intAction") == null){

	  intAction = StaticContext.LIST;

	}else{

	  intAction = Integer.parseInt(request.getParameter("intAction"));

	}
	
	if(Integer.parseInt(request.getParameter("intFunzionalita")) == -1 || request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_ASS_TAR_SCO;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}

  switch (intAction){
		case StaticContext.LIST:
			strIntestazione="Associazione Tariffe Sconti";
		break;
	}
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script language=javascript>
var objForm;
function initialize()
{
	objForm = document.frmDati;
	DisableAllControls(objForm);
	Enable(objForm.cmdCliente);
}

function click_cmdCliente()
{
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
  stringa+="?nomeCombo=objForm.cboContratto";
  stringa+="&codiceTipoContratto=<%=strCodiceTipoContratto%>";
  stringa+="&intAction=<%=intAction%>";
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  openDialog(stringa, 569, 400, handleReturnedValueCliente);
}


function handleReturnedValueCliente()
{
  var stringa="";
  var field;
  stringa=dialogWin.returnedValue;
  field=stringa.split("|");
  Disable(objForm.POPOLALISTA);
  objForm.txtCliente.value = field[0];
  objForm.hidCodeCliente.value = field[1];
  Enable(objForm.cmdCliente);
  Enable(objForm.cboContratto);
  Disable(objForm.POPOLALISTA);
}


function changeContratto()
{
  if(getComboValue(objForm.cboContratto)==""){
        Disable(objForm.POPOLALISTA);
  }
  else
  {
    Enable(objForm.cmdPS);
	Enable(objForm.POPOLALISTA);
  }
}

function ONPOPOLALISTA()
{
			popolaviewState();
      var URLstringa = "Tariffe_sconti_lista.jsp?viewStateRicerca=" + objForm.viewStateRicerca.value + 	"&strFlagFiltro=0";
      openDialog(URLstringa, 800, 600,"","");

}
    
function popolaviewState()
{
	//
	updVS(objForm.viewStateRicerca,"vsRicIntAction","<%=intAction%>");
	updVS(objForm.viewStateRicerca,"vsRicIntFunzionalita","<%=intFunzionalita%>");
	//CODICI
	updVS(objForm.viewStateRicerca,"vsRicCodeTipoContratto","<%=strCodiceTipoContratto%>");
	updVS(objForm.viewStateRicerca,"vsRicCodeCliente",objForm.hidCodeCliente.value);
	updVS(objForm.viewStateRicerca,"vsRicCodeContratto",getComboValue(objForm.cboContratto));
	//DESCRIZIONI
	updVS(objForm.viewStateRicerca,"vsRicDescTipoContratto","<%=strDescTipoContratto%>");
	updVS(objForm.viewStateRicerca,"vsRicDescCliente",objForm.txtCliente.value);
	updVS(objForm.viewStateRicerca,"vsRicDescContratto",getComboText(objForm.cboContratto));
  
}

</script>
<TITLE>Criteri di ricerca</TITLE>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" method="post" action=>
<input type=hidden name="hidCodePS" value="">
<input type=hidden name="hidCodeCliente" value="">
<input type="hidden" name="viewStateRicerca" value="">
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_LISTINOTARIFFARIO_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
		<tr>
			<td>
			  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
				  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=strIntestazione%>: <%=request.getParameter("hidDescTipoContratto")%></td>
				  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
				</tr>
			  </table>
			</td>
		</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
        <td width="28%" class="textB" align="right">Cliente:&nbsp;&nbsp;</td>
        <td width="72%" class="text">
          <input class="text" title="Cliente" size="40" type="text" maxlength="30" name="txtCliente" value="">
          <input class="text" title="Cliente" type="button"  name="cmdCliente" value="..." onClick="click_cmdCliente();">
        </td>
	  </tr>
	  <tr>
        <td width="28%" class="textB" align="right">Contratto:&nbsp;&nbsp;</td>
        <td width="72%" class="text">
          <select class="text" title="Contratto" name="cboContratto" onchange="changeContratto();">
            <option class="text" value="">[Seleziona Opzione]</option>
            <option class="text" value="-2">&nbsp;</option>
            <option class="text" value="-3">&nbsp;</option>
            <option class="text" value="-4">&nbsp;</option>
            <option class="text" value="-5">&nbsp;</option>
            <option class="text" value="-6">&nbsp;</option>
            <option class="text" value="-7">&nbsp;</option>
            <option class="text" value="-8">&nbsp;</option>
            <option class="text" value="-9">&nbsp;</option>
            <option class="text" value="-10">&nbsp;</option>
          </select>
        </td>
      </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center" colspan="5">
            <sec:ShowButtons td_class="textB"/>
            <input type="hidden" name="codiceTipoContratto" value="<%=strCodiceTipoContratto%>">     
	        </td>
	      </tr>
	    </table> 
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>

