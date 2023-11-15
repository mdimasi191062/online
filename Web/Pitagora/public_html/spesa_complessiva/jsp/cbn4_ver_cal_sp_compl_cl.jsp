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
<%=StaticMessages.getMessage(3006,"cbn4_ver_cal_sp_compl_cl.jsp")%>
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
boolean blnNoRecord = false;
String bgcolor = "";
String strAppo = "";
String strCodeElab = Misc.nh(request.getParameter("rdoElaborazioneBatch"));
String codiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));

String strTitle = "Verifica Batch Spesa Complessiva";
String strCodeFunz = StaticContext.RIBES_INFR_BATCH_CALCOLO_SPESA_COMPLESSIVA;
String strPageDestination = StaticContext.PH_SPESACOMPLESSIVA_JSP + "cbn4_ver_cal_sp_compl_2_cl.jsp";
String strImageTitle =StaticContext.PH_SPESACOMPLESSIVA_IMAGES;
String strNameFirstPage = "cbn4_ver_cal_sp_compl_cl.jsp";
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
String strtypeLoad = request.getParameter("hidTypeLoad");
String strSelected = "";
//fine paginatore
%>

<%
Vector vctBatch = null;
vctBatch = null;
// carico il vettore
vctBatch = remoteEnt_Batch.getElabBatchVerificaSpeCom(StaticContext.LIST,codiceTipoContratto,StaticContext.RIBES_INFR_BATCH_CALCOLO_SPESA_COMPLESSIVA);
intRecTotali = vctBatch.size();
if(intRecTotali == 0){
	blnNoRecord = true;
}
// se il vettore � stato caricato si prosegue con il caricamento della lista%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	<%=strTitle%>
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
	var blnNoRecord = <%=blnNoRecord%>;
	function Initialize()
	{
		objForm = document.frmDati;
		//inizializzazione attributi campi per la validazione
		if(blnNoRecord){
			Disable(objForm.SELEZIONA);
		}
		if(objForm.rdoElaborazioneBatch != null)
		{
			if(objForm.rdoElaborazioneBatch.length != null){
				objForm.rdoElaborazioneBatch[0].checked = true;
			}else{
				objForm.rdoElaborazioneBatch.checked = true;
			}
		}
	}
	
	function ONAGGIORNA(){
		reloadPage('0','<%=strNameFirstPage%>');
	}
	
	function ONSELEZIONA()
	{
		objForm.action = '<%=strPageDestination%>';
	  	objForm.submit();
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
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strTitle%>: <%=request.getParameter("hidDescTipoContratto")%></td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dati Elaborazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<!-- tabella risultati -->
<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td colspan="6">
			<table >
				<tr>
					<td class="textB" align="right">Risultati per pag.:&nbsp;</td>
					<td  class="text">
					  <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>');">
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
		<td width='100%'>
			<table width="95%" cellspacing="1" align="center">
				<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
					<td width="4%" height="20" class="textB">&nbsp;</td>
					<td width="8%" height="20" class="textB" align="center">Codice</td>
					<td width="26%" height="20" class="textB">&nbsp;Data/Ora<BR>&nbsp;Inizio Elaborazione</td>
					<td width="26%" height="20" class="textB">&nbsp;Data/Ora<BR>&nbsp;Fine Elaborazione</td>
					<td width="36%" height="20" class="textB">&nbsp;Stato</td>
				</tr>
					<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
					
					<%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++)	
				       {
							DB_Batch lobj_Batch = new DB_Batch();
							lobj_Batch = (DB_Batch)vctBatch.elementAt(i);
							//cambia il colore delle righe
							if ((i%2)==0)
			               		bgcolor=StaticContext.bgColorRigaPariTabella;
			              	else
			               		bgcolor=StaticContext.bgColorRigaDispariTabella;
								
                            if(strCodeElab.equals("")){
								if (i==0){
                                    strChecked = "checked";
                                    strCodeElab=lobj_Batch.getCODE_ELAB();
                                }else{
                                    strChecked = "";
                                }
                            }else{
                                if(strCodeElab.equals(lobj_Batch.getCODE_ELAB())){
                                    strChecked = "checked";
                                }else{
                                    strChecked = "";
                                }
							}
							
							%>
							<tr bgcolor="<%=bgcolor%>">
								<td width="4%" height="20" class="textB">
									<%
										strAppo = "parCodeElab=" + Misc.nh(lobj_Batch.getCODE_ELAB());
										strAppo += "|parDataOraInizioElabBatch=" + Misc.nh(lobj_Batch.getDATA_ORA_INIZIO_ELAB_BATCH());
										strAppo += "|parDataOraFineElabBatch=" + Misc.nh(lobj_Batch.getDATA_ORA_FINE_ELAB_BATCH());
										strAppo += "|parDescStatoBatch=" + Misc.nh(lobj_Batch.getDESC_STATO_BATCH());
                    /* Mimmo Simeone - 28/03/2003 - Modifica per abilitare-disabilitare bottoni su pagine "verifica" */
                    strAppo += "|parCodeStatoBatch=" + Misc.nh(lobj_Batch.getCODE_STATO_BATCH());
                    /* Mimmo Simeone - 28/03/2003 - FINE */
									%>
									<input <%=strChecked%> type="radio" name="rdoElaborazioneBatch" value="<%=strAppo%>" onClick="click_rdoElaborazioneBatch();">
								</td>
								<td width="8%" height="20" class="textNumber" align="center"><%=lobj_Batch.getCODE_ELAB()%></td>
								<td width="26%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_Batch.getDATA_ORA_INIZIO_ELAB_BATCH())%></td>
								<td width="26%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_Batch.getDATA_ORA_FINE_ELAB_BATCH())%></td>
								<td width="36%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_Batch.getDESC_STATO_BATCH())%></td>
                
							</tr>
<%						}%>
							<%if(intRecTotali == 0){%>
								<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
									<td colspan="5" width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
								</tr>
							<%}%>
							<tr>
								<td colspan="6" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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
		<td width='100%' colspan='3'>&nbsp;</td>
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
