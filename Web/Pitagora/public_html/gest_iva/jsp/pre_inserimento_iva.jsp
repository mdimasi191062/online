<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_iva.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Inserimento Aliquota Iva";

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Aliquota Iva
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

function ONCHIUDI(){
   window.close();
}

function ONANNULLA()
{

//   window.close();
document.frmDati.CodeAliquota.value="";
document.frmDati.DescAliquota.value="";
document.frmDati.Aliquota.value="";
document.frmDati.dataIni.value="";
document.frmDati.dataFine.value="";
}   

function ONCONFERMA()
{
  if (!opener || opener.closed) 
  {
	window.alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
    self.close();
    return false;
  }
  else
  {
    /*if(document.frmDati.CodeAliquota.value.length==0){
      alert('Codice Aliquota è obbligatorio.');
      document.frmDati.Aliquota.focus();
      return;
    }*/
    
    if(document.frmDati.Aliquota.value.length==0){
      alert('Aliquota è obbligatorio.');
      document.frmDati.Aliquota.focus();
      return;
    }

    if(document.frmDati.dataIni.value.length==0){
      alert('La data inizio validità è obbligatoria.');
      return;
    }

    opener.frmDati.strCodeAliquota.value = document.frmDati.CodeAliquota.value;
    opener.frmDati.strDescAliquota.value = document.frmDati.DescAliquota.value;
    opener.frmDati.strAliquota.value = document.frmDati.Aliquota.value;
    opener.frmDati.strDIVAliquota.value = document.frmDati.dataIni.value;
    opener.frmDati.strDFVAliquota.value = document.frmDati.dataFine.value;
    
    opener.frmDati.hidTypeLoad.value = "0";
    opener.frmDati.intAggiornamento.value = "1";

    self.close();
    opener.frmDati.submit();
  }
}

function uppercase(obj){
  var value = obj.value;
  obj.value = value.toUpperCase();
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action=''>

<!-- INIZIO INSERIMENTO CLASSE OFFERTA -->
<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/aliquota_iva.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
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

        <!-- Non visibile -->
        <tr style="display:none">
          <td  class="textB" align="left">Codice:</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="CodeAliquota" value="0" maxlength="3" size="5" style="margin-left: 1px;" onchange="uppercase(this)">
          </td> 
        </tr>
        
        <!-- Non visibile -->
        <tr style="display:none">
          <td  class="textB" align="left">Descrizione:</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="DescAliquota" maxlength="50" size="55" value="" onchange="uppercase(this)">
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
          <td  class="textB" align="left">Aliquota IVA &#37; :</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="Aliquota" value="" maxlength="2" size="4" style="margin-left: 0px;"  onkeypress='return (event.keyCode >= 48 && event.keyCode <= 57)'>
          </td> 
        </tr>
       
        
        <!-- Non visibile -->
        <tr style="display:none">
          <td  class="textB" align="left">Data Fine Validità:</td>      
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" size=12 maxlength="12" name="dataFine" title="dataFine" value="31/12/2099" onblur="handleblur('data_fine');" readonly>
            <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
            <a href="javascript:cancelCalendar(document.frmDati.dataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
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
	    <table width="100%" border="1" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
<!-- FINE INSERIMENTO CLASSE OFFERTA -->
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