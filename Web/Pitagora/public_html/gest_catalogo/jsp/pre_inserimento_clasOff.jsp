<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_clasOff.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Inserimento Classe Offerta";

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Classi Offerte
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/off_serv.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">

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
   document.frmDati.CodeClassOff.value = document.frmDati.codice_corretto.value;
   document.frmDati.DescClassOff.value = "";
}

function ONCHIUDI()
{
   window.close();
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
    if(document.frmDati.CodeClassOff.value.length==0){
      alert('Il Codice è obbligatorio.');
      document.frmDati.CodeClassOff.focus();
      return;
    }
    if(document.frmDati.DescClassOff.value.length==0){
      alert("Descrizione è obbligatorio.");
      document.frmDati.DescClassOff.focus();
      return;
    }
    if(!CheckNum(document.frmDati.CodeClassOff.value,9,0,false)){
      alert('Codice Classe Offerta deve essere un numero e non deve superare le 9 cifre.');
      document.frmDati.CodeClassOff.focus();
      return;
    }
    opener.frmDati.strCodeClassOff.value = document.frmDati.CodeClassOff.value;
    opener.frmDati.strDescClassOff.value = document.frmDati.DescClassOff.value;
    opener.frmDati.hidTypeLoad.value = "0";
    opener.frmDati.intAggiornamento.value = "1";
    self.close();
    opener.frmDati.submit();
    
  }
}


</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action=''>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="classOff" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
String codiceDB = "";
String codice_corretto = "";

codiceDB = classOff.getCodiceClassOff();
codice_corretto = codiceDB;
%>

<input type="hidden" name="codiceDB" id="codiceDB" value="<%=codiceDB%>">
<input type="hidden" name="codice_corretto" id="codice_corretto" value="<%=codice_corretto%>">

<!-- INIZIO INSERIMENTO CLASSE OFFERTA -->
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
      <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
        <tr>
          <td  class="textB" align="left">Codice:</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="CodeClassOff" value="<%=codiceDB%>" maxlength="9" size="10" style="margin-left: 1px;">
          </td> 
        </tr>
        <tr>
          <td  class="textB" align="left">Descrizione:</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="DescClassOff" maxlength="50" size="55" value="">
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
</BODY>
</HTML>