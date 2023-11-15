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
<%@ page import="com.ejbSTL.Ent_Clienti"%>
<%@ page import="com.ejbSTL.Ent_ClientiHome"%>
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"com_sel_gest_lista_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="home" type="com.ejbSTL.Ent_ClientiHome" location="Ent_Clienti" />
<EJB:useBean id="remoteEnt_Clienti" type="com.ejbSTL.Ent_Clienti" scope="session">
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
  String strSelected = "";
  String lstrCodeTipoContratto = Misc.nh(request.getParameter("codeTipoContratto"));
  String lstrCodeTipoCaus = Misc.nh(request.getParameter("codeTipoCaus"));
  String lstrCodePS = Misc.nh(request.getParameter("codePS"));
  String lstrCodeOggFatt = Misc.nh(request.getParameter("codeOggFatt"));
  String lstrCodePrestAgg = Misc.nh(request.getParameter("codePrestAgg"));

  String strtypeLoad = request.getParameter("hidTypeLoad");
  //FINE PARAMETRI DI INPUT DELLA PAGINA++++++++++++++++++++++++++++++
  //GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  int typeLoad=0;
  Vector oloVector=null;
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0) {
    oloVector = (Vector) session.getAttribute("oloVector");
    }
  else
  {
    oloVector = remoteEnt_Clienti.getClientiIspOlo(intAction,
												   lstrCodeTipoContratto,
												   lstrCodeTipoCaus,
												   lstrCodePS,
												   lstrCodeOggFatt,
												   lstrCodePrestAgg);
    if (oloVector!=null)
      session.setAttribute("oloVector", oloVector);
  }
//FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
<TITLE>Selezione Clienti</TITLE>
<SCRIPT LANGUAGE='Javascript'>
var objForm = null;
function initialize()
{
  <%/*Martino Marangi 01/03/2004 */
  if ( 0 == oloVector.size() ){%>
    click_Conferma();
  <%}%>
	objForm = document.frmDati;
}
function click_Conferma()
{
  chiudi("ok");
}
function click_Annulla()
{
  chiudi("nok");
}
function chiudi(pstrEsito){
	if (!opener || opener.closed) 
  	{
		window.alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	    self.close();
	    return false;
	}
	else
	{
		opener.dialogWin.returnedValue=pstrEsito;
		opener.dialogWin.returnFunc();
		self.close();
	}
}

</SCRIPT>
</HEAD>
<BODY onload="initialize()">
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidTypeLoad" value="">
<table align="center" width="90%" border="0" cellspacing="0" cellpadding="0">
<!-- Martino Marangi 18/02/2004 -->
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
                                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;ISP/OLO per Tipologia di contratto selezionata</td>
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
	<table align=center width="80%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
				<table width="80%" border="0">
					<td class="textB" align="left" >Risultati per pag.:&nbsp;</td>
					<td  class="text">
					  <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','com_sel_gest_lista_cl.jsp')">
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
				</table>
			</td>
		</tr> 	
	    <tr>
	        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='3'></td>
	    </tr>
	    <tr>
	        <td>
	            <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
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
	                                        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%" nowrap>La struttura tariffaria verr� cancellata per i seguenti ISP/OLO</td>
	                                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
	                                    </tr>
	                                </table>
	                            </td>
	                          </tr>
	                          <tr>
	                            <td>
	                                <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
	                                    <tr>
	                                        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='2'></td>
	                                    </tr>
	<%
	    int i=0;
	    int j=0;
	    String codice="";
	    String ragsociale="";
	    String bgcolor="";
	    if ((oloVector==null)||(oloVector.size()==0))
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
	                                        <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Nome Cliente (ISP/OLO)</td>
	                                        <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Cliente (ISP/OLO)</td>
	                                    </tr>
	<%
		
			int intRecTotali=oloVector.size();
			
			%>
			<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
			
	     <%for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
	      {
	        DB_Clienti myelement=new DB_Clienti();
	        myelement=(DB_Clienti)oloVector.elementAt(j);
	        if ((i%2)==0)
	          bgcolor=StaticContext.bgColorRigaPariTabella;
	        else
	          bgcolor=StaticContext.bgColorRigaDispariTabella;
	%>
	                                    <tr>
	                                        <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getNOME_RAG_SOC_GEST()%></td>
	                                        <td bgcolor='<%=bgcolor%>' class='text'><%=myelement.getCODE_GEST()%></td>
	                                    </tr>
	                                    <tr>
	                                        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='2'></td>
	                                    </tr>
	<%
	          i+=1;
	        }%>
										<tr>
											<td colspan="10" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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
	                            <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='2'></td>
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

<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
	<tr>
		<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center" colspan="5">
			<!-- Martino Marangi 18/02/2004 sec:ShowButtons td_class="textB"/-->
			<input type="button" class="textB" name="txtConferma" value="Conferma" onClick="click_Conferma();">
			<input type="button" class="textB" name="txtAnnulla" value="Annulla" onClick = "click_Annulla();">
		</td>
	</tr>
</table>
   
</form>
</BODY>
</HTML>
