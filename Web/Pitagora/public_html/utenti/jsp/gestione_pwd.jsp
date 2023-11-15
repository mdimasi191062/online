<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"gestione_pwd.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
 
  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String CODE_UTENTE = aUserInfo.getUserName();
  String strChkScadPwd = request.getParameter("ChkScadPwd");  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/password.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function ONCONFERMA()
{ 
  if(document.frmDati.CODE_PWD_OLD.value.length==0)
  {
    alert('La vecchia password è obbligatoria.');
    document.frmDati.CODE_PWD_OLD.focus();
    return;
  }
  if(document.frmDati.CODE_PWD_NEW.value.length==0){
    alert('La nuova password è obbligatoria.');
    document.frmDati.CODE_PWD_NEW.focus();
    return;
  }
  if(document.frmDati.VERIFICA_PWD.value.length==0){
    alert('La verifica password è obbligatoria.');
    document.frmDati.VERIFICA_PWD.focus();
    return;
  }  
  if(document.frmDati.CODE_PWD_NEW.value!=document.frmDati.VERIFICA_PWD.value)
  {
    alert('La nuova password e la verifica devono essere uguali.');
    document.frmDati.VERIFICA_PWD.focus();
    return;
  }

  if(!checkPassword(document.frmDati.CODE_PWD_NEW.value,false))
  {
    return;
  }
  document.CryptoApplet.setData(document.frmDati.CODE_UTENTE.value,document.frmDati.CODE_PWD_OLD.value);
  var vecchiaPwd = document.frmDati.APPO_PWD.value;
  document.CryptoApplet.setData(document.frmDati.CODE_UTENTE.value,document.frmDati.CODE_PWD_NEW.value);
  var nuovaPwd = document.frmDati.APPO_PWD.value;
  
  window.location.href="salva_pwd.jsp?ChkScadPwd=<%=strChkScadPwd%>&CODE_PWD_NEW=" + nuovaPwd + "&CODE_PWD_OLD=" + vecchiaPwd
}

function risposta(valore) 
{
    document.frmDati.APPO_PWD.value = valore;
}

function ONANNULLA()
{
     document.frmDati.reset();
}     



</SCRIPT>
<TITLE>Gestione Password</TITLE>
</HEAD>
<BODY onload="">
   <APPLET CODE="com.applet.CryptoApplet.class" NAME="CryptoApplet" ARCHIVE="jar.jar"  CODEBASE="../../" HEIGHT="0" WIDTH="0" MAYSCRIPT>
    </APPLET>
  <!-- Gestione navigazione-->
<form name="frmDati" action="salva_pwd.jsp">
<table align='center' width="60%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/modificapass.gif" alt="" border="0"></td>
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Gestione Password</td>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="left">Utente:</td>
        <TD  class='textB'><%=CODE_UTENTE%></TD>
        <td  class="text" align="left"><input type="hidden" name="CODE_UTENTE" value="<%=CODE_UTENTE%>"></td>                      
      </tr>   
      <tr>
        <td  class="textB" align="left">Vecchia Password:</td>
        <td  class="text" align="left"><input class="text" type="password" style="margin-left: 1px;text-transform:uppercase" name="CODE_PWD_OLD" maxlength="20" size="20" value="" onblur="this.value=this.value.toUpperCase();"></td>                
      </tr>   
      <tr>
        <td  class="textB" align="left">Nuova Password:</td>
        <td  class="text" align="left"><input class="text" type="password" style="margin-left: 1px;text-transform:uppercase" name="CODE_PWD_NEW" maxlength="20" size="20" value="" onblur="this.value=this.value.toUpperCase();"></td>                        
      </tr>
      <tr>
        <td  class="textB" align="left">Verifica Password:</td>
        <td  class="text" align="left"><input class="text" type="password" style="margin-left: 1px;text-transform:uppercase" name="VERIFICA_PWD" maxlength="20" size="20" value="" onblur="this.value=this.value.toUpperCase();">
        <input type="hidden" name="APPO_PWD"></td>                
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
          <td class="textB" bgcolor="#D5DDF1" align="center" colspan="5">
           <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>