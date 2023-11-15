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
  <%=StaticMessages.getMessage(3006,"bon_rag_soc_olo.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  
  String messaggio = "";
  Integer esito = 0;
  Vector vctAccountOLO = new Vector();
  String risorsa = Misc.nh(request.getParameter("txtAccount"));
  String operazione = Misc.nh(request.getParameter("operazione"));  
  String codAccount = Misc.nh(request.getParameter("CodAccountSel"));
  String descAccount = Misc.nh(request.getParameter("descAccount"));
  String flgRadio = Misc.nh(request.getParameter("flagRadio"));

  if(operazione.equals("1"))
  {
        if (!risorsa.equals("")) {
        vctAccountOLO = remoteCtr_Utility.getRagSocOlo(risorsa);
        }
        else
           {
        messaggio = "Digitare l'account OLO da modificare";
        }
    }

   
  if (operazione.equals("2"))
  {
    if (flgRadio.equals("S"))
    {
      esito = remoteCtr_Utility.updRagSocOlo(codAccount,descAccount);
      
      if(esito==0)
        messaggio = "Aggiornamento account effettuato correttamente.";
      else
        messaggio = "Errore durante aggiornamento account.";
        
      flgRadio="";  
    }
    else
    { 
    messaggio = "E' necessario selezionare un account OLO da aggiornare";
    }
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
 
function ONPOPOLALISTA()
{ 
        document.frmDati.action = "bon_rag_soc_olo.jsp?operazione=1";
        document.frmDati.submit();
}

function ChangeSel(codiceaccount,indice)
{
  objForm.CodAccountSel.value=codiceaccount;
  objForm.DescAccountSel.value=eval('objForm.SelAccount[indice].value');
  objForm.flagRadio.value="S";
}

function ONAGGIORNA()
{ 
        document.frmDati.action = "bon_rag_soc_olo.jsp?operazione=2";
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

    if (operazione.equals("1")) {
        if (!risorsa.equals("")) {
            vctAccountOLO = remoteCtr_Utility.getRagSocOlo(risorsa);
        }   
        else
        {
            messaggio = "Digitare l'account OLO da modificare";
        }
  }
  
  String strNameFirstPage = "bon_rag_soc_olo.jsp";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    
  
%>
<table name="tblElab" id="tblElab" align=center width="90%" border="0" cellspacing="0" cellpadding="0" height="100%" style="display:none">
  <tr>
    <td><img src="../images/BonifRagione.gif" alt="" border="0"></td>
  </tr>
<tr height="20">
  <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
            <td class="textB">Ragione Sociale OLO: </td>
            <td  class="text">
                <input class="text" type='text' name='txtAccount' obbligatorio="si" value=''  >
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
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Account OLO trovati</td>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
      </tr>
    </table>
  </td>
</tr>
<TR valign="top">
  <TD>
  	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctAccountOLO.size()%>">
    <table width="100%" cellspacing="1" align="center">
      <%if((vctAccountOLO!=null) && (vctAccountOLO.size()!=0)){%>
        <tr class="rowHeader" height="20" align="center">
            <td ></td>
            <td >CODE ACCOUNT</td>      
            <td >DESC ACCOUNT</td>      
       </tr>
      <%  
  out.flush();
    
  vctAccountOLO = remoteCtr_Utility.getRagSocOlo(risorsa); 
  
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
    
      
        String classRow = "row2"; 
        
        for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctAccountOLO.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
           classRow = classRow.equals("row2") ? "row1" : "row2";
           DB_AccountOlo objUtility = (DB_AccountOlo)vctAccountOLO.get(i);
           %>
           <TR>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="2%" class="<%=classRow%>">
                <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' name='SelAccount' value='<%=objUtility.getDESC_ACCOUNT()%>' onclick=ChangeSel('<%=objUtility.getCODE_ACCOUNT()%>','<%=i%>') onchange=ChangeSel('<%=objUtility.getCODE_ACCOUNT()%>','<%=i%>')>
            </td>
            
            <td  width="20%" class="<%=classRow%>"  align="center"><%=objUtility.getCODE_ACCOUNT()%></td> 
            
            <td width="78%" class="<%=classRow%>"  >
                <input   class="<%=classRow%>" type='text' size='70' name='descAccount' value="<%=objUtility.getDESC_ACCOUNT()%>"  />
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
    <A HREF="javaScript:goPage('bon_rag_soc_olo.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
    </pg:prev>
    <pg:pages>
      <%if (pageNumber == pagerPageNumber){%>
             <b><%=pageNumber%></b>&nbsp;
      <%}else{%>
              <A HREF="javaScript:goPage('bon_rag_soc_olo.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
      <%}%>
    </pg:pages>
    <pg:next>
      <A HREF="javaScript:goPage('bon_rag_soc_olo.jsp')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
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
  <tr>
    <td>
	<input type=hidden name="CodAccountSel" >
	<input type=hidden name="DescAccountSel">
	<input type=hidden name="flagRadio" value="">
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