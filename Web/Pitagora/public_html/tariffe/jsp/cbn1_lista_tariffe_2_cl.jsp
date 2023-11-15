<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_tariffe_2_cl.jsp")%>
</logtag:logData>

<!-- insatnziazione dell'oggetto remoto  -->
<EJB:useHome id="homeEnt_Tariffe" type="com.ejbSTL.Ent_TariffeHome" location="Ent_Tariffe" />
<EJB:useBean id="remoteEnt_Tariffe" type="com.ejbSTL.Ent_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_Tariffe.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Tariffe" type="com.ejbSTL.Ctr_TariffeHome" location="Ctr_Tariffe" />
<EJB:useBean id="remoteCtr_Tariffe" type="com.ejbSTL.Ctr_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Tariffe.create()%>" />
</EJB:useBean>

<%!
//Oggetti riutilizzati nelle funzioni
HttpSession session=null;
HttpServletRequest request=null;
String str_CodeTipoCaus="";
String str_ImportoTariffa="";
String str_CodePrFascia="";
String str_CodePrTariffa = "";
String strCodeOggFatGlobal = "";
String strCodeOggFat="";
String strCodeClassOggFat="";
String str_CodeUtente="";
//per log
String strLogMessage = "";
int intNumMessage = 0;
String strParameterToLog = "";
//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
Vector lvct_Tariffe = null;
private void inizializeTariffeVector(HttpSession psession, 
                                     HttpServletRequest prequest, 
                                     String pstr_CodeTipoCaus) throws Exception{
    session = psession;
    request = prequest;
	
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	str_CodeUtente = objInfoUser.getUserName();
	
    str_CodeTipoCaus = pstr_CodeTipoCaus;
    String strCodeOggFatGlobal = request.getParameter("cboOggFat");
    //estrazione codice dell'oggetto fatturazione
    if(strCodeOggFatGlobal!=null){
		Vector vctOggFatt = Misc.split(strCodeOggFatGlobal,"$");
		strCodeOggFat = (String)vctOggFatt.elementAt(0);
		strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
    }
	//se txtImporto � NULL allora c'� pi� di una tariffa
    lvct_Tariffe = new Vector();
	for(int j=1;request.getParameter("txtImporto"+j)!=null;j++){
	    str_ImportoTariffa=request.getParameter("txtImporto"+j);
		str_CodePrFascia=request.getParameter("txtCodePrFascia"+j);
		str_CodePrTariffa = request.getParameter("campoPrTariffa"+j);
	    DB_Tariffe l_objTariffa = (DB_Tariffe)inizializeTariffaObject();
	    lvct_Tariffe.addElement(l_objTariffa);
    }
}
//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
private DB_Tariffe inizializeTariffaObject() throws Exception{
	DB_Tariffe lobj_Tariffe = new DB_Tariffe();
    
    lobj_Tariffe.setCODE_CLAS_SCONTO(Misc.nh(request.getParameter("cboClassiSconto")));
    lobj_Tariffe.setCODE_FASCIA(Misc.nh(request.getParameter("cboCodFascia")));
    lobj_Tariffe.setCODE_OGG_FATRZ(Misc.nh(strCodeOggFat));
	lobj_Tariffe.setCODE_PR_CLAS_SCONTO(request.getParameter("rdoClasse"));
    lobj_Tariffe.setCODE_PR_FASCIA(Misc.nh(str_CodePrFascia));
    lobj_Tariffe.setCODE_PR_PS_PA_CONTR(Misc.nh(request.getParameter("CODE_PR_PS_PA_CONTR")));
    lobj_Tariffe.setCODE_PR_TARIFFA(Misc.nh(str_CodePrTariffa));//inserito dalla classe di controllo in fase di inserimento
    lobj_Tariffe.setCODE_TARIFFA(Misc.nh(request.getParameter("campoTipoTariffa")));//inserito dalla classe di controllo in fase di inserimento
    lobj_Tariffe.setCODE_TIPO_CAUS(Misc.nh(str_CodeTipoCaus));
    lobj_Tariffe.setCODE_TIPO_OFF(Misc.nh(request.getParameter("cboTipoOfferta")));
    lobj_Tariffe.setCODE_UNITA_MISURA(Misc.nh(request.getParameter("cboUnitaMisura")));
    lobj_Tariffe.setCODE_UTENTE(str_CodeUtente);
    lobj_Tariffe.setDATA_CREAZ_MODIF(Misc.nh(request.getParameter("hidData_Creaz_Modifica")));//sysdate da SP in fase di inserimento
    lobj_Tariffe.setDATA_CREAZ_TARIFFA(Misc.nh(request.getParameter("DataCreazioneTariffa")));//sysdate da SP in fase di inserimento
    lobj_Tariffe.setDATA_FINE_TARIFFA(Misc.nh(request.getParameter("hidData_Fine_Tariffa")));
    lobj_Tariffe.setDATA_INIZIO_TARIFFA(Misc.nh(request.getParameter("txtDataInizioValidita")));//!!!!
	lobj_Tariffe.setDATA_INIZIO_TARIFFA_OLD(Misc.nh(request.getParameter("hidDataInizioValiditaOld")));
    lobj_Tariffe.setDATA_INIZIO_VALID_OF(Misc.nh(request.getParameter("DATA_INIZIO_VALID_OF")));
    lobj_Tariffe.setDATA_INIZIO_VALID_OF_PS(Misc.nh(request.getParameter("DATA_INIZIO_VALID_OF_PS")));
    lobj_Tariffe.setDESC_TARIFFA(Misc.nh(request.getParameter("txtDescrizioneTariffa")));
    lobj_Tariffe.setDESC_TIPO_OFF("");
    lobj_Tariffe.setIMPT_MAX_SPESA("");
    lobj_Tariffe.setIMPT_MIN_SPESA("");
    lobj_Tariffe.setIMPT_TARIFFA(CustomNumberFormat.getFromNumberFormat(Misc.nh(str_ImportoTariffa)));
    lobj_Tariffe.setTIPO_FLAG_CONG_REPR(Misc.nh(request.getParameter("hidFlag_Cong_Repr")));//N in fase di inserimento
    lobj_Tariffe.setTIPO_FLAG_MODAL_APPL_TARIFFA(request.getParameter("rdoTipoImporto"));
    lobj_Tariffe.setTIPO_FLAG_PROVVISORIA(Misc.nh(request.getParameter("hidTipo_Flag_Provvisoria")));
    lobj_Tariffe.setVALO_LIM_MAX("");
    lobj_Tariffe.setVALO_LIM_MIN("");
	lobj_Tariffe.setCODE_TIPO_CONTR(request.getParameter("codiceTipoContratto"));
	lobj_Tariffe.setCODE_CONTR(request.getParameter("cboContratto"));
	lobj_Tariffe.setCODE_PS(request.getParameter("PsSel"));
	lobj_Tariffe.setCODE_PREST_AGG(request.getParameter("cboPrestAgg"));
	lobj_Tariffe.setCODE_TIPO_CAUS(request.getParameter("cboTipoCaus"));
    
		Vector vctOggFatt = Misc.split(request.getParameter("cboOggFat"),"$");
		String strCodeOggFat = (String)vctOggFatt.elementAt(0);
		String strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
	lobj_Tariffe.setCODE_OGG_FATRZ(strCodeOggFat);

    return lobj_Tariffe;
}

//FUNZIONI PER INSERIMENTO TARIFFE
private String InsertTariffa(com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    String lstr_Msg = "";
    lstr_Msg = remoteCtr_Tariffe.insTariffa(lvct_Tariffe);
    return lstr_Msg;
}
//FUNZIONI PER UPDATE TARIFFE
private String UpdateTariffa(com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    String lstr_Msg = "";
	lstr_Msg = remoteCtr_Tariffe.updTariffa(lvct_Tariffe);
	return lstr_Msg;
}
//FUNZIONI DELETE TARIFFE
private String DeleteTariffa(com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    String lstr_Msg = "";
	lstr_Msg = remoteCtr_Tariffe.delTariffa(lvct_Tariffe);
	return lstr_Msg;
}
%>
<%

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
%>
<%  
//RICEZIONE DESCRIZIONI DAL VIEWSTATE
String strViewState = request.getParameter("viewState");
String strDescTipoContratto=Misc.getParameterValue(strViewState,"vsDescTipoContratto");
String strDescCliente=Misc.getParameterValue(strViewState,"vsDescCliente");
String strDescContratto=Misc.getParameterValue(strViewState,"vsDescContratto");
String strDescPS=Misc.getParameterValue(strViewState,"vsDescPS");
String strDescPrestAgg=Misc.getParameterValue(strViewState,"vsDescPrestAgg");
String strDescOggFatt=Misc.getParameterValue(strViewState,"vsDescOggFatt");
String strDescTipoCaus=Misc.getParameterValue(strViewState,"vsDescTipoCaus");
//FINE RICEZIONE DESCRIZIONI DAL VIEWSTATE

//dichiarazione variabili
int i=0;
String bgcolor = "";
Vector vctTariffeVector = null;
String strChecked = ""; 
// recupero i parametri provanienti dalla pagina di ricerca
String strCodeContr = request.getParameter("cboContratto");
String strCodePrestAgg = "";
String strCODE_PR_PS_PA_CONTR = "";
//estrazione della prestzione aggiuntiva e del code_pr_ps_pa_contr
strCodePrestAgg = Misc.nh(request.getParameter("cboPrestAgg"));
String strCodePs = request.getParameter("PsSel");
String strCodeOggFatGlobal = request.getParameter("cboOggFat");
//estrazione codice dell'oggetto fatturazione
String strCodeOggFat="";
String strCodeClassOggFat="";
//estrazione codice dell'oggetto fatturazione
if(strCodeOggFatGlobal!=null){
	Vector vctOggFatt = Misc.split(strCodeOggFatGlobal,"$");
	strCodeOggFat = (String)vctOggFatt.elementAt(0);
	strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
}

String strCodeTipoCaus = request.getParameter("cboTipoCaus");
String strCodeTariffa = request.getParameter("campoTipoTariffa");
String strCodePrTariffa = request.getParameter("campoPrTariffa1");
String strDataCreazioneTariffa = request.getParameter("DataCreazioneTariffa");%>
<HTML>
<HEAD>

    <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
    <!--<SCRIPT LANGUAGE="JavaScript" SRC="../script/security.js"></SCRIPT>-->
    <TITLE>Selezione Clienti</TITLE>
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
		}
		
    //modifiche fabio del 27-04-2004 - inizio
		function ONCHIUDI()
		{
      window.close();
		}
    //modifiche fabio del 27-04-2004 - fine

    function ONDETTAGLIO()
    {
      var strURL="cbn1_lista_tariffe_3_cl.jsp"
      strURL+="?codeTariffa=" + getRadioButtonValue(objForm.campoTipoTariffa)
      //modifiche fabio del 27-04-2004 - inizio
      openDialog2(strURL, 650, 200, handleReturnedValuePP);
      //modifiche fabio del 27-04-2004 - inizio
    }
		
		function handleReturnedValuePP()
		{}
		function ONVISUALIZZA()
		{
			var intIndex = getRadioButtonIndex(objForm.campoTipoTariffa);
			if(intIndex == -1){
				objForm.DataCreazioneTariffa.value = objForm.txtHIDDataCreazioneTariffa.value;
			}else{
				objForm.DataCreazioneTariffa.value = objForm.txtHIDDataCreazioneTariffa[intIndex].value;
			}
			objForm.txtAction.value="VIS";
			objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_modifica_tariffe_cl.jsp";
			objForm.submit();
		}
		function ONAGGIORNAELIMINA(){
			var intIndex = getRadioButtonIndex(objForm.campoTipoTariffa);
			if(intIndex == -1){
				objForm.DataCreazioneTariffa.value = objForm.txtHIDDataCreazioneTariffa.value;
			}else{
				objForm.DataCreazioneTariffa.value = objForm.txtHIDDataCreazioneTariffa[intIndex].value;
			}
			objForm.txtAction.value="UPD";
			objForm.action="<%=StaticContext.PH_TARIFFE_JSP%>cbn1_modifica_tariffe_cl.jsp";
			objForm.submit();
		}
    </SCRIPT>
</HEAD>
<BODY onload="initialize()">
    <form name="frmDati" method="post" action=''>
            <!-- campi hidden per il passaggio dei valori quando viene richiesto il dettaglio -->
			<input type = "hidden" name = "codiceTipoContratto" value = "<%= request.getParameter("codiceTipoContratto") %>">
            <input type = "hidden" name = "cboContratto" value = "<%= strCodeContr %>">
            <input type = "hidden" name = "cboPrestAgg" value = "<%= Misc.nh(request.getParameter("cboPrestAgg")) %>">
            <input type = "hidden" name = "PsSel" value = "<%= strCodePs %>">
            <input type = "hidden" name = "cboOggFat" value = "<%= strCodeOggFatGlobal %>">
            <input type = "hidden" name = "cboTipoCaus" value = "<%= strCodeTipoCaus %>">
            <input type = "hidden" name = "CODE_PR_PS_PA_CONTR" value = "<%= Misc.nh(request.getParameter("CODE_PR_PS_PA_CONTR"))%>">
            <input type = "hidden" name = "DATA_INIZIO_VALID_OF" value = "<%= Misc.nh(request.getParameter("DATA_INIZIO_VALID_OF"))%>">
            <input type = "hidden" name = "DATA_INIZIO_VALID_OF_PS" value = "<%= Misc.nh(request.getParameter("DATA_INIZIO_VALID_OF_PS"))%>">
            <input type = "hidden" name = "DataCreazioneTariffa" value="">
			<input type = "hidden" name = "txtAction" value="">
            <input type = "hidden" name = "viewState" value="<%=strViewState%>">
			<input type = "hidden" name = "hidTypeLoad" value="">
<%//OPERAZIONI DA ESEGUIRE
if(request.getParameter("txtOperazione")!=null){
    
	int lint_Operazione = Integer.parseInt(request.getParameter("txtOperazione"));
	String lstr_Message="";
    switch (lint_Operazione){
		case StaticContext.INSERT:
			inizializeTariffeVector(session,
		                            request,
		                            strCodeTipoCaus);%>
			<% strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe);
			   strLogMessage = "remoteCtr_Tariffe.insTariffa(" + strParameterToLog  + ")";
			   intNumMessage = 3503;
			%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
			</logtag:logData>						
			<%lstr_Message = InsertTariffa(remoteCtr_Tariffe);
		break;
		case StaticContext.UPDATE:
			inizializeTariffeVector(session,
		                            request,
		                            strCodeTipoCaus);%>
			<%  strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe);
				strLogMessage = "remoteCtr_Tariffe.updTariffa(" + strParameterToLog  + ")";
		   	   intNumMessage = 3504;
			%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
			</logtag:logData>						
			<%lstr_Message = UpdateTariffa(remoteCtr_Tariffe);
			break;
		case StaticContext.DELETE:
			inizializeTariffeVector(session,
		                            request,
		                            strCodeTipoCaus);%>
			<%  strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe);
				strLogMessage = "remoteCtr_Tariffe.delTariffa(" + strParameterToLog  + ")";
		   	   intNumMessage = 3505;
			%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
			</logtag:logData>						
			<%lstr_Message = DeleteTariffa(remoteCtr_Tariffe);
		break;
	}
	if(lstr_Message.equals(""))
	{
		strLogMessage += ": Success"; 
	}
	else
	{
		strLogMessage += ": " + lstr_Message; 
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
   </logtag:logData>
   <%
   	  //mostra il messaggio di errore
	  if(!lstr_Message.equals("")){
	    String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(lstr_Message,com.utl.StaticContext.ENCCharset); 
      strUrl += "&CHIUDI=true";
		response.sendRedirect(strUrl);
	  }
   %>
<%
}%>
<!-- visualizzazione delle descrizioni  -->
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Tariffe</td>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	  <tr>
         <td colspan="4" class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
		 	Risultati per pag.:&nbsp;
			<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_lista_tariffe_2_cl.jsp');">
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
      </tr>
      <tr>
        <td  width='15%' class="textB" align="right" valign="top">Cliente:&nbsp;</td>
        <td  width='35%' class="text" valign="top">
         	<%=strDescCliente%>
        </td>
        <td  width='20%'class="textB" align="right" valign="top">Contratto:&nbsp;</td>
        <td  width='30%'class="text" valign="top">
          <%=strDescContratto%>
        </td>
      </tr>
      <tr>
        <td class="textB" align="right" valign="top">P/S:&nbsp;</td>
        <td class="text" valign="top">
          <%=strDescPS%>
        </td>
        <td class="textB" align="right">Prest. Agg.:&nbsp;</td>
        <td class="text">
           <%=strDescPrestAgg%>
        </td>
      </tr>
      <tr>
        <td class="textB" align="right" valign="top">Ogg. Fat.:&nbsp;</td>
        <td class="text" valign="top">
         <%=strDescOggFatt%>
        </td>
        <td class="textB" align="right">Tipo Causale:&nbsp;</td>
        <td class="text">
           <%=strDescTipoCaus%>
        </td>
      </tr>
    </table>
    </td>
  </tr>
</table>		
<!--TITOLO PAGINA-->			
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
</table>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
				<td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dettaglio</td>
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
        <CENTER>
		<table width="90%" border="0" cellspacing="1" cellpadding="1" align="center">
			<tr>
				<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Offerta</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Cl.Sc.</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Cl.Sc.</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo Tar.</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Fascia</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Fascia</td>
	            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Importo</td>
			</tr>
        	<%//se � stata effettuata una ricerca
			 if(strCodeContr != null){
			 	//invoca il metodo per reperire la lista delle tariffe
				vctTariffeVector = null;
				  if (strtypeLoad.equals("1")) //paginazione
				  {
					vctTariffeVector = (Vector) session.getAttribute("vctTariffeVector");
				  }
				  else //query
				  {
					 vctTariffeVector = remoteEnt_Tariffe.getListaTariffe(StaticContext.LIST,
                                                                    strCodeContr,
                                                                    strCodePs,
                                                                    strCodePrestAgg,
                                                                    strCodeTipoCaus,
                                                                    strCodeOggFat);
					if (vctTariffeVector != null)
					  session.setAttribute("vctTariffeVector", vctTariffeVector);
				  }
					intRecTotali = vctTariffeVector.size();
			 }%>
			<%                                               
            // se il vettore � stato caricato si prosegue con il caricamento della lista
			String strPopolamento="S";
            if ((vctTariffeVector==null)||(vctTariffeVector.size()==0)){
				strPopolamento="N";%>
			  	<tr>
			  		<td class="text" colspan="10" align="center">
						&nbsp;<BR>no record found
					</td>
			  	</tr>
			  	<%
             }else{
			 		%>
			 	<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
			  	<%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++){	
	                DB_Tariffe lobj_Tariffa = new DB_Tariffe();
	                lobj_Tariffa = (DB_Tariffe)vctTariffeVector.elementAt(i);
	                 // permette di selezionare per default il primo radio button
	                 if (i == ((pagerPageNumber.intValue()-1)*intRecXPag))
	                    strChecked = "checked";
	                 else
                    	strChecked = "";
                 	//seleziono il check che mi arriva dal submit precedente
                	/*if(request.getParameter("campoTipoTariffa")!=null){
                    	if(request.getParameter("campoTipoTariffa").equalsIgnoreCase(lobj_Tariffa.getCODE_TARIFFA())){
                        	strChecked = "checked";
                    	}else{
                        	strChecked = "";
                    	}
                	}*/
                 	//verifica se il numero di riga � pari o dispari per la colorazione delle righe   
                 	if ((i%2)==0)
                   		bgcolor=StaticContext.bgColorRigaPariTabella;
                	else
                   		bgcolor=StaticContext.bgColorRigaDispariTabella;%>
					<tr>
						<td class='text' bgcolor='<%=bgcolor%>'>
		                	<input type='radio' <%= strChecked %> name='campoTipoTariffa' value='<%=lobj_Tariffa.getCODE_TARIFFA()%>'>
							<input type="hidden" name="txtHIDDataCreazioneTariffa" value="<%=lobj_Tariffa.getDATA_CREAZ_TARIFFA()%>">
		                </td>
		                <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getDESC_TIPO_OFF()%></td>
		                <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MIN_SPESA())%></td>
		                <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MAX_SPESA())%></td>
		                <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_TARIFFA())%></td>
		                <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MIN()%></td>
		                <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MAX()%></td>
		                <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getTIPO_FLAG_MODAL_APPL_TARIFFA()%></td>
                  	</tr>
                 	<%
                }%>
				<tr>
					<td colspan="8" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
						<!--paginatore-->
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
        </CENTER>
	</td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  	<td class="textB" colspan="8" align="right" width="100%">
    	<!-- pulsantiera -->
		<sec:ShowButtons td_class="textB"/>
		<%if(strPopolamento.equals("N")){%>
			<script language="javascript">
				var objForm = document.frmDati;
				Disable(objForm.DETTAGLIO);
				Disable(objForm.VISUALIZZA);
				Disable(objForm.AGGIORNA_ELIMINA);
			</script>
		<%}%>
	</td>
  </tr>
  <tr>
  	<td>&nbsp;</td>
  </tr>
</table>
</form>
</BODY>
</HTML>