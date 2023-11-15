<%@ page import="com.utl.Misc" %>
<%
String username= Misc.nh(request.getParameter("USERNAME"));
String sistema = Misc.nh(request.getParameter("SISTEMA"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>Profile Services</TITLE>
  <META content="text/html; charset=windows-1252" http-equiv=Content-Type>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  <LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
</HEAD>
<BODY bgColor="#ffffff" text="#000000" onLoad="if ('Navigator' == navigator.appName) document.forms[0].reset();">
<BR>
<BR><!-- nuovo layout inizio -->
<%--<FORM method="post" ACTION="<%=request.getContextPath()%>/SendMail">--%>
<FORM method="post" ACTION="">
<TABLE border="0" cellPadding="0" cellSpacing="0" width="100%">
  <TR>
    <td valign="top"><img src="../../common/images/body/pixel.gif" width="6" height="10"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0" width="500">
        <TR>
          <TD vAlign="top" width="80"><IMG border="0" height="35" src="../../common/images/body/login.gif" width="80"></TD>
        <TR>
      </TABLE>
      <TABLE bgColor="#ffffff" border="0" cellPadding="1" cellSpacing="0" width="502">
        <TR>
          <TD bgColor="#ffffff"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#8C96B4" border="0" cellPadding="1" cellSpacing="0" width="502">
        <TR>
          <TD>
            <TABLE bgColor="#8C96B4" border="0" cellPadding="0" cellSpacing="0" width="502">
              <TR>
                <TD bgColor="#8C96B4" class="white" vAlign="top" width="88%">&nbsp; Info</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="../../common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#8C96B4" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <TD class='white' colspan='2' align='center'>Attenzione!</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>L'utente non dispone delle autorizzazioni necessarie </TD>
                <TD class='white' align='center'>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>per accedere ai sistema <b><%= sistema %></b>.</TD>
                <TD class='white' align='center'>&nbsp;</TD>
              </TR>
                <%
                if(sistema.equals("TELECOMITALIA")){
                %>
                    <TR>
                      <TD class='white' align='center'>Si prega di verificare Username e Password.</TD>
                      <TD class='white' align='center'>&nbsp;</TD>
                    </TR>
                <%
                }
                %>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <%--<TR>
                <TD class='white' align='center'>Per richiedere la registrazione inviare</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>un'e-mail all'amministratore</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>--%>

            </TABLE>
          </TD>
          <TD>&nbsp;</TD>
          <TD><IMG align="right" src="../../common/images/body/log3.gif"></TD>
        </TR>
			  <tr>
				<td colspan='2' align="CENTER" >
				  <%--<input class='textB' type="submit" value="Invia E-mail">--%>
				  <input class='textB' type="hidden" name="USERNAME" value="<%=username%>">
          <input class='textB' type="hidden" name="SISTEMA" value="<%=sistema%>">
          <input class='textB' type="hidden" name="ERRORE" value="AUTENTICAZIONE">
				</td>
			  </tr>
        <TR>
          <TD COLSPAN="2">&nbsp; </TD>
        </TR>
      </TABLE>
    </TD>
  </TR>
</TABLE>
</FORM>
</BODY>
  <HEAD>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="-1">
  </HEAD>
</HTML>