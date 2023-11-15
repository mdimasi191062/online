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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_itc_3_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->

<EJB:useHome id="homeCtr_Tariffe" type="com.ejbSTL.Ctr_TariffeHome" location="Ctr_Tariffe" />
<EJB:useBean id="remoteCtr_Tariffe" type="com.ejbSTL.Ctr_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Tariffe.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>


<%
Vector lvct_ContrattiEsistenti = new Vector();
boolean lbln_Redirect = false;
boolean blnCHKCONTRATTI = Misc.bh(request.getParameter("CHKCONTRATTI"));
String strBgColor="";
String appoViewState = Misc.nh(request.getParameter("hidViewState"));
String strCODE_ACCOUNT_ESISTENTI = Misc.nh(request.getParameter("txtCODE_ACCOUNT_ESISTENTI"));
String strDESCTIPOLOGIACONTRATTO = "INTERCONNESSIONE";
%>
<%!
//Oggetti riutilizzati nelle funzioni
HttpSession session=null;
HttpServletRequest request=null;
//codici
String strCodeOggFatt = "";
String strCodiciTipiCausali = "";

String strCodeClassSconto = "";
String strCodeFascia = "";
String strCodePrClassSconto = "";
String strCodeTipoOfferta = "";
String strCodeUnitaMisura = "";
String strCodeTipoContratto = "";
String strCodePrestAgg = "";

//date
String strDataInizioValidita = "";

//descrizioni
String strDescTariffa = "";

String strCodeTipoImporto = "";
String strCodePs = "";

//importi
String strImportiFasceKm = "";
String strContributoFriaco = "";
String strCanonePorta = "";
String strAccessoCanoneFriaco = "";

String strAppoImporto = "";
String strCodePrFascia = "";
String strCodeUtente="";

String strPageAction = "";
String strTitoloPagina = "";
 
//per log
String strLogMessage = "";
int intNumMessage = 0;
String strParameterToLog = "";

//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
Vector lvct_Tariffe = null;
private void inizializeTariffeVector(HttpSession psession, 
                                     HttpServletRequest prequest) throws Exception{
    session = psession;
    request = prequest;
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	strCodeUtente = objInfoUser.getUserName();
	//se txtImporto � NULL allora c'� pi� di una tariffa
    lvct_Tariffe = new Vector();
    String strAppo = "";
    String strViewState = "";

	
	Vector vctImportiFasceKm = null;
    DB_Tariffe l_objTariffa = null;
    int j;

    // reperimento dei parametri dal viewState
	strViewState = Misc.nh(request.getParameter("hidViewState"));

	strCodeOggFatt = Misc.getParameterValue(strViewState,"vsCodeOggFatt");
	strCodiciTipiCausali = Misc.getParameterValue(strViewState,"vsCodiciTipiCausali");
	strCodeUnitaMisura = Misc.getParameterValue(strViewState,"vsCodeUnitaMisura");
	strCodeTipoContratto = Misc.getParameterValue(strViewState,"vsCodeTipoContratto");
	strCodePrestAgg = Misc.getParameterValue(strViewState,"vsCodePrestAgg");

	strCodePs = Misc.getParameterValue(strViewState,"vsCodePs");

	
	//strCodeClassOggFatt =  Misc.getParameterValue(strViewState,"vsCodeClassOggFatt");
	//strCodeClassPs = Misc.getParameterValue(strViewState,"vsCodeClassPs");
	//strCodeTipoOfferta = Misc.getParameterValue(strViewState,"vsCodeTipoOfferta");
	strCodeTipoImporto = Misc.getParameterValue(strViewState,"vsCodeTipoImporto");

	//strDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
	//strDescTipiCausali = Misc.getParameterValue(strViewState,"vsDescTipiCausali");
	//strDescPs = Misc.getParameterValue(strViewState,"vsDescPs");
	//strDescPrestAgg = Misc.getParameterValue(strViewState,"vsDescPrestAgg");
	//strDescOggFatt = Misc.getParameterValue(strViewState,"vsDescOggFatt");
	strDescTariffa = Misc.getParameterValue(strViewState,"vsDescrizioneTariffa");
	strDataInizioValidita = Misc.getParameterValue(strViewState,"vsDataInizioValidita");
	strImportiFasceKm = Misc.getParameterValue(strViewState,"vsImporti");
	strContributoFriaco = Misc.getParameterValue(strViewState,"vsContributoFriaco");
	strCanonePorta = Misc.getParameterValue(strViewState,"vsCanonePorta");
	strAccessoCanoneFriaco = Misc.getParameterValue(strViewState,"vsAccessoCanoneFriaco");
	//determina l'azione da eseguire inserimento/modifica
	strPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	
	strCodeFascia = "";
    strCodePrFascia = "";
    strCodeClassSconto = "";
    strCodePrClassSconto = "";

	if(!strImportiFasceKm.equals("$$$")){ //Importi fasce
		vctImportiFasceKm = Misc.split(strImportiFasceKm,"$");
		for (j=0;j < vctImportiFasceKm.size();j++)
		{
			strAppoImporto = (String)vctImportiFasceKm.elementAt(j);
            strCodeFascia = "4"; 
			l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,Integer.toString(j+1));
            lvct_Tariffe.addElement(l_objTariffa);
		}
	}

	if(!strContributoFriaco.equals("")){ //Contributi Friaco
		strAppoImporto = strContributoFriaco;
        strCodeFascia = "";
		l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,"");
        lvct_Tariffe.addElement(l_objTariffa);
	}	

	if(!strCanonePorta.equals("")){ //Canone porta
		strAppoImporto = strCanonePorta;
        strCodeFascia = "";
		l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,"");
        lvct_Tariffe.addElement(l_objTariffa);
	}	

	if(!strAccessoCanoneFriaco.equals("")){ //Contributi Friaco
		strAppoImporto = strAccessoCanoneFriaco;
        strCodeFascia = "";
		l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,"");
        lvct_Tariffe.addElement(l_objTariffa);
	}
}

//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
private DB_Tariffe inizializeTariffaObject(String p_strImporto,String p_strCodePrFascia) throws Exception{
	DB_Tariffe lobj_Tariffe = new DB_Tariffe();
    lobj_Tariffe.setCODE_FASCIA(strCodeFascia);
	lobj_Tariffe.setCODE_PR_FASCIA(p_strCodePrFascia);
    lobj_Tariffe.setCODE_OGG_FATRZ(strCodeOggFatt);
    lobj_Tariffe.setCODE_TIPO_CAUS(strCodiciTipiCausali);
    lobj_Tariffe.setCODE_UNITA_MISURA(strCodeUnitaMisura);
    lobj_Tariffe.setCODE_TIPO_CONTR(strCodeTipoContratto);
	lobj_Tariffe.setCODE_PS(strCodePs); //code ps figlio
	lobj_Tariffe.setCODE_PREST_AGG(strCodePrestAgg);
    lobj_Tariffe.setCODE_UTENTE(strCodeUtente);
    lobj_Tariffe.setDATA_INIZIO_TARIFFA(strDataInizioValidita);
    lobj_Tariffe.setDESC_TARIFFA(strDescTariffa);
    lobj_Tariffe.setIMPT_TARIFFA(CustomNumberFormat.getFromNumberFormat(p_strImporto));
    lobj_Tariffe.setTIPO_FLAG_MODAL_APPL_TARIFFA(strCodeTipoImporto);

    //lobj_Tariffe.setCODE_CLAS_SCONTO(strCodeClassSconto);
	//lobj_Tariffe.setCODE_PR_CLAS_SCONTO(strCodePrClassSconto);
    //lobj_Tariffe.setCODE_TIPO_OFF(strCodeTipoOfferta);

    return lobj_Tariffe;
}

//FUNZIONI PER INSERIMENTO TARIFFE
	private String InsertTariffa(String pstrCODE_ACCOUNT_ESISTENTI, com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    	String lstr_Msg = "";
    	lstr_Msg = remoteCtr_Tariffe.insTariffaXTipoContr(pstrCODE_ACCOUNT_ESISTENTI, lvct_Tariffe);
    	return lstr_Msg;
	}
	//FUNZIONI PER UPDATE TARIFFE
	private String UpdateTariffa(com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
	    String lstr_Msg = "";
		lstr_Msg = remoteCtr_Tariffe.updTariffaXTipoContr(lvct_Tariffe);
		return lstr_Msg;
	}
%>

<%
	String lstr_Message = "";
	String strMsgOutput = "";
	inizializeTariffeVector(session,
	                         request);
							 
							 
  if(strPageAction.equals("INS"))
  {
  	strTitoloPagina = "INSERIMENTO";%>
	<%
	//CHK CONTRATTI Esistenti.
	if(!blnCHKCONTRATTI){
		lvct_ContrattiEsistenti = (Vector) remoteEnt_Contratti.getAccountEsistenti((DB_Tariffe)lvct_Tariffe.elementAt(0));
	}
	if(lvct_ContrattiEsistenti.size() > 0){
		lbln_Redirect = false;
	}else{
		lbln_Redirect = true;%>
		<%
		strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe); 
		strLogMessage = "remoteCtr_Tariffe.insTariffaXTipoContr(" + strCODE_ACCOUNT_ESISTENTI + ", " + strParameterToLog  + ")";
		intNumMessage = 3503;
		%>
		<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
				<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
		</logtag:logData>
	  	<%lstr_Message = InsertTariffa(strCODE_ACCOUNT_ESISTENTI,remoteCtr_Tariffe);
	}
  }
  if(strPageAction.equals("UPD"))
  {
  	lbln_Redirect = true;
  	strTitoloPagina = "MODIFICA";%>
	<%  strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe);
		strLogMessage = "remoteCtr_Tariffe.updTariffaXTipoContr(" + strParameterToLog  + ")";
		intNumMessage = 3504;
	%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
	</logtag:logData>
  	<%lstr_Message=UpdateTariffa(remoteCtr_Tariffe);
  }
  
  if(lstr_Message.equals("")){
	strMsgOutput = "Elaborazione terminata correttamente!!";
	strLogMessage += ": Success";  
  }else{
  	strMsgOutput = lstr_Message;
	strLogMessage += ": " + lstr_Message; 
  }%>
   <logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
   </logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset) + "&CHIUDI=true"; 
	if(lbln_Redirect){
		response.sendRedirect(strUrl);
	}else{%>
	<%
	//COSTRUZIONE VETTORE CON I CONTRATTI Esistenti!%>
	<html>
		<head>
			<title></title>
			<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
			<script>
				var objForm = null;
				function initialize()
				{
					objForm = document.frmDati;
				}
				function ONCONTINUA(){
					strURL = "cbn1_ins_tar_x_tipol_contr_itc_3_cl.jsp";
					strURL +="?CHKCONTRATTI=true";
					objForm.action = strURL;
					objForm.submit();
				}
				function ONANNULLA(){
					/*strURL = "SwitchInserimentoXTipologia_cl.jsp";
					strURL += "?codiceTipoContratto=<%=strCodeTipoContratto%>";
					strURL += "&intAction=<%=StaticContext.INSERT%>";
					strURL += "&hidDescTipoContratto=<%=strDESCTIPOLOGIACONTRATTO%>";
					objForm.action = strURL;
					objForm.submit();*/
          window.close();
				}
			</script>
		</head>
		<BODY onload="initialize()">
			<form name="frmDati" method="post" action=''>
			<input type="hidden" name="hidViewState" value="<%=appoViewState%>">
				<!-- Immagine Titolo -->
				<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td align="left"><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
				  <tr>
				</table>
				
				<!--TITOLO PAGINA-->
				<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
					<tr>
						<td>
						 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
							<tr>
							  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO <%=strDESCTIPOLOGIACONTRATTO%></td>
							  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
							</tr>
						 </table>
						</td>
					</tr>
				</table>
				<br>
				<!-- <table width="50%" border="0" bgcolor="<%=StaticContext.bgColorHeader%>" cellspacing="0" cellpadding="0" align='center'>
               	<tr>
                   <td> -->
                       <table align="center" width="50%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                           <tr>
                               <td>
                                   <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                                       <tr>
                                           <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Per i seguenti Account � gi� presente la Struttura Tariffaria</td>
                                           <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                                       </tr>
                                   </table>
                              </td>
                           </tr>
                           <tr>
							<td>
								<table width="100%" border="0" bordercolor="red" cellspacing="0" cellpadding="0" align='center'>
									<tr>
										<!-- <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Account</td> -->
										<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione Account</td>
									</tr>
									<%strCODE_ACCOUNT_ESISTENTI = "";%>
									<%for (int i=0;i < lvct_ContrattiEsistenti.size();i++){
								        DB_Account objDB_Account = new DB_Account();
								        objDB_Account=(DB_Account)lvct_ContrattiEsistenti.elementAt(i);
										if ((i%2)==0){
								          strBgColor=StaticContext.bgColorRigaPariTabella;
								        }else{
								          strBgColor=StaticContext.bgColorRigaDispariTabella;
										}
										if(strCODE_ACCOUNT_ESISTENTI.equals(""))
											strCODE_ACCOUNT_ESISTENTI = objDB_Account.getCODE_ACCOUNT();
										else
											strCODE_ACCOUNT_ESISTENTI += "*" + objDB_Account.getCODE_ACCOUNT();
										%>
										<tr>
											<!-- <td bgcolor='<%=strBgColor%>' class='textNumber'>&nbsp;<%=objDB_Account.getCODE_ACCOUNT()%></td> -->
											<td bgcolor='<%=strBgColor%>' class='text'>&nbsp;<%=objDB_Account.getDESC_ACCOUNT()%></td>
										</tr>
									<%}%>
								</table>
							</td>
						</tr>
					</table>
					<!-- </td>
					</tr>
				</table> -->
				<br>
				<center>
					<font class="text">
						Conferma per proseguire escludendo gli account individuati.<br>
						Annulla per Interrompere l'inserimento della struttura tariffaria.
					</font>
				</center>
				<br>
				<table width="95%" border="0" cellspacing="0" cellpadding="0" align='center'>
					<tr>
						<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
							<sec:ShowButtons td_class="textB"/>
						</td>
					</tr>
				</table>
				<input type="hidden" name="txtCODE_ACCOUNT_ESISTENTI" value="<%=strCODE_ACCOUNT_ESISTENTI%>">
			</form>
		</body>
	</html>
	<%
	}
	%>
