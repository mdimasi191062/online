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
<%=StaticMessages.getMessage(3006,"crea_evento.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeCtr_Inventari" type="com.ejbSTL.Ctr_InventariHome" location="Ctr_Inventari" />
<EJB:useBean id="remoteCtr_Inventari" type="com.ejbSTL.Ctr_Inventari" scope="session">
    <EJB:createBean instance="<%=homeCtr_Inventari.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>


<%
String strReturn = "";
String strMsgOutput = "";
String strtypeLoad       = null;
String strpropagaDesc1     = null;
Vector vctpropagaCompo     = null;
 
Vector vct_InventariProd = null;
Vector ctrlvct_InventariProd = null;
Vector vct_InventariCompo = null;
Vector vct_InventariPrest = null;
Vector vct_InventariAnag = null;
DB_InventProd data_Inventari = null;
Vector vct_InventariCompoDIF = null;
Vector vct_InventariCompoC_C = null;
Vector vct_InventariCompoC_A = null;
String strDataCreaz = request.getParameter("DataCreaz");
String strNoteRettifica =(String) session.getAttribute("NoteRettifica");
session.setAttribute("NoteRettifica",null);
   strtypeLoad = (String)session.getAttribute("hidTypeLoadProd");
   if ( !strtypeLoad.equals ( "0" ) ) {
       vct_InventariProd = (Vector) session.getAttribute("vct_Inventari"); 
       ctrlvct_InventariProd = (Vector) session.getAttribute("ctrlvct_Inventari"); 
      /* Assegno alla data creaz del prodotto */
       data_Inventari = (DB_InventProd)vct_InventariProd.get(0);
       data_Inventari.setDATA_CREAZ(strDataCreaz);
      if (session.getAttribute("DIFListaCOMPO") != null)
      vct_InventariCompoDIF = (Vector) session.getAttribute("DIFListaCOMPO");  
      if (session.getAttribute("C_AListaCOMPO") != null)
      vct_InventariCompoC_A = (Vector) session.getAttribute("C_AListaCOMPO");  
  }

   strtypeLoad = (String)session.getAttribute("hidTypeLoadCompo");
   if ( !strtypeLoad.equals ( "0" ) )
       vct_InventariCompo = (Vector) session.getAttribute("vct_InventariCompo");

   strtypeLoad = (String)session.getAttribute("hidTypeLoadPrestAgg");
   if ( !strtypeLoad.equals ( "0" ) )
       vct_InventariPrest = (Vector) session.getAttribute("vct_InventariPrestAgg");

   strtypeLoad = (String)session.getAttribute("hidTypeLoadPP");
   if ( strtypeLoad.equals("0") ) strtypeLoad = (String)session.getAttribute("hidTypeLoadMP");
   if ( strtypeLoad.equals("0") ) strtypeLoad = (String)session.getAttribute("hidTypeLoadRPVD");
   if ( strtypeLoad.equals("0") ) strtypeLoad = (String)session.getAttribute("hidTypeLoadATM");
   if ( strtypeLoad.equals("0") ) strtypeLoad = (String)session.getAttribute("hidTypeLoadITC");
   if ( strtypeLoad.equals("0") ) strtypeLoad = (String)session.getAttribute("hidTypeLoadITC_REV");
   if ( !strtypeLoad.equals ( "0" ) ) vct_InventariAnag = (Vector) session.getAttribute("vct_InventariAnag");

    strpropagaDesc1 = (String)session.getAttribute("parsrcDescSede1"); 
  /* if (!strpropagaDesc1.equals("0") ){
       strpropagaDesc1 = "1";
   }
  */ 
    vctpropagaCompo = (Vector)session.getAttribute("vPropagaCodeCompo"); 
  //  if (vctpropagaCompo.isEmpty()){
  //     vctpropagaCompo=null;  
  //  }
   
%>

<% 
String strParametri = (vct_InventariProd == null) ? "vuoto" : String.valueOf(vct_InventariProd.size());
strParametri += ",";
strParametri += (vct_InventariCompo == null) ? "vuoto" : String.valueOf(vct_InventariCompo.size());
strParametri += ",";
strParametri += (vct_InventariPrest == null) ? "vuoto" : String.valueOf(vct_InventariPrest.size());
strParametri += ",";
strParametri += (vct_InventariAnag == null) ? "vuoto" : String.valueOf(vct_InventariAnag.size());

String strLogMessage = "remoteCtr_Inventari.inserimentoRettifica(" + strParametri + ")";%>

<%
//PROPAGO OFFERTA SERVIZIO ACCOUNT PRODOTTO
//================================================================
DB_InventProd ctrldata_Inventari=null;

String strpropagaDEE     = "0";
String strpropagaProdotto     = "0";
String strpropagaDRO     = "0";
ctrldata_Inventari = (DB_InventProd)ctrlvct_InventariProd.get(0);

Vector vPropagaElem = new Vector();

//PROPAGO CODE_SERVIZIO
if ( !ctrldata_Inventari.getDATA_DRO().equals(data_Inventari.getDATA_DRO())) {strpropagaDRO="1";}
if ( !ctrldata_Inventari.getDATA_DEE().equals(data_Inventari.getDATA_DEE())) {strpropagaDEE="1";}
if ( !ctrldata_Inventari.getCODE_PRODOTTO().equals(data_Inventari.getCODE_PRODOTTO())) {strpropagaProdotto="1";}

vPropagaElem.add(strpropagaProdotto);
vPropagaElem.add(strpropagaDRO);
vPropagaElem.add(strpropagaDEE);
//================================================================


//inserisce  
int intReturn = remoteCtr_Inventari.inserimentoRettifica(((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName(),
vct_InventariProd,vct_InventariCompo,vct_InventariPrest,vct_InventariAnag,vct_InventariCompoDIF,strpropagaDesc1,vctpropagaCompo,vPropagaElem,vct_InventariCompoC_A ,vct_InventariCompo,strNoteRettifica);

 session.setAttribute("hidTypeLoadProd", "0");
 session.setAttribute("hidTypeLoadCompo", "0");
 session.setAttribute("hidTypeLoadPrestAgg", "0");
 session.setAttribute("hidTypeLoadPP", "0");
 session.setAttribute("hidTypeLoadMP", "0");
 session.setAttribute("hidTypeLoadRPVD", "0");
 session.setAttribute("hidTypeLoadATM", "0");
 session.setAttribute("hidTypeLoadITC", "0");
 session.setAttribute("hidTypeLoadITC_REV", "0");
 session.setAttribute("ableCreaEvento", "0");
 session.setAttribute("elemNonModif","0");
session.setAttribute("parsrcDescSede1","0");
session.setAttribute("parstrCodeComponente","0");
session.setAttribute("DIFListaCOMPO",null);
session.setAttribute("vPropagaCodeCompo",null);

if( intReturn == 0){
	strMsgOutput = "Inserimento avvenuto con successo!!";
	strLogMessage += " : Successo" ;
  
}else if (intReturn == -1) {
	strMsgOutput = "Ci sono elaborazioni in corso impossibile procedere!!";
	strLogMessage += " : " + intReturn ;
} else {
	strMsgOutput = "Errore!!";
	strLogMessage += " : " + intReturn ;
}%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
	<%=StaticMessages.getMessage(3503,strLogMessage)%>
</logtag:logData>

<%//mostra l'esito dell'elaborazione
//	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_POPUP=true&message=" + java.net.URLEncoder.encode(strMsgOutput); 
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_AUT_POPUP=true&message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset); 
  response.sendRedirect(strUrl);%>
