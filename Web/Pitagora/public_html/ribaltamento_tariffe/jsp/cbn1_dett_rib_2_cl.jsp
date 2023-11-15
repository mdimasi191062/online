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
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_dett_rib_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Riba_Tariffe" type="com.ejbSTL.Ctr_Riba_TariffeHome" location="Ctr_Riba_Tariffe" />
<EJB:useBean id="remoteCtr_Riba_Tariffe" type="com.ejbSTL.Ctr_Riba_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Riba_Tariffe.create()%>" />
</EJB:useBean>

<%
    int intAction;
    int intFunzionalita;
	String strMessage="";
	String strLogMessage = "";
	//reperimento dei parametri provenienti dalla pagina precedente
	intAction = Integer.parseInt(request.getParameter("intAction"));
    intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	String strCodeContrOr = Misc.nh(request.getParameter("cboContrattoOr"));
	String strCodeContrDest = Misc.nh(request.getParameter("cboContrattoDest"));
	String strCodePrestAggOr = Misc.nh(request.getParameter("cboPrestAggOr"));
	String strGlobalCodeOggFatrz = Misc.nh(request.getParameter("cboOggFatOr"));
	String strCodeOggFattOr = "";
	if(!strGlobalCodeOggFatrz.equals(""))
	{
		Vector vctAppo = Misc.split(strGlobalCodeOggFatrz,"$");
		strCodeOggFattOr = (String)vctAppo.elementAt(0);
	}
	String strCodePsOr = Misc.nh(request.getParameter("hidCodePsOr"));
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	String strCodeUtente = objInfoUser.getUserName();%>
	<% strLogMessage = "remoteCtr_Riba_Tariffe.lancioBatch(" + "CodeUtente=" + strCodeUtente
															 + ";CodeContrOr=" + strCodeContrOr 
															 + ";CodeContrDest=" + strCodeContrDest 
															 + ";CodePsOr=" + strCodePsOr
															 + ";CodePrestAggOr=" + strCodePrestAggOr
															 + ";CodeOggFattOr=" + strCodeOggFattOr
															 + ")";%>
	<logtag:logData id="<%= strCodeUtente %>">
			<%=StaticMessages.getMessage(3501,strLogMessage)%>
	</logtag:logData>
	<%strMessage = remoteCtr_Riba_Tariffe.lancioBatch(strCodeUtente,
														strCodeContrOr,
														strCodeContrDest,
														strCodePsOr,
														strCodePrestAggOr,
														strCodeOggFattOr);
														
														
	if(strMessage.equals(""))
	{
		strLogMessage += " : Successo" ;
	}
	else
	{
		strLogMessage += " : " + strMessage ;
	}
	%>
	<logtag:logData id="<%= strCodeUtente %>">
			<%=StaticMessages.getMessage(3501,strLogMessage)%>
	</logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMessage,com.utl.StaticContext.ENCCharset); 
	response.sendRedirect(strUrl);
	%>
