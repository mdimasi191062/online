<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import = "com.ds.pdf.*" %>
<%@ page import = "com.ds.chart.*" %>
<%@ page import = "com.utl.*" %>
<%@ page import = "com.usr.*" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>

<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pdf.jsp")%>
</logtag:logData>

<%

    String url = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/statistiche/";
    String urlImage =url + "save/"+request.getParameter("imgName");

    String filePath=application.getRealPath("/")+"statistiche/save"+System.getProperty("file.separator");
    java.util.Date date = new java.util.Date();

    String pdfFile="chart"+date.getTime()+".PDF";

    boolean b = false;

    if (request.getParameter("DIAGRAM_TYPE").equals("BAR")){
      b=HTML2PDF.createBarPDF(urlImage, (BarDiagramDataset)session.getAttribute("barDataset"), filePath+pdfFile);
    }else {
      b=HTML2PDF.createPiePDF(urlImage, (PieDiagramDataset)session.getAttribute("pieDataset"), filePath+pdfFile);
    }
    
    String fwd = "../save/"+pdfFile;
    if (b){
  
%>
<jsp:forward page="<%=fwd%>" />
<%} else {
		StaticContext.writeLog("Generazione file PDF non riuscita");
		String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp";
		strUrl += "?message=" + java.net.URLEncoder.encode("Generazione file PDF non riuscita.",com.utl.StaticContext.ENCCharset); 
		strUrl += "&CHIUDI=true";
		response.sendRedirect(strUrl);
	}
%>
