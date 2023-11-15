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
  <%=StaticMessages.getMessage(3006,"contr_pre_val.jsp")%>
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
</SCRIPT>

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<body>
<form name="frmDati" method="post" action="">
<input type="hidden" name="hidTypeLoad" value="">
<%
  out.flush();
  Vector vctElabBatch = remoteCtr_Utility.getStatistiche_odl();
  DB_ElabBatchResocontoSAP objElabBatch = null;
  String strNameFirstPage = "contr_pre_val.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr>
    <td><img src="../images/ContrPreValoriz.gif" alt="" border="0"></td>
  </tr>
<tr  style="display: none;" height="20">
  <td>
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
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
          Controlli Pre Valorizzazione
        </td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctElabBatch.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if( 1 != 0 ){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Dettaglio<BR>Fattura</td>      
            <td >Testata<BR>Fattura</td>      
            <td >Dettaglio<BR>Nota di Credito</td>      
            <td >Testata<BR>Nota di Credito</td>      
            <td >Dettaglio<BR>CSV Sap</td>      
            <td >Testata<BR>CSV Sap</td>                  
            <td >Account<BR>Duplicati</td>
        </tr>
      <% 
      
  out.flush();
  Integer dettFatt = 0;
  Integer testFatt = 0;
  Integer dettNdc = 0;
  Integer testNdc = 0;
  Integer dettCsv = 0;
  Integer testCsv = 0;  
  Integer accountDup = 0;
  
  ControlliPreValorizElem  elem=null;
  elem=remoteCtr_Utility.getControlliPreValoriz();
  dettFatt = elem.geto_dett_fatt();
  testFatt = elem.geto_test_fatt();  
  dettNdc = elem.geto_dett_ndc();
  testNdc = elem.geto_test_ndc();  
  dettCsv = elem.geto_dett_csv();
  testCsv = elem.geto_test_csv();    
  accountDup = elem.geto_acc_dupl();  %>
             <TR>
           <% if (dettFatt==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>
            <% if (testFatt==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>
           <% if (dettNdc==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>
            <% if (testNdc==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>            
           <% if (dettCsv==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>
            <% if (testCsv==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>                
            <% if (accountDup==0) { %>
            <!--<td  align="center"><img src="../images/check.png" alt="" border="0"><%=dettFatt%></td> -->
            <td  align="center"><img src="../images/check.png" alt="" border="0"></td> 
            <% } else { %>
            <td  align="center"><img src="../images/NOcheck.png" alt="" border="0"></td> 
            <% } %>    
            </TR>
 <%
 // -----------
  
 // ----------
  
  
  Vector vctStatistiche_odl = null;
  vctStatistiche_odl = remoteCtr_Utility.getStatistiche_odl(); 

  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        //for(int i=0;i<vctElabBatch.size();i++){
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctStatistiche_odl.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_Statistiche_odl objUtility = (DB_Statistiche_odl)vctStatistiche_odl.get(i);
           %>
 
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
    <A HREF="javaScript:goPage('contr_pre_val.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('contr_pre_val.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('contr_pre_val.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
  </td>
</tr>
<!--<tr height="28">
  <td >
    <sec:ShowButtons td_class="textB"/>
  </td>
</tr>
-->
</TABLE>
</FORM>
</body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  frmDati.cboNumRecXPag.value = '<%=intRecXPag%>';
  document.all('tblElab').style.display = '';
</SCRIPT>
</html>