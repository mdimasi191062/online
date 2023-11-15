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
<%=StaticMessages.getMessage(3006,"LancioRepricingSp.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEntContrattiSTL" type="com.ejbSTL.EntContrattiSTLHome" location="EntContrattiSTL" />
<EJB:useBean id="remoteEntContrattiSTL" type="com.ejbSTL.EntContrattiSTL" scope="session">
    <EJB:createBean instance="<%=homeEntContrattiSTL.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeBatchSTL" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatchSTL" type="com.ejbSTL.BatchSTL" scope="session">
    <EJB:createBean instance="<%=homeBatchSTL.create()%>" />
</EJB:useBean>



<%
int intNumSpace=100;
String strComboSize = "7";
int intAction;
int i=0;
int intFunzionalita;
String lstrCodeAccount="";
if(request.getParameter("intAction") == null){
    intAction = StaticContext.LIST;//1
}else{
    intAction = Integer.parseInt(request.getParameter("intAction"));
}
if(request.getParameter("intFunzionalita") == null){
	intFunzionalita = StaticContext.FN_TARIFFA;//1
}else{
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
}

session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));

String lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String lstrDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
Vector vctAccount = null;

BatchElem  datiBatch=null;
String codeFunzBatch   = null;
String flagTipoContr   = null; 

datiBatch=remoteBatchSTL.getCodeFunzFlag(lstrCodiceTipoContratto,"VA",null,"S");
if (datiBatch!=null)
{
     codeFunzBatch = datiBatch.getCodeFunz();
     flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString(); 
}  

%>
<html>
<head>
	<title>Lancio Repricing</title>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js"  type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js"     type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js"   type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js"   type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js"   type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js"   type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js"    type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js"         type="text/javascript"></script>

	<SCRIPT LANGUAGE='Javascript'>
    //var flagTipoContr   = "<%//=flagTipoContr%>";
		var objForm = null;
		function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle proprietà di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			clearAllSpaces(objForm.slcDatiCliente);
			clearAllSpaces(objForm.slcRiepilogo);
			setButtonStatus();
		}
		
		function ONINSERISCI_SEL()
		{
      objForm.slcRiepilogo.focus();
			if(getComboIndex(objForm.slcDatiCliente) != -1)
			{
					addOption(objForm.slcRiepilogo,getComboText(objForm.slcDatiCliente),getComboValue(objForm.slcDatiCliente))
					DelOptionByIndex(objForm.slcDatiCliente,getComboIndex(objForm.slcDatiCliente));
					setButtonStatus();
			}
		}
		
	    function ONINSERISCI_TUTTI()
		{
      objForm.slcRiepilogo.focus();
			var i = 0;
			var intLen = objForm.slcDatiCliente.length;
			if (intLen > 0)
			{
				for (i=0; intLen > i; i++)
				{
					addOption(objForm.slcRiepilogo,getComboTextByIndex(objForm.slcDatiCliente,i),getComboValueByIndex(objForm.slcDatiCliente,i));
				}
				clearAll(objForm.slcDatiCliente);
				setButtonStatus();
			}
		}
		
		function ONELIMINA()
		{
      objForm.slcDatiCliente.focus();
			if(getComboIndex(objForm.slcRiepilogo) != -1)
			{
					addOption(objForm.slcDatiCliente,getComboText(objForm.slcRiepilogo),getComboValue(objForm.slcRiepilogo))
					DelOptionByIndex(objForm.slcRiepilogo,getComboIndex(objForm.slcRiepilogo));
					setButtonStatus();
			}
		}
		
		function ONLANCIOBATCH()
		{
			if(validazioneCampi(objForm)){
				if(objForm.slcRiepilogo.length == 0){
					alert("Nessun elemento selezionato!!");
					return;
				}
				objForm.action = "<%=StaticContext.PH_CONGUAGLICAMBITARIFFA_JSP%>LancioRepricing2Sp.jsp";
				preparePageFields();
				EnableAllControls(objForm);
				objForm.submit();
			}
		}
		
		function preparePageFields()
		{
			var strAppo = "";
			var i = 0;
			for(i=0;objForm.slcRiepilogo.length > i;i++)
			{
				if(strAppo != ""){
					strAppo +=  "|" + getComboValueByIndex(objForm.slcRiepilogo,i) ;
				}else{
					strAppo += getComboValueByIndex(objForm.slcRiepilogo,i) ;
				}
			}
			objForm.hidViewState.value = strAppo;
		}
		
		function setButtonStatus()
		{
			if(getComboCount(objForm.slcDatiCliente) > 0){
				Enable(objForm.INSERISCI_SEL);
				Enable(objForm.INSERISCI_TUTTI);
			}else{
				Disable(objForm.INSERISCI_SEL);
				Disable(objForm.INSERISCI_TUTTI);
			}
			
			if(getComboCount(objForm.slcRiepilogo) > 0){
				Enable(objForm.ELIMINA);
				Enable(objForm.LANCIOBATCH);
			}else{
				Disable(objForm.ELIMINA);
				Disable(objForm.LANCIOBATCH);
			}
		}
	</SCRIPT>
</head>
<body onload = "initialize()">
	<form name="frmDati" method="post" action="">
		<input type = "hidden" name = "intAction" value="<%=intAction%>">
		<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
		<input type = "hidden" name = "hidViewState" value="">
		<input type = "hidden" name = "codiceTipoContratto" value="<%=lstrCodiceTipoContratto%>">
		<input type = "hidden" name = "hidDescTipoContratto" value="<%=lstrDescTipoContratto%>">
    <input type="hidden" name=flagTipoContr id= flagTipoContr  value= "<%=flagTipoContr%>">
    	<!-- tabella intestazione -->
		<!-- Immagine Titolo -->
		<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="<%=StaticContext.PH_CONGUAGLICAMBITARIFFA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
		
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Calcolo Conguagli Cambi Tariffa: <%=lstrDescTipoContratto%></td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				  </table>
				</td>
			</tr>
	     </table>
		 <br>
		 <!-- tabella CLIENTE -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
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
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="20%">&nbsp;Account</td>
				<td class="text" align="left" width="80%">
					<select name="slcDatiCliente" size="<%=strComboSize%>" style="width: 80%;" class = "text">
						<%

            vctAccount = remoteEntContrattiSTL.getAccountRepricing(lstrCodiceTipoContratto,codeFunzBatch);
            
						 	for(i=0; i < vctAccount.size();i++){
								DB_Account objDbAccount = (DB_Account)vctAccount.elementAt(i);%>
								<option value="<%=objDbAccount.getCODE_ACCOUNT()%>$"><%//=objDbAccount.getDATA_INIZIO_PERIODO()%><%=objDbAccount.getDESC_ACCOUNT()%></option>
							<%}%>
							<option value="">
								<%
								for (i=0;i<intNumSpace;i++){
									out.print("&nbsp;");
								}
								%>
							</option>
					</select>
				</td>
			</tr>
		 	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		 </table>
		 <br>
		 <!-- tabella RIEPILOGO -->
		 <table width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
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
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="textB" valign="top" width="20%">&nbsp;Account</td>
				<td class="text" align="left" width="80%">
					<select name="slcRiepilogo" size="<%=strComboSize%>" style="width: 80%;"  class = "text">
						<option value="">
							<%
							for (i=0;i<intNumSpace;i++){
								out.print("&nbsp;");
							}
							%>
						</option>
					</select>
				</td>
			</tr>
		 	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
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
	    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">&nbsp;&nbsp;
	        <sec:ShowButtons td_class="textB"/>
	    </td>
	  </tr>
	</table>
	</form>
</body>
</html>