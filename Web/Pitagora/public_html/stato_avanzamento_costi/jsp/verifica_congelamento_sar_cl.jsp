<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbSTL.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Date,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"verifica_congelamento_sar_cl.jsp")%>
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
  I5_2TEST_AVANZ_COSTI_RICAVI_ROW[] aRemote = null;  
  int  iIndice;
  String ChiaveAccount=  null;
  String codiceAccount=  null;
  String Flag_sys=  null;
  String strComRibes = null;
  final String RibesVerficaSar="3";
  final String RibesSeparatore="$";  
  boolean NessunElementoValido = true;
  Date DataIniziale =null;
  Date DataFinale =null; 

  if (session.getAttribute("FlagLancioSar")==null){
    response.sendRedirect(request.getContextPath() + "/common/jsp/com_tc.jsp?destinationPageClassic=/stato_avanzamento_costi/jsp/cbn1_ver_ava_ric_cl.jsp&strTitolo=/stato_avanzamento_costi/images/avanzamricavi.gif&TCNonAmmessiClassic=*2*6*&TCNonAmmessiSpecial=-");  
  }  
  
  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String Utente = aUserInfo.getUserName(); 
  //Account selezionati nella maschera cbn1_lancio_csi_cl
  String  SingoloCongelamento = null;  
  //Codice Elaborazione selezionato
  String code_elab_flag_sys = null;
  String Code_Stato_Avanz_Ricavi = null;
  String Code_elab=null;
  Vector recs = new Vector();
  String strTestAvanUpd = ",";    
  I5_2Elab_Batch[] aRemoteElab_Batch = null;
  int ElabBatchSelezionato; 
  
  ElabBatchSelezionato =  Integer.parseInt(request.getParameter("code_elab_flag_sys"));
  aRemoteElab_Batch = (I5_2Elab_Batch[]) session.getAttribute("aRemote");  
  I5_2Elab_Batch remoteElabBatch = (I5_2Elab_Batch) PortableRemoteObject.narrow(aRemoteElab_Batch[ElabBatchSelezionato],I5_2Elab_Batch.class);                                                        
  I5_2Elab_BatchPK PrimaryKey    = (I5_2Elab_BatchPK) remoteElabBatch.getPrimaryKey();      
  Code_elab=PrimaryKey.getcode_elab();
  Flag_sys=PrimaryKey.getFlag_sys();  
  
  SingoloCongelamento = request.getParameter("SingoloCongelamento");
  strComRibes = RibesVerficaSar + RibesSeparatore + Utente + RibesSeparatore + "B"; 
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>Lancio Confronto Storico Inventario</TITLE>
</HEAD>
<BODY >
<EJB:useHome id="home" type="com.ejbBMP.I5_1ACCOUNTHome" location="I5_1ACCOUNT" />
<%
  if (SingoloCongelamento==null){
      //Il congelamento deve essere effettuato per tutti gli elementi disponibili
      //Verifico di tutti gli elementi quali devono essere congelati
    aRemote = (I5_2TEST_AVANZ_COSTI_RICAVI_ROW[]) session.getAttribute("aRemoteTEST_AVANZ_COSTI_RICAVI_ROW");
    for(iIndice=0;iIndice<aRemote.length;iIndice++)      {
      if (aRemote[iIndice].getCode_Stato_Batch().equals("SUCC")){
        primaryKey = new I5_1ACCOUNTPK(aRemote[iIndice].getCode_Account(),aRemote[iIndice].getFlag_Sys());
        remote = home.findByPrimaryKey(primaryKey);    
        if (remote.getControlloBatch()>0 ){
          recs.add(remote.getDesc_Account());
        } else {  
            //Costruzione riga per dialogo con Ribes
          strComRibes = strComRibes + codiceAccount + RibesSeparatore + Flag_sys  + RibesSeparatore; 
          strComRibes = strComRibes + "#" + Code_elab ;           
          strTestAvanUpd = strTestAvanUpd + aRemote[iIndice].getCode_Stato_Avanz_Ricavi() + ",";
          NessunElementoValido=false;
        }
      }
    }      
  } else {
    ChiaveAccount = request.getParameter("ChiaveAccount");
    iIndice=ChiaveAccount.indexOf(",");
    codiceAccount=  ChiaveAccount.substring(0,iIndice);
    Code_Stato_Avanz_Ricavi=  ChiaveAccount.substring(iIndice+1);    
    primaryKey = new I5_1ACCOUNTPK(codiceAccount,Flag_sys);
    remote = home.findByPrimaryKey(primaryKey);    
    if (remote.getControlloBatch()>0 ){
      recs.add(remote.getDesc_Account());
    } else {  
        //Costruzione riga per dialogo con Ribes
      strComRibes = strComRibes + codiceAccount + RibesSeparatore + Flag_sys  + RibesSeparatore; 
      strComRibes = strComRibes + "#" + Code_elab ;           
      strTestAvanUpd = strTestAvanUpd + Code_Stato_Avanz_Ricavi + ",";
      NessunElementoValido=false;
    }
  }    
  if (NessunElementoValido){
%>
  <script language="javascript">
    window.document.location="messaggio.jsp?Bottone=1&txtTypeLoad=1&strUrl=cbn1_ver_ava_ric_cl.jsp&strMessaggio=<%=response.encodeURL("Attenzione impossibile procedere con l'elaborazione")%>"  
  </script>  
<%
  } else {
    session.setAttribute( "strComRibes", strComRibes);
    session.setAttribute( "strTestAvanUpd", strTestAvanUpd);    
    if (!(recs.size()==0)){
      aRemoteAccount = (String[]) recs.toArray(new String[1]);  
      session.setAttribute( "aRemoteAccount", aRemoteAccount);      
%>
  <script language="javascript">
  window.document.location="../../common/jsp/dialog_vis_account_cl.jsp?FormChiamante=verifica_avanzamento_costi"
  </script>  
<%
    } else {
%>
  <script language="javascript">
    window.document.location="messaggio.jsp?strUrl=salva_verifica_sar_cl.jsp&strMessaggio=<%=response.encodeURL("Lancio procedura batch di Congelamento Stato Avanzamento Costi")%>"      
  </script>  
<%
    } 
  }    
%>
</BODY>
</HTML>
