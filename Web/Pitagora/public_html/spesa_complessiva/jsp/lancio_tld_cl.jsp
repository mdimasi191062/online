<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lancio_tld_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessivaHome" location="Ent_SpesaComplessiva" />
<EJB:useBean id="remoteEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessiva" scope="session">
    <EJB:createBean instance="<%=homeEnt_SpesaComplessiva.create()%>" />
</EJB:useBean>

<%
String lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
String lstrMeseRif = "";
String lstrAnnoRif = "";

String strUrlDiPartenza = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp";
	   strUrlDiPartenza += "?CONTINUA=true";
String strMessaggioAcqEffettuata = "Impossibile effettuare Lancio: Acquisizione Importi gi� effettuata!";
String strMessaggioAcqManInCorso = "Impossibile effettuare Lancio: Acquisizione Importi Manuale in corso!";
int i = 0;
String strBgColor = "";

/*CONTROLLO POSSIBILITA' LANCIARE BATCH*/
Vector vctPeriodoRiferimento = new Vector();
vctPeriodoRiferimento = (Vector)remoteEnt_SpesaComplessiva.getPeriodoAutomTLD(lstrCodiceTipoContratto);
if(! (vctPeriodoRiferimento.size() > 0)){
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMessaggioAcqEffettuata,com.utl.StaticContext.ENCCharset); 
	strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
	response.sendRedirect(strUrl);
}

//il periodo di riferimento esiste...
DB_Account objDB_Account = new DB_Account();
objDB_Account = (DB_Account)vctPeriodoRiferimento.elementAt(0);

lstrMeseRif = (String)objDB_Account.getDATA_MM_RIF_SPESA_COMPL();
lstrAnnoRif = (String)objDB_Account.getDATA_AA_RIF_SPESA_COMPL();

Integer intRes = (Integer)remoteEnt_SpesaComplessiva.CountDettSpComplNoPit(lstrMeseRif,
															 lstrAnnoRif,
															 lstrCodiceTipoContratto);
if(intRes.intValue() != 0){
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMessaggioAcqManInCorso,com.utl.StaticContext.ENCCharset); 
	strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
	response.sendRedirect(strUrl);
}

//@@@@@.....

/*FINE CONTROLLO POSSIBILITA' LANCIARE BATCH*/


%>
<html>
<head>
	<title></title>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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
	<SCRIPT LANGUAGE='Javascript'>
		var objForm = null;
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle propriet� di default per tutti gli oggetti della form
			setDefaultProp(objForm);
		}
		
		function ONLANCIOBATCH()
		{
			if(validazioneCampi(objForm))
			{
				objForm.action = "lancio_tld_2_cl.jsp";
				objForm.submit();
			}
			
		}
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<input type='hidden' name='hidCodiceTipoContratto' value='<%=lstrCodiceTipoContratto%>'>
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_SPESACOMPLESSIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Automatico Acquisizioni Importi da TLD</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td height="30" class="textB">&nbsp;</td>
			</tr>
			<tr>
				<td align="center">
					<table width="80%" align="center" border="0" bordercolor="red">
						<tr>
							<td class="textB" align="right" width="50%">Periodo di Riferimento:</td>
							<td class="text" width="50%">
								<%=lstrMeseRif + " - " + lstrAnnoRif%>
								<input type='hidden' class="text" name='txtMeseRif' value='<%=lstrMeseRif%>'>
								<input type='hidden' class="text" name='txtAnnoRif' value='<%=lstrAnnoRif%>'>
							</td>
						</tr>
						<tr>
							<td width="50%" class="textB" align="right">Caricamento Importi TLD da File:</td>
							<td width="50%">
								<input type='checkbox' name='chkFlagScelta' value='1'>
							</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td colspan="2" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
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
</body>
</html>