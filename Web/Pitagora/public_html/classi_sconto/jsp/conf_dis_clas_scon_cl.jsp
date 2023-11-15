<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Iterator" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"conf_dis_clas_scon_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  I5_2CLAS_SCONTOEJB remote=null;
 // I5_2CLAS_SCONTOEJBHome home=null;
  Collection collection=null;
  Iterator iterator = null;
  String txtDataFine="";

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
</title>
</head>
<BODY>
<EJB:useHome id="home" type="com.ejbBMP.I5_2CLAS_SCONTOEJBHome" location="I5_2CLAS_SCONTOEJB" /> 
<%
       String newDataFine = request.getParameter("DataFine");
       String IdClsSconto = request.getParameter("txtCodiceClsSconto");
       java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
       java.util.Date DataFine = df.parse(newDataFine);       
       collection = home.findAllByCodeClsSconto(IdClsSconto);
       iterator = collection.iterator();
    	  while (iterator.hasNext())
    	  {
          remote = (I5_2CLAS_SCONTOEJB) iterator.next();          
          remote.setFi_Valid(DataFine);
      
        }
%>
<script language="javascript">

  window.close();  
  window.opener.document.location.href="cbn4_lista_clas_scon_cl.jsp?txtTypeLoad=0<%//=sParametri%>";

</script>
</BODY>
</HTML>
