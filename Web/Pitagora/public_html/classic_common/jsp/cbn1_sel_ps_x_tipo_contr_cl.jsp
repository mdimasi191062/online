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
<%@ page import="com.ejbSTL.Ent_ProdottiServizi"%>
<%@ page import="com.ejbSTL.Ent_ProdottiServiziHome"%>
<%@ page import="com.utl.*" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_sel_ps_x_tipo_contr_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_ProdottiServizi" type="com.ejbSTL.Ent_ProdottiServiziHome" location="Ent_ProdottiServizi" />
<EJB:useBean id="remoteEnt_ProdottiServizi" type="com.ejbSTL.Ent_ProdottiServizi" scope="session">
    <EJB:createBean instance="<%=homeEnt_ProdottiServizi.create()%>" />
</EJB:useBean>

<%
//dichiarazione variabili	
int intAction=0;
int intFunzionalita=0;
int typeLoad=0;
int j=0;
String codice="";
String descrizione="";
String bgcolor="";
String strChecked = "";
String strSelected = "";
Vector psVector=null;
//prendo i parametri dalla query string
String strCliente = Misc.nh(request.getParameter("Cliente"));
String strCodeCliente = Misc.nh(request.getParameter("CodeCliente"));
String strCodContratto = Misc.nh(request.getParameter("CodeContr"));
String strContratto = Misc.nh(request.getParameter("Contratto"));
String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
String strCodiceTipoContratto = Misc.nh(request.getParameter("hidCodiceTipoContratto"));
String strMostraCliente = Misc.nh(request.getParameter("parMostraCliente"));
String strMostraContratto = Misc.nh(request.getParameter("parMostraContratto"));
String strNomeCombo = Misc.nh(request.getParameter("nomeCombo"));
String strtypeLoad = request.getParameter("hidTypeLoad");
String strPs = Misc.nh(request.getParameter("parPsPadre"));
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
if (strtypeLoad!=null)
	typeLoad=Integer.parseInt(strtypeLoad);
if (typeLoad!=0)
	//prende il vettore dalla sessione
	psVector = (Vector) session.getAttribute("psVector");
else
{
        psVector = remoteEnt_ProdottiServizi.getProdottiServizi(intAction,intFunzionalita,strCodeCliente,strCodContratto,strCodiceTipoContratto,strPs);
		if (psVector!=null)
			session.setAttribute("psVector", psVector);
}
 //numero di elementi per pagina
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
<TITLE>Selezione Prodotto/Servizio</TITLE>
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
<SCRIPT LANGUAGE='Javascript'>
var objForm = null;
function initialize()
{
	objForm = document.frmDati;
}

function SubmitMe()
{
  if (opener && !opener.closed) 
  {
	opener.dialogWin.returnedValue = getRadioButtonValue(objForm.SelPs);
	opener.dialogWin.returnFunc();
	self.close();
  }
  else 
  {
	alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
    self.close();
  }
}

function CancelMe()
{
  self.close();
}

</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" method="post" action=''>
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="Cliente" value="<%=strCliente%>">
<input type="hidden" name="CodeCliente" value="<%=strCodeCliente%>">
<input type="hidden" name="Contratto" value="<%=strContratto%>">
<input type="hidden" name="nomeCombo" value="<%=strNomeCombo%>">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
<input type="hidden" name="parMostraCliente" value="<%=strMostraCliente%>">
<input type="hidden" name="parMostraContratto" value="<%=strMostraContratto%>">
<input type="hidden" name="hidCodiceTipoContratto" value="<%=strCodiceTipoContratto%>">
<input type="hidden" name="parPsPadre" value="<%=strPs%>">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Selezione ISP/OLO per Tipologia di contratto</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
                  </tr>
              </table>
            </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Contratto</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                        <tr>
                          <td colspan='4' bordercolor="<%=StaticContext.bgColorCellaBianca%>" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='1'></td>
                        </tr>
                        <tr>
                            <td align="left">
								<table>
									<tr>
										<td class="textB" align="left">Risultati per pag.:&nbsp;</td>
					                    <td class="text">
					                        <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_sel_ps_x_tipo_contr_cl.jsp')">
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
								</table>
                                <table border="0">
                                    <tr>
                                         <td colspan="2" width="" bordercolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB" align="right">Tipo Contratto:&nbsp;</td>
                                         <td colspan="2" width="" class="text" nowrap>&nbsp;<%=strDescTipoContratto%></td>
                                    </tr>
                                    <tr>
										<%//quando la pagina si ricarica dal paginatore parMostrCliente e l'altro potrebbero essere vuoti  non solo null%>
                                        <%if(strMostraCliente.equals("")){%>
                                          <td width="" height='18' bordercolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB" align="right">Cliente:&nbsp;</td>
                                          <td width="" class="text" nowrap>&nbsp;<%=strCliente%></td>
                                        <%}else{%>
                                          <td width="" height='18' bordercolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB" align="right">&nbsp;</td>
                                          <td width="" class="text" nowrap>&nbsp;</td>
                                        <%}%>
                                        <%if(strMostraContratto.equals("")){%>
                                          <td width="" bordercolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB" align="right">Contratto:&nbsp;</td>
                                          <td width="" class="text" nowrap>&nbsp;<%=strContratto%></td>
                                        <%}else{%>
                                          <td width="" bordercolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB" align="right"></td>
                                          <td width="" class="text" nowrap>&nbsp;</td>  
                                        <%}%>
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
          <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
        </tr>

        <tr>
            <td>
			<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        	<tr>
            	<td>
				<!--tabella-->
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Selezione Prodotto Servizio</td>
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
                <% if ((psVector==null)||(psVector.size()==0)){%>
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">Nessun P/S valido!</td>
                          </tr>
                <%}else{
                    int intRecTotali=psVector.size();%>
                   <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                   
                    <%for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                      {
                                DB_ProdottiServizi lobj_PS=new DB_ProdottiServizi();
                                lobj_PS=(DB_ProdottiServizi)psVector.elementAt(j);
                                if ((j%2)==0){
                                  bgcolor=StaticContext.bgColorRigaDispariTabella;
                                }else{
                                  bgcolor=StaticContext.bgColorRigaPariTabella;
                                } 
                                if (j==((pagerPageNumber.intValue()-1)*intRecXPag)){
                                    codice=lobj_PS.getCODE_PS();
                                    descrizione=lobj_PS.getDESC_ES_PS();
                                    strChecked = "checked";
                                }else{
                                    strChecked = "";
                                }%>
                                <tr>
                                  <td width='2%' bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                                    <input bgcolor="<%=StaticContext.bgColorCellaBianca%>" type='radio' <%=strChecked%>  name='SelPs' value='<%=lobj_PS.getCODE_PS()%>$<%=lobj_PS.getCODE_CLASS_PS()%>$<%=lobj_PS.getDESC_ES_PS()%>'>
                                  </td>
                                  <td bgcolor='<%=bgcolor%>' class='text'><%=lobj_PS.getDESC_ES_PS()%></td>
                                </tr>
                     <%}%>
                                    <tr>
                                        <td colspan='3' class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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
                <%}%>
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
            <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
          </tr>
	      <tr>
       		<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
            <input class="textB" type="button" name="Seleziona" value="Seleziona" onClick="if (this.disabled) return false; else SubmitMe();">
			<%if(psVector==null||psVector.size()==0){%>
				<script>
					var objForm = document.frmDati;
					Disable(objForm.Seleziona);
				</script>
			<%}%>
            <input class="textB" type="button" name="Annulla" value="Annulla" onClick = "javascript:CancelMe();">
            <input type=hidden name="CodeContr" value="<%=strCodContratto%>">
	        </td>
	      </tr>
	    </table>
		</td>
		</tr>
		</table>
    </td>
</tr>
</table>
<%
  if ((psVector==null)||(psVector.size()==0))
  {
%>
    <script>
      Disable(objForm.Seleziona);
    </script>
<%
  }
%>
</form>
</BODY>
</HTML>
