<%@ page import="com.utl.StaticContext" %>
<%@ page import="com.usr.clsInfoUser" %>
<%  
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String isAuthenticated=(String)request.getParameter("authenticated");
  if (isAuthenticated==null)
    isAuthenticated="";
%>
<HTML>
<HEAD>
    <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/security.js">
    </SCRIPT>
    <TITLE>Telecom</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
    <LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
</head>
    <BODY LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="../images/top/pixel.gif">
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td> <!-- top -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td><img src="../images/top/top.gif" width="603" height="15" alt="" border="0"></td>
                        <td><A href="http://www.telecomitalia.it"  target="_blank" onMouseOver="logo_telecom.src='../images/top/logo_telecom_on.gif';" onMouseOut="logo_telecom.src='../images/top/logo_telecom_off.gif';">
                            <IMG src="../images/top/logo_telecom_off.gif" width="146" height="15" BORDER="0" name="logo_telecom" alt="Telecomitalia"></A></td>
                        <td><img src="../images/top/top_dx.gif" width="16" height="15"></td>
                    </tr>
                </table> <!-- fine top -->
            </td>
        </tr>
        <tr>
            <td> <!-- mid -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td><img src="../images/top/mid_logo.gif" width="288" height="64" border="0"></td>
                        <td><img src="../images/top/mid_dxlogo.gif" width="109" height="64" alt="" border="0"></td>
                        <td><img src="../images/top/mid_foto_1.gif" width="106" height="64" alt="" border="0"></td>
                        <td><img src="../images/top/mid_foto1_2.gif" width="17" height="64" alt="" border="0"></td>
                        <td><img src="../images/top/mid_foto_2.gif" width="106" height="64" alt="" border="0"></td>
                        <td><img src="../images/top/mid_foto3_2.gif" width="17" height="64" alt="" border="0"></td>
                        <td><img src="../images/top/mid_foto_3.gif" width="106" height="64" alt="" border="0"></td>
                        <td><img src="../images/top/mid_dx.gif" width="16" height="64" alt="" border="0"></td>
                    </tr>
                </table> <!-- fine mid -->
            </td>
        </tr>
        <tr>
            <td> <!-- bottom -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td rowspan="2"><img src="../images/top/bot_sx.gif" width="156" height="41" border="0"></td>
                        <td width="609" valign="top" background="../images/top/bot_pixel_bg.gif">
                            <table border="0"   cellspacing="0" cellpadding="0" align="left">
                                <tr>
<%
  if (isAuthenticated.equals("T"))
  {  
%>
                                    <td class='white' width="60" valign="top" align="left">
                                      <A href="../../logout" target=_parent onmouseover="ImageLogin.src='../images/top/login_on.gif';" onmouseout="ImageLogin.src='../../common/images/top/login_off.gif';">
                                        <IMG src="../images/top/login_off.gif" width="54" height="11" border="0" name="ImageLogin" alt="Login/Logout">
                                      </A>
                                    </td>
                                    <td nowrap width="160" valign="top" class='white'>Utente: <%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %></td>
                                    <td nowrap width="190" valign="top" class='white'>Client IP: <%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getClientIp()%></td>                                    
                                    <td nowrap width="150" valign="top" class='white'>DB: <%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getDB_instanceName() %></td>                                    
                                    <td nowrap width="170" valign="top" class='white'>Server: <%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getServer().toUpperCase() %></td>                                    
                                    <td nowrap valign="top" class='white'>Versione: <%= (StaticContext.VERSIONE_JPUB)%></td>
<%
  }
  else
  {
%>
                                    <td width="76" valign="top"><IMG src="../images/top/pixel_black.gif" width="54" height="11" border="0" name="ImageLogin" alt="Login/Logout"></td>
                                    <td width="67" valign="top"><IMG src="../images/top/pixel_black.gif" width="67" height="11" BORDER="0" name="ImageContact" alt="Contatti"></td>
                                    <td width="30"><img src="../images/top/pixel_black.gif" width="30" height="2"></td>
<%
  }
%>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </body>
    <HTML>

