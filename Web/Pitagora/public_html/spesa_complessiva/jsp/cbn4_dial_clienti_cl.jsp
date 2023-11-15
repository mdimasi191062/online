<!-- import delle librerie necessarie -->
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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_dial_clienti_cl.jsp")%>
</logtag:logData>

<%
//dichiarazione variabili
int i = 0;
String strBgColor = "";

//response.addHeader("Pragma", "no-cache");
//response.addHeader("Cache-Control", "no-store");

//gestione Azione della pagina Lista o Inserimento
int intAction;
if(request.getParameter("intAction") == null){
	intAction = StaticContext.LIST;
}else{
	intAction = Integer.parseInt(request.getParameter("intAction"));
}%>

<html>
<head>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
</TITLE>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null ;
	function Initialize(){

	}

	//GESTIONE PULSANTI
	//+++++CONFERMA++++++
	function click_cmdConferma(){
		opener.dialogWin.returnedValue=1;
		opener.dialogWin.returnFunc();
		self.close();
	}
	//+++++ANNULLA++++++
	function click_cmdAnnulla(){
		opener.dialogWin.returnedValue=0;
		opener.dialogWin.returnFunc();
		self.close();
    }
</SCRIPT>
</head>

<body onload="Initialize();">
<form name="frmDati" method="post" action="">
	<!-- Immagine Titolo -->
	<table align="center" width="90%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td align="left"><img src="<%=StaticContext.PH_SPESACOMPLESSIVA_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
	  <tr>
	</table>
	
    <table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>">&nbsp;</td>
      </tr>
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Direzione Generale</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                        </tr>
                      </table>
                    </td>
                </tr>
            </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
        <td>
            <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                <tr>
                    <td width="100%" colspan="2" height="30" class="textB" align="left" valign="middle">&nbsp;TESTO_INTESTAZIONE_1</td>
                </tr>
                <tr>
                    <td width="100%" colspan="2" height="30" class="textB" align="left" valign="top">&nbsp;TESTO_INTESTAZIONE_2</td>
                </tr>
                <tr>
                    <td width="100%" colspan="2" height="20" class="textB" align="center">
						<table border="0" width="90%" cellspacing="1" align="center">
							<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
								<td width="100%" height="20" class="textB">&nbsp;Clienti</td>
							</tr>

							<tr>
								<td width="100%" height="15" bgcolor="<%=StaticContext.bgColorRigaPariTabella%>" class="text">&nbsp;Prova 1</td>
							</tr>
							<tr>
								<td width="100%" height="15" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="text">&nbsp;Prova 2</td>
							</tr>
							<tr>
								<td width="100%" height="15" bgcolor="<%=StaticContext.bgColorRigaPariTabella%>" class="text">&nbsp;Prova 3</td>
							</tr>
						</table>
					</td>
                </tr>
                <tr>
                    <td width="15%" height="30" class="textB" align="left" valign="bottom">&nbsp;Selezionare:</td>
                    <td width="85%" height="30" class="textB" align="left" valign="bottom">&nbsp;TESTO_MESSAGGIO_CONFERMA</td>
                </tr>
                <tr>
                    <td width="15%" height="30" class="textB" align="left" valign="middle">&nbsp;</td>
                    <td width="85%" height="30" class="textB" align="left" valign="middle">&nbsp;TESTO_MESSAGGIO_ANNULLAMENTO</td>
                </tr>
			</table>
        </td>
      </tr>
      <tr>
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
      </tr>
	  <tr>
	  	<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
              <tr>
                <td width="50%" class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">
					&nbsp;<input type="button" class="textB" name="cmdConferma" value="CONFERMA" onClick="click_cmdConferma();">
					&nbsp;<input type="button" class="textB" name="cmdAnnulla" value="ANNULLA" onClick="click_cmdAnnulla();">
				</td>
              </tr>
            </table> 
		</td>
	  </tr>
	</table>
</form>
</body>
</html>