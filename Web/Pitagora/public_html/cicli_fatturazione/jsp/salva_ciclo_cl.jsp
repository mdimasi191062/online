<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_ciclo_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  I5_2ANAG_CICLI_FATRZ_ROW riga=null;

  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtnumPag=request.getParameter("txtnumPag");
  String txtTypeLoad = request.getParameter("txtTypeLoad");
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String modo = request.getParameter("modo");
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
  sParametri= sParametri + "&txtnumPag=" + txtnumPag; 
//  sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
  sParametri= sParametri + "&modo=" + modo; 
  
%>  
<EJB:useHome id="home" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJBHome" location="I5_2ANAG_CICLI_FATRZEJB" />
<EJB:useBean id="ciclo" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJB" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  String DescCiclo = request.getParameter("txtDescCiclo");
  int GiorniCiclo = Integer.parseInt(request.getParameter("txtGiorniCiclo"));
  if (modo.equals("0"))
  {
    ciclo.creaCiclo(DescCiclo,GiorniCiclo);
  }
  if (modo.equals("1"))
  {
    String CodiceCiclo = request.getParameter("CodSel");
    riga = new I5_2ANAG_CICLI_FATRZ_ROW(CodiceCiclo,DescCiclo,GiorniCiclo);
    ciclo.updateCiclo(riga);
  }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
</title>
</head>
<body>
  <script language="javascript">
<% if ( modo.equals("0") ){ %>
    window.document.location.href="cbn1_agg_ciclo_cl.jsp?txtTypeLoad=0<%=sParametri%>";
<%}%>   
    window.opener.document.location.href="cbn1_lista_cicli_cl.jsp?txtTypeLoad=0<%=sParametri%>";
<% if ( modo.equals("1") ){ %>
    window.close();
<%}%>   

  </script>
</BODY>
</HTML>
