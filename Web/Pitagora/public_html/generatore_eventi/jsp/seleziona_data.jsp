<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"seleziona_data.jsp")%>
</logtag:logData>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_EVENTI_JS%>generatoreEventi.js" type="text/javascript"></script>
</head>
<BODY  onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">
<%
DataFormat dataOdierna = new DataFormat();

  %>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;

  var dialogWin = new Object();
  
  function ONSELEZIONA(){
  
      var URL='';
      if(frmSearch.strDataElaborazione.value==''){
            alert('Occorre Specificare la data di elaborazione.');
            frmSearch.strDataElaborazione.focus();
            return;
      }
    var URLstringa = "crea_evento.jsp";
    var URLparam = "?DataCreaz=" + frmSearch.strDataElaborazione.value;

    frmSearch.action = URLstringa + URLparam;
    //alert( frmSearch.action);
    setTimeout('window.opener.ChiudiCallParentWindowFunction();frmSearch.submit(); ',1100);
 //frmSearch.submit();
  }
</SCRIPT>


  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="../images/GeneratoreEventi.gif" alt="" border="0"></td>
    </tr>
  </table>
  <BR>
  	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">SELEZIONA DATA PER RETTIFICA</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<form name="frmSearch"  method="post" action="">
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr height="70">
        <TD class="text" align="center">
          <br>
        Data di elaborazione:
         <INPUT class="text" id="strDataElaborazione" name="strDataElaborazione" readonly obbligatorio="si" tipocontrollo="data" label="Data Elaborazione" Update="false" size="13" value="<%=dataOdierna.getDate()%>">
         <a href="javascript:showCalendar('frmSearch.strDataElaborazione','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
         <a href="javascript:clearField(frmSearch.strDataElaborazione);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
        </td>
     <TR  height="30">
        <TD>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr align="center" >
            <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
              <sec:ShowButtons td_class="textB"/>
            </td>
          </tr>
        </table>
        </TD>
      </TR>
    </table>
</form>
</body>
</html>