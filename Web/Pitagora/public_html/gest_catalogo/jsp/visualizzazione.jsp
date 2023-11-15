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
<%@ page import="com.usr.*"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"visualizzazione.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">
    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>
<%

%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
</TITLE>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  var objXmlPreOff = null;
  var objXmlPreServ = null;
  var objXmlPreCaratt = null;
  var valCboPreOfferte = '';
  var valCboPreServizi = '';

  var objWindows = null;

  function Initialize() {

    objXmlPreServ    = CreaObjXML();
    objXmlPreOff     = CreaObjXML();
    objXmlPreCaratt  = CreaObjXML();

    objXmlPreServ.loadXML('<MAIN><%=remoteEnt_Catalogo.getPreServiziXml()%></MAIN>');
    objXmlPreOff.loadXML ('<MAIN><%=remoteEnt_Catalogo.getPreOfferteXml()%></MAIN>');

    CaricaComboDaXML(frmDati.cboPreOfferte,objXmlPreOff.documentElement.selectNodes('OFFERTA'));

	}


  function change_cboPreOfferte(){

      if (valCboPreOfferte!=frmDati.cboPreOfferte.value){
        valCboPreOfferte=frmDati.cboPreOfferte.value;
      }
      else valCboPreOfferte = '';
  }

  function ONSELEZIONA () {
      if ( valCboPreOfferte == '' ) {
        alert ('Selezionare Un offerta');
        return;
      }
      ONGENERA();
  }

  /* funzione per il lancio dell'espora catalogo dopo aver generato il relativo xml */
  function ONSELEZIONA_LANCIO () {
    var URL;
    URL = 'NavigatoreCatalogo.jsp' + '?Offerta=' + valCboPreOfferte;
    objWindows = window.open(URL,'NavCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
  }


  /* funzione per la generazione degli xml */
  function ONGENERA () {
    var URL;
    URL = 'GeneraXml.jsp?offerta='+valCboPreOfferte;
    openDialog(URL , 400, 200,"");
  }

</script>

</HEAD>
<BODY onload="Initialize();" onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">

<form name="frmDati" method="post" action="">
<TABLE align="center" width="95%" border="0" cellspacing="0" cellpadding="0" >
      <TR height="35">
        <TD>
          <TABLE align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
            <TR>
              <TD align="left">
                <IMG alt="" src="../images/catalogo.gif" border="0">
              </TD>
            </TR>
          </table>
        </td>
      </tr>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>" rules="rows" frame="box" bordercolor="<%=StaticContext.bgColorHeader%>" height="100%">
            <TR align="center">
              <TD class="white" >
                ESPLORA CATALOGO
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>"  align="center" width="9%">
                <IMG alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28">
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
<tr height="35">
  <td>
    <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
      <tr>
        <td>
         <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
          <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"> Offerta  </td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
          </tr>
         </table>
        </td>
      </tr>
    </table>
  </td>
</tr>      
<tr>
  <td>
    <table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
        <td width="25%" class="textB" align="right">Offerta&nbsp;&nbsp;</td>
        <td >
          <select class="text" title="Offerte" name="cboPreOfferte" onchange="change_cboPreOfferte();" >
             <option class="text"  value="">[Seleziona Offerte]</option>
          </select>
        </td>
      </tr>
    </table>
  </td>
</tr>
<!-------- fine caricamento -----------!-->
<TR height="3">
  <TD></TD>
</TR>
<TR height="30">
  <TD>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
    <tr>
      <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
        <sec:ShowButtons td_class="textB"/>
      </td>
    </tr>
  </table>
  </TD>
</TR>
</TABLE>
</form>
</BODY>
</HTML>