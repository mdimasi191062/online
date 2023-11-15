<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"agg_utente.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  I5_6anag_utenteROW riga = null;
  String strMessaggioFunz=""; 

    //Gestione Paramteri Navigazione
  String CodSel = request.getParameter("CodSel");
  int operazione = Integer.parseInt(request.getParameter("operazione"));  
  //Parametro in ingresso con valore = 0 pagina richiamata da nuovo 
  //                     con valore = 1 pagina richiamata da aggiorna 
  //                     con valore = 2 pagina richiamata da elimina
  //                     con valore = 3 pagina richiamata da riabilitazione
  
  String strQueryString = request.getQueryString();
  String strTitolo = null;
 
  String CODE_UTENTE =null;
  String CODE_PROF_UTENTE =null;
  String NOME_COGN_UTENTE =null;

  Date DATE_END =null;
  
  int NUM_PWD_DUR =0;

  String FLAG_ADMIN_IND =null;
  String CODE_PWD =null;

  String CODE_UNITA_ORGANIZ =null;
  String CODE_PROF_ABIL =null;

  String BASE_LDAP =null;
  String SEARCH_LDAP =null;
  int NUM_MONTHS_DISABLED =0;
  Date DATE_START =null;
  String DATA_LOGIN =null;
  Date DATE_DISABLE_NOT_ACCESS=null;
  String DATA_END_USER ="";

  String MAIL =null;
  String MAIL_MANAGER =null;

  String NOME_UTENTE = null;
  String COGNOME_UTENTE = null;  
  
  CODE_UTENTE = request.getParameter("CodSel");

  // Gestione del Titolo
  if (operazione==0)
  {    
      strTitolo="Inserimento Utente";
  }  
  else if (operazione==1)
  {  
      strTitolo="Modifica Utente";
  }    
  else if (operazione==2)
  {
      strTitolo="Cancellazione Utente";
  }
  else if (operazione==3)
  {
      strTitolo="Riabilitazione Utente nel sistema J.P.U.B.";
  }

  String numRec      = Misc.nh(request.getParameter("numRec"));
  String offset      = Misc.nh(request.getParameter("pager.offset"));
  String txtTypeLoad = Misc.nh(request.getParameter("txtTypeLoad"));
  String txtRicerca  = Misc.nh(request.getParameter("txtRicerca"));
  String tipoUser    = Misc.nh(request.getParameter("tipoUser"));
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
<SCRIPT LANGUAGE="JavaScript" SRC="../js/password.js"></SCRIPT>


<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>

<script language="JavaScript">

var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";

var operazione=<%=operazione%>
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
  if(document.frmDati.CODE_UNITA_ORGANIZ.value.length==0){
    alert("L'Unità Organizzativa è obbligatoria.");
    document.frmDati.CODE_UNITA_ORGANIZ.focus();
    return;
  }
  /*
  if(!CheckNum(document.frmDati.NUM_MONTHS_DISABLE.value,2,0,false)){
    alert('Mesi Validità Utente deve essere un numero.');
    document.frmDati.NUM_MONTHS_DISABLE.focus();
    return;
  }
  */
/*
  if(document.frmDati.DATA_END_USER.value.length==0){
    alert('Data disabilitazione utente è obbligatoria.');
    document.frmDati.DATA_END_USER.focus();
    return;
  }
  if(!chkData(document.frmDati.DATA_END_USER.value)){
    alert('Data disabilitazione utente minore della data odierna.');
    return;
  }
  
  if(!controllaDate(document.frmDati.DATA_END_USER.value)){
    if (document.frmDati.CODE_UTENTE.value.substring(0,2) == 'UE')
      alert('ATTENIONE!!! Per utenza esterna la Data Disabilitazione Utente non può superare la data odierna più 1 anno.');
    else
      alert('ATTENIONE!!! Per utenze interne la Data Disabilitazione Utente non può superare la data odierna più 3 anni.');
    return;
  }

  */ 
  
  document.frmDati.CODE_PROF_ABIL.disabled = false;
  document.frmDati.submit();
}

function controllaDate(strData){
  var dataDiOggi = new Date();
  var day  = dataDiOggi.getDate();
  var month  = dataDiOggi.getMonth()+1;
  var year  = dataDiOggi.getFullYear();
  if (document.frmDati.CODE_UTENTE.value.substring(0,2) == 'UE')
    year = year +1;
  else
    year = year +3;

  var annoUser = strData.substring(6,10);
  var meseUser = strData.substring(3,5);
  var giornoUser = strData.substring(0,2); 
  
  var dataInput     = new Date(annoUser,meseUser,giornoUser,"23","59","59");
  var dataControllo = new Date(year,month,day,"23","59","59");

  if(dataInput>dataControllo)
    return false;
  else
    return true;
}

function risposta(valore) 
{
    document.frmDati.APPO_PWD.value = valore;
}

function mostracalendario() 
{
  if(document.frmDati.DATE_END.value.length==0)
    showCalendar('frmDati.DATE_END','sysdate');
  else
    showCalendar('frmDati.DATE_END',impData(document.frmDati.DATE_END.value))
}

function controllaUtente(){
  if(document.frmDati.CODE_UTENTE.value != ''){
    var URL = 'controlla_utente.jsp?utente='+document.frmDati.CODE_UTENTE.value;
    document.all.FrameUser.src = URL;
  }else{
    alert("Inserire il Codice Utente per efettuare la verifica");
  }
}

//function popolaCampi(nome_cognome,ou,base,search,mail,mailManager,nomeUtente,cognomeUtente,errore){
function popolaCampi(nome_cognome,ou,base,search,nomeUtente,cognomeUtente,errore){
  if(errore == ""){
    document.frmDati.NOME_COGN_UTENTE.value = nome_cognome;
    document.frmDati.CODE_UNITA_ORGANIZ.value = ou;
    document.frmDati.BASE_LDAP.value = base;
    document.frmDati.SEARCH_LDAP.value = search;
    //document.frmDati.NUM_MONTHS_DISABLE.value = '6';
    /*
    document.frmDati.MAIL.value = mail;
    document.frmDati.MAIL_MANAGER.value = mailManager;
    */
    document.frmDati.NOME_UTENTE.value = nomeUtente;
    document.frmDati.COGNOME_UTENTE.value = cognomeUtente;
    
    Enable(frmDati.CONFERMA);
    //Enable(frmDati.ANNULLA); 
  }else{
    alert("Codice Utente non anagrafato nel Sistema Aziendale Centralizzato LDAP");
    document.frmDati.NOME_COGN_UTENTE.value = '';
    document.frmDati.CODE_UNITA_ORGANIZ.value = '';
    document.frmDati.BASE_LDAP.value = '';
    document.frmDati.SEARCH_LDAP.value = '';
//    document.frmDati.NUM_MONTHS_DISABLE.value = '';
    document.frmDati.DATA_END_USER.value = '';
    document.frmDati.NOME_UTENTE.value = '';
    document.frmDati.COGNOME_UTENTE.value = '';
    Disable(frmDati.CONFERMA);
    //Disable(frmDati.ANNULLA); 
  }
}

function controllaPulsanti(){
  if (operazione == 0){
    Disable(frmDati.CONFERMA);
    //Disable(frmDati.ANNULLA);
  }
}

function cancelCalendar (obj)
{
  obj.value="";
}

function helpProfili(){
  if(document.frmDati.CODE_PROF_UTENTE.value==''){
    alert('Occorre selzionare un Profilo.');
    document.frmDati.CODE_PROF_UTENTE.focus();
    return;
  }
  openCentral('helpProfili.jsp?CodeProfUte='+document.frmDati.CODE_PROF_UTENTE.value,'HelpProfili','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',400,400);
}

function onChangeProfUte(profilo){
  for (i=document.frmDati.CODE_PROF_ABIL.length-1;i>=0;i--){
    document.frmDati.CODE_PROF_ABIL.options[i]=null;
  }
  
  if(profilo == 'UTE'){
    document.frmDati.CODE_PROF_ABIL.options[0] = new Option("Gestione Utenze","Gestione Utenze");
  }else if(profilo == 'SU'){
    document.frmDati.CODE_PROF_ABIL.options[0] = new Option("Amministratore","Amministratore");
  }else if(profilo == 'REA'){
    document.frmDati.CODE_PROF_ABIL.options[0] = new Option("Consultazione","Consultazione");
    document.frmDati.CODE_PROF_ABIL.options[1] = new Option("Lavorazione","Lavorazione");
    if(document.frmDati.PROF_ABIL_USER.value != null || document.frmDati.PROF_ABIL_USER.value != ''){
      document.frmDati.CODE_PROF_ABIL.value = document.frmDati.PROF_ABIL_USER.value;
    }
  }else {
    document.frmDati.CODE_PROF_ABIL.options[0] = new Option("Lavorazione","Lavorazione");
  }
}



</script>

<body onLoad="controllaPulsanti()">
<form name="frmDati" method="post" action='salva_utente.jsp?strQueryString=<%=strQueryString%>'>
   <APPLET CODE="com.applet.CryptoApplet.class" NAME="CryptoApplet" ARCHIVE="jar.jar"  CODEBASE="../../" HEIGHT="0" WIDTH="0" MAYSCRIPT>
    </APPLET>
<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_UTENTEejbHome" location="I5_6ANAG_UTENTEejb" />
<EJB:useBean id="utenti" type="com.ejbSTL.I5_6ANAG_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<EJB:useHome id="home2" type="com.ejbSTL.I5_6PROF_UTENTEejbHome" location="I5_6PROF_UTENTEejb" />
<EJB:useBean id="profili" type="com.ejbSTL.I5_6PROF_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home2.create()%>" />
</EJB:useBean>


<% 
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  if (operazione!=0) // aggiornamento
  {   
      riga = utenti.loadUtente(CODE_UTENTE);
      CODE_PROF_UTENTE    = riga.getCode_prof_utente();
      NOME_COGN_UTENTE    = riga.getNome_cogn_utente();
      DATE_END            = riga.getDate_end();
      FLAG_ADMIN_IND      = riga.getFlag_admin_ind();
      CODE_UNITA_ORGANIZ  = Misc.nh(riga.getCode_unita_organiz());
      CODE_PROF_ABIL      = Misc.nh(riga.getCode_prof_abil());
      BASE_LDAP           = riga.getBaseIDN_LDAP();
      SEARCH_LDAP         = riga.getSearchIDN_LDAP();
      DATE_START          = riga.getDateStart();
      NUM_MONTHS_DISABLED = riga.getNum_months_disabled();
      DATA_LOGIN          = riga.getData_login();
      /*
      MAIL                = riga.getMail();
      MAIL_MANAGER        = riga.getMail_manager();
      DATA_END_USER       = riga.getData_end_user();
      */
      NOME_UTENTE         = riga.getNome_utente();
      COGNOME_UTENTE      = riga.getCogn_utente();
      
      if(DATA_LOGIN == null)
         DATA_LOGIN = "";
      DATE_DISABLE_NOT_ACCESS = riga.getDt_disable_not_access();
  }  
%>
<input type="hidden" name="BASE_LDAP" value="<%=BASE_LDAP%>">
<input type="hidden" name="SEARCH_LDAP" value="<%=SEARCH_LDAP%>">
<input type="hidden" name="NOME_UTENTE" value="<%=NOME_UTENTE%>">
<input type="hidden" name="COGNOME_UTENTE" value="<%=COGNOME_UTENTE%>">

<%-- PARAMETRI FILTRO RICERCA INIZIO --%>
<input type="hidden" name="numRec" value="<%=numRec%>">
<input type="hidden" name="offset" value="<%=offset%>">
<input type="hidden" name="txtTypeLoad" value="<%=txtTypeLoad%>">
<input type="hidden" name="txtRicerca" value="<%=txtRicerca%>">
<input type="hidden" name="tipoUser" value="<%=tipoUser%>">
<input type="hidden" name="operazione" value="<%=operazione%>">
<%-- PARAMETRI FILTRO RICERCA FINE --%>

<table align='center' width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/gestutenti.gif" alt="" border="0"></td>
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
        <%if(operazione==0){%>
          <input type="text" class="text" name="CODE_UTENTE" maxlength="8" size="10" style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();">
        <%}else{%>
          <input type="hidden" name="CODE_UTENTE" value="<%=CODE_UTENTE%>">
          <%out.println(CODE_UTENTE);
          }
        %>
        </td>
        <%if(operazione!=2 && operazione != 3){%>
        <td width="10%" rowspan='2' class="textB" valign="right" align="right">
          <input class="textB" type="button" name="controlla_utente" value="Controlla Utente" onclick="controllaUtente();">
        </td>
        <%}%>
      </tr>
      <tr>
        <td  class="textB" align="left" nowrap>Nome Cognome:</td>
        <td  class="text" align="left" colspan="2">
        <%if(operazione==2 || operazione == 3){out.println(NOME_COGN_UTENTE);}else{%>
          <input type="text" class="text" name="NOME_COGN_UTENTE" maxlength="50" size="55" value="<%if(operazione==1){out.println(NOME_COGN_UTENTE);}%>" readonly>
        <%}%>
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Profilo:</td>      
        <td  class="text" align="left" colspan="2">
        <%if(operazione==2 || operazione == 3){out.println(CODE_PROF_UTENTE);}
        else if (((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName().equals(CODE_UTENTE) && operazione!=0){
          out.println(CODE_PROF_UTENTE);
          %>
          <input type="hidden" name="CODE_PROF_UTENTE" value="<%=CODE_PROF_UTENTE%>">
          <%
        }else{%>
              <select class="text" name="CODE_PROF_UTENTE" onchange="onChangeProfUte(this.value);">
              <%  

                I5_6PROF_UTENTE_ROW[] aRemote = null;
                int i=0;
                Collection appoVector = profili.FindAll("");
                aRemote = (I5_6PROF_UTENTE_ROW[])appoVector.toArray(new I5_6PROF_UTENTE_ROW[1]);
                for(i=0;i<aRemote.length;i++)
                {
                  String strAppo = aRemote[i].getCODE_PROF_UTENTE();
                  String selezionato="";
                  if(CODE_PROF_UTENTE!=null)
                  {
                    if(CODE_PROF_UTENTE.equals(strAppo))
                      selezionato="selected";
                  }
              %>
                <option <%=selezionato%> value="<%=strAppo%>"><%=strAppo%></option>
              <%}%>
              </select>
              <input type="hidden" name="CODE_PROF_UTENTE_H" value="<%=CODE_PROF_UTENTE%>">
              <%
              if (!((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName().equals(CODE_UTENTE))
              {
              %>
                <IMG alt="Help Profili" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOHelp.gif" style="cursor:hand" onclick="helpProfili()">
              <%
              }
              %>
        <%}%>
        </td>
      </tr>
      <%if(operazione!=0){%>
      <tr>
        <%if(operazione==1){%>
              <input type="hidden" name="NUM_MONTHS_DISABLE" value="<%=NUM_MONTHS_DISABLED%>" readonly>
        <%}%>
        <td  class="textB" align="left" nowrap>Data Ultimo Accesso:</td>      
        <td  class="text" align="left" colspan="2">
        <%if(operazione==2 || operazione == 3){out.println(DATA_LOGIN);}else{%>
            <%if(DATA_LOGIN != null) {%>
               <input type="text" class="text" name="DATA_LOGIN" size="25" value="<%if(operazione==1){out.println(DATA_LOGIN);}%>" readonly>
            <%}else{%>
               <input type="text" class="text" name="DATA_LOGIN" size="25" value="" readonly>
            <%}%>
        </td>
      </tr>
<%--
      <tr>
        <td  class="textB" align="left" nowrap>Data Disabilitazione Utente:</td>
        <%if(DATE_DISABLE_NOT_ACCESS != null) {%>
          <td  class="text" align="left" colspan="2"><%if(operazione==2 || operazione == 3){out.println(df.format(DATE_DISABLE_NOT_ACCESS));}else{%><input type="text" class="text" name="DATE_DISABLE_NOT_ACCESS" size="25" value="<%if(operazione==1 && DATE_DISABLE_NOT_ACCESS != null){out.println(df.format(DATE_DISABLE_NOT_ACCESS));}else{out.println("");}%>" readonly><%}%></td> 
        <%}else{%>
          <td  class="text" align="left" colspan="2"><%if(operazione==2 || operazione == 3){out.println(df.format(DATE_DISABLE_NOT_ACCESS));}else{%><input type="text" class="text" name="DATE_DISABLE_NOT_ACCESS" size="25" value="" readonly><%}%></td> 
        <%}%>
      </tr>

      <tr>
        <td class="textB" align="left" nowrap>Data Fine Validità Utente:</td>      
        <td class="text" align="left">
          <input type="text" class="text" size="25" maxlength="25" name="DATA_END_USER" title="Data Fine Validità Utente" value="<%=DATA_END_USER%>" readonly>          
          <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
          <a href="javascript:cancelCalendar(document.frmDati.DATA_END_USER);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
--%>
         <%}%>
      <%}else{%>
<%--
        <tr>
          <td class="textB" align="left" nowrap>Data Fine Validità Utente:</td>      
          <td class="text" align="left">
            <input type="text" class="text" size="25" maxlength="25" name="DATA_END_USER" title="Data Inizio Validità" value="<%=DATA_END_USER%>"readonly>
            <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
            <a href="javascript:cancelCalendar(document.frmDati.DATA_END_USER);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" border="0"></a>
          </td>
        </tr>
        
        <tr>
          <td class="textB" align="left" nowrap>Mesi Validità Utente:</td>      
          <td class="text" align="left" colspan="2"><input type="text" class="text" name="NUM_MONTHS_DISABLE" maxlength="8" size="10" style="margin-left: 1px;text-transform:uppercase" onblur="this.value=this.value.toUpperCase();" readonly></td> 
        </tr>
--%>
              <input type="hidden" name="NUM_MONTHS_DISABLE" value="" readonly>
      <%}%>
      <tr>
        <td  class="textB" align="left" nowrap>Unità Organiz.:</td>      
        <td  class="text" align="left" colspan="2"><%if(operazione==2 || operazione == 3){out.println(CODE_UNITA_ORGANIZ);}else{%><input type="text" class="text" name="CODE_UNITA_ORGANIZ" size="60" maxlength="50" value="<%if(operazione==1){out.println(CODE_UNITA_ORGANIZ);}%>"><%}%></td> 
      </tr>
      <tr>
        <td  class="textB" align="left" nowrap>Profilo abil.:</td>      
        <%--<td  class="text" align="left" colspan="2"><%if(operazione==2){out.println(CODE_PROF_ABIL);}else{%><input type="text" class="text" name="CODE_PROF_ABIL" size="60" maxlength="50" value="<%if(operazione==1){out.println(CODE_PROF_ABIL);}%>"><%}%></td>--%>
        <td  class="text" align="left" colspan="2">
          <%if(operazione==2 || operazione == 3){
              out.println(CODE_PROF_ABIL);
            }else if (((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName().equals(CODE_UTENTE) && operazione!=0){
              out.println(CODE_PROF_ABIL);
              %>
              <input type="hidden" name="CODE_PROF_ABIL" value="<%=CODE_PROF_ABIL%>">
              <%
            }else{%>
            <select class="text" name="CODE_PROF_ABIL">
            <%
            String selezionatoAmm = "";
            String selezionatoLav = "";
            String selezionatoUte = "";
            String selezionatoCon = "";
            
            if (CODE_PROF_ABIL == null){
              selezionatoAmm = "selected";
              selezionatoLav = "";
              selezionatoUte = "";
              selezionatoCon = "";
            }else if(CODE_PROF_ABIL.equals("Amministratore")){
              selezionatoAmm = "selected";
              selezionatoLav = "";
              selezionatoUte = "";
              selezionatoCon = "";             
            }else if(CODE_PROF_ABIL.equals("Lavorazione")){
              selezionatoAmm = "";
              selezionatoLav = "selected";
              selezionatoUte = "";
              selezionatoCon = "";          
            }else if(CODE_PROF_ABIL.equals("Consultazione")){
              selezionatoAmm = "";
              selezionatoCon = "selected";
              selezionatoLav = "";
              selezionatoUte = "";            
            }else{
              selezionatoAmm = "";
              selezionatoLav = "";
              selezionatoUte = "selected";
              selezionatoCon = "";
            }
            %>
            <option <%=selezionatoAmm%> value="Amministratore" disabled>Amministratore</option>
            <option <%=selezionatoLav%> value="Lavorazione">Lavorazione</option>
            <option <%=selezionatoUte%> value="Gestione utenze">Gestione Utenze</option>
            <option <%=selezionatoCon%> value="Consultazione">Consultazione</option>
          </select>
          <input type="hidden" name="PROF_ABIL_USER" VALUE="<%=CODE_PROF_ABIL%>">
          <%}%>
        </td>
      </tr>
      <%if(operazione!=2 && operazione != 3){%>
<%--
      <tr>
        <td  class="textB" align="left" nowrap>Email Utente:</td>
        <%if(operazione==0){%>
           <td class="text" align="left" colspan="2"><input class="text" type="text" style="margin-left: 1px;" name="MAIL" maxlength="70" size="70" value="<%if(operazione==1){out.println(MAIL);}%>" readonly></td>
        <%}else{%>
           <td class="text" align="left" colspan="2"><input class="text" type="text" style="margin-left: 1px;" name="MAIL" maxlength="70" size="70" value="<%if(operazione==1){out.println(MAIL);}%>" readonly></td>
        <%}%>
      </tr>
      <tr>
      </tr>
        <td  class="textB" align="left" nowrap>Email Manager:</td>
        <%if(operazione==0){%>
           <td class="text" align="left" colspan="2"><input class="text" type="text" style="margin-left: 1px;" name="MAIL_MANAGER" maxlength="70" size="70" value="<%if(operazione==1){out.println(MAIL_MANAGER);}%>" readonly></td>
        <%}else{%>
           <td class="text" align="left" colspan="2"><input class="text" type="text" style="margin-left: 1px;" name="MAIL_MANAGER" maxlength="70" size="70" value="<%if(operazione==1){out.println(MAIL_MANAGER);}%>" readonly></td>
        <%}%>
      </tr>
--%>
      <%}%>
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
if (document.frmDati.operazione.value != 2 && document.frmDati.operazione.value != 1){
  document.frmDati.DATE_END?Disable(document.frmDati.DATE_END):null;
  onChangeProfUte(document.frmDati.CODE_PROF_UTENTE.value);
  
  // Calendario Data Inizio Validità
  /*var cal1 = new calendar1(document.forms['frmDati'].elements['DATA_END_USER']);
  cal1.year_scroll = true;
  cal1.time_comp = false;*/
}

if (document.frmDati.operazione.value == 1){
  for (i=document.frmDati.CODE_PROF_ABIL.length-1;i>=0;i--){
    if(document.frmDati.CODE_PROF_UTENTE_H.value == 'UTE'){  
      if(document.frmDati.CODE_PROF_ABIL.options[i].value != 'Gestione Utenze')
        document.frmDati.CODE_PROF_ABIL.options[i]=null;
    }else if(document.frmDati.CODE_PROF_UTENTE_H.value == 'SU'){
      if(document.frmDati.CODE_PROF_ABIL.options[i].value != 'Amministratore')
        document.frmDati.CODE_PROF_ABIL.options[i]=null;
    }else if(document.frmDati.CODE_PROF_UTENTE_H.value == 'REA'){
      if(document.frmDati.CODE_PROF_ABIL.options[i].value != 'Consultazione' && 
         document.frmDati.CODE_PROF_ABIL.options[i].value != 'Lavorazione' )
        document.frmDati.CODE_PROF_ABIL.options[i]=null;
    }else{
      if(document.frmDati.CODE_PROF_ABIL.value != 'Lavorazione')
        document.frmDati.CODE_PROF_ABIL.options[i]=null;
    }
  }
}


</script>

<form name="frmControllaUtente" method="post" action=''>
<iframe src="" frameborder=2 width=0% height=0% scrolling=auto name="FrameUser"></iframe>
</form>

</BODY>
</HTML>