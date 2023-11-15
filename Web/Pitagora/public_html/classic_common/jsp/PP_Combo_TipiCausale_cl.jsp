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
<%@ page import="com.ejbSTL.Ent_TipiCausale"%>
<%@ page import="com.ejbSTL.Ent_TipiCausaleHome"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.utl.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"PP_Combo_TipiCausale_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.Ent_TipiCausaleHome" location="Ent_TipiCausale" />
<EJB:useBean id="remoteEnt_TipiCausale" type="com.ejbSTL.Ent_TipiCausale" scope="session">
    <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  //gestione Azione della pagina Lista o Inserimento
 int intAction;
 Vector lvctData = null ;
 int i = 0;
    System.out.println("QUERYSTRING: " + request.getQueryString());
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
 String strCodeOggFatt = Misc.nh(request.getParameter("CodeOggFatt"));
 String strNomeCombo = Misc.nh(request.getParameter("nomeComboTipoCaus"));
 String strValueDescTipoCaus = "";
 String strValueCodeTipoCaus = "";
    
Vector lvct_TipiCausali = remoteEnt_TipiCausale.getTipiCausale(intAction,
                                                              intFunzionalita,
                                                              strCodePs,
                                                              strCodeCliente,
                                                              strCodeContr,
                                                              strCodePrestAgg,
                                                              strCodeTipoContratto,
															  strCodeOggFatt); 
  if (lvct_TipiCausali!=null)
  {
    for(i=0;i<lvct_TipiCausali.size();i++)
    {
      DB_TipoCausale myelement = new DB_TipoCausale();
      myelement=(DB_TipoCausale)lvct_TipiCausali.elementAt(i);
      if (strValueDescTipoCaus=="")
      {
        if(myelement.getCODE_TIPO_CAUS().equals("5")){//AMPLIAMENTO/DECREMENTO
			strValueDescTipoCaus="AMPLIAMENTO";
		}else{
			strValueDescTipoCaus=myelement.getDESC_TIPO_CAUS();
		}
		strValueCodeTipoCaus=myelement.getCODE_TIPO_CAUS();//+"$"+myelement.getCODE_PR_PS_PA_CONTR()+"$"+myelement.getDATA_INIZIO_VALID_OF()+"$"+myelement.getDATA_INIZIO_VALID_OF_PS();
      }
      else
      {
	  	if(myelement.getCODE_TIPO_CAUS().equals("5")){//AMPLIAMENTO/DECREMENTO
			strValueDescTipoCaus+="|AMPLIAMENTO";
		}else{
			strValueDescTipoCaus+="|"+myelement.getDESC_TIPO_CAUS();
		}
        strValueCodeTipoCaus+="|"+myelement.getCODE_TIPO_CAUS();//+"$"+myelement.getCODE_PR_PS_PA_CONTR()+"$"+myelement.getDATA_INIZIO_VALID_OF()+"$"+myelement.getDATA_INIZIO_VALID_OF_PS();
      }
    }
  }
  %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
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
		opener.insertAll('<%=strNomeCombo%>','<%=strValueDescTipoCaus%>','<%=strValueCodeTipoCaus%>');
		opener.dialogWin.returnedValue=1;
		opener.dialogWin.returnFunc();
	}
	else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
  	closeWindow();
}
</SCRIPT>
</HEAD>
<BODY onload="window.setTimeout(SubmitMe, 2000);setInterval('recursiveCloseWindow()',1000);">
<form name="frmDati" method="post">
	<center>
		<font class="red">CARICAMENTO IN CORSO...</font><br>
		<img src="<%=StaticContext.PH_CLASSIC_COMMON_IMAGES%>orologio.gif" width="60" height="50" alt="" border="0">
	</center>
</form>
</BODY>
</HTML>

