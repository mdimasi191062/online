<%--@ include file="../../common/jsp/gestione_cache.jsp"--%>
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
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"download_file.jsp")%>
</logtag:logData>



<%@ page import="com.utl.StaticContext" %>
<%@ page import="com.utl.*" %>



<%
String nomefile         = request.getParameter("nomeFileHiddenDownload");
System.out.println("download_file.jsp - nomeFile ["+nomefile+"]");
String path             = request.getParameter("comboNomeFile");
System.out.println("download_file.jsp - path     ["+path+"]");

%>

<pg:downloadTag1 file="<%=nomefile%>" dir="<%=path%>" inline="false" contentType="text/html"/>

