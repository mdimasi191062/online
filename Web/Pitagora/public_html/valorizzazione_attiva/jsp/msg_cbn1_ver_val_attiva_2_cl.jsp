<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="com.utl.*"%>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<html>
<head>
	<title>MSG</title>
	<link rel="STYLESHEET" type="text/css" HREF="<%=StaticContext.PH_CSS%>Style.css">
</head>
<body>
<form name="frmDati" method="post" action = "">
<!-- Immagine Titolo -->
<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_VALORIZZAZIONEATTIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Messaggio</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
     <tr>
         <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
		 	<%=request.getParameter("msg")%>
         </td>
     </tr> 
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
     <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
         <!-- <input class="textB" type="button" name="cmdOK" value="OK" onClick = "click_cmdOk();"> -->
     </td>
   </tr>
</table>	
</form>
</body>
</html>
