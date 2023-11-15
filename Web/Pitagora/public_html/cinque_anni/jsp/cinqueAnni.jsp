<!-- import delle librerie necessarie -->
<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>

<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cinqueAnni.jsp")%>
</logtag:logData>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/json2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/cinqueAnni.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>

<HTML>
  <HEAD>
  <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
  <TITLE>Selezione Cinque Anni</TITLE>
  <Script language="JavaScript">
 
  </Script>
  </HEAD>
  <BODY onload="caricaList()">
    <div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
      <form id="frmMessaggio" name="frmMessaggio">
        <%@include file="../../common/htlm_ajax/messaggio.html"%>
      </form>
    </div>
    <div name="orologio" id="orologio">
      <%@include file="../../common/htlm_ajax/orologio.html"%>
    </div>
    <div name="maschera" id="maschera">
      <form name="formPag" method="post" action=''>
        <table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="left"><img src="../images/titoloPagina.gif" alt="" border="0"></td>
          <tr>
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
                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
                      
                        <div id="PageTitle" name="PageTitle" />
                                             </td>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr >
        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" heigth="100%">
            <div id="divRicercaAreeOperatori" name="divRicercaAreeOperatori" ></div>
            <div id="divTabellaAreeOperatori" name="divTabellaAreeOperatori" ></div>
            
          </td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
              <tr>
                  <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                    <div id="divButtonList" name="divButtonList">
                      <table>
                      <tr>             
                      <td>
                      <sec:ShowButtons td_class="textB"  force_singleButton="SALVA" />
                      </td>
                      </tr>
                      </table>
                    </div>
               
                </td>
              </tr>
            </table>
          </td>
        </tr>
        </table>
       
      </form>
    </div>
  </BODY>
  <script>
    var http=getHTTPObject();
  </script>
</HTML>
