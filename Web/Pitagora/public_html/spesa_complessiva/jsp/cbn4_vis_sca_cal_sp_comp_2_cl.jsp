<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_vis_sca_cal_sp_comp_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Scarti" type="com.ejbSTL.Ctr_ScartiHome" location="Ctr_Scarti" />
<EJB:useBean id="remoteCtr_Scarti" type="com.ejbSTL.Ctr_Scarti" scope="session">
    <EJB:createBean instance="<%=homeCtr_Scarti.create()%>" />
</EJB:useBean>


<%!
	//costruzione di un vettore di databean dato un vettore di stringhe
	String strParameterToLog = "";
	private Vector costruzioneVectorDataBean(Vector pvct_Account) throws Exception{
		Vector lvctReturn = new Vector();
		strParameterToLog = "";
		for (int j=0;j<pvct_Account.size();j++){
			String lstrAppoAccount = (String)pvct_Account.elementAt(j);
			DB_Scarti lobjAppoScarto = new DB_Scarti();
			Vector lvctAppoDatiAccount = Misc.split(lstrAppoAccount,"=");
			lobjAppoScarto.setCODE_SCARTO((String)lvctAppoDatiAccount.elementAt(0));
			lobjAppoScarto.setTIPO_FLAG_STATO_SCARTO((String)lvctAppoDatiAccount.elementAt(1));
			lvctReturn.addElement(lobjAppoScarto);
		}
		return lvctReturn;
	}
%>
<%
	int intAction;
	int intFunzionalita;
	intAction = Integer.parseInt(request.getParameter("intAction"));
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	Vector lvct_Account = new Vector();
	//Lista Account!
	String lstr_CodiciAccount = Misc.nh(request.getParameter("hidViewState"));
	lvct_Account = Misc.split(lstr_CodiciAccount,"|");
	lvct_Account = costruzioneVectorDataBean(lvct_Account);
    String lstr_Message = "";%>
	<%  strParameterToLog = Misc.buildParameterToLog(lvct_Account);
		String strLogMessage = "remoteCtr_Scarti.updScarti(" + strParameterToLog  + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3504,strLogMessage)%>
	</logtag:logData>
	<%lstr_Message = remoteCtr_Scarti.updScarti(lvct_Account);
	if(lstr_Message.equals("")){
		lstr_Message = "Aggiornamento avvenuto con successo!";
		strLogMessage += ": Successo";
	}
	else
	{
		strLogMessage += ": " + lstr_Message;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3504,strLogMessage)%>
	</logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(lstr_Message,com.utl.StaticContext.ENCCharset); 
	response.sendRedirect(strUrl);
	%>