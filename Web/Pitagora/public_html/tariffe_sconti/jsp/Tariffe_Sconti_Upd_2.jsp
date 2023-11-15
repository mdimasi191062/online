<!-- import delle librerie necessarie -->
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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
 <EJB:useHome id="homeCtr_TariffeSconti" type="com.ejbSTL.Ctr_TariffeScontiHome" location="Ctr_TariffeSconti" />
    <EJB:useBean id="remoteCtr_TariffeSconti" type="com.ejbSTL.Ctr_TariffeSconti" scope="session">
        <EJB:createBean instance="<%=homeCtr_TariffeSconti.create()%>" />
    </EJB:useBean>
<%
//ricevo i prametri per la tariffa scelta
String strCODE_TARIFFA = Misc.nh(request.getParameter("CODE_TARIFFA"));
String strCODE_PR_TARIFFA = Misc.nh(request.getParameter("CODE_PR_TARIFFA"));
String strCODE_SCONTO = Misc.nh(request.getParameter("CODE_SCONTO"));
String strDATA_INIZIO_VALID =Misc.nh(request.getParameter("DATA_INIZIO_VALID"));
String strDATA_FINE_VALID =Misc.nh(request.getParameter("DataFineValid"));
 
String Result = remoteCtr_TariffeSconti.disattiva(strCODE_TARIFFA,strCODE_PR_TARIFFA,strCODE_SCONTO,strDATA_INIZIO_VALID,strDATA_FINE_VALID);

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
				<%=StaticMessages.getMessage(3506,strLogMessage)%>
		</logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset) + "&CHIUDI=true"; 
	response.sendRedirect(strUrl);
%>
%>