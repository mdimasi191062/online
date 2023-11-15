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
<%@ page import="com.usr.*"%>
<!-- inclusione della tagLib che permette l'instanziazione dell'oggetto remoto  -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_dett_rib_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto per i Tipi di Tariffe-->
<EJB:useHome id="homeEnt_Tariffe" type="com.ejbSTL.Ent_TariffeHome" location="Ent_Tariffe" />
<EJB:useBean id="remoteEnt_Tariffe" type="com.ejbSTL.Ent_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_Tariffe.create()%>" />
</EJB:useBean>
<% 
	//dichiarazione variabili
	Vector vctDettaglioTariffe = null;
	String strCodeGestOr = "";
	String strCodeGestDest = "";
	String strCodeContrOr = "";
	String strCodeContrDest = "";
	String strCodePsOr = "";
	String strCodePrestAggOr = "";
	String strCodeOggFatrzOr = "";
	String strDescClienteOrigine = "";
	String strDescContrattoOrigine = "";
	String strDescClienteDestinazione = "";
	String strDescContrattoDestinazione = "";
	String strGlobalCodeOggFatrz = "";
	String strSelected = "";
	String strBgColor = "";
	String strtypeLoad = "";
	int i = 0;
    int intAction;
    int intFunzionalita;
	int intRecXPag = 0;
	//reperimento dei parametri provenienti dalla pagina precedente
    intAction = Integer.parseInt(request.getParameter("intAction"));
    intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	strCodeGestOr = request.getParameter("hidCodeClienteOr");
	strCodeGestDest = request.getParameter("hidCodeClienteDest");
	strCodeContrOr = request.getParameter("cboContrattoOr");
	strCodeContrDest = request.getParameter("cboContrattoDest");
	strCodePsOr = request.getParameter("hidCodePsOr");
	strCodePrestAggOr = "";
	String strCODE_PR_PS_PA_CONTROr = "";
	strCodePrestAggOr = Misc.nh(request.getParameter("cboPrestAggOr"));
	strGlobalCodeOggFatrz = request.getParameter("cboOggFatOr");
	//prendo il codice oggetto fatturazione datta stringa comcatenata
	if(!strGlobalCodeOggFatrz.equals(""))
	{
		Vector vctOggFatt = Misc.split(strGlobalCodeOggFatrz,"$");
		strCodeOggFatrzOr = (String)vctOggFatt.elementAt(0);
		
	}
	
	strDescClienteOrigine = request.getParameter("txtClienteOr");
	strDescContrattoOrigine = request.getParameter("hidDescContrattoOr");
	strDescClienteDestinazione = request.getParameter("txtClienteDest");
	strDescContrattoDestinazione = request.getParameter("hidDescContrattoDest");
    strtypeLoad = request.getParameter("hidTypeLoad");
    //numero di elementi per pagina
	 if(request.getParameter("cboNumRecXPag")==null){
	     intRecXPag=5;
	 }else{
	     intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
	 }
%>
<html>
<head>
	<title>Fatturazione non Traffico</title>
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
        function ONANNULLA(){
          //torna sulla pagina di scelta del tipo contratto
          window.location="<%=StaticContext.PH_COMMON_JSP%>com_tc.jsp?strTitolo=Ribaltamento%20Parametri%20Tariffari&destinationPageClassic=/ribaltamentotariffe/jsp/cbn1_pt_rib_cl.jsp&destinationPageSpecial=&intFunzionalita=2&intAction=1&TCNonAmmessiClassic=&TCNonAmmessiSpecial=";
        }
		
        function ONCONTINUA(){
          objForm.action = "<%=StaticContext.PH_RIBALTAMENTOTARIFFE_JSP%>cbn1_dett_rib_2_cl.jsp";
          objForm.submit();
        }
        
        function initialize(){
          objForm = document.frmDati;
          //disabilitazione dei controlli
          Disable(objForm.txtDescClienteOrigine);
          Disable(objForm.txtDescContrattoOrigine);
          Disable(objForm.txtDescClienteDestinazione);
          Disable(objForm.txtDescContrattoDestinazione);
        }
		
        
    </SCRIPT>
</head>

<body onload="initialize()">
<form name="frmDati" method="post" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidTypeLoad" value="">

<input type="hidden" name="hidCodeClienteOr" value="<%=request.getParameter("hidCodeClienteOr")%>">
<input type="hidden" name="hidCodeClienteDest" value="<%=request.getParameter("hidCodeClienteDest")%>">
<input type="hidden" name="cboContrattoOr" value="<%=request.getParameter("cboContrattoOr")%>">
<input type="hidden" name="cboContrattoDest" value="<%=request.getParameter("cboContrattoDest")%>">
<input type="hidden" name="hidCodePsOr" value="<%=request.getParameter("hidCodePsOr")%>">
<input type="hidden" name="cboPrestAggOr" value="<%=request.getParameter("cboPrestAggOr")%>">
<input type="hidden" name="cboOggFatOr" value="<%=request.getParameter("cboOggFatOr")%>">
<input type="hidden" name="txtClienteOr" value="<%=request.getParameter("txtClienteOr")%>">
<input type="hidden" name="hidDescContrattoOr" value="<%=request.getParameter("hidDescContrattoOr")%>">
<input type="hidden" name="txtClienteDest" value="<%=request.getParameter("txtClienteDest")%>">
<input type="hidden" name="hidDescContrattoDest" value="<%= request.getParameter("hidDescContrattoDest")%>">
<!-- Immagine Titolo -->
<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_RIBALTAMENTOTARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!-- tabella intestazione -->
  <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Visualizzazione Dettaglio Ribaltamento</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		  </table>
		</td>
	</tr>
   </table>
   <br>
<!-- tabella dati di riferimento -->
<table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati di Riferimento</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		  </table>
		</td>
	</tr>
</table>
<table align="center" width="80%" bgcolor="#F6FAFA">
	<td class="textB" align="left">Risultati per pag.:&nbsp;</td>
	<td  class="text">
		<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_dett_rib_cl.jsp')">
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
	<tr>
		<td class="textB">Cliente origine</td>
		<td><input type="text" name="txtDescClienteOrigine" class="text" value = "<%= strDescClienteOrigine %>" size="50"></td>
	</tr>
	<tr>
		<td class="textB">Contratto origine</td>
		<td><input type="text" name="txtDescContrattoOrigine" class="text"value = "<%= strDescContrattoOrigine %>" size="50"></td>
	</tr>
	<tr>
		<td class="textB">Cliente Destinanazione</td>
		<td><input type="text" name="txtDescClienteDestinazione" class="text" value = "<%= strDescClienteDestinazione %>" size="50"></td>
	</tr>
	<tr>
		<td class="textB">Contratto Destinanazione</td>
		<td><input type="text" name="txtDescContrattoDestinazione" class="text" value = "<%= strDescContrattoDestinazione %>" size="50"></td>
	</tr>
</table>

<!-- tabella dettaglio tariffe -->
<table align="center" width="80%" cellpadding="1" cellspacing="1">
	<tr>
		<td colspan="11">
			<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dettaglio Tariffe</td>
						  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
						</tr>
					  </table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="<%=StaticContext.bgColorHeader%>">
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Prodotto/Servizio</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Prestazione<BR>&nbsp;Aggiuntiva</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Tipo<BR>&nbsp;Causale</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Oggetto Fatturazione</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Tipo<BR>&nbsp;Offerta</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Minimo Classe<BR>&nbsp;di Sconto</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Massimo Classe<BR>&nbsp;diSconto</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Minimo<BR>&nbsp;Fascia</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Massimo<BR>&nbsp;Fascia</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Importo<BR>&nbsp;Tariffa</td>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">&nbsp;Tipo<BR>&nbsp;Importo</td>
	</tr>
	<!-- gestisco i vari casi -->
	<%
    if(strtypeLoad==null){
        vctDettaglioTariffe = remoteEnt_Tariffe.getDettRibaTariffa(StaticContext.LIST,
                                                                   strCodeContrOr,
                                                                   strCodePsOr,
                                                                   strCodePrestAggOr,
                                                                   "",
                                                                   strCodeOggFatrzOr);
        if (vctDettaglioTariffe!=null){
            session.setAttribute("vctDettaglioTariffe", vctDettaglioTariffe);
        }
    }else{
        //prende il vettore dalla sessione
        vctDettaglioTariffe = (Vector) session.getAttribute("vctDettaglioTariffe");
    }
    
	if(vctDettaglioTariffe != null)
    {
        int intRecTotali = vctDettaglioTariffe.size();%>

		<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
			
		<%
		for (i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++)
        {
              DB_Tariffe lobj_Tariffa = new DB_Tariffe();
              lobj_Tariffa = (DB_Tariffe)vctDettaglioTariffe.elementAt(i);
			  if ((i%2)==0)
               	strBgColor = StaticContext.bgColorRigaPariTabella;
              else
               	strBgColor = StaticContext.bgColorRigaDispariTabella;%>
			  <tr bgcolor="<%=strBgColor%>">
				  <td class="text" nowrap>&nbsp;<%=lobj_Tariffa.getDESC_ES_PS()%></td>
				  <td class="text" nowrap>&nbsp;<%=lobj_Tariffa.getDESC_PREST_AGG()%></td>
				  <td class="text" nowrap>&nbsp;<%=lobj_Tariffa.getDESC_TIPO_CAUS()%></td>
				  <td class="text" nowrap>&nbsp;<%=lobj_Tariffa.getDESC_OGG_FATRZ()%></td>
				  <td class="text" nowrap>&nbsp;<%=lobj_Tariffa.getDESC_TIPO_OFF()%></td>
				  <td class="textNumber" nowrap>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MIN_SPESA())%></td>
				  <td class="textNumber" nowrap>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MAX_SPESA())%></td>
				  <td class="textNumber" nowrap>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MIN()%></td>
				  <td class="textNumber" nowrap>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MAX()%></td>
				  <td class="textNumber" nowrap>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_TARIFFA())%></td>
				  <td class="text" nowrap>&nbsp;<%=lobj_Tariffa.getTIPO_FLAG_MODAL_APPL_TARIFFA()%></td>
			  </tr>
      <%}%>
              <tr>
                <td colspan="11" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
	                    <!-- barra di navigazione -->
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

<!-- pulsantiera -->
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
