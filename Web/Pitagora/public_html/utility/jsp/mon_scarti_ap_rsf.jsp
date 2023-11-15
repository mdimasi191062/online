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
  <%=StaticMessages.getMessage(3006,"mon_scarti_ap_rsf.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  int esito = 0;
  String messaggio = "";
  String strTipoScarto = Misc.nh(request.getParameter("comboTipoScarto"));
  String operazione = Misc.nh(request.getParameter("operazione"));  
  if(!operazione.equals(""))
  {
      esito = remoteCtr_Utility.insScartiFreschi(strTipoScarto);
      if(esito==0)
        messaggio = "Inserimento effettuato correttamente.";
      else
        messaggio = "Errore durante il salvataggio dati.";
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
function ONAGGIUNGI()
{ 


    
    if (document.frmDati.comboTipoScarto.selectedIndex==0)
    {
        alert('La Tipologia dello scarto \E8 obbligatoria.');
        document.frmDati.comboTipoScarto.focus();
        return;
    }
    else
    {
        document.frmDati.action = "mon_scarti_ap_rsf.jsp?operazione=1";
        document.frmDati.submit();
    }

}

  
</SCRIPT>

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<body>
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
  Vector vctElabBatch = remoteCtr_Utility.getScartiFreschi();
  String strNameFirstPage = "mon_scarti_ap_rsf.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr>
    <td><img src="../images/monit_scarti.gif" alt="" border="0"></td>
  </tr>
<tr height="20">
  <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
            <td class="textB" width="20%">Tipo Promozione</td>
            <td class="text" width="25%">
                <select name="comboTipoScarto" width="10px" class="text" onchange="">
                    <option value="Z" Selected>Selezionare Tipo Scarto</option>
                        <option value="A">ANTE</option>
                        <option value="P">POST</option>
                </select>
            </td>
        </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="25%"></td>
            <td class="textB" width="10%"></td>
            <td class="text" width="50%"></td>
        </tr>
        </table>

    <table>
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
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Riepilogo Scarti</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabBatch.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if(vctElabBatch.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Data<BR>Scarto</td>      
            <td >Code Tipo<BR>Contr</td>      
            <td >Code Contr</td>
            <td >Descrizione</td>
            <td >Stato</td>
            <td >Tot ANTE</td>
            <td >Tot POST</td>
        </tr>
      <% 
  out.flush();
    
  Vector vctScartiFreschi = null;
  vctScartiFreschi = remoteCtr_Utility.getScartiFreschi(); 

  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        //for(int i=0;i<vctElabBatch.size();i++){
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctScartiFreschi.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_ScartiFreschi objUtility = (DB_ScartiFreschi)vctScartiFreschi.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_SCARTO().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CONTR()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_CONTR()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESCRIZIONE()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTIPO_SCARTO()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTOTANTE()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getTOTPOST()%></td> 
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
    <A HREF="javaScript:goPage('mon_scarti_ap_rsf.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('mon_scarti_ap_rsf.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('mon_scarti_ap_rsf.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
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
</SCRIPT>
<script>
var http=getHTTPObject();

if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
</html>