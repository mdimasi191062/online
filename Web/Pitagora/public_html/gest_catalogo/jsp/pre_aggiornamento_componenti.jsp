<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>

<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_aggiornamento_componenti.jsp")%>
</logtag:logData>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Aggiornamento Componente";

  //Vector vctGruppiOff = null;
  //DB_Anag_Class_Off anag_class_off = null;
  String code_componente_input = Misc.nh(request.getParameter("code_componente"));


  //AP Aggiunta modifica descrizione
  String modifica_descrizione = Misc.nh(request.getParameter("modifica_descrizione"));
  String disabled = null;
  if (!modifica_descrizione.equals("")){
   disabled = "disabled";
  }


  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Componenti
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

function ONCONFERMA() {
  if(document.frmDati.strCodeComponente.value.length==0){
    alert('Il Codice è obbligatorio.');
    document.frmDati.strCodeComponente.focus();
    return;
  }
  if(document.frmDati.strDescComponente.value.length==0){
    alert("Descrizione è obbligatorio.");
    document.frmDati.strDescComponente.focus();
    return;
  }
  if(!CheckNum(document.frmDati.strCodeComponente.value,9,0,false)){
    alert('Codice Componente deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.strCodeComponente.focus();
    return;
  }

  opener.frmDati.strCodeCompo.value = document.frmDati.strCodeComponente.value;
  opener.frmDati.strDescCompo.value = document.frmDati.strDescComponente.value;


  /* AP Aggiunta modifica descrizione  */ 
  opener.frmDati.strFlagModificaDescrizione.value = document.frmDati.strFlagModificaDescrizione.value;


  opener.frmDati.intAggiornamento.value = "2";
  opener.frmDati.hidTypeLoad.value = "0";
      
  self.close();
  opener.frmDati.submit();
}

function ONANNULLA() {
  document.frmDati.strDescComponente.value = "";
  document.frmDati.strDescComponente.focus();
}

function uppercase(obj){
  var value = obj.value;
  obj.value = value.toUpperCase();
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action=''>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="componenti" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
Vector accountVector=null;
accountVector = componenti.getPreComponente(code_componente_input);
DB_Componente myelement = new DB_Componente();
for(int j=0;j < accountVector.size();j++)	
{
  myelement=(DB_Componente)accountVector.elementAt(j);
}
%>

<!-- AP Aggiunta modifica descrizione -->
<INPUT type="hidden" name="strFlagModificaDescrizione" value="<%=modifica_descrizione%>"> 




<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/catalogo.gif" alt="" border="0"></td>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
          <td height="30" width="35%" class="textB" align="right" nowrap>Codice Componente</td>
          <TD>
            <!-- AP Aggiunta modifica descrizione -->
            <INPUT class="text" id="strCodeComponente" name="strCodeComponente"  obbligatorio="si" tipocontrollo="intero" label="Codice Componente" Update="false" size="35" maxlength=9 <%=disabled%> readonly="readonly" value="<%=myelement.getCODE_COMPONENTE()%>">
          </TD>
        </tr>
        <tr>
          <td height="30" width="35%" class="textB" align="right" nowrap>Descrizione Componente</td>
          <td>
            <input class="text" id="strDescComponente" name="strDescComponente"  obbligatorio="si" tipocontrollo="intero" label="Descrizione Componente" Update="false" size="35" value="<%=myelement.getDESC_COMPONENTE()%>">
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
</form>
</BODY>
</HTML>