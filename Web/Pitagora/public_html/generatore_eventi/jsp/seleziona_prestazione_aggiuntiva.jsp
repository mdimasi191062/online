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
<%=StaticMessages.getMessage(3006,"seleziona_prestazione_aggiuntiva.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
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
  //Lettura del parametro Cliente nel filtro di ricerca  per ripristino dopo  ricaricamento e per condizione di ricerca
  String strPrestAgg = Misc.nh(request.getParameter("txtPrestAgg"));
  String strtypeLoad = request.getParameter("hidTypeLoad");
  String Code_Servizio = Misc.nh(request.getParameter("Servizio"));
  String Code_Offerta = Misc.nh(request.getParameter("Offerta"));
  String Code_Prodotto = Misc.nh(request.getParameter("Prodotto"));
  String Code_Componente = Misc.nh(request.getParameter("Componente"));

  String strSelected = "";
  //FINE PARAMETRI DI INPUT DELLA PAGINA++++++++++++++++++++++++++++++
//GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector prestVector=null;
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
    prestVector = (Vector) session.getAttribute("prestVector");
  else
  {
    prestVector = remoteEnt_Inventari.getPrestazioniAggiuntive(Code_Servizio,Code_Offerta,Code_Prodotto,Code_Componente);
    if (prestVector!=null)
      session.setAttribute("prestVector", prestVector);
  }
//FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//memorizza il numero di record totali
int intRecTotali=prestVector.size();
//determina il numero di elementi per pagina
int intRecXPag;
if(request.getParameter("cboNumRecXPag")==null){
	intRecXPag=5;
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
<TITLE>Seleziona Prestazione Aggiuntiva</TITLE>
<SCRIPT LANGUAGE='Javascript'>
var objForm = null;
function initialize()
{
	objForm = document.frmDati;
}

function ChangeSel(codiceprest,indice)
{
  objForm.CodPrestSel.value=codiceprest;
  objForm.DescPrestSel.value=eval('objForm.SelPrest[indice].value');
}

function submitRicerca(typeLoad)
{
  var stringa="";
  var URLParam = '?Servizio=' + '<%=Code_Servizio%>';
  stringa=objForm.txtPrestAgg.value;
  objForm.txtPrestAgg.value=stringa.toUpperCase();
  objForm.hidTypeLoad.value = "0";
  objForm.action = "seleziona_prestazione_aggiuntiva.jsp" + URLParam;
  objForm.submit();
}

function SubmitSeleziona()
{
  if (!opener || opener.closed) 
  {
	window.alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
    self.close();
    return false;
  }
  else
  {
    opener.frmDati.strCodePrestAgg.value = objForm.CodPrestSel.value;
    opener.frmDati.strDescPrestAgg.value = objForm.DescPrestSel.value;
    self.close();
  }
}
function CancelMe()
{
  self.close();
  return false;
}
</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">

<input type="hidden" name="Servizio" value="<%=Code_Servizio%>">
<input type="hidden" name="Offerta" value="<%=Code_Offerta%>">
<input type="hidden" name="Prodotto" value="<%=Code_Prodotto%>">
<input type="hidden" name="Componente" value="<%=Code_Componente%>">


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <!-- <tr>
        <td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>tariffeTitolo.gif" alt="" border="0"></td>
    </tr> -->
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
                                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Seleziona la Prestazione Aggiuntiva</td>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                              </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
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
	                                           <td width="40%" class="textB" align="right">Descrizione Prestazione Aggiuntiva:&nbsp;</td>
	                                           <td width="40%" class="text"><input class="text" type='text' name='txtPrestAgg' value='<%=strPrestAgg%>' size='15'></td>
	                                           <td width="20%" rowspan='2' class="textB" valign="center" align="center">
	                                               <input type="button" class="textB" name="Esegui" value="ESEGUI" onclick="submitRicerca('0');">
	                                           </td>
                                        </tr>
										<tr>
						                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
						                      <td  class="text">
						                        <select class="text" name="cboNumRecXPag" onchange="submitRicerca('1');">
												<%for(int k = 5;k <= 50; k=k+5){
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
                                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Prestazioni Aggiuntive Selezionate</td>
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
    String codiceprest="";
    String descprest="";
    String bgcolor="";
    if ((prestVector==null)||(prestVector.size()==0))
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
                                        <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione Prestazione Aggiuntiva</td>
                                        <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Prestazione Aggiuntiva </td>
                                    </tr>
		<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
		
	<%for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
      
      {
        DB_PrestazioneAggiuntiva myelement=new DB_PrestazioneAggiuntiva();
        myelement=(DB_PrestazioneAggiuntiva)prestVector.elementAt(j);
        if ((i%2)==0)
          bgcolor=StaticContext.bgColorRigaPariTabella;
        else
          bgcolor=StaticContext.bgColorRigaDispariTabella;
%>
                                    <tr>
                                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="2%">
<%
          if (i==0)
          {
            codiceprest=myelement.getCODE_PREST_AGG();
            descprest=myelement.getDESC_PREST_AGG();
%>
                
                                            <input type='radio' checked name='SelPrest' value='<%=myelement.getDESC_PREST_AGG()%>' onclick=ChangeSel("<%=myelement.getCODE_PREST_AGG()%>",'<%=i%>')>
<%
          }
          else
          {
%>

                                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' name='SelPrest' value='<%=myelement.getDESC_PREST_AGG()%>' onclick=ChangeSel('<%=myelement.getCODE_PREST_AGG()%>','<%=i%>')>
<%
          }
%>
                                        </td>
                                        <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getDESC_PREST_AGG()%></td>
                                        <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getCODE_PREST_AGG()%></td>
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
</table>
  </td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
     		<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center" colspan="5">
				<input type="button" class="textB" name="Seleziona" value="Seleziona" onClick="if (this.disabled) return false; else SubmitSeleziona();">
				<input type="button" class="textB" name="Annulla" value="Annulla" onClick = "javascript:CancelMe();">
				<input type=hidden name="CodPrestSel" value="<%=codiceprest%>">
				<input type=hidden name="DescPrestSel" value="<%=descprest%>">
	        </td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
<%
  if ((prestVector==null)||(prestVector.size()==0))
  {
%>
    <script>
      Disable(document.frmDati.Seleziona);
    </script>
<%
  }
%>

</form>
</BODY>
</HTML>