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
<%=StaticMessages.getMessage(3006,"cbn1_servizio_prodotto_sel.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Servizi" type="com.ejbSTL.Ent_ServiziHome" location="Ent_Servizi" />
<EJB:useBean id="remoteEnt_Servizi" type="com.ejbSTL.Ent_Servizi" scope="session">
    <EJB:createBean instance="<%=homeEnt_Servizi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Offerte" type="com.ejbSTL.Ent_OfferteHome" location="Ent_Offerte" />
<EJB:useBean id="remoteEnt_Offerte" type="com.ejbSTL.Ent_Offerte" scope="session">
    <EJB:createBean instance="<%=homeEnt_Offerte.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Prodotti" type="com.ejbSTL.Ent_ProdottiHome" location="Ent_Prodotti" />
<EJB:useBean id="remoteEnt_Prodotti" type="com.ejbSTL.Ent_Prodotti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Prodotti.create()%>" />
</EJB:useBean>
<%
String  tipoTariffa = Misc.nh(request.getParameter("tipo_tariffa"));
if (!tipoTariffa.equalsIgnoreCase("")) {
//    request.getSession().setAttribute("tipo_tariffa",tipoTariffa);
}
%>
<HTML>
<HEAD>

<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<%  if (!tipoTariffa.equalsIgnoreCase("")) { %>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style1.css" TYPE="text/css">
<% } %>
<TITLE>
</TITLE>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>

<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  var objXmlServ = null;
  var objXmlOff = null;
  var objXmlProd = null;
  var valCboServizio = '';
  var valCboOfferta = '';
  var objWindows = null;

  function Initialize() {

    objXmlServ = CreaObjXML();
    objXmlOff = CreaObjXML();
    objXmlProd = CreaObjXML();

    objXmlServ.loadXML('<MAIN><%=remoteEnt_Servizi.getServiziXml()%></MAIN>');
    objXmlOff.loadXML('<MAIN><%=remoteEnt_Offerte.getOfferteXml()%></MAIN>');
    objXmlProd.loadXML('<MAIN><%=remoteEnt_Prodotti.getProdottiXml()%></MAIN>');

    CaricaComboDaXML(frmDati.cboServizio,objXmlServ.documentElement.selectNodes('SERVIZIO'));
        
	}


  function change_cboServizio(){
    if (valCboServizio!=frmDati.cboServizio.value){

      valCboServizio=frmDati.cboServizio.value;
      
      if(frmDati.cboServizio.value!=''){
        var objNodes = objXmlOff.documentElement.selectNodes('OFFERTA[SERVIZIO=' + frmDati.cboServizio.value + ']');
        
        CaricaComboDaXML(frmDati.cboOfferta,objNodes);
      }
      else{
        ClearCombo(frmDati.cboOfferta);        
      }
      ClearCombo(frmDati.cboProdotto);
      valCboOfferta = '';
    }
  }

  function change_cboOfferta(){
    if (valCboOfferta!=frmDati.cboOfferta.value){
      valCboOfferta=frmDati.cboOfferta.value;
 
      if(frmDati.cboOfferta.value!=''){
        var objNodes = objXmlProd.documentElement.selectNodes('PRODOTTO[./PAR/SERVIZIO=' + frmDati.cboServizio.value + '][./PAR/OFFERTA=' + frmDati.cboOfferta.value + ']');
          CaricaComboDaXML(frmDati.cboProdotto,objNodes);
      }
      else{
        ClearCombo(frmDati.cboProdotto);
      }
    }
  }
  
	function ONSELEZIONA() {
    var URL='';
    if(frmDati.cboServizio.value==''){
      alert('Occorre selezionare un servizio.');
      frmDati.cboServizio.focus();
      return;
    }

    if(frmDati.cboOfferta.value==''){
      alert('Occorre selezionare un\'offerta.');
      frmDati.cboOfferta.focus();
      return;
    }

    if(frmDati.cboProdotto.value==''){
      alert('Occorre selezionare un prodotto.');
      frmDati.cboProdotto.focus();
      return;
    }
     URL = 'cbn1_lista_tariffe_prodotto.jsp?Servizio=' + valCboServizio; 
     URL += '&Prodotto=' + frmDati.cboProdotto.value + '&Offerta=' + valCboOfferta;
     URL += '&DescProdotto=' + getComboText(frmDati.cboProdotto);
     URL += '&DescServizio=' + getComboText(frmDati.cboServizio);
     URL += '&tipo_tariffa=' + frmDati.tipo_tariffa.value;
   
     objWindows = window.open(URL,'_new','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
	}
  
</SCRIPT>

</HEAD>


<BODY  onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()"  >


<form   name="frmDati" method="post" action=""   >
 <INPUT type="hidden" name="tipo_tariffa" id="tipo_tariffa" value="<%=tipoTariffa%>">
<!-- Immagine Titolo style="background: url(../images/facsimile.jpg) no-repeat;"-->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0"  >
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  </tr>
</table>
	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"  >
			  <% 
          String titolo = "TARIFFA PER SERVIZIO";
           String  etichetta= "";
          if (!tipoTariffa.equalsIgnoreCase("")) {
             titolo = "TARIFFA PER VERIFICA";
             etichetta= "        PER VERIFICA       ";
             
          }
        %> 
      
        <tr>
        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=titolo%></td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Servizio</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
  <td height="30" width="25%" class="textB" align="right">Servizio&nbsp;&nbsp;</td>
	<td height="30" width="75%">
		<select class="text" title="Servizio" name="cboServizio" onchange="change_cboServizio();" >
       <option class="text"  value="">[Seleziona Servizio]</option>
    </select>
	</td>
</tr>
<tr>
  <td height="30" width="25%" class="textB" align="right">Offerta&nbsp;&nbsp;</td>
	<td height="30" width="75%">
		<select class="text" title="Servizio" name="cboOfferta" onchange="change_cboOfferta();" >
      <option class="text"  value="">[Seleziona Offerta]</option>
    </select>
	</td>
</tr>
<tr>
  <td height="30" width="25%" class="textB" align="right">Prodotto&nbsp;&nbsp;</td>
	<td height="30" width="75%">
		<select class="text" title="Prodotto" name="cboProdotto"> <!--onchange="change_cboProdotto();"-->
			<option class="text" value="">[Seleziona Prodotto]</option>
		</select>
	</td>
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
    <td class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"><%=etichetta%></td> 
    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
      <sec:ShowButtons td_class="textB"/>
    </td>
    <td  class="redB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center"> <%=etichetta%> </td>
  </tr>

</table>
</form>

</BODY>
</HTML>

