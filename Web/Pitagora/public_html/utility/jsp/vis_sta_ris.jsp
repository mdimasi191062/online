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
  <%=StaticMessages.getMessage(3006,"vis_sta_ris.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  
  String messaggio = "";
  Integer esito = 0;
  String risorsa = Misc.nh(request.getParameter("txtRisorsa"));
  String operazione = Misc.nh(request.getParameter("operazione"));  

  if(!operazione.equals(""))
  {
        esito = remoteCtr_Utility.lanciaStatoRisorsa(risorsa);
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
	function initialize(){
  	objForm = document.frmDati;
		//impostazione delle propriet? di default per tutti gli oggetti della form
		setDefaultProp(objForm);
  }
 
  function ONAGGIORNA()
{ 
        if(document.frmDati.txtRisorsa.value==''){
            alert('ID Risorsa obbligatorio.');
            document.frmDati.comboServizi.focus();
        return;
        }
        document.frmDati.action = "vis_sta_ris.jsp?operazione=1";
        document.frmDati.submit();
}

</SCRIPT>

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
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
  Vector vctAnalisiRisorsa = new Vector();
  Vector vctUltFat = new Vector();
  Vector vctUltNdc = new Vector();
  if(!operazione.equals("")) {
    vctAnalisiRisorsa = remoteCtr_Utility.getAnalisiRisorsa(risorsa);
    vctUltFat = remoteCtr_Utility.getUltimaFatt(risorsa);
    vctUltNdc = remoteCtr_Utility.getUltimaNdc(risorsa);
    }
  
  
  String strNameFirstPage = "vis_sta_ris.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr>
    <td><img src="../images/StatoRisorsa.gif" alt="" border="0"></td>
  </tr>
<tr height="20">
  <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
            <td class="textB">Risorsa da analizzare: </td>
            <td  class="text">
                <input class="text" type='text' name='txtRisorsa' obbligatorio="si" value=''  >
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
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Analisi Stato della Risorsa</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctAnalisiRisorsa.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if((vctAnalisiRisorsa!=null) && (vctAnalisiRisorsa.size()!=0)){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Risorsa</td>      
            <td >Note</td>      
       </tr>
      <% 
  out.flush();
    
  vctAnalisiRisorsa = remoteCtr_Utility.getAnalisiRisorsa(risorsa); 
  
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctAnalisiRisorsa.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_StatoRisorsa objUtility = (DB_StatoRisorsa)vctAnalisiRisorsa.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESC_ID_RISORSA()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getNOTE()%></td> 
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
    <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Fattura</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctUltFat.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if((vctUltFat!=null) && (vctUltFat.size()!=0) && (vctAnalisiRisorsa.size()!=0)){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Code Doc</td>      
            <td >Code Account</td>      
            <td >Code<br>Tipo Contr</td>      
            <td >Data Inizio<br>Ciclo Fatt</td>                  
            <td >Data Fine<br>Ciclo Fatt</td>                              
            <td >Data<br>Emissione</td>    
            <td >Impt<br>Totale</td>                              
       </tr>
      <% 
  out.flush();
    
  vctUltFat = remoteCtr_Utility.getUltimaFatt(risorsa); 
  
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctUltFat.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_StatoRisorsa objUtility = (DB_StatoRisorsa)vctUltFat.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DOC()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_ACCOUNT()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INIZIO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_FINE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_EMISSIONE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getIMPT_TOT()%></td>
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
    <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Nota di Credito</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctUltNdc.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if((vctUltNdc!=null) && (vctUltNdc.size()!=0) && (vctAnalisiRisorsa.size()!=0)){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Code Doc</td>      
            <td >Code Account</td>      
            <td >Code<br>Tipo Contr</td>      
            <td >Data Inizio<br>Ciclo Fatt</td>                  
            <td >Data Fine<br>Ciclo Fatt</td>       
            <td >Data<br>Emissione</td>             
            <td >Impt<br>Totale</td>                              
       </tr>
      <% 
  out.flush();
    
  vctUltNdc = remoteCtr_Utility.getUltimaNdc(risorsa); 
  
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctUltNdc.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_StatoRisorsa objUtility = (DB_StatoRisorsa)vctUltNdc.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_DOC()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_ACCOUNT()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CONTR()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INIZIO()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_FINE()%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_EMISSIONE()%></td>            
            <td  class="<%=classRow%>" align="center"><%=objUtility.getIMPT_TOT()%></td>
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
    <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('vis_sta_ris.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
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
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  frmDati.cboNumRecXPag.value = '<%=intRecXPag%>';
  document.all('tblElab').style.display = '';

var http=getHTTPObject();

if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
</html>