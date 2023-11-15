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
<%=StaticMessages.getMessage(3006,"cbn4_ver_cal_sp_compl_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_SpesaComplessiva" type="com.ejbSTL.Ctr_SpesaComplessivaHome" location="Ctr_SpesaComplessiva" />
<EJB:useBean id="remoteCtr_SpesaComplessiva" type="com.ejbSTL.Ctr_SpesaComplessiva" scope="session">
    <EJB:createBean instance="<%=homeCtr_SpesaComplessiva.create()%>" />
</EJB:useBean>
<%
	String strParameterToLog = "";
	String strMessage = "";
	int i = 0;
	Vector vctDataBean = null;
	//Lista Account SELEZIONATI!
	String strCodeTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String strViewState = Misc.nh(request.getParameter("hidViewState"));
	String strElementIndex = Misc.nh(request.getParameter("hidElementIndex"));
	vctDataBean = (Vector) session.getAttribute("vctAccountElaborati");
	if(strViewState.equals("S")){//congela selezionato
		i = Integer.parseInt(strElementIndex);
		DB_Account lobj_AppoAccountElaborati = (DB_Account)vctDataBean.elementAt(i);
		vctDataBean = new Vector();
		vctDataBean.addElement(lobj_AppoAccountElaborati);
	}
	%>
	
	<% strParameterToLog = Misc.buildParameterToLog(vctDataBean);
	String strLogMessage = "remoteCtr_SpesaComplessiva.congela(" + "CodeTipoContratto=" + strCodeTipoContratto 
																	+ ";" + strParameterToLog  + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3502,strLogMessage)%>
	</logtag:logData>
    <%String strResult = remoteCtr_SpesaComplessiva.congela(strCodeTipoContratto,vctDataBean);
	if(strResult.equals("")){
		strMessage = "Elaborazione conclusa con successo!!";
		strLogMessage += ": Successo";
	}else{
		strMessage = strResult;
		strLogMessage += ": " + strResult;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3502,strLogMessage)%>
	</logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMessage,com.utl.StaticContext.ENCCharset); 
	response.sendRedirect(strUrl);
	%>