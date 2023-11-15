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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"Tariffe_sconti_lista.jsp")%>
</logtag:logData>
<%
//dichiarazioni delle variabili
String strAppoData = "";
int intAction=0;
int intFunzionalita=0;
//codici
String strCodeContr = "";
String strCodeTipoContratto = "";
String strCodeCliente = "";
String strFlagFiltro = "";

//descrizioni 
String strDescTipoContratto = "";
String strDescContratto = "";
String strDescCliente = "";

//altro

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@PARAMETRI PROVENIENTI DALLA PMASCHERA DI RICERCA@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@UTILIZZATO ANCHE PER I PARAMETRI DI FILTRAGGIO LISTA@@@@@@@@@@@@@@@@@@@@@@@@@@
//reperisco  parametri
String strViewStateRicerca = Misc.nh(request.getParameter("viewStateRicerca"));
//ricevo i prametri per invocare il metodo che carica la lista
//codici
strCodeTipoContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeTipoContratto");
strCodeContr = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeContratto");
strCodeCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeCliente");
strFlagFiltro=request.getParameter("strFlagFiltro");
//Descrizioni
strDescTipoContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicDescTipoContratto");
strDescContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicDescContratto");
strDescCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicDescCliente");
//altro
intFunzionalita = Integer.parseInt(Misc.getParameterValue(strViewStateRicerca,"vsRicIntFunzionalita"));
intAction = Integer.parseInt(Misc.getParameterValue(strViewStateRicerca,"vsRicIntAction"));
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%>
<EJB:useHome id="homeEnt_TariffeSconti" type="com.ejbSTL.Ent_TariffeScontiHome" location="Ent_TariffeSconti" />
<EJB:useBean id="remoteEnt_TariffeSconti" type="com.ejbSTL.Ent_TariffeSconti" scope="session">
    <EJB:createBean instance="<%=homeEnt_TariffeSconti.create()%>" />
</EJB:useBean>

<script LANGUAGE="javascript">

function inizialize()
{
    if(<%=strFlagFiltro%> == "1")
    {
    document.frmDati.chkFiltro.checked = true;
    }

    Disable(document.frmDati.DISATTIVA);
}

function RadioSelezione()
{
  Enable(document.frmDati.DISATTIVA);
}

function ONDISATTIVA()
{
  //var SelectedTariffa ="\""+ getRadioButtonValue(document.frmDati.radioTariffaSel).toString();
  
  document.frmDati.viewStateModifica.value = getRadioButtonValue(document.frmDati.radioTariffaSel).toString();

  document.frmDati.viewStateModifica.value += "|strDescCliente=<%=strDescCliente%>"
  document.frmDati.viewStateModifica.value += "|strDescContratto=<%=strDescContratto%>"
  document.frmDati.viewStateModifica.value += "|strCodeContr=<%=strCodeContr%>"
  document.frmDati.viewStateModifica.value += "|strCodeCliente=<%=strCodeCliente%>"
  document.frmDati.viewStateModifica.value += "|intAction=<%=intAction%>"
  document.frmDati.viewStateModifica.value += "|intFunzionalita=<%=intFunzionalita%>"
      
  document.frmDati.action= "Tariffe_sconti_Upd.jsp";
  document.frmDati.submit();
}

function ONCHIUDI()
{
  window.close();
}

function filtra()
{

  popolaviewState();
  var URLstringa = "Tariffe_sconti_lista.jsp?viewStateRicerca=" + document.frmDati.viewStateRicerca.value ;
      
    if(document.frmDati.chkFiltro.checked == true)
    {
      URLstringa += "&strFlagFiltro=1";
    }
    else
    {
      URLstringa += "&strFlagFiltro=0";
    }
  document.frmDati.action = URLstringa;
  document.frmDati.submit();
}

function popolaviewState()
{
	//
	updVS(document.frmDati.viewStateRicerca,"vsRicIntAction","<%=intAction%>");
	updVS(document.frmDati.viewStateRicerca,"vsRicIntFunzionalita","<%=intFunzionalita%>");
	//CODICI
	updVS(document.frmDati.viewStateRicerca,"vsRicCodeTipoContratto","<%=strCodeTipoContratto%>");
	updVS(document.frmDati.viewStateRicerca,"vsRicCodeCliente","<%=strCodeCliente%>");
	updVS(document.frmDati.viewStateRicerca,"vsRicCodeContratto","<%=strCodeContr%>");
	//DESCRIZIONI
	updVS(document.frmDati.viewStateRicerca,"vsRicDescTipoContratto","<%=strDescTipoContratto%>");
	updVS(document.frmDati.viewStateRicerca,"vsRicDescCliente","<%=strDescCliente%>");
	updVS(document.frmDati.viewStateRicerca,"vsRicDescContratto","<%=strDescContratto%>");
}

</script>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
</TITLE>
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
</HEAD>
<BODY onload="inizialize();">
<form name="frmDati" method="post" action="" >
	<input type="hidden" name="hidCodeUnitaMisura" value="">
	<input type="hidden" name="viewStateRicerca" value="">
  <input type="hidden" name="viewStateModifica" value="">
<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
	<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">LISTA ASSOCIAZIONE TARIFFE SCONTI</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<br>
<!-- dati di riepilogo -->
<!-- tabella intestazione -->

<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Criteri di Ricerca Associazioni</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>


<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	  	<td width="15%" height="20" class="textB" align="right">Tipo Contratto:&nbsp;</td>
      <td width="35%" height="20" class="text">
         	<%=strDescTipoContratto%>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
</tr>
<tr>
	<td height="30" width="15%" class="textB">Cliente:</td>
	<td width="35%" height="20" class="text">
         	&nbsp;<%=strDescCliente%>
  </td>
	<td height="30" width="15%" class="textB">Contratto:</td>
	<td width="35%" height="20" class="text">
          &nbsp;<%=strDescContratto%>
  </td>
</tr>
</table>
<!-- fine dati di riepilogo-->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lista Associazioni</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<%

Vector vctTariffeSconti = null;
vctTariffeSconti = remoteEnt_TariffeSconti.getTariffeSconti (intAction,
                                                    intFunzionalita,
									                                  strCodeCliente,
                                                    strCodeContr,
                                                    strCodeTipoContratto,
                                                    strFlagFiltro);

%>

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" >
  <tr>
    <td width="">&nbsp;</td>
    <td width="15%" align="center" class="textB">Sconto</td>
    <td width="15%" align="center" class="textB">%</td>
    <td width="15%" align="center" class="textB">Valore</td>
    <td width="15%" align="center" class="textB">Data Inizio validità</td>
    <td width="15%" align="center" class="textB">Data fine validità</td>
    <td width="15%" align="center" class="textB">Prodotto/Servizio</td>
  </tr>
<%
int i;
String bgcolor = "";
int intRecTotali = vctTariffeSconti.size();
for(i=0;i < intRecTotali ;i++)
	{
      DB_TariffeSconti lobj_TariffaSconti = (DB_TariffeSconti)vctTariffeSconti.elementAt(i);
      //cambia il colore delle righe
      if ((i%2)==0)
                bgcolor=StaticContext.bgColorRigaPariTabella;
              else
                bgcolor=StaticContext.bgColorRigaDispariTabella;%>
      <tr bgcolor="<%=bgcolor%>">
        <td class="text" bgcolor="<%=bgcolor%>">
		        <input type="radio" name="radioTariffaSel" onclick="RadioSelezione();" value="CODE_TARIFFA=<%=lobj_TariffaSconti.getCODE_TARIFFA()%>|CODE_PR_TARIFFA=<%=lobj_TariffaSconti.getCODE_PR_TARIFFA()%>|CODE_SCONTO=<%=lobj_TariffaSconti.getCODE_SCONTO()%>|DATA_INIZIO_VALID=<%=lobj_TariffaSconti.getDATA_INIZIO_VALID()%>">
        </td>
        <td width="" class="text" align="left" nowrap>&nbsp;<%=Misc.nh(lobj_TariffaSconti.getDESC_SCONTO())%></td>
        <td width="" class="text" align="right" nowrap>&nbsp;<%=Misc.nh(lobj_TariffaSconti.getVALO_PERC_SCONTO())%></td>
        <td width="" class="text" align="right" nowrap>&nbsp;<%=Misc.nh(lobj_TariffaSconti.getVALO_DECR_TARIFFA())%></td>
        <td width="" class="text" align="left" nowrap>&nbsp;<%=Misc.nh(lobj_TariffaSconti.getDATA_INIZIO_VALID())%></td>
        <td width="" class="text" align="left" nowrap>&nbsp;<%=Misc.nh(lobj_TariffaSconti.getDATA_FINE_VALID())%></td>
        <td width="" class="text" align="left" nowrap>&nbsp;<%=Misc.nh(lobj_TariffaSconti.getDESC_ES_PS())%></td>
      </tr>
<%}%>

</table>

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
  <tr>
      <td align="center" width="50%" class="textB">
        <input type="checkbox" name="chkFiltro">Mostra anche associazioni disattive
      </td>
      <td align="center" width="50%" class="textB">
        <input type="button" class="textB" name="BtnFiltra" onclick="filtra()" value="Filtra">
      </td>
  </tr>
</table>

 <!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td bgcolor="white"><img src="<=StaticContext.PH_COMMON_IMAGES>pixel.gif" width="1" height="3"></td>
		</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	  <tr>
	    <td class="textB" bgcolor="<=StaticContext.bgColorTestataTabella>" align="left">
			<sec:ShowButtons td_class="textB"/>
	    </td>
	  </tr>
	</table>
</form>
</body>
</html>
