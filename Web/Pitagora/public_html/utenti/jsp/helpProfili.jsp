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
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*"%>

<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<EJB:useHome id="home" type="com.ejbSTL.I5_6PROF_UTENTEejbHome" location="I5_6PROF_UTENTEejb" />
<EJB:useBean id="profili" type="com.ejbSTL.I5_6PROF_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
  java.util.Collection appoVector=null;
  I5_6PROF_UTENTE_ROW[] aRemote = null;
  
  String CodeProfUte = Misc.nh(request.getParameter("CodeProfUte"));
  appoVector = profili.FindAll(CodeProfUte);
  if (!(appoVector==null || appoVector.size()==0)) 
  {
     aRemote = (I5_6PROF_UTENTE_ROW[])appoVector.toArray(new I5_6PROF_UTENTE_ROW[1]);
  } 
  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Help regola
</title>
</head>
<body>
    <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
      <TR height="20">
        <TD>
        <%
        String CODE_PROF_UTENTE = "";
        String DESC_PROF_UTENTE = "";        
        for(int j=0;j<aRemote.length;j++)
        {
          CODE_PROF_UTENTE = aRemote[j].getCODE_PROF_UTENTE();
          DESC_PROF_UTENTE = aRemote[j].getDESC_PROF_UTENTE();
        }
        %>
          <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="middle">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                <%=CODE_PROF_UTENTE%>
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="middle" width="9%">
                <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD align="center" valign="middle" width="100%" height="100%">
            <textarea class="text" style="width:100%;height:100%"><%=DESC_PROF_UTENTE%>
            </textarea>
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
