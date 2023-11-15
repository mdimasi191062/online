<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_verifica_sar_cl.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------      
  LancioBatch lanciobatch =null;
  String strComRibes=null;
  String strTestAvanUpd=null;  
  int Ritorno;
  strComRibes = (String) session.getAttribute("strComRibes");
  strTestAvanUpd = (String) session.getAttribute("strTestAvanUpd");    

  if (session.getAttribute("FlagLancioSar")==null){
    response.sendRedirect(request.getContextPath() + "/common/jsp/com_tc.jsp?destinationPageClassic=/stato_avanzamento_costi/jsp/cbn1_lancio_sar_cl.jsp&strTitolo=/stato_avanzamento_costi/images/avanzamricavi.gif&TCNonAmmessiClassic=*2*6*&TCNonAmmessiSpecial=-");  
  } else {
    session.setAttribute("FlagLancioSar",null);
  }  
  
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>Lancio Confronto Storico Inventario</TITLE>
</HEAD>
<BODY >
<EJB:useHome id="home_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVIHome" location="I5_2TEST_AVANZ_COSTI_RICAVI" />
<EJB:useBean id="remote_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVI" scope="session">
  <EJB:createBean instance="<%=home_TEST_ACR.create()%>" />
</EJB:useBean>
<%
  remote_TEST_ACR.UpdateDate(strTestAvanUpd);
  lanciobatch = new LancioBatch();
  Ritorno = lanciobatch.Esecuzione(strComRibes);
%>
  <script language="javascript">
<% 
  String strMessaggio = null;
  if (Ritorno==0) { 
   strMessaggio = response.encodeURL("Elaborazione batch avviata correttamente");
  }else{
   strMessaggio = response.encodeURL("Errore nel lancio della procedura batch");  
  }
%>           
    window.document.location="messaggio.jsp?Bottone=1&strMessaggio=<%=strMessaggio%>&strUrl=../../common/jsp/com_tc.jsp?destinationPageClassic=/stato_avanzamento_costi/jsp/cbn1_ver_ava_ric_cl.jsp&strTitolo=/stato_avanzamento_costi/images/avanzamricavi.gif&TCNonAmmessiClassic=*2*6*&TCNonAmmessiSpecial=-";
  </script>  
</BODY>
</HTML>
