<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_aggiornamento_clasoff.jsp")%>
</logtag:logData>


<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Aggiornamento Offerta";

  Vector vctGruppiOff = null;
  String code_classe_offerta = Misc.nh(request.getParameter("code_classe_offerta"));

  // QS: 4.9 Aggiunta gestione modifica descrizione
  String modifica_descrizione = Misc.nh(request.getParameter("modifica_descrizione"));
  String disabled = null;
  if (modifica_descrizione.equals("")){
   disabled = "disabled";
  }
 

  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Classe Offerta
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

function ONANNULLA()
{
   //QS 4.9 resetValue();
   document.frmDati.descrizione.value = "";
 
}

function ONCONFERMA()
{
  if(document.frmDati.descrizione.value.length==0){
    alert("Descrizione è obbligatorio.");
    document.frmDati.descrizione.focus();
    return;
  }
  
  opener.frmDati.strCodeClassOff.value = document.frmDati.codice.value;
  opener.frmDati.strDescClassOff.value = document.frmDati.descrizione.value;
  
  opener.frmDati.hidTypeLoad.value = "0";
  opener.frmDati.intAggiornamento.value = "2";

  //QS 4.9  Aggiunta gestione flag_modifica_descrizione
  opener.frmDati.strFlagModificaDescrizione.value = document.frmDati.strFlagModificaDescrizione.value;
  
  self.close();
  opener.frmDati.submit();
}

function ONCHIUDI(){
   window.close();
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action=''>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="offerte" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
Vector accountVector=null;
accountVector = offerte.getClassOff_codeClasOff(code_classe_offerta);
DB_Anag_Class_Off myelement = new DB_Anag_Class_Off();
for(int j=0;j < accountVector.size();j++)	
{
  myelement=(DB_Anag_Class_Off)accountVector.elementAt(j);
}

%>
<input type="hidden" name="code_classe_offerta" id="codiceDB" value="<%=code_classe_offerta%>">
<!--  QS - AP Aggiunta gestione flag_modifica_descrizione -->
<INPUT type="hidden" name="strFlagModificaDescrizione" value="<%=modifica_descrizione%>">  

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
          <input readonly type="text" class="text" name="codice" value="<%=myelement.getCODE_CLASSE_OFFERTA()%>" maxlength="9" size="10" style="margin-left: 1px;" readonly>
        </td> 
      </tr>
      <tr>
        <td  class="textB" align="left">Descrizione:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="descrizione" maxlength="50" size="55" value="<%=myelement.getDESC_CLASSE_OFFERTA()%>">
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
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center"/>        
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>

