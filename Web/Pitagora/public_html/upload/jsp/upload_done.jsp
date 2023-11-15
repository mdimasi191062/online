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

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"upload_done.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">

<title></title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
</head>
<BODY   onload="window.setTimeout(SubmitMe, 2000)" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">
<%
 String CodeFunz = Misc.nh(request.getParameter("CodeFunz"));
 String DescFunz = null , VarPath = null , MaxSizeUpl = null , FileDiUpload = null;

 if ( !CodeFunz.equals("")) {
  DB_WebUplFiles reWeb = remoteCtr_ElabAttive.getWebUpl(CodeFunz);
  DescFunz = reWeb.getDESC_FUNZ();
  VarPath = reWeb.getVAR_PATH_DOWNLOAD();
  MaxSizeUpl = reWeb.getLIM_MAX_SIZE_UPLOAD();
  FileDiUpload = Misc.nh(request.getParameter("FileDiUpload"));
  session.setAttribute("MaxSizeUpl", MaxSizeUpl);
 }
  %>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;
</SCRIPT>
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr height="30">
        <td>
          <table width="100%">
            <tr>
              <td>
                <img src="../images/upload.gif" alt="" border="0"/>
              </td>
            </tr>
          </table>
        </td>
        <td/>
      </tr>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"> <%=DescFunz%> </td>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="20">
        <TD>
          <TABLE width="90%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white"/>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
</table>
<form align="center" method="POST" action="../../UplFiles" ENCTYPE="multipart/form-data" >
<input type=hidden name="VarPathUpl" value="<%=VarPath%>">
<input type=hidden name="MaxSizeUpl" value="<%=MaxSizeUpl%>">
<input type=hidden name="FileDiUpload" value="<%=FileDiUpload%>">

  <center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
  </center>
  
</form>
</body>
</html>
