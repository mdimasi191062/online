<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"gestione_euribor_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  String strMessaggioFunz="";
  int operazione = Integer.parseInt(request.getParameter("operazione"));
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
  strQueryString += "&txtDataDa=" + request.getParameter("txtDataDa"); 
  strQueryString += "&txtDataA=" + request.getParameter("txtDataA");   
  strQueryString += "&CodSel=" + request.getParameter("CodSel");

  String strVALO_EURIBOR = request.getParameter("VALO_EURIBOR").replace(',','.');  
  String strDATA_INIZIO_CICLO_FATRZ = request.getParameter("DATA_INIZIO_CICLO_FATRZ");
  String strDATA_FINE_CICLO_FATRZ = request.getParameter("DATA_FINE_CICLO_FATRZ");

  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  java.util.Date DATA_INIZIO_CICLO_FATRZ = df.parse(strDATA_INIZIO_CICLO_FATRZ);
  java.util.Date DATA_FINE_CICLO_FATRZ = df.parse(strDATA_FINE_CICLO_FATRZ);
  Float VALO_EURIBOR = new Float(strVALO_EURIBOR);

  int ret=0;

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />  
<EJB:useBean id="eur" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

</HEAD>
<BODY>
<%
      if (operazione==2) //cancellazione
      {
          if(eur.updateValoreEuribor(null,DATA_INIZIO_CICLO_FATRZ,DATA_FINE_CICLO_FATRZ)==0)
          {
                  strMessaggioFunz = "Si è verificato un errore nell'aggiornamento della % Euribor.";
                  response.sendRedirect("messaggio_euribor_cl.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
          }
      }
      else
      {
          if (eur.checkValoreEuribor(VALO_EURIBOR,DATA_INIZIO_CICLO_FATRZ,DATA_FINE_CICLO_FATRZ)>0) 
          {
            strMessaggioFunz = "Il valore % Euribor è stato già inserito per il periodo di riferimento selezionato.";
            response.sendRedirect("messaggio_euribor_cl.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
          }
          else
          {
                if(eur.updateValoreEuribor(VALO_EURIBOR,DATA_INIZIO_CICLO_FATRZ,DATA_FINE_CICLO_FATRZ)==0)
                {
                        strMessaggioFunz = "Si è verificato un errore nell'aggiornamento della % Euribor.";
                        response.sendRedirect("messaggio_euribor_cl.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
                }
          }
      }

%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="cbn1_lista_euribor_cl.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>