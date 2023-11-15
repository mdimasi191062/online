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
<%@ page import="com.utl.Misc" %>
<%@ page import="com.utl.DB_Account" %>



<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn_dg_lancio_val_attiva_1_cl.jsp")%>
</logtag:logData>
<%
//dichiarazioni delle variabili
int i=0;
int intAction = 0;
Vector vctAccount = null;
String bgcolor = "";
String strPageAction = "";
String strMessaggio = "";
String strCodiceTipoContratto = "";
String strCicloDiFatturazione = "";
String strIstanzaCiclo = "";
String strLastErrorMessage = "";
String strResult = "";
String strMode = "";
String strParameterToLog = "";
String strLogMessage = "";
String strViewState = Misc.nh(request.getParameter("hidViewState"));
boolean blnCambiaCiclo = false;
boolean blnCicloCambiato = false;
boolean blnFattureCancellate = false;
%>
<html>
<head>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<style type="text/css">
    #waitpage { position: absolute; }
  </style>
  <title>
	</title>
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
	var blnCambiaCiclo = <%=blnCambiaCiclo%>;
	var blnCicloCambiato =  <%=blnCicloCambiato%>;
	var blnFattureCancellate = <%=blnFattureCancellate%>;
	function initialize()
	{
		objForm = document.frmDati;
	}
	
	function click_cmdConferma(){
		if(blnCambiaCiclo){
			updVS(objForm.hidViewState,"vsPageAction","CAMBIACICLO");
		}else{
			updVS(objForm.hidViewState,"vsPageAction","CANCELLA");
		}
		objForm.action = "cbn_dg_lancio_val_attiva_1_cl.jsp";
		objForm.submit();
	}
	function click_cmdAnnulla(){
		self.close();
	}
 	function HideImage ()
	{
	    if (document.layers)
      {
	      document.waitpage.visibility = 'hide';
	    }
      else
	    {
	      if (document.all)
	        document.all.waitpage.style.visibility = 'hidden';
	    }
	}

</SCRIPT>
</head>
<body onload="initialize()">
<DIV ID="waitpage">
<table border=0 align="center" width=100%>
<tr>
  <td align="center">
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif" width="60" height="50" alt="" border="0">
  </td>
</tr>
</table>
</DIV>
<%out.flush();%>
<!-- instanziazione dell'oggetto remoto-->
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Fatture" type="com.ejbSTL.Ctr_FattureHome" location="Ctr_Fatture" />
<EJB:useBean id="remoteCtr_Fatture" type="com.ejbSTL.Ctr_Fatture" scope="session">
    <EJB:createBean instance="<%=homeCtr_Fatture.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>
<%
if(strViewState.equals("")){
	strMessaggio = Misc.nh(request.getParameter("messaggio"));
	strCodiceTipoContratto = Misc.nh(request.getParameter("strCodiceTipoContratto"));
	strCicloDiFatturazione = Misc.nh(request.getParameter("strCicloDiFatturazione"));
	strIstanzaCiclo = Misc.nh(request.getParameter("strIstanzaCiclo"));				 
	strMode =  Misc.nh(request.getParameter("strMode"));
	intAction = Integer.parseInt(Misc.nh(request.getParameter("strAction")));
}else{
	//prendo i valori dal viewState
	strPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	strCodiceTipoContratto = Misc.getParameterValue(strViewState,"vsCodeTipoContratto");
	strCicloDiFatturazione = Misc.getParameterValue(strViewState,"vsCicloDiFatturazione");
	strIstanzaCiclo = Misc.getParameterValue(strViewState,"vsIstanzaCiclo");				 
	strMode =  Misc.getParameterValue(strViewState,"vsMode");
	intAction = Integer.parseInt(Misc.getParameterValue(strViewState,"vsIntAction"));

}

if(strPageAction.equals("CANCELLA")){
		//vengono eliminate le fatture provvisorie
		vctAccount = remoteEnt_Contratti.getAccountFatture (intAction,
                                                            strCodiceTipoContratto,
                                                            strCicloDiFatturazione,
                                                            strIstanzaCiclo,
                                                            StaticContext.FATTURE_PROVVISORIE);
		for(i = 0; i < vctAccount.size();i++)
		{
			DB_Account lobjDbAccount = (DB_Account)vctAccount.elementAt(i);
		}%>
		
		<%  strParameterToLog = Misc.buildParameterToLog(vctAccount);
			strLogMessage = "remoteCtr_Fatture.delFattureProvvisorie(" + strParameterToLog + ")";%>
		<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
				<%=StaticMessages.getMessage(3505,strLogMessage)%>
		</logtag:logData>
		<%strResult = remoteCtr_Fatture.delFattureProvvisorie(vctAccount);
		if(strResult.equals(""))
		{
			strLogMessage += ": Successo";
		}
		else
		{
			strLogMessage += ": " + strResult;
		}%>
		<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
				<%=StaticMessages.getMessage(3505,strLogMessage)%>
		</logtag:logData>
		<%vctAccount = remoteEnt_Contratti.getAccountFatture (intAction,
                    									   	strCodiceTipoContratto,
                    									   	strCicloDiFatturazione,
                    									   	strIstanzaCiclo,
												   		   	StaticContext.FATTURE_DEFINITIVE);
        //se non ci sono fatture definitive eseguo subito il cambio ciclo
		if(vctAccount.size() == 0){%>
			<%strLogMessage = "remoteCtr_Fatture.CambioCicloFatturazione(" + strParameterToLog 
																		   + ";CodiceTipoContratto=" + strCodiceTipoContratto
																		   + ";CicloDiFatturazione=" + strCicloDiFatturazione
																		   + ";strIstanzaCiclo=" + strIstanzaCiclo + ")";%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(3504,strLogMessage)%>
			</logtag:logData>
			<%strResult = remoteCtr_Fatture.CambioCicloFatturazione (vctAccount,
                                                                  strCodiceTipoContratto,
                                                                  strCicloDiFatturazione,
                                                                  strIstanzaCiclo);
			if(strResult.equals(""))
			{
				strLogMessage += ": Successo";
			}
			else
			{
				strLogMessage += ": " + strResult;
			}%>												  												
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(3504,strLogMessage)%>
			</logtag:logData>					  
            <%blnCicloCambiato = true;
		}	
}

if(strPageAction.equals("CAMBIACICLO")){
	vctAccount = remoteEnt_Contratti.getAccountFatture (intAction,
                    									   	strCodiceTipoContratto,
                    									   	strCicloDiFatturazione,
                    									   	strIstanzaCiclo,
												   		   	StaticContext.FATTURE_DEFINITIVE);%>
	<%strLogMessage = "remoteCtr_Fatture.CambioCicloFatturazione(" + strParameterToLog 
																		   + ";CodiceTipoContratto=" + strCodiceTipoContratto
																		   + ";CicloDiFatturazione=" + strCicloDiFatturazione
																		   + ";strIstanzaCiclo=" + strIstanzaCiclo + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3504,strLogMessage)%>
	</logtag:logData>														
	<%strResult = remoteCtr_Fatture.CambioCicloFatturazione (vctAccount,
                                                                  strCodiceTipoContratto,
                                                                  strCicloDiFatturazione,
                                                                  strIstanzaCiclo);
	if(strResult.equals(""))
	{
		strLogMessage += ": Successo";
	}
	else
	{
		strLogMessage += ": " + strResult;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3504,strLogMessage)%>
	</logtag:logData>			
	<%blnCicloCambiato = true;
	
} 

if(!blnCicloCambiato){
	Vector vctAppo = remoteEnt_Batch.getElabBatchRunning (intAction,
			                               				  StaticContext.RIBES_INFR_BATCH_VAL_ATTIVA,
			                               				  "");
	
	strResult = Misc.nh((String)vctAppo.elementAt(0));
	if(!strResult.equals("")){
		strLastErrorMessage = remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"TW-6");
	    strLastErrorMessage = Misc.replace(strLastErrorMessage,"%1",strResult);
		strMessaggio = "";
	}else{
			vctAccount = remoteEnt_Contratti.getAccountFatture (intAction,
	                                                                 strCodiceTipoContratto,
	                                                                 strCicloDiFatturazione,
	                                                                 strIstanzaCiclo,
	                                                                 StaticContext.FATTURE_PROVVISORIE);
			if(vctAccount.size()>0){
	                  strMessaggio = "Per i seguenti account esistono fatture provvisorie.<br>E' necessario cancellarle per cambiare ciclo di fatturazione.";
			}else{
				vctAccount = remoteEnt_Contratti.getAccountFatture (intAction,
	                                                                 strCodiceTipoContratto,
	                                                                 strCicloDiFatturazione,
	                                                                 strIstanzaCiclo,
	                                                                 StaticContext.FATTURE_DEFINITIVE);
				if(vctAccount.size()>0){
	                      strMessaggio = "Per i seguenti account non � stata congelata la fattura del ciclo di fatturazione corrente.<br>Procedere con il cambio di ciclo?";
                          blnCambiaCiclo = true;
				}else{
                    //faccio direttamente il cambio ciclo%>
					
                    <%strResult = remoteCtr_Fatture.CambioCicloFatturazione (vctAccount,
                                                                           strCodiceTipoContratto,
                                                                           strCicloDiFatturazione,
                                                                           strIstanzaCiclo);
                    blnCicloCambiato = true;
                }
			}
	}
}
if (blnCicloCambiato)
{
%>
<script language="javascript">
  if (<%=blnCicloCambiato%>)
  {
			if (opener && !opener.closed) 
			{
				opener.dialogWin.returnFunc();
			}
			else{ 
				alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
			}
		 	self.close();
  }
</script>
<%
}
else
{
%>
<script language="javascript">
    HideImage();
    resize(569,400);
</script>
<form name="frmDati" method="post" action="">
	<input type = "hidden" name = "hidViewState" value="vsCodeTipoContratto=<%=strCodiceTipoContratto%>|vsCicloDiFatturazione=<%=strCicloDiFatturazione%>|vsIstanzaCiclo=<%=strIstanzaCiclo%>|vsIntAction=<%=intAction%>|vsMode=<%=strMode%>">
	<!-- Immagine Titolo -->
	<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td align="left"><img src="<%=StaticContext.PH_VALORIZZAZIONEATTIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
	  <tr>
	</table>
	
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
	                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strMessaggio%></td>
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
			<table width="90%" cellspacing="1" align="center">
				<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
					<td width="100%" height="20" class="textB">&nbsp;Descrizione</td>
				</tr>
				<%  
				// se il vettore � stato caricato si prosegue con il caricamento della lista
				if(vctAccount != null){
						for(i =0; i < vctAccount.size(); i++){
							DB_Account lobj_Account = new DB_Account();
							lobj_Account = (DB_Account)vctAccount.elementAt(i);
					  		//cambia il colore delle righe
							if ((i%2)==0)
								bgcolor=StaticContext.bgColorRigaPariTabella;
					        else
								bgcolor=StaticContext.bgColorRigaDispariTabella;
							%>
							<tr bgcolor="<%=bgcolor%>">
								<td width="100%" height="20" class="text">&nbsp;<%=lobj_Account.getDESC_ACCOUNT()%></td>
							</tr>
					   <%}%>
				 <%}else{%>
				 		<tr bgcolor="<%=bgcolor%>">
								<td width="100%" height="20" class="text">&nbsp;<%=strLastErrorMessage%></td>
						</tr>
				 <%}%>
			</table>
		</td>
	  </tr>
	</table>

<!--PULSANTIERA-->
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
	<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td width="50%" class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
	<%if(strLastErrorMessage.equals("")){%>
        <input class="textB" type="button" name="cmdConferma" value="CONFERMA" onClick="click_cmdConferma()">
	<%}%>
    </td>
    <td width="50%" class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
        <input class="textB" type="button" name="cmdAnnulla" value="ANNULLA" onClick="click_cmdAnnulla()">
    </td>
  </tr>
</table> 
<%}%>
</form>
</body>
</html>
