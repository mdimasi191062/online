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
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_ver_cal_sp_compl_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
//dichiarazioni delle variabili
int intAction;
int intFunzionalita;
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
int i=0;
String bgcolor = "";
//da vrificare
String strElaborazioneBatch = Misc.nh(request.getParameter("rdoElaborazioneBatch"));
String strCodeElab = Misc.getParameterValue(strElaborazioneBatch,"parCodeElab");
String strDataOraInizioElabBatch = Misc.getParameterValue(strElaborazioneBatch,"parDataOraInizioElabBatch");
String strDataOraFineElabBatch = Misc.getParameterValue(strElaborazioneBatch,"parDataOraFineElabBatch");
String strDescStatoBatch = Misc.getParameterValue(strElaborazioneBatch,"parDescStatoBatch");
String strValoNrPsElab = Misc.getParameterValue(strElaborazioneBatch,"parValoNrPsElab");
/* Mimmo Simeone - 28/03/2003 - Modifica per abilitare-disabilitare bottoni su pagine "verifica" */
String strCodeStatoBatch = Misc.getParameterValue(strElaborazioneBatch,"parCodeStatoBatch");
/* Mimmo Simeone - 28/03/2003 - FINE */
//fine da vrificare
String codiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
String lstrCodeAccount="";
String strChecked = "";
String strChecked2 = "";
String strErroreBloccante = "";

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
//String strAccoundDaElaborare = "";
//fine paginatore
%>

<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	Verifica Calcolo Spesa Complessiva
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
	var objForm = null;
	function Initialize()
	{
		objForm = document.frmDati;
		//inizializzazione attributi campi per la validazione
		setDefaultProp(objForm);
		Disable(objForm.txtMeseRiferimento);
		Disable(objForm.txtAnnoRiferimento);
    	checkErroreBloccante(objForm.rdoAccountElaborati);
	}
	
	function checkErroreBloccante(p_objRadio)
	{
		var blnBloccanteTutti = false;
		var blnBloccante = false;
		var blnScarti = false;
		var strRadioAccElab;
		var arrRadioAccElab;
		var strErrBlocc;
		var strScarti;
		if(p_objRadio!=null){
			if(p_objRadio.length==null){
				//un solo radio
				strRadioAccElab = getRadioButtonValue(p_objRadio);
				arrRadioAccElab = strRadioAccElab.split("|");
				strErrBlocc = arrRadioAccElab[2];
				strScarti =  arrRadioAccElab[3];
				if (strErrBlocc=="S"){
					blnBloccanteTutti = true;
					blnBloccante = true;
				}
	
				if (strScarti=="0"){
					blnScarti = true;
				}
			}
			else{
				//piu di un radio
				for(i=0;i < p_objRadio.length;i++){
					strRadioAccElab = p_objRadio[i].value;
					arrRadioAccElab = strRadioAccElab.split("|");
					strErrBlocc = arrRadioAccElab[2];
					strScarti = arrRadioAccElab[3];
					if (strErrBlocc=="S"){
						blnBloccanteTutti = true;
					}
					if (i==0){
						if (strErrBlocc=="S"){
							blnBloccante = true;
						}
						if (strScarti=="0"){
							blnScarti = true;
						}
					}
				}
			}
		}else{
			//disabilita tutto se non c'� nessun Account!
			blnBloccante=true;
			blnBloccanteTutti=true;
			blnScarti=true;
		}
		 if (blnBloccante) {
			Disable(objForm.CONGELA_SEL);
		 }else{
			Enable(objForm.CONGELA_SEL);
		 }
		 if (blnBloccanteTutti) {
			Disable(objForm.CONGELA_TUTTI);
		 }else{
			Enable(objForm.CONGELA_TUTTI);
		 }
     /* Mimmo Simeone - 28/03/2003 - Modifica per abilitare-disabilitare bottoni su pagine "verifica" */
     if ("<%=strCodeStatoBatch%>" != "SUCC") {
     Disable(objForm.CONGELA_TUTTI);
     Disable(objForm.CONGELA_SEL);
     }
     /* Mimmo Simeone - 28/03/2003 - FINE */
		 if (blnScarti) {
			Disable(objForm.VISUALIZZA_SCARTI);
		 }else{
			Enable(objForm.VISUALIZZA_SCARTI);
		 }
	}

	//GESTIONE PULSANTI
	

	function preparePageFields()
	{
		var strCodeAccount = "";		
		var strCodeTestSpesaCompl = ""; 
		var strAppo = "";
		var i = 0;
		if(objForm.rdoAccountElaborati.length==null){
			strCodeAccount = getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[0];
			strCodeTestSpesaCompl = getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[5];
			objForm.hidViewState.value = strCodeAccount + "|" + strCodeTestSpesaCompl;
		}else{
			for(i=0;i<objForm.rdoAccountElaborati.length;i++){
				strCodeAccount = objForm.rdoAccountElaborati[i].value.split("|")[0];
				strCodeTestSpesaCompl = objForm.rdoAccountElaborati[i].value.split("|")[5];
				if(strAppo != ""){
					strAppo +=  "$" + strCodeAccount + "|" + strCodeTestSpesaCompl;;
				}else{
					strAppo += strCodeAccount + "|" + strCodeTestSpesaCompl;
				}
			}
		}
		objForm.hidViewState.value = strAppo;
	}
	
	function ONCONGELA_TUTTI(){
		if(window.confirm("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3112")%>")){
			var strURL="<%=StaticContext.PH_SPESACOMPLESSIVA_JSP%>cbn4_ver_cal_sp_compl_3_cl.jsp";
			objForm.hidViewState.value = "M";
			objForm.action=strURL
			objForm.submit();
		}
	}
	
	function ONCONGELA_SEL(){
		if(window.confirm("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3112")%>")){
			var strCodeAccount = getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[0];
			var strCodeTestSpesaCompl = getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[5];
			var strURL="<%=StaticContext.PH_SPESACOMPLESSIVA_JSP%>cbn4_ver_cal_sp_compl_3_cl.jsp";
			objForm.hidViewState.value = "S";
			objForm.hidElementIndex.value = getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[6];
			objForm.action=strURL
			objForm.submit();
		}
	}

	function ONVISUALIZZA_SCARTI(){
		var strURL="<%=StaticContext.PH_SPESACOMPLESSIVA_JSP%>cbn4_vis_sca_cal_sp_comp_cl.jsp";
		strURL+="?hidCodeAccountPerScarti="+getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[0].split("$")[0];
		strURL+="&hidDescAccount="+getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[4];
		strURL+="&codiceTipoContratto=<%=codiceTipoContratto%>";
		strURL+="&hidCodeFunz=";
		strURL+="&hidCodeTestSpesaCompl="+getRadioButtonValue(objForm.rdoAccountElaborati).split("|")[5];
		strURL+="&intAction=<%=intAction%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
    strURL+="&CodeElab=<%=strCodeElab%>";
		openDialog(strURL, 569, 400);
	}
	
	
	function click_rdoAccountElaborati(){
		var strAccountElaborati = getRadioButtonValue(objForm.rdoAccountElaborati);
		var arrAccountElaborati = strAccountElaborati.split("|");
		var strCodeAccount = arrAccountElaborati[0];
		var strErrBlocc = arrAccountElaborati[2];
		var strScarti =  arrAccountElaborati[3];
		if (strErrBlocc=="S"){
			Disable(objForm.CONGELA_SEL);
		}else{
			Enable(objForm.CONGELA_SEL);
		}
		if (strScarti=="0"){
			Disable(objForm.VISUALIZZA_SCARTI);
		}else{
			Enable(objForm.VISUALIZZA_SCARTI);
		}
	}
	
	
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
<input type="hidden" name="codiceTipoContratto" value="<%=codiceTipoContratto%>">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidViewState" value="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="hidElementIndex" value="">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
<input type="hidden" name="rdoElaborazioneBatch" value="<%=strElaborazioneBatch%>">
<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_SPESACOMPLESSIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Verifica calcolo spesa complessiva: <%=request.getParameter("hidDescTipoContratto")%></td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<!-- tabella riepilogo -->
<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width='100%'>
			<table width="90%" cellspacing="1" align="center">
				<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
					<td width="8%" height="20" class="textB" align="center">Codice</td>
					<td width="26%" height="20" class="textB">&nbsp;Data/Ora<BR>&nbsp;Inizio Elaboraz.</td>
					<td width="26%" height="20" class="textB">&nbsp;Data/Ora<BR>&nbsp;Fine Elaboraz.</td>
					<td width="30%" height="20" class="textB">&nbsp;Stato</td>
				</tr>
				<%bgcolor=StaticContext.bgColorRigaDispariTabella;%>
				<tr bgcolor="<%=bgcolor%>">
					<td width="8%" height="20" class="textNumber" align="center">&nbsp;<%=strCodeElab%></td>
					<td width="26%" height="20" class="text">&nbsp;<%=strDataOraInizioElabBatch%></td>
					<td width="26%" height="20" class="text">&nbsp;<%=strDataOraFineElabBatch%></td>
					<td width="30%" height="20" class="text" nowrap>&nbsp;<%=strDescStatoBatch%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lista Account Elaborati</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<!-- tabella risultati -->
<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<%
	Vector vctAccountElaborati = null;
	DB_Account lobj_AppoAccountElaborati = new DB_Account();
	// carico il vettore
	  int typeLoad=0;
	  if (!strtypeLoad.equals(""))
	  {
	    Integer tmptypeLoad=new Integer(strtypeLoad);
	    typeLoad=tmptypeLoad.intValue();
	  }
	  if (typeLoad!=0)
	    vctAccountElaborati = (Vector) session.getAttribute("vctAccountElaborati");
	  else
	  {
	    vctAccountElaborati = remoteEnt_Contratti.getAccountVerificaSpeCom(StaticContext.LIST,codiceTipoContratto,strCodeElab);
	    if (vctAccountElaborati!=null)
	      session.setAttribute("vctAccountElaborati", vctAccountElaborati);
	  }
	
	intRecTotali = vctAccountElaborati.size();
	if(vctAccountElaborati.size()>0){
		lobj_AppoAccountElaborati = (DB_Account)vctAccountElaborati.elementAt(0);
	}
	%>
	<tr>
		<td width='100%'  colspan='3'>
			<table>
				<tr>
                     <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                     <td  class="text">
                       <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn4_ver_cal_sp_compl_2_cl.jsp');">
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
		<td width='100%' colspan='3'>
			<table width="100%" border="0">
				<tr>
					<td class="textB" width="25%" align="right">Mese di Riferimento&nbsp;</td>
					<td class="text" width="25%" align="left"><input type="text" name="txtMeseRiferimento" class="text" maxlength="10" value = "<%=lobj_AppoAccountElaborati.getDATA_MM_RIF_SPESA_COMPL()%>" size="20"></td>
					<td class="textB" width="25%" align="right">Anno di Riferimento&nbsp;</td>
					<td class="text" width="25%" align="left"><input type="text" name="txtAnnoRiferimento" class="text" maxlength="10" value = "<%=lobj_AppoAccountElaborati.getDATA_AA_RIF_SPESA_COMPL()%>" size="20"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width='100%' colspan='3'>
			<table width="95%" cellspacing="1" align="center">
				<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
					<td width="4%" height="20" class="textB">&nbsp;</td>
					<td width="36%" height="20" class="textB">&nbsp;Cliente</td>
					<td width="18%" height="20" class="textB">&nbsp;Data Fine<BR>&nbsp;periodo comp.</td>
					<td width="18%" height="20" class="textB">&nbsp;Importo</td>
					<td width="14%" height="20" class="textB">&nbsp;Nr.P/S<br>&nbsp;processati</td>
					<td width="10%" height="20" class="textB" nowrap>&nbsp;Scarti NB</td>
					<td width="10%" height="20" class="textB">&nbsp;Errore<BR>&nbsp;bloccante</td>
				</tr>
				<%
						// se il vettore � stato caricato si prosegue con il caricamento della lista%>
					<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
					
						<%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++)	
					       {
								DB_Account lobj_AccountElaborati = new DB_Account();
								lobj_AccountElaborati = (DB_Account)vctAccountElaborati.elementAt(i);
								//cambia il colore delle righe
								if ((i%2)==0)
				                  bgcolor=StaticContext.bgColorRigaPariTabella;
								        else
				                  bgcolor=StaticContext.bgColorRigaDispariTabella;

                                if (i == ((pagerPageNumber.intValue()-1)*intRecXPag)){
                                    strChecked = "checked";
                                }else{
                                    strChecked = "";
                                }
								%>
								<tr bgcolor="<%=bgcolor%>">
									<td width="4%" height="20" class="text">
										<input  <%=strChecked%> type="radio" name="rdoAccountElaborati" onClick="click_rdoAccountElaborati();" value="<%=lobj_AccountElaborati.getCODE_ACCOUNT()%>|<%=lobj_AccountElaborati.getCODE_PARAM()%>|<%if(Misc.nh(lobj_AccountElaborati.getTIPO_FLAG_ERR_BLOCC()).equals("")){out.print("N");}else{out.print("S");}%>|<%if(Misc.nh(lobj_AccountElaborati.getSCARTI()).equals("")){out.print("0");}else{out.print(Misc.nh(lobj_AccountElaborati.getSCARTI()));}%>|<%=lobj_AccountElaborati.getNOME_RAG_SOC_GEST()%>|<%=lobj_AccountElaborati.getCODE_TEST_SPESA_COMPL()%>|<%=i%>">
									</td>
									<td width="36%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_AccountElaborati.getNOME_RAG_SOC_GEST())%></td>
									<td width="18%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_AccountElaborati.getDATA_FINE_PERIODO_COMPTZ())%></td>
									<td width="18%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_AccountElaborati.getIMPT_SPESA_COMPL())%></td>
									<td width="14%" height="20" class="textNumber"><%=Misc.nh(lobj_AccountElaborati.getVALO_NR_PS_ELAB())%>&nbsp;</td>
									<td width="10%" height="20" class="text" align="center">&nbsp;<%if(Misc.nh(lobj_AccountElaborati.getSCARTI()).equals("")){out.print("0");}else{out.print(Misc.nh(lobj_AccountElaborati.getSCARTI()));}%></td>
									<td width="10%" height="20" class="text" align="center">&nbsp;<%if(Misc.nh(lobj_AccountElaborati.getTIPO_FLAG_ERR_BLOCC()).equals("")){out.print("N");}else{out.print("S");}%></td>
								</tr>
					<%}%>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!--PULSANTIERA-->
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	    <tr>
    		<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    	</tr>
		<tr>
        	<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
				<sec:ShowButtons td_class="textB"/>
        	</td>
      	</tr>
    </table> 
</form>

</BODY>
</HTML>