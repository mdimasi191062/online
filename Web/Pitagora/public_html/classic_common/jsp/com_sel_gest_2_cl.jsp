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
<%@ page import="com.ejbSTL.Ent_Contratti"%>
<%@ page import="com.ejbSTL.Ent_ContrattiHome"%>
<%@ page import="com.utl.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth isModal="true"/>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"com_sel_gest_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  //PARAMETRI DI INPUT DELLA PAGINA++++++++++++++++++++++++++++++
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
  String strCodClienteSel = request.getParameter("CodClienteSel");
  String lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
  String lstrNomeCombo = request.getParameter("nomeCombo");
  //FINE PARAMETRI DI INPUT DELLA PAGINA++++++++++++++++++++++++++++++  
  Vector contrattoVector;
  contrattoVector = remoteEnt_Contratti.getContratti(intAction,intFunzionalita,strCodClienteSel,lstrCodiceTipoContratto);
  remoteEnt_Contratti.remove();
  String strReturnValueDesc= "";
  String strReturnValueCode= "";
  
  if (contrattoVector!=null)
  {
    
    for(Enumeration e = contrattoVector.elements();e.hasMoreElements();)
    {
      DB_Contratto myelement=new DB_Contratto();
      myelement=(DB_Contratto)e.nextElement();
      if (strReturnValueDesc=="")
      {
        strReturnValueDesc=myelement.getDESC_CONTR();
        strReturnValueCode=myelement.getCODE_CONTR();
      }
      else
      {
        strReturnValueDesc+="|"+myelement.getDESC_CONTR();
        strReturnValueCode+="|"+myelement.getCODE_CONTR();
      }
    }
  }
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>Selezione Clienti</TITLE>
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
	function initialize(){
		 setInterval("recursiveCloseWindow()",1000);
		if (window.opener && !window.opener.closed) 
	    {
	        window.opener.insertAll("<%=lstrNomeCombo%>","<%=strReturnValueDesc%>","<%=strReturnValueCode%>");
	        opener.dialogWin.returnFunc();
	    }
	    else {
	        alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	    }
	    closeWindow(); 
	}
</SCRIPT>
</HEAD>
<BODY onload="initialize()">

</BODY>
</HTML>
