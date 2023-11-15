<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"GenericMsgSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String strMessage = Misc.nh(request.getParameter("message"));
//Modifica 11/11/02 inizio
//String strDestinationURL = request.getParameter("URL");
String strDestinationURL = Misc.nh((String)session.getAttribute("URL_COM_TC"));
boolean blnContinua = Misc.bh(request.getParameter("CONTINUA"));
//Modifica 11/11/02 fine
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">

<TITLE>Message Page</TITLE>


<SCRIPT LANGUAGE='Javascript'>
	function onClick_btnContinua(){
		document.location.replace("<%=strDestinationURL%>");
	}


</SCRIPT>

</HEAD>
<BODY bgColor="#ffffff" text="#000000">
<form name="lancioForm" action="GenericMsgSp.jsp" method="get">
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
<%
if(blnContinua && (!strDestinationURL.equals("")))
{
%>
        <TR>
          <TD bgColor="#ffffff" COLSPAN="5"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
        <tr>
          <td COLSPAN="5">
            <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
              <tr>
                <td align="center">
                  <input class="textB" type="button" name="btnContinua" value="Continua..." onclick="onClick_btnContinua()">
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
</BODY>
</HTML>