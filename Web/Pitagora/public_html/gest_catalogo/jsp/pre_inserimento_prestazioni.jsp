<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_prestazioni.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
  String strTitolo = null;
  String codice_corretto = null;
    
  strTitolo="Inserimento Prestazione";

  String codiceDB = "";

  String esito = "";
  String messaggio = "";
  DB_PrestazioneAggiuntiva newPrestAgg;
  //String parametriSubmit = "";
  
  String navigatore = Misc.nh(request.getParameter("navigatore"));
  if (!navigatore.equals("")){
    //elenco parametri per submit
    //parametriSubmit = Misc.nh(request.getParameter("parametri"));
  }
  String operazione = Misc.nh(request.getParameter("operazione"));
  
  if(!operazione.equals("")){
    String codice = Misc.nh(request.getParameter("strCodePrestAgg"));
    String descrizione = Misc.nh(request.getParameter("strDescPrestAgg"));
    //Effettuo l'inserimento
    newPrestAgg = new DB_PrestazioneAggiuntiva();
    newPrestAgg.setCODE_PREST_AGG(codice);
    newPrestAgg.setDESC_PREST_AGG(descrizione);
    esito = remoteEnt_Catalogo.insPrestAgg(newPrestAgg);
    if(esito.equals("")){
      messaggio = "Inserimento nuova Prestazione Aggiuntiva effettuato correttamente.";
    }else{
      messaggio = esito;
    }
  }
  
%>

<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
</TITLE>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

function Initialize() {
  /* niente */
  var pippo;
}

function ONANNULLA()
{
  resetValue();
}   

function ONSALVA()
{
  if(document.frmDati.strCodePrestAgg.value.length==0){
    alert('Il Codice è obbligatorio.');
    document.frmDati.strCodePrestAgg.focus();
    return;
  }
  if(document.frmDati.strDescPrestAgg.value.length==0){
    alert("Descrizione è obbligatorio.");
    document.frmDati.strDescPrestAgg.focus();
    return;
  }
  
  if(!CheckNum(document.frmDati.strCodePrestAgg.value,9,0,false)){
    alert('Codice Prestazione deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.strCodePrestAgg.focus();
    return;
  }
  
  if(document.frmDati.navigatore.value != ""){
    //submit su se stessa
    document.frmDati.action = "pre_inserimento_prestazioni.jsp?operazione=1";
    document.frmDati.submit();
  }else{
    //submit su pagina di visualizzazione elenco
    opener.frmDati.strCodePrestAgg.value = document.frmDati.strCodePrestAgg.value;
    opener.frmDati.strDescPrestAgg.value = document.frmDati.strDescPrestAgg.value;
    opener.frmDati.hidTypeLoad.value = "0";
    opener.frmDati.intAggiornamento.value = "1";
    self.close();
    opener.frmDati.submit();
  }
}

function resetValue(){
  document.frmDati.strCodePrestAgg.value = document.frmDati.codice_corretto.value;
  document.frmDati.strDescPrestAgg.value = "";
}

function ONCHIUDI(){
  if(document.frmDati.navigatore.value != ''){

    opener.document.all('elabCorso').innerText ="ELABORAZIONE IN CORSO..";
    Disable (opener.frmDati.NUOVO);
    Disable (opener.frmDati.SELEZIONA);
    Disable (opener.frmDati.CHIUDI);
    nascondi(opener.frmDati.folderTree);
    visualizza(opener.frmDati.imgOrologio);
    opener.frmDati.action = 'NavigatoreAggiungi.jsp?'+opener.frmDati.parametri.value;

    self.close();
    opener.frmDati.submit();
  }else{
    self.close();
  }
}

function change_cboPreCaratteristica(){
  if (valCboPreCaratt!=frmDati.cboPreCaratteristica.value){
    valCboPreCaratt=frmDati.cboPreCaratteristica.value;
  }
}  

function setColocazione(checked){
  if(checked){
    document.frmDati.colocazione.value = "S";
  }else{
    document.frmDati.colocazione.value = "N";
  }  
}

function setElemTrasm(checked){
  if(checked){
    document.frmDati.elemento_trasmissivo.value = "S";
  }   
  else
  {
    document.frmDati.elemento_trasmissivo.value = "N";
  } 
}

</script>

</HEAD>
<BODY onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()" >

<%
  codiceDB = remoteEnt_Catalogo.getCodicePrestazione();
  codice_corretto = codiceDB;
%>

<form name="frmDati" method="post" action="">
<input type="hidden" name="codiceDB" id="codiceDB" value="<%=codiceDB%>">
<input type="hidden" name="codice_corretto" id="codice_corretto" value="<%=codice_corretto%>">
<input type="hidden" name="elemento_trasmissivo" id="elemento_trasmissivo" value="0">
<input type="hidden" name="colocazione" id="colocazione" value="N">
<input type="hidden" name="navigatore" id="navigatore" value="<%=navigatore%>">
<input type="hidden" name="operazione" id="operazione" value="<%=operazione%>">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">

<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr height="30">
	<td align="left"><img src="../images/catalogo.gif" alt="" border="0"></td>
  </tr>
</table>
	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">DEFINIZIONE NUOVA PRESTAZIONE AGGIUNTIVA JPUB2</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<br>

<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Anagrafica Prestazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
  <tr>
    <td height="30" width="35%" class="textB" align="right">   Codice Prestazione </td>
    <TD>
      <INPUT class="text" id="strCodePrestAgg" name="strCodePrestAgg"  obbligatorio="si" tipocontrollo="intero" label="Codice Prestazione" Update="false" size="35" maxlength=9 value="<%=codiceDB%>">
    </TD>
  </tr>
  <tr>
    <td height="30" width="35%" class="textB" align="right">  Descrizione Prestazione </td>
    <TD>
      <INPUT class="text" id="strDescPrestAgg" name="strDescPrestAgg"  obbligatorio="si" tipocontrollo="intero" label="Descrizione Prestazione" Update="false" size="35">
    </TD>
  </tr>
<%--
  <tr>
    <td height="30" width="35%" class="textB" align="right" nowrap>Descrizione Caratteristica</td>
    <td height="30" width="65%">
      <select class="text" title="Caratteristica" name="cboPreCaratteristica" onchange="change_cboPreCaratteristica();" >
        <option class="text"  value="">[Seleziona Caratteristica]</option>
      </select>
    </td>
  </tr>
  <tr>
    <td height="30" width="35%" class="textB" align="right" nowrap>Elemento Trasmissivo</td>
    <td>
      <input type="checkbox" name="strElementoTrasmissivo" onclick="setElemTrasm(this.checked)">
    </td>
  </tr>
  <tr>
    <td height="30" width="35%" class="textB" align="right" nowrap>Colocazione</td>
    <td>
      <input type="checkbox" name="strColocazione" onclick="setColocazione(this.checked)">
    </td>
  </tr>
--%>
</table>

 <!--PULSANTIERA-->
<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
	<tr>
		<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
      <sec:ShowButtons td_class="textB"/>
    </td>
  </tr>
</table>
</form>

<script language="JavaScript">
  if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>

</BODY>
</HTML>