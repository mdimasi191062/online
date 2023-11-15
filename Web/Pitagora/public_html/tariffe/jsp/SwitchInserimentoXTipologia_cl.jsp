<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"SwitchInserimentoXTipologia_cl.jsp")%>
</logtag:logData>

<%
String strURL="";
switch (Integer.parseInt(request.getParameter("codiceTipoContratto"))){
	case StaticContext.TPL_ITC:
		strURL="cbn1_ins_tar_x_tipol_contr_itc_cl.jsp";
	break;
	case StaticContext.TPL_CDN:
		strURL="cbn1_ins_tar_x_tipol_contr_cdn_cl.jsp";
	break;
	case StaticContext.TPL_ACCESSO_RETE_DATI:
		strURL="cbn1_ins_tar_x_tipol_contr_cvp_cl.jsp";
	break;
	case StaticContext.TPL_ACQUISTI:
		strURL="cbn1_ins_tar_x_tipol_contr_acquisti_cl.jsp";
	break;
	case StaticContext.TPL_CIRCUITI_PARZIALI:
		strURL="cbn1_ins_tar_x_tipol_circ_parziali_cl.jsp";
	break;
}
strURL+="?intAction=" + java.net.URLEncoder.encode(request.getParameter("intAction"),com.utl.StaticContext.ENCCharset);
strURL+="&codiceTipoContratto="+ java.net.URLEncoder.encode(request.getParameter("codiceTipoContratto"),com.utl.StaticContext.ENCCharset);
strURL+="&hidDescTipoContratto="+ java.net.URLEncoder.encode(request.getParameter("hidDescTipoContratto"),com.utl.StaticContext.ENCCharset);
strURL+="&PageAction=INS";
response.sendRedirect(strURL);
%>

