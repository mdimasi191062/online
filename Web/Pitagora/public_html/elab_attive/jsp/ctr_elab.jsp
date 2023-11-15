<%@ page contentType="text/html;charset=windows-1252"%>
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
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>

<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_controller_tariffe.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Elaborazione in corso...
</title>
</head>
<body>
    <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                &nbsp;
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="middle" width="9%">
                <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD align="center" valign="middle">
          <IMG name="imgProgress" id="imgProgress" alt="Elaborazione in corso" src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif">
          <BR>
          <FONT class="textMsg" id="msg" name="msg">
           Elaborazione in corso...
          </FONT><BR><BR>
          <FONT class="textMsgDett" id="msgDett" name="msgDett">
          </FONT>
        </TD>
      </TR>
      <TR height="20" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD>
          <TABLE align="center" width="100%" border="0">
            <TR>
              <td class="text" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                <INPUT TYPE="button" td_class="textB" value="Chiudi" onclick="window.close()">
              </td>
            </TR>
          </TABLE>
        </TD>
      </TR>
    </TABLE>
<%
   out.flush();
   String strElabBatch = "";
   String[] strGestori = null;
   String[] strServizi = null;
   String[] strAccount = null;
   boolean checkTldDaFile = false;
/*mm01 23/01/2005 INIZIO*/    
   boolean checkCong = false;
/*mm01 23/01/2005 FINE*/
/*mm01 04/05/2005 INIZIO*/    
   String strTextNomeFile = "";
/*mm01 04/05/2005 FINE*/
   String strDataFinePeriodo = "";
   String strUsrProfile = "";
   String strResponse = "";
   String strResponseDett = ""; 
   String strParamFunz = "";
   String strPeriodoRif = "";

/*QS 06/12/2007: INIZIO modifica per export GECOM*/
   boolean checkInvioGecom = false;
/* QS 06/12/2007: FINE modifica per export GECOM */
  String ivaFc = "";
  /* ivaFc=request.getParameter("fcIva"); */
  ivaFc="X";
  String cinqueAnni = "";
  cinqueAnni=request.getParameter("cinqueAnni");
  
  String reprDel = "";
  if(request.getParameter("reprDel")!=null) {
    reprDel = request.getParameter("reprDel");   /*F: - R1I-19-0356 */
  }
  else
  {
    reprDel = "N";
  }
  String richEmissRepr = "";
  richEmissRepr = request.getParameter("richEmissRepr");   /*F: - R1I-19-0356 */
  String dataDelib = request.getParameter("dataDelib");
  String dataChiusAnnoCont = request.getParameter("dataChiusAnnoCont");
  String motRepricing = request.getParameter("testoRepr") + " " + request.getParameter("motivazioneRepr");  
      
  motRepricing = motRepricing.replace(' ','*');
  String newParameter = reprDel + ";" + richEmissRepr + ";" + dataDelib + ";" + dataChiusAnnoCont + ";" + motRepricing;  

   strElabBatch = request.getParameter("cboElaborazioni");
   strDataFinePeriodo = Misc.nh(request.getParameter("txtData" + strElabBatch));
   strParamFunz = Misc.nh(request.getParameter("ParamFunz"));

/*mm01 04/05/2005 INIZIO*/
   if ( (strElabBatch.equals(StaticContext.RIBES_J2_EXPORT_SWN_VAL) )  ||
        (strElabBatch.equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR) ) ||
        (strElabBatch.equals(StaticContext.RIBES_J2_EXPORT_MENSILE) )
       ) {
        strPeriodoRif = Misc.nh(request.getParameter("txtDataFineCiclo"));
   }
   else {
        strPeriodoRif = Misc.nh(request.getParameter("PeriodoRif"));
   }
   strTextNomeFile = Misc.nh(request.getParameter("txtNomeFile"));
/*mm01 04/05/2005 FINE*/
   if(request.getParameter("checkAcquisizioneTLDdaFile")!=null) checkTldDaFile = true;
/*mm01 23/01/2005 INIZIO*/   
   if(request.getParameter("checkCongelamentoSpesa")!=null) checkCong = true;
/*mm01 23/01/2005 FINE*/

 /*QS 06/12/2007: INIZIO modifica per export GECOM*/
     if(request.getParameter("checkInvioGecom")!=null) checkInvioGecom = true;
 /* QS 06/12/2007: FINE modifica per export GECOM */
   if(request.getParameter("cboServizi") != null){
      strServizi = request.getParameterValues("cboServizi");

      //out.println(strServizi.length);      
   }

   if(request.getParameter("cboAccount") != null){
      strAccount = request.getParameterValues("cboAccount");

      //out.println(strAccount.length);
   }

   if(request.getParameter("cboGestori") != null){
      strGestori = request.getParameterValues("cboGestori");
      //out.println(strGestori.length);      
   }

  strUsrProfile = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();  
  String desc_ciclo = "";
  desc_ciclo = request.getParameter("desc_ciclo");
  String codice_ciclo = "";
  codice_ciclo = request.getParameter(desc_ciclo);
  try{
    int risposta = 0;
    //aggiunto inserimento nella tabella PREINV_SERV dei servizi da lanciare per 
    //l'elaborazione preinventario in base al codice ciclo selezionato dall'online
    if(strElabBatch.equals(StaticContext.RIBES_J2_ELAB_PREINVE) ){
      risposta = remoteCtr_ElabAttive.insertElabPreinve(codice_ciclo);
    }

    //QS 06/12/2007-Modifica per GECOM: aggiunto alla funzione lancioBatch il flag checkInvioGecom
    //strResponse = String.valueOf(remoteCtr_ElabAttive.lancioBatch(strElabBatch,strUsrProfile,strParamFunz,strPeriodoRif,strGestori,strServizi,strAccount,strDataFinePeriodo,ivaFc,checkTldDaFile,checkCong,strTextNomeFile,checkInvioGecom,cinqueAnni,reprDel,richEmissRepr,dataDelib,dataChiusAnnoCont,motRepricing));
    strResponse = String.valueOf(remoteCtr_ElabAttive.lancioBatch(strElabBatch,strUsrProfile,strParamFunz,strPeriodoRif,strGestori,strServizi,strAccount,strDataFinePeriodo,ivaFc,checkTldDaFile,checkCong,strTextNomeFile,checkInvioGecom,cinqueAnni,newParameter));
    if ( strResponse.equals("0") ) {
        strResponse ="";
    }
    else if( strResponse.equals("2") ) {
         strResponse = "Si è verificato un errore con la comunicazione al ribes. Contattare l'assistenza.";
         strResponseDett = "";
    } else  if( !strResponse.equals("0") ) {
         strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
         strResponseDett = "";
    }
  }
  catch(Exception e){
    strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
    strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
  }

  strResponse = Misc.nh(strResponse);
  strResponse = Misc.replace(strResponse,"'","\\'");
  strResponseDett = Misc.nh(strResponseDett);
  strResponseDett = Misc.replace(strResponseDett,"'","\\'");
  
%>
<script language="javascript">
  var strResponse ='<%=strResponse%>';
  imgProgress.style.display='none';
  var myWin = null;

  if ( '' == strResponse ){
    document.all('msg').innerText = 'Operazione effettuata con successo.';
    //window.opener.location.replace('','_self');
    //myWin = window.opener.open('','_self');
  }
  else{
    document.all('msg').style.color ='red';
    document.all('msg').innerHTML = strResponse;
    document.all('msgDett').innerHTML = '<%=strResponseDett%>';    
  }

</script>
</body>
</html>
