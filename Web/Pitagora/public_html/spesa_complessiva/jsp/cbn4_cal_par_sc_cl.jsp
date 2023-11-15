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

<EJB:useHome id="homeCtr_Contratti" type="com.ejbSTL.Ctr_ContrattiHome" location="Ctr_Contratti" />
<EJB:useBean id="remoteCtr_Contratti" type="com.ejbSTL.Ctr_Contratti" scope="session">
    <EJB:createBean instance="<%=homeCtr_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_ClassiSconto" type="com.ejbSTL.Ctr_ClassiScontoHome" location="Ctr_ClassiSconto" />
<EJB:useBean id="remoteCtr_ClassiSconto" type="com.ejbSTL.Ctr_ClassiSconto" scope="session">
    <EJB:createBean instance="<%=homeCtr_ClassiSconto.create()%>" />
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
String strStringaPerCalcolaTutti = "";
String strIMPT_TOT_SPESA_COMPL = "";
String strCODE_ACCOUNT = "";
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
//account selezionati per il calcolo
lstrAccountSelected = Misc.nh(request.getParameter("hidAccountSelected"));
//carica la prima lista
if (strtypeLoad.equals("1")) //paginazione
 {
	vctAccount = (Vector) session.getAttribute("vctAccount");
 }
 else //query
 {
	/*vctAccount = remoteEnt_Contratti.getAccountSpeComCalPar(intAction,
                                            			lstrCodiceTipoContratto,
                                            			"");*/
	vctAccount = remoteCtr_Contratti.getAccountXCalcoloParametriClassiSconto();
	if (vctAccount != null)
  		session.setAttribute("vctAccount", vctAccount);
 }
 //carico una stringa per il calcola tutti
 for(i = 0;i < vctAccount.size();i++){	
	DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);
	if(strStringaPerCalcolaTutti.equals("")){
		strStringaPerCalcolaTutti = objDbAccount.getIMPT_TOT_SPESA_COMPL() + "$" + objDbAccount.getCODE_GEST();//importo + GEST
	}else{
		strStringaPerCalcolaTutti += "|" + objDbAccount.getIMPT_TOT_SPESA_COMPL() + "$" + objDbAccount.getCODE_GEST();//importo + GEST
	}
}
%>
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
		var intNumRowClienti = <%=vctAccount.size()%>;
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle propriet� di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			if(intNumRowClienti > 0)
			{
				Enable(objForm.CALCOLA_SEL);
				Enable(objForm.CALCOLA_TUTTI);
			}else{
				Disable(objForm.CALCOLA_SEL);
				Disable(objForm.CALCOLA_TUTTI);
			}
			
		}
		
		function ONCALCOLA_SEL()
		{
			var strValue = getRadioButtonValue(objForm.rdoSelClienti);
			objForm.hidAccountSelected.value = strValue.split("|")[1] + "$" + strValue.split("|")[2];//importo + account
			objForm.action = "cbn4_cal_par_sc_2_cl.jsp";
			objForm.submit();
		}
		
		function ONCALCOLA_TUTTI()
		{
			//preparaValoriDaCalcolare(objForm.hidAccountSelected,objForm.rdoSelClienti);
			//objForm.hidAccountSelected.value = objForm.hidStringaPerCalcolaTutti.value;
      objForm.hidAccountSelected.value = "";
			objForm.action = "cbn4_cal_par_sc_2_cl.jsp";
			objForm.submit();
		}
		
		/*function preparaValoriDaCalcolare(p_objField,p_objRadio)
		{
			var strTemp = "";
			
			//un solo radio
			if(p_objRadio.length==null)
			{
				var strTemp = getRadioButtonValue(objForm.rdoSelClienti);
				objForm.hidAccountSelected.value = strTemp.split("|")[1] + "$" + strTemp.split("|")[2];//importo + account
			}
			else
			{
				//piu di un radio
				for(i=0;i < p_objRadio.length;i++)
				{
					var strTemp = p_objRadio[i].value;
					if(objForm.hidAccountSelected.value == ""){
						objForm.hidAccountSelected.value = strTemp.split("|")[1] + "$" + strTemp.split("|")[2];//importo + account
					}else{
						objForm.hidAccountSelected.value += "|" + strTemp.split("|")[1] + "$" + strTemp.split("|")[2];//importo + account
					}
				}
			}
		}*/
		
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="cbn4_cal_par_sc_cl.jsp">
		<input type = "hidden" name = "hidViewState" value="vsCodiceTipoContratto=<%=lstrCodiceTipoContratto%>|vsDescTipoContratto=<%=lstrDescTipoContratto%>">
		<input type = "hidden" name = "hidPageAction" value="">
		<input type = "hidden" name = "hidAccountSelected" value = "">
		<input type = "hidden" name = "hidTypeLoad" value="">
		<input type = "hidden" name = "hidStringaPerCalcolaTutti" value="<%=strStringaPerCalcolaTutti%>">
    
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
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Calcolo parametri classi di sconto:</td>
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
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Clienti:</td>
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
			                 <td colspan="7" class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
							 	Risultati per pag.:&nbsp;
								<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn4_cal_par_sc_cl.jsp');">
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
							<td width="4%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;</td>
							<td width="15%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Cliente</td>
							<td width="13%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Mese<BR>&nbsp;Riferimento</td>
							<td width="13%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Anno<BR>&nbsp;Riferimento</td>
							<td width="14%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Importo<BR>&nbsp;di Spesa<BR>&nbsp;Complessiva<BR>&nbsp;di T.I.</td>
							<td width="13%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Data<BR>&nbsp;Estrazione</td>
							<td width="13%" bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;Data<BR>&nbsp;Ricezione<BR>&nbsp;da TLD</td>
						</tr>
						<%intRecTotali = vctAccount.size();%>
						<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
						 <%
						 for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++){	
							DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);
							 //verifica se il numero di riga � pari o dispari per la colorazione delle righe   
			                 if ((i%2)==0)
			                   	strBgColor=StaticContext.bgColorRigaPariTabella;
			                 else
			                   	strBgColor=StaticContext.bgColorRigaDispariTabella;
							  
							 lstrRdoSelClienti = lstrCodiceTipoContratto;
							 lstrRdoSelClienti += "|" + objDbAccount.getIMPT_TOT_SPESA_COMPL();
							 lstrRdoSelClienti += "|" + objDbAccount.getCODE_GEST(); 
							   
							 if(i == ((pagerPageNumber.intValue()-1)*intRecXPag)){
							 	strChecked = "checked";
							 }else{
							 	strChecked = "";
							 }

              //salvataggi mese e anno:
              lstr_Mese = objDbAccount.getDATA_MM_RIF_SPESA_COMPL();
              lstr_Anno = objDbAccount.getDATA_AA_RIF_SPESA_COMPL();               
							 %>
						<tr>
							<td width="4%" bgcolor='<%=strBgColor%>' class='text' nowrap><input <%=strChecked%> type="radio" name="rdoSelClienti" value="<%=lstrRdoSelClienti%>"></td>
							<td width="15%" bgcolor='<%=strBgColor%>' class='text' nowrap><%=objDbAccount.getNOME_RAG_SOC_GEST()%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%" nowrap><%=DataFormat.getMeseInLettere(Integer.parseInt(objDbAccount.getDATA_MM_RIF_SPESA_COMPL()))%></td>
							<td bgcolor='<%=strBgColor%>' class='textNumber' width="16%" nowrap><%=objDbAccount.getDATA_AA_RIF_SPESA_COMPL()%></td>
							<td bgcolor='<%=strBgColor%>' class='textNumber' width="16%" nowrap><%=CustomNumberFormat.setToNumberFormat(objDbAccount.getIMPT_TOT_SPESA_COMPL())%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%" nowrap><%=objDbAccount.getDATA_ESTRAZIONE_IMPT()%></td>
							<td bgcolor='<%=strBgColor%>' class='text' width="16%" nowrap><%=objDbAccount.getDATA_RICEZ_TOT_SPESA()%></td>
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


    <input type = "hidden" name = "hidMese" value="<%=lstr_Mese%>">
    <input type = "hidden" name = "hidAnno" value="<%=lstr_Anno%>">
  
	</form>
</body>
</html>

