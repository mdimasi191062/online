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
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_acquis_imp_spesa_tld_cl.jsp")%>
</logtag:logData>
<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessivaHome" location="Ent_SpesaComplessiva" />
<EJB:useBean id="remoteEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessiva" scope="session">
    <EJB:createBean instance="<%=homeEnt_SpesaComplessiva.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_SpesaComplessiva" type="com.ejbSTL.Ctr_SpesaComplessivaHome" location="Ctr_SpesaComplessiva" />
<EJB:useBean id="remoteCtr_SpesaComplessiva" type="com.ejbSTL.Ctr_SpesaComplessiva" scope="session">
    <EJB:createBean instance="<%=homeCtr_SpesaComplessiva.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
int intNumSpace=100;
int intAction;
int i=0;
int intFunzionalita;
String strTemp = "";
String strComboSize = "7";
String strViewState = "";
String strBgColor = "";
String strChecked = "";
String lstrCodiceTipoContratto = "";
String lstrDescTipoContratto = "";
String lstrSelectedAccount = "";
String lstrRdoClienteElabValue = "";
String lstrPageAction = "";
String strCODE_TEST_SPESA_COMPL = "";
String strDATA_MM_RIF_SPESA_COMPL = "";
String strDATA_AA_RIF_SPESA_COMPL = "";
String strCODE_GEST = "";
String strIMPT_TOT_SPESA_COMPL = "";
String strErrorString = "";
String strParameterToLog = "";
Vector vctAccount = null;
Vector vctProcEmittenti = null;

//determina l'azione per la chiamata ai metodi
if(request.getParameter("intAction") == null){
    intAction = StaticContext.LIST;
}else{
    intAction = Integer.parseInt(request.getParameter("intAction"));
}
//determina la funzionalit� per la chiamata ai metodi
if(request.getParameter("intFunzionalita") == null){
	intFunzionalita = StaticContext.FN_TARIFFA;
}else{
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
}

//paginatore
String strTypeLoad = Misc.nh(request.getParameter("hidTypeLoad"));
String strSelected = "";
//stringa per riempire la combo dei rec per page
String strNumRecXPag = Misc.nh(request.getParameter("cboNumRecXPag"));
int intRecXPag = 0;
int intRecTotali = 0;
//numero di elementi per pagina
if(strNumRecXPag.equals("")){
	intRecXPag=5;
}else{
	intRecXPag = Integer.parseInt(strNumRecXPag);
}
//fine paginatore
//reperisce i valori dal viewState
strViewState = Misc.nh(request.getParameter("hidViewState"));
if(strViewState.equals("")){
	lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
}else{
	lstrPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	lstrCodiceTipoContratto = Misc.getParameterValue(strViewState,"vsCodiceTipoContratto");
	lstrDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
}
//reperisce ol valore dell'account selezionato nella prima lista
lstrSelectedAccount = Misc.nh(request.getParameter("rdoClienteElab"));
if(!lstrSelectedAccount.equals("")){
	//recupera i valori necessari che sono concatenati nella stringa
    Vector vctAppoData = Misc.split(lstrSelectedAccount,"|");
    strCODE_TEST_SPESA_COMPL = (String)vctAppoData.elementAt(2);
    strDATA_MM_RIF_SPESA_COMPL = (String)vctAppoData.elementAt(3);
    strDATA_AA_RIF_SPESA_COMPL = (String)vctAppoData.elementAt(4);
    strCODE_GEST = (String)vctAppoData.elementAt(5);
	//strIMPT_TOT_SPESA_COMPL = (String)vctAppoData.elementAt(6);
}
String strReturn = "";
//determina l'azione da intraprendere
if(lstrPageAction.equals("DEL")){%>
	<% String strLogMessage = "remoteCtr_SpesaComplessiva.delDettaglioSpesaCompl(" + "CODE_TEST_SPESA_COMPL=" + strCODE_TEST_SPESA_COMPL + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3505,strLogMessage)%>
	</logtag:logData>
	<%strReturn = remoteCtr_SpesaComplessiva.delDettaglioSpesaCompl(strCODE_TEST_SPESA_COMPL);
	if(strReturn.equals(""))
	{
		strLogMessage += " : Successo" ;
	}
	else
	{
		strLogMessage += " : " + strReturn ;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3505,strLogMessage)%>
	</logtag:logData>
<%}

if(lstrPageAction.equals("SALVA")){
	Vector vctDettaglioSpesa = new Vector();
	String strAppo = "";
	for (i=1;request.getParameter("hidDati" + i)!=null;i++)
	{
		strAppo = request.getParameter("hidDati" + i);
		Vector vctAppoData = Misc.split(strAppo,"|");
		
		DB_SpesaComplessiva objDbSpesaComp = new DB_SpesaComplessiva();
		objDbSpesaComp.setDESC_PROC_EMITT((String)vctAppoData.elementAt(0));
    	objDbSpesaComp.setDESC_VALO_PROC_EMITT((String)vctAppoData.elementAt(1));
    	objDbSpesaComp.setIMPT_SPESA_COMPL(CustomNumberFormat.getFromNumberFormat(request.getParameter("txtImporto" + i)));
    	objDbSpesaComp.setDATA_ESTRAZIONE_IMPT(request.getParameter("txtDataEstrazione" + i));
    	objDbSpesaComp.setCODE_TEST_SPESA_COMPL((String)vctAppoData.elementAt(2));
    	objDbSpesaComp.setCODE_PROC_EMITT((String)vctAppoData.elementAt(3));
    	objDbSpesaComp.setCODE_DETT_SPESA_COMPL((String)vctAppoData.elementAt(4));
		if(!objDbSpesaComp.getDATA_ESTRAZIONE_IMPT().equals("") && !objDbSpesaComp.getIMPT_SPESA_COMPL().equals("")){
			vctDettaglioSpesa.addElement(objDbSpesaComp);
		}
	}%>
	<%  strParameterToLog = Misc.buildParameterToLog(vctDettaglioSpesa);
		String strLogMessage = "remoteCtr_SpesaComplessiva.salvaDettaglioSpesaCompl(" + strParameterToLog  + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3503,strLogMessage)%>
	</logtag:logData>
	<%strReturn = remoteCtr_SpesaComplessiva.salvaDettaglioSpesaCompl(vctDettaglioSpesa);
	if(strReturn.equals(""))
	{
		strLogMessage += " : Successo" ;
	}
	else
	{
		strLogMessage += " : " + strReturn ;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3503,strLogMessage)%>
	</logtag:logData>
<%}
//carica la prima lista
vctAccount = remoteEnt_Contratti.getAccountSpeComAcqImp(intAction,lstrCodiceTipoContratto,"","1");
DB_Account lobjDbAccount = new DB_Account();
//se � stato selezionato un elemento dalla lista
if(!lstrSelectedAccount.equals("")){
    // estraggo i dati dal record selezionato
    lobjDbAccount.setCODE_TEST_SPESA_COMPL(strCODE_TEST_SPESA_COMPL);
    lobjDbAccount.setDATA_MM_RIF_SPESA_COMPL(strDATA_MM_RIF_SPESA_COMPL);
    lobjDbAccount.setDATA_AA_RIF_SPESA_COMPL(strDATA_AA_RIF_SPESA_COMPL);
    lobjDbAccount.setCODE_GEST(strCODE_GEST);
	//lobjDbAccount.setIMPT_TOT_SPESA_COMPL(strIMPT_TOT_SPESA_COMPL);
	
 	if(lstrPageAction.equals("GENERA")){
		 vctProcEmittenti = remoteCtr_SpesaComplessiva.generaDettaglioSpesaCompl(lstrCodiceTipoContratto,strCODE_GEST);
		 int intLastElementVector  = vctProcEmittenti.size()-1;
		 //recupero l'eventuale errore che si trova nell'ultimo elemento del vettore
		 strErrorString = (String)vctProcEmittenti.elementAt(intLastElementVector);
		 if(!strErrorString.equals("")){
		 	//se ci sono errori visualizzo il messaggio ma carico la lista con il metodo normale
			vctProcEmittenti = remoteEnt_SpesaComplessiva.getProcedureEmittenti (intAction,
		                                                                         lstrCodiceTipoContratto,
		                                                                         lobjDbAccount);
		 }else{
		 	//se non ci sono errori elimino l'ultimo elemento del vettore (messaggio di errore) e carico la lista
            vctProcEmittenti.remove(intLastElementVector);
		 }
	 }else{
		    vctProcEmittenti = remoteEnt_SpesaComplessiva.getProcedureEmittenti (intAction,
		                                                                         lstrCodiceTipoContratto,
		                                                                         lobjDbAccount);
	}
}else{
//� la prima volta
	if(vctAccount.size() > 0){
		 	lobjDbAccount = (DB_Account)vctAccount.elementAt(0);
			 vctProcEmittenti = remoteEnt_SpesaComplessiva.getProcedureEmittenti (intAction,
	                                                                         lstrCodiceTipoContratto,
	                                                                         lobjDbAccount);
	}
}
%>
<html>
<head>
	<title>Acquisizione degli importi di spesa complessiva da TLD</title>
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
		var intNumRowClienti = <%=vctAccount.size()%>;
        <%if(vctProcEmittenti != null){%>
            var intNumRowSpesaComplessiva = <%=vctProcEmittenti.size()%>;
        <%}else{%>
            var intNumRowSpesaComplessiva = 0;
        <%}%>
		var intLastRowIndexSpesaComplessiva = intNumRowSpesaComplessiva;
		var objTemp = null;
		var objTempData = null;
		var objLastObjImporto = null;
		var strDateChanged = "";
		var strErrorString = "<%=strErrorString%>";
		function initialize()
        {
			objForm = document.frmDati;
			if(strErrorString != ""){
				alert(strErrorString);
			}
			//impostazione delle propriet� di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			<%if(vctAccount.size() < 1){%>
				Disable(objForm.SELEZIONA);
			<%}%>
			for(i=1;i<=intNumRowClienti;i++){
				Disable(eval("objForm.txtImportoPitagora" + i));
			}
			
		}
		
		function copiaData(p_ObjCurrent)
		{
			var objFirstDataField = null;
			objFirstDataField = eval(objForm.txtDataEstrazione1);
			if(p_ObjCurrent !== objFirstDataField){
				p_ObjCurrent.value = strDateChanged;
			}
		}
		
		function setData(p_ObjCurrent)
		{
			if(p_ObjCurrent.value != ""){
				
				strDateChanged = p_ObjCurrent.value;
			}
		}
		
		function ONSELEZIONA()
		{
			objForm.action = "cbn4_acquis_imp_spesa_tld_2_cl.jsp";
            objForm.submit();
		}
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="cbn4_cal_par_sc_cl.jsp">
		<input type = "hidden" name = "hidViewState" value="vsCodiceTipoContratto=<%=lstrCodiceTipoContratto%>|vsDescTipoContratto=<%=lstrDescTipoContratto%>">
		<input type = "hidden" name = "hidPageAction" value="">
		<input type="hidden" name="hidTypeLoad" value="">
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
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Acquisizione degli importi di spesa complessiva da TLD per tipologia di contratto: <%=lstrDescTipoContratto%></td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <br>
		 <!-- tabella account -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Clienti Elaborati:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <!--CORPO CLIENTE-->
		 <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td class="text" align="center" width="80%">
					<!-- tabella dati -->
					<table>
						<tr>
							<td colspan="8" align="left">
								<table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
								  <tr>
								  	<td class="textB" align="left">
										Risultati per pag.:&nbsp;
										<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn4_acquis_imp_spesa_tld_cl.jsp')">
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
									
								  </tr>
								 </table>
							</td>
						</tr>
						<tr>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="4%">&nbsp;</td>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="16%">&nbsp;Account</td>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="16%">&nbsp;Mese<BR>&nbsp;Riferimento</td>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="16%">&nbsp;Anno<BR>&nbsp;Riferimento</td>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="16%">&nbsp;Importo Pitagora</td>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="16%">&nbsp;Data<BR>&nbsp;Elaborazione</td>
							<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="16%">&nbsp;Data<BR>&nbsp;Estrazione</td>
						</tr>
						<%if(vctAccount.size() == 0){%>
							<tr>
								<td  align="center" colspan="7" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" width="4%">Nessun Record da Elaborare!</td>
							</tr>
						<%}
						intRecTotali = vctAccount.size();
						%>
						<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
						 <%
						 for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++){	
							DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);
							 //verifica se il numero di riga � pari o dispari per la colorazione delle righe   
			                 if((i%2)==0){
			                   strBgColor=StaticContext.bgColorRigaPariTabella;
							 }else{
			                   strBgColor=StaticContext.bgColorRigaDispariTabella;
							 }
							   
							 lstrRdoClienteElabValue = Integer.toString(i+1);
							 lstrRdoClienteElabValue += "|" + lstrCodiceTipoContratto;
							 lstrRdoClienteElabValue += "|" + objDbAccount.getCODE_TEST_SPESA_COMPL();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getDATA_MM_RIF_SPESA_COMPL();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getDATA_AA_RIF_SPESA_COMPL();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getCODE_GEST();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getNOME_RAG_SOC_GEST();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getIMPT_SPESA_COMPL();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getIMPT_TOT_SPESA_COMPL();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getDATA_ORA_INIZIO_ELAB_BATCH();
							 lstrRdoClienteElabValue += "|" + objDbAccount.getDATA_ESTRAZIONE_IMPT();
							 if(i == ((pagerPageNumber.intValue()-1)*intRecXPag)){
							 	strChecked = "checked";
							 }else{
							 	strChecked = "";
							 }
							
							 %>
						<tr>																							
							<td bgcolor='<%=strBgColor%>' class='text' width="4%"><input <%=strChecked%> type="radio" name="rdoClienteElab" value="<%=lstrRdoClienteElabValue%>"></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%"><%=objDbAccount.getNOME_RAG_SOC_GEST()%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%"><%=DataFormat.getMeseInLettere(Integer.parseInt(objDbAccount.getDATA_MM_RIF_SPESA_COMPL()))%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%"><%=objDbAccount.getDATA_AA_RIF_SPESA_COMPL()%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%"><%=objDbAccount.getIMPT_SPESA_COMPL()%><input type="hidden" name="txtImportoPitagora<%=i+1%>" class="text" maxlength="20" value = "<%=objDbAccount.getIMPT_SPESA_COMPL()%>" size="20"></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%"><%=objDbAccount.getDATA_ORA_INIZIO_ELAB_BATCH()%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%"><%=objDbAccount.getDATA_ESTRAZIONE_IMPT()%></td>
						</tr>
						<%}%>
									<pg:index>
						<tr>
							<td colspan="7" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
				                <!--paginatore-->
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
							</td>
						</tr>
									</pg:index>
								</pg:pager>
            
					</table>
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
<script language="JavaScript">
var strIMPT_TOT_SPESA_COMPL = "<%=strIMPT_TOT_SPESA_COMPL%>";
</script>
</body>
</html>

