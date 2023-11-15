<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.ejbSTL.*,com.utl.*,com.usr.*,java.util.Vector" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"verifica_lancio_cpm_cl.jsp")%>
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
  I5_2PARAM_VALORIZ_CL_ROW rowPARAM_VALORIZ;
  String[] aRemoteAccount;  
  int  iIndice;
  String codiceAccount=  null;
  String Flag_sys=  null;
  String strComRibes = null;
  final String RibesCalcolo_Penali="10001";
  final String RibesSeparatore="$";  
  boolean NessunElementoValido = true;

    //Controllo se proveniamo da cbn1_lancio_calc_penali_cl
  if (session.getAttribute("FlagLancioCpm")==null){
    response.sendRedirect(request.getContextPath() + "/common/jsp/com_tc.jsp?destinationPageSpecial=/calcolo_penali_mensili/jsp/cbn1_lancio_calc_penali_cl.jsp&destinationPageClassic=/calcolo_penali_mensili/jsp/cbn1_lancio_calc_penali_cl.jsp&strTitolo=/calcolo_penali_mensili/images/calcpenmens.gif&TCNonAmmessiClassic=*2*6*&TCNonAmmessiSpecial=-");  
  }

  clsInfoUser aUserInfo =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
  String Utente = aUserInfo.getUserName();    
    //Account selezionati nella maschera cbn1_lancio_csi_cl
  String  RiepilogoAccount = null;
  RiepilogoAccount = request.getParameter("RiepilogoAccount");

  rowPARAM_VALORIZ=(I5_2PARAM_VALORIZ_CL_ROW) session.getAttribute("rowPARAM_VALORIZ");
  
  strComRibes = RibesCalcolo_Penali + RibesSeparatore + Utente + "_"; 
  strComRibes = strComRibes + RibesSeparatore + rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz();   
  strComRibes = strComRibes + RibesSeparatore + rowPARAM_VALORIZ.getData_fine_ciclo_fatrz() + RibesSeparatore;     
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
    
    if (remote.getControlloBatch_CPM(rowPARAM_VALORIZ.getData_inizio_ciclo_fatrz(),rowPARAM_VALORIZ.getData_fine_ciclo_fatrz())>0 ){
      recs.add(remote.getDesc_Account());
    } else {  
        //Costruzione riga per dialogo con Ribes
      strComRibes = strComRibes + codiceAccount + RibesSeparatore + Flag_sys  + RibesSeparatore; 
      NessunElementoValido=false;
    }
  }    
if (NessunElementoValido) {
%>
  <script language="javascript">
    window.document.location="messaggio.jsp?Bottone=1&strUrl=../../common/jsp/com_tc.jsp?destinationPageSpecial=/calcolo_penali_mensili/jsp/cbn1_lancio_calc_penali_cl.jsp&destinationPageClassic=/calcolo_penali_mensili/jsp/cbn1_lancio_calc_penali_cl.jsp&strTitolo=/calcolo_penali_mensili/images/calcpenmens.gif&TCNonAmmessiClassic=*2*6*&TCNonAmmessiSpecial=-&strMessaggio=<%=response.encodeURL("Non é possibile lanciare la procedura batch di Calcolo Penali Mensili in quanto tutti gli account selezionati hanno le fatture non congelate")%>"
  </script>  
<%
}
  session.setAttribute( "strComRibes", strComRibes);  
  if (!(recs.size()==0)){
    aRemoteAccount = (String[]) recs.toArray(new String[1]);  
    session.setAttribute( "aRemoteAccount", aRemoteAccount);
%>
  <script language="javascript">
    window.document.location="../../common/jsp/dialog_vis_account_cl.jsp?FormChiamante=LSP"
  </script>  
<%
  } else {
%>
  <script language="javascript">
    window.document.location="messaggio.jsp?strUrl=salva_lancio_cpm_cl.jsp&strMessaggio=<%=response.encodeURL("Lancio procedura batch di Calcolo Penali Mensili")%>"  
  </script>  
<%
  } 
%>
</BODY>
</HTML>
