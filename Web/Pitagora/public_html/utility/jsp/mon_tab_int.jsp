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
  <%=StaticMessages.getMessage(3006,"mon_tab_int.jsp")%>
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
  Vector vctAnagContrRegNow = null;
  Vector vctAnagContrXdslNow = null;
  Vector vctAnagGestRegNow = null;
  Vector vctAnagGestXdslNow = null;
  if(!operazione.equals(""))
  {
      vctAnagContrRegNow    = remoteCtr_Utility.getAnagContrRegNow(datarif);
      vctAnagContrXdslNow   = remoteCtr_Utility.getAnagContrXdslNow(datarif);
      vctAnagGestRegNow     = remoteCtr_Utility.getAnagGestRegNow(datarif);
      vctAnagGestXdslNow    = remoteCtr_Utility.getAnagGestXdslNow(datarif);
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
        document.frmDati.action = "mon_tab_int.jsp?operazione=1";
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
  Vector vctElabAnagContrRegNow = null;
  Vector vctElabAnagContrXdslNow = null;
  Vector vctElabAnagGestRegNow = null;
  Vector vctElabAnagGestXdslNow = null;

  if(operazione.equals("")) 
  {
    datarif = "01/01/1900";
  }

  vctElabAnagContrRegNow    = remoteCtr_Utility.getAnagContrRegNow(datarif);
  vctElabAnagContrXdslNow   = remoteCtr_Utility.getAnagContrXdslNow(datarif);
  vctElabAnagGestRegNow     = remoteCtr_Utility.getAnagGestRegNow(datarif);
  vctElabAnagGestXdslNow    = remoteCtr_Utility.getAnagGestXdslNow(datarif);
   
  
  String strNameFirstPage = "mon_tab_int.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<TABLE name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr>
    <td><img src="../images/MonTabInter.gif" alt="" border="0"></td>
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
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Scarti su Ordini di Anagrafica Contratti di Servizi REG_NOW</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabAnagContrRegNow.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabAnagContrRegNow.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Inserimento</td>
            <td >Data Acquisizione</td>
            <td >Data Scarto</td>
            <td >Tag<br>Code Ccontr</td>
            <td >Tag<br>Desc Contr</td>
            <td >Tag<br>Code Tipo Contr</td>
            <td >Tag<br>Id Ord Crmws</td>
            <td >Tag<br>Data Scad Contr</td>
            <td >Tag<br>Data Stip Contr</td>
            <td >Tag<br>Data Inizio Valid</td>
            <td >Tag<br>Data Fine Valid</td>            
            <td >Id Ord Crmws</td>
            <td >Code Scarto</td>
            <td >Code Dett Scarto</td>
            <td >Tag in Errore</td>
            <td >Nome Attributo<br>in Errore</td>            
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctAnagContrRegNow = null;
    vctAnagContrRegNow = remoteCtr_Utility.getMonitRiscontri1("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctAnagContrRegNow.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonTabInt objUtility = (DB_MonTabInt)vctAnagContrRegNow.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INSERIMENTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ACQUISIZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DESC_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_TIPO_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_ID_ORD_CRMWS()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_SCAD_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_STIP_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_INIZIO_VALID()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_FINE_VALID()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getID_ORD_CRMWS()%></td>            
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DETT_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_IN_ERRORE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOME_ATTRIBUTO_IN_ERRORE()%></td>            
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
    <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Scarti su Ordini di Anagrafica Contratti di Servizi xDSL NOW</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabAnagContrXdslNow.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabAnagContrXdslNow.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Inserimento</td>
            <td >Data Acquisizione</td>
            <td >Data Scarto</td>
            <td >Tag<br>Code Ccontr</td>
            <td >Tag<br>Desc Contr</td>
            <td >Tag<br>Code Tipo Contr</td>
            <td >Tag<br>Id Ord Crmws</td>
            <td >Tag<br>Data Scad Contr</td>
            <td >Tag<br>Data Stip Contr</td>
            <td >Tag<br>Data Inizio Valid</td>
            <td >Tag<br>Data Fine Valid</td>            
            <td >Code Scarto</td>
            <td >Code Dett Scarto</td>
            <td >Tag in Errore</td>
            <td >Nome Attributo<br>in Errore</td>            
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctAnagContrXdslNow = null;
    vctAnagContrXdslNow = remoteCtr_Utility.getMonitRiscontri2("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctAnagContrXdslNow.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonTabInt objUtility = (DB_MonTabInt)vctAnagContrXdslNow.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INSERIMENTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ACQUISIZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DESC_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_TIPO_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_ID_ORD_CRMWS()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_SCAD_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_STIP_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_INIZIO_VALID()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_DATA_FINE_VALID()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DETT_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_IN_ERRORE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOME_ATTRIBUTO_IN_ERRORE()%></td>   
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
    <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Scarti su Ordini Anagrafica Gestori di Servizi REG NOW</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabAnagGestRegNow.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabAnagGestRegNow.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Inserimento</td>
            <td >Data Acquisizione</td>
            <td >Data Scarto</td>
            <td >Tag<br>Tipo Azione</td>
            <td >Tag<br>Code Gest</td>
            <td >Tag<br>Nome Rag Soc Gest</td>
            <td >Tag<br>Nome Gest Sigla</td>
            <td >Tag<br>Code Partita Iva</td>            
            <td >Id Ord Crmws</td>
            <td >Code Scarto</td>
            <td >Code Dett Scarto</td>
            <td >Tag in Errore</td>
            <td >Nome Attributo<br>in Errore</td>  
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctAnagGestRegNow = null;
    vctAnagGestRegNow = remoteCtr_Utility.getMonitRiscontri3("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctAnagGestRegNow.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonTabInt objUtility = (DB_MonTabInt)vctAnagGestRegNow.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INSERIMENTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ACQUISIZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_TIPO_AZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_GEST()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_NOME_RAG_SOC_GEST()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_NOME_GEST_SIGLA()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_PARTITA_IVA()%></td>            
            <td  class="<%=classRow%>" align="center"><%=objUtility.getID_ORD_CRMWS()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DETT_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_IN_ERRORE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOME_ATTRIBUTO_IN_ERRORE()%></td> 
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
    <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Scarti su Ordini Anagrafica Gestori di Servizi xDSL NOW</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabAnagGestXdslNow.size()%>"> 
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabAnagGestXdslNow.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data Inserimento</td>
            <td >Data Acquisizione</td>
            <td >Data Scarto</td>
            <td >Tag<br>Tipo Azione</td>
            <td >Tag<br>Code Gest</td>
            <td >Tag<br>Nome Rag Soc Gest</td>
            <td >Tag<br>Nome Gest Sigla</td>
            <td >Tag<br>Code Partita Iva</td>            
            <td >Id Ord Crmws</td>
            <td >Code Scarto</td>
            <td >Code Dett Scarto</td>
            <td >Tag in Errore</td>
            <td >Nome Attributo<br>in Errore</td> 
        </tr>
      <% 
  out.flush();
    
  if(operazione.equals(""))    {
    vctAnagGestXdslNow = null;
    vctAnagGestXdslNow = remoteCtr_Utility.getMonitRiscontri4("01/01/1900"); 
  }

  if (request.getParameter("cboNumRecXPag")!=null) {
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	}
        String classRow = "row2"; 
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctAnagGestXdslNow.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_MonTabInt objUtility = (DB_MonTabInt)vctAnagGestXdslNow.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INSERIMENTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ACQUISIZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_TIPO_AZIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_GEST()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_NOME_RAG_SOC_GEST()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_NOME_GEST_SIGLA()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_CODE_PARTITA_IVA()%></td>            
            <td  class="<%=classRow%>" align="center"><%=objUtility.getID_ORD_CRMWS()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DETT_SCARTO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTAG_IN_ERRORE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOME_ATTRIBUTO_IN_ERRORE()%></td> 
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
    <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_tab_int.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
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
