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
<%=StaticMessages.getMessage(3006,"acquisizione.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Batch" type="com.ejbSTL.Ctr_BatchHome" location="Ctr_Batch" />
<EJB:useBean id="remoteCtr_Batch" type="com.ejbSTL.Ctr_Batch" scope="session">
    <EJB:createBean instance="<%=homeCtr_Batch.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<%
 String CodeFunz = Misc.nh(request.getParameter("CodeFunz"));
  String NameBatchImport = null, DescFunz = null , VarPath = null , MaxSizeUpl = null , strDett = "Seleziona File";
 if ( !CodeFunz.equals("")) {
  DB_WebUplFiles reWeb = remoteCtr_ElabAttive.getWebUpl(CodeFunz);
  DescFunz = reWeb.getDESC_FUNZ();
  VarPath = reWeb.getVAR_PATH_DOWNLOAD();
  MaxSizeUpl = reWeb.getLIM_MAX_SIZE_UPLOAD();
  NameBatchImport = reWeb.getNAME_BATCH_IMPORT();
 }
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>
Elaborazione in corso...
</title>
</head>
<body>
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr height="30">
        <td>
          <table width="100%">
            <tr>
              <td>
                <img src="../images/upload.gif" alt="" border="0"/>
              </td>
            </tr>
          </table>
        </td>
        <td/>
      </tr>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"> Acquisizione File </td>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="20">
        <TD>
          <TABLE width="90%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white"/>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"/>
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
    </TABLE>
<%
   out.flush();
   String strElabBatch = "";
   String[] strGestori = null;
   String[] strServizi = null;
   String[] strAccount = null;
   boolean checkTldDaFile = false;
   boolean checkCong = false;
   String strTextNomeFile = "";
   String strDataFinePeriodo = "";
   String strUsrProfile = "";
   String strResponse = "";
   String strResponseDett = ""; 
   String strParamFunz = "";
   String strPeriodoRif = "";
   
   strUsrProfile = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();  
  try{
    int risposta = 0;
    if(CodeFunz.equals("10044"))
      strResponse = String.valueOf(remoteCtr_Batch.LancioBatch_ImportTariffeSp(strUsrProfile,NameBatchImport));
    else if(CodeFunz.equals("10045"))
      strResponse = String.valueOf(remoteCtr_Batch.LancioBatch_ImportPromozioni(strUsrProfile,NameBatchImport));
    else if(CodeFunz.equals("10046"))
      strResponse = String.valueOf(remoteCtr_Batch.LancioBatch_ImportFatture(strUsrProfile,NameBatchImport));
    else if(CodeFunz.equals("10047"))
      strResponse = String.valueOf(remoteCtr_Batch.LancioBatch_ImportTariffeSpCluster(strUsrProfile,NameBatchImport));
    else
      strResponse = String.valueOf(remoteCtr_Batch.LancioBatch_Import(strUsrProfile,NameBatchImport));

/*
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
      */
  }
  catch(Exception e){
    strResponse = "Si è verificato un errore inaspettato. Contattare l'assistenza.";
    strResponseDett = "(" + Misc.replace(e.getMessage(),"\n","") + ")";          
  }


  strResponse     = Misc.nh(strResponse);
  strResponse     = Misc.replace(strResponse,"'","\\'");
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
