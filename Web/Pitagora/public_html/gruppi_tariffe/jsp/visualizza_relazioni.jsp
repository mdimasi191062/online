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
<%=StaticMessages.getMessage(3006,"visualizza_relazioni.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioniHome" location="Ent_TipoRelazioni" />
<EJB:useBean id="remoteEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioni" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipoRelazioni.create()%>" />
</EJB:useBean>

<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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

  var objXmlTipoRel = null;
  var valcboTipoRelazione = '';
  var objWindows = null;

  function Initialize() {

    objXmlTipoRel = CreaObjXML();

    objXmlTipoRel.loadXML('<MAIN><%=remoteEnt_TipoRelazioni.getRelazioniXml()%></MAIN>');

    CaricaComboDaXML(frmDati.cboTipoRelazione,objXmlTipoRel.documentElement.selectNodes('RELAZIONE'));
        
	}

  
  function change_cboTipoRelazione(){
    if (valcboTipoRelazione!=frmDati.cboTipoRelazione.value){

      valcboTipoRelazione=frmDati.cboTipoRelazione.value;
      
    }
  }  

  
	function ONSELEZIONA() {
    var URL='';
    if(frmDati.cboTipoRelazione.value==''){
      alert('Occorre selezionare una relazione.');
      frmDati.cboTipoRelazione.focus();
      return;
    }

     URL = 'visualizza_gruppi.jsp?TipoRelazione=' + valcboTipoRelazione; 
     URL += '&DescTipoRelazione=' + getComboText(frmDati.cboTipoRelazione);

    frmDati.action = URL;
    frmDati.submit();
     //objWindows = window.open(URL,'_new','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
	}
  
</SCRIPT>
</HEAD>
<BODY onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">

<form name="frmDati" method="post" action="">
<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr height="30">
	<td align="left"><img src="../images/GruppiTariffari.gif" alt="" border="0"></td>
  </tr>
</table>
	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">TIPI DI RELAZIONI TRA ACCOUNT JPUB2</td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Relazioni</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
  <td height="30" width="25%" class="textB" align="right">Relazioni&nbsp;&nbsp;</td>
	<td height="30" width="75%">
		<select class="text" title="Relazioni" name="cboTipoRelazione" onchange="change_cboTipoRelazione();" >
       <option class="text"  value="">[Seleziona Relazione]</option>
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
    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
      <sec:ShowButtons td_class="textB"/>
    </td>
  </tr>
</table>
</form>

</BODY>
</HTML>
