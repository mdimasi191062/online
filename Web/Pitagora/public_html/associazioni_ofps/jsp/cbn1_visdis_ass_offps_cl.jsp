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
<!-- inclusione della tagLib che permette l'instanziazione dell'oggetto remoto  -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>

<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_visdis_ass_offps_cl.jsp")%>
</logtag:logData>

<!-- instanziazione degli oggetti remoti-->
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPsHome" location="Ctr_AssociazioniOfPs" />
<EJB:useBean id="remoteCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPs" scope="session">
    <EJB:createBean instance="<%=homeCtr_AssociazioniOfPs.create()%>" />
</EJB:useBean>

<% 
//dichiarazione variabili
//Descrizioni
String strDescContratto = "";
String strDescCliente = "";
String strDescPS = "";
String strDescPrestAgg = "";
String strDescOggFatt = "";
String strDescTipoCaus = "";

String strModAppl = "";
String strPageAction = "";
String strViewStateDati = "";
String strViewStateRicerca = "";
String strReturn = "";
String strMostraAssocDisattive = "";
DB_OggettoFatturazione objOggFattForIns = null;


//cattura i valori provenienti dal radio
strViewStateRicerca = request.getParameter("viewStateRicerca");
strViewStateDati = request.getParameter("viewStateDati");
strPageAction = Misc.getParameterValue(strViewStateDati,"vsPageAction");
//se � stata chiamata la disattivazione devo chiamare il metodo checkDisattiva
if(strPageAction.equalsIgnoreCase("DIS")){

	  objOggFattForIns = new DB_OggettoFatturazione();
	  //carico il data been
      objOggFattForIns.setCODE_OGG_FATRZ(Misc.getParameterValue(strViewStateDati,"vsCODE_OGG_FATRZ"));
	  objOggFattForIns.setDESC_OGG_FATRZ(Misc.getParameterValue(strViewStateDati,"vsDescOggFatt"));
	  objOggFattForIns.setCODE_CONTR(Misc.getParameterValue(strViewStateDati,"vsCODE_CONTR"));
	  objOggFattForIns.setDESC_PREST_AGG(Misc.getParameterValue(strViewStateDati,"vsDescPrestAgg"));
	  objOggFattForIns.setDESC_ES_PS(Misc.getParameterValue(strViewStateDati,"vsDescEsPs"));
	  objOggFattForIns.setCODE_PR_PS_PA_CONTR(Misc.getParameterValue(strViewStateDati,"vsCODE_PR_PS_PA_CONTR"));
	  objOggFattForIns.setDATA_INIZIO_VALID_OF_PS(Misc.getParameterValue(strViewStateDati,"vsDataInizioValidOfPs"));
	  objOggFattForIns.setDATA_FINE_VALID_OF_PS(Misc.getParameterValue(strViewStateDati,"vsDataFineValidOfPs"));
	  objOggFattForIns.setTIPO_FLAG_ANTTO_POSTTO(Misc.getParameterValue(strViewStateDati,"vsTIPO_FLAG_ANTTO_POSTTO"));
	  objOggFattForIns.setQNTA_SHIFT_CANONI(Misc.getParameterValue(strViewStateDati,"vsQNTA_SHIFT_CANONI"));
	  objOggFattForIns.setCODE_TIPO_CAUS(Misc.getParameterValue(strViewStateDati,"vsCODE_TIPO_CAUS"));
	  objOggFattForIns.setDESC_TIPO_CAUS(Misc.getParameterValue(strViewStateDati,"vsDescTipoCaus"));
	  objOggFattForIns.setDESC_CLAS_OGG_FATRZ(Misc.getParameterValue(strViewStateDati,"vsDescClasOggFatt"));
	  //chiamare il metodo
	  strReturn = remoteCtr_AssociazioniOfPs.chkDisattivaAssociazione(objOggFattForIns);
}

//Descrizioni
strDescContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicDescContratto");
strDescCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicDescCliente");
strDescPS = Misc.getParameterValue(strViewStateRicerca,"vsRicDescPs");
strDescPrestAgg = Misc.getParameterValue(strViewStateRicerca,"vsRicDescPrestAgg");
strDescOggFatt = Misc.getParameterValue(strViewStateRicerca,"vsRicDescOggFatt");
strDescTipoCaus = Misc.getParameterValue(strViewStateRicerca,"vsRicDescTipoCaus");
strMostraAssocDisattive = Misc.getParameterValue(strViewStateRicerca,"vsRicMostraAssocDisattive");
%>
<html>
<head>
	<title>Visualizzazione Associazione Of a P/S e Contratto</title>
	<link rel="STYLESHEET" type="text/css" HREF="<%=StaticContext.PH_CSS%>Style.css">
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
			setDefaultProp(objForm);
			//disabilitazione dei controlli
			DisableAllControls(objForm);
// MODIFICA DEL 28/04/2004
      Enable(objForm.CHIUDI);
// FINE MODIFICA
			//disabilitazione delle date
			DisableLink(document.links[0],objForm.imgCalendar)
			DisableLink(document.links[1],objForm.imgCancel)
			<%if(strPageAction.equalsIgnoreCase("DIS")){%>
				Enable(objForm.DISATTIVA);
				EnableLink(document.links[0],objForm.imgCalendar)
				EnableLink(document.links[1],objForm.imgCancel)
				setFocus(objForm.txtDataFineValidita);
				setObjProp(objForm.txtDataFineValidita,"label=Data fine Validit�|tipocontrollo=data|obbligatorio=si")
			<%}%>
        }
		
		function ONDISATTIVA()
		{
			if(validazioneCampi(objForm))
			{
				if(dateToInt(objForm.txtDataFineValidita.value) <= dateToInt(objForm.txtDataInizioValidita.value))
				{
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3135")%>");
					setFocus(objForm.txtDataFineValidita);
					return;
				}
				if(dateToInt(objForm.txtDataFineValidita.value) < dateToInt("<%=DataFormat.getDate()%>"))
				{
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3129")%>");
					setFocus(objForm.txtDataFineValidita);
					return;
				}
				if(checkContinua()){
					//updVS(objForm.viewState,"parAction","DIS");
					//aggiorna il viewState con la DataFineValidOfPs digitata
					updVS(objForm.viewStateDati,"vsDataFineValidOfPs",objForm.txtDataFineValidita.value);
					objForm.action = "<%=StaticContext.PH_ASSOCIAZIONIOFPS_JSP%>cbn1_lista_ass_ofps_2_cl.jsp";
					objForm.submit();
				}
			}
		}

// MODIFICA DEL 28/04/2004
  function ONCHIUDI()
  {
    window.close();
  }

//  FINE MODIFICA
    </SCRIPT>
</head>

<body onload="initialize()">
<form name="frmDati" method="post" action = "">
<input type="hidden" name="viewStateDati" size="300" value="<%=strViewStateDati%>">
<input type="hidden" name="viewStateRicerca" size="300" value="<%=strViewStateRicerca%>">
<!-- intestazione funzionalit�-->
<%
if(!strReturn.equalsIgnoreCase("")){
	
	//String strUrl = request.getContextPath() + "/classic_common/jsp/" + "msg_cl.jsp?msg=" + java.net.URLEncoder.encode(strReturn,com.utl.StaticContext.ENCCharset,) + "&viewStateRicerca=" + java.net.URLEncoder.encode(strViewStateRicerca,com.utl.StaticContext.ENCCharset)+ "&viewStateDati=" + java.net.URLEncoder.encode(strViewStateDati) + "&url=/associazioniofps/jsp/cbn1_lista_ass_ofps_2_cl.jsp";
	String strUrl = "msg_associazioni_ofps_cl.jsp";
    strUrl += "?msg=" + java.net.URLEncoder.encode(strReturn,com.utl.StaticContext.ENCCharset);
    strUrl += "&viewStateRicerca=" + java.net.URLEncoder.encode(strViewStateRicerca,com.utl.StaticContext.ENCCharset);
    strUrl += "&viewStateDati=" + java.net.URLEncoder.encode(strViewStateDati,com.utl.StaticContext.ENCCharset);
    strUrl += "&url=cbn1_lista_ass_ofps_2_cl.jsp";
    
    response.sendRedirect(strUrl);
}
%>
<!-- Immagine Titolo -->
<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_ASSOCIAZIONIOFPS_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
<!-- visualizzazione delle descrizioni  -->
<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Associazioni</td>
						  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
						</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	      <tr>
	        <td width='25%' class="textB" align="right">Cliente:&nbsp;</td>
	        <td width='25%' class="text">
	           &nbsp;<%=strDescCliente%>
	        </td>
	        <td width='25%' class="textB" align="right">Contratto:&nbsp;</td>
	        <td width='25%' class="text">
	           &nbsp;<%=strDescContratto%>
	        </td>
	      </tr>
	      <tr>
	        <td width='25%' class="textB" align="right" valign="2">P/S:&nbsp;</td>
	        <td width='25%' class="text">
	           &nbsp;<%=strDescPS%>
	        </td>
	        <td width='25%' class="textB" align="right">Prestazione&nbsp;<BR>Aggiuntiva:&nbsp;</td>
	        <td width='25%' class="text">
	           &nbsp;<%=strDescPrestAgg%>
	        </td>
	      </tr>
	      <tr>
	        <td width='25%' class="textB" align="right">Oggetto Fatturazione:&nbsp;</td>
	        <td width='25%' class="text">
	           &nbsp;<%=strDescOggFatt%>
	        </td>
	        <td width='25%' class="textB" align="right">Tipo Causale:&nbsp;</td>
	        <td width='25%' class="text">
	           &nbsp;<%=strDescTipoCaus%>
	        </td>
	      </tr>
		  <tr>
		  	<td width='25%' class="textB" align="right">Mostra Ass. Disattive:&nbsp;</td>
	        <td width='75%' class="text" colspan="3">
			   <%if(strMostraAssocDisattive.equals("S")){out.print("SI");} else{out.print("NO");}%>
	        </td>
		  </tr>
	  </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
</table>
<!-- finevisualizzazione delle descrizioni provenienti dalla pagina di ricerca -->
<table width="90%" border="0" align="center" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
							<%if(strPageAction.equalsIgnoreCase("DIS")){%>
				                Disattivazione Associazione OF a P/S e Contratto
				            <%}else{%>
				                Visualizzazione Associazione OF a P/S e Contratto
				            <%}%>
					</td>
					<td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	 <tr>
	      <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
	 </tr>
</table>

<!-- tabella intestazione -->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Prodotto/Servizio</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="76%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
    <td height="30" width="20%" class="textB">Cliente</td>
	<td height="30" width="30%"><input type="text" name="txtCliente" class="text" value = "<%=Misc.getParameterValue(strViewStateRicerca,"vsRicDescCliente")%>" size="20"></td>
	<td height="30" width="20%" class="textB">Contratto</td>
	<td height="30" width="30%">&nbsp;<input type="text" name="txtContratto" class="text" value = "<%=Misc.getParameterValue(strViewStateRicerca,"vsRicDescContratto")%>" size="15"></td>
</tr>
<tr>
    <td height="30" class="textB" width="20%">Prodotto/Servizio</td>
    <td height="30" colspan="3" width="80%"><input type="text" name="txtProdottoServizio" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescEsPs")%>" size="50"></td>
</tr>
<tr>
    <td height="30" width="20%" class="textB">Prest.Aggiuntiva</td>
	<td height="30" width="30%"><input type="text" name="txtPrestAgg" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescPrestAgg")%>" size="20"></td>
	<td height="30" width="20%" class="textB">Tipo Causale</td>
	<td height="30" width="30%">&nbsp;<input type="text" name="txtTipoCausale" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescTipoCaus")%>" size="15"></td>
</tr>
<tr>
  <td colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
</tr>
</table>

<!-- tabella intestazione -->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Oggetto di Fatturazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="76%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="20%" class="textB">Classe</td>
		<td height="30" width="80%"><input type="text" name="txtClasse" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescClasOggFatt")%>" size="40"></td>
	</tr>
	<tr>
		<td height="30" width="20%" class="textB">Descrizione</td>
		<td height="30" width="80%"><input type="text" name="txtDescrizione" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescOggFatt")%>" size="40"></td>
	</tr>
    <tr>
      <td colspan="2" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    </tr>
</table>
<!-- tabella intestazione -->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Modalit� Applicazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="76%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" class="textB" width="20%">Frequenza</td>
		<td width="30%"><input type="text" name="txtFrequenza" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescFreqAppl")%>" size="10"></td>
		<td height="30" class="textB" width="20%">Modalit� appl.ne prorata</td>
		<td width="30%"><input type="text" name="txtModalitaAppProrata" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDescModalAppl")%>" size="10"></td>
	</tr>
	<tr>
		<td height="30" class="textB" width="20%">Modalit� appl.ne</td>
		<%
			String strAppo = Misc.getParameterValue(strViewStateDati,"vsTIPO_FLAG_ANTTO_POSTTO");
			if(strAppo.equalsIgnoreCase("A"))
			{
				strModAppl = "Anticipata";
			}
			if(strAppo.equalsIgnoreCase("P"))
			{
				strModAppl = "Posticipata";
			}
			if(strAppo.equalsIgnoreCase("X"))
			{
				strModAppl = "";
			}
		%>
		<td height="30" width="30%"><input type="text" name="txtModalitaApp" class="text" value = "<%=strModAppl%>" size="10"></td>
		<td height="30" class="textB" width="20%">Shift canoni</td>
		<td height="30" width="30%"><input type="text" name="txtShiftCanoni" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsQNTA_SHIFT_CANONI")%>" size="10"></td>
	</tr>
    <tr>
      <td colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    </tr>
</table>

<!-- tabella intestazione -->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Validit�</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="76%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" class="textB" width="20%">Data Inizio Validit�</td>
		<td height="30" width="30%"><input type="text" name="txtDataInizioValidita" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDataInizioValidOfPs")%>" size="10"></td>
		<td height="30" class="textB" width="20%">Data Fine Validit�</td>
		<td height="30" width="30%" nowrap>
			<input type="text" name="txtDataFineValidita" class="text" value = "<%=Misc.getParameterValue(strViewStateDati,"vsDataFineValidOfPs")%>" size="10" maxlength="10">
			<a href="javascript:showCalendar('frmDati.txtDataFineValidita','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
			<a href="javascript:clearField(objForm.txtDataFineValidita);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
		</td>
	</tr>
    <tr>
      <td colspan="4" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    </tr>
</table>

<!-- pulsantiera -->
 <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
   <tr>
   	 <%if(strPageAction.equalsIgnoreCase("DIS")){%>
	 	<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
         	<!-- <input class="textB" type="button" name="DISATTIVA" value="DISATTIVA" onClick = "ONDISATTIVA();"> -->
			<sec:ShowButtons td_class="textB"/>
     	</td>
	 <%}%>	
   </tr>
    <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
              <tr>
                <td width="50%" class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
					<sec:ShowButtons td_class="textB"/>
				</td>
              </tr>
            </table> 
        </td>
      </tr>
 </table>	
</form>
</body>
</html>

