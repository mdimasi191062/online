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
<%=StaticMessages.getMessage(3006,"pre_inserimento_ivaVis.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.AliquotaIvaHome" location="AliquotaIva" />
<EJB:useBean id="aliquotaIva" type="com.ejbSTL.AliquotaIva" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  // PARAMETRI DI INPUT DELLA PAGINA - INIZIO
  int intAction;
  String sistema=request.getParameter("sistema");
  
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
  int intAggiornamento;
  if (request.getParameter("intAggiornamento") == null){
    intAggiornamento = 0;
  }else{
    intAggiornamento = Integer.parseInt(request.getParameter("intAggiornamento"));
  }

  // Controllo se effettuare l'inserimento o no dopo l'apertura del popup
  String esito = "";
  String messaggio = "";
  DB_AliquotaIva aliquotaDB;
  String codeAliquota = Misc.nh(request.getParameter("strCodeAliquota"));
  String descAliquota = Misc.nh(request.getParameter("strDescAliquota"));
  String aliquota = Misc.nh(request.getParameter("strAliquota"));
  String divAliquota = Misc.nh(request.getParameter("strDIVAliquota"));
  String dfvAliquota = Misc.nh(request.getParameter("strDFVAliquota"));

  String strCodeAliquota = Misc.nh(request.getParameter("CodeAliquota"));
  
  if(!codeAliquota.equals("") && intAggiornamento != 0){
    aliquotaDB = new DB_AliquotaIva();
    aliquotaDB.setCODE_ALIQUOTA(codeAliquota);
    aliquotaDB.setDESC_ALIQUOTA(descAliquota);
    aliquotaDB.setALIQUOTA(aliquota);
    aliquotaDB.setDATA_INIZIO_VALID(divAliquota);
    
    /* INSERIMENTO */
    if(intAggiornamento==1)
    {
      if(sistema.compareTo("C")==0)
        esito = aliquotaIva.insAliquotaIvaClassic(aliquotaDB);
      else
        esito = aliquotaIva.insAliquotaIva(aliquotaDB);
     
      if(esito.equals("")){
        messaggio = "Inserimento nuova Aliquota IVA effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }
    
    /* AGGIORNAMENTO */
    else if(intAggiornamento==2)
    {
      if(sistema.compareTo("C")==0)
        esito = aliquotaIva.aggAliquotaIvaClassic(aliquotaDB);
      else
        esito = aliquotaIva.aggAliquotaIva(aliquotaDB);
      
      if(esito.equals("")){
        messaggio = "Aggiornamento Aliquota IVA effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }
    
    /* CANCELLAZIONE */
    else if(intAggiornamento==3)
    {
    
      if(sistema.compareTo("C")==0)
        esito = aliquotaIva.cancella_aliquotaIvaClassic(strCodeAliquota);
      else
        esito = aliquotaIva.cancella_aliquotaIva(strCodeAliquota);
      
      if(esito.equals("")){
        messaggio = "Cancellazione Aliquota effettuata correttamente.";
      }else{
        messaggio = esito;
      }
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
    if(sistema.compareTo("C")==0)
    {
      accountVector = aliquotaIva.getAllAliquoteClassic();
    }
    else
    {
    accountVector = aliquotaIva.getAllAliquote();
    }
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

function CancelMe()
{
  self.close();
  return false;
}

function ONAGGIUNGI() {
  var URL = '';
  URL='pre_inserimento_iva.jsp';
  openCentral(URL,'AliquoteIVA','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

function ONAGGIORNA() {
  var URL = '';
  URL='pre_aggiornamento_iva.jsp?code_aliquota='+document.frmDati.strCodeAliquota.value+'&sistema='+document.frmDati.strSistema.value;
  openCentral(URL,'AliquoteIVA','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

function ONCANCELLA() {
  if(confirm("Attenzione!!! Si vuole procedere con la cancellazione dell aliquota selezionata?")){
    document.frmDati.intAggiornamento.value = "3";
    document.frmDati.hidTypeLoad.value = '0';
    document.frmDati.submit();
  }
}
  
function setCodeHidden(obj){
  var app = 'tipo_sistema_mittente_'+obj.value;
  for(j=0; j<document.forms.length; j++) {
    for(k=0; k<document.forms[j].elements.length; k++) {
//     alert( app + " --- " + document.forms[j].elements[k].name );
      if ( app == document.forms[j].elements[k].name ) {
        var app_value = document.forms[j].elements[k].value;
        if (app_value != '' && app_value != null && app_value != 'null'){
          Enable(document.frmDati.AGGIORNA);
          Enable(document.frmDati.CANCELLA);
          break;
        }else{
          Enable(document.frmDati.AGGIORNA);
          Enable(document.frmDati.CANCELLA);
          break;
        }
      }
    }
  }
  document.frmDati.strCodeAliquota.value=obj.value;
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

<input type="hidden" name="strCodeAliquota" value="">
<input type="hidden" name="strDescAliquota" value="">
<input type="hidden" name="strCodeAliquotaSap" value="">
<input type="hidden" name="strAliquota" value="">
<input type="hidden" name="strDIVAliquota" value="">
<input type="hidden" name="strDFVAliquota" value="">
<input type="hidden" name="strSistema" value="<%=sistema%>">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/aliquota_iva.gif" alt="" border="0"></td>
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;IVA</td>
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
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Aliquote inserite</td>
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
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Data Inizio Validit&agrave; </td>
                            <%-- <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione </td> --%>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Aliquota &#37;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Data Fine Validit&agrave; </td>
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
                            DB_AliquotaIva myelement=new DB_AliquotaIva();
                            myelement=(DB_AliquotaIva)accountVector.elementAt(j);
                            curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                            curSubClass_Row = curSubClassRow;

                          %>
                            
                          <tr class="<%=curSubClass_Row%>">
                            <td class='text'>
                              <input type="radio" name="CodeAliquota" value="<%=myelement.getCODE_ALIQUOTA()%>" onClick="setCodeHidden(this);">
                              <input type="hidden" name="tipo_sistema_mittente_<%=myelement.getCODE_ALIQUOTA()%>" value="<%=myelement.getCODE_ALIQUOTA()%>">
                            </td>
                            
                           <%-- <td><%=myelement.getCODE_ALIQUOTA() %></td> --%>
                            <td><%=myelement.getDATA_INIZIO_VALID()%></td>
                            <%-- <td><%=myelement.getDESC_ALIQUOTA() %></td> --%>
                            <td><%=myelement.getALIQUOTA() %>&nbsp;</td>
                            <td><%=myelement.getDATA_FINE_VALID()%></td> 
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
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
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
      Disable(document.frmDati.Seleziona);
    </script>
<%
  }
%>

</form>
<script language="JavaScript">
  if(document.frmDati.messaggio.value != "") 
    alert("<%=messaggio%>");

  Disable(document.frmDati.AGGIORNA);
  Disable(document.frmDati.CANCELLA);

</script>
</BODY>
</HTML>

