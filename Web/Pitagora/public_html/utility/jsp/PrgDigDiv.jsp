<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"PrgDigDiv.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String all_JPUBS = "";
String all_JPUB2 = "";
%>

<EJB:useHome id="homeAccountElabSTL" type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
<EJB:useBean id="remoteAccountElabSTL" type="com.ejbSTL.AccountElabSTL" scope="session">
    <EJB:createBean instance="<%=homeAccountElabSTL.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive"/>
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
  <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>"/>
</EJB:useBean>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<script language="JavaScript" src="../../common/js/misc.js"></script>

<SCRIPT LANGUAGE='Javascript'>

function ONLANCIOBATCH()
{
  //Disable(formPag.LANCIOBATCH);
  numero = document.getElementById("txtAnno").value;
  if ((document.formPag.txtAnno.value != '') && (!isNaN(numero))) {
    var parametri = "anno="+document.formPag.txtAnno.value;
 
    var URL = "PrgDigDiv2.jsp?"+parametri; 
    openCentral(URL,'Action','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
  }else{
    alert("Digitare l'anno di elaborazione (valore numerico)!");
  }
}



</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>
Progetto Digital Divide
</title>
</head>

<BODY>
<form name="formPag" method="post">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../../utility/images/PrgDigDiv.gif" alt="" border="0"></td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Progetto Digital Divide</td>
                    
                 </tr>
                </table>
              </td>
	   </tr>
           <tr bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <td class="textB" width="20%">Anno elaborazione: </td>
              <td  class="text" align="left"  width="20%">
                <input class="textNumber" type='text' size="5" name='txtAnno' obbligatorio="si" value=''  maxlenght="4">
              </td>
              <td  class="text" align="left" width="20%"></td>
              <td  class="text" align="left" width="20%"></td>
              <td  class="text" align="left" width="20%"></td>
           </tr>
      </table>
    </td>
  </tr>  
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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

<script language="Javascript">
Enable(formPag.LANCIABATCH);
</script>

</body>
</html>
