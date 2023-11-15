<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%--<sec:ChkUserAuth isModal="true" />--%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"promozioneParamAdd.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCausaleSTL" type="com.ejbSTL.CausaleSTLHome" location="CausaleSTL" />
<EJB:useBean id="remoteCausaleSTL" type="com.ejbSTL.CausaleSTL" scope="session">
    <EJB:createBean instance="<%=homeCausaleSTL.create()%>" />
</EJB:useBean>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String descPromozione = "";
String codePromozione = Misc.nh(request.getParameter("code_promozione"));
String descOggFatrz = Misc.nh(request.getParameter("comboOggFatt"));
String dataInizioTariffa = Misc.nh(request.getParameter("dataInizioTariffa"));

PromozioniDett riga = new PromozioniDett();
riga = remoteCausaleSTL.getPromozioneParam(codePromozione);
descPromozione  = riga.getDescPromozione();

String data_ini_mmdd    = Utility.getDateMMDDYYYY();

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>
Aggiungi Promozione
</title>
</head>


<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<!-- NUOVO CALENDARIO -->
<script language="JavaScript" src="../../common/js/calendar.js"></script>
<script language="JavaScript" src="../../common/js/misc.js"></script>

<SCRIPT LANGUAGE='Javascript'>
var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";

function ONAGGIUNGI()
{
  var codePromozione = '';
  var descPromozione = '';
  var div = '';
  var dfv = '';
  var codeProgBill = '';
  var descOggFatrz = '';
  var divc = '';
  var dfvc = '';
  var numMesiCan = '';
  
  var dataInizioTariffa = '';
    
  codePromozione = document.formPag.codePromozione.value;
  descPromozione = document.formPag.descPromozione.value;
  div = document.formPag.data_ini_prom.value;
  dfv = document.formPag.data_fine_prom.value;
  codeProgBill = document.formPag.code_prog_bill.value;
  descOggFatrz = document.formPag.descOggFatrz.value;
  dataInizioTariffa = document.formPag.dataInizioTariffa.value;
  
  if(div == '')
  {
    alert('La data inizio validità della promozione è obbligatoria.');
    return;
  }
  if(dfv == '')
  {
    alert('La data fine validità della promozione è obbligatoria.');
    return;
  }
  /*
  if(!chkDataInizioFine(dataInizioTariffa,div))
  {
    alert('La data inizio validità della promozione deve essere maggiore o uguale della data inizio validità della tariffa.');
    return;
  }
  */
  if(descOggFatrz == 'Canone')
  {
    divc = document.formPag.data_ini_can.value;
    dfvc = document.formPag.data_fine_can.value;
    numMesiCan = document.formPag.mesi_canoni.value;
    if(divc == '' && dfvc == '' && numMesiCan == '')
    {
      alert('Selezionare la data inizio e fine validità canonio i mesi di validità canoni.');
      return;
    }
    if(divc == '' && dfvc != '')
    {
      alert('La data inizio validità canoni della promozione è obbligatoria.');
      return;
    }
    if(divc != '' && dfvc == '')
    {
      alert('La data fine validità canoni della promozione è obbligatoria.');
      return;
    }
    if(divc != '' && dfvc != '')
    {
      //controllo tra data inizio validità promozione e data inizio validità canoni
      if(!chkDataInizioFine(div,divc))
      {
        alert('La data inizio validità canoni deve essere maggiore o uguale della data inizio validità promozione.');
        return;
      }
      
      //controllo tra data inizio validità canoni e data fine validità canoni
      if(!chkDataInizioFine(divc,dfvc))
      {
        alert('La data fine validità canoni non può essere minore della data inizio validità canoni.');
        return;
      }
    }
  }
  
  window.opener.AggiungiPromozione(codePromozione,descPromozione,div,dfv,divc,dfvc,codeProgBill,numMesiCan);
  window.close();
}

</SCRIPT>

<BODY>
<form name="formPag" method="post">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../../tariffe/images/titoloPagina.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Aggiungi Promozione</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td colspan='2'>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Promozione</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
              <tr>
                <td colspan='4' class="textB" nowrap>&nbsp;<%=descPromozione%></td>
                <input type="hidden" name="codePromozione" value="<%=codePromozione%>">
                <input type="hidden" name="descPromozione" value="<%=descPromozione%>">
                <input type="hidden" name="descOggFatrz" value="<%=descOggFatrz%>">
                <input type="hidden" name="dataInizioTariffa" value="<%=dataInizioTariffa%>">
                <td align="left" class="textB" nowrap>&nbsp;Data inizio validità tariffa</td>
                <td nowrap>         
                  <input type="text" class="text" size="12" maxlength="12" name="data_ini_tariffa" title="Data inizio validità tariffa" readonly value="<%=dataInizioTariffa%>" onblur="handleblur('data_ini_tariffa');"> 
                </td>
              </tr>
              <tr>
                <td align="left" class="textB" nowrap>&nbsp;Data inizio validità</td>
                <td nowrap>         
                <%--
                  <input type="text" class="text" size="12" maxlength="12" name="data_ini_prom" title="Data inizio validità" readonly value="" onblur="handleblur('data_ini_prom');"> 
                  <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.formPag.data_ini_prom);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
                --%>
                  <input title="Data inizio" type="text" class="text" size="10" name="data_ini_prom" value="" />
                  <a href="javascript:showCalendar('formPag.data_ini_prom','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='calendario' src="../../common/images/body/calendario.gif" border="no"/></a>
                  <a href="javascript:cancelCalendar('formPag.data_ini_prom');" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a>
                </td>
                <td align="left" class="textB" nowrap>Data fine validità</td>
                <td nowrap>
                  <%--
                  <input type="text" class="text" size="12" maxlength="12" name="data_fine_prom" title="Data fine validità" readonly value="" onblur="handleblur('data_fine_prom');"> 
                  <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.formPag.data_fine_prom);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
                  --%>
                  <input title="Data Fine Validità" type="text" class="text" size="10" name="data_fine_prom" value="" />
                  <a href="javascript:showCalendar('formPag.data_fine_prom','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='calendario' src="../../common/images/body/calendario.gif" border="no"/></a>
                  <a href="javascript:cancelCalendar('formPag.data_fine_prom');" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a>
                </td>
                <td align="left" class="textB" nowrap>Cod. Progetto Bill</td>
                <td nowrap>
                  <input title="Codice Progetto Bill" type="text" class="text" size="12" name="code_prog_bill" value=""/>
                </td>
              </tr>
            <%
            if(descOggFatrz.equals("Canone")){
            %>
              <tr>
                <td align="left" class="textB" nowrap>&nbsp;Data inizio validità Canoni</td>
                <td nowrap>
                  <%--
                  <input type="text" class="text" size="12" maxlength="12" name="data_ini_can" title="Data inizio canone" readonly value="" onblur="handleblur('data_ini_can');"> 
                  <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.formPag.data_ini_can);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
                  --%>
                  <input title="Data Inizio Canone" type="text" class="text" size="10" name="data_ini_can" value="" />
                  <a href="javascript:showCalendar('formPag.data_ini_can','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='calendario' src="../../common/images/body/calendario.gif" border="no"/></a>
                  <a href="javascript:cancelCalendar('formPag.data_ini_can');" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a>
                </td>
                <td align="left" class="textB" nowrap>Data fine validità Canoni</td>
                <td nowrap>
                  <%--
                  <input type="text" class="text" size="12" maxlength="12" name="data_fine_can" title="Data fine canone" readonly value="" onblur="handleblur('data_ini_can');"> 
                  <a href="javascript:cal4.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
                  <a href="javascript:cancelCalendar(document.formPag.data_fine_can);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
                  --%>
                  <input title="Data Fine Canone" type="text" class="text" size="10" name="data_fine_can" value="" />
                  <a href="javascript:showCalendar('formPag.data_fine_can','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='calendario' src="../../common/images/body/calendario.gif" border="no"/></a>
                  <a href="javascript:cancelCalendar('formPag.data_fine_can');" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true">
                  <img width="24" name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a>
                </td>
                <td class="textB" align="left" nowrap>Mesi Canoni</td>
                <td nowrap>
                  <input type="TEXT" class="text" size="3" name="mesi_canoni" maxlength="6" value=""/>
                </td>
              </tr>
              <%}%>
            </table>
          </td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>

        <tr>
          <td align='center'>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td align='center'>
                  <input type='button' name='btnAggiungi' value='Aggiungi' onClick='ONAGGIUNGI();' class='textB'/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </TABLE>
    </td>
  </tr>
</table>
</form>
<%--
 <script language="JavaScript">
  var cal1 = new calendar1(document.forms['formPag'].elements['data_ini_prom']);
  cal1.year_scroll = true;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['formPag'].elements['data_fine_prom']);
  cal2.year_scroll = true;
  cal2.time_comp = false;
  <%
  if(descOggFatrz.equals("Canone")){
  %>
    var cal3 = new calendar1(document.forms['formPag'].elements['data_ini_can']);
    cal3.year_scroll = true;
    cal3.time_comp = false;
    var cal4 = new calendar1(document.forms['formPag'].elements['data_fine_can']);
    cal4.year_scroll = true;
    cal4.time_comp = false;
  <%}%>
  
 </script>
--%>
</body>
</html>
