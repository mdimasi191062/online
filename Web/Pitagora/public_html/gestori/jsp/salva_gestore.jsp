<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*" %>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  String strQueryString = "";
  strQueryString =  "txtnumRec=" + request.getParameter("txtnumRec");
  strQueryString += "&numRec=" + request.getParameter("numRec");
  strQueryString += "&pager.offset=" + request.getParameter("pager.offset");
  strQueryString += "&txtTypeLoad=0"; 
//  strQueryString += "&txtRicerca=" + request.getParameter("txtRicerca"); 
  strQueryString += "&CodSel=" + request.getParameter("CodSel");

  I5_3GEST_TLC_ROW row = new I5_3GEST_TLC_ROW();
  row.setCODE_GEST(request.getParameter("CODE_GEST"));                       
  row.setCODE_TIPOL_OPERATORE(request.getParameter("CODE_TIPOL_OPERATORE"));
  row.setCODE_TIPO_GEST(request.getParameter("CODE_TIPO_GEST"));                 
  row.setCODE_COMUNE_SEDE_LEGALE(request.getParameter("CODE_COMUNE_SEDE_LEGALE"));        
  row.setCODE_COMUNE_SEDE_CENTRALE(request.getParameter("CODE_COMUNE_SEDE_CENTRALE"));      
  row.setNOME_RAG_SOC_GEST(request.getParameter("NOME_RAG_SOC_GEST"));              
  row.setNOME_GEST_SIGLA(request.getParameter("NOME_GEST_SIGLA"));                
  row.setCODE_PARTITA_IVA(request.getParameter("CODE_PARTITA_IVA"));               
  row.setINDR_VIA_SEDE_LEGALE(request.getParameter("INDR_VIA_SEDE_LEGALE"));           
  row.setINDR_CIV_SEDE_LEGALE(request.getParameter("INDR_CIV_SEDE_LEGALE"));           
  row.setCODE_CAP_SEDE_LEGALE(request.getParameter("CODE_CAP_SEDE_LEGALE"));           
  row.setINDR_TEL_SEDE_LEGALE(request.getParameter("INDR_TEL_SEDE_LEGALE"));           
  row.setINDR_FAX_SEDE_LEGALE(request.getParameter("INDR_FAX_SEDE_LEGALE"));           
  row.setINDR_VIA_SEDE_CENTRALE(request.getParameter("INDR_VIA_SEDE_CENTRALE"));         
  row.setINDR_CIV_SEDE_CENTRALE(request.getParameter("INDR_CIV_SEDE_CENTRALE"));         
  row.setCODE_CAP_SEDE_CENTRALE(request.getParameter("CODE_CAP_SEDE_CENTRALE"));         
  row.setINDR_TEL_SEDE_CENTRALE(request.getParameter("INDR_TEL_SEDE_CENTRALE"));         
  row.setINDR_FAX_SEDE_CENTRALE(request.getParameter("INDR_FAX_SEDE_CENTRALE"));         
  row.setINDR_INTERNET(request.getParameter("INDR_INTERNET"));                  
  row.setTEXT_NOTE(request.getParameter("TEXT_NOTE"));
  Integer QNTA_DIP = null;
  if(request.getParameter("QNTA_DIP")!=null)
  {
    if(!request.getParameter("QNTA_DIP").equals(""))
        row.setQNTA_DIP(new Integer(request.getParameter("QNTA_DIP"))); 
  }
  row.setTEXT_ALLEANZE(request.getParameter("TEXT_ALLEANZE"));                  
  row.setTEXT_INFO_ESTERO(request.getParameter("TEXT_INFO_ESTERO"));               
  row.setTEXT_DIP(request.getParameter("TEXT_DIP"));                       
  row.setTEXT_TIPOL_OPERATORE(request.getParameter("TEXT_TIPOL_OPERATORE"));           
  row.setCODE_GEST_TIRKS(request.getParameter("CODE_GEST_TIRKS"));                

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_3GEST_TLCejbHome" location="I5_3GEST_TLCejb" />  
<EJB:useBean id="gestori" type="com.ejbSTL.I5_3GEST_TLCejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean></HEAD>
<BODY>
<%
          gestori.updateGestNorm(row);
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="lista_gestori.jsp?<%=strQueryString%>"
  this.close();
</SCRIPT>
</BODY>
</HTML>