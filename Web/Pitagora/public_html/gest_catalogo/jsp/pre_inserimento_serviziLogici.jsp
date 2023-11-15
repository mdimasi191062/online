<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_serviziLogici.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="entCatalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = "Inserimento Servizio Logico";

  // Progressivo del Codice Servizio Logico
  String codiceDB = entCatalogo.getCodiceServizioLogico();
  String codice_corretto = codiceDB;

  Vector vctServizi = null;
  DB_Servizio servizio = null;
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Servizi Logici
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>

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
   document.frmDati.codice.value = document.frmDati.codice_corretto.value;
   document.frmDati.descrizione.value = "";
   document.frmDati.descBreve.value = "";
   document.frmDati.cboServizi.value = "";
}   

function ONSALVA()
{
  if(document.frmDati.codice.value.length==0){
    alert('Il Codice è obbligatorio.');
    document.frmDati.codice.focus();
    return;
  }
  if(document.frmDati.descrizione.value.length==0){
    alert("La Descrizione è obbligatoria.");
    document.frmDati.descrizione.focus();
    return;
  }
  if(document.frmDati.descBreve.value.length==0){
    alert("La Descrizione breve è obbligatoria.");
    document.frmDati.descrizione.focus();
    return;
  }  
  if(document.frmDati.cboServizi.value == ""){
    alert('Il Servizio Fisico è obbligatorio.');
    return;
  }
  if(!CheckNum(document.frmDati.codice.value,9,0,false)){
    alert('Il Codice Servizio Logico deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.codice.focus();
    return;
  }

  opener.frmDati.strCodeServLogico.value = document.frmDati.codice.value;
  opener.frmDati.strDescServLogico.value = document.frmDati.descrizione.value;
  opener.frmDati.strDescBreve.value = document.frmDati.descBreve.value;
  opener.frmDati.strCodeServ.value = document.frmDati.cboServizi.value;

  opener.frmDati.hidTypeLoad.value = "0";
  opener.frmDati.intAggiornamento.value = "1";

  self.close();
  opener.frmDati.submit();
}

function ONCHIUDI(){
   window.close();
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action='pre_inserimento_offerte.jsp?operazione=1'>

<input type="hidden" name="codiceDB" id="codiceDB" value="<%=codiceDB%>">
<input type="hidden" name="codice_corretto" id="codice_corretto" value="<%=codice_corretto%>">

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
          <input type="text" class="text" name="codice" value="<%=codiceDB%>" maxlength="9" size="10" style="margin-left: 1px;">
        </td> 
      </tr>
      <tr>
        <td  class="textB" align="left">Descrizione:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="descrizione" maxlength="50" size="55" value="">
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Descrizione Breve:</td>
        <td  class="text" align="left" colspan="2">
          <input type="text" class="text" name="descBreve" maxlength="20" size="55" value="">
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Servizio Fisico:</td>      
        <td  class="text" align="left" colspan="2">
           <select class="text" name="cboServizi">
            <option value="">[Selezionare Servizio Fisico]</option>
            <%
            vctServizi = entCatalogo.getPreServizi();
            for(int z=0;z<vctServizi.size();z++){
              servizio = (DB_Servizio)vctServizi.get(z);
              %>
              <option value="<%=servizio.getCODE_SERVIZIO()%>">
                 <%=servizio.getDESC_SERVIZIO()%>
              </option>
              <%
            }
            %>           
           </select>
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

 </script>
</BODY>
</HTML>