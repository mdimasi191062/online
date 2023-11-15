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
<%@ page import="com.ejbSTL.Ent_OggettiFatturazione"%>
<%@ page import="com.ejbSTL.Ent_OggettiFatturazioneHome"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<%@ page import="com.utl.*" %>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"PP_Combo_OggettiFatturazione_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeFatt" type="com.ejbSTL.Ent_OggettiFatturazioneHome" location="Ent_OggettiFatturazione" />
<EJB:useBean id="remoteEnt_OggettiFatturazione" type="com.ejbSTL.Ent_OggettiFatturazione" scope="session">
    <EJB:createBean instance="<%=homeFatt.create()%>" />
</EJB:useBean>
<%
  //gestione Azione della pagina Lista o Inserimento
	int intAction;
	if(request.getParameter("intAction") == null){
		intAction = StaticContext.LIST;
	}else{
		intAction = Integer.parseInt(request.getParameter("intAction"));
	}
	int intFunzionalita;
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
	
	String strCodeTipoContratto = Misc.nh(request.getParameter("CodeTipoContratto"));
	String strCodeCliente = Misc.nh(request.getParameter("CodeCliente"));
	String strCodeContr = Misc.nh(request.getParameter("CodeContr"));
	String strCodePs = Misc.nh(request.getParameter("CodePs"));
	String strCodePrestAgg = Misc.nh(request.getParameter("CodePrestAgg"));
	String strCodeClasse = Misc.nh(request.getParameter("CodeClasse"));
	String strNomeCombo = Misc.nh(request.getParameter("nomeComboOggFat"));
	String strValueDescOggFat= "";
	String strValueCodeOggFat= "";
	
	Vector lvctOggFatt = remoteEnt_OggettiFatturazione.getOggFatturazione(intAction,
																			  intFunzionalita,
																			  strCodeTipoContratto,
																			  strCodeCliente,
																			  strCodeContr,
																			  strCodePs,
																			  strCodePrestAgg,
																			  strCodeClasse);
	if (lvctOggFatt!=null)
	{
		for(int i=0;i<lvctOggFatt.size();i++)
	  	{
	    	DB_OggettoFatturazione lobjOggFatt=(DB_OggettoFatturazione)lvctOggFatt.elementAt(i);
	    	if (strValueDescOggFat=="")
	    	{
	      		strValueDescOggFat=lobjOggFatt.getDESC_OGG_FATRZ();//+" - "+lobjOggFatt.getCODE_OGG_FATRZ();
	      		strValueCodeOggFat=lobjOggFatt.getCODE_OGG_FATRZ()+"$"+lobjOggFatt.getCODE_CLAS_OGG_FATRZ()+"$"+lobjOggFatt.getDATA_INIZIO_VALID_OF()+"$"+lobjOggFatt.getDATA_FINE_VALID_OF();
			}
	    	else
	    	{
	      		strValueDescOggFat+="|"+lobjOggFatt.getDESC_OGG_FATRZ();//+" - "+lobjOggFatt.getCODE_OGG_FATRZ();
	      		strValueCodeOggFat+="|"+lobjOggFatt.getCODE_OGG_FATRZ()+"$"+lobjOggFatt.getCODE_CLAS_OGG_FATRZ()+"$"+lobjOggFatt.getDATA_INIZIO_VALID_OF()+"$"+lobjOggFatt.getDATA_FINE_VALID_OF();
	    	}
	  	}
	}
%>
<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<TITLE>CARICAMENTO IN CORSO...</TITLE>
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
<SCRIPT LANGUAGE='Javascript'>
function SubmitMe()
{
	if (opener && !opener.closed) 
	{
		opener.dialogWin.state="0";
		opener.insertAll('<%=strNomeCombo%>','<%=strValueDescOggFat%>','<%=strValueCodeOggFat%>');
		opener.dialogWin.returnedValue=0;//seleziono il primo valore;
		opener.dialogWin.returnFunc();
	}
	else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
 	closeWindow();
}
</SCRIPT>
</HEAD>
<BODY  onload="window.setTimeout(SubmitMe, 2000);setInterval('recursiveCloseWindow()',1000);">
<form name="frmDati" method="post">
	<center>
		<font class="red">CARICAMENTO IN CORSO...</font><br>
		<img src="<%=StaticContext.PH_CLASSIC_COMMON_IMAGES%>orologio.gif" width="60" height="50" alt="" border="0">
	</center>
</form>
</BODY>
</HTML>

