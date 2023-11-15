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
<%@ page import="com.ejbSTL.Ent_PrestazioniAggiuntive" %>
<%@ page import="com.ejbSTL.Ent_PrestazioniAggiuntiveHome" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_sel_ps_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="Ent_PrestazioniAggiuntive" type="com.ejbSTL.Ent_PrestazioniAggiuntiveHome" location="Ent_PrestazioniAggiuntive" />
<EJB:useBean id="remoteEnt_PrestazioniAggiuntive" type="com.ejbSTL.Ent_PrestazioniAggiuntive" scope="session">
    <EJB:createBean instance="<%=Ent_PrestazioniAggiuntive.create()%>" />
</EJB:useBean>
<%

String strCodePS = request.getParameter("CodPSSel");// codice del prodotto/servizio
String strCodContrSel = request.getParameter("CodeContr");//codice contratto
String strCodeTipoContratto = request.getParameter("hidCodiceTipoContratto");
String strCodeCliente = Misc.nh(request.getParameter("CodeCliente"));
String strNomeCombo = Misc.nh(request.getParameter("nomeCombo"));
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
Vector prestaggVector=null;
prestaggVector = remoteEnt_PrestazioniAggiuntive.getPrestazioniAggiuntive(intAction,
                                                                          intFunzionalita,
                                                                          strCodePS,
                                                                          strCodContrSel,
                                                                          strCodeTipoContratto,
                                                                          strCodeCliente);
String strReturnValueDesc= "";
String strReturnValueCode= "";
if (prestaggVector!=null)
{
  
  for(Enumeration e = prestaggVector.elements();e.hasMoreElements();)
  {
    DB_PrestazioniAggiuntive lobj_PA=new DB_PrestazioniAggiuntive();
    lobj_PA=(DB_PrestazioniAggiuntive)e.nextElement();
    if (strReturnValueDesc=="")
    {
      strReturnValueDesc=lobj_PA.getDESC_PREST_AGG();
      strReturnValueCode=lobj_PA.getCODE_PREST_AGG();//+"$"+lobj_PA.getCODE_PR_PS_PA_CONTR();
    }
    else
    {
      strReturnValueDesc+="|"+lobj_PA.getDESC_PREST_AGG();
      strReturnValueCode+="|"+lobj_PA.getCODE_PREST_AGG();//+"$"+lobj_PA.getCODE_PR_PS_PA_CONTR();
    }
  }
}
%>

<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>Selezione Prodotto/Servizio</TITLE>
<script src="../../common/js/misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE='Javascript'>
	function initialize()
	{
		  setInterval("recursiveCloseWindow()",1000);
		  if (opener && !opener.closed) 
	      {
	        opener.insertAll("<%=strNomeCombo%>","<%=strReturnValueDesc%>","<%=strReturnValueCode%>");
	        opener.dialogWin.returnFunc();
	      }
	      else{
			alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	      }
		  closeWindow(); 
	}
	
</SCRIPT>
</HEAD>
<BODY onload="initialize()">

</BODY>
</HTML>
