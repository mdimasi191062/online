<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"shedulazione.jsp")%>
</logtag:logData>
<%
  String data_ini_mmdd    = Utility.getDateMMDDYYYY();
  String strUserName    = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
%>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/misc.js"></SCRIPT>


<SCRIPT LANGUAGE='Javascript'>
var pathImg = '<%=StaticContext.PH_COMMON_IMAGES%>';

function openSchedulazione(idMessag,codeElab,codeUtente,dataSched,nomeFile)
{
  divTabellaSched.style.display='none';
  divTabellaSched.style.visibility='hidden';
  divTabellaDett.style.display='inline';
  divTabellaDett.style.visibility='visible';
  document.formPag.idMessaggio.value=idMessag;
  document.formPag.codeElab.value=codeElab;
  document.formPag.codeUtente.value=codeUtente;
  document.formPag.dataSched.value=dataSched;
  document.getElementById('nomeFile').innerHTML = nomeFile;
  //document.formPag.nomeFile.value=nomeFile;
  //document.formPag.dataInizio.value=startTime;
  //document.formPag.dataFine.value=endTime;
 
  //document.formPag.txtDataFineCiclo.value;
  
  
 }

function caricaSftpSched()
{
  divTabellaSched.style.display='inline';
  divTabellaSched.style.visibility='visible';
  divTabellaDett.style.display='none';
  divTabellaDett.style.visibility='hidden';
  var headers=new Array("Id Messag","Code Elab","Code Utente","Data Schedulazione","File","Modifica");
  var campiFunction=new Array("Id Messag","Code Elab","Code Utente","Data Schedulazione","File");
  var carica = function(dati){riempiTabellaLinkMore(divTabellaSched,dati,headers,'Modifica',campiFunction,'openSchedulazione','Modifica');};
  var errore = function(dati){gestisciMessaggio(dati.messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('','listaSftpSched',asyncFunz);
  
}


function indietro()
{
    caricaSftpSched();
}

function modifica(azione)
{
      carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
      errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
      asyncFunz=  function(){ handler_generico(http,carica,errore);};
      var idMessag=document.formPag.idMessaggio.value;
      var dataSched=document.formPag.dataSched.value;
      chiamaRichiesta('azione='+azione+'&idMessag='+idMessag+'&dataSched='+dataSched,'modificaSftpSched',asyncFunz);
      
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
<body onload="caricaSftpSched();">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:hidden;display:none">
<form name="formPag" method="post">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.GIF" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Modifica Schedulazione Invio File</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
      
       <table width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
        <tr><td>
      <div id="divTabellaSched" name="divTabellaSched"></div>
      </td></tr>
       </table>
       <div id="divTabellaDett" name="divTabellaSched">
               <table width="80%" border="0" cellspacing="3" cellpadding="3" >
                <tr>
                    <td align="right" width="50%">Id Messaggio:</td>
                    <td align="left"><input id=idMessaggio"" name="idMessaggio" title="idMessaggio" type="text" class="text"  readonly/></td>
                </tr>
                <tr>
                    <td align="right" width="50%">Code Elab:</td>
                    <td align="left"><input id=codeElab"" name="codeElab" title="codeElab" type="text" class="text" readonly/></td>
                </tr>
                  <tr>
                    <td align="right" width="50%">Code Utente:</td>
                    <td align="left"><input id=codeUtente"" name="codeUtente" title="codeUtente" type="text" class="text" readonly/></td>
                </tr>
                  <tr>
                    <td align="right" width="50%">Data/Ora Schedulazione:</td>
                    <td align="left"> <input type="text" class="text" size=20 maxlength="20" name="dataSched" title="dataSched" value="" onblur="handleblur('data_ini');"> 
                                      <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
                                      <a href="javascript:cancelCalendar(document.formPag.dataSched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a></td>
                </tr>
                 <tr>
                    <td align="right" width="40%">File da inviare</td>
                    <td align="left" id="nomeFile"></td>
                </tr>
                
            <!--      <tr>
                    <td align="right" width="40%">Data Inizio:</td>
                    <td align="left"><input id=dataInizio"" name="dataInizio" title="dataInizio" type="text" class="text" readonly/></td>
                </tr>
                  <tr>
                    <td align="right" width="40%">Data Fine:</td>
                    <td align="left"><input id=dataFine"" name="dataFine" title="dataFine" type="text" class="text" readonly/></td>
                </tr>-->
                <tr>
                <td><input type="button" value="Indietro" onClick="indietro()"/></td>
                <td><input type="button" value="Salva Modifica" onClick="modifica(1)"/>&nbsp;
                <input type="button" value="Cancella Invio" onClick="modifica(2)"/>&nbsp;
                <input type="button" value="Invia Subito" onClick="modifica(3)"/></td>
                </tr>
               </table>
             
           </div>      
</table><br>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <sec:ShowButtons VectorName="vectorButton" />
    </td>
  </tr>
</table>
 <script language="JavaScript">
       var cal3 = new calendar1(document.forms['formPag'].elements['dataSched']);
       cal3.year_scroll = true;
			 cal3.time_comp = true;
 </script>
</form>
</div>
</body>
<script>
var http=getHTTPObject();
</script>
</html>