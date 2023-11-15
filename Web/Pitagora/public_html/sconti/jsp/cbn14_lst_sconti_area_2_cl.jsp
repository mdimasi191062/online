<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
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
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<!-- inclusione della tagLib che permette l'instanziazione dell'oggetto remoto  -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>

<sec:ChkUserAuth />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn14_lst_sconti_area_2_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeEnt_Sconti" type="com.ejbSTL.Ent_ScontiHome" location="Ent_Sconti" />
<EJB:useBean id="remoteEnt_Sconti" type="com.ejbSTL.Ent_Sconti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Sconti.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
//dichiarazione variabili	
Vector lvct_Sconti = null;
int i=0;
String strNameFirstPage="cbn14_lst_sconti_area_2_cl.jsp";
String lstrTitolo = StaticContext.PH_SCONTI_IMAGES + "sconti.gif";
String strVALO_PERC = Misc.nh(request.getParameter("txtAPPO_VALO_PERC"));
String strOperazione = Misc.nh(request.getParameter("OPERAZIONE"));
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>Inserimento Sconto per Area Metropolitana</TITLE>
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
<Script language="JavaScript">
var objForm = null;
function initialize()
{
	objForm = document.frmDati;
	//impostazione delle propriet� di default per tutti gli oggetti della form
	setDefaultProp(objForm);
    // impostazione delle propriet� degli elementi di input per la validazione dei campi
			
			
	<%if(strOperazione.equalsIgnoreCase("Inserimento")){%>
		setObjProp(objForm.txtVALO_PERC,"label=Valore Percentuale|obbligatorio=si|tipocontrollo=intero|minnumericvalue=0|maxnumericvalue=100");
		setObjProp(objForm.txtVALO_LIM_MIN,"label=Limite Minimo|obbligatorio=si|tipocontrollo=intero|minnumericvalue=0|maxnumericvalue=100");
		setObjProp(objForm.txtVALO_LIM_MAX,"label=Limite Massimo|obbligatorio=no|tipocontrollo=intero|minnumericvalue=0|maxnumericvalue=100");
		Enable(objForm.SALVA);
		Disable(objForm.ELIMINA);
	<%}else if(strOperazione.equalsIgnoreCase("Aggiornamento")){%>
		setObjProp(objForm.txtVALO_LIM_MIN,"label=Limite Minimo|obbligatorio=si|tipocontrollo=intero|minnumericvalue=0|maxnumericvalue=100");
		setObjProp(objForm.txtVALO_LIM_MAX,"label=Limite Massimo|obbligatorio=no|tipocontrollo=intero|minnumericvalue=0|maxnumericvalue=100");
		Enable(objForm.SALVA);
		Disable(objForm.ELIMINA);
	<%}else if(strOperazione.equalsIgnoreCase("Eliminazione")){%>
		Disable(objForm.SALVA);
		Enable(objForm.ELIMINA);		
	<%}%>
}
function ONSALVA()
{
	var strURL = "<%=StaticContext.PH_SCONTI_JSP%>cbn14_lst_sconti_area_cl.jsp";
	strURL += "?OPERAZIONE=<%=strOperazione%>"
	objForm.action=strURL;
	
	
	if(validazioneCampi(objForm)){
		if(parseInt(objForm.txtVALO_LIM_MAX.value) < parseInt(objForm.txtVALO_LIM_MIN.value)){	
			alert("Attenzione! Il Limite Massimo deve essere maggiore uguale al Lilite Minimo.");
			setFocus(objForm.txtVALO_LIM_MAX);
		}
		objForm.submit();
	}
	
}
function ONELIMINA()
{
	var strURL = "<%=StaticContext.PH_SCONTI_JSP%>cbn14_lst_sconti_area_cl.jsp";
	strURL += "?OPERAZIONE=<%=strOperazione%>"
	objForm.action=strURL;
	if(validazioneCampi(objForm)){
		objForm.submit();
	}
}
</Script>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" method="post" action=''>
<!-- Immagine Titolo -->
<table align="center" width="70%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=lstrTitolo%>" alt="" border="0"></td>
  <tr>
</table>
<table align=center width="70%" border="0" >
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
	            <tr>
	              <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=strOperazione%> Sconto per Area Metropolitana</td>
	              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
	            </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  	<td align="center">
		<table width="50%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
		<tr>
			<td>
			    <table width="100%" border="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" cellspacing="0" cellpadding="2" align='center'>
					<%lvct_Sconti = (Vector)remoteEnt_Sconti.getSconti(strVALO_PERC);%>
					<%if(lvct_Sconti.size()==1){
						DB_Sconti objDBTipoContratto = new DB_Sconti();
				        objDBTipoContratto=(DB_Sconti)lvct_Sconti.elementAt(0);%>
					<tr>
						<td class="textB">Percentuale Sconto (%)</td>
						<%if(strOperazione.equalsIgnoreCase("Inserimento")){%>
							<td class="textNumber"><input type="text" name="txtVALO_PERC" size="5" maxlength="3" class="textNumber"></td>
						<%}else if(strOperazione.equalsIgnoreCase("Aggiornamento")){%>
							<td class="textNumber">&nbsp;<%=objDBTipoContratto.getVALO_PERC()%>&nbsp;<input type="hidden" value="<%=objDBTipoContratto.getVALO_PERC()%>" name="txtVALO_PERC" size="5" class="textNumber"></td>
						<%}else if(strOperazione.equalsIgnoreCase("Eliminazione")){%>
							<td class="textNumber">&nbsp;<%=objDBTipoContratto.getVALO_PERC()%>&nbsp;<input type="hidden" value="<%=objDBTipoContratto.getVALO_PERC()%>" name="txtVALO_PERC" size="5" class="textNumber"></td>
						<%}%>
					</tr>
					<tr>
						<td class="textB">Limite Minimo</td>
						<%if(strOperazione.equalsIgnoreCase("Inserimento")){%>
							<td class="textNumber"><input type="text" name="txtVALO_LIM_MIN" size="5" class="textNumber" maxlenght="3"></td>
						<%}else if(strOperazione.equalsIgnoreCase("Aggiornamento")){%>
							<td class="textNumber"><input type="text" name="txtVALO_LIM_MIN" size="5" value="<%=objDBTipoContratto.getVALO_LIM_MIN()%>" class="textNumber" obbligatorio="si" tipo="intero" minnumericvalue="0" maxnumericvalue="100" maxlenght="3"></td>
						<%}else if(strOperazione.equalsIgnoreCase("Eliminazione")){%>
							<td class="textNumber">&nbsp;<%=objDBTipoContratto.getVALO_LIM_MIN()%>&nbsp;</td>
						<%}%>
					</tr>
					<tr>
						<td class="textB">Limite Massimo</td>
						<%if(strOperazione.equalsIgnoreCase("Inserimento")){%>
							<td class="textNumber"><input type="text" name="txtVALO_LIM_MAX" size="5" class="textNumber" maxlenght="3"></td>
						<%}else if(strOperazione.equalsIgnoreCase("Aggiornamento")){%>
							<td class="textNumber"><input type="text" name="txtVALO_LIM_MAX" size="5" value="<%=objDBTipoContratto.getVALO_LIM_MAX()%>" class="textNumber" obbligatorio="si" tipo="intero" minnumericvalue="0" maxnumericvalue="100" maxlenght="3"></td>
						<%}else if(strOperazione.equalsIgnoreCase("Eliminazione")){%>
							<td class="textNumber">&nbsp;<%=objDBTipoContratto.getVALO_LIM_MAX()%>&nbsp;</td>
						<%}%>
					</tr>
					<%}%>
				</table>
			</td>
		</tr>
	</table>
   </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          	<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                <sec:ShowButtons td_class="textB"/>
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>
