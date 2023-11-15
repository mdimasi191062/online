<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth isModal="true"/>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_vis_listino_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Tariffe" type="com.ejbSTL.Ent_TariffeHome" location="Ent_Tariffe" />
<EJB:useBean id="remoteEnt_Tariffe" type="com.ejbSTL.Ent_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_Tariffe.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<%
//dichiarazioni delle variabili
String strAppoData = "";
//codici
String strCodeContr = "";
String strCodeTipoContratto = "";
String strCodeCliente = "";
String strCodePs = "";
String strCodePrestAgg = "";
String strCodeTipoCaus = "";
String strCodeOggFatt = "";
String strCodeClasse = "";//non serve in questa pagina
//descrizioni 
String strDescTipoContratto = "";
String strDescContratto = "";
String strDescCliente = "";
String strDescPS = "";
String strDescPrestAgg = "";
String strDescOggFatt = "";
String strDescTipoCaus = "";
//altro
//paginatore
int intRecXPag = 0;
int intRecTotali = 0;
if(request.getParameter("cboNumRecXPag")==null){
	intRecXPag=5;
}else{
	intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
}
String strtypeLoad = Misc.nh(request.getParameter("hidTypeLoad"));
String strSelected = "";
//fine paginatore
String strMostraStoricoTariffe = "";
int intAction=0;
int intFunzionalita=0;
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@PARAMETRI PROVENIENTI DALLA PMASCHERA DI RICERCA@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//reperisco  parametri
String strViewStateRicerca = Misc.nh(request.getParameter("viewStateRicerca"));
//ricevo i prametri per invocare il metodo che carica la lista
//codici
strCodeTipoContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeTipoContratto");
strCodeContr = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeContratto");
strCodeCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeCliente");
strCodePs = Misc.getParameterValue(strViewStateRicerca,"vsRicCodePS");
strCodePrestAgg = Misc.getParameterValue(strViewStateRicerca,"vsRicCodePrestAgg");
strCodeTipoCaus = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeTipoCaus");
strAppoData = Misc.getParameterValue(strViewStateRicerca,"vsRicCodeOggFatt");
if(strAppoData.equals("")){
	strCodeOggFatt = "";
}else{
	strCodeOggFatt = (String)Misc.split(strAppoData,"$").elementAt(0);
}
//Descrizioni
strDescTipoContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicDescTipoContratto");
strDescContratto = Misc.getParameterValue(strViewStateRicerca,"vsRicDescContratto");
strDescCliente = Misc.getParameterValue(strViewStateRicerca,"vsRicDescCliente");
strDescPS = Misc.getParameterValue(strViewStateRicerca,"vsRicDescPs");
strDescPrestAgg = Misc.getParameterValue(strViewStateRicerca,"vsRicDescPrestAgg");
strDescOggFatt = Misc.getParameterValue(strViewStateRicerca,"vsRicDescOggFatt");
strDescTipoCaus = Misc.getParameterValue(strViewStateRicerca,"vsRicDescTipoCaus");
//altro
intFunzionalita = Integer.parseInt(Misc.getParameterValue(strViewStateRicerca,"vsRicIntFunzionalita"));
intAction = Integer.parseInt(Misc.getParameterValue(strViewStateRicerca,"vsRicIntAction"));
strMostraStoricoTariffe = Misc.getParameterValue(strViewStateRicerca,"vsRicMostraStoricoTariffe");
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
int i=0;
String bgcolor = "";
String strChecked = "";
%>

<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>Listino Tariffario</TITLE>
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
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null;
	function Initialize()
	{
		objForm = document.frmDati;
		setDefaultProp(objForm);
	}
	function ONSTAMPA(){
		if(checkContinua()){
			/*//preparePageFields()
			objForm.action="cbn1_vis_listino_3_cl.jsp";
			objForm.submit();
			//window.print();*/
			var stringa="<%=StaticContext.PH_LISTINOTARIFFARIO_JSP%>cbn1_vis_listino_3_cl.jsp";
			openDialog(stringa, 569, 400, "" ,"print");
		}
	}

// MODIFICA DEL 27/04/2004
 function ONCHIUDI()
 {
  window.close();
 }
//FINE MODIFICA
	function preparePageFields()
	{
		var strAppo = "";
		var i = 0;
		if(objForm.chkTariffa.length==null){
			if(objForm.chkTariffa.checked){
				objForm.hidViewStateTariffe.value = objForm.chkTariffa.value;
			}
		}else{
			for(i=0;i<objForm.chkTariffa.length;i++){
				if(objForm.chkTariffa[i].checked){
					if(strAppo != ""){
						strAppo +=  "|" + objForm.chkTariffa[i].value;
					}else{
						strAppo += objForm.chkTariffa[i].value;
					}
				}
			}
		}
		objForm.hidViewStateTariffe.value = strAppo;
	}
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
<input type="hidden" name="strCodeTipoContratto" value="<%=strCodeTipoContratto%>">
<input type="hidden" name="hidDescTipoContratto" value="<%=strDescTipoContratto%>">
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidViewStateTariffe" value="">
<input type="hidden" name="viewStateRicerca" value="<%=strViewStateRicerca%>">
<input type = "hidden" name = "hidTypeLoad" value="">
<!-- Immagine Titolo -->
<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="<%=StaticContext.PH_LISTINOTARIFFARIO_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">LISTINO TARIFFARIO</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<br>
<!-- visualizzazione delle descrizioni  -->
<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
		<tr>
			<td>
			  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
				  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;LISTINO TARIFFARIO</td>
				  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
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
      <table align='center' width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
      <tr>
	  	<td width="15%" height="20" class="textB" align="right">Tipo Contratto:&nbsp;</td>
        <td width="35%" height="20" class="text">
         	<%=strDescTipoContratto%>
        </td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	  </tr>
	  <tr>
        <td width="15%" height="20" class="textB" align="right">Cliente:&nbsp;</td>
        <td width="35%" height="20" class="text">
         	&nbsp;<%=strDescCliente%>
        </td>
        <td width="15%" height="20" class="textB" align="right">Contratto:&nbsp;</td>
        <td width="35%" height="20" class="text">
          &nbsp;<%=strDescContratto%>
        </td>
      </tr>
      <tr>
        <td width="15%" height="20" class="textB" align="right" valign="top">P/S:&nbsp;</td>
        <td width="35%" height="20" class="text">
         &nbsp;<%=strDescPS%>
        </td>
        <td width="15%" height="20" class="textB" align="right">Prestazione&nbsp;<BR>Aggiuntiva:&nbsp;</td>
        <td width="35%" height="20" class="text">
           &nbsp;<%=strDescPrestAgg%>
        </td>
      </tr>
      <tr>
        <td width="15%" height="20" class="textB" align="right" valign="top">Oggetto Fatturazione:&nbsp;</td>
        <td width="35%" height="20" class="text">
         &nbsp;<%=strDescOggFatt%>
        </td>
        <td width="15%" height="20" class="textB" align="right">Tipo Causale:&nbsp;</td>
        <td width="35%" height="20" class="text">
           &nbsp;<%=strDescTipoCaus%>
        </td>
      </tr>
	  <tr>
	  	<td width="15%" height="20" class="textB" align="left" nowrap>Mostra Storico Tariffe:&nbsp;</td>
		<td width="85%" height="20" class="text" colspan="3">
        	<%if(strMostraStoricoTariffe.equals("S")){out.print("SI");} else{out.print("NO");}%>
		</td>
	  </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
</table>
 <!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lista Tariffe</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<!-- tabella risultati -->
<table align='center' width="85%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width='100%' colspan='3'>
			<table width="95%" cellspacing="1" align="center">
				<tr>
	                 <td colspan='3' class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
					 	Risultati per pag.:&nbsp;
						<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_vis_listino_2_cl.jsp');">
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
				<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
					<td width="" class="textB">P/S</td>
					<td width="" class="textB">Ogg. Fatturaz.</td>
					<td width="" class="textB">Importo</td>
				</tr>
				<%
				Vector vctTariffe = null;
				// carico il vettore
				if(strMostraStoricoTariffe.equals("S")){
					  if (strtypeLoad.equals("1")) //paginazione
				  	  {
						vctTariffe = (Vector) session.getAttribute("vctTariffe");
					  }
					  else //query
					  {
						vctTariffe = remoteEnt_Tariffe.getDettRibaTariffa (intAction,
									                                       strCodeContr,
									                                       strCodePs,
									                                       strCodePrestAgg,
																		   strCodeTipoCaus,
									                                       strCodeOggFatt);
						if (vctTariffe != null)
						  session.setAttribute("vctTariffe", vctTariffe);
					  }
				}else{
					if (strtypeLoad.equals("1")) //paginazione
				  	  {
						vctTariffe = (Vector) session.getAttribute("vctTariffe");
					  }
					  else //query
					  {
						vctTariffe = remoteEnt_Tariffe.getListaTariffe(intAction,
									                               strCodeContr,
									                               strCodePs,
									                               strCodePrestAgg,
									                               strCodeTipoCaus,
									                               strCodeOggFatt);
						if (vctTariffe != null)
						  session.setAttribute("vctTariffe", vctTariffe);
					  }
				}
				intRecTotali = vctTariffe.size();
				%>
				<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
				<%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++)
			       {
						DB_Tariffe lobj_Tariffa = (DB_Tariffe)vctTariffe.elementAt(i);
						//cambia il colore delle righe
						if ((i%2)==0)
		                  bgcolor=StaticContext.bgColorRigaPariTabella;
						        else
		                  bgcolor=StaticContext.bgColorRigaDispariTabella;%>
						<tr bgcolor="<%=bgcolor%>">
							<td width="" class="text" nowrap>&nbsp;<%=Misc.nh(lobj_Tariffa.getDESC_ES_PS())%></td>
							<td width="" class="text" nowrap>&nbsp;<%=Misc.nh(lobj_Tariffa.getDESC_OGG_FATRZ())%></td>
							<td width="" class="textNumber" nowrap>&nbsp;<%=CustomNumberFormat.setToNumberFormat(Misc.nh(lobj_Tariffa.getIMPT_TARIFFA()))%></td>
						</tr>
					<%}%>
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
			</table>
		</td>
	</tr>
	
</table>
<!--PULSANTIERA-->
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	    <tr>
    		<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    	</tr>
		<tr>
        	<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
				<sec:ShowButtons td_class="textB"/>
        	</td>
      	</tr>
    </table> 
</form>
</BODY>
</HTML>