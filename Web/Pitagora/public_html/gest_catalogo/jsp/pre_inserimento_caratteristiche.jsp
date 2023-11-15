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
<%=StaticMessages.getMessage(3006,"pre_inserimento_caratteristiche.jsp")%>
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
    
  strTitolo="Inserimento Caratteristica";

  String codiceDB = "";

  String esito = "";
  String messaggio = "";
  DB_PreCaratteristiche newCaratteristica;
  
  String navigatore = Misc.nh(request.getParameter("navigatore"));
  
  String operazione = Misc.nh(request.getParameter("operazione"));
  if(!operazione.equals("")){
    String codiceCarat = Misc.nh(request.getParameter("strCodeCarat"));
    String codiceTipoCarat = Misc.nh(request.getParameter("strCodeTipoCarat"));  
    String descrizione = Misc.nh(request.getParameter("strDescCarat"));
    
    //Effettuo l'inserimento
    newCaratteristica = new DB_PreCaratteristiche();
    newCaratteristica.setCODE_CARATT(codiceCarat);
    newCaratteristica.setCODE_TIPO_CARATT(codiceTipoCarat);
    newCaratteristica.setDESC_CARATT(descrizione);    
    esito = remoteEnt_Catalogo.insCaratteristica(newCaratteristica);
    if(esito.equals("")){
      messaggio = "Inserimento nuova Caratteristica effettuata correttamente.";
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

var objWindows  = null;
var elementiCheck = '';
var param = '';
  
var objXmlModalNoleg = null;
var valStrCodeTipoCarat = '';

function Initialize() {
  <%if(navigatore.equals("")){%>
  objXmlModalNoleg  = CreaObjXML();
  objXmlModalNoleg.loadXML ('<MAIN><%=remoteEnt_Catalogo.getTipoCaratteristicheXml()%></MAIN>');
  CaricaComboDaXML(frmDati.strCodeTipoCarat,objXmlModalNoleg.documentElement.selectNodes('TIPO_CARATTERISTICHE'));
  <%}%>
}

function ONANNULLA()
{
  document.frmDati.strCodeCarat.value = document.frmDati.codice_corretto.value;
  document.frmDati.strCodeTipoCarat.value = "";  
  document.frmDati.strDescCarat.value = "";
}   

function ONSALVA()
{
  if(document.frmDati.strCodeCarat.value.length==0){
    alert('Il Codice caratteristica è obbligatorio.');
    document.frmDati.strCodeCarat.focus();
    return;
  }
  if(document.frmDati.strCodeTipoCarat.value.length==0){
    alert('Il Codice Tipo Caratteristica è obbligatorio.');
    document.frmDati.strCodeTipoCarat.focus();
    return;
  }
  if(document.frmDati.strDescCarat.value.length==0){
    alert("Descrizione Caratteristica è obbligatorio.");
    document.frmDati.strDescCarat.focus();
    return;
  }
  if(!CheckNum(document.frmDati.strCodeCarat.value,9,0,false)){
    alert('Codice Caratteristica deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.strCodeCarat.focus();
    return;
  }
  if(!CheckNum(document.frmDati.strCodeTipoCarat.value,9,0,false)){
    alert('Codice Tipo Caratteristica deve essere un numero e non deve superare le 9 cifre.');
    document.frmDati.strCodeTipoCarat.focus();
    return;
  }
  if(document.frmDati.navigatore.value != ""){
    //submit su se stessa
    document.frmDati.action = "pre_inserimento_caratteristiche.jsp?operazione=1";
    document.frmDati.submit();
  }else{
    //submit su pagina di visualizzazione elenco
    opener.frmDati.strCodeCarat.value = document.frmDati.strCodeCarat.value;
    opener.frmDati.strCodeTipoCarat.value = document.frmDati.strCodeTipoCarat.value;    
    opener.frmDati.strDescCarat.value = document.frmDati.strDescCarat.value;
    opener.frmDati.hidTypeLoad.value = "0";
    opener.frmDati.intAggiornamento.value = "1";
    self.close();
    opener.frmDati.submit();
  }
}

function ONCHIUDI(){
  if(document.frmDati.navigatore.value != ''){
    /*opener.frmDati.action = 'NavigatoreAggiungi.jsp?'+opener.frmDati.parametri.value;
    opener.document.all('elabCorso').innerText ="ELABORAZIONE IN CORSO..";
    Disable (opener.frmDati.NUOVO);
    Disable (opener.frmDati.SELEZIONA);
    Disable (opener.frmDati.CHIUDI);
    nascondi(opener.frmDati.folderTree);
    visualizza(opener.frmDati.imgOrologio);*/
    self.close();
    opener.frmDatiDett.submit();
  }else{
    self.close();
  }
}
</script>

</HEAD>
<BODY onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">

<%
  codiceDB = remoteEnt_Catalogo.getCodiceCaratteristica();
  codice_corretto = codiceDB;
%>

<form name="frmDati" method="post" action="">
<input type="hidden" name="codiceDB" id="codiceDB" value="<%=codiceDB%>">
<input type="hidden" name="codice_corretto" id="codice_corretto" value="<%=codice_corretto%>">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">DEFINIZIONE NUOVA CARATTERISTICA JPUB2</td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Anagrafica Caratteristica</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
  <tr>
    <td height="30" width="35%" class="textB" align="right">   Codice Caratteristica </td>
    <TD>
      <INPUT class="text" id="strCodeComponente" name="strCodeCarat"  obbligatorio="si" tipocontrollo="intero" label="Codice Caratteristica" Update="false" size="35" maxlength=9 value="<%=codiceDB%>">
    </TD>
  </tr>
  <%
  if (navigatore.equals("1")){
  %>
    <INPUT type="hidden" id="strCodeTipoCarat" name="strCodeTipoCarat" value="1">    
  <%
  }else{
  %>
  <tr>
    <td height="30" width="35%" class="textB" align="right">  Codice Tipo Caratteristica </td>
    <td>
      <select class="text" title="strCodeTipoCarat" name="strCodeTipoCarat">
        <option class="text"  value="">[Seleziona Tipo Caratteristica]</option>
      </select>
    </td>
    <%--<TD>
      <INPUT class="text" id="strCodeTipoCarat" name="strCodeTipoCarat"  obbligatorio="si" tipocontrollo="intero" label="Codice Tipo Caratteristica" Update="false" size="35">
    </TD>--%>
  </tr>
  <%}%>
  <tr>
    <td height="30" width="35%" class="textB" align="right">  Descrizione Caratteristica </td>
    <TD>
      <INPUT class="text" id="strDescCarat" name="strDescCarat"  obbligatorio="si" tipocontrollo="intero" label="Descrizione Caratteristica" Update="false" size="35">
    </TD>
  </tr>
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