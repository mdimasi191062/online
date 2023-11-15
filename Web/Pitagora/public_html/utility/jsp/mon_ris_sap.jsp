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

<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"mon_ris_sap.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  //Integer pagerPageNumber=1;
  String messaggio = "";
  String datarif = Misc.nh(request.getParameter("txtDataInizioCiclo"));
  System.out.println("data rif : " + datarif);
  String operazione = Misc.nh(request.getParameter("operazione"));  
  Vector vctRisRicMese = null;
  Vector vctRisErrMese = null;
  Vector vctDettRisErrMese = null;
  Vector vctTesFattNoRisc = null;
  Vector vctRisErrTestNoRisc = null;
  if(!operazione.equals(""))
  {
        vctRisRicMese       = remoteCtr_Utility.getMonitRiscontri1(datarif);
        vctRisErrMese       = remoteCtr_Utility.getMonitRiscontri2(datarif);
        vctDettRisErrMese   = remoteCtr_Utility.getMonitRiscontri3(datarif);
        vctTesFattNoRisc    = remoteCtr_Utility.getMonitRiscontri4(datarif);
        vctRisErrTestNoRisc = remoteCtr_Utility.getMonitRiscontri5(datarif);
   }
  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript">
    var objForm = null;
    function initialize()
    {
  	objForm = document.frmDati;
		//impostazione delle propriet? di default per tutti gli oggetti della form
		setDefaultProp(objForm);
    }
 
  function ONAGGIORNA()
{ 
        document.frmDati.action = "mon_ris_sap.jsp?operazione=1";
        document.frmDati.submit();
}

</SCRIPT>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>
<BODY onload = "initialize();">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<form name="frmDati" method="post" action="">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="hidTypeLoad" value="">
<%
  out.flush();
  Vector vctElabBatch = null;
  Vector vctElabRisRicMese = null;
  Vector vctElabRisErrMese = null;
  Vector vctElabDettRisErrMese = null;
  Vector vctElabTesFattNoRisc = null;
  Vector vctElabRisErrTestNoRisc = null;
  if(operazione.equals("")) 
  {
    datarif = "01/01/1900";
  }

  vctElabRisRicMese       = remoteCtr_Utility.getMonitRiscontri1(datarif);
  vctElabRisErrMese       = remoteCtr_Utility.getMonitRiscontri2(datarif);
  vctElabDettRisErrMese   = remoteCtr_Utility.getMonitRiscontri3(datarif);
  vctElabTesFattNoRisc    = remoteCtr_Utility.getMonitRiscontri4(datarif);
  vctElabRisErrTestNoRisc = remoteCtr_Utility.getMonitRiscontri5(datarif);    
  
  String strNameFirstPage = "mon_ris_sap.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<TABLE name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr>
    <td><img src="../images/RiscontriSap.gif" alt="" border="0"></td>
  </tr>
<tr height="20">
  <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
                    <td class="textB">Data Inizio Monitoraggio: </td>
                    <td class="text">
                        <input type='text' name='txtDataInizioCiclo' obbligatorio="si" value='' class="text" readonly >
                        <a href="javascript:showCalendar('frmDati.txtDataInizioCiclo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
			<a href="javascript:clearField(objForm.txtDataInizioCiclo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                    </td>
       </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="25%"></td>
            <td class="textB" width="10%"></td>
            <td class="text" width="50%"></td>
        </tr>
        </table>

    <table style="display:none;">
      <tr>
        <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
        <td  class="text">
        <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>')">
          <%for(int k = 300;k >= 50; k=k-50){%>
          <option class="text" value="<%=k%>"><%=k%></option>
          <%}%>
        </select>
        </td>
      </tr>
     </table>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Riscontri ricevuti per Mese Solare</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabRisRicMese.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabRisRicMese.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Elaborazione</td>
            <td >Totale</td>
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctRisRicMese = null;
    vctRisRicMese = remoteCtr_Utility.getMonitRiscontri1("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctRisRicMese.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonRiscSap objUtility = (DB_MonRiscSap)vctRisRicMese.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ELAB1()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTOTALE1()%></td> 
           </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Riscontri in errore per Mese Solare</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabRisErrMese.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabRisErrMese.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Elaborazione</td>
            <td >Totale</td>
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctRisErrMese = null;
    vctRisErrMese = remoteCtr_Utility.getMonitRiscontri2("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctRisErrMese.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonRiscSap objUtility = (DB_MonRiscSap)vctRisErrMese.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ELAB2()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTOTALE2()%></td> 
           </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dettagli dei Riscontri in errore per Mese Solare</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabDettRisErrMese.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabDettRisErrMese.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Elaborazione</td>
            <td >Nome File</td>
            <td >Code Doc</td>
            <td >Flusso Origine</td>
            <td >Numero Riga File</td>
            <td >Code Scarto</td>
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctDettRisErrMese = null;
    vctDettRisErrMese = remoteCtr_Utility.getMonitRiscontri3("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctDettRisErrMese.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonRiscSap objUtility = (DB_MonRiscSap)vctDettRisErrMese.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ELABORAZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOME_FILE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DOC()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getFLUSSO_ORIGINE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNUMERO_RIGA_FILE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_SCARTO()%></td>
           </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Testate Fattura Non Riscontrate, per Operatore</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabTesFattNoRisc.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabTesFattNoRisc.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Desc Account</td>
            <td >Importo Totale</td>
            <td >ID Richiesta</td>
            <td >Numero Fattura</td>
            <td >Numero Doc</td>
            <td >Esercizio</td>
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctTesFattNoRisc = null;
    vctTesFattNoRisc = remoteCtr_Utility.getMonitRiscontri4("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctTesFattNoRisc.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonRiscSap objUtility = (DB_MonRiscSap)vctTesFattNoRisc.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESC_ACCOUNT()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getIMPT_TOT()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getID_RICHIESTA()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNR_FATTURA_SD()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNR_DOC_FI()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getESERCIZIO()%></td>
           </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
</tr>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Riscontri in errore con le Testate fATTURA Non Riscontrate</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabRisErrTestNoRisc.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabRisErrTestNoRisc.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Elaborazione</td>
            <td >Nome File</td>
            <td >Code Doc</td>
            <td >Flusso Origine</td>
            <td >Numero Riga File</td>
            <td >Code Scarto</td>
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctRisErrTestNoRisc = null;
    vctRisErrTestNoRisc = remoteCtr_Utility.getMonitRiscontri5("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctRisErrTestNoRisc.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonRiscSap objUtility = (DB_MonRiscSap)vctRisErrTestNoRisc.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ELABORAZIONE().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOME_FILE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DOC()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getFLUSSO_ORIGINE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNUMERO_RIGA_FILE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_SCARTO()%></td>
           </TR>
           <%
           }
      }
      else{%>
        <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
          <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
        </tr>
      <%}%>
    </table>
  </TD>
<TR>
<tr height="28" class="text">
  <td >
    <pg:index>
       Risultati Pag.
    <pg:prev> 
    <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_ris_sap.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>

<tr height="28">
  <td >
    <sec:ShowButtons td_class="textB"/>
  </td>
</tr>

</TABLE>
</FORM>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  frmDati.cboNumRecXPag.value = '<%=intRecXPag%>';
  document.all('tblElab').style.display = '';
</SCRIPT>
<script>
var http=getHTTPObject();

if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
