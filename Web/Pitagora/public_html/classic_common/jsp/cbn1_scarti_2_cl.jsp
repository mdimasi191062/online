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
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<EJB:useHome id="homeCtr_Scarti" type="com.ejbSTL.Ctr_ScartiHome" location="Ctr_Scarti" />
<EJB:useBean id="remoteCtr_Scarti" type="com.ejbSTL.Ctr_Scarti" scope="session">
    <EJB:createBean instance="<%=homeCtr_Scarti.create()%>" />
</EJB:useBean>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_scarti_2_cl.jsp")%>
</logtag:logData>

<%!
	String strParameterToLog = "";
	//costruzione di un vettore di databean dato un vettore di stringhe
	private Vector costruzioneVectorDataBean(Vector pvct_Account) throws Exception{
		Vector lvctReturn = new Vector();
		for (int j=0;j<pvct_Account.size();j++){
			String lstrAppoAccount = (String)pvct_Account.elementAt(j);
			DB_Scarti lobjAppoScarto = new DB_Scarti();
			Vector lvctAppoDatiAccount = Misc.split(lstrAppoAccount,"=");
			lobjAppoScarto.setCODE_SCARTO((String)lvctAppoDatiAccount.elementAt(0));
			lobjAppoScarto.setTIPO_FLAG_STATO_SCARTO((String)lvctAppoDatiAccount.elementAt(1));
			lvctReturn.addElement(lobjAppoScarto);
		}
		return lvctReturn;
	}
%>
<%
	int intAction;
	int intFunzionalita;
	intAction = Integer.parseInt(request.getParameter("intAction"));
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	Vector lvct_Account = new Vector();
	//Lista Account!
	String lstr_CodiciAccount = Misc.nh(request.getParameter("hidViewState"));
	lvct_Account = Misc.split(lstr_CodiciAccount,"|");
	lvct_Account = costruzioneVectorDataBean(lvct_Account);
    String lstr_Message = "";%>
	
	<%  strParameterToLog = Misc.buildParameterToLog(lvct_Account);
		String strLogMessage = "remoteCtr_Scarti.updScarti(" + strParameterToLog + ")";%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3504,strLogMessage)%>
	</logtag:logData>
	<%lstr_Message = remoteCtr_Scarti.updScarti(lvct_Account);
	if(lstr_Message.equals(""))
	{
		lstr_Message = "Aggiornamento avvenuto con successo!";
		strLogMessage += " : Successo" ;
	}
	else{
		strLogMessage += " : " + lstr_Message ;
	}
%>
	<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3504,strLogMessage)%>
	</logtag:logData>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title>SCARTI</title>
<script language="javascript">
    function click_Chiudi()
    {
        self.close();
    }
</script>
</HEAD>
<BODY>



<TABLE align="center" border="0" cellPadding="0" cellSpacing="0" width="100%">
  <TR>
    <td valign="top"><img src="../../common/images/body/pixel.gif" width="6" height="10"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0" width="500">
        <TR>
          <TD vAlign="top" width="80"><IMG border="0" height="35" src="../../common/images/body/info.gif" width="80"></TD>
          <td width="420" valign="top"><img src="../../common/images/body/pixel.gif" width="420" height="35"></td>
        <TR>
      </TABLE>
      <TABLE bgColor="#ffffff" border="0" cellPadding="1" cellSpacing="0" width="502">
        <TR>
          <TD bgColor="#ffffff"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#006699" border="0" cellPadding="1" cellSpacing="0" width="502">
        <TR>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="502">
              <TR>
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; 
                Informazione</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="../../common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <TD class='white' align='center'>Attenzione!</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>&nbsp;<%=lstr_Message%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white'>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE>
          </TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
          <TD><IMG align="right" src="../../common/images/body/log3.gif"></TD>
        </TR>
        <TR>
          <TD COLSPAN="5">&nbsp; </TD>
        </TR>
        <TR>
          <TD bgColor="#ffffff" COLSPAN="5"><IMG height="3" src="pixel.gif" width="1"></TD>
        </TR>
        <tr>
          <td COLSPAN="5">
            <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500">
              <tr>
                <td align="center">
                  <input type="button" class="textB" name="cmdChiudi" value="Chiudi" onclick="click_Chiudi()">
                </td>
              </tr>
            </TABLE>
          </td>
        </tr>
      </TABLE>
    </TD>
  </TR>
  <tr><td>&nbsp;</td></tr>
  </TABLE>
</form>


</BODY>
</HTML>