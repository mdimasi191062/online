<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_switch_ins_upd_cl.jsp")%>
</logtag:logData>

<%
String strCodeTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String strDescTipoContrato = Misc.nh(request.getParameter("hidDescTipoContratto"));

%>
<html>
<head>
	<title></title>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<script src="../../common/js/inputValue.js" type="text/javascript"></script>
	<script language="JavaScript">
		var objForm = null;
		function initialize()
		{
			objForm = document.frmDati;
			click_rdoScelta();
		}
		function click_cmdAggiorna()
		{
			objForm.action = "SwitchModificaXTipologia_cl.jsp";
			objForm.intFunzionalita.value = "3";
			objForm.intAction.value = "2";
			objForm.submit();
		}
		
		function click_cmdElimina()
		{
			objForm.action = "cbn1_canc_tar_X_tipol_contr_cl.jsp";
			objForm.intFunzionalita.value = "1";
			objForm.intAction.value = "4";
			objForm.submit();
		}
		
		function click_rdoScelta(){
			var strScelta = getRadioButtonValue(objForm.rdoScelta);
			switch(strScelta){
				case "MODIFICA":
					objForm.action = "SwitchModificaXTipologia_cl.jsp";
					objForm.intFunzionalita.value = "3";
					objForm.intAction.value = "2";
					break;
				case "ELIMINA":
					objForm.action = "cbn1_canc_tar_X_tipol_contr_cl.jsp";
					objForm.intFunzionalita.value = "1";
					objForm.intAction.value = "4";
					break;
			}
			
		}
		
		function click_cmdConferma(){
			objForm.submit();
		}
	
	</script>
</head>

<body onload="initialize()">
<form name="frmDati" action="" method="post">
<input type="hidden" name="codiceTipoContratto" value="<%=strCodeTipoContratto%>">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContrato%>">
    <input type="hidden" name="intFunzionalita" value="">
    <input type="hidden" name="intAction" value="">
    <table align='center' width="70%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
      <tr>
    </table>

    <table align='center' width="70%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Agggiorna/Elimina 
                    Tariffa per Tipologia di Contratto: <%=strDescTipoContrato%></td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                      <img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <table align='center' width="50%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
        <td colspan="3" bgcolor="#ffffff"><img src="../../common/imges/body/pixel.gif" width="1" height="3"></td>
      </tr>
      <tr>
        <td colspan="3" align="left" class="textB">Proseguire con:</td>
      </tr>
      <tr>
        <td width="30%" class="textB">&nbsp;</td>
        <td width="1%"><input checked type="radio" name="rdoScelta" value="MODIFICA" onclick="click_rdoScelta()"></td>
        <td class="textB">Aggiornamento Tariffa</td>
      </tr>
      <tr>
        <td width="30%" class="textB">&nbsp;</td>
        <td width="1%"><input type="radio" name="rdoScelta" value="ELIMINA" onclick="click_rdoScelta()"></td>
        <td class="textB">Eliminazione Tariffa</td>
      </tr>
      <tr>
        <td colspan="3" bgcolor="#ffffff"><img src="../../common/imges/body/pixel.gif" width="1" height="3"></td>
      </tr>
    </table>
    <table align='center' width="70%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
        <td colspan="3" align="center">
          <input class="textB" type="button" name="cmdConferma" value="Conferma" onclick="click_cmdConferma()">
        </td>
      </tr>
    </table>
  </form>

  </body>
</html>
