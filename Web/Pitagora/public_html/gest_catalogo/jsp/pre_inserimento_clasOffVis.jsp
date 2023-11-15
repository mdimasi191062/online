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
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_clasOff.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="classOff" type="com.ejbSTL.Ent_Catalogo" scope="session">
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

  int intAggiornamento;
                            //          0 - NESSUNA OPERAZIONE
                            //          1 - INSERIMENTO
                            //          2 - AGGIORNAMENTO
                            //          3 - CANCELLAZIONE
                        
  if (request.getParameter("intAggiornamento") == null){
    intAggiornamento = 0;
  }else{
    intAggiornamento = Integer.parseInt(request.getParameter("intAggiornamento"));
  }
  
  //Controllo se effettuare l'inserimento o no dopo l'apertura del popup
  String esito = "";
  String messaggio = "";  
  String codeClassOff = Misc.nh(request.getParameter("strCodeClassOff"));
  String descClassOff = Misc.nh(request.getParameter("strDescClassOff"));


  //QS 4.9 : Aggiunta gestione flag_modifica_descrizione
  String strFlagModificaDescrizione = Misc.nh(request.getParameter("strFlagModificaDescrizione"));

  
  if(!codeClassOff.equals("")){

    if(intAggiornamento == 1){
      //Effettuo l'inserimento
      esito = classOff.insClassOff(codeClassOff,descClassOff);
      if(esito.equals("")){
        messaggio = "Inserimento nuova Classe Offerta effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }else if(intAggiornamento == 2){
      // Aggiornamento
      esito = classOff.aggiorna_classe_offerta(codeClassOff,descClassOff,strFlagModificaDescrizione);
      if(esito.equals("")){
        messaggio = "Aggiornamento Classe Offerta effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }else if(intAggiornamento == 3){
      // Cancellazione
      esito = classOff.cancella_classe_offerta(codeClassOff);
      if(esito.equals("")){
        messaggio = "Cancellazione Classe Offerta effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }
  }
  
  //Lettura del parametro Cliente nel filtro di ricerca  per ripristino dopo  ricaricamento e per condizione di ricerca
  String strAccount = Misc.nh(request.getParameter("txtAccount"));
  if(strAccount.equals(""))
    strAccount = "%";
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
    accountVector = classOff.getClassOffFiltro(strAccount);
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
  stringa=objForm.txtAccount.value;
  objForm.txtAccount.value=stringa.toUpperCase();
  objForm.hidTypeLoad.value = "0";
  //QS 4.9
  document.frmDati.intAggiornamento.value = '0';
  
  objForm.action = "pre_inserimento_clasOffVis.jsp";
  objForm.submit();
}

function CancelMe()
{
  self.close();
  return false;
}

function ONAGGIUNGI() {
  var URL = '';
  URL='pre_inserimento_clasOff.jsp';
  openCentral(URL,'ClasseOfferta','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

function ONAGGIORNA() {
  var URL = '';
  URL='pre_aggiornamento_clasOff.jsp?code_classe_offerta='+document.frmDati.strCodeClassOff.value;
  openCentral(URL,'ClasseOfferte','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

function ONCANCELLA() {
  if(confirm("Attenzione!!! Si vuole procedere con la cancellazione dell'offerta selezionata e di un eventuale catalogo presente?")){
    document.frmDati.intAggiornamento.value = '3';
    document.frmDati.hidTypeLoad.value = '0';
    document.frmDati.submit();
  }
}


//QS 4.9
function ONMODIFICADESC() {
   var URL = '';
  
  URL='pre_aggiornamento_clasOff.jsp?code_classe_offerta='+document.frmDati.strCodeClassOff.value + '&modifica_descrizione=1';
  openCentral(URL,'Componenti','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
  
  }

function setCodeHidden(obj){
  var app = 'tipo_sistema_mittente_'+obj.value;
  for(j=0; j<document.forms.length; j++) {
    for(k=0; k<document.forms[j].elements.length; k++) {
      if ( app == document.forms[j].elements[k].name ) {
        var app_value = document.forms[j].elements[k].value;
        if (app_value != '' && app_value != null && app_value != 'null'){
          Disable(document.frmDati.AGGIORNA);
          Disable(document.frmDati.CANCELLA);
          //QS 4.9
          Enable(document.frmDati.MODIFICA_DESC);
          break;
        }else{
          Enable(document.frmDati.AGGIORNA);
          Enable(document.frmDati.CANCELLA);
          //QS 4.9
          Disable(document.frmDati.MODIFICA_DESC);
          break;
        }
      }
    }
  }
  document.frmDati.strCodeClassOff.value=obj.value;
}

</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="strCodeClassOff" value="">
<input type="hidden" name="strDescClassOff" value="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="intAggiornamento" value="<%=intAggiornamento%>">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">

<!--QS - AP Aggiunta gestione flag_modifica_descrizione -->
<INPUT type="hidden" id="strFlagModificaDescrizione" name="strFlagModificaDescrizione" value=""> 

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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Classi Offerte</td>
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
                                            <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                                        </tr>
                                        <tr>
	                                           <td width="40%" class="textB" align="right">Descrizione Classe Offerta:&nbsp;</td>
                                             <%
                                             if(strAccount.equals("%"))
                                               strAccount = "";
                                             %>
	                                           <td width="40%" class="text"><input class="text" type='text' name='txtAccount' value='<%=strAccount%>' size='15'></td>
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
              												<%}%>
						                        </select>
						                      </td>
                                </tr>
                                <tr>
                                    <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
                                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Classi Offerte Selezionate</td>
                                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                                    </tr>
                                </table>
                            </td>
                          </tr>
                          <tr>
                            <td>
                                <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
                                      <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">&nbsp;</td>
                                      <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Classe Offerta </td>
                                      <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione Classe Offerta</td>
                                    </tr>
                                    <tr>
                                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                                    </tr>
                                    <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
		
                                    <%
                                      
                                      String classRow = "row2";
                                      String curClassRow = "";
                                      String curSubClass_Row = "";
                                      String curSubClassRow = "";
                                      String curSubClassRow_new = "";
                                        
                                      for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)
                                      {
                          
                                        DB_Anag_Class_Off myelement=new DB_Anag_Class_Off();
                                        myelement=(DB_Anag_Class_Off)accountVector.elementAt(j);

                                        if(myelement.getTIPO_SISTEMA_MITTENTE() != null && myelement.getTIPO_SISTEMA_MITTENTE().equals("S")){
                                          curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                                          curSubClass_Row = curSubClassRow;
                                        
                                        }else{
                                          curSubClassRow_new = curSubClassRow.equals("row1") ? "row2_new" :  "row1_new";
                                          curSubClassRow = curSubClassRow.equals("row1") ? "row2" :  "row1";  
                                          curSubClass_Row = curSubClassRow_new;
                                        }
                                        
                                        /*
                                        if ((i%2)==0)
                                          bgcolor=StaticContext.bgColorRigaPariTabella;
                                        else
                                          bgcolor=StaticContext.bgColorRigaDispariTabella;
                                        */
%>
                                    <tr class="<%=curSubClass_Row%>">
                                      <TD width="10">
                                        <input type="radio" name="CodeFunz" value="<%=myelement.getCODE_CLASSE_OFFERTA()%>" onClick="setCodeHidden(this);">
                                        <input type="hidden" name="tipo_sistema_mittente_<%=myelement.getCODE_CLASSE_OFFERTA()%>" value="<%=myelement.getTIPO_SISTEMA_MITTENTE()%>">
                                      </TD>
                                      <td><%=myelement.getCODE_CLASSE_OFFERTA()%></td>
                                      <td><%=myelement.getDESC_CLASSE_OFFERTA()%></td>
                                    </tr>
                                    <tr>
                                        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                                    </tr>
<%
          i+=1;
        }%>
									<tr>
										<td colspan="3" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
											<!--paginatore-->
												<pg:index>
													 Risultati Pag.
													 <pg:prev> 
							                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
							                         </pg:prev>
													 <pg:pages>
													 		<%if (pageNumber == pagerPageNumber){%>
															       <b><%= pageNumber %></b>&nbsp;
															<%}else{%>
											                       <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
															<%}%>
													 </pg:pages>
													 <pg:next>
							                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
							                         </pg:next>
												</pg:index>
											</pg:pager>
										</td>
									</tr>
    <%  }%>
                                                                  </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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


  Disable(document.frmDati.AGGIORNA);
  Disable(document.frmDati.CANCELLA);
  Disable(document.frmDati.MODIFICA_DESC);
  
</script>
</BODY>
</HTML>
