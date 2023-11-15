<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*" %>
<%@ page import="java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<!---->
    <EJB:useHome id="homeCtr_TariffeSconti" type="com.ejbSTL.Ctr_TariffeScontiHome" location="Ctr_TariffeSconti" />
    <EJB:useBean id="remoteCtr_TariffeSconti" type="com.ejbSTL.Ctr_TariffeSconti" scope="session">
        <EJB:createBean instance="<%=homeCtr_TariffeSconti.create()%>" />
    </EJB:useBean>

<%
      Vector lvct_TariffeLista = (Vector)session.getAttribute("VectorTariffeList");
      String CodSconto = Misc.nh(request.getParameter("hidCodeSconto"));
      String DataInizio = Misc.nh(request.getParameter("txtDataInizioVal"));
      String Result = remoteCtr_TariffeSconti.insert(lvct_TariffeLista,CodSconto,DataInizio);

        String strMsgOutput = "" ;
        String strLogMessage = "";
       if(Result.equals("")){
        strMsgOutput = "Elaborazione terminata correttamente!!";
        strLogMessage += ": Success";  
        }else{
        strMsgOutput = Result;
        strLogMessage += ": " + Result; 
        }%>
   <logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
				<%=StaticMessages.getMessage(3503,strLogMessage)%>
		</logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset) + "&CHIUDI=true"; 
	response.sendRedirect(strUrl);
%>