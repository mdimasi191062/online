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
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_cal_par_sc_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_ClassiSconto" type="com.ejbSTL.Ctr_ClassiScontoHome" location="Ctr_ClassiSconto" />
<EJB:useBean id="remoteCtr_ClassiSconto" type="com.ejbSTL.Ctr_ClassiSconto" scope="session">
    <EJB:createBean instance="<%=homeCtr_ClassiSconto.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ClassiSconto" type="com.ejbSTL.Ent_ClassiScontoHome" location="Ent_ClassiSconto" />
<EJB:useBean id="remoteEnt_ClassiSconto" type="com.ejbSTL.Ent_ClassiSconto" scope="session">
    <EJB:createBean instance="<%=homeEnt_ClassiSconto.create()%>" />
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
boolean blnParametriSalvati = false;
String strComboSize = "7";
String strViewState = "";
String strBgColor = "";
String strChecked = "";
String lstrCodiceTipoContratto = "";
String lstrDescTipoContratto = "";
String lstrRdoSelClienti = "";
String lstrRdoSelClientiValue = "";
String lstrAccountSelected = "";
String strAppo = "";
String lstrPageAction = "";
String lstrChkSelClassiValue = "";
String strIMPT_SPESA_COMPL = "";
String strCODE_GEST = "";
String lstr_Mese = "";
String lstr_Anno = "";

DB_Account lobjDbAccount = null;
Vector vctAccount = null;
Vector vctParamClassi = null;
Vector vctAccountSelected = new Vector();

if(request.getParameter("intAction") == null){
    intAction = StaticContext.LIST;
}else{
    intAction = Integer.parseInt(request.getParameter("intAction"));
}
if(request.getParameter("intFunzionalita") == null){
	intFunzionalita = StaticContext.FN_TARIFFA;
}else{
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
}
strViewState = Misc.nh(request.getParameter("hidViewState"));
if(strViewState.equals("")){
	lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
}else{
	lstrPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	lstrCodiceTipoContratto = Misc.getParameterValue(strViewState,"vsCodiceTipoContratto");
	lstrDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
}
//paginatore
int intRecXPag = 0;
int intRecTotali = 0;
if(request.getParameter("cboNumRecXPag")==null){
	intRecXPag=5;
}else{
	intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
}
String strtypeLoad = Misc.nh(request.getParameter("hidTypeLoad"));
String strSelected = "";
//fine paginatore
//valore della riga selezionata
lstrRdoSelClientiValue = Misc.nh(request.getParameter("rdoSelClienti"));

lstr_Mese = Misc.nh(request.getParameter("hidMese"));
lstr_Anno = Misc.nh(request.getParameter("hidAnno"));

//account selezionati per il calcolo
lstrAccountSelected = Misc.nh(request.getParameter("hidAccountSelected"));
if(!lstrAccountSelected.equals("")){
	//preparo il vettore da passare al metodo
	Vector vctCiclo = Misc.split(lstrAccountSelected , "|");
	for (i=0;i < vctCiclo.size();i++)
	{
        strAppo = (String)vctCiclo.elementAt(i);
		Vector vctAppoData = Misc.split(strAppo,"$");
		String strImporto = (String)vctAppoData.elementAt(0);
		String strCodeAccount = (String)vctAppoData.elementAt(1);
		DB_ClasseSconto objDbClasseSconto = new DB_ClasseSconto();
		objDbClasseSconto.setIMPT_MAX_SPESA(strImporto);
		objDbClasseSconto.setCODE_GEST(strCodeAccount);
		
		vctAccountSelected.addElement(objDbClasseSconto);
	}

	//carica la seconda lista
	if (strtypeLoad.equals("1")) //paginazione
	 {
		vctParamClassi = (Vector) session.getAttribute("vctParamClassi");
	 }
	 else //query
	 {
		vctParamClassi = remoteCtr_ClassiSconto.getClassiScontoCalPar(lstrCodiceTipoContratto,
	                                                    		  vctAccountSelected);
		if (vctParamClassi != null)
	  		session.setAttribute("vctParamClassi", vctParamClassi);
	 }														
	
}else if(!lstr_Mese.equalsIgnoreCase("")){ //CALCOLA TUTTI
  //carica la seconda lista
	if (strtypeLoad.equals("1")) //paginazione
	 {
		vctParamClassi = (Vector) session.getAttribute("vctParamClassi");
	 }
	 else //query
	 {
		vctParamClassi = remoteEnt_ClassiSconto.getClassiScontoCalParAll(lstr_Mese, lstr_Anno);
		if (vctParamClassi != null)
	  		session.setAttribute("vctParamClassi", vctParamClassi);
	 }														
}

if(lstrPageAction.equals("SALVA")){
	String strParameterToLog = Misc.buildParameterToLog(vctParamClassi);%>
	<% String strLogMessage = "remoteCtr_ClassiSconto.insParamClasSconto(" + strParameterToLog  + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3503,strLogMessage)%>
	</logtag:logData>
	<%String strReturn = remoteCtr_ClassiSconto.insParamClasSconto(vctParamClassi);
	if(strReturn.equals(""))
	{
		strLogMessage += " : Successo" ;
		blnParametriSalvati = true;
	}
	else
	{
		strLogMessage += " : " + strReturn ;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3503,strLogMessage)%>
	</logtag:logData>
<%}%>

<html>
<head>
	<title>Calcolo parametri classi di sconto</title>
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
		var blnParametriSalvati = <%=blnParametriSalvati%>;
		<%if(vctParamClassi != null){%>
			var intNumRowClassi = <%=vctParamClassi.size()%>;
		<%}else{%>
			var intNumRowClassi = 0;
		<%}%>
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle propriet� di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			Disable(objForm.SALVA);
			if(blnParametriSalvati){
				alert("Parametri Salvati Correttamente!");
				ONANNULLA();
			}
			
			if(intNumRowClassi > 0)
			{
				Enable(objForm.SALVA);
			}else{
				Disable(objForm.SALVA);
			}
		}
		
		function ONSALVA()
		{
			if(window.confirm("Procedere con il salvataggio?")){
				updVS(objForm.hidViewState,"vsPageAction","SALVA");
				objForm.action = "cbn4_cal_par_sc_2_cl.jsp";
				objForm.submit();
			}
		}
		
		function ONANNULLA()
		{
			objForm.action = "cbn4_cal_par_sc_cl.jsp";
			objForm.submit();
		}
		
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<input type = "hidden" name = "hidViewState" value="vsCodiceTipoContratto=<%=lstrCodiceTipoContratto%>|vsDescTipoContratto=<%=lstrDescTipoContratto%>">
		<input type = "hidden" name = "hidPageAction" value="">
		<input type = "hidden" name = "hidTypeLoad" value="">
		<input type = "hidden" name = "hidAccountSelected" value="<%=lstrAccountSelected%>">
    <input type = "hidden" name = "hidMese" value="<%=lstr_Mese%>">
    <input type = "hidden" name = "hidAnno" value="<%=lstr_Anno%>">
    
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
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Calcolo parametri classi di sconto per tipologia di contratto: <%=lstrDescTipoContratto%></td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <br>
		 <!-- tabella RIEPILOGO -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Parametri Classi di Sconto:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <!--CORPO RIEPILOGO-->
		 <table width="80%" border="0"  bordercolor="#ff00ff"cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<%if(vctParamClassi != null ){%>
			<tr>
				<!-- tabella dati -->
				<td class="text" align="center" width="80%">
					<table>
							<tr>
				                 <td colspan="7" class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
								 	Risultati per pag.:&nbsp;
									<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn4_cal_par_sc_2_cl.jsp');">
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
							<tr>
								<!--<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Cliente</td>-->
								<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Account</td>
								<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Mese<BR>&nbsp;Riferimento</td>
								<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Anno<BR>&nbsp;Riferimento</td>
								<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Codice Classe</td>
								<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Importo<BR>&nbsp;MIN classe<BR>&nbsp;di sconto</td>
								<td width="16%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Importo<BR>&nbsp;MAX classe<BR>&nbsp;di sconto</td>
							</tr>
							 <%
                             		intRecTotali = 	vctParamClassi.size();%>
							 <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                                 <%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++){	
                                    DB_ClasseSconto objDbClasseSconto = (DB_ClasseSconto)vctParamClassi.elementAt(i);
                                     //verifica se il numero di riga � pari o dispari per la colorazione delle righe   
                                     if ((i%2)==0){
                                       strBgColor=StaticContext.bgColorRigaPariTabella;
                                     }else{
                                       strBgColor=StaticContext.bgColorRigaDispariTabella;
                                      }
									 %>
                                <tr>
                                    <!--<td width="16%" bgcolor='<%=strBgColor%>' class='text' nowrap><%//=objDbClasseSconto.getNOME_RAG_SOC_GEST()%></td>-->
                                    <td width="16%" bgcolor='<%=strBgColor%>' class='text' nowrap><%=objDbClasseSconto.getDESC_ACCOUNT()%></td>
                                    <td width="16%" bgcolor='<%=strBgColor%>' class='text' nowrap><%=DataFormat.getMeseInLettere(Integer.parseInt(objDbClasseSconto.getDATA_MM_RIF_SPESA_COMPL()))%></td>
                                    <td width="16%" bgcolor='<%=strBgColor%>' class='text' nowrap><%=objDbClasseSconto.getDATA_AA_RIF_SPESA_COMPL()%></td>
                                    <td width="16%" bgcolor='<%=strBgColor%>' class='textNumber'><%=objDbClasseSconto.getCODE_CLAS_SCONTO()%></td>
                                    <td width="16%" bgcolor='<%=strBgColor%>' class='textNumber'><%=CustomNumberFormat.setToNumberFormat(objDbClasseSconto.getIMPT_MIN_SPESA())%></td>
                                    <td width="16%" bgcolor='<%=strBgColor%>' class='textNumber'><%=CustomNumberFormat.setToNumberFormat(objDbClasseSconto.getIMPT_MAX_SPESA())%></td>
                                </tr>
                                <%}%>
								
					</table>
					
				</td>
			</tr>
			<tr>
				<td colspan="7" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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


