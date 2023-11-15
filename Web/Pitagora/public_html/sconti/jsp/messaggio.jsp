<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=request.getContextPath()%>/css/Style.css" TYPE="text/css">
<TITLE>Message Page</TITLE>
</HEAD>
<BODY bgColor="#ffffff" text="#000000">
<form name="lancioForm">
<BR>
<BR><!-- nuovo layout inizio -->
<TABLE border="0" cellPadding="0" cellSpacing="0" width="100%">
  <TR>
    <td valign="top"><img src="../../common/images/body/pixel.gif" width="6" height="10"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0" width="500">
        <TR>
          <TD vAlign="top" width="80"><IMG border="0" height="35" src="../../common/images/body/info.gif" width="80"></TD>
          <td width="420" valign="top"><img src="../../common/images/body/pixel.gif" width="420" height="35"></td>
        <TR>
      </TABLE>
      <TABLE bgColor="#ffffff" border="0" cellPadding="1" cellSpacing="0" width="502">
        <TR>
          <TD bgColor="#ffffff"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#006699" border="0" cellPadding="1" cellSpacing="0" width="502">
        <TR>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="502">
              <TR>
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; 
                Informazione</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="../../common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="502">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <TD class='white' align='center'>Attenzione!</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>&nbsp;<% out.println(request.getParameter("messaggio")); %></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white'>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE>
          </TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
          <TD><IMG align="right" src="../../common/images/body/log3.gif"></TD>
        </TR>
        <TR>
          <TD bgColor="#ffffff" COLSPAN="5"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
        <tr>
          <td COLSPAN="5">
            <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
              <tr>
                <td align="center">
                  <input class="textB" type="button" name="Indietro" value="Indietro" onclick = "window.history.back();">
                  <input class="textB" type="button" name="chiudi" value="Chiudi" onclick = "window.close();">
                </td>
              </tr>
            </TABLE>
          </td>
        </tr>
      </TABLE>
    </TD>
  </TR>
  <tr><td>&nbsp;</td></tr>
  </TABLE>
</form>


</BODY>
</HTML>