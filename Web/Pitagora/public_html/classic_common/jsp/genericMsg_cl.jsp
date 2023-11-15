<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="com.utl.*"%>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<%
String strMessage = request.getParameter("message");
String strDestinationURL = Misc.nh((String)session.getAttribute("URL_COM_TC"));
boolean blnContinua = Misc.bh(request.getParameter("CONTINUA"));
boolean blnChiudi_Popup = Misc.bh(request.getParameter("CHIUDI_POPUP"));
boolean blnChiudi_Aut_Popup = Misc.bh(request.getParameter("CHIUDI_AUT_POPUP"));

// MODIFICA DEL 26/04/2004
boolean blnChiudi = Misc.bh(request.getParameter("CHIUDI"));
//FINE MODIFICA

// modifica per reindirizzamento inizio
boolean blnContinua_InsTar = Misc.bh(request.getParameter("CONTINUA_INS_TAR"));
String strDestinationURL_InsTar = Misc.nh(request.getParameter("URL_InsTar"));

String intAction = Misc.nh(request.getParameter("intAction"));
String intFunzionalita = Misc.nh(request.getParameter("intFunzionalita"));
String hidViewState = Misc.nh(request.getParameter("hidViewState"));

if (blnContinua_InsTar) {
  strDestinationURL = strDestinationURL_InsTar;
}

// modifica per reindirizzamento fine



%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=request.getContextPath()%>/css/Style.css" TYPE="text/css">
<TITLE>Message Page</TITLE>
<script language="JavaScript">
	function onClick_btnContinua(){
    // modifica per reindirizzamento inizio
    // document.location.replace("<%=strDestinationURL%>");
    
    //document.lancioForm.action = "<%=request.getContextPath() + strDestinationURL%>";
    document.lancioForm.action = "<%=strDestinationURL%>";
    document.lancioForm.submit();
    // modifica per reindirizzamento fine
	}

	function onClick_btnChiudi_PopUp(){
		window.opener.dialogWin.returnFunc();
		window.parent.close();
	}
	
 
  
</script>
</HEAD>
<BODY bgColor="#ffffff" text="#000000"
<%if(blnChiudi_Popup){%>
	onunload="javascript:onClick_btnChiudi_PopUp();"
<%}%>>
<form name="lancioForm" action="" method="post">
<!--<form name="lancioForm" action="" method="get">-->
<input type="hidden" name="hidViewState" value="<%=hidViewState%>">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
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
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
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
                <TD class='white' align='center'>&nbsp;<%=strMessage%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white'>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE>
          </TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
          <TD><IMG align="right" src="../../common/images/body/log3.gif"></TD>
        </TR>
        <TR>
          <TD COLSPAN="5">&nbsp; </TD>
        </TR>
<%//modifica del 26/04/2004
if((blnContinua || blnChiudi_Popup || blnChiudi) && (!strDestinationURL.equals("")))
{//FINE MODIFICA
%>
        <TR>
          <TD bgColor="#ffffff" COLSPAN="5"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
        <tr>
          <td COLSPAN="5">
            <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
              <tr>
                <td align="center" nowrap>
				  <%if(blnChiudi_Popup){%>
					  <input class="textB" type="button" name="btnChiudi_PopUp" value="Chiudi" onclick="onClick_btnChiudi_PopUp()">
				  <%}%>
                  <%if(blnContinua){%>
					  <input class="textB" type="button" name="btnContinua" value="Continua..." onclick="onClick_btnContinua()">
				  <%}%>

      <%//MODIFICA DEL 26/04/2004
      if(blnChiudi){%>
					  <input class="textB" type="button" name="btnChiudi" value="Chiudi" onclick="window.close();">
				  <%}
        //FINE MODIFICA%>

                </td>
              </tr>
            </TABLE>
          </td>
        </tr>
<%
}
%>
      </TABLE>
    </TD>
  </TR>
  <tr><td>&nbsp;</td></tr>
  </TABLE>
</form>
<script language="JavaScript">

<%if(blnChiudi_Aut_Popup==true){%>
  setTimeout('self.close();',5000);
<%}%>  
</script>


</BODY>
</HTML>