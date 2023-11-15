<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_canc_tar_X_tipol_contr_cl.jsp")%>
</logtag:logData>

<%
	
	String strIntestazione="";
	String strCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	int intAction;
	if(request.getParameter("intAction") == null){
	  intAction = StaticContext.LIST;
	}else{
	  intAction = Integer.parseInt(request.getParameter("intAction"));
	}
	int intFunzionalita;
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
	
	switch (intAction){
		case StaticContext.LIST:
			strIntestazione="Lista Tariffe";
		break;
		case StaticContext.INSERT:
			strIntestazione="Inserimento Tariffe";
		break;
		case StaticContext.DELETE:
			strIntestazione="Eliminazione Tariffe";
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
<SCRIPT LANGUAGE="JavaScript">
var CodSel="";
var objForm;
function initialize()
{
	objForm = document.frmDati;
	DisableAllControls(objForm);
	Enable(objForm.cmdPS);
}

/*function handleReturnedValueCliente()
{
  var stringa="";
  var field;
  stringa=dialogWin.returnedValue;
  field=stringa.split("|");
  objForm.txtPS.value = "";
  Disable(objForm.cmdPS);
  objForm.cboPrestAgg.options[0].selected = true;
  Disable(objForm.cboPrestAgg);
  objForm.cboOggFat.options[0].selected = true;
  Disable(objForm.cboOggFat);
  objForm.cboTipoCaus.options[0].selected = true;
  Disable(objForm.cboTipoCaus);
  Disable(objForm.cmdPopolaLista);
  objForm.txtCliente.value = field[0];
  CodSel = field[1];
  Enable(objForm.cmdCliente);
  Enable(objForm.cboContratto);
}
*/
function handleReturnedValuePS()
{
  var field = dialogWin.returnedValue.split("|");
  objForm.PsSel.value=field[0];
  objForm.txtPS.value=field[1];
  Enable(objForm.cboPrestAgg);
}
function handleReturnedValuePrestAgg()
{
	if(dialogWin.state==0){//ANNULLATO
		Enable(objForm.cboOggFat);
  		Disable(objForm.cboTipoCaus);		
	}else{//ESEGUITO
  		Enable(objForm.cboOggFat);
		Disable(objForm.cboTipoCaus);		
	}
}
/*
function click_cmdCliente()
{
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
  stringa+="?nomeCombo=objForm.cboContratto";
  stringa+="&codiceTipoContratto=<%=strCodiceTipoContratto%>";
  stringa+="&intAction=<%=intAction%>";
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  openDialog(stringa, 569, 400, handleReturnedValueCliente);
}
*/
function selezionaPs()
{
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_cl.jsp"
  stringa+="?nomeCombo=objForm.cboPrestAgg"
  stringa+="&intAction=<%=intAction%>"
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  stringa+="&CodeContr="//+getComboValue(objForm.cboContratto)
  stringa+="&Cliente="//+objForm.txtCliente.value
  stringa+="&CodeCliente="//+CodSel
  stringa+="&Contratto="//+getComboText(objForm.cboContratto)
  stringa+="&hidCodiceTipoContratto=<%=strCodiceTipoContratto%>"
  stringa+="&hidDescTipoContratto=<%=strDescTipoContratto%>"
  stringa+="&parMostraCliente=no&parMostraContratto=no";
  openDialog(stringa, 569, 400,handleReturnedValuePS);
}

/*function changeContratto()
{
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
  stringa+="?nomeCombo=objForm.cboContratto";
  stringa+="&codiceTipoContratto=<%=strCodiceTipoContratto%>";
  stringa+="&intAction=<%=intAction%>";
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  index=objForm.cboContratto.selectedIndex;
  //objForm.hidDescContratto.value = getComboText(objForm.cboContratto);
  if (index==0)
  {
    objForm.txtPS.value="";
    Disable(objForm.cmdPS);
    objForm.cboPrestAgg.options[0].selected = true;
    Disable(objForm.cboPrestAgg);
    objForm.cboOggFat.options[0].selected = true;
    Disable(objForm.cboOggFat);
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    Disable(objForm.cmdPopolaLista);
  }
  else
    Enable(objForm.cmdPS);
}
*/
function changePrestAgg()
{
  index=objForm.cboPrestAgg.selectedIndex;
  if (index==0)
  {
    objForm.cboOggFat.options[0].selected = true;
    Disable(objForm.cboOggFat);
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    Disable(objForm.CONTINUA);
  }
  else
  {
	//popup cha carica gli oggetti di fatturazione
	var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_OggettiFatturazione_cl.jsp";
	strURL+="?intAction=<%=intAction%>";
	strURL+="&intFunzionalita=<%=intFunzionalita%>";
	strURL+="&nomeComboOggFat=objForm.cboOggFat";
	strURL+="&CodeTipoContratto=<%=strCodiceTipoContratto%>";
	strURL+="&CodeCliente="//+CodSel;
	strURL+="&CodeContr="//+getComboValue(objForm.cboContratto);
    strURL+="&CodePs="+objForm.PsSel.value;
	strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg)//.split("$")[0];
	strURL+="&CodeClasse=";
    openDialog(strURL, 400, 5,handleReturnedValuePrestAgg);
  }
}
function changeOggFat()
{
  if (getComboIndex(objForm.cboOggFat)==0)
  {
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    Disable(objForm.CONTINUA);
  }
  else{
  	//popup che carica i tipi causali
	var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_TipiCausale_cl.jsp";
	strURL+="?nomeComboTipoCaus=objForm.cboTipoCaus";
	strURL+="&intAction=<%=intAction%>";
	strURL+="&intFunzionalita=<%=intFunzionalita%>";
	strURL+="&CodePs="+objForm.PsSel.value;
	strURL+="&CodeCliente="//+CodSel;
	strURL+="&CodeContr="//+getComboValue(objForm.cboContratto);
	strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg)//.split("$")[0];
	strURL+="&CodeTipoContratto=<%=strCodiceTipoContratto%>";
	strURL+="&CodeOggFatt="+getComboValue(objForm.cboOggFat).split("$")[0];
    openDialog(strURL, 400, 5,handleReturnedValueOggFat);
  }
}
function handleReturnedValueOggFat(){
		Enable(objForm.cboTipoCaus);
}
function changeTipoCaus()
{
  index=objForm.cboTipoCaus.selectedIndex;
  //objForm.hidDescTipoCausale.value = getComboText(objForm.cboTipoCaus);
  if (index==0)
    Disable(objForm.CONTINUA);
  else
    Enable(objForm.CONTINUA);
}

function ONCONTINUA()
    {
        if (objForm.CONTINUA.disabled) 
        {
            window.alert('Attenzione selezionare Tipo Causale');
        }
        else
        {
			popolaViewState();
			objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_canc_tar_X_tipol_contr_2_cl.jsp";
			objForm.submit();
        }
    }
function popolaViewState(){
	updVS(objForm.viewState,"vsDescTipoContratto","<%=strDescTipoContratto%>");
	//updVS(objForm.viewState,"vsDescCliente",objForm.txtCliente.value);
	//updVS(objForm.viewState,"vsDescContratto",getComboText(objForm.cboContratto));
	updVS(objForm.viewState,"vsDescPS",objForm.txtPS.value);
	updVS(objForm.viewState,"vsDescPrestAgg",getComboText(objForm.cboPrestAgg));
	updVS(objForm.viewState,"vsDescOggFatt",getComboText(objForm.cboOggFat));
	updVS(objForm.viewState,"vsDescTipoCaus",getComboText(objForm.cboTipoCaus));
	updVS(objForm.viewState,"vsCodeTipoContratto","<%=strCodiceTipoContratto%>");
}
</SCRIPT>
<TITLE></TITLE>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="viewState" value="">

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
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
        <td width="30%" class="textB" align="right">P/S:&nbsp;&nbsp;</td>
        <td width="70%" class="text" colspan="3" nowrap>
          <input class="text" title="P/S"  type="text" maxlength="60" size="50" name="txtPS" value="">
          <input class="text" title="P/S"  type="button" maxlength="30" name="cmdPS" value="..." onClick="selezionaPs();">
        </td>
	  </tr>
	  <tr>
        <td width="30%" class="textB" align="right">Prestazione Aggiuntiva:&nbsp;&nbsp;</td>
        <td width="70%" class="text">
          <select class="text" title="Prestazione Aggiuntiva" name="cboPrestAgg" onchange="changePrestAgg();">
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
	  <tr>
        <td width="30%" class="textB" align="right">Oggetto Fatturazione:&nbsp;&nbsp;</td>
        <td width="70%" class="text">
          <select class="text" title="Ogg.Fatturazione" name="cboOggFat" onchange="changeOggFat();">
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
      <tr>
        <td width="30%" class="textB" align="right">Tipo Causale:&nbsp;&nbsp;</td>
        <td width="70%" class="text">
          <select class="text" title="Tipo Causale" name="cboTipoCaus" onchange="changeTipoCaus();">
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
            <input type=hidden name="PsSel" value="">
	        </td>
	      </tr>
	    </table> 
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>
