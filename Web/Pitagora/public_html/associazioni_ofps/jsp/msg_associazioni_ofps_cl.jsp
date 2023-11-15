<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"msg_associazioni_ofps_cl.jsp")%>
</logtag:logData>
<%
	String strValuesDati = Misc.nh(request.getParameter("viewStateDati"));
	String strValuesRicerca = Misc.nh(request.getParameter("viewStateRicerca"));
	String strUrlToReturn = Misc.nh(request.getParameter("url"));
	String strMsg = Misc.nh(request.getParameter("msg"));
%>
<html>
<head>
	<title>MSG</title>
	<link rel="STYLESHEET" type="text/css" HREF="<%=StaticContext.PH_CSS%>Style.css">
	<script language="JavaScript">
		function click_cmdOk()
		{
			var objForm = document.frmDati;
			objForm.action='<%=strUrlToReturn%>';
			objForm.submit();
		}
	</script>
</head>
<body>
<form name="frmDati" method="post" action = "">
<input type="hidden" name="viewStateDati" value="<%=strValuesDati%>">
<input type="hidden" name="viewStateRicerca" value="<%=strValuesRicerca%>">
<!-- nuovo -->
<BR><!-- nuovo layout inizio -->
<TABLE align="center" border="0" cellPadding="0" cellSpacing="0" width="100%">
  <TR>
    <td valign="top"><img src="<%=request.getContextPath()%>/common/images/body/pixel.gif" width="6" height="10"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0">
        <TR>
          <TD vAlign="top"><IMG border="0" src="<%=request.getContextPath()%>/common/images/body/messaggioTitolo.gif"></TD>
        <TR>
      </TABLE>
      <TABLE bgColor="#ffffff" border="0" cellPadding="1" cellSpacing="0" width="602">
        <TR>
          <TD bgColor="#ffffff"><IMG height="3" src="<%=request.getContextPath()%>/common/images/body/pixel.gif" width="1"></TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#006699" border="0" cellPadding="1" cellSpacing="0" width="602">
        <TR>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="602">
              <TR>
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; Messaggio</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="<%=request.getContextPath()%>/common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="600" height="150">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <TD class='white' colspan='2' align='center'><%=strMsg%></TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE>
          </TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
        </TR>
		<TR>
		  <td colspan="4" NOWRAP align="CENTER" >
            <input class="textB" type="button" name="cmdOK" value="OK" onClick = "click_cmdOk();">
          </td>
		 </TR>
      </TABLE>
    </TD>
  </TR>
</TABLE>
<!-- fine nuovo -->
</form>
</body>
</html>
