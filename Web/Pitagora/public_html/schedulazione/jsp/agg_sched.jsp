<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"agg_sched.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  ClassSchedBatchElem rigaSched = null;

  //Gestione Paramteri Navigazione
  String CodSel = request.getParameter("CodSel");
  int operazione = Integer.parseInt(request.getParameter("operazione"));  
  //Parametro in ingresso con valore = 1 pagina richiamata da aggiorna 
  //                      con valore = 2 pagina richiamata da elimina 
  String strQueryString = request.getQueryString();
  String idSched = request.getParameter("idSched");
  String messaggio = request.getParameter("messaggio");
  if(messaggio == null)
    messaggio = "";
  
  String strTitolo = null;
 
  String ID_SCHED   = null;
  String CODE_UTENTE= null;  
  String CODE_FUNZ  = null;
  String DESC_FUNZ  = null;
  String CODE_STATO = null;
  String DESC_STATO = null;  
  String DATA_INS   = null;
  String DATA_SCHED = null;

  // Gestione del Titolo
  if (operazione==1)
  {  
      strTitolo="Modifica Schedulazione";
  }    
  else if (operazione==2)
  {
      strTitolo="Cancellazione Schedulazione";
  }

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Gestione utenti
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar1.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>

<script language="JavaScript">
var operazione=<%=operazione%>
function impData(strData)
{
  var appo = strData.substring(3,5) + "/" + strData.substring(0,2) + "/" + strData.substring(6,10);
  return appo;
}


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
   window.close();
}

function ONCONFERMA()
{
    if(operazione==2)
    {
      Cancella();
    }
    else
    {
      Salva();
    }
}   

function Cancella()
{
   document.frmDati.submit();
} 


function chkData(strData)
{
   var dataDiOggi = new Date();
	 var data = new Date(strData.substring(6,10),strData.substring(3,5)-1,strData.substring(0,2));
	 if(data<dataDiOggi)
	   return false;
   return true;
}


function Salva()
{
  if(document.frmDati.DATA_SCHED.value == null || document.frmDati.DATA_SCHED.value == "")
  {
    alert('Attenzione!!Inserire Data Schedulazione.');
    return;
  }
  
  document.frmDati.submit();
}

function cancelCalendar (obj)
{
  obj.value="";
}

function showMessage (field)
{
  if (field=='seleziona1')
		self.status=msg1;
 	else
 		self.status=msg2;
}

</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action='salva_sched.jsp?<%=strQueryString%>'>
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">

<EJB:useHome id="homeSchedBatch" type="com.ejbSTL.SchedBatchSTLHome" location="SchedBatchSTL" /> 
<EJB:useBean id="remoteSchedBatch" type="com.ejbSTL.SchedBatchSTL" value="<%=homeSchedBatch.create()%>" scope="session"></EJB:useBean>


<% 
      rigaSched  = remoteSchedBatch.loadSched(idSched);
      ID_SCHED   = rigaSched.getIdSched();
      CODE_FUNZ  = rigaSched.getCodeFunz();
      DESC_FUNZ  = rigaSched.getDescFunz();
      CODE_STATO = rigaSched.getCodeStatoSched();
      DESC_STATO = rigaSched.getDescStatoSched();  
      DATA_INS   = rigaSched.getDataOraInsSched();
      DATA_SCHED = rigaSched.getDataOraSched();
      CODE_UTENTE= rigaSched.getCodeUtente();
%>
<!--<input type="hidden" name="strQueryString" value="<%=strQueryString%>">-->
<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/gestsched.gif" alt="" border="0"></td>
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
        <td  class="textB" align="left">Utente:<input type="hidden" name="APPO_PWD"></td>
        <td  class="text" align="left" colspan="2">
        <input type="hidden" name="CODE_UTENTE" value="<%=CODE_UTENTE%>">
          <%out.println(CODE_UTENTE);%>
        </td> 
      </tr>
      <tr>
        <td  class="textB" align="left">Funzione:</td>
        <td  class="text" align="left" colspan="2">
          <%out.println(DESC_FUNZ);%>
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Stato:</td>
        <td  class="text" align="left" colspan="2">
          <%out.println(DESC_STATO);%>
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Data Schedulazione:</td>
        <%
        if(operazione == 2){
        %>
        <td class="text" align="left" colspan="2"><%out.println(DATA_SCHED);%></td>
        <%
        }else{
        %>
        <td class="text" align="left" colspan="2">
           <input type="text" class="text" name="DATA_SCHED" size="22" maxlength="22" value="<%out.println(DATA_SCHED);%>">
           <a href="javascript:cal3.popup();"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>&nbsp;
           <a href="javascript:cancelCalendar(document.frmDati.DATA_SCHED);"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
           &nbsp;
        </td>
        <%
        }
        %>
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
	if(document.frmDati.messaggio.value != ""){
    alert(document.frmDati.messaggio.value);
    document.frmDati.messaggio.value = "";
  }
</script>
<%
if(operazione == 1){
%>
<script language="JavaScript">
	var cal3 = new calendar1(document.forms['frmDati'].elements['DATA_SCHED']);
  cal3.year_scroll = true;
	cal3.time_comp = true;
</script>
<%
}
%>
</BODY>
</HTML>