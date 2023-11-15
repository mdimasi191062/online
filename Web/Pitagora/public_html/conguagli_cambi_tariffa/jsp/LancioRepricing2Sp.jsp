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
<%@ page import="com.usr.*"%>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>


<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioRepricing2Sp.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtrRepricingSTL" type="com.ejbSTL.CtrRepricingSTLHome" location="CtrRepricingSTL" />
<EJB:useBean id="remoteCtrRepricingSTL" type="com.ejbSTL.CtrRepricingSTL" scope="session">
    <EJB:createBean instance="<%=homeCtrRepricingSTL.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtrContrattiSTL" type="com.ejbSTL.CtrContrattiSTLHome" location="CtrContrattiSTL" />
<EJB:useBean id="remoteCtrContrattiSTL" type="com.ejbSTL.CtrContrattiSTL" scope="session">
    <EJB:createBean instance="<%=homeCtrContrattiSTL.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeBatchSTL" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatchSTL" type="com.ejbSTL.BatchSTL" scope="session">
    <EJB:createBean instance="<%=homeBatchSTL.create()%>" />
</EJB:useBean>



<EJB:useHome id="homeEB" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />

<%!
	//dichiarazione costanti per gli step
	static final int gintStepElabBatchXlancio = 1;
	static final int gintStepAccountStatoProvvisorio1 = 2;
	static final int gintStepAccountStatoProvvisorio2 = 3;
	static final int gintStepFinal = 4; 
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
			lobjAppoAccount.setCODE_PARAM((String)lvctAppoDatiAccount.elementAt(1));
			lvctReturn.addElement(lobjAppoAccount);
		}
		return lvctReturn;
	}
%>
<%
  BatchElem  datiBatch=null;
  String codeFunzBatchVA = null;
  String codeFunzBatchVN = null;
  String codeFunzBatchVR = null;
	String strLogMessage = "";
  String       flagTipoContr       = request.getParameter("flagTipoContr");
	int intStepNow;
	int intAction;
	int intFunzionalita;
	boolean blnExit = false;
	intAction = Integer.parseInt(request.getParameter("intAction"));
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	String lstr_TipoElab="";
	String lstr_CodiciAccount = "";
	String lstr_CodeTipoContratto = "";
	String lstr_DescTipoContratto = "";
	String lstr_Messagge = "";
	String strMessage = "";
	String lstr_CodiciAccountDaEliminare = "";
  Vector lvct_Account = new Vector();
  Vector lvct_AccountPagina = new Vector();
	Vector lvct_AccountDaEliminare = new Vector();
	Vector lvct_AccountRisultato = new Vector();
	Vector lvct_Global1 = new Vector();
	Vector lvct_Global2 = new Vector();
	//String strUrlDiPartenza = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp";
  String strUrlDiPartenza = request.getContextPath() + "/common/jsp/GenericMsgSp.jsp";
	strUrlDiPartenza += "?CONTINUA=true";
	//paginatore
	int intRecXPag = 0;
	int i = 0;
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
	lvct_Account = costruzioneVectorDataBean(lvct_Account);
	//lista acccount da eliminare
	lstr_CodiciAccountDaEliminare = Misc.nh(request.getParameter("hidCodiciAccountDaEliminare"));
	lvct_AccountDaEliminare = Misc.split(lstr_CodiciAccountDaEliminare,"|");
	lvct_AccountDaEliminare = costruzioneVectorDataBean(lvct_AccountDaEliminare);
	lstr_CodeTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	lstr_DescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));

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
         if(flagTipoContr.equals("0") || flagTipoContr.equals("1"))
         {
               int numElabInCorsoAcc = (homeEB.findElabBatchUguali((new Integer(flagTipoContr)).intValue())).getElabBatch();
               if (numElabInCorsoAcc!=0)
               {
                   blnExit = true;
                   lstr_Messagge="Processo interrotto.Vi sono elaborazioni batch in corso.";
               }
         }    
		break;
    
		case gintStepAccountStatoProvvisorio1:
			if (strtypeLoad.equals("1")) //paginazione
			  {
				lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
			  }
			  else //query
			  {
        datiBatch=remoteBatchSTL.getCodeFunzFlag(lstr_CodeTipoContratto,"VA",null,"S");
        if (datiBatch!=null)
            codeFunzBatchVA = datiBatch.getCodeFunz();
				lvct_AccountPagina = remoteCtrContrattiSTL.getAccountStatoProvvisorio(lvct_AccountRisultato,
																		lstr_CodeTipoContratto,
                                    codeFunzBatchVA); //23

				if (lvct_AccountPagina != null)
				  session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
			  }
			    strMessage ="Per i seguenti account esistono elaborazioni batch di tipo Valorizzazione Attiva non congelate!";
	        strMessage += " Proseguire escludendo gli account individuati";
		break;

		case gintStepAccountStatoProvvisorio2:
			if (strtypeLoad.equals("1")) //paginazione
			  {
				lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
			  }
			  else //query
			  {
        datiBatch=remoteBatchSTL.getCodeFunzFlag(lstr_CodeTipoContratto,"VN",null,"S");
        if (datiBatch!=null)
            codeFunzBatchVN = datiBatch.getCodeFunz();
				lvct_AccountPagina = remoteCtrContrattiSTL.getAccountStatoProvvisorio(lvct_AccountRisultato,
																		lstr_CodeTipoContratto,
                                    codeFunzBatchVN);

				if (lvct_AccountPagina != null)
				  session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
			  }
			
			    strMessage ="Per i seguenti account esistono elaborazioni batch di tipo Note di Credito non congelate!";
	        strMessage += " Proseguire escludendo gli account individuati";																		
		break;

		//case gintStepFinal:
        default:
			//estrazione del code utente loggato dalla sessione
		  	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
			  String strCodeUtente = objInfoUser.getUserName();
				strParameterToLog = Misc.buildParameterToLog(lvct_AccountRisultato);
				strLogMessage = "remoteCtrRepricingSTL.lancioBatch(" + "CodeTipoContratto=" + lstr_CodeTipoContratto + ";CodeUtente=" + strCodeUtente + ";"  + strParameterToLog  + ")";%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(3501,strLogMessage)%>
			</logtag:logData>

			<%
       datiBatch=remoteBatchSTL.getCodeFunzFlag(lstr_CodeTipoContratto,"VR",null,"S");
       if (datiBatch!=null)
            codeFunzBatchVR = datiBatch.getCodeFunz();      
			lstr_Messagge = remoteCtrRepricingSTL.lancioBatch(lstr_CodeTipoContratto,strCodeUtente,lvct_AccountRisultato, codeFunzBatchVR, codeFunzBatchVR); //25
     
			if(lstr_Messagge==null || lstr_Messagge.equals(""))
			{
				strLogMessage += " : Successo" ;
			}
			else
			{
				strLogMessage += " : " + lstr_Messagge ;
			}
			blnExit = true;%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(3501,strLogMessage)%>
			</logtag:logData>
		<%
    break;
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
    var strURL = "../../conguagli_cambi_tariffa/jsp/AccountCambiTariffaSp.jsp";
    
		strURL += "?strImageDirPadre=conguagli_cambi_tariffa";
		strURL += "&strMessage=<%=strMessage%>";
		
		function initialize()
		{
			objForm = document.frmDati;
			<%
      if(!blnExit)
      {
         if (intStepNow==gintStepElabBatchXlancio || (lvct_AccountPagina!=null && lvct_AccountPagina.size()==0))
         {
         %>
					//esegue il prossimo step
					goNextStep();
				<%}
         else
         {
         %>
					//openPopUpAccount(strURL);
          VisualizzaAccount();
				<%}%>
	 <%}
     else
     {
				//mostra l'esito dell'elaborazione
        String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(lstr_Messagge,com.utl.StaticContext.ENCCharset);
				strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
				response.sendRedirect(strUrl);
			}%>
		}
		
		function ONCONFERMA()
    {
        //document.frmDati.submit();
        goNextStep();
		}
    
		function ONANNULLA()
    {
        //torna sulla pagina di scelta del tipo contratto
        objForm.action = "<%=(String)session.getAttribute("URL_COM_TC")%>";
		  	document.frmDati.submit();
		}

function VisualizzaAccount()
{
     var stringa='../../conguagli_cambi_tariffa/jsp/AccountCambiTariffaSp.jsp?cod_tipo_contr=<%=lstr_CodeTipoContratto%>&des_tipo_contr=<%=lstr_DescTipoContratto%>&strMessage=<%=strMessage%>';
     openDialog(stringa, 580, 380, handleReturnedValuePPAccount);
}
    
	</script>
</HEAD>
<BODY onload="initialize()">
	<form name="frmDati" action="LancioRepricing2Sp.jsp" method="post">
	<input type = "hidden" name = "intAction" value="<%=intAction%>">
	<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
	<%String strCodiceAccountRisultato="";
	for( i=0;i < lvct_AccountRisultato.size();i++){
		DB_Account lobjAppoAccount = new DB_Account();
		lobjAppoAccount = (DB_Account)lvct_AccountRisultato.elementAt(i);
		if(strCodiceAccountRisultato.equals("")){
			strCodiceAccountRisultato = lobjAppoAccount.getCODE_ACCOUNT() + "$" + lobjAppoAccount.getCODE_PARAM();
		}else{
			strCodiceAccountRisultato += "|" + lobjAppoAccount.getCODE_ACCOUNT() + "$" + lobjAppoAccount.getCODE_PARAM();
		}
	}
  %>
	<input type = "hidden" name = "hidViewState" value="<%=strCodiceAccountRisultato%>">
	<input type = "hidden" name = "codiceTipoContratto" value="<%=lstr_CodeTipoContratto%>">
	<input type = "hidden" name = "hidDescTipoContratto" value="<%=lstr_DescTipoContratto%>">
	<input type = "hidden" name = "hidStep" value="<%=intStepNow%>">
	<input type = "hidden" name = "hidTypeLoad" value="">
  <input type = "hidden" name = flagTipoContr id= flagTipoContr  value= "<%=flagTipoContr%>">
	<%

	//costruisce la stringa degli account da eliminare a partire dal vettore
	//restituito dai vari metodi	
	lstr_CodiciAccountDaEliminare = "";


 	if(!blnExit) 
  {
   if (intStepNow>gintStepElabBatchXlancio && lvct_AccountPagina!=null)
   {
		for(i = 0; i < lvct_AccountPagina.size(); i++)
    {	
			DB_Account lobj_Account=new DB_Account();
			lobj_Account=(DB_Account)lvct_AccountPagina.elementAt(i);
			if(lstr_CodiciAccountDaEliminare.equals(""))
      {
				lstr_CodiciAccountDaEliminare = lobj_Account.getCODE_ACCOUNT() + "$" + lobj_Account.getCODE_PARAM();
			}
      else
      {
				lstr_CodiciAccountDaEliminare += "|" + lobj_Account.getCODE_ACCOUNT() + "$" + lobj_Account.getCODE_PARAM();
			}
		}//for
   }//if 
	}//if
	%>
	<input type="hidden" name="hidCodiciAccountDaEliminare" value="<%=lstr_CodiciAccountDaEliminare%>">
</form>
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_CONGUAGLICAMBITARIFFA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
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