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
<%=StaticMessages.getMessage(3006,"cbn1_lista_ass_ofps_cl.jsp")%>
</logtag:logData>
<%
	
	String strIntestazione="";
	String strCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	int intAction;
	int intFunzionalita;
	
	if(request.getParameter("intAction") == null){
	  intAction = StaticContext.LIST;
	}else{
	  intAction = Integer.parseInt(request.getParameter("intAction"));
	}
	
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
	
	switch (intAction){
		case StaticContext.LIST:
			strIntestazione="Lista Associazioni OF/PS";
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
var objForm;
function initialize()
{
	objForm = document.frmDati;
	clearAllFields(objForm);
	DisableAllControls(objForm);
	Enable(objForm.cmdCliente);
	Enable(objForm.chkAssDisattive);
}

function change_txtCliente()
{
objForm.hidCodePS.value="";
}

function handleReturnedValueCliente()
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
  Disable(objForm.POPOLALISTA);
  objForm.txtCliente.value = field[0];
  objForm.hidCodeCliente.value = field[1];
  Enable(objForm.cmdCliente);
  Enable(objForm.cboContratto);
  Disable(objForm.POPOLALISTA);
}

function handleReturnedValuePS()
{
  var field = dialogWin.returnedValue.split("|");
  objForm.hidCodePS.value=field[0];
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

function click_cmdCliente()
{
//  MODIFICA DEL 28/04/2004
change_txtCliente();
//FINE MODIFICA
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
  stringa+="?nomeCombo=objForm.cboContratto";
  stringa+="&codiceTipoContratto=<%=strCodiceTipoContratto%>";
  stringa+="&intAction=<%=intAction%>";
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  openDialog(stringa, 569, 400, handleReturnedValueCliente);
}

function selezionaPs()
{
// MODIFICA DEL 28/04/2004
  objForm.cmdCANC.disabled=false;
// FINE MODIFICA
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_sel_ps_cl.jsp"
  stringa+="?nomeCombo=objForm.cboPrestAgg"
  stringa+="&intAction=<%=intAction%>"
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  stringa+="&CodeContr="+getComboValue(objForm.cboContratto)
  stringa+="&Cliente="+objForm.txtCliente.value
  stringa+="&CodeCliente="+objForm.hidCodeCliente.value
  stringa+="&Contratto="+getComboText(objForm.cboContratto)
  stringa+="&hidCodiceTipoContratto=<%=strCodiceTipoContratto%>"
  stringa+="&hidDescTipoContratto=<%=strDescTipoContratto%>"
  stringa+="&parMostraCliente=si&parMostraContratto=si";
  openDialog(stringa, 569, 400,handleReturnedValuePS);
}

function changeContratto()
{
  var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_cl.jsp";
  stringa+="?nomeCombo=objForm.cboContratto";
  stringa+="&codiceTipoContratto=<%=strCodiceTipoContratto%>";
  stringa+="&intAction=<%=intAction%>";
  stringa+="&intFunzionalita=<%=intFunzionalita%>";
  if(getComboValue(objForm.cboContratto)==""){
    objForm.txtPS.value="";
    Disable(objForm.cmdPS);
    objForm.cboPrestAgg.options[0].selected = true;
    Disable(objForm.cboPrestAgg);
    objForm.cboOggFat.options[0].selected = true;
    Disable(objForm.cboOggFat);
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    Disable(objForm.POPOLALISTA);
  }
  else{
    Enable(objForm.cmdPS);
	Enable(objForm.POPOLALISTA);
  }
}

function changePrestAgg()
{
  if(getComboValue(objForm.cboPrestAgg)==""){
  
    objForm.cboOggFat.options[0].selected = true;
    Disable(objForm.cboOggFat);
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    /*
    MODIFICA DEL 28/04/2004
      Disable(objForm.POPOLALISTA);
    */
  }
  else
  {
  //MODIFICA DEL 28/04/2004
  Enable(objForm.POPOLALISTA);
  //FINE MODIFICA
	//popup cha carica gli oggetti di fatturazione
	var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_OggettiFatturazione_cl.jsp";
	strURL+="?intAction=<%=intAction%>";
	strURL+="&intFunzionalita=<%=intFunzionalita%>";
	strURL+="&nomeComboOggFat=objForm.cboOggFat";
	strURL+="&CodeTipoContratto=<%=strCodiceTipoContratto%>";
	strURL+="&CodeCliente="+objForm.hidCodeCliente.value;
	strURL+="&CodeContr="+getComboValue(objForm.cboContratto);
    strURL+="&CodePs="+objForm.hidCodePS.value;
	strURL+="&CodePrestAgg="+getComboValue(objForm.cboPrestAgg)//.split("$")[0];
	strURL+="&CodeClasse=";
    openDialog(strURL, 400, 5,handleReturnedValuePrestAgg);
  }
}
function changeOggFat()
{
if(getComboIndex(objForm.cboOggFat)==0){
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    /*
    MODIFICA DEL 28/04/2004
    Disable(objForm.POPOLALISTA);
    */
  }
  else{
  //MODIFICA DEL 28/04/2004
  Enable(objForm.POPOLALISTA);
  //FINE MODIFICA
  	//popup che carica i tipi causali
	var strURL="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Combo_TipiCausale_cl.jsp";
	strURL+="?nomeComboTipoCaus=objForm.cboTipoCaus";
	strURL+="&intAction=<%=intAction%>";
	strURL+="&intFunzionalita=<%=intFunzionalita%>";
	strURL+="&CodePs="+objForm.hidCodePS.value;
	strURL+="&CodeCliente="+objForm.hidCodeCliente.value;
	strURL+="&CodeContr="+getComboValue(objForm.cboContratto);
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
/*
  MODIFICA DEL 28/04/2004
  if(getComboValue(objForm.cboTipoCaus)=="")
    Disable(objForm.POPOLALISTA);
  else*/
  
    Enable(objForm.POPOLALISTA);
}
function ONPOPOLALISTA()
    {
			popolaviewState();
// MODIFICA DEL 28/04/2004
			//objForm.action="cbn1_lista_ass_ofps_2_cl.jsp";
        //    objForm.submit();
        var URLstringa = "cbn1_lista_ass_ofps_2_cl.jsp?viewStateRicerca="+ objForm.viewStateRicerca.value;
        openDialog(URLstringa , 640 , 480 , "" , "" );
//FINE MODIFICA
    }
function popolaviewState(){
	//
	updVS(objForm.viewStateRicerca,"vsRicIntAction","<%=intAction%>");
	updVS(objForm.viewStateRicerca,"vsRicIntFunzionalita","<%=intFunzionalita%>");
	//CODICI
	updVS(objForm.viewStateRicerca,"vsRicCodeTipoContratto","<%=strCodiceTipoContratto%>");
	updVS(objForm.viewStateRicerca,"vsRicCodeCliente",objForm.hidCodeCliente.value);
	updVS(objForm.viewStateRicerca,"vsRicCodeContratto",getComboValue(objForm.cboContratto));
	updVS(objForm.viewStateRicerca,"vsRicCodePS",objForm.hidCodePS.value);
	updVS(objForm.viewStateRicerca,"vsRicCodePrestAgg",getComboValue(objForm.cboPrestAgg));
	updVS(objForm.viewStateRicerca,"vsRicCodeOggFatt",getComboValue(objForm.cboOggFat));
	updVS(objForm.viewStateRicerca,"vsRicCodeTipoCaus",getComboValue(objForm.cboTipoCaus));
	//DESCRIZIONI
	updVS(objForm.viewStateRicerca,"vsRicDescTipoContratto","<%=strDescTipoContratto%>");
	updVS(objForm.viewStateRicerca,"vsRicDescCliente",objForm.txtCliente.value);
	updVS(objForm.viewStateRicerca,"vsRicDescContratto",getComboText(objForm.cboContratto));
	updVS(objForm.viewStateRicerca,"vsRicDescPS",objForm.txtPS.value);
	if(getComboValue(objForm.cboPrestAgg)==""){
		updVS(objForm.viewStateRicerca,"vsRicDescPrestAgg","");
	}else{
		updVS(objForm.viewStateRicerca,"vsRicDescPrestAgg",getComboText(objForm.cboPrestAgg));
	}
	if(getComboIndex(objForm.cboOggFat)==0){
		updVS(objForm.viewStateRicerca,"vsRicDescOggFatt","");
	}else{
		updVS(objForm.viewStateRicerca,"vsRicDescOggFatt",getComboText(objForm.cboOggFat));
	}
	if(getComboValue(objForm.cboTipoCaus)==""){
		updVS(objForm.viewStateRicerca,"vsRicDescTipoCaus","");
	}else{
		updVS(objForm.viewStateRicerca,"vsRicDescTipoCaus",getComboText(objForm.cboTipoCaus));
	}
		
	//Code Ass Disattive
	if(objForm.chkAssDisattive.checked == true){
		updVS(objForm.viewStateRicerca,"vsRicMostraAssocDisattive","S");
	}else{
		updVS(objForm.viewStateRicerca,"vsRicMostraAssocDisattive","N");
	}
}
//MODIFICA DEL 28/04/2004
function CancellaPs()
{
    objForm.cboPrestAgg.options[0].selected = true;
    Disable(objForm.cboPrestAgg);
    objForm.cboOggFat.options[0].selected = true;
    Disable(objForm.cboOggFat);
    objForm.cboTipoCaus.options[0].selected = true;
    Disable(objForm.cboTipoCaus);
    objForm.hidCodePS.value="";
    objForm.txtPS.value="";
}
//FINE MODIFICA
</SCRIPT>
<TITLE>Selezione Tipo Contratto</TITLE>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" method="post" action=>
<!-- <input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="codiceTipoContratto" value="<%=strCodiceTipoContratto%>"> -->
<input type=hidden name="hidCodePS" value="">
<input type=hidden name="hidCodeCliente" value="">
<input type="hidden" name="viewStateRicerca" value="">
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_ASSOCIAZIONIOFPS_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <!-- <tr>
	<td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>tariffeTitolo.gif" alt="" border="0"></td>
  <tr> -->
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
        <td width="28%" class="textB" align="right">Cliente:&nbsp;</td>
        <td width="72%" class="text">
          <input class="text" title="Cliente" type="text" size="40" maxlength="30" name="txtCliente" value="" onchange="change_txtCliente()">
          <input class="text" title="Cliente" type="button" maxlength="30" name="cmdCliente" value="..." onClick="click_cmdCliente();">
        </td>
	  </tr>
	  <tr>
        <td width="28%" class="textB" align="right">Contratto:&nbsp;</td>
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
      <tr>
        <td width="28%" class="textB" align="right">P/S:&nbsp;</td>
        <td width="72%" class="text">
          <input class="text" title="P/S"  type="text" size="40" maxlength="30" name="txtPS" value="">
          <input class="text" title="P/S"  type="button" maxlength="30" name="cmdPS" value="..." onClick="selezionaPs();">
          <%//MODIFICA DEL 28/04/2004%>
            <input class="text" type="button" maxlength="30" name="cmdCANC" value="Cancella" onClick="CancellaPs();">
          <%//fine modifica%>
        </td>
      </tr>
      <tr>
        <td width="28%" class="textB" align="right">Prestazione Aggiuntiva:&nbsp;</td>
        <td width="72%" class="text">
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
        <td width="28%" class="textB" align="right">Oggetto Fatturazione:&nbsp;</td>
        <td width="72%" class="text">
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
        <td width="28%" class="textB" align="right">Tipo Causale:&nbsp;</td>
        <td width="72%" class="text">
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
	  <tr>
        <td width="28%" height="30" class="textB">&nbsp;</td>
		<td width="72%" height="30" class="text"><input type="checkbox" name="chkAssDisattive" value="S">&nbsp;Mostra anche associazioni disattive</td>
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
            <!--<input class="textB" type="button" name="TipoContr" value="Indietro" onClick="history.back();">-->
            <!-- <input class="textB" type="button" name="POPOLALISTA" value="POPOLA LISTA" onClick="ONPOPOLALISTA(this);"> -->
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
