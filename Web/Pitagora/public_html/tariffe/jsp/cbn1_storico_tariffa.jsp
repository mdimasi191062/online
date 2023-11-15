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
<%@ taglib uri="/webapp/Tar" prefix="tar" %>

<sec:ChkUserAuth isModal="true"/>
 
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_storico_tariffa.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TariffeNew" type="com.ejbSTL.Ent_TariffeNewHome" location="Ent_TariffeNew" />
<EJB:useBean id="remoteEnt_TariffeNew" type="com.ejbSTL.Ent_TariffeNew" scope="session">
    <EJB:createBean instance="<%=homeEnt_TariffeNew.create()%>" />
</EJB:useBean>

<%
  int CodeTariffa = Integer.parseInt(request.getParameter("CodeTariffa"));
  //Vector vctTariffe = remoteEnt_TariffeNew.getStoricoTariffa(CodeTariffa);
   int tipo_Tariffa  = 0;
   String appotipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
   if (appotipoTariffa.equalsIgnoreCase("1")){
      tipo_Tariffa = Integer.parseInt(request.getParameter("tipo_tariffa"));
  }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<%if (tipo_Tariffa != 0) { %>
   <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style1.css" TYPE="text/css">
<% } %>
<title>
Storico tariffa
</title>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
</head>
<body>
    <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
      <TR height="20">
        <TD>
          <TABLE  height="100%" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                Storico tariffa
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD align="center" valign="center">
          <DIV>
          <tar:TableTar CodeTariffa="<%=CodeTariffa%>" ClassRow1="row1" ClassRow2="row2" ClassIntest="rowHeader" tipoTariffa="<%=tipo_Tariffa%>" />
          </DIV>
        </TD>
      </TR>
      <TR height="20" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD>
          <TABLE align="center" width="100%" border="0">
            <TR>
              <td class="text" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                <INPUT TYPE="button" class="textB" value="Chiudi" onclick="window.close()">
              </td>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
</body>
</html>
