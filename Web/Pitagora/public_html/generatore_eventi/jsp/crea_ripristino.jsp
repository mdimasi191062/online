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
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"crea_ripristino.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>

<%
String strReturn = "";
String strMsgOutput = "";

  String strID_Evento = Misc.nh(request.getParameter("IdEvento"));
  String strDataElaborazione = Misc.nh(request.getParameter("DataElab"));
	/*MA*/
  String strCod_Ist_Prod = Misc.nh(request.getParameter("srcIstanzaProd"));
  String strSistema_Mittente = Misc.nh(request.getParameter("sistema_mittente"));
  /*FINE MA*/

String strCodTipoEvento = "2";
String strIdEventoIniziale = (String)session.getAttribute("hidsrcIdEvento");
 if (!strID_Evento.equals(strIdEventoIniziale)) {
    strCodTipoEvento = "3";
 }
 

String strNoteRettifica =Misc.nh((String) session.getAttribute("NoteRettifica"));
session.setAttribute("NoteRettifica",null);
//String strParametri = "Evento = " + strID_Evento + "Data Elaborazione =" + strDataElaborazione;
/* MA */
String strParametri = "CodTipoEvento = " + strCodTipoEvento + "Evento = " + strID_Evento + ",Data Elaborazione = " + strDataElaborazione+ ",Codice_Istanza_Prod = " + strCod_Ist_Prod+ ",Sistema_Mittente = " + strSistema_Mittente + "Note Rettifica = " + strNoteRettifica;
/* FINE MA */
System.out.println("strParametri "+strParametri );
String strLogMessage = "remoteEnt_Inventari.inserimentoRipristino(" + strParametri + ")";


%>

<%
//inserisce  

/*int intReturn = remoteEnt_Inventari.inserimentoRipristino(((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName(),
                                strID_Evento,strDataElaborazione);*/
/* MA 
MS 17/12/2009 
int intReturn = remoteEnt_Inventari.inserimentoRipristino(((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName(),
                                strID_Evento,strDataElaborazione,strCod_Ist_Prod,strSistema_Mittente);
FINE MA*/   


if (strNoteRettifica.compareTo("")==0)  { 
strNoteRettifica=null;
}

int intReturn = remoteEnt_Inventari.inserimentoRipristino(((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName(),
                                strID_Evento,strDataElaborazione,strCod_Ist_Prod,strSistema_Mittente,strCodTipoEvento,strNoteRettifica);
/*
if (strNoteRettifica.compareTo("")!=0)  { 
remoteEnt_Inventari.inserimentoNoteRettificaRipristino(strCod_Ist_Prod,"99",strNoteRettifica); 
}
*/


if( intReturn == 0){
	strMsgOutput = "Inserimento avvenuto con successo!!";
	strLogMessage += " : Successo" ;
}
else if (intReturn == -40099) {
	strMsgOutput = "Impossibile procedere con l''elaborazione. Si � verificato un errore generico Oracle o di sistema. Contattare l'assistenza!";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40007) {
	strMsgOutput = "Impossibile procedere con l'elaborazione. L'ID EVENTO seelzionato non corrisponde all'ultimo evento attivo della risorsa in inventario!!";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40006) {
	strMsgOutput = "Impossibile procedere con l''elaborazione del generatore di eventi per ripristino. L''elaborazione e'' stata lanciata con i parametri a Null!!";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40005) {
	strMsgOutput = "Impossibile procedere con l''elaborazione del generatore di eventi. Non sono gestiti eventi di trasformazione help desk !";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40004) {
	strMsgOutput = "Impossibile procedere con l''elaborazione del generatore di eventi per ripristino per prodotto variato. Non sono presenti componenti o prestazioni aggiuntive cessate, variate o attive!!";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40003) {
	strMsgOutput = "Impossibile procedere con l''elaborazione del generatore di eventi per ripristino. Sono presenti altre elaborazioni in corso!";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40002) {
	strMsgOutput = "Impossibile procedere con l''elaborazione del generatore di eventi per ripristino. La data elaborazione selezionata non e'' congruente !";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -40001) {
	strMsgOutput = "Impossibile procedere con l''elaborazione del generatore di eventi per ripristino. L''id evento selezionato e'' inesistente!";
	strLogMessage += " : " + intReturn ;
} else
if (intReturn == -1) {
	strMsgOutput = "Impossibile procedere con l'elaborazione. Errore di sistema. Contattare l'assistenza";
	strLogMessage += " : " + intReturn ;
} else {
	strMsgOutput = "Errore!!";
	strLogMessage += " : " + intReturn ;
}%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
	<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>


<%//mostra l'esito dell'elaborazione
/*  session.setAttribute("URL_COM_TC","ripristina_inventario.jsp");*/
//	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_POPUP=false&message=" + java.net.URLEncoder.encode(strMsgOutput); 
	//String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_POPUP=false&message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset); 
  
  String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_AUT_POPUP=true&message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset); 
	response.sendRedirect(strUrl);%>



