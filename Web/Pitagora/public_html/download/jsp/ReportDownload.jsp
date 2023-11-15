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
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.StaticContext,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>

<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ReportDownload.jsp")%>
</logtag:logData>

<%
String strElencoFile[] = request.getParameterValues("comboDaScaricare");
String pathReport      = Misc.nh(request.getParameter("pathReportHidden"));
String nomeFileZip     = Misc.nh(request.getParameter("nomeFileCompressoHidden"));
String pathZipFile     = Misc.nh(request.getParameter("pathFileZipHidden"));

int checkCompressFile = GenerateCompressFile.generateZipFileByArray(strElencoFile,pathReport,pathZipFile,nomeFileZip);

if(checkCompressFile == 0){
%>

<pg:downloadTag1 file="<%=nomeFileZip%>" dir="<%=pathZipFile%>" inline="true" contentType="application/octet-stream"/>


<%
}else{
  String strMsgOutput = "Errore generazione file zip!!";
  String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_POPUP=false&message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset); 
  response.sendRedirect(strUrl);
}
%>


