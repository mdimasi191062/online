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
<%=StaticMessages.getMessage(3006,"pre_inserimento_AssOffServIns.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
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
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>

<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  var objXmlPreOff = null;
  var objXmlPreServ = null;
  var valCboPreOfferte = '';
  var valCboPreServizi = '';
  var objWindows = null;

  function Initialize() {
    
    objXmlPreServ = CreaObjXML();
    objXmlPreOff  = CreaObjXML();
    
    objXmlPreServ.loadXML('<MAIN><%=remoteEnt_Catalogo.getPreServiziXml()%></MAIN>');
    objXmlPreOff.loadXML ('<MAIN><%=remoteEnt_Catalogo.getPreOfferteXml()%></MAIN>');
    
    CaricaComboDaXML(frmDati.cboPreServizi,objXmlPreServ.documentElement.selectNodes('SERVIZIO'));
    CaricaComboDaXML(frmDati.cboPreOfferte,objXmlPreOff.documentElement.selectNodes('OFFERTA'));
    
	}
  
	function ONCONFERMA() {
    var URL='';
    if(frmDati.cboPreServizi.value==''){
      alert('Occorre selezionare un Servizio.');
      frmDati.cboPreServizi.focus();
      return;
    }

    if(frmDati.cboPreOfferte.value==''){
      alert('Occorre selezionare una Offerta.');
      frmDati.cboPreOfferte.focus();
      return;
    }

    if(document.frmDati.srcDIV.value.length==0){
      alert('La data inizio validit� � obbligatoria.');
      return;
    }
    if(document.frmDati.srcDFV.value.length==0){
      alert('La data fine validit� � obbligatoria.');
      return;
    }
    
    if(document.frmDati.srcDFV.value.length!=0 && !CheckNum(document.frmDati.app_fre_cicli_cs.value,3,0,false)){
      alert('Frequenza Ciclo per Classi Sconto deve essere un numero.');
      document.frmDati.val_rec.focus();
      return;
    }

    URL = 'pre_inserimento_AssOffServ.jsp?operazione=1';
    URL += '&PreOfferte=' + document.frmDati.codice_offerta.value;
    URL += '&PreServizi=' + document.frmDati.codice_servizio.value;
    URL += '&DataIni=' + document.frmDati.srcDIV.value;
    URL += '&DataFine=' + document.frmDati.srcDFV.value;
    URL += '&FreCicliCS=' + document.frmDati.app_fre_cicli_cs.value;

    if(controlloDate(document.frmDati.srcDIV.value,document.frmDati.srcDFV.value)){
      frmDati.action = URL;
      frmDati.submit();
    }else{
      alert('La Data Inizio Validit� deve essere minore della Data Fine Validit�');
      return;
    }
	}

  function change_cboPreServizi(value){
     document.frmDati.codice_servizio.value = value;
  }

  function change_cboPreOfferte(value){
     document.frmDati.codice_offerta.value = value;
  }

  function ONANNULLA(){
     document.frmDati.action = 'pre_inserimento_AssOffServ.jsp';
     document.frmDati.submit();
  }

  function controlloDate(data_inizio, data_fine){    
       var tokensInizio = data_inizio.split("/");
       var annoInizio   = tokensInizio[2];
       var meseInizio   = tokensInizio[1];
       var giornoInizio = tokensInizio[0]; 
       
       var tokensFine = data_fine.split("/");
       var annoFine   = tokensFine[2];
       var meseFine   = tokensFine[1];
       var giornoFine = tokensFine[0];      

       /*alert('annoInizio ['+annoInizio+']');
       alert('meseInizio ['+meseInizio+']');
       alert('giornoInizio ['+giornoInizio+']');
       
       alert('annoFine ['+annoFine+']');
       alert('meseFine ['+meseFine+']');
       alert('giornoFine ['+giornoFine+']');*/
       
       if(eval(annoInizio) > eval(annoFine)){
         return false;
       }else if(eval(annoInizio) < eval(annoFine)){
         return true;
       }else{
         if(eval(meseInizio) > eval(meseFine)){
            return false;
         }else if(eval(meseInizio) < eval(meseFine)){
            return true;
         }else{
            if(eval(giornoInizio) > eval(giornoFine) || 
               eval(giornoInizio) == eval(giornoFine)){
              return false;
            }else{
              return true;
            }
         }
       }
    }
</SCRIPT>
</HEAD>
<BODY onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">

<form name="frmDati" method="post" action="">
<input type="hidden" name="codice_servizio" id="codice_servizio" value="">
<input type="hidden" name="codice_offerta" id="codice_offerta" value="">

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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">INS. ASSOCIAZIONE OFFERTA/SERVIZIO</td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Associazione Offerta/servizio</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
  <tr>
    <td height="30" width="35%" class="textB" align="right">Servizio&nbsp;&nbsp;</td>
    <td height="30" width="75%">
      <select class="text" title="Servizi" name="cboPreServizi" onchange="change_cboPreServizi(this.value);" >
        <option class="text"  value="">[Seleziona Servizio]</option>
      </select>
    </td>
  </tr>
  <tr>
    <td height="30" width="35%" class="textB" align="right">Offerta&nbsp;&nbsp;</td>
    <td height="30" width="75%">
      <select class="text" title="Offerte" name="cboPreOfferte" onchange="change_cboPreOfferte(this.value);" >
         <option class="text"  value="">[Seleziona Offerte]</option>
      </select>
    </td>
  </tr>
  <tr>  
    <TD class="textB" align="right"> Data Inizio Validit� :&nbsp; </td>
    <td>
      <INPUT class="text" id="srcDIV" name="srcDIV" readonly obbligatorio="si" tipocontrollo="data" label="Data Inizio Valid" Update="false" size="13" value="">
      <a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='imgCalendarDFV' src="../../common/images/img/cal.gif" border="no"></a>
      <a href="javascript:cancelCalendar(document.frmDati.srcDIV);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='imgCancelDFV' src="../../common/images/img/images7.gif" border="0"></a>
    </td>
  </TR> 
  <TR>
    <TD class="textB" align="right"> Data Fine Validit� :&nbsp; </td>
    <td>
      <INPUT class="text" id="srcDFV" name="srcDFV" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Valid" Update="false" size="13" value="31/12/2030">
      <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='imgCalendarDFV' src="../../common/images/img/cal.gif" border="no"></a>
      <a href="javascript:cancelCalendar(document.frmDati.srcDFV);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='imgCancelDFV' src="../../common/images/img/images7.gif" border="0"></a>
    </td>
  </TR>
  <tr>
    <TD class="textB" align="right">Frequenza Cicli per Classi Sconto :&nbsp; </td>
    <td>
      <input type="text" class="text" name="app_fre_cicli_cs" value="" maxlength="3" size="5" style="margin-left: 1px;">
    </td>
  </tr>
</table>
<br>
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
var cal1 = new calendar1(document.forms['frmDati'].elements['srcDIV']);
var cal2 = new calendar1(document.forms['frmDati'].elements['srcDFV']);
cal1.year_scroll = true;
cal1.time_comp = false;
</script>
</BODY>
</HTML>
