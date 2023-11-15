<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>

<sec:ChkUserAuth isModal="true" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"conf_email_prof_ute.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_UTENTEejbHome" location="I5_6ANAG_UTENTEejb" />
<EJB:useBean id="utenti" type="com.ejbSTL.I5_6ANAG_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>


<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = "";
  strTitolo="Configurazione Email profile Gestione Utenze";

  String operazione = Misc.nh(request.getParameter("operazione"));  
  String esito = "";
  String messaggio = "";
  int result = 0;
  String ldapUrl = "ldap://156.54.242.110";
  String strResult = "";
  String pwd_decode=null;
  String code_utente = "";
  String pwd = "";
  String nome_cognome = "";
  String mail = "";
  I5_6anag_utenteROW user_ute = null;

  if(!operazione.equals("")){
    code_utente = Misc.nh(request.getParameter("CODE_UTENTE"));
    pwd = Misc.nh(request.getParameter("APPO_PWD"));
    nome_cognome = Misc.nh(request.getParameter("NOME_COGN_UTENTE"));
    mail = Misc.nh(request.getParameter("MAIL"));
    
    pwd_decode=new com.utl.CustomDecode(pwd,code_utente).decode();

    /* controllare che la password sia corretta effettuado l'autenticazione su ldap */
    result = com.utl.StaticContext.doAuthenticateLdap(code_utente,pwd_decode,null,ldapUrl);

    if(result == 0){
      //Effettuo l'inserimento
      strResult = utenti.insParamProfUte(code_utente,pwd_decode,nome_cognome,mail);

      if(strResult.equals("OK")){
        messaggio = "Salvataggio effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }else if(result == 1){
      messaggio = "Attenzione password scaduta.";
    }else{
      messaggio = "Attenzione password errata.";
    }
  }else{
    /* reperimento dati dal db */
    user_ute = new I5_6anag_utenteROW();  
    user_ute = utenti.loadParamProfUte();

    if(user_ute != null){
    System.out.println("code_utente => "+Misc.nh(user_ute.getCode_utente()));
    System.out.println("pwd => "+Misc.nh(user_ute.getCode_prof_utente()));
    System.out.println("nome_cognome => "+Misc.nh(user_ute.getNome_cogn_utente()));
    System.out.println("mail => "+Misc.nh(user_ute.getMail_manager()));    
    code_utente = Misc.nh(user_ute.getCode_utente());
    pwd = Misc.nh(user_ute.getCode_prof_utente());
    pwd_decode=new com.utl.CustomDecode(pwd,code_utente).decode();    
    nome_cognome = Misc.nh(user_ute.getNome_cogn_utente());
    mail = Misc.nh(user_ute.getMail_manager());
    }
    
  }
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Gestione utenti - Configurazione Email
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/password.js"></SCRIPT>


<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>

<script language="JavaScript">
var operazione='';
var objWindows = null;
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
    if(operazione==2 || operazione==3)
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


function chkData(strData){
			var dataDiOggi = new Date();
			var data = new Date(strData.substring(6,10),strData.substring(3,5)-1,strData.substring(0,2));
			if(data<dataDiOggi)
				return false;
      return true;
}


function Salva()
{
  if(document.frmDati.CODE_UTENTE.value.length==0){
    alert('Il Codice Utente è obbligatorio.');
    document.frmDati.CODE_UTENTE.focus();
    return;
  }
  if(document.frmDati.NOME_COGN_UTENTE.value.length==0){
    alert("Il Nome dell'utente è obbligatorio.");
    document.frmDati.NOME_COGN_UTENTE.focus();
    return;
  }
  if(document.frmDati.MAIL.value.length==0){
    alert("L'Unità Organizzativa è obbligatoria.");
    document.frmDati.MAIL.focus();
    return;
  }
  if(document.frmDati.PWD_USER.value.length==0){
    alert('La Password è obbligatoria.');
    document.frmDati.PWD_USER.focus();
    return;
  }

  document.CryptoApplet.setData(document.frmDati.CODE_UTENTE.value,document.frmDati.PWD_USER.value);
  document.frmDati.PWD_USER.value="";
  document.frmDati.operazione.value="1";
  document.frmDati.submit();
}

function risposta(valore) 
{
    document.frmDati.APPO_PWD.value = valore;
}

function controllaUtente(){
  if(document.frmDati.CODE_UTENTE.value != ''){
    var URL = 'controlla_utente.jsp?utente='+document.frmDati.CODE_UTENTE.value;
    document.all.FrameUser.src = URL;
  }else{
    alert("Inserire il Codice Utente per efettuare la verifica");
  }
}

function popolaCampi(nome_cognome,ou,base,search,mail,mailManager,errore){
  if(errore == ""){
    document.frmDati.NOME_COGN_UTENTE.value = nome_cognome;
    document.frmDati.MAIL.value = mail;
    Enable(frmDati.CONFERMA);
    Enable(frmDati.ANNULLA);
  }else{
    alert("Codice Utente non anagrafato nel Sistema Aziendale Centralizzato LDAP");
    document.frmDati.NOME_COGN_UTENTE.value = '';
    document.frmDati.MAIL.value = '';
    Disable(frmDati.CONFERMA);
    Disable(frmDati.ANNULLA);
  }
}

function controllaPulsanti(){
  if (operazione == 0){
    Disable(frmDati.CONFERMA);
    Disable(frmDati.ANNULLA);
  }
}

</script>
<body onLoad="controllaPulsanti()">

<form name="frmDati" method="post" action='conf_email_prof_ute.jsp'>

<INPUT type="HIDDEN" name="APPO_PWD">
<INPUT type="HIDDEN" name="ACTION" value="LOGIN">
<INPUT type="HIDDEN" name="operazione">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
        
<APPLET CODE="com.applet.CryptoApplet.class" NAME="CryptoApplet" ARCHIVE="jar.jar"  CODEBASE="../../" HEIGHT="0" WIDTH="0" MAYSCRIPT>
</APPLET>

<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/gestutenti.gif" alt="" border="0"></td>
  </tr>
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
          <td  class="textB" align="left">Utente:</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="CODE_UTENTE" value="<%=code_utente%>" maxlength="8" size="10" style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();">
          </td>
          <td width="10%" rowspan='2' class="textB" valign="right" align="right">
            <input class="textB" type="button" name="controlla_utente" value="Controlla Utente" onclick="controllaUtente();">
          </td>
        </tr>
        <tr>
          <td  class="textB" align="left" nowrap>Nome Cognome:</td>
          <td  class="text" align="left" colspan="2">
            <input type="text" class="text" name="NOME_COGN_UTENTE" maxlength="50" size="55" value="<%=nome_cognome%>" readonly>
          </td>                
        </tr>
        <tr>
          <td  class="textB" align="left" nowrap>Indirizzo Email:</td>
          <td class="text" align="left" colspan="2">
            <input class="text" type="text" style="margin-left: 1px;" name="MAIL" maxlength="70" size="70" value="<%=mail%>" readonly>
          </td>
        </tr>
        <tr>
          <td  class="textB" align="left" nowrap>Password:</td>      
          <td  class="text" align="left" colspan="2">
            <input type="password" class="text" name="PWD_USER" size="60" maxlength="50">
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
  if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>


<form name="frmControllaUtente" method="post" action=''>
<iframe src="" frameborder=2 width=0% height=0% scrolling=auto name="FrameUser"></iframe>
</form>

</BODY>
</HTML>