<%@ taglib uri="/webapp/sec" prefix="sec" %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth />
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/security.js"></SCRIPT>
<html>
<script language="javascript">

if (document.all)
{
<!-- EXPLORER -->
document.write('<frameset  rows="120,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="TOP" src="top.jsp?authenticated=T" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frameset  cols="156,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="LEFT" src="left.jsp?authenticated=T" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frame name="MAIN" src="../../login/html/home.html" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0">');
document.write('</frameset>');
document.write('</frameset>');

}
else
{
document.write('<frameset  rows="120,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="TOP" src="top.jsp?authenticated=T" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frameset  cols="164,*" FRAMEBORDER="0" BORDER=0 FRAMESPACING="0">');
document.write('<frame name="LEFT" src="left.jsp?authenticated=T" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>');
document.write('<frame name="MAIN" src="../../login/html/home.html" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0">');
document.write('</frameset>');
document.write('</frameset>');

}

</script>

</html>


