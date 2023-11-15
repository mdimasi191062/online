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

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"OfferteDettaglio.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<%
   String strCodeOfferta    = Misc.nh(request.getParameter("Offerta"));
   String Elemento = "O";

   Vector vct_Info = remoteEnt_Catalogo.getVisualizzaInfo( Elemento,  strCodeOfferta,  "",  "",  "" , "" );
   DB_VisualizzaInfo info_Compo = (DB_VisualizzaInfo)vct_Info.get(0);
%>

<HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>Offerte Dettaglio</title>
</head>
<body>
 <table ALIGN=center>
      <tr>
         <td bgcolor="#0a6b98" class="white" valign="top" width="91%"> Offerte Dati Dettaglio</td>
      </tr>
 </table>
 <TABLE ALIGN=center BORDER=10 CELLPADDING=5 CELLSPACING=5 WIDTH=200 HEIGHT=9>
        <tr>
            <TD  class="textB" > L'offerta <%=info_Compo.getDATO_ESERCIZIO().equals("N")?"non":""%> è in esercizio </TD>
        </tr>
</TABLE> 
</body>
</HTML>