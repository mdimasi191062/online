<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>

<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="javax.ejb.*"%>

<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ page import = "com.ds.chart.*" %>

<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_PS_Statistiche.jsp")%>
</logtag:logData>

<%
    int j=0;

    String strCopia = "";
    String strChecked = "";
    String strSelected = "";

    String comboDiagramType = "";
    String diagramTypeSessione = "";
    String diagramTypePagina = "";

    session.removeAttribute("PIE_DIAGRAM_TYPE");

    int intAction;
    if(request.getParameter("intAction") == null){
        intAction = StaticContext.LIST;
    }else{
        intAction = Integer.parseInt(request.getParameter("intAction"));
    }
    int intFunzionalita;
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
    int intRecXPag;
    if(request.getParameter("cboNumRecXPag")==null){
        intRecXPag=5;
    }else{
        intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    }

    String strtypeLoad = request.getParameter("hidTypeLoad");
    String strDescTipoContratto = Misc.nh(request.getParameter("DescTipoContratto"));

	diagramTypePagina = request.getParameter("cboDiagramType");
	diagramTypeSessione = (String)session.getAttribute("PieDiagramType");
    
    if (diagramTypePagina==null) {
    		// se è null significa che la pagina chiamante non ha passato il valore quindi lo prendo dalla sessione
    		comboDiagramType = diagramTypeSessione;
    } else {
    		// se è diverso da null la chiamante è la pagina stessa (si sta navigando oppure si è premuto 'GENERA' )
    		// è necessario verificare se il valore letto dalla pagina differisce da quello in sessione ed in questo caso 
    		// aggiornare il valore nella sessione stessa.
        comboDiagramType = diagramTypePagina;
		
	    if (!diagramTypePagina.equalsIgnoreCase(diagramTypeSessione)) {
	        session.setAttribute("PieDiagramType", diagramTypePagina);
	    }
    }

    if (request.getParameter("FIRST_TIME")!=null) {
        session.setAttribute("idPSClone", ((Vector) session.getAttribute("idPS")).clone());
    }
    
    Vector lvct_ListaPS = (Vector) session.getAttribute("idPSClone");
    StringTokenizer stElencoCheck = null;
    
    int numElemento = 0;
    int statoElemento = 0;

    boolean blnValore = false;

    if ((request.getParameter("hidComando")!=null)&&(!request.getParameter("hidComando").equals(""))){
        blnValore = (request.getParameter("hidComando").equals("SEL_ALL"));
        for (int i=0; i< lvct_ListaPS.size(); i++){
            ((KeyValue)lvct_ListaPS.elementAt(i)).setChecked(blnValore);
        }
    }else {
        if ((request.getParameter("hidListaCheck") != null) && (request.getParameter("hidListaCheck") != "")) {

            stElencoCheck = new StringTokenizer(request.getParameter("hidListaCheck"),",");
        
            while (stElencoCheck.hasMoreTokens()) {

                strCopia = stElencoCheck.nextToken();
                statoElemento = Integer.parseInt(strCopia.substring(strCopia.indexOf(":")+1,strCopia.length()));
                numElemento = Integer.parseInt(strCopia.substring("chkPS".length(),strCopia.indexOf(":")));

                if (statoElemento==0) {
                    ((KeyValue)lvct_ListaPS.elementAt(numElemento)).setChecked(false);
                } else {
                    ((KeyValue)lvct_ListaPS.elementAt(numElemento)).setChecked(true);
                }
            }
        }
    }
    
    String flagTermina=request.getParameter("flagTermina");
    if (flagTermina==null) {
        flagTermina="0";
    } else {
        session.setAttribute("idPS", ((Vector) session.getAttribute("idPSClone")));
    }

%>
  
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<TITLE>Selezione P/S per Statistiche</TITLE>
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
    
	var objForm;

	function inizialize(flagChiusura) {
   		objForm = document.frmDati;
        if (flagChiusura =="1") {
            goConfermaChiusura();
        }
	}

	function goConfermaChiusura() {
		if (opener && !opener.closed) 
		{
            opener.dialogWin.returnedValue ="<%=comboDiagramType%>";
            opener.dialogWin.returnFunc();
            self.close();
		}
		else{ 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
			self.close();
		}
	}

	function old_setResetAllItemCheckPS(modo) {
		if (opener && !opener.closed) {
        
            for (i=0; i<objForm.elements.length; i++) {
                ch=objForm.elements[i];
                if (ch.name.indexOf('chkPS')>=0) {
                    ch.checked = modo;
                }
            }
            
		} else { 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
            self.close();
		}
    }
    
	function aggiornaListaCheck() {
		if (opener && !opener.closed) {

    		var stat='';
            
            for (i=0; i<objForm.elements.length; i++) {
                ch=objForm.elements[i];
                if (ch.name.indexOf('chkPS')>=0) {
                    indexCh=ch.name.substring(ch.name.indexOf('chkPS'), ch.name.length);
                    if (stat != '') {
                        stat = stat+",";
                    }
                    if (ch.checked){
                        stat=stat+indexCh+":1";
                    }else {
                        stat=stat+indexCh+":0";
                    }
                }
            }

            objForm.hidListaCheck.value = stat;
            
		} else { 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
			self.close();
		}
    }

	function goPagina(UrlPagina) {
        aggiornaListaCheck();
        goPage(UrlPagina);
    }

    // NUOVE FUNZIONI GESTITE DAL TAG DELLA PULSANTIERA

    function ONGENERA() {
		if (opener && !opener.closed) 
		{
			aggiornaListaCheck();
            objForm.flagTermina.value = "1";
            objForm.submit();
		}
		else{ 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
			self.close();
		}
    }
    
    function ONANNULLA() {
		if (opener && !opener.closed) {
						
		}
		else { 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
		}
	  	self.close();
    }
    
    function ONSELEZIONA_TUTTI() {
		if (opener && !opener.closed) 
		{
            objForm.hidComando.value = "SEL_ALL";
            objForm.submit();
		}
		else { 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
		}
    }
    
    function ONDESELEZIONA_TUTTI() {
		if (opener && !opener.closed) 
		{
            objForm.hidComando.value = "SEL_NONE";
            objForm.submit();
		}
		else { 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
		}
    }
    
    // VECCHIE FUNZIONI GESTITE DAI PULSANTI PRESENTI NELLA FORM

	function click_cmdConferma() {
		if (opener && !opener.closed) 
		{
			aggiornaListaCheck();
            objForm.flagTermina.value = "1";
            objForm.submit();
		}
		else{ 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
			self.close();
		}
	}

	function click_cmdAnnulla() {
		if (opener && !opener.closed) {
						
		}
		else { 
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.");
		}
	  	self.close();
	}
    
	</SCRIPT>
</HEAD>
<BODY onload="inizialize('<%=flagTermina%>');">
<form name="frmDati" method="post">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="hidListaCheck" value="">
<input type="hidden" name="hidListaTotaleCheck" value="">
<input type="hidden" name="flagTermina" value="<%=flagTermina%>">
<input type="hidden" name="hidComando" value="">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Selezione Grafico Dettaglio Statistiche</td>
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
	    <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
            <td>
            	<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Grafico </td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                        <tr>
                            <td colspan='2' bordercolor="<%=StaticContext.bgColorCellaBianca%>" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                        </tr>
                        <tr>
                            <td align="left" colspan='2'>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                                    <tr>
                                        <td class="textB" align="left">&nbsp;Tipo di grafico</td>
                                        <td class="text" align="left">
                                            <select name="cboDiagramType" class="text"><%= HTMLWriter.getTipoGraficoPieOptions(comboDiagramType)%></select>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan='2' bordercolor="<%=StaticContext.bgColorCellaBianca%>" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                        </tr>
                        <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;P/S per tipo contratto <%=strDescTipoContratto%></td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
				  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	                    <tr>
	                      <td colspan='3' bordercolor="<%=StaticContext.bgColorCellaBianca%>" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
	                    </tr>
                        <tr>
                            <td align="left" colspan='3'>
                                <table>
                                    <tr>
                                        <td class="textB" align="left">Risultati per pag.:&nbsp;</td>
                                        <td class="text">
                                            <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_PS_Statistiche.jsp')"> 
                                                <%
                                                for(int k = 5;k <= 50; k=k+5){
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
                    <%if ((lvct_ListaPS==null)||(lvct_ListaPS.size()==0)){%>
                        <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">Nessun P/S presente</td>
                        </tr>
	                <%}else{
							String bgcolor="";
							String codicePS="";
							String descrizionePS="";
                            KeyValue lobj_PS=null;
                            int intRecTotali=lvct_ListaPS.size();%>
                            
                        <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                     <%for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                            {
                                lobj_PS=null;
                                lobj_PS=(KeyValue)lvct_ListaPS.elementAt(j);
                                if ((j%2)==0){
                                    bgcolor=StaticContext.bgColorRigaDispariTabella;
		                        }else{
                                    bgcolor=StaticContext.bgColorRigaPariTabella;
		                        }

                                if (j ==((pagerPageNumber.intValue()-1)*intRecXPag)){
                                    codicePS=lobj_PS.getKey();
                                    descrizionePS=lobj_PS.getValue();
                                }%>
                        <tr>
                            <td width='2%' bgcolor="<%=bgcolor%>">
                                <% strChecked=lobj_PS.isChecked()?"checked":"";%>
                                <input type='checkbox' name='chkPS<%=""+j%>' value='<%=lobj_PS.getKey()%>|<%=lobj_PS.getValue()%>' <%=strChecked%> >
                            </td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=lobj_PS.getValue()%></td>
                        </tr>
                        <%}%>
                        <tr>
                            <td colspan='3' class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                                <!--paginatore-->
                                <pg:index>
                                     Risultati Pag.
                                     <pg:prev> 
                                        <A HREF="javaScript:goPagina('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                                     </pg:prev>
                                     <pg:pages>
                                        <%if (pageNumber == pagerPageNumber){%>
                                            <b><%= pageNumber %></b>&nbsp;
                                        <%}else{%>
                                            <A HREF="javaScript:goPagina('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                        <%}%>
                                     </pg:pages>
                                     <pg:next>
                                           <A HREF="javaScript:goPagina('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                                     </pg:next>
                                </pg:index>
                            </pg:pager>
                            </td>
                        </tr>
						<%}%>
	                    <tr>
	                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
	                    </tr>
	                  </table>
					 </td>
					</tr>
                </table>
                </td>
              </tr>
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
</BODY>
</HTML>