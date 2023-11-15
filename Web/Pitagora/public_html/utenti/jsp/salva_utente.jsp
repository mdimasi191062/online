<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_utente.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  I5_6anag_utenteROW riga = null;


  String strMessaggioFunz="";
  int operazione = Integer.parseInt(request.getParameter("operazione"));
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("offset");
  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca");
  strQueryString += "&txtTypeLoad=0"; 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");
  
  if(operazione!=2 && operazione!=3)
  {
      riga = new I5_6anag_utenteROW();
      java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
      riga.setCode_utente(request.getParameter("CODE_UTENTE"));
      riga.setCode_prof_utente(request.getParameter("CODE_PROF_UTENTE"));
      riga.setNome_cogn_utente(request.getParameter("NOME_COGN_UTENTE"));
      riga.setCode_prof_abil(request.getParameter("CODE_PROF_ABIL"));
      riga.setNum_months_disabled(6);
      riga.setBaseIDN_LDAP(request.getParameter("BASE_LDAP"));
      riga.setSearchIDN_LDAP(request.getParameter("SEARCH_LDAP"));      
      riga.setCode_unita_organiz(request.getParameter("CODE_UNITA_ORGANIZ"));
      riga.setMail(request.getParameter("MAIL"));
      riga.setMail_manager(request.getParameter("MAIL_MANAGER"));
      riga.setData_end_user(request.getParameter("DATA_END_USER"));      
      riga.setCogn_utente(request.getParameter("COGNOME_UTENTE")); 
      riga.setNome_utente(request.getParameter("NOME_UTENTE")); 
      String strAppo = request.getParameter("FLAG_ADMIN_IND");
      if(strAppo!=null)
      {
        riga.setFlag_admin_ind("S");
      }
      else
      {
        riga.setFlag_admin_ind("N");
      }
      //riga.setCode_pwd(request.getParameter("APPO_PWD"));
  }

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_UTENTEejbHome" location="I5_6ANAG_UTENTEejb" />
<EJB:useBean id="utenti" type="com.ejbSTL.I5_6ANAG_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
</HEAD>
<BODY>
<%
      if (operazione==2) //cancellazione
      {
        strMessaggioFunz = utenti.deleteUtente(request.getParameter("CODE_UTENTE"));
      }
      else if (operazione==1)//aggiornamento
      {
        strMessaggioFunz = utenti.updateUtente(riga);
      }
      else if (operazione==0)//inserimento
      {
        strMessaggioFunz = utenti.creaNuovo(riga);
      }
      else if (operazione==3)//riabilitazione
      {
        strMessaggioFunz = utenti.riabilitaUtente(request.getParameter("CODE_UTENTE"));
      }
      if (strMessaggioFunz==null)
      {
        strMessaggioFunz = "OK";
      }
%>

<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="lista_utenti.jsp?<%=strQueryString%>&msg=<%=strMessaggioFunz%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>