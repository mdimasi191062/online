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
<%@ page import="com.usr.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"verifica_tld_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessivaHome" location="Ent_SpesaComplessiva" />
<EJB:useBean id="remoteEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessiva" scope="session">
    <EJB:createBean instance="<%=homeEnt_SpesaComplessiva.create()%>" />
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

int i=0;
String bgcolor = "";
String strAppo = "";
String strElaborazioneBatch = Misc.nh(request.getParameter("rdoElaborazioneBatch"));
String strCodeElab = Misc.getParameterValue(strElaborazioneBatch,"parCodeElab");
String codiceTipoContratto = "";
//modifica richiesta in quanto non viene più passato il codice del tipo di contratto nè la sua descrizione
//String codiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
//String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
String strFunz = Misc.nh(request.getParameter("hidFunz"));
String lstrCodeAccount="";
String strChecked = "";
String strChecked2 = "";
String strErroreBloccante = "";
String strDataInizioCiclo = "";
String strDataFineCiclo = "";
String strTitle = "";
String strCodeFunz = "";
String strNameFirstPage = "verifica_tld_cl.jsp";
//String strPageDestination = "";
String strImageTitle = "";

		strTitle = "Verifica Batch Automatico Acquisizioni Importi da TLD";
		strCodeFunz = StaticContext.RIBES_AUTOMATISMO_TLD;
//		strPageDestination = StaticContext.PH_NOTEDICREDITO_JSP + "verifica_tld_2_cl.jsp";
		strImageTitle =StaticContext.PH_SPESACOMPLESSIVA_IMAGES;
%>

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
	var blnNoRecord = false;
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
	
	/*function ONSELEZIONA()
	{
		objForm.action = '<%//=strPageDestination%>';
	  	objForm.submit();
	}*/
	function ONVISUALIZZA_SCARTI(){
		
		var strURL="<%=StaticContext.PH_SPESACOMPLESSIVA_JSP%>visualizza_scarti_tld_cl.jsp";
		strURL+="?codiceTipoContratto=<%=codiceTipoContratto%>";
		strURL+="&hidCodeFunz=<%=StaticContext.RIBES_AUTOMATISMO_TLD%>";
		strURL+="&intAction=<%=intAction%>";
		strURL+="&intFunzionalita=<%=intFunzionalita%>";
		
		openDialog(strURL, 569, 400);
	}
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
<input type="hidden" name="codiceTipoContratto" value="">
<input type = "hidden" name = "intAction" value="<%=intAction%>">
<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
<input type = "hidden" name = "hidViewState" value="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="hidDescTipoContratto" value="">

<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=strImageTitle%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strTitle%></td>
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
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width='100%'>
			<table width="90%" cellspacing="1" align="center">
				<%
					Vector vctBatch = null;
					vctBatch = null;
					// carico il vettore
					  int typeLoad=0;
					  if (strtypeLoad!=null)
					  {
					    Integer tmptypeLoad=new Integer(strtypeLoad);
					    typeLoad=tmptypeLoad.intValue();
					  }
					  if (typeLoad!=0)
					    vctBatch = (Vector) session.getAttribute("vctBatch");
					  else
					  {
					    vctBatch = remoteEnt_SpesaComplessiva.GetElabBatchVerificaxTLD(strCodeFunz,
                                                                    codiceTipoContratto);
					    if (vctBatch!=null)
					      session.setAttribute("vctBatch", vctBatch);
					  }
					intRecTotali = vctBatch.size();
				if(vctBatch.size()!=0){%>
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
					<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
						<td width="4%" height="20" class="textB">&nbsp;</td>
						<td width="8%" height="20" class="textB" align="center">Codice</td>
						<td width="26%" height="20" class="textB">&nbsp;Data/Ora<BR>&nbsp;Inizio Elaboraz.</td>
						<td width="26%" height="20" class="textB">&nbsp;Data/Ora<BR>&nbsp;Fine Elaboraz.</td>
						<td width="30%" height="20" class="textB">&nbsp;Stato</td>
						<td width="6%" height="20" class="textB">&nbsp;Nr. <BR>&nbsp;Scarti</td>
					</tr>
				<%}else{%>
					<SCRIPT LANGUAGE="JavaScript">
							 blnNoRecord = true;
					</SCRIPT>
					<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
						<td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
					</tr>
				<%}%>
					<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
					
				      <%
					   // se il vettore è stato caricato si prosegue con il caricamento della lista	
					   for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++)	
				       {
							DB_Batch lobj_Batch = new DB_Batch();
							lobj_Batch = (DB_Batch)vctBatch.elementAt(i);
							//cambia il colore delle righe
							if ((i%2)==0)
			               		bgcolor=StaticContext.bgColorRigaPariTabella;
			              	else
			               		bgcolor=StaticContext.bgColorRigaDispariTabella;
								
                            /*if(strCodeElab.equals("")){
								if (i == ((pagerPageNumber.intValue()-1)*intRecXPag)){
                                    strChecked = "checked";
                                    strCodeElab = lobj_Batch.getCODE_ELAB();
                                }else{
                                    strChecked = "";
                                }
                            }else{
                                if(strCodeElab.equals(lobj_Batch.getCODE_ELAB())){
                                    strChecked = "checked";
                                }else{
                                    strChecked = "";
                                }
							}*/
							
							%>
							<tr bgcolor="<%=bgcolor%>">
								<td width="4%" height="20" class="textB">
									<%
										strAppo = "parCodeElab=" + Misc.nh(lobj_Batch.getCODE_ELAB());
										strAppo += "|parDataOraInizioElabBatch=" + Misc.nh(lobj_Batch.getDATA_ORA_INIZIO_ELAB_BATCH());
										strAppo += "|parDataOraFineElabBatch=" + Misc.nh(lobj_Batch.getDATA_ORA_FINE_ELAB_BATCH());
										strAppo += "|parDescStatoBatch=" + Misc.nh(lobj_Batch.getDESC_STATO_BATCH());
										strAppo += "|parValoNrPsElab=" + Misc.nh(lobj_Batch.getVALO_NR_PS_ELAB());
                    /* Mimmo Simeone - 28/03/2003 - Modifica per abilitare-disabilitare bottoni su pagine "verifica" */
                    strAppo += "|parCodeStatoBatch=" + Misc.nh(lobj_Batch.getCODE_STATO_BATCH());
                    /* Mimmo Simeone - 28/03/2003 - FINE */
									%>
									<input <%=strChecked%> type="radio" name="rdoElaborazioneBatch" value="<%=strAppo%>">
								</td>
								<td width="8%" height="20" class="textNumber" align="center"><%=lobj_Batch.getCODE_ELAB()%></td>
								<td width="26%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_Batch.getDATA_ORA_INIZIO_ELAB_BATCH())%></td>
								<td width="26%" height="20" class="text">&nbsp;<%=Misc.nh(lobj_Batch.getDATA_ORA_FINE_ELAB_BATCH())%></td>
								<td width="30%" height="20" class="text" nowrap>&nbsp;<%=Misc.nh(lobj_Batch.getDESC_STATO_BATCH())%></td>
								<td width="6%" height="20" class="textNumber" align="center"><%=Misc.nh(lobj_Batch.getVALO_NR_PS_ELAB())%></td>
							</tr>
<%						}%>
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

</BODY>
</HTML>
