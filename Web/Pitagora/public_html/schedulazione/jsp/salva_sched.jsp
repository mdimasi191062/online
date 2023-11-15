<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_sched.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  ClassSchedBatchElem riga = null;


  String strMessaggioFunz="";
  int operazione = Integer.parseInt(request.getParameter("operazione"));
  String strQueryString = "";
  strQueryString =  "idSched=" + request.getParameter("idSched");
  strQueryString += "&dataSched=" + request.getParameter("DATA_SCHED");
  
  
  if(operazione!=2)
  {
      riga = new ClassSchedBatchElem();
      riga.setIdSched(request.getParameter("idSched"));
      riga.setDataOraSched(request.getParameter("DATA_SCHED"));
  }

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">

<EJB:useHome id="homeSchedBatch" type="com.ejbSTL.SchedBatchSTLHome" location="SchedBatchSTL" /> 
<EJB:useBean id="remoteSchedBatch" type="com.ejbSTL.SchedBatchSTL" value="<%=homeSchedBatch.create()%>" scope="session"></EJB:useBean>

</HEAD>
<BODY>
<%
      if (operazione==2) //cancellazione
      {
        strMessaggioFunz = remoteSchedBatch.deleteSched(request.getParameter("idSched"));
      }
      else if (operazione==1)//aggiornamento
      {
        strMessaggioFunz = remoteSchedBatch.updateSched(riga);
      }
      if (strMessaggioFunz!=null)
      {
        response.sendRedirect("agg_sched.jsp?idSched=" + request.getParameter("idSched") + "&operazione=" + operazione + "&messaggio=" + strMessaggioFunz);
      }      
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="verifica_schedulazioni.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>