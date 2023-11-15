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
<!--
<%@ taglib uri="/webapp/pg" prefix="pg" %>
-->
<%@ taglib uri="/webapp/sec" prefix="sec" %>

<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ScodamentoEventi.jsp")%>
</logtag:logData>
<!-- instanziazione dell'oggetto remoto -->

<EJB:useHome id="home" type="com.ejbSTL.ScodamentoEventiHome" location="ScodamentoEventi" />
<EJB:useBean id="scodamentoEventi" type="com.ejbSTL.ScodamentoEventi" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%
  // PARAMETRI DI INPUT DELLA PAGINA - INIZIO
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

  String sistema=request.getParameter("sistema");
  
  int intAggiornamento;
  if (request.getParameter("intAggiornamento") == null){
    intAggiornamento = 0;
  }else{
    intAggiornamento = Integer.parseInt(request.getParameter("intAggiornamento"));
  }

  // Controllo se effettuare l'inserimento o no dopo l'apertura del popup
  String esito = "";
  String messaggio = "";
  DB_ScodamentoEventi ScodamentoeventiDB;
  String codLotto = Misc.nh(request.getParameter("strCodLotto"));
  String dataFine = Misc.nh(request.getParameter("strDataFine"));
  
  if(!codLotto.equals("") && intAggiornamento != 0){
    ScodamentoeventiDB = new DB_ScodamentoEventi();
    ScodamentoeventiDB.setCOD_LOTTO(codLotto);
    ScodamentoeventiDB.setDATA_FINE(dataFine);
    
    /* INSERIMENTO */

if(intAggiornamento==1)
    {
//        esito = ScodamentoEventi.insScodamentoEventi(ScodamentoEventiDB);
     
      if("".equals(esito)){
        messaggio = "Inserimento nuovo Lotto effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }
  
    /* AGGIORNAMENTO */
    else if(intAggiornamento==2)
    {
     esito = scodamentoEventi.aggScodamentoEventi(ScodamentoeventiDB);
      if("".equals(esito)){
        messaggio = "Aggiornamento Lotto effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }
    
    /* CANCELLAZIONE */
    else if(intAggiornamento==3)
    {
    
//        esito = ScodamentoEventi.cancella_ScodamentoEventi(strCodLotto);
      
      if("".equals(esito)){
        messaggio = "Cancellazione Lotto effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    } 
  
  }
  
  String strtypeLoad = request.getParameter("hidTypeLoad");
  String strSelected = "";
  // PARAMETRI DI INPUT DELLA PAGINA - FINE
  
  // GESTIONE CARICAMENTO VETTORE - INIZIO
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
    accountVector = scodamentoEventi.getScodamentoEventi();
    if (accountVector!=null)
      session.setAttribute("accountVector", accountVector);
  }
  // GESTIONE CARICAMENTO VETTORE -FINE

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
<TITLE>Scodamento Eventi</TITLE>
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

function CancelMe()
{
  self.close();
  return false;
}

/*function ONAGGIUNGI() {
  var URL = '';
  URL='pre_inserimento_iva.jsp';
  openCentral(URL,'AliquoteIVA','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}
*/
function ONAGGIORNA() {
  var URL = '';
  URL='agg_ScodamentoEventi.jsp?cod_lotto='+document.frmDati.strCodLotto.value+'&sistema='+document.frmDati.strSistema.value;
  openCentral(URL,'ScodamentoEventi','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

/*function ONCANCELLA() {
  if(confirm("Attenzione!!! Si vuole procedere con la cancellazione dell aliquota selezionata?")){
    document.frmDati.intAggiornamento.value = "3";
    document.frmDati.hidTypeLoad.value = '0';
    document.frmDati.submit();
  }
}
*/  

function setCodeHidden(obj){
  var app = 'tipo_sistema_mittente_'+obj.value;
  for(j=0; j<document.forms.length; j++) {
    for(k=0; k<document.forms[j].elements.length; k++) {
//     alert( app + " --- " + document.forms[j].elements[k].name );
      if ( app == document.forms[j].elements[k].name ) {
        var app_value = document.forms[j].elements[k].value;
        if (app_value != '' && app_value != null && app_value != 'null'){
          Enable(document.frmDati.AGGIORNA);
 //         Enable(document.frmDati.CANCELLA);
          break;
        }else{
          Enable(document.frmDati.AGGIORNA);
 //         Enable(document.frmDati.CANCELLA);
          break;
        }
      }
    }
  }
  document.frmDati.strCodLotto.value=obj.value;
}

</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="" method="post" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="intAggiornamento" value="<%=intAggiornamento%>">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidTypeLoad" value="">

<input type="hidden" name="strCodLotto" value="">
<input type="hidden" name="strDataFine" value="">
<input type="hidden" name="strSistema" value="<%=sistema%>">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/scodamento_eventi.gif" alt="" border="0"></td>
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;SCODAMENTO EVENTI</td>
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
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Scodamento Eventi di Fatturazione</td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                          int i=0;
                          int j=0;
                          String codiceaccount="";
                          String descaccount="";
                          //String bgcolor="";
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
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;</td>
                            <%-- <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice </td> --%>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" align="center">Lotto </td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;</td>
                            <%--<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Data Fine</td>--%>
                          </tr>
                          <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                          <%
                          //SimpleDateFormat datafmt = new SimpleDateFormat ("dd'/'MM'/'yyyy");

                          String classRow = "row1";
                          String curClassRow = "";
                          String curSubClass_Row = "";
                          String curSubClassRow = "";
                          String curSubClassRow_new = "";
                          
                          for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                          {
                            DB_ScodamentoEventi myelement=new DB_ScodamentoEventi();
                            myelement=(DB_ScodamentoEventi)accountVector.elementAt(j);
                            curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                            curSubClass_Row = curSubClassRow;

                          %>
                            
                          <tr class="<%=curSubClass_Row%>">
                            <td class='text'>
                              <input type="hidden" name="CodLotto" value="<%=myelement.getCOD_LOTTO()%>" onClick="setCodeHidden(this);" checked>
                              <input type="hidden" name="tipo_sistema_mittente_<%=myelement.getCOD_LOTTO()%>" value="<%=myelement.getCOD_LOTTO()%>">
                            </td>
                            
                            <td align="center"><%=myelement.getCOD_LOTTO()%></td>
                            <td>&nbsp;</td>
                            <%--<td><%=myelement.getDATA_FINE()%></td>--%>
                          </tr>
                          <tr>
                            <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
                      <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                  </table>
    </td>
  </tr>

  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
                  <td>
                       <sec:ShowButtons td_class="textB"  force_singleButton="AGGIORNA" />
                        <script language="JavaScript">
                         Enable(document.frmDati.AGGIORNA);
                        </script>
                  </td>
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
//      Disable(document.frmDati.Seleziona);
    </script>
<%
  }
%>

</form>
<script language="JavaScript">

  if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");

  Enable(document.frmDati.AGGIORNA);

</script>
</BODY>
</HTML>
