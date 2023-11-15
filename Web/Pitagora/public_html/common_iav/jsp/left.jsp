<%@ taglib uri="/webapp/sec" prefix="sec" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Final//EN">
<%  
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String isAuthenticated=(String)request.getParameter("authenticated");
  if (isAuthenticated==null)
    isAuthenticated="";
%>

<HTML>
<HEAD>
	<TITLE>Telecom</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/security.js"></SCRIPT>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
</head>

<BODY LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>

<%
  if (isAuthenticated.equals("T"))
  {  
%>
  <sec:ChkUserAuth />
  <div style="position:absolute; left:0; top:0"><img src="../images/left/bg.gif" width="149" height="490" alt="" border="0"></div>
  <APPLET CODE="com.applet.Tree.class" ARCHIVE="jar.jar" HEIGHT="490" WIDTH="149" ALIGN="right" vspace="0" hspace="7" CODEBASE="../../">
  <PARAM NAME="sizey" VALUE="490">
  <PARAM NAME="sizex" VALUE="149"></APPLET>
<%
  }
  else
  {
%>
    <div style="position:absolute; left:0; top:0"><img src="../images/left/bg2.gif" width="156" height="884" alt="" border="0"></div>
<%
  }
%>


</body>
</html>