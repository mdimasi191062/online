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
  <%=StaticMessages.getMessage(3006,"rettifica_note.jsp")%>
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
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"  type="text/javascript"></SCRIPT>
</head>
<BODY  onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()"  >
<div id="ajax_res" style="visibility:hidden;display:none" >Server Date Time will replace thistext.
</div>



<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;

  var dialogWin = new Object();

//Make the XMLHttpRequest Object
var http = getHTTPObject();
function sendRequest(method, url){
if(method == 'GET'){
http.open(method,url,true);
http.onreadystatechange = handleResponse;
http.send(null);
}
}
function handleResponse(){
if(http.readyState == 4 && http.status == 200){
var response = http.responseText;
if(response){
document.getElementById("ajax_res").innerHTML = response;
}
}
}
  
  
  function ONCONFERMA(){
 
 //alert('@'+ frmSearch.strNoteRettifica.value +'@');
var appoNoteRettifica =frmSearch.strNoteRettifica.value;
 //alert("@" + appoNoteRettifica + "@" );
if (appoNoteRettifica != null){
appoNoteRettifica =trim(frmSearch.strNoteRettifica.value);
//alert('appoNoteRettifica@'+ appoNoteRettifica +'@');
 if(appoNoteRettifica==''){
       	if(!confirm('Attenzione! Nessuna nota inserita.\n\rVuoi proseguire?')){
            frmSearch.strNoteRettifica.focus();
            return;
         }   
      }


 
   if (appoNoteRettifica != '') {
  // alert(frmSearch.strNoteRettifica.value);
      sendRequest('GET','rettifica_note2.jsp?NoteRettifica='+frmSearch.strNoteRettifica.value);
      
   }


}

  window.close();
   

  
  }
  
function trim(stringa){
    while (stringa.substring(0,1) == ' '){
        stringa = stringa.substring(1, stringa.length);
    }
    while (stringa.substring(stringa.length-1, stringa.length) == ' '){
        stringa = stringa.substring(0,stringa.length-1);
    }
    return stringa;
} 
function ONCHIUDI(){  
if(!confirm('Attenzione! Nessuna nota inserita.\n\rVuoi proseguire?')){
            frmSearch.strNoteRettifica.focus();
            return;

}
  window.close();    
} 
</SCRIPT>


  <table align=center width="100%" border="0" cellspacing="0" cellpadding="0">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">INSERIMENTO NOTE</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<form name="frmSearch"  method="post" action="" target="_self">
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr height="50">
        <TD class="text" align="center">
        Note :
          <br>
        
         <textarea id="strNoteRettifica" name="strNoteRettifica"  rows="5" cols ="42" label="Note" Update="false"  >
        </textarea>
        </td>
     </TR> 
     <TR >
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