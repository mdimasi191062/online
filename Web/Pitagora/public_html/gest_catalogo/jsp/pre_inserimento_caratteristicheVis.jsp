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
<%=StaticMessages.getMessage(3006,"pre_inserimento_caratteristicheVis.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="caratteristiche" type="com.ejbSTL.Ent_Catalogo" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<%
  // PARAMETRI DI INPUT DELLA PAGINA - INIZIO
  int intAction;
  int intFunzionalita;
  int intAggiornamento; //          1 - INSERIMENTO
                        //          2 - AGGIORNAMENTO / MODIFICA DESC
                        //          3 - CANCELLAZIONE
                        
  if (request.getParameter("intAggiornamento") == null){
    intAggiornamento = 0;
  }else{
    intAggiornamento = Integer.parseInt(request.getParameter("intAggiornamento"));
  }
  if(request.getParameter("intAction") == null){
    intAction = StaticContext.LIST;
  }else{
    intAction = Integer.parseInt(request.getParameter("intAction"));
  }
  if(request.getParameter("intFunzionalita") == null){
    intFunzionalita = StaticContext.FN_TARIFFA;
  }else{
    intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
  }

  //Controllo se effettuare l'inserimento o no dopo l'apertura del popup
  String esito = "";
  String messaggio = "";
  DB_PreCaratteristiche newCaratteristica;
  
  String codiceCarat = Misc.nh(request.getParameter("strCodeCarat"));
  String codiceTipoCarat = Misc.nh(request.getParameter("strCodeTipoCarat"));  
  String descrizione = Misc.nh(request.getParameter("strDescCarat"));

  //QS - AP : Aggiunta gestione flag_modifica_descrizione
  String strFlagModificaDescrizione = Misc.nh(request.getParameter("strFlagModificaDescrizione"));
  
   if(!codiceCarat.equals("") && intAggiornamento != 0){   
    newCaratteristica = new DB_PreCaratteristiche();
    newCaratteristica.setCODE_CARATT(codiceCarat);
    newCaratteristica.setCODE_TIPO_CARATT(codiceTipoCarat);
    newCaratteristica.setDESC_CARATT(descrizione);
    newCaratteristica.setFLAG_MODIF(strFlagModificaDescrizione);
      
    /* INSERIMENTO */       
    if(intAggiornamento == 1){    
      esito = caratteristiche.insCaratteristica(newCaratteristica);
      if(esito.equals("")){
        messaggio = "Inserimento nuova Caratteristica effettuata correttamente.";
      }else{
        messaggio = esito;
      }
    }

    /* AGGIORNAMENTO */
    else if(intAggiornamento == 2){
       //QS - AP : Aggiunta gestione flag_modifica_descrizione
      esito = caratteristiche.aggiorna_caratteristica(newCaratteristica);
      if(esito.equals("")){
        messaggio = "Aggiornamento caratteristica effettuato correttamente.";
      }else{
        messaggio = esito;
      }
    }

    /* CANCELLAZIONE */
    else if(intAggiornamento == 3){
      esito = caratteristiche.cancella_caratteristica(newCaratteristica.getCODE_CARATT());
      if(esito.equals("")){
        messaggio = "Cancellazione caratteristica effettuata correttamente.";
      }else{
        messaggio = esito;
      }
    }
  }
  
  //Lettura del parametro Cliente nel filtro di ricerca  per ripristino dopo  ricaricamento e per condizione di ricerca
  String strCodeCaratteristica = Misc.nh(request.getParameter("txtCodeCarat"));
  String strCodeTipoCaratteristica = Misc.nh(request.getParameter("txtCodeTipoCarat"));  
  String strDescCaratteristica = Misc.nh(request.getParameter("txtDescCarat"));
  String strDescTipoCaratteristica = Misc.nh(request.getParameter("txtDescTipoCarat")); 
  
  if(strCodeCaratteristica.equals(""))
    strCodeCaratteristica = "%";
  if(strCodeTipoCaratteristica.equals(""))
    strCodeTipoCaratteristica = "%";
  if(strDescCaratteristica.equals(""))
    strDescCaratteristica = "%";
  if(strDescTipoCaratteristica.equals(""))
    strDescTipoCaratteristica = "%";    

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
    accountVector = caratteristiche.getCaratteristicheFiltro(strCodeCaratteristica,strCodeTipoCaratteristica,strDescCaratteristica,strDescTipoCaratteristica);
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
  var stringa3="";  
  var stringa4="";  
  stringa=objForm.txtCodeCarat.value;
  stringa2=objForm.txtCodeTipoCarat.value;  
  stringa3=objForm.txtDescCarat.value;
  stringa4=objForm.txtDescTipoCarat.value;
  objForm.txtCodeCarat.value=stringa.toUpperCase();
  objForm.txtCodeTipoCarat.value=stringa2.toUpperCase();  
  objForm.txtDescCarat.value=stringa3.toUpperCase();
  objForm.txtDescTipoCarat.value=stringa4.toUpperCase();  
  objForm.hidTypeLoad.value = "0";
  objForm.intAggiornamento.value = "0";
  objForm.action = "pre_inserimento_caratteristicheVis.jsp";
  objForm.submit();
}

function CancelMe()
{
  self.close();
  return false;
}

function ONAGGIUNGI() {
  var URL = '';
  URL='pre_inserimento_caratteristiche.jsp';
  openCentral(URL,'Caratteristiche','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',900,500);
}

function ONAGGIORNA() {
  var URL = '';
  URL='pre_aggiornamento_caratteristiche.jsp?code_caratteristica='+ document.frmDati.strCodeCarat.value + '&modifica_descrizione=0';
  openCentral(URL,'Componenti','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

function ONCANCELLA() {
  if(confirm("Attenzione!!! Si vuole procedere con la cancellazione della caratteristica selezionata?")){
    document.frmDati.intAggiornamento.value = '3';
    document.frmDati.hidTypeLoad.value = '0';
    document.frmDati.submit();
  }
}

function ONMODIFICADESC() {
   var URL = '';
  URL='pre_aggiornamento_caratteristiche.jsp?code_caratteristica='+ document.frmDati.strCodeCarat.value + '&modifica_descrizione=1';
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
          Enable(document.frmDati.MODIFICA_DESC);
          break;
        }else{
          Enable(document.frmDati.AGGIORNA);
          Enable(document.frmDati.CANCELLA);
          Disable(document.frmDati.MODIFICA_DESC);
          break;
        }
      }
    }
  }
  document.frmDati.strCodeCarat.value=obj.value;
}

  
</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="strCodeCarat" value="">
<input type="hidden" name="strCodeTipoCarat" value="">
<input type="hidden" name="strDescCarat" value="">
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
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Caratteristiche</td>
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
                      <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                      <td width="20%" class="textB" align="right" nowrap>Codice Caratteristica:&nbsp;</td>
                      <%
                      if(strCodeCaratteristica.equals("%"))
                        strCodeCaratteristica = "";
                      %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtCodeCarat' value='<%=strCodeCaratteristica%>' size='15'></td>
                      <td width="20%" class="textB" align="right" nowrap>Descrizione Caratteristica:&nbsp;</td>
                      <%
                      if(strDescCaratteristica.equals("%"))
                        strDescCaratteristica = "";
                      %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtDescCarat' value='<%=strDescCaratteristica%>' size='15'></td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input type="button" class="textB" name="Esegui" value="ESEGUI" onclick="submitRicerca(this.value);">
                      </td>
                    </tr>
                    <tr>
                      <td width="20%" class="textB" align="right" nowrap>Codice Tipo Caratteristica:&nbsp;</td>
                      <%
                      if(strCodeTipoCaratteristica.equals("%"))
                        strCodeTipoCaratteristica = "";
                      %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtCodeTipoCarat' value='<%=strCodeTipoCaratteristica%>' size='15'></td>
                      <td width="20%" class="textB" align="right" nowrap>Descrizione Tipo Caratteristica:&nbsp;</td>
                      <%
                      if(strDescTipoCaratteristica.equals("%"))
                        strDescTipoCaratteristica = "";
                      %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtDescTipoCarat' value='<%=strDescTipoCaratteristica%>' size='15'></td>                      
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
                      <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Caratteristiche Selezionate</td>
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
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Cod. Caratteristica&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Descrizione Caratteristica&nbsp;</td>                            
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Cod. Tipo Caratteristica&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" nowrap>Descrizione Tipo Caratteristica&nbsp;</td>
                          </tr>
                          <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                          <%
                          
                          String curSubClass_Row = "Row1";
                          String curSubClassRow_new ="";
                           String curSubClassRow = "Row1";
                          for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                          {
                            
                            String classRow = "row1";
                            String curClassRow = "";
                          
                          
                            DB_PreCaratteristiche myelement=new DB_PreCaratteristiche();
                            myelement=(DB_PreCaratteristiche)accountVector.elementAt(j);

                            
                            if(myelement.getTIPO_SISTEMA_MITTENTE() != null && myelement.getTIPO_SISTEMA_MITTENTE().equals("S")){
                              curSubClassRow = curSubClassRow.equals("row1") ? "row2" : "row1";
                              curSubClass_Row = curSubClassRow;
                                        
                              }else{
                                curSubClassRow_new = curSubClassRow.equals("row1") ? "row2_new" :  "row1_new";
                                curSubClassRow = curSubClassRow.equals("row1") ? "row2" :  "row1";  
                                curSubClass_Row = curSubClassRow_new;
                              }
                            
                            %>
                            
                          <tr class="<%=curSubClass_Row%>">
                            <td width=10>
                              <input type="radio" name="CodeFunz" value="<%=myelement.getCODE_CARATT()%>" onClick="setCodeHidden(this);">
                              <input type="hidden" name="tipo_sistema_mittente_<%= myelement.getCODE_CARATT()%>" value="<%=myelement.getTIPO_SISTEMA_MITTENTE()%>">
                            </td>
                            <td><%=myelement.getCODE_CARATT()%></td>
                            <td><%=myelement.getDESC_CARATT()%></td>
                            <td><%=myelement.getCODE_TIPO_CARATT()%></td>                            
                            <td><%=myelement.getDESC_TIPO_CARATT()%></td>
                          </tr>
                          <tr>
                            <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                            i+=1;
                          }
                          %>
                          <tr>
                            <td colspan="7" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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

  Disable(document.frmDati.AGGIORNA);
  Disable(document.frmDati.CANCELLA);
  Disable(document.frmDati.MODIFICA_DESC);  
</script>
</BODY>
</HTML>
