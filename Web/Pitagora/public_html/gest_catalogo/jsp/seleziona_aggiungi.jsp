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
<%=StaticMessages.getMessage(3006,"sel_upload.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>

<%
  String strCode = "";
  String strDesc = "";
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
</head>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">

  var objForm = null;
  
  function ONSELEZIONA () {
    var URL = '';
    var URL_Param = '';

    if (frmDati.CodeSel.value == '' ) {
      alert ('Occorre Selezionare un Elemento');
      return;
    }

    if ( '1' == objForm.CodeSel.value ) {
        opener.frmDati.nodo.value = 'COMPONENTI';
    }
    else if ( '2' == objForm.CodeSel.value ) {
            opener.frmDati.nodo.value = 'PRESTAZIONI';
         } else {
            opener.frmDati.nodo.value = '';
         }

    window.close();

    /* Richiamo aggiornamento dati dell'opener */
    opener.ONAGGIUNGI();

  }

  function initialize()
  {
    objForm = document.frmDati;
  }
  
  function ChangeSel(codiceaccount,indice)
  {
    objForm.CodeSel.value=codiceaccount;
    objForm.DescSel.value=eval('objForm.SelFunz[indice].value');
  }
</SCRIPT>
<body onload="initialize()">
<form name="frmDati" method="post" action="">
<input type=hidden name="CodeSel" value="<%=strCode%>">
<input type=hidden name="DescSel" value="<%=strDesc%>">

    <TABLE width="90%" height="100%" border="0" cellspacing="0" cellpadding="1" align="center">
      <tr height="20">
        <TD>
           <IMG alt="" src="../images/catalogo.gif" border="0">
        </TD>
      </tr>
      <TR >
        <TD>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">

              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">AGGIUNGI...</TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="20">
        <TD>
          <TABLE width="90%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white"/>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <tr> <td>
<TABLE width="70%" border="0" cellspacing="1" cellpadding="1" align="center">
  <TR align="center">
     <TD width="2%"> </TD>
     <TD class="rowHeader" width="50%" align="center" nowrap>Cosa si desidera Associare? </TD>
  </TR>
    <TR class="row2" align="center" height="20">
      <TD width="2%">
      <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' name='SelFunz' value='Componente' onclick=ChangeSel('1','1')>
      </TD>
      <TD align="left" align="right"> Componente</TD> 
    </TR>
    <TR class="row1" align="center" height="20">
      <TD width="2%">
      <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' name='SelFunz' value='Prestazione Aggiuntiva' onclick=ChangeSel('2','1')>
      </TD>
      <TD align="left" align="right"> Prestazione Aggiuntiva</TD> 
    </TR>
</TABLE>
</td> </tr> 
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
</body>
</html>
