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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lancio_val_attiva_2_cl.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_ValAttiva" type="com.ejbSTL.Ctr_ValAttivaHome" location="Ctr_ValAttiva" />
<EJB:useBean id="remoteCtr_ValAttiva" type="com.ejbSTL.Ctr_ValAttiva" scope="session">
    <EJB:createBean instance="<%=homeCtr_ValAttiva.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Batch" type="com.ejbSTL.Ctr_BatchHome" location="Ctr_Batch" />
<EJB:useBean id="remoteCtr_Batch" type="com.ejbSTL.Ctr_Batch" scope="session">
    <EJB:createBean instance="<%=homeCtr_Batch.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Contratti" type="com.ejbSTL.Ctr_ContrattiHome" location="Ctr_Contratti" />
<EJB:useBean id="remoteCtr_Contratti" type="com.ejbSTL.Ctr_Contratti" scope="session">
    <EJB:createBean instance="<%=homeCtr_Contratti.create()%>" />
</EJB:useBean>
<%!
	//dichiarazione costanti per gli step
	static final int gintStepElabBatchXlancio = 1;
	static final int gintStepClientiStatoProvvisorio1 = 2;
	static final int gintStepClientiStatoProvvisorio2 = 3;
	static final int gintStepClientiSpeComNoCong = 4;
	static final int gintStepFinal = 5;
	String strParameterToLog = "";
	//costruzione di un vettore di databean dato un vettore di stringhe
	private Vector costruzioneVectorDataBean(Vector pvct_Account) throws Exception{
		Vector lvctReturn = new Vector();
		strParameterToLog = "";
		for (int j=0;j<pvct_Account.size();j++){
			String lstrAppoAccount = (String)pvct_Account.elementAt(j);
			DB_Account lobjAppoAccount = new DB_Account();
			Vector lvctAppoDatiAccount = Misc.split(lstrAppoAccount,"$");
			lobjAppoAccount.setCODE_ACCOUNT((String)lvctAppoDatiAccount.elementAt(0));
			//lobjAppoAccount.setCODE_PARAM((String)lvctAppoDatiAccount.elementAt(1));
			lvctReturn.addElement(lobjAppoAccount);
		}
		return lvctReturn;
	}
%>
<%
	String strLogMessage = "";
	int intStepNow;
	int intAction;
	int intFunzionalita;
	int i;
	boolean blnExit = false;
	boolean blnStop = false;
	Vector lvct_AccountDaElaborare = null;
	intAction = Integer.parseInt(request.getParameter("intAction"));
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	String strMessage = "";
	String lstrCodeCicloDiFatturazione = ""; 
	String lstrIstanzaCicloFatturazione = ""; 
	String lstr_TipoElab="";
	String lstr_CodiciAccount = "";
	String lstr_CodeTipoContratto = "";
	String lstr_DescTipoContratto = "";
	String lstr_CodiciAccountDaEliminare = "";
	String lstrDataFinePeriodo = "";
	String strResult = "";
	Vector lvct_Account = new Vector();
    Vector lvct_AccountPagina = new Vector();
	Vector lvct_AccountDaEliminare = new Vector();
	Vector lvct_AccountRisultato = new Vector();
	Vector lvct_Global1 = new Vector();
	Vector lvct_Global2 = new Vector();
	
	String strUrlDiPartenza = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp";
	strUrlDiPartenza += "?CONTINUA=true";
		
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
	//fine paginatore
	
	//Lista Account SELEZIONATI!
	lstr_CodiciAccount = Misc.nh(request.getParameter("hidViewState"));
	lvct_Account = Misc.split(lstr_CodiciAccount,"|");
	//Costruzione del vettore di DataBean (DB_Clienti)
	lvct_Account = costruzioneVectorDataBean(lvct_Account);
	
	lstr_CodiciAccountDaEliminare = Misc.nh(request.getParameter("hidCodiciAccountDaEliminare"));
	lvct_AccountDaEliminare = Misc.split(lstr_CodiciAccountDaEliminare,"|");
	//Costruzione del vettore di DataBean (DB_Clienti)
	lvct_AccountDaEliminare = costruzioneVectorDataBean(lvct_AccountDaEliminare);
	
	lstr_CodeTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	lstr_DescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	lstrDataFinePeriodo = Misc.nh(request.getParameter("txtDataFinePeriodo"));
	lstrCodeCicloDiFatturazione = Misc.nh(request.getParameter("cboCicloDiFatturazione"));
	lstrIstanzaCicloFatturazione = Misc.nh(request.getParameter("txtIstanzaCicloDiFatt"));
	
	if(Misc.nh(request.getParameter("hidStep")).equals("")){
        intStepNow = 1;
    }else{
        intStepNow = Integer.parseInt(Misc.nh(request.getParameter("hidStep")));
    }
	
	//CONTROLLO DEGLI STEPS
	if(! Misc.gestStepXLancio(request,intStepNow)){
		response.sendRedirect((String)session.getAttribute("URL_COM_TC"));
	}
	
	//MATCH VECTORS
	if(strtypeLoad.equals("1"))
	{//paginazione
		lvct_AccountRisultato = lvct_Account;
	}
	else
	{//sottrae i record da eliminare a quelli selezionati
		//MATCH VECTORS
		lvct_Global1.addElement(lvct_Account);
		lvct_Global1.addElement(DB_Account.class);
		lvct_Global1.addElement("CODE_ACCOUNT");
		lvct_Global2.addElement(lvct_AccountDaEliminare);
		lvct_Global2.addElement(DB_Account.class);
		lvct_Global2.addElement("CODE_ACCOUNT");
		lvct_AccountRisultato = Misc.MatchVectors(lvct_Global1, lvct_Global2, StaticContext.DIFF);
	}

    //ESTRAZIONE Nuovi Account da eliminare
	lvct_AccountPagina = null;
	switch (intStepNow){
		case gintStepElabBatchXlancio:
			  if (strtypeLoad.equals("1")) //paginazione
			  {
				lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
			  }
			  else //query
			  {
				lvct_AccountPagina = remoteCtr_Batch.getElabBatchXLancio(lstr_CodeTipoContratto,lvct_AccountRisultato,"");
				if (lvct_AccountPagina != null)
				  session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
			  }
			
			strMessage ="Attenzione! per i seguenti account � in corso un'altra eleborazione batch!<br>";
			strMessage += " Proseguire escludendo gli account individuati?";
		break;
		case gintStepClientiStatoProvvisorio1:
			if (strtypeLoad.equals("1")) //paginazione
			  {
				lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
			  }
			  else //query
			  {
				lvct_AccountPagina = remoteCtr_Contratti.getAccountStatoProvvisorio(lvct_AccountRisultato,
																		lstr_CodeTipoContratto,
																		StaticContext.RIBES_INFR_BATCH_NOTE_CREDITO);
				if (lvct_AccountPagina != null)
				  session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
			  }
			
			strMessage ="Per i seguenti account esistono elaborazioni batch <br>";
	        strMessage += " di tipo Note di credito non congelate!<br>";
	        strMessage += " Proseguire escludendo gli account individuati?";
		break;
		case gintStepClientiStatoProvvisorio2:
			if (strtypeLoad.equals("1")) //paginazione
			  {
				lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
			  }
			  else //query
			  {
				lvct_AccountPagina = remoteCtr_Contratti.getAccountStatoProvvisorio(lvct_AccountRisultato,
																		lstr_CodeTipoContratto,
																		StaticContext.RIBES_INFR_BATCH_CAMBI_TARIFFA);
				if (lvct_AccountPagina != null)
				  session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
			  }
			
			strMessage ="Per i seguenti account esistono elaborazioni batch <br>";
	        strMessage += " di tipo Cambi tariffa non congelate!<br>";
	        strMessage += " Proseguire escludendo gli account individuati?";
		break;
		case gintStepClientiSpeComNoCong:
			if (strtypeLoad.equals("1")) //paginazione
			  {
				lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
			  }
			  else //query
			  {
				  lvct_AccountPagina = remoteCtr_Contratti.getAccountSpeComNoCong(lvct_AccountRisultato,
																		lstr_CodeTipoContratto);
				if (lvct_AccountPagina != null)
				  session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
			  }
          
			strMessage ="Per i seguenti account esistono elaborazioni batch <br>";
	        strMessage += " di tipo Spesa complessiva non congelate!<br>";
	        strMessage += " Proseguire escludendo gli account individuati?";
		break;
		case gintStepFinal:
        default:
			 //estrazione del code utente loggato dalla sessione
			clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
			String strCodeUtente = objInfoUser.getUserName();%>
			<%
			if(lvct_AccountRisultato.size() > 0){
					strParameterToLog = Misc.buildParameterToLog(lvct_AccountRisultato);
					strLogMessage = "remoteCtr_ValAttiva.LancioBatch(" + "CodeTipoContratto=" + lstr_CodeTipoContratto 
																		+ ";CodeUtente=" + strCodeUtente 
																		+ ";CodeCicloDiFatturazione=" + lstrCodeCicloDiFatturazione
																		+ ";IstanzaCicloFatturazione=" + lstrIstanzaCicloFatturazione 
																		+ ";DataFinePeriodo=" + lstrDataFinePeriodo + ";"  
																		+ strParameterToLog  + ")";%>
					<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
						<%=StaticMessages.getMessage(3501,strLogMessage)%>
					</logtag:logData>													
					<%strResult = remoteCtr_ValAttiva.LancioBatch (lvct_AccountRisultato,
				                                                        lstr_CodeTipoContratto,     
				                                                        lstrDataFinePeriodo,
				                                                        lstrCodeCicloDiFatturazione,
				                                                        lstrIstanzaCicloFatturazione,
				                                                        strCodeUtente );
					if(strResult.equals(""))
					{
						strLogMessage += " : Successo" ;
					}
					else
					{
						strLogMessage += " : " + strResult ;
					}
					blnExit = true;%>
					<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
						<%=StaticMessages.getMessage(3501,strLogMessage)%>
					</logtag:logData>
		  <%}else{
				strResult = "Elaborazione Batch non avviata per mancanza di Account validi!";
				//blnStop = true;
				blnExit = true;
			}%>
		<%break;
	}
	
%>
<HTML>
<HEAD>
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
	<script language="JavaScript">
		var objForm = null;
		var strURL = "<%=StaticContext.PH_CLASSIC_COMMON_JSP%>PP_Pag_Account_cl.jsp";
		strURL += "?strImageDirPadre=note_di_credito";
		strURL += "&strMessage=<%=strMessage%>";
		
		function initialize()
		{
			objForm = document.frmDati;
			<%if(!blnExit){%>
				<%if(lvct_AccountPagina.size()==0){%>
					//esegue il prossimo step
					goNextStep();
				<%}else{%>
					openPopUpAccount(strURL);
				<%}%>
			<%}else{
				//mostra l'esito dell'elaborazione
				//String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strResult);
        String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
        strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
				response.sendRedirect(strUrl);
			}%>
		}
		
		function ONCONFERMA(){
            goNextStep();
		}
		function ONANNULLA(){
            //torna sulla pagina di scelta del tipo contratto
//modificata da mimmo per adeguamento Special
//			objForm.action = "cbn1_lancio_val_attiva_cl.jsp";
        objForm.action = "<%=(String)session.getAttribute("URL_COM_TC")%>";
			objForm.submit();
		}
	</script>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" action="cbn1_lancio_val_attiva_2_cl.jsp" method="post">
<input type = "hidden" name = "intAction" value="<%=intAction%>">
<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">

<%String strCodiceAccountRisultato="";
for(i=0;i < lvct_AccountRisultato.size();i++){
	DB_Account lobjAppoAccount = new DB_Account();
	lobjAppoAccount = (DB_Account)lvct_AccountRisultato.elementAt(i);
	if(strCodiceAccountRisultato.equals("")){
		strCodiceAccountRisultato = lobjAppoAccount.getCODE_ACCOUNT() + "$" + lobjAppoAccount.getCODE_PARAM();
	}else{
		strCodiceAccountRisultato += "|" + lobjAppoAccount.getCODE_ACCOUNT() + "$" + lobjAppoAccount.getCODE_PARAM();
	}
}%>
<input type = "hidden" name = "hidViewState" value="<%=strCodiceAccountRisultato%>">
<input type = "hidden" name = "codiceTipoContratto" value="<%=lstr_CodeTipoContratto%>">
<input type = "hidden" name = "hidDescTipoContratto" value="<%=lstr_DescTipoContratto%>">
<input type = "hidden" name = "txtDataFinePeriodo" value="<%=lstrDataFinePeriodo%>">
<input type = "hidden" name = "cboCicloDiFatturazione" value="<%=lstrCodeCicloDiFatturazione%>">
<input type = "hidden" name = "txtIstanzaCicloDiFatt" value="<%=lstrIstanzaCicloFatturazione%>">
<input type = "hidden" name = "hidStep" value="<%=intStepNow%>">
<input type = "hidden" name = "hidTypeLoad" value="">
<%
//costruisce la stringa degli account da eliminare a partire dal vettore
//restituito dai vari metodi	
lstr_CodiciAccountDaEliminare = "";
if(!blnExit){
	for(i = 0; i < lvct_AccountPagina.size(); i++){	
		DB_Account lobj_Account=new DB_Account();
		lobj_Account=(DB_Account)lvct_AccountPagina.elementAt(i);
		if(lstr_CodiciAccountDaEliminare.equals("")){
			lstr_CodiciAccountDaEliminare = lobj_Account.getCODE_ACCOUNT() + "$" + lobj_Account.getCODE_PARAM();
		}else{
			lstr_CodiciAccountDaEliminare += "|" + lobj_Account.getCODE_ACCOUNT() + "$" + lobj_Account.getCODE_PARAM();
		}
	}
}
%>
<input type="hidden" name="hidCodiciAccountDaEliminare" value="<%=lstr_CodiciAccountDaEliminare%>">
</form>
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_VALORIZZAZIONEATTIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lancio Batch</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<center>
	<h1 class="textB">
	Lancio Batch in Corso...<br>
	Attendere
	</h1>
	
</center>
</BODY>
</HTML>
