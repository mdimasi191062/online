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
  <%=StaticMessages.getMessage(3006,"annulla_ordine.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<%
  int esito = 0;
  String messaggio = "";
  String IdOrdCrmws = Misc.nh(request.getParameter("txtIdOrdCrmws"));
  String tracciamento = Misc.nh(request.getParameter("txtTracciamento"));
  String dataAcq = Misc.nh(request.getParameter("txtdataAcq"));
  String operazione = Misc.nh(request.getParameter("operazione"));  

  if(!operazione.equals(""))
  {

      esito = remoteCtr_Utility.annullaOrdine(IdOrdCrmws,tracciamento,dataAcq);

      if(esito==1)
        messaggio = "Annulla Ordine effettuato correttamente.";

      if(esito==2)
        messaggio = "Errore Annulla Ordine: (code_caus_ull 1): tipo_flag_acq_rich non gestito.";

      if(esito==3)
        messaggio = "Errore Annulla Ordine: (code_caus_ull 2): tipo_flag_acq_rich non gestito.";  
        
      if(esito==4)
        messaggio = "Errore Annulla Ordine: code_caus_ull non gestito.";        

      if(esito==5)
        messaggio = "Errore Annulla Ordine: Errore generico.";  
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
        if(document.frmDati.txtIdOrdCrmws.value==''){
            alert('Digitare ID Ordine CRMWS.');
            document.frmDati.comboServizi.focus();
        return;
        }
        
        if(document.frmDati.txtTracciamento.value==''){
            alert('Digitare il Codice Tracciamento.');
            document.frmDati.comboServizi.focus();
        return;
        }   
        
        if(document.frmDati.txtdataAcq.value==''){
            alert('Selezionare la Data Acquisizione.');
            document.frmDati.comboServizi.focus();
        return;
        } 

        document.frmDati.action = "annulla_ordine.jsp?operazione=1";
        document.frmDati.submit();
}

</SCRIPT>

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<BODY onload = "initialize();">
<table width="100%">
<td width=5%></td>
<td width=95%><img src="../images/AnnullaOrdine.gif" alt="" border="0">
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
<table name="tblElab" id="tblElab" align=center valign=top width="90%" border="0" cellspacing="0" cellpadding="0" style="display:none">
<!--  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0" ></td>
  </tr>
  -->
<tr>
  <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
            <td class="textB">Id Ordine CRMWS: </td>
            <td  class="text">
                <input class="text" type='text' name='txtIdOrdCrmws' obbligatorio="si" value=''  >
            </td>
       </tr>
        <tr height="35px">
            <td class="textB">Tracciamento: </td>
            <td  class="text">
                <input class="text" type='text' name='txtTracciamento'  obbligatorio="si" value=''  >
            </td>
       </tr>    
       <tr height="35px">
            <td class="textB">Data Acquisizione: </td>
            <td class="text">
                <input type='text' name='txtdataAcq' obbligatorio="si" value='' class="text" readonly >
                <a href="javascript:showCalendar('frmDati.txtdataAcq','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
		<a href="javascript:clearField(objForm.txtdataAcq);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
            </td>
       </tr>     
        </table>
  </td>
<tr height="28">
  <td >
    <sec:ShowButtons td_class="textB"/>
  </td>
</tr>

</TABLE>
</FORM>
</body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  document.all('tblElab').style.display = '';

var http=getHTTPObject();

if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
</html>