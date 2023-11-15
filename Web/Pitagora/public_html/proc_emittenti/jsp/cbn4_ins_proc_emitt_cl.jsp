<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_ins_proc_emitt_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONANNULLA()
{
  
  if( window.document.frmDati.txtProcedureEmittente.value.length!=0 ||
      window.document.frmDati.txtCodiceEmittente.value.length!=0 ){
    if (confirm('Sono state apportate delle modifiche all\'elemento corrente.\nVuoi ignorarle?')==true)
    {
      window.close();
    }
   }else {
     window.close();
  }    
}

function ONCONFERMA()
{
  if( window.document.frmDati.txtProcedureEmittente.value.length==0){
    alert('Il campo Procedure Emittente é obbligatorio');
    window.document.frmDati.txtProcedureEmittente.focus();
    return(false);
  }
  if( window.document.frmDati.txtCodiceEmittente.value.length==0){
    alert('Il campo Codice Emittente é obbligatorio');
    window.document.frmDati.txtCodiceEmittente.focus();
    return(false);
  }
  if (confirm('Si conferma l\'inserimento della Procedure Emittente')==true)
  {
    window.document.frmDati.submit();
  }
}

</SCRIPT>


<TITLE>Inserimento Procedura Emittente</TITLE>

</HEAD>
<BODY>
<form name="frmDati" method="post" action='salva_proc_emitt_cl.jsp'>
<%
    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtnumPag=request.getParameter("txtnumPag");
  String txtCodRicerca = request.getParameter("txtCodRicerca");
%>
<input type="hidden" name="txtnumRec" value="<%=txtnumRec%>">
<input type="hidden" name="numRec" value="<%=NumRec%>">
<input type="hidden" name="txtnumPag" value="<%=txtnumPag%>">
<input type="hidden" name="txtCodRicerca" value="<%=txtCodRicerca%>">
<BR><BR><BR>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/procemittenti.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Nuova Procedura Emittente</td>
						  <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
						</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="right">Procedura Emittente:</td>
        <td  class="text" align="right"><input type="text" class="text" name="txtProcedureEmittente"  maxlength="100"></td>
      </tr>   
      <tr>
        <td  class="textB" align="right">Codice Emittente:</td>
        <td  class="text" align="right"><input type="text" class="text" name="txtCodiceEmittente"  maxlength="20"></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	        
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>
