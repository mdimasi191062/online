<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Date,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"verifica_lancio_sar_cl.jsp")%>
</logtag:logData>
<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
    //Interfaccia Remota I5_1ACCOUNT
  I5_1ACCOUNT remote = null;       
  I5_1ACCOUNTPK primaryKey;
  String[] aRemoteAccount;  
  int  iIndice;
  String codiceAccount=  null;
  String Flag_sys=  null;
  String strComRibes = null;
  final String RibesINFR_BATCH_SAR="13";
  final String RibesSeparatore="$";  
  boolean NessunElementoValido = true;
  Date DataIniziale =null;
  Date DataFinale =null;  
  String CodiceTest_ACR=null;

    //Controllo se proveniamo da cbn1_lancio_sar_cl
  if (session.getAttribute("FlagLancioSar")==null){
    response.sendRedirect(request.getContextPath() + "/common/jsp/com_tc.jsp?destinationPageClassic=/stato_avanzamento_costi/jsp/cbn1_lancio_sar_cl.jsp&strTitolo=/stato_avanzamento_costi/images/avanzamricavi.gif&TCNonAmmessiClassic=*2*6*&TCNonAmmessiSpecial=-");  
  }  

  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String Utente = aUserInfo.getUserName();    
    //Account selezionati nella maschera cbn1_lancio_csi_cl
  String  RiepilogoAccount = null;
      //Periodo Selizionato 
  String CaricaPeriodo;  
  RiepilogoAccount = request.getParameter("RiepilogoAccount");
    //Periodo Selizionato 
  CaricaPeriodo = request.getParameter("CaricaPeriodo");  
  strComRibes = RibesINFR_BATCH_SAR + RibesSeparatore + Utente + RibesSeparatore + CaricaPeriodo; 
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>Lancio Confronto Storico Inventario</TITLE>
</HEAD>
<BODY >
<EJB:useHome id="home_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVIHome" location="I5_2TEST_AVANZ_COSTI_RICAVI" />
<EJB:useBean id="remote_TEST_ACR" type="com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVI" scope="session">
  <EJB:createBean instance="<%=home_TEST_ACR.create()%>" />
</EJB:useBean>
<EJB:useHome id="home" type="com.ejbBMP.I5_1ACCOUNTHome" location="I5_1ACCOUNT" />
<%
  Vector recs = new Vector();
  while (RiepilogoAccount.length()>1) {
    iIndice=RiepilogoAccount.indexOf(",");
    codiceAccount=  RiepilogoAccount.substring(0,iIndice);
    RiepilogoAccount =  RiepilogoAccount.substring(iIndice+1);
    iIndice=RiepilogoAccount.indexOf(",");
    Flag_sys=  RiepilogoAccount.substring(0,iIndice);
    RiepilogoAccount =  RiepilogoAccount.substring(iIndice+1)  ;
    primaryKey = new I5_1ACCOUNTPK(codiceAccount,Flag_sys);
    remote = home.findByPrimaryKey(primaryKey);    
    if (remote.getControlloBatch()>0 ){
      recs.add(remote.getDesc_Account());
    } else {  
        //Costruzione riga per dialogo con Ribes
      CodiceTest_ACR=remote_TEST_ACR.PresenzaAccount(codiceAccount,Flag_sys,CaricaPeriodo.substring(0,4),CaricaPeriodo.substring(4));
      if  (CodiceTest_ACR==null) {
        strComRibes = strComRibes + RibesSeparatore + "I" + codiceAccount + RibesSeparatore + Flag_sys;       
      } else {
        strComRibes = strComRibes + RibesSeparatore + "U" + CodiceTest_ACR + RibesSeparatore + Flag_sys; 
      }       
      NessunElementoValido=false;
    }
  }    
  session.setAttribute( "strComRibes", strComRibes);
  if (!(recs.size()==0)){
    aRemoteAccount = (String[]) recs.toArray(new String[1]);  
    session.setAttribute( "aRemoteAccount", aRemoteAccount);
%>
  <script language="javascript">
  window.document.location="../../common/jsp/dialog_vis_account_cl.jsp?FormChiamante=LAR"
  </script>  
<%
  } else {
%>
  <script language="javascript">
    window.document.location="messaggio.jsp?strUrl=salva_lancio_sar_cl.jsp&strMessaggio=<%=response.encodeURL("Lancio procedura batch di Stato Avanzamento Costi")%>"    
  </script>  
<%
  } 
%>
</BODY>
</HTML>
