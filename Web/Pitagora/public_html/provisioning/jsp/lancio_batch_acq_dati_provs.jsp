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
<%=StaticMessages.getMessage(3006,"lancio_batch_acq_dati_provs.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>

<%

	Vector vctListaBatch = null;
	Vector vctListaSysParam = null;

	String lstr_Message = "";
	String strComboSize = "7";

	int i=0;
	int intAction = StaticContext.LIST;
	int intFunzionalita = StaticContext.FN_PROVISIONING;

	SimpleDateFormat formatter_date = new SimpleDateFormat( "dd/MM/yyyy", Locale.getDefault() );
	String dataRiferimento = formatter_date.format(new Date());

    String lstr_SysParamValorizzazione = "0";
    vctListaSysParam = remoteEnt_Batch.getI5_6SysParamValue("VALZ");

    for(i=0; i < vctListaSysParam.size();i++) {
        DB_I5_6SysParam objDbSysParam = (DB_I5_6SysParam)vctListaSysParam.elementAt(i);
        lstr_SysParamValorizzazione = objDbSysParam.getNUM_NUMERIC_VALUE();
    }
    
	lstr_Message = "In data " + dataRiferimento + " Il Sistema";
    if (lstr_SysParamValorizzazione.equals("0")) {
        lstr_Message = lstr_Message + " NON";
    }

    lstr_Message = lstr_Message + " si trova in VALORIZZAZIONE.";

%>
<html>
<head>
<title>Lancio Acquisizione Dati Provisioning</title>
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
        clearAllSpaces(objForm.slcBatchDisponibili);
        clearAllSpaces(objForm.slcRiepilogo);
        setButtonStatus();
    }
		
	function ONELIMINA() {
	    if(getComboIndex(objForm.slcRiepilogo) != -1) {
	        addOption(objForm.slcBatchDisponibili,getComboText(objForm.slcRiepilogo),getComboValue(objForm.slcRiepilogo));
	        DelOptionByIndex(objForm.slcRiepilogo,getComboIndex(objForm.slcRiepilogo));
	        setButtonStatus();
	    }
	}
	
	function ONINSERISCI_SEL() {
		if(objForm.slcRiepilogo.length == 0) {
		    if(getComboIndex(objForm.slcBatchDisponibili) != -1) {
		        addOption(objForm.slcRiepilogo,getComboText(objForm.slcBatchDisponibili),getComboValue(objForm.slcBatchDisponibili));
		        DelOptionByIndex(objForm.slcBatchDisponibili,getComboIndex(objForm.slcBatchDisponibili));
		        setButtonStatus();
		    }
	    } else {
		    alert("Attenzione! Non è possibile eseguire più di un batch.");
	    }
	}
		
	function ONLANCIOBATCH() {
		if(validazioneCampi(objForm)) {
		
			if(objForm.slcRiepilogo.length == 0) {
			    alert("Nessun batch selezionato!!");
			    return;
			}
		
			objForm.hidCodeElabBatch.value=objForm.slcRiepilogo.options[0].value;
			
			EnableAllControls(objForm);
			objForm.action = "lancio_batch_acq_dati_provs_2.jsp";
			
			objForm.submit();
		}
	}	

    function setButtonStatus() {
        if(getComboCount(objForm.slcBatchDisponibili) > 0) {
            Enable(objForm.INSERISCI_SEL);
        } else {
            Disable(objForm.INSERISCI_SEL);
        }
			
        if(getComboCount(objForm.slcRiepilogo) > 0) {
            Enable(objForm.ELIMINA);
            Enable(objForm.LANCIOBATCH);
        } else {
            Disable(objForm.ELIMINA);
            Disable(objForm.LANCIOBATCH);
        }
    }
		
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="" target="_self">
		<input type = "hidden" name = "intAction" value="<%=intAction%>">
		<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
		<input type = "hidden" name = "hidCodeElabBatch" value="">
		<input type = "hidden" name = "hidSysParamValorizzazione" value="<%=lstr_SysParamValorizzazione%>">

		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="left"><img src="<%=StaticContext.PH_PROVISIONING_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
			<tr>
		</table>
		<!-- tabella intestazione -->
		<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
							<td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Acquisizione Dati Provisioning</td>
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

		 <!-- tabella BATCH PROVISIONING DISPONIBILI -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Batch Provisioning:</td>
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
				<td class="textB" valign="top" width="20%">&nbsp;Disponibili</td>
				<td class="text" align="left" width="80%">
					<select name="slcBatchDisponibili" size="<%=strComboSize%>" style="width: 80%;" class = "text">
                            <%
                            vctListaBatch = remoteEnt_Batch.getListaBatch(intFunzionalita,intAction);
                            for(i=0; i < vctListaBatch.size();i++){
                                DB_AnagFunz objDbAnagFunz = (DB_AnagFunz)vctListaBatch.elementAt(i);%>
							<option value="<%=objDbAnagFunz.getCODE_FUNZ()%>"><%=objDbAnagFunz.getDESC_FUNZ()%></option>
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
				<td class="textB" valign="top" width="20%">&nbsp;Selezionati</td>
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

		 <!-- tabella STATO SISTEMA -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
			</tr>
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Stato Sistema:</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
        <center>
            <h1 class="textB">
                <%=lstr_Message%>
            </h1>
        </center>

		 
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