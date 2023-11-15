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
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_canc_tar_X_tipol_contr_3_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Tariffe" type="com.ejbSTL.Ctr_TariffeHome" location="Ctr_Tariffe" />
<EJB:useBean id="remoteCtr_Tariffe" type="com.ejbSTL.Ctr_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Tariffe.create()%>" />
</EJB:useBean>
<%!
//Oggetti riutilizzati nelle funzioni
HttpSession session=null;
HttpServletRequest request=null;
String str_ImportoTariffa="";
String str_CodePrFascia="";
String str_CodePrTariffa = "";
String strCodeOggFatGlobal = "";
String strCodeOggFat="";
String strCodeClassOggFat="";
String strCodeUtente = "";
//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
//Vector lvct_Tariffe = null;
DB_Tariffe l_objTariffa = new DB_Tariffe();
private void inizializeTariffe(HttpSession psession, 
                                     HttpServletRequest prequest) throws Exception{
    session = psession;
    request = prequest;
    String strCodeOggFatGlobal = request.getParameter("cboOggFat");
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	strCodeUtente = objInfoUser.getUserName();
    //estrazione codice dell'oggetto fatturazione
    if(strCodeOggFatGlobal!=null){
		Vector vctOggFatt = Misc.split(strCodeOggFatGlobal,"$");
		strCodeOggFat = (String)vctOggFatt.elementAt(0);
		strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
    }
	l_objTariffa.setCODE_CLAS_SCONTO(Misc.nh(request.getParameter("cboClassiSconto")));
    l_objTariffa.setCODE_FASCIA(Misc.nh(request.getParameter("cboCodFascia")));
    l_objTariffa.setCODE_OGG_FATRZ(Misc.nh(strCodeOggFat));
	l_objTariffa.setCODE_PR_CLAS_SCONTO(request.getParameter("rdoClasse"));
    l_objTariffa.setCODE_PR_FASCIA("");//Misc.nh(str_CodePrFascia)
    l_objTariffa.setCODE_PR_PS_PA_CONTR(Misc.nh(request.getParameter("CODE_PR_PS_PA_CONTR")));
    l_objTariffa.setCODE_PR_TARIFFA("");//Misc.nh(str_CodePrTariffa)
    l_objTariffa.setCODE_TARIFFA(Misc.nh(request.getParameter("campoTipoTariffa")));
    l_objTariffa.setCODE_TIPO_CAUS(Misc.nh(request.getParameter("cboTipoCaus")));
    l_objTariffa.setCODE_TIPO_OFF(Misc.nh(request.getParameter("cboTipoOfferta")));
    l_objTariffa.setCODE_UNITA_MISURA(Misc.nh(request.getParameter("cboUnitaMisura")));
    l_objTariffa.setCODE_UTENTE(strCodeUtente);
    l_objTariffa.setDATA_CREAZ_MODIF(Misc.nh(request.getParameter("hidData_Creaz_Modifica")));//sysdate da SP in fase di inserimento
    l_objTariffa.setDATA_CREAZ_TARIFFA(Misc.nh(request.getParameter("DataCreazioneTariffa")));//sysdate da SP in fase di inserimento
    l_objTariffa.setDATA_FINE_TARIFFA(Misc.nh(request.getParameter("hidData_Fine_Tariffa")));
    l_objTariffa.setDATA_INIZIO_TARIFFA(Misc.nh(request.getParameter("txtDataInizioValidita")));//!!!!
	l_objTariffa.setDATA_INIZIO_TARIFFA_OLD(Misc.nh(request.getParameter("hidDataInizioValiditaOld")));
    l_objTariffa.setDATA_INIZIO_VALID_OF(Misc.nh(request.getParameter("DATA_INIZIO_VALID_OF")));
    l_objTariffa.setDATA_INIZIO_VALID_OF_PS(Misc.nh(request.getParameter("DATA_INIZIO_VALID_OF_PS")));
    l_objTariffa.setDESC_TARIFFA("");//Misc.nh(request.getParameter("txtDescrizioneTariffa"))
    l_objTariffa.setDESC_TIPO_OFF("");
    l_objTariffa.setIMPT_MAX_SPESA("");
    l_objTariffa.setIMPT_MIN_SPESA("");
    l_objTariffa.setIMPT_TARIFFA("");//CustomNumberFormat.getFromNumberFormat(Misc.nh(str_ImportoTariffa))
    l_objTariffa.setTIPO_FLAG_CONG_REPR(Misc.nh(request.getParameter("hidFlag_Cong_Repr")));//N in fase di inserimento
    l_objTariffa.setTIPO_FLAG_MODAL_APPL_TARIFFA(request.getParameter("rdoTipoImporto"));
    l_objTariffa.setTIPO_FLAG_PROVVISORIA(Misc.nh(request.getParameter("hidTipo_Flag_Provvisoria")));
    l_objTariffa.setVALO_LIM_MAX("");
    l_objTariffa.setVALO_LIM_MIN("");
	l_objTariffa.setCODE_TIPO_CONTR(request.getParameter("codiceTipoContratto"));
	l_objTariffa.setCODE_CONTR(request.getParameter("cboContratto"));
	l_objTariffa.setCODE_PS(request.getParameter("PsSel"));
	l_objTariffa.setCODE_PREST_AGG(request.getParameter("cboPrestAgg"));
	l_objTariffa.setCODE_TIPO_CAUS(request.getParameter("cboTipoCaus"));
    
		Vector vctOggFatt = Misc.split(request.getParameter("cboOggFat"),"$");
		String strCodeOggFat = (String)vctOggFatt.elementAt(0);
		String strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
	l_objTariffa.setCODE_OGG_FATRZ(strCodeOggFat);
    
}

//FUNZIONI PER ELIMINAZIONE TARIFFE
private String DeleteTariffa(com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    String lstr_Msg = "";
    lstr_Msg = remoteCtr_Tariffe.delTariffaXTipoContr(l_objTariffa);
    return lstr_Msg;
}
%>

<%

    String lstr_Message = "";
	String strMsgOutput = "";
    inizializeTariffe(session,request);%>
	<% String strLogMessage = "remoteCtr_Tariffe.delTariffaXTipoContr(" + l_objTariffa.FieldsToString()  + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3505,strLogMessage)%>
	</logtag:logData>
	<%lstr_Message = DeleteTariffa(remoteCtr_Tariffe);
	if(lstr_Message.equals("")){
		strMsgOutput = "Eliminazione avvenuta con successo!!";
		strLogMessage += ": Successo";
	}else{
	  	strMsgOutput = lstr_Message;
		strLogMessage += ": " + lstr_Message;
	}%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3505,strLogMessage)%>
	</logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset); 
	response.sendRedirect(strUrl);
	%>