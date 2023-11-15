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
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"ann_tutto_mas.jsp")%>
</logtag:logData>


<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>
<%
  int esito = 0;
  String messaggio = "";
  String codeAccount = Misc.nh(request.getParameter("txtCodiceAccount"));
  String codeIstanza = Misc.nh(request.getParameter("txtCodiceIstanza"));
  String dataInizioFatt = Misc.nh(request.getParameter("txtDataInizioFatt"));
  String dataFineAcq = Misc.nh(request.getParameter("txtDataFineAcq"));
  String tracciamento  = Misc.nh(request.getParameter("txtTracciamento"));
  String operazione = Misc.nh(request.getParameter("operazione"));  

  if(!operazione.equals(""))
  {

      esito = remoteCtr_Utility.annullaTutto(codeAccount,codeIstanza,dataInizioFatt,"H3",dataFineAcq,tracciamento);
      //esito = remoteCtr_Utility.annullaTutto(codeAccount,"H3",tracciamento);
      if(esito==1)
        messaggio = "Annullamento effettuato correttamente.";
      else
        messaggio = "Errore durante l'annullamento.";
   }
   
    String CodeFunz = StaticContext.RIBES_IMPORT_COD_INVENT;
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null;
	/*function initialize(){
  	objForm = document.frmDati;
		//impostazione delle propriet? di default per tutti gli oggetti della form
		setDefaultProp(objForm);
  }*/
var isnn,isie

if(navigator.appName=='Microsoft Internet Explorer') //check the browser
{
 isie=true;
}

if(navigator.appName=='Netscape')
{
 isnn=true; 
}

function nascondi(oggetto)
{
  
	if  (oggetto!="undefined" && oggetto!=null)
  {
    if (isie)
    {
    oggetto.style.visibility="hidden";
    Disable(oggetto);
    }
    else if (isnn)
    {    
        
        oggetto.visibility="hidden";
    }
   }
}
 
  function ONESEGUI()
{ 
        if(document.frmDati.txtCodiceAccount.value==''){
            alert('Digitare il Codice Account.');
            document.frmDati.comboServizi.focus();
        return;
        }
        
        if(document.frmDati.txtCodiceIstanza.value==''){
            alert('Digitare il Codice Istanza.');
            document.frmDati.comboServizi.focus();
        return;
        }   
        
        if(document.frmDati.txtDataInizioFatt.value==''){
            alert('Selezionare la Data Inizio Fatturazione.');
            document.frmDati.comboServizi.focus();
        return;
        } 

        if(document.frmDati.txtDataFineAcq.value==''){
            alert('Selezionare la Data Chiusura Acquisizione.');
            document.frmDati.comboServizi.focus();
        return;
        } 

        if(document.frmDati.txtTracciamento.value==''){
            alert('Digitare il codice Tracciamento.');
            document.frmDati.comboServizi.focus();
        return;
        }         
        
        document.frmDati.action = "ann_tutto_mas.jsp?operazione=1";
        document.frmDati.submit();
}


  function Initialize() {
      nascondi(document.frmDati.orologio);

      document.all('DescPerFileIN').innerText ="Il file di upload per il caricamento dei Codici Inventario deve essere nel formato .csv.";

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

</head>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<BODY onload = "Initialize();">
<table width="100%">
<td width=5%></td>
<td width=95%><img src="../images/AnnullaTutto.gif" alt="" border="0">
</td>
</table>
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<form name="frmDati" id="frmDati" align="center" method="POST" action="../../UplFilesAnnulla" ENCTYPE="multipart/form-data" >
<input type=hidden name="VarPathUpl" value="<%=VarPath%>">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="hidTypeLoad" value="">
<table name="tblElab" id="tblElab" align=center valign=top width="90%" border="0" cellspacing="0" cellpadding="0" style="display:none">
<!--  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0" ></td>
  </tr>
  -->
<tr>
  <td>
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


</TABLE>
</FORM>
</body>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  document.all('tblElab').style.display = '';

var http=getHTTPObject();

if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
</html>