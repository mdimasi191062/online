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

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"PrgDigDiv2.jsp")%>
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
<form name="frmDati" method="post" action="" target="Action">
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
  String strCodeFunz = "PRGDIGDIV";
  String strParamANNO = Misc.nh(request.getParameter("anno"));

  String strUsrProfile = "";
  String strResponse = "";
  String strResponseDett = ""; 
  String strParamFunz = "";
  String strPeriodoRif = "";

  strCodeFunz = "PRGDIGDIV";
  strUsrProfile = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();  
  
  try{
    int risposta = 0;
    
    strResponse = String.valueOf(remoteCtr_ElabAttive.lancioProgDigDiv(strCodeFunz,strUsrProfile,strParamANNO));

    if ( strResponse.equals("0") ) {
        strResponse ="OK";
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
</form>
<script language="javascript">
  var strResponse ='<%=strResponse%>';
  document.frmDati.imgProgress.style.display='none';
  var myWin = null;
  
  if ( 'OK' == strResponse ){
    document.all('msg').innerText = 'Operazione effettuata con successo.';
  }
  else{
    document.all('msg').style.color ='red';
    document.all('msg').innerHTML = strResponse;
    document.all('msgDett').innerHTML = '<%=strResponseDett%>';    
  }

</script>
</body>
</html>
