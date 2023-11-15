<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"cruscottogui.jsp")%>
</logtag:logData>
<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
<SCRIPT LANGUAGE="JavaScript">
  function ONCHIUDI()
  {
    window.close();
  }
  
  
  function apriDettPrep(codeFunz)
  {
    var currentdate = new Date();
    var dd = currentdate.getDate();
    var mm = currentdate.getMonth();
    var yy = currentdate.getFullYear();
    if (dd<10) {dd='0'+dd;}
    if (mm==0) {mm='12';yy=yy-1;}
    if (mm<10) {mm='0'+mm;}
    currentdate = dd+'/'+mm+'/'+yy;
    window.open("../../stati_elab/jsp/StatiElabBatchSp.jsp?selFunz=&selStato=&selUtente=&codeFunzione="+codeFunz+"&codeStatoBatch=&codeUtente=&data_ini_mmdd=&data_fine_mmdd=&act=POPOLALISTA&comboFunzioni="+codeFunz+"&data_ini_tmp="+currentdate+"&data_ini="+currentdate+"&comboStati=-1&data_fine_tmp=&data_fine=&comboUtenti=-1&numRec=5&SelCodeElab=&SelFlagSys=S&num_rec=124&typeLoad=0&txtnumRec=0&txtnumPag=1"); 
  }
  
  function apriCruscottoDett(tipoDett)
  {
    window.open("cruscottoDett.jsp?tipoDett="+tipoDett); 
  }  
  
  function chiamaStatistiche()
  {
    window.open("statistiche_odl.jsp"); 
  }  
  
</SCRIPT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML lang=en><HEAD><META content="IE=8.0000" http-equiv="X-UA-Compatible">
<TITLE>DASHBOARD</TITLE>
<meta http-equiv="refresh" content="30" />
<META charset=utf-8>
<STYLE>

      .note {
          position:relative;
          width:240px;
		  height:240px;
          padding:1em 1.5em;
          margin:0em auto;
          color:#fff;
          background:#97C02F;
          overflow:hidden;

      }

      .note:before {
          content:"";
          position:absolute;
          top:0;
          right:0;
          border-width:0 16px 16px 0; 
          border-style:solid;
          border-color:#fff #fff #658E15 #658E15; 
          background:#658E15; 
          display:block; width:0; 
          
          -webkit-box-shadow:0 1px 1px rgba(0,0,0,0.3), -1px 1px 1px rgba(0,0,0,0.2);
          -moz-box-shadow:0 1px 1px rgba(0,0,0,0.3), -1px 1px 1px rgba(0,0,0,0.2);
          box-shadow:0 1px 1px rgba(0,0,0,0.3), -1px 1px 1px rgba(0,0,0,0.2);
      }

      .note.red2 {background:#C93213;}
      .note.red2:before {border-color:#fff #fff #97010A #97010A; background:#97010A;}

      .note.grey {background:#D3D3D3;}
      .note.grey:before {border-color:#fff #fff #B6B6B6 #B6B6B6; background:#B6B6B6;}

      .note.taupe {background:#999868;}
      .note.taupe:before {border-color:#fff #fff #BDBB8B #BDBB8B; background:#BDBB8B;}

      .note.rounded {
          -webkit-border-radius:5px 0 5px 5px;
          -moz-border-radius:5px 0 5px 5px;
          border-radius:5px 0 5px 5px;
      }

      .note.rounded:before {
          border-width:8px; 
          border-color:#fff #fff transparent transparent; 
          -webkit-border-bottom-left-radius:5px;
          -moz-border-radius:0 0 0 5px;
          border-radius:0 0 0 5px;
      }

      .note p {margin:0;}
      .note p + p {margin:1.5em 0 0;}
    </STYLE>
</HEAD>
<BODY>
<form name="frmDati" method="post" action="">
<input type="hidden" name="hidTypeLoad" value="">
<%
  out.flush();
  int lImportOrdini = remoteCtr_Utility.cruscottoGuiByCodeId("IMP_ORD");
  int lPrepopolamentoRunn = remoteCtr_Utility.cruscottoGuiCountRunn("PREP");
  int lPrepopolamentoColor = remoteCtr_Utility.cruscottoGuiStatus("PREP");
  int lPopolValRunn = remoteCtr_Utility.cruscottoGuiCountRunn("21");
  int lPopolValColor = remoteCtr_Utility.cruscottoGuiStatus("21");
  int lRepricingRunn = remoteCtr_Utility.cruscottoGuiCountRunn("26");
  int lRepricingColor = remoteCtr_Utility.cruscottoGuiStatus("26");
  int lExportSapRunn = remoteCtr_Utility.cruscottoGuiCountRunn("10037");
  int lExportSapColor = remoteCtr_Utility.cruscottoGuiStatus("10037");  
  int lSapRewriteRunn = remoteCtr_Utility.cruscottoGuiCountRunn("10039");
  int lSapRewriteColor = remoteCtr_Utility.cruscottoGuiStatus("10039");    
  int lReportValRunn = remoteCtr_Utility.cruscottoGuiCountRunn("499");
  int lReportValColor = remoteCtr_Utility.cruscottoGuiStatus("499");  
  int lReportRepRunn = remoteCtr_Utility.cruscottoGuiCountRunn("498");
  int lReportRepColor = remoteCtr_Utility.cruscottoGuiStatus("498");    
  int lCongelamentoRunn = remoteCtr_Utility.cruscottoGuiCountRunn("27");
  int lCongelamentoColor = remoteCtr_Utility.cruscottoGuiStatus("27");    
  int lRendicontazione = remoteCtr_Utility.cruscottoGuiByCodeId("PRDD");
  //String strNameFirstPage = "contr_pre_val.jsp";
  //String strtypeLoad = request.getParameter("hidTypeLoad");
  
%>
<table width="100%" cellspacing="1" cellpadding="1">
  <tr>
    <td><img src="../images/CruscottoGui.gif" alt="" border="0"></td>
  </tr>
	<tr>
		<td width="20%" align="center">
                        <% 
                        if (lImportOrdini == 0){
                        %>
			<DIV class="note grey rounded" onclick="apriCruscottoDett('IMP_ORDINI');">
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lImportOrdini%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>IMPORT ORDINI</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                        %>
                        <DIV class="note rounded" onclick="apriCruscottoDett('IMP_ORDINI');">
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lImportOrdini%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>IMPORT ORDINI</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }
                        %>
		</td>
		<td width="20%" align="center">
                        <% 
                        if (lPrepopolamentoColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('PREP');">
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lPrepopolamentoRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>PRE POPOLAMENTO</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lPrepopolamentoColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('PREP')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lPrepopolamentoRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>PRE POPOLAMENTO</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('PREP')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lPrepopolamentoRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>PRE POPOLAMENTO</b></font></td>
                        </tr>
                        </table>                        
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
		<td width="20%" align="center">
                        <% 
                        if (lPopolValColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('21')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lPopolValRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>POPOLAMENTO VALORIZZAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lPopolValColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('21')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lPopolValRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>POPOLAMENTO VALORIZZAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded"  onclick="apriDettPrep('21')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lPopolValRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>POPOLAMENTO VALORIZZAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
		<td width="20%" align="center">
                        <% 
                        if (lRepricingColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('26')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lRepricingRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPRICING</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lRepricingColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('26')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lRepricingRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPRICING</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('26')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lRepricingRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPRICING</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
                <td width="20%" align="center">
                        <% 
                        if (lExportSapColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('10037')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lExportSapRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>Export SAP</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lExportSapColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('10037')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lExportSapRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>Export SAP</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('10037')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lExportSapRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>EXPORT SAP</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
	</tr>
        <tr>
		<td width="20%" align="center">
                <input class="textB" title="Statistiche" type="button" maxlength="30" name="Statistiche" bgcolor="<%=StaticContext.bgColorFooter%>" value="Statistiche Ordini" onClick="chiamaStatistiche();">
                	</td>
                        <td width="20%" align="center">
                	</td>
                        <td width="20%" align="center">
                	</td>
                        <td width="20%" align="center">
                	</td>
                        <td width="20%" align="center">
                	</td>
        </tr>   
         <tr>
                 <td width="20%" align="center">
                           &nbsp;</br></br>
                	</td>
                        <td width="20%" align="center">
                	</td>
                        <td width="20%" align="center">
                	</td>
                        <td width="20%" align="center">
                	</td>
                        <td width="20%" align="center">
                	</td>
        </tr> 
	<tr>
		<td width="20%" align="center">
                        <% 
                        if (lSapRewriteColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('10039')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lSapRewriteRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>SAP REWRITE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lSapRewriteColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('10039')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lSapRewriteRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>SAP REWRITE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('10039')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lSapRewriteRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>SAP REWRITE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
		<td width="20%" align="center">
                        <% 
                        if (lReportValColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('499')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lReportValRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPORT VALORIZZAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lReportValColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('499')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lReportValRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPORT VALORIZZAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('499')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lReportValRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPORT VALORIZZAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
                <td width="20%" align="center">
                        <% 
                        if (lReportRepColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('498')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=(lReportRepRunn)%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPORT REPRICING</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lReportRepColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('498')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lReportRepRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPORT REPRICING</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('498')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lReportRepRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>REPORT REPRICING</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
		<td width="20%" align="center">
                        <% 
                        if (lCongelamentoColor == 0){
                        %>
			<DIV class="note red2 rounded" onclick="apriDettPrep('27')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/alert.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lCongelamentoRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>CONGELAMENTO</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                         if (lCongelamentoColor == 1){
                        %>
                        <DIV class="note rounded" onclick="apriDettPrep('27')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lCongelamentoRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>CONGELAMENTO</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }else{
                        %>
                        <DIV class="note grey rounded" onclick="apriDettPrep('27')";>
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lCongelamentoRunn%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>CONGELAMENTO</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }}
                        %>
		</td>
		<td width="20%" align="center">
                        <% 
                        if (lRendicontazione == 0){
                        %>
			<DIV class="note grey rounded" onclick="apriCruscottoDett('RENDIC');">
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Pausa.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lRendicontazione%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>RENDICONTAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                        <% 
                        }else{
                        %>
                        <DIV class="note rounded" onclick="apriCruscottoDett('RENDIC');">
                        <table width="100%">
                        <tr height="50 px" valign="top">
                        <td> <img src="../images/Play2.png"  width="80"  border="0"></td>
                        <td><font size="60" color="white" ><b><%=lRendicontazione%></b></font></td>
                        </tr>
                        <tr height="110 px" valign="bottom">
                        <td colspan=2 align=center><font size="5" color="white" ><b>RENDICONTAZIONE</b></font></td>
                        </tr>
                        </table>
                        </DIV>
                          <% 
                        }
                        %>
		</td>
	</tr></table>
</FORM>
</BODY></HTML>
