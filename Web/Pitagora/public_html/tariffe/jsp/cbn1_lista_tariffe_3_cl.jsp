<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_tariffe_2_cl.jsp")%>
</logtag:logData>

<!-- insatnziazione dell'oggetto remoto  -->
<EJB:useHome id="homeEnt_Tariffe" type="com.ejbSTL.Ent_TariffeHome" location="Ent_Tariffe" />
<EJB:useBean id="remoteEnt_Tariffe" type="com.ejbSTL.Ent_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_Tariffe.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Tariffe" type="com.ejbSTL.Ctr_TariffeHome" location="Ctr_Tariffe" />
<EJB:useBean id="remoteCtr_Tariffe" type="com.ejbSTL.Ctr_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Tariffe.create()%>" />
</EJB:useBean>
<%
	String strCodeTariffa = Misc.nh(request.getParameter("codeTariffa"));
	int i = 0;
	String strChecked = "";
	String bgcolor = "";
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
%>
<HTML>
<HEAD>

    <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
    <!--<SCRIPT LANGUAGE="JavaScript" SRC="../script/security.js"></SCRIPT>-->
    <TITLE>Selezione Clienti</TITLE>
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
		function click_cmdChiudi()
		{
			self.close();
		}
    </SCRIPT>
</HEAD>

<BODY onload="initialize()">
<form name="frmDati" method="post" action=''>
<!-- campi hidden per il passaggio dei valori quando viene richiesto il dettaglio -->
<input type = "hidden" name = "hidTypeLoad" value="">
<!-- visualizzazione delle descrizioni  -->
<table align='center' width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
	<tr>
		<td>
		  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dettaglio Tariffa</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		  </table>
		</td>
	</tr>
 </table>
      <!-- lista dettaglio tariffe -->     
      <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
	  	<tr>
         <td colspan="10" class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
		 	Risultati per pag.:&nbsp;
			<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_lista_tariffe_3_cl.jsp');">
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
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Offerta</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Cl.Sc.</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Cl.Sc.</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo Tariffa</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Fascia</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Fascia</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Importo</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Inizio</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Fine</td>
          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Creazione</td>
        </tr>
          <%
          //annullo il vettore 
          Vector vctTariffeDettaglio = null;
          if(strCodeTariffa != null)
          {
		  	 	  if (strtypeLoad.equals("1")) //paginazione
				  {
					vctTariffeDettaglio = (Vector) session.getAttribute("vctTariffeDettaglio");
				  }
				  else //query
				  {
					vctTariffeDettaglio = remoteEnt_Tariffe.getDettaglioTariffa(StaticContext.LIST,
                                                         				strCodeTariffa,
												   						"");//CODE_PR_TARIFFA
					if (vctTariffeDettaglio != null)
					  session.setAttribute("vctTariffeDettaglio", vctTariffeDettaglio);
				  }							   
          }
          
          // se il vettore � stato caricato si prosegue con il caricamento della lista
         
          if (vctTariffeDettaglio!=null)
          {
		if(vctTariffeDettaglio.size() > 0){
			intRecTotali = vctTariffeDettaglio.size();
			%>
			<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
              <%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++)
              {
                DB_Tariffe lobj_Tariffa = new DB_Tariffe();
                lobj_Tariffa = (DB_Tariffe)vctTariffeDettaglio.elementAt(i);
                 // permette di selezionare per default il primo radio button
                 if (i == ((pagerPageNumber.intValue()-1)*intRecXPag))
                    strChecked = "checked";
                 else
                    strChecked = "";
                 //verifica se il numero di riga � pari o dispari per la colorazione delle righe   
                 if ((i%2)==0)
                   bgcolor=StaticContext.bgColorRigaDispariTabella;
                 else
                   bgcolor=StaticContext.bgColorRigaPariTabella;
            %>
                  <tr>
                    <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getDESC_TIPO_OFF()%></td>
                    <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MIN_SPESA())%></td>
                    <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MAX_SPESA())%></td>
                    <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_TARIFFA())%></td>
                    <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MIN()%></td>
                    <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MAX()%></td>
                    <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getTIPO_FLAG_MODAL_APPL_TARIFFA()%></td>
                    <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getDATA_INIZIO_TARIFFA()%></td>
                    <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getDATA_FINE_TARIFFA()%></td>
                    <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=DataFormat.truncData(lobj_Tariffa.getDATA_CREAZ_TARIFFA())%></td>
                  </tr>
                 <%
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
				 <tr>
				  	<td class="text" colspan="10" align="center">
						<input class="textB" type="button" name="cmdChiudi" value="Chiudi" onclick="click_cmdChiudi()">
					</td>
				  </tr>
              <%}else{%>
			  <tr>
			  	<td class="text" colspan="15" align="center">
					&nbsp;<BR>no record found
				</td>
			  </tr>
			<%}%>
	  <%}%>
      </table>
	
</form>
</BODY>
</HTML>