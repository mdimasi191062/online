<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"inserisci_codice_gestore.jsp")%>
</logtag:logData>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
//  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");


  String CODE_GEST_ORIG = request.getParameter("CODE_GEST_ORIG");
  String CODE_GEST = request.getParameter("CodSel");
  String FLAG_SYS = request.getParameter("FLAG_SYS");
  
                

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script language="javascript">
function ONANNULLA()
{
   window.close();
}   
function ONCONFERMA()
{
      if(document.forms[0].CODE_GEST.value.length==0)
      {
        alert("Il codice deve essere valorizzato!");
        document.forms[0].CODE_GEST.focus();
        return;
      }
      document.forms[0].submit();
}   
</script>
</HEAD>
<BODY>
<form name="frmDati" method="post" action='inserisci_gestore.jsp?<%=strQueryString%>'>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/gestgestnorm.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Inserimento Nuovo Gestore</td>
						  <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
						</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="left">Codice Nuovo Gestore:</td>
        <td  class="text" align="left">
                <input type="text" class="text" name="CODE_GEST" maxlength="3" size="10" value="<%=CODE_GEST_ORIG%>">
                <input type="hidden" name="CODE_GEST_ORIG" value="<%=CODE_GEST_ORIG%>">
                <input type="hidden" name="FLAG_SYS" value="<%=FLAG_SYS%>">
        </td>                
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='10'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>

</BODY>
</HTML>


















