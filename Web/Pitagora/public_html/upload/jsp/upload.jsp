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
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"upload.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">

<title></title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>ListaTariffeSp.js" type="text/javascript"></script>
</head>
<BODY  onLoad="Initialize()" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">
<%
 String CodeFunz = Misc.nh(request.getParameter("CodeFunz"));
 String DescFunz = null , VarPath = null , MaxSizeUpl = null , strDett = "Seleziona File";
 String NameFileOut = null;

 if ( !CodeFunz.equals("")) {
  DB_WebUplFiles reWeb = remoteCtr_ElabAttive.getWebUpl(CodeFunz);
  DescFunz = reWeb.getDESC_FUNZ();
  VarPath = reWeb.getVAR_PATH_DOWNLOAD();
  MaxSizeUpl = reWeb.getLIM_MAX_SIZE_UPLOAD();
  NameFileOut =reWeb.getNAME_FILE_OUT();
  session.setAttribute("MaxSizeUpl", MaxSizeUpl);
  session.setAttribute("CodeFunz", CodeFunz);
  session.setAttribute("NameFileOut", NameFileOut);
 }
  %>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;
  
  function Initialize () {
      nascondi(document.frmDati.orologio);
<%      if ( CodeFunz != null && CodeFunz.equals("10038") ) { %>
      document.all('DescPerFileIN').innerText ="Il file di upload per il caricamento dei Materiali Sap deve essere nel formato .txt o un file .csv \n I Campi contenuti nel file devono essere separati da punto e virgola.";
<%}%>
<%    if ( CodeFunz != null && CodeFunz.equals("10044") ) { %>
      document.all('DescPerFileIN').innerText ="Il file di upload per il caricamento delle Tariffe deve essere nel formato .txt o un file .csv \n I Campi contenuti nel file devono essere separati da punto e virgola.";
<%}%>

<%    if ( CodeFunz != null && CodeFunz.equals("10046") ) { %>
      document.all('DescPerFileIN').innerText ="Il file di upload per il caricamento della Fattura/Nota credito manuale deve essere nel formato .txt o un file .csv \n I Campi contenuti nel file devono essere separati da punto e virgola.";
<%}%>

<%    if ( CodeFunz != null && CodeFunz.equals("10045") ) { %>
      document.all('DescPerFileIN').innerText ="Il file di upload per il caricamento delle Promozioni deve essere nel formato .txt o un file .csv \n I Campi contenuti nel file devono essere separati da punto e virgola.";
<%}%>

<%    if ( CodeFunz != null && CodeFunz.equals("10047") ) { %>
      document.all('DescPerFileIN').innerText ="Il file di upload per il caricamento delle Tariffe deve essere nel formato .txt o un file .csv \n I Campi contenuti nel file devono essere separati da punto e virgola.";
<%}%>

  }

  function lancio () {
    if(frmDati.FileDiUpload.value != '' && frmDati.FileDiUpload.value != null){
      frmDati.orologio.style.visibility="visible";
      frmDati.salva.style.visibility="hidden";
      frmDati.FileDiUpload.style.visibility="hidden";
      document.all('DescParam').innerText ="Upload In Corso";
      frmDati.submit();
    }else{
      alert('Selezionare il file.');
    }
  }

</SCRIPT>
<form name="frmDati" id="frmDati" align="center" method="POST" action="../../UplFiles" ENCTYPE="multipart/form-data" >
<input type=hidden name="VarPathUpl" value="<%=VarPath%>">
<input type=hidden name="MaxSizeUpl" value="<%=MaxSizeUpl%>">
<input type=hidden name="strDett" value="<%=strDett%>">

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
              <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"> <%=DescFunz%> </td>
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
<tr><td>
    <table align="center" border="0" style="border-collapse: collapse">
        <tr>
          <td align="center" colspan="2">
          		<img id="orologio" name ="orologio" src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
          </td>
        </tr>
        <tr>
        <td colspan="2" bgcolor="<%=StaticContext.bgColorHeader%>" class="white" align="center"><FONT id="DescParam" name="DescParam">Selezionare il File</FONT></td>
        </tr>
        <tr>
            <td>
              <input name="FileDiUpload" type="file">
            </td>
            <td align="center">
              <input type="button" name="salva" onclick="lancio();" value="UPLOAD">
            </td>
        </tr>
    </table>
    </td>
    </tr>
    <tr>
        <td align="center" class="text" >
          <FONT id="DescPerFileIN" name="DescPerFileIN">
         </FONT>
        </td>
    </tr>
  </table>
</form>
<SCRIPT>
</SCRIPT>
</body>
</html>