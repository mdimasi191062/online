<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String message=(String)request.getParameter("message");
  if (message==null)
    message="";
%>
<html>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/security.js"></SCRIPT>
</HEAD>

<script language="javascript">
if (document.all)
{
document.write('<frameset  rows="120,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="top" src="../jsp/top.jsp" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frameset  cols="156,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="left" src="../jsp/left.jsp" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frame name="main" src="main_disconnect.jsp?message=<%=message%>" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0">');
document.write('</frameset>');
document.write('</frameset>');

}
else
{
document.write('<frameset  rows="120,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="top" src="../jsp/top.jsp" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frameset  cols="164,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="left" src="../jsp/left.jsp" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frame name="main" src="main_disconnect.jsp?message=<%=message%>" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0">');
document.write('</frameset>');
document.write('</frameset>');

}

</script>

</html>

