<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>

<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_aggiornamento_prodotti.jsp")%>
</logtag:logData>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Aggiornamento Prodotto";

  //Vector vctGruppiOff = null;
  //DB_Anag_Class_Off anag_class_off = null;
  String code_prodotto_input = Misc.nh(request.getParameter("code_prodotto"));


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
  Prodotti
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
  if(document.frmDati.strCodeProdotto.value.length==0){
    alert('Il Codice Prodotto è obbligatorio.');
    document.frmDati.strCodeProdotto.focus();
    return;
  }
  if(document.frmDati.strDescProdotto.value.length==0){
    alert("Descrizione Prodotto è obbligatorio.");
    document.frmDati.strDescProdotto.focus();
    return;
  }      
  if(!CheckNum(document.frmDati.strCodeProdotto.value,9,0,false)){
    alert('Codice Prodotto deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.strCodeProdotto.focus();
    return;
  }

  opener.frmDati.strCodeProd.value = document.frmDati.strCodeProdotto.value;
  opener.frmDati.strDescProd.value = document.frmDati.strDescProdotto.value;


  /* AP Aggiunta modifica descrizione  */ 
  opener.frmDati.strFlagModificaDescrizione.value = document.frmDati.strFlagModificaDescrizione.value;

  opener.frmDati.intAggiornamento.value = "2";
  opener.frmDati.hidTypeLoad.value = "0";
      
  self.close();
  opener.frmDati.submit();
}

function ONANNULLA() {
  document.frmDati.strDescProdotto.value = "";
  document.frmDati.strDescProdotto.focus();
}

function uppercase(obj){
  var value = obj.value;
  obj.value = value.toUpperCase();
}
</script>

<body onLoad="//impostaFocus()">
<form name="frmDati" method="post" action=''>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="prodotti" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
Vector accountVector=null;
accountVector = prodotti.getPreProdotto(code_prodotto_input);
DB_Prodotto myelement = new DB_Prodotto();
for(int j=0;j < accountVector.size();j++)	
{
  myelement=(DB_Prodotto)accountVector.elementAt(j);
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
          <td height="30" width="35%" class="textB" align="right" nowrap>Codice Prodotto</td>
          <TD>

          <!-- AP Aggiunta modifica descrizione -->
            <INPUT class="text" id="strCodeProdotto" name="strCodeProdotto"  obbligatorio="si" tipocontrollo="intero" label="Codice Prodotto" Update="false" size="35" maxlength=9 <%=disabled%> readonly="readonly" value="<%=myelement.getCODE_PRODOTTO()%>">
          </TD>
        </tr>
        <tr>
          <td height="30" width="35%" class="textB" align="right" nowrap>Descrizione Prodotto</td>
          <td>
            <input class="text" id="strDescProdotto" name="strDescProdotto"  obbligatorio="si" tipocontrollo="intero" label="Descrizione Prodotto" Update="false" size="35" value="<%=myelement.getDESC_PRODOTTO()%>">
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