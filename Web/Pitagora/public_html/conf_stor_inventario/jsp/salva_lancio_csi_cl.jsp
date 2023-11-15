<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_lancio_csi_cl.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------      
  LancioBatch lanciobatch =null;
  String strComRibes=null;
  int Ritorno;

    //Controllo se proveniamo da cbn1_lancio_csi_cl
  if (session.getAttribute("FlagLancioCsi")==null){
    response.sendRedirect(request.getContextPath() + "/common/jsp/com_tc.jsp?destinationPageClassic=/conf_stor_inventario/jsp/cbn1_lancio_csi_cl.jsp&strTitolo=/conf_stor_inventario/images/confrstoricoinven.gif&TCNonAmmessiSpecial=-");  
  }else{  
    session.setAttribute("FlagLancioCsi",null);    
  }  
  
  strComRibes = (String) session.getAttribute("strComRibes");
  lanciobatch = new LancioBatch();
  Ritorno = lanciobatch.Esecuzione(strComRibes);
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>Lancio Confronto Storico Inventario</TITLE>
</HEAD>
<BODY >
  <script language="javascript">
<% 
  String strMessaggio = null;
  if (Ritorno==0) { 
   strMessaggio = response.encodeURL("Elaborazione batch avviata correttamente");
  }else{
   strMessaggio = response.encodeURL("Errore nel lancio della procedura batch");  
  }
%>           
    window.document.location="messaggio.jsp?Bottone=1&strMessaggio=<%=strMessaggio%>&strUrl=../../common/jsp/com_tc.jsp?destinationPageClassic=/conf_stor_inventario/jsp/cbn1_lancio_csi_cl.jsp&strTitolo=/conf_stor_inventario/images/confrstoricoinven.gif&TCNonAmmessiSpecial=-";
  </script>  
</BODY>
</HTML>
