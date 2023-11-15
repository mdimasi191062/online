<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%--<sec:ChkUserAuth isModal="true" />--%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"dettaglioPromozioneAdd.jsp")%>
</logtag:logData>

<%

String codePromozione = Misc.nh(request.getParameter("codePromozione"));
String descPromozione = Misc.nh(request.getParameter("descPromozione"));
String div = Misc.nh(request.getParameter("div"));
String dfv = Misc.nh(request.getParameter("dfv"));
String divc = Misc.nh(request.getParameter("divc"));
String dfvc = Misc.nh(request.getParameter("dfvc"));
String cpb = Misc.nh(request.getParameter("cpb"));
String numMesi = Misc.nh(request.getParameter("numMesi"));

%>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<!-- NUOVO CALENDARIO -->
<script language="JavaScript" src="../../common/js/calendar1.js"></script>

<SCRIPT LANGUAGE='Javascript'>

function ONCHIUDI()
{
  window.close();
}

</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>
Promozione Associata
</title>
</head>

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Promozione Associata</td>
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
                <td colspan='6' class="textB">&nbsp;<%=descPromozione%></td>
              </tr>
              <tr>
                <td align="left" class="textB">&nbsp;Data inizio validità</td>
                <td>         
                  <input title="Data inizio" type="text" class="text" size="12" name="data_ini_prom" value="<%=div%>" readonly/>
                </td>
                <td align="left" class="textB">Data fine validità</td>
                <td>
                  <input title="Data inizio" type="text" class="text" size="12" name="data_fine_prom" value="<%=dfv%>" readonly/>
                </td>
                <td align="left" class="textB">Cod. Progetto Bill</td>
                <td>
                  <input title="Codice Progetto Bill" type="text" class="text" size="12" name="code_prog_bill" value="<%=cpb%>" readonly/>
                </td>
              </tr>
              <%
              if((divc != null && !divc.equals("")) || (numMesi!= null && !numMesi.equals(""))){
              %>
              <tr>
                <td align="left" class="textB">&nbsp;Data inizio validità Canoni</td>
                <td>
                  <input title="Data inizio" type="text" class="text" size="12" name="data_ini_can" value="<%=divc%>" readonly/>
                </td>
                <td align="left" class="textB">Data fine validità Canoni</td>
                <td>
                  <input title="Data inizio" type="text" class="text" size="12" name="data_fine_can" value="<%=dfvc%>" readonly/>
                </td>
                <td class="textB" align="left">Mesi Canoni</td>
                <td>
                  <input type="TEXT" class="text" size="3" name="mesi_canoni" maxlength="6" value="<%=numMesi%>" readonly/>
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
                  <input type='button' name='btnIndietro' value='Chiudi' onClick='ONCHIUDI();' class='textB'/>
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
</body>
</html>
