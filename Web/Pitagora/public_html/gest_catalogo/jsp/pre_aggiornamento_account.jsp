<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*,java.util.*" %>

<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_aggiornamento_account.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="account" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
    
  strTitolo="Aggiornamento Account";

  //Vector vctGruppiOff = null;
  //DB_Anag_Class_Off anag_class_off = null;
  String code_account_input = Misc.nh(request.getParameter("code_account"));

  // MSCATENA - Aggiunta gestione modifica descrizione
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
  Account
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>


<SCRIPT LANGUAGE="JavaScript">

var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";

var objXmlPreServLogici = null; 

function Initialize() {
  objXmlPreServLogici = CreaObjXML();
  objXmlPreServLogici.loadXML('<MAIN><%=account.getPreServiziLogiciXml()%></MAIN>');
  CaricaComboDaXMLFiltro(document.frmDati.cboPreServiziLogici,objXmlPreServLogici.documentElement.selectNodes('SERVIZIO_LOGICO'),document.frmDati.cboPreServizi.value);     
  if (document.frmDati.code_servizio_logico.value != '')
  {
      document.frmDati.cboPreServiziLogici.value = document.frmDati.code_servizio_logico.value;  
  }
  if(document.frmDati.strFlagModificaDescrizione.value == "1")
  {
    document.frmDati.cboPreServiziLogici.disabled = true;
  }
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

function ONCHIUDI(){
   window.close();
}

function ONANNULLA(){
  if(document.frmDati.strFlagModificaDescrizione.value != "1")
  {
    document.frmDati.dataIni.value = "";
    document.frmDati.dataFine.value = "31/12/2030";
    document.frmDati.cboPreServizi.value = "";
    document.frmDati.cboPreServiziLogici.value = "";
    document.frmDati.cboPreGestori.value = "";
    document.frmDati.CodeGestSap.value = "";    
    document.frmDati.chkClasseSconto.checked = false;
    document.frmDati.chkAccFittizio.checked = false;
    document.frmDati.chkFatturabilita.checked = false;
    document.frmDati.chkInterim.checked = false;
    document.frmDati.chkInvioSAP.checked = false;
  }
  document.frmDati.descrizione.value = "";
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
    if(document.frmDati.codice.value.length==0){
      alert('Il Codice è obbligatorio.');
      document.frmDati.codice.focus();
      return;
    }
    if(!CheckNum(document.frmDati.codice.value,9,0,false)){
      alert('Codice Account deve essere un numero e non deve superare le 9 cifre.');
      document.frmDati.codice.focus();
      return;
    }
    if(document.frmDati.descrizione.value.length==0){
      alert("Descrizione è obbligatorio.");
      document.frmDati.descrizione.focus();
      return;
    }
    if(document.frmDati.cboPreServizi.value==""){
      alert("Il Servizio è obbligatorio.");
      return;
    }
    if(document.frmDati.cboPreServiziLogici.value=="" && !document.frmDati.cboPreServiziLogici.disabled){
      alert("Il Servizio Logico è obbligatorio.");
      return;
    }     
    if(document.frmDati.cboPreGestori.value==""){
      alert("Il Gestore è obbligatorio.");
      return;
    }
    if(document.frmDati.CodeGestSap.value.length==0){
      alert('Il Codice Gestore Sap è obbligatorio.');
      document.frmDati.CodeGestSap.focus();
      return;
    }
    if(document.frmDati.dataIni.value.length==0){
      alert('La Data Inizio Validità è obbligatoria.');
      return;
    }
    if(document.frmDati.dataFine.value.length==0){
      alert('La Data Fine Validità è obbligatoria.');
      return;
    }
  
    if(controllaData(document.frmDati.dataFine.value,document.frmDati.dataIni.value)){
      /* controlla codiceGestoreSap se diverso per stesso gestore e altri account esistenti */
      checkCodeGestSap();
    }else{
      alert('Data Inizio Validità deve essere minore o uguale della Data Fine Validità');
    }
  }
}

function checkCodeGestSap()
{
    //QS 18-06-2008: Aggiunta chiamata a on_changeGestori che tokenizza la stringa code_gestore || code_gestore_sap
  on_changeGestori(document.frmDati.cboPreGestori);
  
  carica = function(dati){ONRITORNO(dati[0].messaggio)};
  errore = function(dati){ONRITORNO(dati[0].messaggio);};  
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('code_gestore='+document.frmDati.cboPreGestori.value+'&code_gestore_sap='+document.frmDati.CodeGestSap.value,'checkGestoreSap',asyncFunz);
}

function ONRITORNO(messaggio){
  if (messaggio == 'KO'){
    if(confirm('Attenzione!!! Il Codice Gestore Sap è diverso a livello di Gestore per altri Account si vuole procedere?')){
      opener.frmDati.strCodeAcc.value = document.frmDati.codice.value;
      opener.frmDati.strDescAcc.value = document.frmDati.descrizione.value;
      opener.frmDati.strDIVAcc.value = document.frmDati.dataIni.value;
      opener.frmDati.strDFVAcc.value = document.frmDati.dataFine.value;
      opener.frmDati.strCodeServ.value = document.frmDati.cboPreServizi.value;
      opener.frmDati.strCodeServLogico.value = document.frmDati.cboPreServiziLogici.value;
      opener.frmDati.strCodeGest.value = document.frmDati.code_gestore.value;
      opener.frmDati.strCodeGestSap.value = document.frmDati.CodeGestSap.value;
      opener.frmDati.strFlagClasSconto.value = document.frmDati.chkClasseSconto.checked;
      opener.frmDati.strFlagAccFitt.value = document.frmDati.chkAccFittizio.checked;
      opener.frmDati.strFlagFatt.value = document.frmDati.chkFatturabilita.checked;
      opener.frmDati.strFlagInterim.value = document.frmDati.chkInterim.checked;
      opener.frmDati.strFlagInvSap.value = document.frmDati.chkInvioSAP.checked;

      // MSCATENA - Aggiunta gestione flag_modifica_descrizione
      opener.frmDati.strFlagModificaDescrizione.value = document.frmDati.strFlagModificaDescrizione.value;
        
      opener.frmDati.hidTypeLoad.value = "0";
      opener.frmDati.intAggiornamento.value = "2";
      self.close();
      opener.frmDati.submit();  
      
    }
  }else{
    opener.frmDati.strCodeAcc.value = document.frmDati.codice.value;
    opener.frmDati.strDescAcc.value = document.frmDati.descrizione.value;
    opener.frmDati.strDIVAcc.value = document.frmDati.dataIni.value;
    opener.frmDati.strDFVAcc.value = document.frmDati.dataFine.value;
    opener.frmDati.strCodeServ.value = document.frmDati.cboPreServizi.value;
    opener.frmDati.strCodeServLogico.value = document.frmDati.cboPreServiziLogici.value;    
    opener.frmDati.strCodeGest.value = document.frmDati.code_gestore.value;
    opener.frmDati.strCodeGestSap.value = document.frmDati.CodeGestSap.value;
    opener.frmDati.strFlagClasSconto.value = document.frmDati.chkClasseSconto.checked;
    opener.frmDati.strFlagAccFitt.value = document.frmDati.chkAccFittizio.checked;
    opener.frmDati.strFlagFatt.value = document.frmDati.chkFatturabilita.checked;
    opener.frmDati.strFlagInterim.value = document.frmDati.chkInterim.checked;
    opener.frmDati.strFlagInvSap.value = document.frmDati.chkInvioSAP.checked;

    // MSCATENA - Aggiunta gestione flag_modifica_descrizione
    opener.frmDati.strFlagModificaDescrizione.value = document.frmDati.strFlagModificaDescrizione.value;
        
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

function on_changeGestori(obj){
  var str = obj.value;
  var token = str.split("||");
  var code_gestore = token[0].split("||");
  var code_gestore_sap = token[1].split("||");
  document.frmDati.CodeGestSap.value = code_gestore_sap;
  document.frmDati.code_gestore.value = code_gestore;
}

</script>

<body onload="Initialize();">

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio"  style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera">

<form name="frmDati" method="post" action=''>

<%
Vector accountVector=null;
accountVector = account.getPreAccount(code_account_input);
DB_CAT_Account myelement = new DB_CAT_Account();
for(int j=0;j < accountVector.size();j++)	
{
  myelement=(DB_CAT_Account)accountVector.elementAt(j);
}
%>
<input type="hidden" name="code_gestore" id="code_gestore" value="">
<input type="hidden" name="code_servizio_logico" id="code_servizio_logico" value="<%=myelement.getCODE_SERVIZIO_LOGICO()%>">

<!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
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
        <td  class="textB" align="left" nowrap>Codice Account:</td>
        <td  class="text" align="left">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="text" class="text" name="codice" value="<%=myelement.getCODE_ACCOUNT()%>" <%=disabled%> maxlength="9" size="10" style="margin-left: 1px;" readonly>
        </td> 
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Descrizione Account:</td>
        <td class="text" align="left">
          <input type="text" class="text" name="descrizione" maxlength="50" size="55" value="<%=myelement.getDESC_ACCOUNT()%>">
        </td>                
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Servizio:</td>
        <td class="text" align="left">
          <select class="text" title="Servizi" name="cboPreServizi" <%=disabled%> onchange="CaricaComboDaXMLFiltro(document.frmDati.cboPreServiziLogici,objXmlPreServLogici.documentElement.selectNodes('SERVIZIO_LOGICO'),this.value)">
          <%
            Vector servizi = account.getPreServizi();
            DB_PreServizi servizio = null;

            for(int i=0; i<servizi.size(); i++)
            {
              servizio = (DB_PreServizi)servizi.elementAt(i);
              out.write("<option value='" + servizio.getCODE_SERVIZIO() + "'");
              if(servizio.getCODE_SERVIZIO().equals(myelement.getCODE_SERVIZIO()))
              {
                out.write(" selected='selected'");
              }
              out.write(">" + servizio.getDESC_SERVIZIO() + "</option>");
            }
            %>
          </select>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Servizio Logico:</td>
        <td class="text" align="left">
          <select class="text" title="Servizi Logici" name="cboPreServiziLogici">
          <option class="text"  value="">[Seleziona Servizio Logico]</option>
          </select>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Gestore:</td>
        <td class="text" align="left">
          <select class="text" title="Gestori" name="cboPreGestori" onchange="on_changeGestori(this)" <%=disabled%>>
          <%
            Vector gestori = account.getPreGestori();
            DB_Gestori gestore = null;

            for(int i=0; i<gestori.size(); i++)
            {
              gestore = (DB_Gestori)gestori.elementAt(i);
              out.write("<option value='" + gestore.getCODE_GESTORE() + "||" + gestore.getCODE_GESTORE_SAP() + "'");
              if(gestore.getCODE_GESTORE().equals(myelement.getCODE_GESTORE()))
              {
                out.write(" selected='selected'");
              }
              out.write(">" + gestore.getDESC_GESTORE() + "</option>");
            }
            %>
          </select>
        </td>
      </tr>
      <tr>
        <td  class="textB" align="left">Codice Gestore Sap:</td>
        <td  class="text" align="left" colspan="2">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="text" class="text" name="CodeGestSap" value="<%=myelement.getCODE_GESTORE_SAP()%>" <%=disabled%> maxlength="10" size="15" style="margin-left: 1px;" onchange="uppercase(this)">
        </td> 
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Applica Classe Sconto:</td>  
        <td class="text" align="left">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="checkbox" value="Y" name="chkClasseSconto" <%=disabled%> <%if(myelement.getTIPO_FLAG_CLAS_SCONTO().equals("Si")){out.write("checked=checked");}%>>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Account Fittizio:</td>  
        <td class="text" align="left">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="checkbox" value="Y" name="chkAccFittizio" <%=disabled%> <%if(myelement.getTIPO_FLAG_FITTZ().equals("Si")){out.write("checked=checked");}%>>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Fatturabilità:</td>  
        <td class="text" align="left">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="checkbox" value="Y" name="chkFatturabilita" <%=disabled%> <%if(myelement.getTIPO_FLAG_FATTRB().equals("Si")){out.write("checked=checked");}%>>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Data Inizio Validità:</td>      
        <td class="text" align="left">
          <input type="text" class="text" size=12 maxlength="12" name="dataIni" title="Data Inizio Validità" value="<%=myelement.getDATA_INIZIO_VALID()%>" readonly <%=disabled%>>
            <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario_div' src="../../common/images/img/cal.gif" border="no"></a>
            <a href="javascript:cancelCalendar(document.frmDati.dataIni);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data_div' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Data Fine Validità:</td>      
        <td class="text" align="left">
          <input type="text" class="text" size=12 maxlength="12" name="dataFine" title="Data Fine Validità" value="<%=myelement.getDATA_FINE_VALID()%>" readonly <%=disabled%>>
            <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario_dfv' src="../../common/images/img/cal.gif" border="no"></a>
            <a href="javascript:cancelCalendar(document.frmDati.dataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data_dfv' src="../../common/images/img/images7.gif" border="0"></a>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Interim:</td>  
        <td class="text" align="left">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="checkbox" value="Y" name="chkInterim" <%=disabled%> <%if(myelement.getFLAG_INTERIM().equals("Si")){out.write("checked=checked");}%>>
        </td>
      </tr>
      <tr>
        <td class="textB" align="left" nowrap>Invio SAP:</td>  
        <td class="text" align="left">
          <!-- MSCATENA - Aggiunta gestione flag_modifica_descrizione -->
          <input type="checkbox" value="Y" name="chkInvioSAP" <%=disabled%> <%if(myelement.getFLAG_INVIO_SAP().equals("S")){out.write("checked=checked");}%>>
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
       // Calendario Data Inizio Validità
       var cal1 = new calendar1(document.forms['frmDati'].elements['dataIni']);
			 cal1.year_scroll = true;
			 cal1.time_comp = false;
       // Calendario Data Fine Validità       
       var cal2 = new calendar1(document.forms['frmDati'].elements['dataFine']);
			 cal2.year_scroll = true;
			 cal2.time_comp = false;

       // MSCATENA  - Aggiunta gestione flag_modifica_descrizione
       if(document.frmDati.strFlagModificaDescrizione.value == "1")
       {
          if(!frmDati.calendario_div.disabled)
            DisableLink ( document.links[0], frmDati.calendario_div);
          if(!frmDati.cancella_data_div.disabled)
            DisableLink ( document.links[1], frmDati.cancella_data_div);
          Disable ( frmDati.calendario_div );
          Disable ( frmDati.cancella_data_div );    

          if(!frmDati.calendario_dfv.disabled)
            DisableLink ( document.links[2], frmDati.calendario_dfv);
          if(!frmDati.cancella_data_dfv.disabled)
            DisableLink ( document.links[3], frmDati.cancella_data_dfv);
          Disable ( frmDati.calendario_dfv );
          Disable ( frmDati.cancella_data_dfv );            
       }       
</script>

<script>
var http=getHTTPObject();
</script>
</BODY>
</HTML>