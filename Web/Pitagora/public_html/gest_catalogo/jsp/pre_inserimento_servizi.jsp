<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_servizi.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
  String codice_corretto = null;
    
  strTitolo="Inserimento Servizio";

  String codiceDB = "";
  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Offerte
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/off_serv.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";
var codice_db = "<%= codiceDB%>";

function impostaFocus()
{

  for(var i=0;i<document.forms[0].elements.length;i++)
  {
      if(document.forms[0].elements[i].type=="text")
      {      
        document.forms[0].elements[i].focus();
        break;
      }
  }
}   

function ONANNULLA()
{
   resetValue();
}   

function chkData(strData){
			var dataDiOggi = new Date();
      var data = new Date(strData.substring(6,10),strData.substring(3,5)-1,strData.substring(0,2),"23","59","59");
      if(data<dataDiOggi)
				return false;
      return true;
}


function ONCONFERMA()
{
  if(document.frmDati.codice.value.length==0){
    alert('Il Codice è obbligatorio.');
    document.frmDati.codice.focus();
    return;
  }
  if(document.frmDati.descrizione.value.length==0){
    alert("Descrizione è obbligatorio.");
    document.frmDati.descrizione.focus();
    return;
  }
  if(document.frmDati.dataIni.value.length==0){
    alert('La data inizio validità è obbligatoria.');
    return;
  }
  if(document.frmDati.dataFine.value.length==0){
    alert('La data fine validità è obbligatoria.');
    return;
  }

  opener.frmDati.strCodeServ.value = document.frmDati.codice.value;
  opener.frmDati.strDescServ.value = document.frmDati.descrizione.value;
  opener.frmDati.strDIVServ.value = document.frmDati.dataIni.value;
  opener.frmDati.strDFVServ.value = document.frmDati.dataFine.value;
  opener.frmDati.strAppValEurServ.value = document.frmDati.appl_val_eur.value;
  opener.frmDati.hidTypeLoad.value = "0";

  self.close();
  opener.frmDati.submit();
}

function cancelCalendar (obj)
{
  obj.value="";
}

function setCheck(checked){
  if(checked)
    document.frmDati.appl_val_eur.value = "1";
  else
    document.frmDati.appl_val_eur.value = "0";
}

function resetValue(){
   document.frmDati.codice.value = document.frmDati.codice_corretto.value;
   document.frmDati.descrizione.value = "";
   document.frmDati.dataIni.value = "";
   document.frmDati.dataFine.value = "31/12/2099";
   document.frmDati.app_euribor.checked = false;
   document.frmDati.appl_val_eur.value = "0";
}

function ONCHIUDI(){
   window.close();
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action='pre_inserimento_servizi.jsp?operazione=1'>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="servizi" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
  codiceDB = servizi.getCodiceServizio();
  codice_corretto = codiceDB;
%>
<input type="hidden" name="codiceDB" id="codiceDB" value="<%=codiceDB%>">
<input type="hidden" name="codice_corretto" id="codice_corretto" value="<%=codice_corretto%>">
<input type="hidden" name="appl_val_eur" id="appl_val_eur" value="0">

<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/catalogo.gif" alt="" border="0"></td>
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%= strTitolo %></td>
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
      <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="left">Codice:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="codice" value="<%=codiceDB%>" maxlength="8" size="10" style="margin-left: 1px;">
        </td> 
      </tr>
      <tr>
        <td  class="textB" align="left">Descrizione:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="descrizione" maxlength="50" size="55" value="">
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Data Inizio Validità:</td>      
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" size=12 maxlength="12" name="dataIni" title="dataIni" value="" onblur="handleblur('data_ini');" readonly>
          <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
          <a href="javascript:cancelCalendar(document.frmDati.dataIni);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Data Fine Validità:</td>      
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" size=12 maxlength="12" name="dataFine" title="dataFine" value="31/12/2099" onblur="handleblur('data_fine');" readonly>
          <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
          <a href="javascript:cancelCalendar(document.frmDati.dataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Appl. Valore % Euribor:</td>
        <td  class="text" align="left" colspan="2">
          <input type="checkbox" name="app_euribor" onclick="setCheck(this.checked)">
        </td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='10'></td>
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
<script language="JavaScript">
       // Calendario Data Inizio Validità
       var cal1 = new calendar1(document.forms['frmDati'].elements['dataIni']);
			 cal1.year_scroll = true;
			 cal1.time_comp = false;
       // Calendario Data Fine Validità       
       var cal2 = new calendar1(document.forms['frmDati'].elements['dataFine']);
			 cal2.year_scroll = true;
			 cal2.time_comp = false;
 </script>
</BODY>
</HTML>