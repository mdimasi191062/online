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
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn_dg_003_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto-->
<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>

<%
//dichiarazioni delle variabili
int i=0;
String bgcolor = "";
String strMessaggio = Misc.nh(request.getParameter("messaggio"));
String strCodiceTipoContratto = Misc.nh(request.getParameter("strCodiceTipoContratto"));
String lstrCodeAccount="";
String lstrCodeFunz = Misc.nh(request.getParameter("strCodeFunz"));
%>

<html>
<head>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<title>
		Verifica Batch Note di Credito - Account con Nota di Credito non congelata
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
	function click_cmdChiudi()
	{
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
				<%
				   	Vector vctAccount = null;
					vctAccount = null;
					// carico il vettore
					vctAccount = remoteEnt_Contratti.getAccountAnomali(StaticContext.LIST,
                                                                        strCodiceTipoContratto,
                                                                        lstrCodeAccount,
                                                                        lstrCodeFunz);
						// se il vettore è stato caricato si prosegue con il caricamento della lista
						for(i =0; i < vctAccount.size(); i++)
              {
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
<%            }%>
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
    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
        <input class="textB" type="button" name="cmdChiudi" value="CHIUDI" onClick="click_cmdChiudi()">&nbsp;&nbsp;
    </td>
  </tr>
</table> 

</body>
</html>