<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_offerteVis.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="servizi" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  //PARAMETRI DI INPUT DELLA PAGINA+++++++++++++++++++++++++++++++++
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

  //Controllo se effettuare l'inserimento o no dopo l'apertura del popup
  String esito = "";
  String messaggio = "";
  DB_CAT_Servizio newServizio;
  
  String codeServ = Misc.nh(request.getParameter("strCodeServ"));
  String descServ = Misc.nh(request.getParameter("strDescServ"));
  String divServ = Misc.nh(request.getParameter("strDIVServ"));
  String dfvServ = Misc.nh(request.getParameter("strDFVServ"));
  String appValEurServ = Misc.nh(request.getParameter("strAppValEurServ"));
  
  if(!codeServ.equals("")){
    //Effettuo l'inserimento
    newServizio = new DB_CAT_Servizio();
    newServizio.setCODE_SERVIZIO(codeServ);
    newServizio.setDESC_SERVIZIO(descServ);
    newServizio.setDATA_INIZIO_VALID(divServ);
    newServizio.setDATA_FINE_VALID(dfvServ);
    newServizio.setAPP_VAL_EUR(appValEurServ);
    esito = servizi.insServizio(newServizio);
    if(esito.equals("")){
      messaggio = "Inserimento nuovo Servizio effettuato correttamente.";
    }else{
      messaggio = esito;
    }
  }
  
  //Lettura del parametro Cliente nel filtro di ricerca  per ripristino dopo  ricaricamento e per condizione di ricerca
  String strAccount = Misc.nh(request.getParameter("txtAccount"));
  String strDescAccount = Misc.nh(request.getParameter("txtDescAccount"));  
  if(strAccount.equals(""))
    strAccount = "%";
  if(strDescAccount.equals(""))
    strDescAccount = "%";
  String strtypeLoad = request.getParameter("hidTypeLoad");
  String strSelected = "";
  //FINE PARAMETRI DI INPUT DELLA PAGINA++++++++++++++++++++++++++++++
  
//GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector accountVector=null;
  if (strtypeLoad!=null && strtypeLoad!="")
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
    accountVector = (Vector) session.getAttribute("accountVector");
  else
  {
    accountVector = servizi.getServiziFiltro(strAccount,strDescAccount);
    if (accountVector!=null)
      session.setAttribute("accountVector", accountVector);
  }
  //FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  //memorizza il numero di record totali
  int intRecTotali=accountVector.size();
  //determina il numero di elementi per pagina
  int intRecXPag;
  if(request.getParameter("cboNumRecXPag")==null){
    intRecXPag=50;
  }else{
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  }
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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
<TITLE>Seleziona Account</TITLE>
<SCRIPT LANGUAGE='Javascript'>
var objForm = null;
function initialize()
{
	objForm = document.frmDati;
}

function ChangeSel(codiceaccount,indice)
{
  objForm.CodAccountSel.value=codiceaccount;
  objForm.DescAccountSel.value=eval('objForm.SelAccount[indice].value');
}

function submitRicerca(typeLoad)
{
  var stringa="";
  var stringa2="";
  stringa=objForm.txtAccount.value;
  stringa2=objForm.txtDescAccount.value;
  objForm.txtAccount.value=stringa.toUpperCase();
  objForm.txtDescAccount.value=stringa2.toUpperCase();
  objForm.hidTypeLoad.value = "0";
  objForm.action = "pre_inserimento_serviziVis.jsp";
  objForm.submit();
}

function CancelMe()
{
  self.close();
  return false;
}

function ONAGGIUNGI() {
  var URL = '';
  URL='pre_inserimento_servizi.jsp';
  openCentral(URL,'Offerte','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}
  
</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="strCodeServ" value="">
<input type="hidden" name="strDescServ" value="">
<input type="hidden" name="strDIVServ" value="">
<input type="hidden" name="strDFVServ" value="">
<input type="hidden" name="strAppValEurServ" value="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/catalogo.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Servizi</td>
						  <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
						</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
</table>

<table align=center width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                      </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="20%" class="textB" align="right">Codice Servizio:&nbsp;</td>
                      <%
                      if(strAccount.equals("%"))
                        strAccount = "";
                      %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtAccount' value='<%=strAccount%>' size='15'></td>
                      <td width="20%" class="textB" align="right" nowrap>Descrizione Servizio:&nbsp;</td>
                      <%
                      if(strDescAccount.equals("%"))
                        strDescAccount = "";
                      %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtDescAccount' value='<%=strDescAccount%>' size='15'></td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input type="button" class="textB" name="Esegui" value="ESEGUI" onclick="submitRicerca(this.value);">
                      </td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="cboNumRecXPag" onchange="submitRicerca('1');">
                        <%for(int k = 50;k <= 300; k=k+50){
                          if(k==intRecXPag){
                            strSelected = "selected";
                          }else{
                            strSelected = "";
                          }
                          %>
                          <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
                        <%
                        }
                        %>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Servizi Selezionati</td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                          int i=0;
                          int j=0;
                          String codiceaccount="";
                          String descaccount="";
                          String bgcolor="";
                          if ((accountVector==null)||(accountVector.size()==0))
                          {
                          %>
                          <tr>
                              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">No Record Found</td>
                          </tr>
                          <%
                          }
                          else
                          {
                          %>
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="textB">&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice </td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione </td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">App.Val.Euribor </td>
                          </tr>
                          <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                          <%
                          for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                          {
                            DB_CAT_Servizio myelement=new DB_CAT_Servizio();
                            myelement=(DB_CAT_Servizio)accountVector.elementAt(j);
                            if ((i%2)==0)
                              bgcolor=StaticContext.bgColorRigaPariTabella;
                            else
                              bgcolor=StaticContext.bgColorRigaDispariTabella;
                            %>
                            
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="2%"></td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getCODE_SERVIZIO()%></td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getDESC_SERVIZIO()%></td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getAPP_VAL_EUR()%></td>
                          </tr>
                          <tr>
                            <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                            i+=1;
                          }
                          %>
                          <tr>
                            <td colspan="6" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                              <!--paginatore-->
                              <pg:index>
                                Risultati Pag.
                                <pg:prev> 
                                  <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                                </pg:prev>
                                <pg:pages>
                                  <%
                                  if (pageNumber == pagerPageNumber){
                                  %>
                                    <b><%= pageNumber %></b>&nbsp;
                                  <%
                                  }else{
                                  %>
                                    <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                  <%
                                  }
                                  %>
                                </pg:pages>
                                <pg:next>
                                  <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                                </pg:next>
                              </pg:index>
                              </pg:pager>
                            </td>
                          </tr>
                          <%
                          }
                          %>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
	    <table width="80%" border="1" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
<%
  if ((accountVector==null)||(accountVector.size()==0))
  {
%>
    <script>
      Disable(document.frmDati.Seleziona);
    </script>
<%
  }
%>

</form>
<script language="JavaScript">
  if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
</BODY>
</HTML>
