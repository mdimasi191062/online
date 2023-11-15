<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"repricingCongelaTariffe.jsp")%>

</logtag:logData>
<%
  String data_ini_mmdd    = Utility.getDateMMDDYYYY();
 String desc_contratto=(String) request.getParameter("hidDescTipoContratto");
%>
<script>
function ONCONGELATARIFFE()
{
  divConferma.style.visibility='visible';
  divConferma.style.display='inline';
  pulsanteLancia.style.visibility='hidden';
  pulsanteLancia.style.display='none';
}

function onconferma()
{
 var carica = function(dati){gestisciMessaggioConFunzioneRitorno(dati[0].messaggio,'onnascondi();');};
 var errore = function(dati){gestisciMessaggioConFunzioneRitorno(dati[0].messaggio,'onnascondi();');};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 var sendMessage='codiceTipoContratto=1&codeFunz=28&codeTipoContr='+<%=request.getParameter("codiceTipoContratto")%>;
 chiamaRichiesta(sendMessage,'lancioBatchCongelaRepricing',asyncFunz);
}
function onnascondi()
{
    divConferma.style.visibility='hidden';
    divConferma.style.display='none'; 
    pulsanteLancia.style.visibility='visible';
  pulsanteLancia.style.display='inline';
}
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<link rel="body" type="text/html" href="orologio.html"/>
</head>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<body>
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio" style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" >
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
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td >
           					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Congela Tariffe Repricing Special:&nbsp; <%=desc_contratto%> </td>
                           <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                      </tr>
                      </table>
                </td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>


  </table>
          <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
  <tr>
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
    <div id="divConferma" name="divConferma" style="visibility:hidden;display:none">
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;La conferma comporterà l'eliminazione del flag repricing da tutte le tariffe di questo tipo contratto! Confermare?</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  <tr>
                  <td align='center'>
                     <input type="button" onclick="onconferma();" value="OK" text="OK"/>
                     <input type="button" onclick="onnascondi();" value="NO" text="NO"/>
                     </td>
                     <td align='center'>
                      
                    </td>
                  </tr>
                  </table>
     
       
    </div>
  </td>
  </tr>
  <tr>
    <td >
    <div id="pulsanteLancia" name="pulsanteLancia">
       <sec:ShowButtons VectorName="bottonSp" />
       </div>
    </td>
  </tr>
</TABLE>  
</form>
</body>
<script>
var http=getHTTPObject();
</script>
</html>
