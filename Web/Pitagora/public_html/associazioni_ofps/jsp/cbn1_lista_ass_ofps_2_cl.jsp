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
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_ass_ofps_2_cl.jsp")%>
</logtag:logData>

<!-- instanziazione degli oggetti remoti-->
<EJB:useHome id="homeEnt_AssocOggettiFatturazione" type="com.ejbSTL.Ent_AssocOggettiFatturazioneHome" location="Ent_AssocOggettiFatturazione" />
<EJB:useBean id="remoteEnt_AssocOggettiFatturazione" type="com.ejbSTL.Ent_AssocOggettiFatturazione" scope="session">
    <EJB:createBean instance="<%=homeEnt_AssocOggettiFatturazione.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPsHome" location="Ctr_AssociazioniOfPs" />
<EJB:useBean id="remoteCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPs" scope="session">
    <EJB:createBean instance="<%=homeCtr_AssociazioniOfPs.create()%>" />
</EJB:useBean>
<%

//dichiarazione variabili
int z = 0;
Vector vctOggettiFatturazione = null;
String strBgColor = "";
String strChecked = "";
String strViewStateRicerca = "";
String strViewStateDati = "";
String strAppoData = "";
//codici
String strCodeContr = "";
String strCodeTipoContratto = "";
String strCodeCliente = "";
String strCodePs = "";
String strCodePrestAgg = "";
String strCodeTipoCaus = "";
String strCodeOggFatt = "";
String strCodeClasse = "";//non serve in questa pagina
//descrizioni 
String strDescContratto = "";
String strDescCliente = "";
String strDescPS = "";
String strDescPrestAgg = "";
String strDescOggFatt = "";
String strDescTipoCaus = "";

//altro
String strAssDisattiva = "";
String strReturn = "";
String strPageAction = "";
String strViewStateCostructor = "";
String strMostraAssocDisattive = "";
String strSelected = "";

boolean blnAssociazioniDisattive;
boolean blnShowMessage = false;
int intFunzionalita = 0;
int intAction = 0;

//reperisco  parametri
strViewStateRicerca = Misc.nh(request.getParameter("viewStateRicerca"));
strViewStateDati = Misc.nh(request.getParameter("viewStateDati"));
strPageAction = Misc.getParameterValue(strViewStateDati,"vsPageAction");
if(strPageAction.equalsIgnoreCase("DIS"))
{

	  DB_OggettoFatturazione objOggFattForIns = new DB_OggettoFatturazione();
	  //carico il databeen	
	  objOggFattForIns.setCODE_TIPO_CONTR(Misc.getParameterValue(strViewStateRicerca,"vsRicCodeTipoContratto"));
 	  objOggFattForIns.setCODE_OGG_FATRZ(Misc.getParameterValue(strViewStateDati,"vsCODE_OGG_FATRZ"));
	  objOggFattForIns.setDATA_INIZIO_VALID_OF(Misc.getParameterValue(strViewStateDati,"vsDATA_INIZIO_VALID_OF"));
	  objOggFattForIns.setDESC_OGG_FATRZ(Misc.getParameterValue(strViewStateDati,"vsDescOggFatt"));
	  objOggFattForIns.setDATA_FINE_VALID_OF(Misc.getParameterValue(strViewStateDati,"vsDATA_FINE_VALID_OF"));
	  objOggFattForIns.setCODE_CONTR(Misc.getParameterValue(strViewStateRicerca,"vsRicCodeContratto"));
	  objOggFattForIns.setCODE_PREST_AGG(Misc.getParameterValue(strViewStateDati,"vsCODE_PREST_AGG"));
	  objOggFattForIns.setDESC_PREST_AGG(Misc.getParameterValue(strViewStateDati,"vsDescPrestAgg"));
	  objOggFattForIns.setCODE_PS(Misc.getParameterValue(strViewStateDati,"vsCODE_PS"));
	  objOggFattForIns.setDESC_ES_PS(Misc.getParameterValue(strViewStateDati,"vsDescEsPs"));
	  objOggFattForIns.setDATA_INIZIO_VALID(Misc.getParameterValue(strViewStateDati,"vsDATA_INIZIO_VALID"));
	  objOggFattForIns.setDATA_FINE_VALID(Misc.getParameterValue(strViewStateDati,"vsDATA_FINE_VALID"));
	  objOggFattForIns.setCODE_PR_PS_PA_CONTR(Misc.getParameterValue(strViewStateDati,"vsCODE_PR_PS_PA_CONTR"));
	  objOggFattForIns.setDATA_INIZIO_VALID_OF_PS(Misc.getParameterValue(strViewStateDati,"vsDataInizioValidOfPs"));
	  objOggFattForIns.setDATA_FINE_VALID_OF_PS(Misc.getParameterValue(strViewStateDati,"vsDataFineValidOfPs"));
	  objOggFattForIns.setTIPO_FLAG_ANTTO_POSTTO(Misc.getParameterValue(strViewStateDati,"vsTIPO_FLAG_ANTTO_POSTTO"));
	  objOggFattForIns.setQNTA_SHIFT_CANONI(Misc.getParameterValue(strViewStateDati,"vsQNTA_SHIFT_CANONI"));
	  objOggFattForIns.setCODE_TIPO_CAUS(Misc.getParameterValue(strViewStateDati,"vsCODE_TIPO_CAUS"));
	  objOggFattForIns.setDESC_TIPO_CAUS(Misc.getParameterValue(strViewStateDati,"vsDescTipoCaus"));
	  objOggFattForIns.setDESC_CLAS_OGG_FATRZ(Misc.getParameterValue(strViewStateDati,"vsDescClasOggFatt"));%>
	  <% String strLogMessage = "remoteCtr_AssociazioniOfPs.DisattivaAssociazione(" + objOggFattForIns.FieldsToString() + ")";%>
	  <logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3506,strLogMessage)%>
	  </logtag:logData>
	  <%//eseguo la disattivazione
	  strReturn = remoteCtr_AssociazioniOfPs.DisattivaAssociazione(objOggFattForIns);
	  if(strReturn.equals("")) //successo
	  {
	  	strLogMessage += " : Successo" ;
	  }
	  else
	  {
	  	strLogMessage += " : " + strReturn ;
	  }%>
	  <logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3506,strLogMessage)%>
	  </logtag:logData>
<%}


//ricevo i prametri per invocare il metodo che carica la lista
//codici
strCodeTipoContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeTipoContratto");
strCodeContr = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeContratto");
strCodeCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeCliente");
strCodePs = Misc.getParameterValue(strViewStateRicerca,"vsRicCodePS");
strCodePrestAgg = Misc.getParameterValue(strViewStateRicerca,"vsRicCodePrestAgg");
strCodeTipoCaus = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeTipoCaus");
strAppoData = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeOggFatt");
if(strAppoData.equals("")){
	strCodeOggFatt = "";
}else{
	strCodeOggFatt = (String)Misc.split(strAppoData,"$").elementAt(0);
}
//Descrizioni
strDescContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicDescContratto");
strDescCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicDescCliente");
strDescPS = Misc.getParameterValue(strViewStateRicerca,"vsRicDescPs");
strDescPrestAgg = Misc.getParameterValue(strViewStateRicerca,"vsRicDescPrestAgg");
strDescOggFatt = Misc.getParameterValue(strViewStateRicerca,"vsRicDescOggFatt");
strDescTipoCaus = Misc.getParameterValue(strViewStateRicerca,"vsRicDescTipoCaus");
//altro
intFunzionalita = Integer.parseInt(Misc.getParameterValue(strViewStateRicerca,"vsRicIntFunzionalita"));
intAction = Integer.parseInt(Misc.getParameterValue(strViewStateRicerca,"vsRicIntAction"));
strMostraAssocDisattive = Misc.getParameterValue(strViewStateRicerca,"vsRicMostraAssocDisattive");

if(strMostraAssocDisattive.equals("S")){
	blnAssociazioniDisattive = true;
}else{
	blnAssociazioniDisattive = false;
}

//codice per paginatore
//una volta iniziata la paginazione il typeLoad permette di caricare il vettore dalla sessione
String strTypeLoad = Misc.nh(request.getParameter("hidTypeLoad"));

//stringa per riempire la combo dei rec per page
String strValueCombo="5|10|15|20";
String strNumRecXPag = Misc.nh(request.getParameter("cboNumRecXPag"));
String strPaginaRichiesta = Misc.nh(request.getParameter("hidPaginaRichiesta"));
int intRecXPag;
int intRecTotali;
int intNumPaginaRichiesta;
int intLinkBarra=5;
//numero di elementi per pagina
if(strNumRecXPag.equals("")){
	intRecXPag=5;
}else{
	intRecXPag = Integer.parseInt(strNumRecXPag);
}
//numero pagina richiesta
if(strPaginaRichiesta.equals("")){
	intNumPaginaRichiesta=1;
}else{
	intNumPaginaRichiesta = Integer.parseInt(strPaginaRichiesta);
}
//fine codice per paginatore

%>
<%
//se si � verificato un errore durante il controllo per la disattivazione, faccio
// vedere il messaggio su una pagina apposita
if(!strReturn.equalsIgnoreCase("")){
	//IMPOSTO L'ACTION DEL VIEWSTATE A VIS PER NON 
	strViewStateDati = Misc.setParameterValue(strViewStateDati,"vsPageAction","VIS");
	//String strUrl = request.getContextPath() + "/classic_common/jsp/" + "msg_cl.jsp?msg=" + java.net.URLEncoder.encode(strReturn,com.utl.StaticContext.ENCCharset,com.utl.StaticContext.ENCCharset) + "&viewStateRicerca=" + java.net.URLEncoder.encode(strViewStateRicerca,com.utl.StaticContext.ENCCharset)+ "&viewStateDati=" + java.net.URLEncoder.encode(strViewStateDati) + "&url=/associazioniofps/jsp/cbn1_lista_ass_ofps_2_cl.jsp";
	String strUrl = "msg_associazioni_ofps_cl.jsp?msg=" + java.net.URLEncoder.encode(strReturn,com.utl.StaticContext.ENCCharset) + "&viewStateRicerca=" + java.net.URLEncoder.encode(strViewStateRicerca,com.utl.StaticContext.ENCCharset)+ "&viewStateDati=" + java.net.URLEncoder.encode(strViewStateDati,com.utl.StaticContext.ENCCharset) + "&url=/associazioniofps/jsp/cbn1_lista_ass_ofps_2_cl.jsp";
	blnShowMessage = true;
	//response.sendRedirect(strUrl);
}%>
<html>
<head>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
Lista Associazioni OF a Contratto P/S
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
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null ;
	var blnShowMessage = <%=blnShowMessage%>;
	function Initialize(){
		objForm = document.frmDati;
		if(objForm.rdoDati != null)
		{
			//simula il click sul primo radio button
			click_rdoDati();
			Enable(objForm.VISUALIZZA);
		}
		else
		{
			Disable(objForm.DISATTIVA);
			Disable(objForm.VISUALIZZA);
		}
		if(blnShowMessage){
			alert("<%=strReturn%>");
		}
	}

	function ONDISATTIVA(){
		objForm.action='<%=StaticContext.PH_ASSOCIAZIONIOFPS_JSP%>cbn1_visdis_ass_offps_cl.jsp';
		updVS(objForm.viewStateDati,"vsPageAction","DIS");
		
		objForm.submit();
	}
	function ONVISUALIZZA(){
		objForm.action='<%=StaticContext.PH_ASSOCIAZIONIOFPS_JSP%>cbn1_visdis_ass_offps_cl.jsp';
		updVS(objForm.viewStateDati,"vsPageAction","VIS");
		
		objForm.submit();
	}

// MODIFICA DEL 28/04/2004
  function ONCHIUDI()
  {
    window.close();
  }

// FINE MODIFICA

	function click_rdoDati()
	{
		objForm.viewStateDati.value = getRadioButtonValue(objForm.rdoDati);
		if(getVS(objForm.viewStateDati, "vsDataFineValidOfPs")!=""){
			Disable(objForm.DISATTIVA);
		}else{
			Enable(objForm.DISATTIVA);
		}
		
	}
	

</SCRIPT>
</head>
<body onload="Initialize();" topmargin="0">

<form name="frmDati" method="post" action="">
	<input type="hidden" name="hidPaginaRichiesta" value="">
	<input type="hidden" name="hidTypeLoad" value="">
	<input type="hidden" name="viewStateRicerca" value="<%=strViewStateRicerca%>">
	<input type="hidden" name="viewStateDati" value="">
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_ASSOCIAZIONIOFPS_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
<!-- visualizzazione delle descrizioni  -->
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
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
	  	<td class="textB" align="right">Risultati per pag.:&nbsp;</td>
		<td  class="text">
			<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_lista_ass_ofps_2_cl.jsp')">
			<%for(int k = 5;k <= 50; k=k+5){
			if(k==intRecXPag){
			strSelected = "selected";
			}else{
			strSelected = "";
			}
			%>
			  <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
			<%}%>
			</select>
		</td>
		 <td width='25%' class="text">&nbsp;</td>
		 <td width='25%' class="text">&nbsp;</td>
	  </tr>
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
	
	<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Associazioni</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
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
	     <td width="100%" colspan="4" class="text" align="center">
				<table border="0" width="95%" cellspacing="1">
					<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
						<td width="4%"  height="20" class="textB">&nbsp;</td>
						<td width="20%" height="20" class="textB">&nbsp;P/S</td>
						<td width="16%" height="20" class="textB">&nbsp;Prestazione<BR>&nbsp;Aggiuntiva</td>
						<td width="20%" height="20" class="textB">&nbsp;Tipo<BR>&nbsp;Causale</td>
						<td width="20%" height="20" class="textB">&nbsp;Oggetto<BR>&nbsp;Fatturazione</td>
						<td width="10%" height="20" class="textB">&nbsp;Data<BR>&nbsp;Inizio</td>
						<td width="10%" height="20" class="textB">&nbsp;Data<BR>&nbsp;Fine</td>
					</tr>
				        <!-- ciclo -->
					<%  
								if (strTypeLoad.equals("1")){
									vctOggettiFatturazione = (Vector) session.getAttribute("vctOggettiFatturazione");
								}else{
									vctOggettiFatturazione = remoteEnt_AssocOggettiFatturazione.getAssocOggFatturazione(intAction,
																														  intFunzionalita,
																														  strCodeTipoContratto,
																														  strCodeCliente,
																														  strCodeContr,
																														  strCodePs,
																														  strCodePrestAgg,
                                                                                                                          strCodeTipoCaus,
                                                                                                                          strCodeOggFatt, 		
                                                                                                                          blnAssociazioniDisattive,
																														  "");
																			  
									if (vctOggettiFatturazione!=null)
								      session.setAttribute("vctOggettiFatturazione", vctOggettiFatturazione);
								}
								if(vctOggettiFatturazione != null)
                                {
									//@@@@@@@@@@@@Paginatore@@@@@@@@@@@@@@@@@@
									intRecTotali=vctOggettiFatturazione.size();%>
									<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
									<%
									  for(z=((pagerPageNumber.intValue()-1)*intRecXPag);((z < intRecTotali) && (z < pagerPageNumber.intValue()*intRecXPag));z++)	
									//for (z=((intNumPaginaRichiesta-1)*intRecXPag);((z<intRecTotali) && (z<intNumPaginaRichiesta*intRecXPag)); z++)
                                      {
                                            DB_OggettoFatturazione lobj_OggettoFatturazione = new DB_OggettoFatturazione();
                                            lobj_OggettoFatturazione = (DB_OggettoFatturazione)vctOggettiFatturazione.elementAt(z);
									  //cambia il colore delle righe
									  if ((z%2)==0)
					                   	strBgColor=StaticContext.bgColorRigaPariTabella;
					                  else
					                   	strBgColor=StaticContext.bgColorRigaDispariTabella;
									  
									  if(z == ((pagerPageNumber.intValue()-1)*intRecXPag)){
									  	strChecked = "checked";
									  }else{
									  	strChecked = "";
									  }
										%>
										<tr>
											<td width="4%"  bgcolor="<%=strBgColor%>"  class="text">
												<%
													
													//date
													strViewStateCostructor = "vsDATA_FINE_VALID="+ lobj_OggettoFatturazione.getDATA_FINE_VALID() + "|";
                                                    strViewStateCostructor += "vsDataInizioValidOfPs="+ lobj_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS() + "|";
													strViewStateCostructor += "vsDataFineValidOfPs="+ lobj_OggettoFatturazione.getDATA_FINE_VALID_OF_PS() + "|";
													strViewStateCostructor += "vsDATA_INIZIO_VALID_OF="+ lobj_OggettoFatturazione.getDATA_INIZIO_VALID_OF() + "|";
                                                    strViewStateCostructor += "vsDATA_FINE_VALID_OF="+ lobj_OggettoFatturazione.getDATA_FINE_VALID_OF() + "|";
													strViewStateCostructor += "vsDATA_INIZIO_VALID="+ lobj_OggettoFatturazione.getDATA_INIZIO_VALID() + "|";
													//codici
													strViewStateCostructor += "vsCODE_PS="+ lobj_OggettoFatturazione.getCODE_PS() + "|";
													strViewStateCostructor += "vsCODE_PREST_AGG="+ lobj_OggettoFatturazione.getCODE_PREST_AGG() + "|";
													strViewStateCostructor += "vsCODE_CONTR="+ lobj_OggettoFatturazione.getCODE_CONTR() + "|";
													strViewStateCostructor += "vsCODE_PR_PS_PA_CONTR="+ lobj_OggettoFatturazione.getCODE_PR_PS_PA_CONTR() + "|";
													strViewStateCostructor += "vsCODE_OGG_FATRZ="+ lobj_OggettoFatturazione.getCODE_OGG_FATRZ() + "|";
													strViewStateCostructor += "vsCODE_TIPO_CAUS="+ lobj_OggettoFatturazione.getCODE_TIPO_CAUS() + "|";
													//descrizioni
													strViewStateCostructor += "vsDescEsPs="+ lobj_OggettoFatturazione.getDESC_ES_PS() + "|";
													strViewStateCostructor += "vsDescPrestAgg="+ lobj_OggettoFatturazione.getDESC_PREST_AGG() + "|";
													strViewStateCostructor += "vsDescTipoCaus="+ lobj_OggettoFatturazione.getDESC_TIPO_CAUS() + "|";
													strViewStateCostructor += "vsDescClasOggFatt="+ lobj_OggettoFatturazione.getDESC_CLAS_OGG_FATRZ() + "|";
													strViewStateCostructor += "vsDescOggFatt="+ lobj_OggettoFatturazione.getDESC_OGG_FATRZ() + "|";
													strViewStateCostructor += "vsDescFreqAppl="+ lobj_OggettoFatturazione.getDESC_FREQ_APPL() + "|";
													strViewStateCostructor += "vsDescModalAppl="+ lobj_OggettoFatturazione.getDESC_MODAL_APPL() + "|";
													//altro
													strViewStateCostructor += "vsTIPO_FLAG_ANTTO_POSTTO="+ lobj_OggettoFatturazione.getTIPO_FLAG_ANTTO_POSTTO() + "|";
													strViewStateCostructor += "vsQNTA_SHIFT_CANONI="+ lobj_OggettoFatturazione.getQNTA_SHIFT_CANONI() + "|";
													//controllo pagina 
													strViewStateCostructor += "vsPageAction=";
												%>
												<input <%=strChecked%> type="radio" name="rdoDati" value="<%=strViewStateCostructor%>" onclick="click_rdoDati()"> 
											</td>
											<td width="20%" bgcolor="<%=strBgColor%>" class="text"><%=lobj_OggettoFatturazione.getDESC_ES_PS()%></td>
											<td width="16%" bgcolor="<%=strBgColor%>" class="text"><%=lobj_OggettoFatturazione.getDESC_PREST_AGG()%></td>
											<td width="20%" bgcolor="<%=strBgColor%>" class="text"><%=lobj_OggettoFatturazione.getDESC_TIPO_CAUS()%></td>
											<td width="20%" bgcolor="<%=strBgColor%>" class="text"><%=lobj_OggettoFatturazione.getDESC_OGG_FATRZ()%></td>
											<td width="10%" bgcolor="<%=strBgColor%>" class="text"><%=lobj_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS()%></td>
											<td width="10%" bgcolor="<%=strBgColor%>" class="text"><%=lobj_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()%>&nbsp;</td>
											
										</tr>
                                       <% 
				  		            }%>
									<tr>
										<td colspan="10" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
							                <!--paginatore-->
												<pg:index>
													 Risultati Pag.
													 <pg:prev> 
							                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
							                         </pg:prev>
													 <pg:pages>
													 		<%if (pageNumber == pagerPageNumber){%>
															       <b><%= pageNumber %></b>&nbsp;
															<%}else{%>
											                       <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
															<%}%>
													 </pg:pages>
													 <pg:next>
							                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
							                         </pg:next>
												</pg:index>
											</pg:pager>
										</td>
									</tr>
                           		<%}%>
				</table>
		</td>
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