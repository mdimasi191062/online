<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*,java.util.Vector"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- inclusione della tagLib che permette l'instanziazione dell'oggetto remoto  -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_ass_ofps_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPsHome" location="Ctr_AssociazioniOfPs" />
<EJB:useBean id="remoteCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPs" scope="session">
    <EJB:createBean instance="<%=homeCtr_AssociazioniOfPs.create()%>" />
</EJB:useBean>
<%
String lstr_ViewState = request.getParameter("viewState");
DB_OggettoFatturazione objOggFatt = new DB_OggettoFatturazione();
String strReturn = "";
String strMsgOutput = "";
String lstrCodeOggFat = "";
String lstrCodeClassOggFat = "";
String lstrDATA_INIZIO_VALID_OF = "";
String lstrDATA_FINE_VALID_OF = "";
String lstrTipoCausale = "";
String lstrCODE_PR_PS_PA_CONTR = "";
String lstrCodePrestAgg = "";
String strCodeUtente = "";
Vector lvctSplit = null;
//estrazione del code utente loggato dalla sessione
clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
strCodeUtente = objInfoUser.getUserName();
	
lvctSplit = Misc.split(Misc.nh(request.getParameter("cboDescrizioneFat")),"$");
lstrCodeOggFat=(String)lvctSplit.elementAt(0);
lstrCodeClassOggFat=(String)lvctSplit.elementAt(1);
lstrDATA_INIZIO_VALID_OF = (String)lvctSplit.elementAt(2);
lstrDATA_FINE_VALID_OF = (String)lvctSplit.elementAt(3);


lstrTipoCausale = Misc.nh(request.getParameter("cboTipoCausale"));

lstrCodePrestAgg = Misc.nh(request.getParameter("cboPrestAgg"));
//lstrCodePrestAgg = (String)lvctSplit.elementAt(0);
//lstrCODE_PR_PS_PA_CONTR = (String)lvctSplit.elementAt(1);

//valorizzo il data been	
objOggFatt.setCODE_TIPO_CONTR(Misc.getParameterValue(lstr_ViewState,"codeTipoContratto"));
objOggFatt.setCODE_OGG_FATRZ(lstrCodeOggFat);//s
objOggFatt.setDATA_INIZIO_VALID_OF(lstrDATA_INIZIO_VALID_OF);//s
objOggFatt.setCODE_CLAS_OGG_FATRZ(Misc.nh(request.getParameter("cboClasseFat")));//s
objOggFatt.setDATA_FINE_VALID_OF(lstrDATA_FINE_VALID_OF);//s
objOggFatt.setCODE_CONTR(Misc.nh(request.getParameter("cboContratto")));//s
objOggFatt.setCODE_PREST_AGG(lstrCodePrestAgg);//s
objOggFatt.setCODE_PS(Misc.getParameterValue(lstr_ViewState,"codePs"));//s
objOggFatt.setCODE_PR_PS_PA_CONTR(lstrCODE_PR_PS_PA_CONTR);//s
objOggFatt.setDATA_INIZIO_VALID_OF_PS(Misc.nh(request.getParameter("txtDataInizioValidita")));//s
objOggFatt.setDATA_FINE_VALID_OF_PS(Misc.nh(request.getParameter("txtDataFineValidita")));//s
objOggFatt.setCODE_FREQ_APPL(Misc.nh(request.getParameter("cboFrequenza")));//s
objOggFatt.setCODE_MODAL_APPL(Misc.nh(request.getParameter("cboModalitaProrata")));//s
objOggFatt.setTIPO_FLAG_ANTTO_POSTTO(Misc.nh(request.getParameter("cboModalita")));//s
objOggFatt.setQNTA_SHIFT_CANONI(Misc.nh(request.getParameter("txtShiftCanoni")));//s
objOggFatt.setCODE_TIPO_CAUS(lstrTipoCausale);//s
objOggFatt.setCODE_UTENTE(strCodeUtente);//s%>

<% String strLogMessage = "remoteCtr_AssociazioniOfPs.InsAssociazioneOfPs(" + objOggFatt.FieldsToString() + ")";%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
	<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>
<%
//inserisce  
strReturn = remoteCtr_AssociazioniOfPs.InsAssociazioneOfPs(objOggFatt);
if(strReturn.equalsIgnoreCase("")){
	strMsgOutput = "Inserimento avvenuto con successo!!";
	strLogMessage += " : Successo" ;
}else{
	strMsgOutput = strReturn;
	strLogMessage += " : " + strReturn ;
}%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
	<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>
<%//mostra l'esito dell'elaborazione
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_POPUP=true&message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset); 
	response.sendRedirect(strUrl);%>

