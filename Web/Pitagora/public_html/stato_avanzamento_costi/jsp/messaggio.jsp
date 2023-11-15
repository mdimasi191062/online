<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%
  String strUrl=request.getParameter("strUrl");  
  String strMessaggio=request.getParameter("strMessaggio");  
  String Bottone=request.getParameter("Bottone");  
  String QueryString=request.getQueryString();
%>
<HTML>
<HEAD>
  <TITLE>Messaggio</TITLE>
  <META content="text/html; charset=windows-1252" http-equiv=Content-Type>
  <LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
  <script language="javascript">
    function Esegui(){
      window.document.location="<%=strUrl + "?" + QueryString%>";
    }
  </script>  
</HEAD>
<% if (Bottone != null){%>      
<BODY bgColor="#ffffff" text="#000000">
<% }else{%>      
<BODY bgColor="#ffffff" text="#000000" onload="Esegui();">
<%  }%>      

<% if (Bottone == null){%>      
<form name="frmdati">
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
        <td align="left"><img src="../images/avanzamricavi.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0a6b98" align = "center">
        <tr>
                <td>
                 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0a6b98">
                        <tr>
                          <td bgcolor="#0a6b98" class="white" valign="top" width="91%">Lancio Batch</td>
                          <td bgcolor="#ffffff" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                        </tr>
                 </table>
                </td>
        </tr>
</table>
<center>
        <h1 class="textB">
        Lancio Batch in Corso...<br>
        Attendere
        </h1>
        
</center>
</form>
<% }else{%>      

<form name="frmdati">
<TABLE border="0" cellPadding="0" cellSpacing="0" width="100%" >
  <TR>
    <td valign="top"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0" width="500" align="center">
        <TR>
          <TD vAlign="top" width="80"><IMG border="0"  src="../../common/images/body/info.gif" ></TD>
        <TR>
      </TABLE>

      <TABLE bgColor="#006699" border="0" cellPadding="1" cellSpacing="0" width="502" align="center">
        <TR>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="502">
              <TR>
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; Messaggio</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="../../common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500" align="center">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <td align='center' class='white'><%=strMessaggio%></td>
                <TD>&nbsp;</TD>
              </TR>

            </TABLE>
          </TD>
          <TD><IMG align="right" src="../../common/images/body/log3.gif"></TD>
        </TR>
      </TABLE>
<% if (Bottone != null){%>      
      <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td align="center">
            <img src="Images/pixel.gif" width="1" height='1'>
	        </td>
	      </tr>
	      <tr>
          <td class="textB" bgcolor="#D5DDF1" align="center">
            <input class="textB" type="button" name="Prosegui" value="Prosegui" onclick = "Esegui();">
	        </td>
	      </tr>        
	    </table>
<% }%>            
    </TD>
  </TR>
</TABLE>
<%  }%>      
</BODY>
</form>
</HTML>



