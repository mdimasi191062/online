<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>

<sec:ChkUserAuth isModal="true" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"agg_ScodamentoEventi.jsp")%>
</logtag:logData>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Aggiornamento Scodamento Eventi di Fatturazione";

  String cod_lotto_input = Misc.nh(request.getParameter("CodLotto"));
  
  String sistema = Misc.nh(request.getParameter("sistema"));
  
  String disabled = "disabled";
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Aggiornamento Scodamento Eventi
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
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
  document.frmDati.CodLotto.value="";
  document.frmDati.DataFine.value="";
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
    if(document.frmDati.CodLotto.value.length==0){
      alert('Il Codice Lotto è obbligatorio.');
      document.frmDati.CodLotto.focus();
      return;
    }

    if (isNaN(document.frmDati.CodLotto.value)) {
      alert("il valore inserito per il Codice Lotto non è un numero");
      document.frmDati.CodLotto.focus();
      return;
    }



    if(document.frmDati.DataFine.value.length==0){
      alert('La data fine è obbligatoria.');
      return;
    }

//    alert(document.frmDati.CodLotto.value+" "+document.frmDati.DataFine.value);
    opener.frmDati.strCodLotto.value = document.frmDati.CodLotto.value;
    opener.frmDati.strDataFine.value = document.frmDati.DataFine.value;
   
    opener.frmDati.hidTypeLoad.value = "0";
    opener.frmDati.intAggiornamento.value = "2";

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

<EJB:useHome id="home" type="com.ejbSTL.ScodamentoEventiHome" location="ScodamentoEventi" />
<EJB:useBean id="scodamentoEventi" type="com.ejbSTL.ScodamentoEventi" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
Vector accountVector=null;

accountVector = scodamentoEventi.getScodamentoEventi();

DB_ScodamentoEventi myelement = new DB_ScodamentoEventi();

for(int j=0;j < accountVector.size();j++)	
{
  myelement=(DB_ScodamentoEventi)accountVector.elementAt(j);
}
%>


<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/scodamento_eventi.gif" alt="" border="0"></td>
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
        <tr>
          <td  class="textB" align="left">Codice Lotto:</td>
          <td  class="text" align="left" colspan="2">
            <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
            <input type="text" class="text" name="CodLotto" value="<%=myelement.getCOD_LOTTO()%>"  maxlength="6" size="6" style="margin-left: 1px;" >
            <input type="hidden" class="text" size=12 maxlength="12" name="DataFine" title="DataFine" value="<%=myelement.getDATA_FINE()%>" onblur="handleblur('data_fine');"  <%=disabled%>>
          </td> 
        </tr>
       
<%--
        <tr>

          <td  class="textB" align="left">Data Fine </td>      
          <td  class="text" align="left" colspan="2">
            <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->          
            <input type="text" class="text" size=12 maxlength="12" name="DataFine" title="DataFine" value="<%=myelement.getDATA_FINE()%>" onblur="handleblur('data_fine');"  <%=disabled%>>
       <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario_dfv' src="../../common/images/img/cal.gif" border="no"></a>
            <a href="javascript:cancelCalendar(document.frmDati.DataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data_dfv' src="../../common/images/img/images7.gif" border="0"></a>

</td>
        </tr>
--%>
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
</form>
<script language="JavaScript">

       // Calendario Data Fine Validità       
     var cal2 = new calendar1(document.forms['frmDati'].elements['DataFine']);
			 cal2.year_scroll = true;
			 cal2.time_comp = false;
       
 </script>
</BODY>
</HTML>