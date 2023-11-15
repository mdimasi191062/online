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
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.utl.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ page import = "com.ds.chart.*" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>

<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_statistiche_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Statistiche" type="com.ejbSTL.Ent_StatisticheHome" location="Ent_Statistiche" />
<EJB:useBean id="remoteEnt_Statistiche" type="com.ejbSTL.Ent_Statistiche" scope="session">
    <EJB:createBean instance="<%=homeEnt_Statistiche.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
    
    // rimozione oggetti dalla sessione
    if (session.getAttribute("barDataset")!=null) {
        session.removeAttribute("barDataset");
    }
        
    if (session.getAttribute("flagSysTipoContratto")!=null) {
        session.removeAttribute("flagSysTipoContratto");
    }
        
    if (session.getAttribute("tipoContratto")!=null) {
        session.removeAttribute("tipoContratto");
    }
        
    if (session.getAttribute("BarDiagramType")!=null) {
        session.removeAttribute("BarDiagramType");
    }
        
    if (session.getAttribute("PieDiagramType")!=null) {
        session.removeAttribute("PieDiagramType");
    }
        
    if (session.getAttribute("idPS")!=null) {
        session.removeAttribute("idPS");
    }
        
    if (session.getAttribute("pieDataset")!=null) {
        session.removeAttribute("pieDataset");
    }
        
    if (session.getAttribute("idPSClone")!=null) {
        session.removeAttribute("idPSClone");
    }
        
    if (session.getAttribute("PIE_DIAGRAM_TYPE")!=null) {
        session.removeAttribute("PIE_DIAGRAM_TYPE");
    }

	int i=0;
	int intAction;
	int intFunzionalita;

	String strComboSize = "7";
	String lstrCodeAccount="";
	String lstrCodiceTipoContratto="";
	String lstrDescTipoContratto="";
	String lstrFlagSysSubContratto = "";

	Vector vctAccount = null;

	SimpleDateFormat formatter_date = new SimpleDateFormat( "yyyy", Locale.getDefault() );
	String annoRiferimento = formatter_date.format(new Date());
	
	if(request.getParameter("intAction") == null){
	    intAction = StaticContext.LIST;
	}else{
	    intAction = Integer.parseInt(request.getParameter("intAction"));
	}
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_STATISTICHE;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
	
	lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	
	/* gestione della sottocategoria tipo_contratto
	 *
	 * se lstrCodiceTipoContratto è 7,8,9,12,17 la sottocategoria è "SR" (Special - Regolamentato)
	 * se lstrCodiceTipoContratto è 11,13,18,19,20,21 la sottocategoria è "SX" (Special - XDSL)
	 * se lstrCodiceTipoContratto NON è compreso nei precedenti range la sottocategoria è "C" (Classic)
	 */
	 switch (Integer.parseInt(lstrCodiceTipoContratto)) {
	 
	 	case 7:
	 	case 8:
	 	case 9:
	 	case 12:
	 	case 17:
	 		lstrFlagSysSubContratto = "SR";
	 		break;
	 		
	 	case 11:
	 	case 13:
	 	case 18:
	 	case 19:
	 	case 20:
	 	case 21:
	 		lstrFlagSysSubContratto = "SX";
	 		break;
	 	
	 	default:
	 		lstrFlagSysSubContratto = "C";
	 		break;
	 }

        

%>
<html>
<head>
<title>Lancio Statistiche</title>
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
        
    function initialize() {
		
        objForm = document.frmDati;
        //impostazione delle proprietà di default per tutti gli oggetti della form
        setDefaultProp(objForm);
        clearAllSpaces(objForm.slcDatiCliente);
        clearAllSpaces(objForm.slcRiepilogo);
        setButtonStatus();
    }
		
    function ONINSERISCI_SEL() {
        if(getComboIndex(objForm.slcDatiCliente) != -1) {
            addOption(objForm.slcRiepilogo,getComboText(objForm.slcDatiCliente),getComboValue(objForm.slcDatiCliente));
            DelOptionByIndex(objForm.slcDatiCliente,getComboIndex(objForm.slcDatiCliente));
            setButtonStatus();
        }
    }
		
    function ONINSERISCI_TUTTI() {
        var i = 0;
        var intLen = objForm.slcDatiCliente.length;
        if (intLen > 0) {
            for (i=0; i < intLen; i++) {
                addOption(objForm.slcRiepilogo,getComboTextByIndex(objForm.slcDatiCliente,i),getComboValueByIndex(objForm.slcDatiCliente,i));
            }
            clearAll(objForm.slcDatiCliente);
            setButtonStatus();
        }
    }
		
    function ONELIMINA_TUTTI() {
        var i = 0;
        var intLen = objForm.slcRiepilogo.length;
        if (intLen > 0) {
            for (i=0; i < intLen; i++) {
                addOption(objForm.slcDatiCliente,getComboTextByIndex(objForm.slcRiepilogo,i),getComboValueByIndex(objForm.slcRiepilogo,i));
            }
            clearAll(objForm.slcRiepilogo);
            setButtonStatus();
        }
    }
		
    function ONELIMINA() {
        if(getComboIndex(objForm.slcRiepilogo) != -1) {
            addOption(objForm.slcDatiCliente,getComboText(objForm.slcRiepilogo),getComboValue(objForm.slcRiepilogo));
            DelOptionByIndex(objForm.slcRiepilogo,getComboIndex(objForm.slcRiepilogo));
            setButtonStatus();
        }
    }
		
    function ONGENERA() {

        var ids="";
        var strValore = "";

        if(validazioneCampi(objForm)) {
				
            // costruzione lista gestori

            if(objForm.slcRiepilogo.length == 0) {
                alert("Nessun elemento selezionato!!");
                return;
            }

            for (i=0; i<objForm.slcRiepilogo.options.length; i++) {
                if (ids!='') {
                    ids=ids+",";
                }
                ids=ids+"'"+objForm.slcRiepilogo.options[i].value+"'";
            }

            objForm.ids.value=ids;

            objForm.meseInizio.value=getComboValue(objForm.cboMeseInizio);
            objForm.annoInizio.value=getComboValue(objForm.cboAnnoInizio);

            objForm.meseFine.value=getComboValue(objForm.cboMeseFine);
            objForm.annoFine.value=getComboValue(objForm.cboAnnoFine);
            
            if (objForm.annoInizio.value > objForm.annoFine.value) {
                alert("Il periodo di riferimento non è corretto!!");
                return;
            }

            if ((objForm.annoInizio.value == objForm.annoFine.value) && (objForm.meseInizio.value >  objForm.meseFine.value)) {
                alert("Il periodo di riferimento non è corretto!!");
                return;
            }

            if (getComboValue(objForm.cboTipoGrafico) == "") {
                alert("Selezionare il tipo di grafico!!");
                return;
            }

            objForm.tipoGrafico.value=getComboValue(objForm.cboTipoGrafico);

            objForm.submit();

        }
    }
		
    function setButtonStatus() {
        if(getComboCount(objForm.slcDatiCliente) > 0) {
            Enable(objForm.INSERISCI_SEL);
            Enable(objForm.INSERISCI_TUTTI);

            Disable(objForm.ELIMINA_TUTTI);
        } else {
            Disable(objForm.INSERISCI_SEL);
            Disable(objForm.INSERISCI_TUTTI);

            Enable(objForm.ELIMINA_TUTTI);
        }
			
        if(getComboCount(objForm.slcRiepilogo) > 0) {
            Enable(objForm.ELIMINA);
            Enable(objForm.GENERA);
        } else {
            Disable(objForm.ELIMINA);
            Disable(objForm.GENERA);
        }
    }

		
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="<%=StaticContext.PH_STATISTICHE_JSP%>bar.jsp" target="_blank">
		<input type = "hidden" name = "intAction" value="<%=intAction%>">
		<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
		<input type = "hidden" name = "hidViewState" value="">
		<input type = "hidden" name = "tipoGrafico" value="">
		<input type = "hidden" name = "ids" value="">
		<input type = "hidden" name = "meseInizio" value="">
		<input type = "hidden" name = "annoInizio" value="">
		<input type = "hidden" name = "meseFine" value="">
		<input type = "hidden" name = "annoFine" value="">
		<input type = "hidden" name = "codiceTipoContratto" value="<%=lstrCodiceTipoContratto%>">
		<input type = "hidden" name = "descrTipoContratto" value="<%=lstrDescTipoContratto%>">
		<input type = "hidden" name = "flagSysTipoContratto" value="<%=lstrFlagSysSubContratto%>">
    	<!-- tabella intestazione -->
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_STATISTICHE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Statistiche per contratto : <%=lstrDescTipoContratto%></td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		<table width="85%" border="0" cellspacing="0" cellpadding="0" align='center'>
			<tr>
				<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
		</table>

		 <!-- tabella CLIENTE -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Cliente:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <!--CORPO CLIENTE-->
		 <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="20%">&nbsp;Account</td>
				<td class="text" align="left" width="80%">
					<select name="slcDatiCliente" size="<%=strComboSize%>" style="width: 80%;" class = "text">
						<%vctAccount = remoteEnt_Statistiche.getAccountStatistiche(intAction,intFunzionalita,lstrCodiceTipoContratto);
						 	for(i=0; i < vctAccount.size();i++){
								DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);%>
								<option value="<%=objDbAccount.getCODE_ACCOUNT()%>"><%//=objDbAccount.getDATA_INIZIO_PERIODO()%><%=objDbAccount.getDESC_ACCOUNT()%></option>
							<%}%>
							<option value="">
								<%
								for (i=0;i<50;i++){
									out.print("&nbsp;");
								}
								%>
							</option>
					</select>
				</td>
			</tr>
		 </table>

		 <!-- tabella RIEPILOGO -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <!--CORPO RIEPILOGO-->
		 <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="20%">&nbsp;Account</td>
				<td class="text" align="left" width="80%">
					<select name="slcRiepilogo" size="<%=strComboSize%>" style="width: 80%;"  class = "text">
						<option value="">
							<%
							for (i=0;i<50;i++){
								out.print("&nbsp;");
							}
							%>
						</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
		 </table>
		 
		<!-- tabella intestazione -->
		<table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Periodo di riferimento</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				 </table>
				</td>
			</tr>
		</table>

		<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td class="textB"  width="20%">&nbsp;Inizio</td>
				<td class="text" align="left" width="80%">
					Mese
						<select name="cboMeseInizio" class="text"><%= HTMLWriter.getMesiOptions()%></select>
					Anno
						<select name="cboAnnoInizio" class="text"><%= HTMLWriter.getAnniOptions(1980,Integer.parseInt(annoRiferimento))%></select>	
				</td>
			</tr>
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td class="textB" width="20%">&nbsp;Fine</td>
				<td class="text" align="left" width="80%">
					Mese
						<select name="cboMeseFine" class="text"><%= HTMLWriter.getMesiOptions()%></select>
					Anno
						<select name="cboAnnoFine" class="text"><%= HTMLWriter.getAnniOptions(1980,Integer.parseInt(annoRiferimento))%></select>
				</td>
			</tr>
		</table>

		<table width="85%" border="0" cellspacing="0" cellpadding="0" align='center'>
			<tr>
				<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
		</table>

		<!-- tabella intestazione -->
		<table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Grafico</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				 </table>
				</td>
			</tr>
		</table>

		<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td class="textB" width="20%">&nbsp;Tipo di grafico</td>
				<td class="text" align="left" width="80%">
					<select class="text" title="TipoGrafico" name="cboTipoGrafico">
						<option class="text" value="">[Seleziona Opzione]</option>
	                        <option class="text" value="BarRenderer3D">barre 3D</option>
	                        <option class="text" value="BarRenderer">barre 2D</option>
	                        <option class="text" value="LineAndShapeRenderer">interpolazione lineare</option>
	                        <option class="text" value="CategoryStepRenderer">interpolazione a gradini</option>
	                        <option class="text" value="MinMaxCategoryRenderer">minimo e massimo</option>
	                        <option class="text" value="LevelRenderer">puntuale</option>
					</select>
				</td>
			</tr>
		</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='5'></td>
		</tr>
	</table>
		 <!--PULSANTIERA-->
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