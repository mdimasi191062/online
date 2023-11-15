<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="java.io.*,java.util.*,java.text.*,javax.naming.*,javax.rmi.*,javax.ejb.*,com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lancio_batch_allineamento.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------      
  String strComRibes = null;
  final String RibesAllineamento="2001";
  final String RibesSeparatore="$";  
  String strQueryString = request.getQueryString();
  
  if (session.getAttribute("FlagLancioGestori")==null){
    response.sendRedirect(request.getContextPath() + "/gestori/jsp/allineamento_db.jsp?" + strQueryString);  
  } else {
    session.setAttribute("FlagLancioGestori",null);
  } 

  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String Utente = aUserInfo.getUserName();    

  strComRibes = RibesAllineamento + RibesSeparatore + Utente ; 

  // bisogna lanciare la servlet Lista_gestori

  LancioBatch lanciobatch =null;
  int Ritorno;
  lanciobatch = new LancioBatch();
  Ritorno = lanciobatch.Esecuzione(strComRibes);  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>Lancio Bath di Allineamento</TITLE>
</HEAD>
<BODY >
  <script language="javascript">
<% 
  String strMessaggio = null;
  if (Ritorno==0) { 
   strMessaggio = response.encodeURL("Elaborazione batch avviata correttamente");
   clsApplication objApplication = new clsApplication();
   objApplication.setAdminIndicator(StaticContext.ACTION_SHUTDOWN);
   Date adesso= new Date();
   objApplication.setDataLancioAllineamntoDB(adesso);
   application.setAttribute(StaticContext.ACTION_INDICATOR,objApplication);   
  }else{
   strMessaggio = response.encodeURL("Errore nel lancio della procedura batch");  
  }
%>           
   window.document.location="messaggio_p.jsp?Bottone=1&strMessaggio=<%=strMessaggio%>&strUrl=allineamento_db.jsp&<%=strQueryString%>";
  </script>  
</BODY>
</HTML>
