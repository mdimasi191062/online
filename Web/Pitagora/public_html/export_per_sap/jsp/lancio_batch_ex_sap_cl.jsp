
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
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"lancio_batch_ex_sap_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSapHome" location="Ent_ExportPerSap" />
<EJB:useBean id="remoteEnt_ExportPerSap" type="com.ejbSTL.Ent_ExportPerSap" scope="session">
    <EJB:createBean instance="<%=homeEnt_ExportPerSap.create()%>" />
</EJB:useBean>

<%
	String strConTestate = "";
	String strSenzaTestate = "";
	String strDataInizioCiclo = "";
	String strDataFineCiclo = "";
	String strDataFinePeriodo = "";
	boolean blnTestate = false;
	Vector vctDate = new Vector();

  Integer intCountTabella;
  //######################
  //controllo sul popolamento
  intCountTabella = (Integer)remoteEnt_ExportPerSap.countTestCsvSap();
 
	//######################
	//prime due date
	vctDate = (Vector)remoteEnt_ExportPerSap.getDateCicloFattSap();
	if(vctDate.size() > 0){
		blnTestate = true;
		DB_ExportPerSap objDB_ExportPerSap = (DB_ExportPerSap)vctDate.elementAt(0);
		strDataInizioCiclo = (String)objDB_ExportPerSap.getDATA_INIZIO_CICLO_FATRZ();
		strDataFineCiclo = (String)objDB_ExportPerSap.getDATA_FINE_CICLO_FATRZ();
		//strDataFinePeriodo = (String)objDB_ExportPerSap.getDATA_FINE_PERIODO();
	}
	//terza data
	vctDate = (Vector)remoteEnt_ExportPerSap.getDataFinePeriodoSap();
	if(vctDate.size() > 0){
		blnTestate = true;
		strConTestate = "checked";
		strSenzaTestate = "";
		DB_ExportPerSap objDB_ExportPerSap = (DB_ExportPerSap)vctDate.elementAt(0);
		strDataFinePeriodo = (String)Misc.nh(objDB_ExportPerSap.getDATA_FINE_PERIODO());
	}
	
	if(blnTestate){
		strConTestate = "checked";
	}else{
		strSenzaTestate = "checked";
	}


  
%>

<html>
<head>
	<title></title>
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
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle proprietà di default per tutti gli oggetti della form
			setDefaultProp(objForm);		
      <%//Se intCountTabella == 0 devo disabilitare il radio button Senza Generazione Testate %>
      <%if(intCountTabella.intValue() == 0 ){%>
        Disable(objForm.rdTestate[0]);    
      <%}%>
			checkTestate()					
		}
		
		function checkTestate(){
			
			if(getRadioButtonValue(objForm.rdTestate) == "0"){
				
				DisableLink(document.links[0],objForm.imgCalendar1)//data inizio ciclo
				DisableLink(document.links[1],objForm.imgCancel1)//data inizio ciclo
				setObjProp(objForm.txtDataInizioCiclo,"label=Data Inizio Ciclo|tipocontrollo=data|obbligatorio=no|disabilitato=si");
				objForm.txtDataInizioCiclo.value = "";
				
				DisableLink(document.links[2],objForm.imgCalendar2)//data fine ciclo
				DisableLink(document.links[3],objForm.imgCancel2)//data fine ciclo
				setObjProp(objForm.txtDataFineCiclo,"label=Data Fine Ciclo|tipocontrollo=data|obbligatorio=no|disabilitato=si");
				objForm.txtDataFineCiclo.value = "";
				
				DisableLink(document.links[4],objForm.imgCalendar3)//data fine periodo
				DisableLink(document.links[5],objForm.imgCancel3)//data fine periodo
				setObjProp(objForm.txtDataFinePeriodo,"label=Data Fine Periodo|tipocontrollo=data|obbligatorio=no|disabilitato=si");
				objForm.txtDataFinePeriodo.value = "";
				
			}else{
				
				EnableLink(document.links[0],objForm.imgCalendar1)//data inizio ciclo
				EnableLink(document.links[1],objForm.imgCancel1)//data inizio ciclo
				setObjProp(objForm.txtDataInizioCiclo,"label=Data Inizio Ciclo|tipocontrollo=data|obbligatorio=si|disabilitato=si");
				objForm.txtDataInizioCiclo.value = "<%=strDataInizioCiclo%>";
				
				EnableLink(document.links[2],objForm.imgCalendar2)//data fine ciclo
				EnableLink(document.links[3],objForm.imgCancel2)//data fine ciclo
				setObjProp(objForm.txtDataFineCiclo,"label=Data Fine Ciclo|tipocontrollo=data|obbligatorio=si|disabilitato=si");
				objForm.txtDataFineCiclo.value = "<%=strDataFineCiclo%>";
				
				EnableLink(document.links[4],objForm.imgCalendar3)//data fine periodo
				EnableLink(document.links[5],objForm.imgCancel3)//data fine periodo
				setObjProp(objForm.txtDataFinePeriodo,"label=Data Fine Periodo|tipocontrollo=data|obbligatorio=si|disabilitato=si");
				objForm.txtDataFinePeriodo.value = "<%=strDataFinePeriodo%>";
				
			}
			
		}
		
		function ONLANCIOBATCH()
		{
			if(validazioneCampi(objForm))
			{
				EnableAllControls(objForm);
				objForm.action = "lancio_batch_ex_sap_2_cl.jsp";
				objForm.submit();
			}
			
		}
	
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_EXPORT_PER_SAP_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
    	<!-- tabella intestazione -->
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Export per Sap</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <table width="85%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
		 	<tr>
				<td height="30" class="textB">&nbsp;</td>
			</tr>
			<tr>
				<td align="center">
					<table width="80%" border="0">
						<tr>
							<td class="text" align="right">
								<input type="Radio" name="rdTestate" value="0" class="text" onclick="checkTestate()" <%=strSenzaTestate%>>
							</td>
							<td class="text" align="left">
								Generazione report
							</td>
						</tr>
						<tr>
							<td class="text" align="right">
								<input type="Radio" name="rdTestate" value="1" class="text" onclick="checkTestate()" <%=strConTestate%>>
							</td>
							<td class="text" align="left">
								Elaborazione procedura e generazione report
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<table>
									<tr>
										<td class="textB">Data Inizio Ciclo</td>
										<td class="textB">Data Fine Ciclo</td>
										<td class="textB">Data Fine Periodo</td>
									</tr>
									<tr>
										<td class="text">
											<input type='text' name='txtDataInizioCiclo' value='<%=strDataInizioCiclo%>' class="text" readonly="">
											<a href="javascript:showCalendar('frmDati.txtDataInizioCiclo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
											<a href="javascript:clearField(objForm.txtDataInizioCiclo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
										</td>
										<td class="text">
											<input type='text' name='txtDataFineCiclo' value='<%=strDataFineCiclo%>' class="text" readonly="">
											<a href="javascript:showCalendar('frmDati.txtDataFineCiclo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar2' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
											<a href="javascript:clearField(objForm.txtDataFineCiclo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel2'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
										</td>
										<td class="text">
											<input type='text' name='txtDataFinePeriodo' value='<%=strDataFinePeriodo%>' class="text" readonly="">
											<a href="javascript:showCalendar('frmDati.txtDataFinePeriodo','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar3' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
											<a href="javascript:clearField(objForm.txtDataFinePeriodo);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel3'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
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
</body>
</html>