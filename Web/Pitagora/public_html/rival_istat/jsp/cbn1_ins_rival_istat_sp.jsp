<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_rival_istat_sp.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtnumPag=request.getParameter("txtnumPag");
  String txtCodRicerca = request.getParameter("txtCodRicerca");


  %>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONANNULLA(){
 window.close();
}

function ONESEGUI(){

   /* richiede quattro parametri:
    1) il valore da testare, obbligatorio;
    2) il numero massimo di cifre, opzionale (default 50);
    3) il numero di decimali, opzionale (default 0);
    4) booleano negativo sì o no, opzionale (default true)
       Se il numero è decimale, impostando 2) e 3) si decide
       anche la lunghezza massima della parte intera.
       Restituisce true o false a seconda che siano o meno rispettati
      i criteri impostati
   */
  if(window.document.frmDati.txtIndiceIstat.value.length == 0){
     alert('Il campo Indice Istat é obbligatorio');
     window.document.frmDati.txtIndiceIstat.focus();
     return(false);
    }     
  if(!CheckNum(window.document.frmDati.txtIndiceIstat.value,6,4)){
      alert('Il valore Indice Istat deve essere un numero positivo composto da 2 cifre intere e 4 decimali '); 
      window.document.frmDati.txtIndiceIstat.focus(); 
      return(false);       
  }  
  if(window.document.frmDati.txtIndiceIstat.value<0){
      alert('Il valore Indice Istat deve essere un numero positivo composto da 2 cifre intere e 4 decimali '); 
      window.document.frmDati.txtIndiceIstat.focus(); 
      return(false);       
  }  
  if(window.document.frmDati.txtANNO.value.length == 0){
   alert('Il campo Anno é obbligatorio');
   window.document.frmDati.txtANNO.focus();
   return(false);
  }   
  if(!CheckNum(window.document.frmDati.txtANNO.value,4)){
   alert('Inserire un valore numerico per l\'anno!');
   window.document.frmDati.txtANNO.focus();
   return(false);
  }   

   if (confirm('Si conferma l\'inserimento del nuovo Indice Istat')==true)
   {
    window.document.frmDati.submit();
   }
}

</SCRIPT>

<TITLE>Inserimento Indice Istat</TITLE>
</HEAD>
<BODY>
<form name="frmDati" method="post" action='salva_rival_istat_sp.jsp'>
<input type="hidden" name="txtnumRec" value="<%=txtnumRec%>">
<input type="hidden" name="numRec" value="<%=NumRec%>">
<input type="hidden" name="txtnumPag" value="<%=txtnumPag%>">
<input type="hidden" name="txtCodRicerca" value="<%=txtCodRicerca%>">
<br>
<br>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/rivalutazioneistat.gif" alt="" border="0"></td>
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Inserimento Indice Istat</td>
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
        <td  class="textB" align="left" width="40%">Anno:</td>
        <td  class="text" align="left" width="60%"><input type="text" class="text" name="txtANNO" size="4" MAXLENGTH="4" ></td>
      </tr>   
      <tr>
        <td  class="textB" align="left">Indice Istat:</td>
        <td  class="text" align="left"><input type="text" class="text" name="txtIndiceIstat" size="7" MAXLENGTH="7"></td>      
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
