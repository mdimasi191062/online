<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.io.*,java.util.*,java.text.*,javax.naming.*,javax.rmi.*,javax.ejb.*,java.sql.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"elimina_mov_non_ric_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
  String strMessaggioFunz = null;
  String bErrore = null;
  String bgcolor="";
  I5_2MOV_NON_RICEJB remotoejb=null;
  String mov_da_canc = request.getParameter("txtOccorrenzaCanc");   
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<TITLE>
</TITLE>
</HEAD>
<BODY>
<EJB:useHome id="home" type="com.ejbBMP.I5_2MOV_NON_RICEJBHome" location="I5_2MOV_NON_RICEJB" />

<%
  remotoejb = home.findByPrimaryKey(mov_da_canc);      
  remotoejb.remove();
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
</title>
</head>
<body>
<script language="javascript">
window.location.href="cbn1_lista_mnr_cl.jsp?txtTypeLoad=0";
</script>
</BODY>
</HTML>
