<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_sconto_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  //DA CAMBIARE QUANDO CI SARà LA GESTIONE UTENTI
  String codeUtente=((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();

  String strMessaggioFunz="";
  int operazione = Integer.parseInt(request.getParameter("operazione"));
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
//  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");

  String strAppo=null;
  String code_sconto = request.getParameter("code_sconto");
  String desc_sconto = request.getParameter("desc_sconto");
  Integer valo_perc_sconto = null;
  strAppo = request.getParameter("valo_perc_sconto");
  if(strAppo!=null)
    if(!strAppo.equals(""))
      valo_perc_sconto = new Integer(strAppo);
  strAppo=null;
  strAppo = request.getParameter("valo_decr_tariffa");
  java.math.BigDecimal valo_decr_tariffa = null;
  if(strAppo!=null)
    if(!strAppo.equals(""))
      valo_decr_tariffa = new java.math.BigDecimal(strAppo.replace(',','.'));
  int ret=0;
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_2SCONTO_CLHome" location="I5_2SCONTO_CL" />  
<EJB:useBean id="sconto" type="com.ejbSTL.I5_2SCONTO_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean> 
</HEAD>
<BODY>
<%
      if (operazione==2) //cancellazione
      {
           if(sconto.CheckCodeSconto(code_sconto)>0)
           {
              strMessaggioFunz = "Allo Sconto selezionato è associata una tariffa. Non è possibile procedere con l'aggiornamento.";
              response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
           }
           else
           {
              sconto.removeSconto(code_sconto); 
           }
      }
      else if (operazione==1)//aggiornamento
      {
           if(sconto.CheckCodeSconto(code_sconto)>0)
           {
              strMessaggioFunz = "Allo Sconto selezionato è associata una tariffa. Non è possibile procedere con l'aggiornamento.";
              response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
           }
           else
           {
             sconto.saveSconto(code_sconto,desc_sconto,valo_perc_sconto,valo_decr_tariffa);
           }
      }
      else if (operazione==0)//inserimento
      {
         sconto.insertSconto(desc_sconto, valo_perc_sconto, valo_decr_tariffa,codeUtente);
      }
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="cbn4_lista_sconti_cl.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>