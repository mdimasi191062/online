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
  <%=StaticMessages.getMessage(3006,"tmlrisorsa.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  
  String messaggio = "";
  String IdRisorsa = Misc.nh(request.getParameter("txtIdRisorsa"));
  System.out.println("data rif : " + IdRisorsa);
  String operazione = Misc.nh(request.getParameter("operazione"));  
  Vector vctTimeLineRisorsa = new Vector();
  Vector vctTimeLineConsistenza = new Vector();
  if(!operazione.equals(""))
  {
        System.out.println("operazione 1 " );
        vctTimeLineRisorsa = remoteCtr_Utility.getTimeLineRisorsa(IdRisorsa);
        vctTimeLineConsistenza = remoteCtr_Utility.getTimeLineCons(IdRisorsa);
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
 
  function ONESEGUI()
{ 
        document.frmDati.action = "tmlrisorsa.jsp?operazione=1";
        document.frmDati.submit();
}

  function apriDettPrep(codeInvent,idRisorsa)
  {
    window.open("tmlrisorsaDett.jsp?codeInvent="+codeInvent); 
  }
</SCRIPT>

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<BODY onload = "initialize();">
<table width="100%">
<td width=5%></td>
<td width=95%><img src="../images/TimeLineRisorsa.gif" alt="" border="0">
</td>
</table>
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
  String strNameFirstPage = "tmlrisorsa.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
<!--  <tr>
    <td><img src="../images/TimeLineRisorsa.gif" alt="" border="0"></td>
  </tr>
-->
<tr height="20">
  <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
                    <td class="textB">Identificativo Risorsa: </td>
                    <td class="text">
                        <input type='text' name='txtIdRisorsa' obbligatorio="si" value='' class="text" size="40" >
                    </td>
                    <td >
                    <sec:ShowButtons />
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
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">TimeLine della Risorsa</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctTimeLineRisorsa.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if(vctTimeLineRisorsa.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Identificativo<BR>Risorsa</td>
            <td >Data<BR>DRO</td>      
            <td >Code<BR>Servizio</td>      
            <td >Descrizione<BR>Servizio</td>
            <td >Code<BR>Account</td>                  
            <td >Descrizione<BR>Account</td>      
            <td >CODE_TIPO<BR>CAUS_VARIAZ</td>
            <td >DATA INIZIO<BR>VALIDITA'</td>
            <td >DATA FINE<BR>VALIDITA'</td>
            <td >DATA ULTIMA<BR>APPL_CANONI</td>
            <td >DATA ULTIMA<BR>FATTURAZIONE</td>
            <td >DETTAGLIO</td>
        </tr>
      <% 
  out.flush();
    
  /*if(operazione.equals(""))    {
    vctTimeLineRisorsa = null;
    vctTimeLineRisorsa = remoteCtr_Utility.getTimeLineRisorsa("01/01/1900"); 
  }*/

  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctTimeLineRisorsa.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_TimeLineRisorsa objUtility = (DB_TimeLineRisorsa)vctTimeLineRisorsa.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_ISTANZA_PS().replaceAll(" ","&nbsp;")%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_DRO().substring(0,10)%></td>  
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CONTR()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESC_TIPO_CONTR  ()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_ACCOUNT()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESC_ACCOUNT()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CAUS_VARIAZ()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INIZIO_VALID().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_FINE_VALID().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ULTIMA_APPL_CANONI().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ULTIMA_FATRZ().substring(0,10)%></td>            
            <td  class="<%=classRow%>" align="center">
                    <input class="textB" title="Dettaglio" type="button" maxlength="30" name="cmdDettaglio" bgcolor="<%=StaticContext.bgColorFooter%>" value="..." onClick="apriDettPrep('<%=objUtility.getCODE_INVENT()%>');">
            </td>  
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
<tr height="20">
  <td>
    <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Consistenza della Risorsa</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	
    <table width="100%" cellspacing="1" align="center">
      <%if(vctTimeLineConsistenza.size()!=0){%>
        <tr class="rowHeader" height="20" align="center">
            <td >Identificativo<BR>Risorsa</td>
            <td >Data<BR>DRO</td>      
            <td >Code<BR>Servizio</td>      
            <td >Descrizione<BR>Servizio</td>
            <td >Code<BR>Account</td>                  
            <td >Descrizione<BR>Account</td>      
            <td >CODE_TIPO<BR>CAUS_VARIAZ</td>
            <td >DATA INIZIO<BR>VALIDITA'</td>
            <td >DATA FINE<BR>VALIDITA'</td>
            <td >DATA ULTIMA<BR>APPL_CANONI</td>
            <td >DATA ULTIMA<BR>FATTURAZIONE</td>
            <td >DETTAGLIO</td>
        </tr>
      <% 
  out.flush();
    
  /*if(operazione.equals(""))    {
    vctTimeLineRisorsa = null;
    vctTimeLineRisorsa = remoteCtr_Utility.getTimeLineRisorsa("01/01/1900"); 
  }*/

  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctTimeLineConsistenza.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_TimeLineRisorsa objUtility = (DB_TimeLineRisorsa)vctTimeLineConsistenza.get(i);
           %>
           <TR>
            <td  class="<%=classRow%>" align="center"><a href="tmlrisorsa.jsp?operazione=2&txtIdRisorsa=<%=objUtility.getCODE_ISTANZA_PS()%>"> <%=objUtility.getCODE_ISTANZA_PS().replaceAll(" ","&nbsp;")%></a></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_DRO().substring(0,10)%></td>  
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CONTR()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESC_TIPO_CONTR  ()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_ACCOUNT()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDESC_ACCOUNT()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getCODE_TIPO_CAUS_VARIAZ()%></td> 
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_INIZIO_VALID().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_FINE_VALID().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ULTIMA_APPL_CANONI().substring(0,10)%></td>
            <td  class="<%=classRow%>" align="center"><%=objUtility.getDATA_ULTIMA_FATRZ().substring(0,10)%></td>            
            <td  class="<%=classRow%>" align="center">
                    <input class="textB" title="Dettaglio" type="button" maxlength="30" name="cmdDettaglio" bgcolor="<%=StaticContext.bgColorFooter%>" value="..." onClick="apriDettPrep('<%=objUtility.getCODE_INVENT()%>');">
            </td>  
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
    <A HREF="javaScript:goPage('tmlrisorsa.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('tmlrisorsa.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('tmlrisorsa.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
    </pg:next>
    </pg:index>
    </pg:pager>
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