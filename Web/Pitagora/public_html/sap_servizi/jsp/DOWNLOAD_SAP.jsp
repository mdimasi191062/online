<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive"/>
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
  <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>"/>
</EJB:useBean>
<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"DOWNLOAD_SAP.jsp")%>
</logtag:logData>

<%
String path       = "";
String nomeFile   = "";
String download = Misc.nh(request.getParameter("download"));
String pathDownload = Misc.nh(request.getParameter("path"));
String listafile = Misc.nh(request.getParameter("listafile"));
String[] Arrlistafile;

%>

<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE='Javascript' type="text/javascript">

 var objForm = null;
 objForm = document.formPag;
 
function ONESEGUI(){
  var trovato=false;
  var operazione = "";
  var contSelezionati=0;
  for (var i=0;i<document.formPag.comboNomeFile.length;i++)
  {
    if ((document.formPag.comboNomeFile[i].selected))
    {
        trovato = true;
        contSelezionati++;
    }
  }

  if  (!trovato)  {
    alert("Selezionare almeno un file dalla lista");
    document.formPag.comboNomeFile.focus();
    return;
  }
  
  var listafile=new Array();
  for (var i=0;i<document.formPag.comboNomeFile.length;i++){
      if ((document.formPag.comboNomeFile[i].selected)) 
      {
        var nomeFile=document.formPag.comboNomeFile.options[i].text;
        var comboNome=document.formPag.comboNomeFile.options[i].value;
        document.formPag.nomeFileHidden.value=nomeFile;
        var nomecompleto = comboNome+"/"+nomeFile;
        listafile.push(nomecompleto);
      }
  }
  
      var path = document.formPag.comboNomeFile.options[0].value;
      if (contSelezionati>1)
      {
      document.formPag.OperazioneHidden.value = "1";
      }
      else
      {
      document.formPag.OperazioneHidden.value = "0";
      }
      document.formPag.ListaFileHidden.value = listafile;
      //document.formPag.action="DOWNLOAD_SAP.jsp?download=1&listafile="+listafile+"&path="+path;
      //document.formPag.submit();
      document.formPag.action="../../elab_attive/jsp/resocontoDownload.jsp";
        document.formPag.method="POST";
        document.formPag.submit();
}
function aggiornaElencoFile(codiceFunzione)
{
 document.formPag.comboNomeFile.length=0;
 var carica = function(dati){riempiSelect('comboNomeFile',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 indiceCiclo= document.formPag.ciclo.selectedIndex;
 //indicecomboServizio= document.formPag.comboServizio.selectedIndex;
 if (indiceCiclo > 0)
 {
    var appociclo = document.formPag.ciclo.options[indiceCiclo].text;
    var apposervizio = "7"; //document.formPag.comboServizio.options[indicecomboServizio].value;
    chiamaRichiesta('codiceFunzione='+codiceFunzione+apposervizio+appociclo,'ElencoFileDownloadJPUB2',asyncFunz);
 }
}
function ElencoFile(codiceFunzione)
{
 document.formPag.comboNomeFile.length=0;
 var carica = function(dati){riempiSelect('comboNomeFile',dati);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 chiamaRichiesta('codiceFunzione='+codiceFunzione+'7'+'Gennaio - 1994','ElencoFileDownloadJPUB2',asyncFunz);
}

function gestisciMessaggio(messaggio)
{
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';  
}

</SCRIPT>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
 <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>

<body onload="ElencoFile('DOWNLOAD_SAPSP')">
<div id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio" action="">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div id="maschera" style="visibility:hidden;display:none">
<form name="formPag" method="post" action="" target="_blank">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3" alt=""></td>
  </tr>
  <tr>
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
                    <td class="textB">Ciclo fatturazione: </td>
                    <td bgcolor="<%=StaticContext.bgColorTabellaGenerale%>"> 
                      <Select name="ciclo" id="ciclo" class="text" label="Ciclo di riferimento" onchange="aggiornaElencoFile('DOWNLOAD_SAPSP');">
                      <%
                      Vector vctPeriodoRif = null;
                      DB_PeriodoRiferimento objPeriodoRif = null;
                      vctPeriodoRif = remoteCtr_Utility.getPeriodoRiferimento("getCicliSapSp");
                      String strCmbValue = "[Ciclo di Riferimento]";
                      %>
                        <option value=""><%=strCmbValue%></option>
                        <%
                        for(int z=0;z<vctPeriodoRif.size();z++){
                          objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                          if(objPeriodoRif.getCODE_CICLO().equals("999"))
                            objPeriodoRif.setCODE_CICLO("A");
                          %>
                          <option value="<%=objPeriodoRif.getCODE_CICLO()%>">
                            <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                          </option>
                          <%
                        }
                      %>
                      </Select>
                    </td>
       </tr>
        <tr HEIGHT='15px'>
            <td class="textB" width="20%"></td>
            <td class="text" width="25%"></td>
            <td class="textB" width="10%"></td>
            <td class="text" width="50%"></td>
        </tr>
        </table>    
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Resoconti SAP</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28" alt=""></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="5" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
          <td class="textB" width="20%">Seleziona File</td>
          <td width="80%"><select name="comboNomeFile" multiple class="text" size="12" style="width: 100%;"></select><input type="hidden" id="nomeFileHidden" name="nomeFileHidden"/>
          <input type="hidden" id="ListaFileHidden" name="ListaFileHidden"/>
          <input type="hidden" id="OperazioneHidden" name="OperazioneHidden"/>
          </td>
        </tr>              
		 	</table>
    </td>
  </tr>
</table>
</form>

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <input type="button" class="textB" name="Download" value="Download" onclick="ONESEGUI()">
    </td>
  </tr>
</table>

</div>
<script language="javascript" type="text/javascript">
var http=getHTTPObject();


</script>
</body>
</html>

