<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ListaAssOfPsWfSp.jsp")%>
</logtag:logData>

<%
String act        = request.getParameter("act");
String codOf      = request.getParameter("codOf");
String codPs      = request.getParameter("codPs");
String codCOf     = request.getParameter("codCOf");
String dataIniOf    = request.getParameter("dataIni");
String dataIniOfPs  = request.getParameter("dataIniOf");
String dataFineOfPs = request.getParameter("dataFineOf");
String codModal   = request.getParameter("codModal");
String codFreq    = request.getParameter("codFreq");
String flag       = request.getParameter("flag");
String shift      = request.getParameter("shift");
int numTariffe=0;

if(act!=null)
{
      // Creazione oggetto
      GestAssOfPsBMPPK pk = new GestAssOfPsBMPPK();
      pk.setCodeOf(codOf);
      pk.setCodePs(codPs);
      pk.setCodeCOf(codCOf);
      pk.setDataIni(dataIniOf);
      pk.setDataIniOfPs(dataIniOfPs);
      pk.setDataFineOfPs(dataFineOfPs);
      pk.setCodModalAppl(codModal);
      pk.setCodFreq(codFreq);
      pk.setFlag(flag);
      pk.setShift(shift);

      if((act.equals("disattiva"))||(act.equals("cancella")))
      {%>
      <EJB:useHome id="homeGestAss" type="com.ejbBMP.GestAssOfPsBMPHome" location="GestAssOfPsBMP" />
      <EJB:useBean id="remoteGestAss" type="com.ejbBMP.GestAssOfPsBMP" value="<%=homeGestAss.findByPrimaryKey(pk)%>" scope="session"></EJB:useBean>
    <%
       numTariffe=remoteGestAss.getNumTariffe();
    }//disattiva o cancella
} //if(act!=null)

%>

<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
	<TITLE>ELABORAZIONE IN CORSO...</TITLE>
	<!--script src="../../common/js/calendar.js" type="text/javascript"></script>
  <script src="../../common/js/comboCange.js" type="text/javascript"></script>
  <script src="../../common/js/changeStatus.js" type="text/javascript"></script!-->
  <script src="../../common/js/openDialog.js" type="text/javascript"></script>
  <script src="../../common/js/validateFunction.js" type="text/javascript"></script>
<SCRIPT LANGUAGE='Javascript'>

function SubmitMe()
{
<%
 if ((act!=null)&& (act.equals("disattiva"))||(act.equals("cancella")))
  {%>
    if (opener && !opener.closed)
    {
    opener.numTariffe=<%=numTariffe%>;
    opener.dialogWin.returnFunc();
    }
    else
    {  
		   alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
   	}
<%}%> 
  //chiusura window
  self.close();
}
</SCRIPT>
</HEAD>






<BODY  onload="window.setTimeout(SubmitMe, 2000)">
<center>
<form name="frmDati" method="post">
	<center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
	</center>
</form>
</BODY>
</HTML>
