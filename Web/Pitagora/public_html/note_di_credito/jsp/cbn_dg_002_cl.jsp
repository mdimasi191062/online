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
<%=StaticMessages.getMessage(3006,"cbn_dg_002_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto-->
<EJB:useHome id="homeEnt_Batch" type="com.ejbSTL.Ent_BatchHome" location="Ent_Batch" />
<EJB:useBean id="remoteEnt_Batch" type="com.ejbSTL.Ent_Batch" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch.create()%>" />
</EJB:useBean>

<%
//dichiarazioni delle variabili
int i=0;
String bgcolor = "";
String strMessaggio = Misc.nh(request.getParameter("messaggio"));
String strCodiceTipoContratto = Misc.nh(request.getParameter("strCodiceTipoContratto"));
String strCodeAccount = Misc.nh(request.getParameter("strCodeAccount"));
String strCodeElab = "";
if (strCodeAccount==""){
	strCodeAccount = null;
}
%>

<html>
<head>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<title>
		Verifica Batch Note di Credito - Account con elaborazione in batch corso
	</title>
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
</head>
<SCRIPT LANGUAGE="JavaScript">
	function click_cmdConferma(){
	}
	function click_cmdAnnulla(){
		self.close();
	}
</SCRIPT>
<body>
	<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
	  </tr>
	  <tr>
	    <td>
	      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
	        <tr>
	            <td>
	              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
	                  <tr>
	                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strMessaggio%></td>
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
			<table width="90%" cellspacing="1" align="center">
				<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
					<td width="100%" height="20" class="textB">&nbsp;Descrizione</td>
				</tr>
				<%  Vector vctAccount = null;
					vctAccount = null;
					out.println("strCodiceTipoContratto--"+strCodiceTipoContratto);
					out.println("<BR>");
					out.println("strCodeAccount--"+strCodeAccount);
					// carico il vettore
					vctAccount = remoteEnt_Batch.getElabBatchXLancio(StaticContext.LIST,strCodiceTipoContratto,strCodeAccount,strCodeElab,"");
					// se il vettore è stato caricato si prosegue con il caricamento della lista
					for(i =0; i < vctAccount.size(); i++){
						DB_Account lobj_Account = new DB_Account();
						lobj_Account = (DB_Account)vctAccount.elementAt(i);
				  		//cambia il colore delle righe
						if ((i%2)==0)
							bgcolor=StaticContext.bgColorRigaPariTabella;
				        else
							bgcolor=StaticContext.bgColorRigaDispariTabella;
						%>
						<tr bgcolor="<%=bgcolor%>">
							<td width="100%" height="20" class="text">&nbsp;<%=lobj_Account.getDESC_ACCOUNT()%></td>
						</tr>
<%					}%>
			</table>
		</td>
	  </tr>
	</table>

<!--PULSANTIERA-->
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
	<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td width="50%" class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
        <input class="textB" type="button" name="cmdConferma" value="CONFERMA" onClick="click_cmdConferma()">
    </td>
    <td width="50%" class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
        <input class="textB" type="button" name="cmdAnnulla" value="ANNULLA" onClick="click_cmdAnnulla()">
    </td>
  </tr>
</table> 

</body>
</html>