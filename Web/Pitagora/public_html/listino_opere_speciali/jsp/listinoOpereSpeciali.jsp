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
<%=StaticMessages.getMessage(3006,"listinoOpereSpeciali.jsp")%>
</logtag:logData>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/json2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/listinoOpereSpeciali.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>

<HTML>
  <HEAD>
  <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
  <TITLE>Selezione Listino</TITLE>
  <Script language="JavaScript">
 
  </Script>
  </HEAD>
  <BODY onload="caricaListini()">
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
                       <!-- 
                       <script>
                          showPageTitle();
                        </script>
                        -->
                        &nbsp;Selezione Listino
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
            <div id="divTabellaListini" name="divTabellaListini" >
              
            </div>
            <div name="divIns" id="divIns" style="visibility:hidden;display:none;" >
              <table width="75%" align="center" border="0" cellspacing="0" cellpadding="1" >
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                        <tr>
                          <td width="49%" class="textB" align="left">&nbsp; Listino </td>
                          <td class="text" align="left" width="100%" colspan="2">
                            <div name="divRiepilogoListino" id="divRiepilogoListino"/>
                          </td>
                        </tr>
                        <tr>
                          <td width="49%" class="textB" align="left">&nbsp; Data inizio validità </td>
                          <td class="text" align="left" width="100%" colspan="2">
                            <div name="divDataInizioValidita" id="divDataInizioValidita"/>
                          </td>
                        </tr>
                         <tr>
                          <td width="49%" class="textB" align="left">&nbsp; Data fine validità </td>
                          <td class="text" align="left" width="100%" colspan="2">
                            <div name="divDataFineValidita" id="divDataFineValidita"/>
                          </td>
                        </tr>
                      </table>
            </td>
          </tr>
          <tr>
                  <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                </tr>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <tr>
                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" width="91%">&nbsp;Tariffe </td>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                          <img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                      </tr>
                    </table>
                    <div id="divTabellaTariffa" name="divTabellaTariffa">
                    </div>
                  </td>
                </tr>
              </table>
            </div>
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
                    <div id="divButtonListino" name="divButtonListino">
                      <table>
                      <tr>
                      <td>
                      <sec:ShowButtons td_class="textB"  force_singleButton="NUOVO" />
                      </td>
                      <td>
                      <sec:ShowButtons td_class="textB"  force_singleButton="DETTAGLIO" />
                      </td>
                      <td>
                      <sec:ShowButtons td_class="textB"  force_singleButton="ELIMINA" />
                      </td>
                      </tr>
                      </table>
                    </div>
                    <div id="divButtonTariffe" name="divButtonTariffe" style="visibility:hidden;display:none;">
                        <table>
                      <tr>
                      <td>
                      <sec:ShowButtons td_class="textB"   force_singleButton="AGGIORNA" />
                      </td>
                      <td>
                        <sec:ShowButtons td_class="textB"  force_singleButton="ANNULLA" />
                      </td>
                      </tr>
                      </table>        
                    </div>
                    <div id="divButtonModTariffe" name="divButtonModTariffe" style="visibility:hidden;display:none;">
                      <table>
                      <tr>
                      <td>
                      <sec:ShowButtons td_class="textB"  force_singleButton="SALVA" />
                      </td>
                      <td>
                      <sec:ShowButtons td_class="textB"  force_singleButton="ANNULLA" />
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
