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
<%@ page import="com.usr.*"%>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ver_ndc_3_cl.jsp")%>
</logtag:logData>
<EJB:useHome id="homeCtr_NoteCredito" type="com.ejbSTL.Ctr_NoteCreditoHome" location="Ctr_NoteCredito" />
<EJB:useBean id="remoteCtr_NoteCredito" type="com.ejbSTL.Ctr_NoteCredito" scope="session">
    <EJB:createBean instance="<%=homeCtr_NoteCredito.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Batch" type="com.ejbSTL.Ctr_BatchHome" location="Ctr_Batch" />
<EJB:useBean id="remoteCtr_Batch" type="com.ejbSTL.Ctr_Batch" scope="session">
    <EJB:createBean instance="<%=homeCtr_Batch.create()%>" />
</EJB:useBean>

<%!
	//dichiarazione costanti per gli step
	static final int gintStepElabBatchXlancio = 1;
	static final int gintStepFinal = 2;
	String strParameterToLog = "";
%>
<%
	int intStepNow;
	int intAction;
	int intFunzionalita;
	int intVectorIndex = 0;
	int i = 0;
	boolean blnExit = false;
	String strAppo = "";
	String strResult = "";
	String lstr_CodeTipoContratto = "";
	String lstr_DescTipoContratto = "";
	String lstr_TipoElab = "";
	String strViewState = "";
	String strPageAction = "";
	String strVectorIndex = "";
	String strElaborazioneBatch = "";
	
	Vector lvct_Account = null;
	Vector lvct_AccountDaEliminare = null;
	Vector lvct_AccountRisultato = null;
	Vector lvct_AccountToDel = null;
	Vector lvct_Global1 = new Vector();
	Vector lvct_Global2 = new Vector();
	Vector vctAppo = null;
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
	strPageAction = Misc.nh(request.getParameter("hidPageAction"));
	
	intAction = Integer.parseInt(request.getParameter("intAction"));
	intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	lstr_CodeTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	lstr_DescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	strElaborazioneBatch = Misc.nh(request.getParameter("rdoElaborazioneBatch"));
	
	strAppo = Misc.nh(request.getParameter("rdoElaborazioneBatch"));
	lstr_TipoElab = Misc.getParameterValue(strAppo,"parCodeElab");
	
	strAppo = Misc.nh(request.getParameter("rdoAccountElaborati"));
	vctAppo = Misc.split(strAppo,"|");
	strVectorIndex = (String)vctAppo.elementAt(4);
	intVectorIndex = Integer.parseInt(strVectorIndex);
	
	//prendo i vettori dalla sessione
	lvct_Account = (Vector) session.getAttribute("vctAccountElaborati");
	lvct_AccountDaEliminare = (Vector) session.getAttribute("vctAccountDaEliminare");
	
	strViewState = Misc.nh(request.getParameter("hidViewState"));
	if(strViewState.equals("S")){ //congela selezionato
		vctAppo = new Vector();
		vctAppo.addElement((DB_Account)lvct_Account.elementAt(intVectorIndex));
		lvct_Account = vctAppo;
	}
	
	if(lvct_AccountDaEliminare != null)
	{
		//MATCH VECTORS
		lvct_Global1.addElement(lvct_Account);
		lvct_Global1.addElement(DB_Account.class);
		lvct_Global1.addElement("CODE_ACCOUNT");
		lvct_Global2.addElement(lvct_AccountDaEliminare);
		lvct_Global2.addElement(DB_Account.class);
		lvct_Global2.addElement("CODE_ACCOUNT");
		lvct_AccountRisultato = Misc.MatchVectors(lvct_Global1, lvct_Global2, StaticContext.DIFF);
	}
	else
	{
		lvct_AccountRisultato = lvct_Account;
	}
%>

<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<script language="JavaScript">
		var objForm = null;
		function initialize()
		{
			objForm = document.frmDati;
		}
		
		function ONCONFERMA(){
			objForm.hidPageAction.value = "CONGELA";
            objForm.submit();
		}
		
		function ONANNULLA(){
			objForm.action = "cbn1_ver_ndc_2_cl.jsp";
			objForm.submit();
		}
		
	</script>
</HEAD>

<BODY onload="initialize()">
<form name="frmDati" action="cbn1_ver_ndc_3_cl.jsp">
<input type = "hidden" name = "intAction" value="<%=intAction%>">
<input type = "hidden" name = "intFunzionalita" value="<%=intFunzionalita%>">
<input type = "hidden" name = "codiceTipoContratto" value="<%=lstr_CodeTipoContratto%>">
<input type = "hidden" name = "hidDescTipoContratto" value="<%=lstr_DescTipoContratto%>">
<input type = "hidden" name = "hidViewState" value="<%=strViewState%>">
<input type = "hidden" name = "hidPageAction" value="">
<input type = "hidden" name = "rdoAccountElaborati" value="<%=strAppo%>">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="rdoElaborazioneBatch" value="<%=strElaborazioneBatch%>">


  <%if(strPageAction.equals(""))
	{
		//faccio il controllo per i record da eliminare
		Vector vctAccountElaborati = null;
		// carico il vettore
		  int typeLoad=0;
		  if (!strtypeLoad.equals(""))
		  {
		    Integer tmptypeLoad=new Integer(strtypeLoad);
		    typeLoad=tmptypeLoad.intValue();
		  }
		  if (typeLoad!=0)
		    lvct_AccountToDel = (Vector) session.getAttribute("vctAccountDaEliminare");
		  else
		  {
		    lvct_AccountToDel = remoteCtr_Batch.getElabBatchXLancio(lstr_CodeTipoContratto,lvct_Account,"");
		    if (lvct_AccountToDel != null)
		      session.setAttribute("vctAccountDaEliminare", lvct_AccountToDel);
		  }
		intRecTotali = lvct_AccountToDel.size();
		if(lvct_AccountToDel.size() == 0){
			strPageAction = "CONGELA";
		}
		else
		{%>
			<!-- Immagine Titolo -->
			<table align="center" width="50%"  border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td align="left"><img src="<%=StaticContext.PH_NOTEDICREDITO_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
			  <tr>
			</table>
			<!--TITOLO PAGINA-->
			<table width="50%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
				<tr>
					<td>
					 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Account da Eliminare</td>
						  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
						</tr>
					 </table>
					</td>
				</tr>
			</table>
			<!-- faccio vedere i record da eliminare-->
			<table width="50%" align='center' border="0" cellspacing="0" cellpadding="0">
				<tr>
                     <td class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
					 	Risultati per pag.:&nbsp;
						<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','cbn1_ver_ndc_3_cl.jsp');">
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
		            <td align=center class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
		                Per i seguenti account esistono elaborazioni batch <br>
		                in corso!<br>
		                Proseguire escludendo gli account individuati?
		        		
		            </td>
		        </tr>
			</table>
			
			<table width="50%" align='center' border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='2'></td>
				</tr>
				<tr>
					<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Account</td>
					<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione</td>
				</tr>
				<%
				String bgcolor="";%>
				<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
					
				<%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++){	
					//for (int i=0;i < lvct_AccountToDel.size(); i++){
					DB_Account lobj_Account=new DB_Account();
					lobj_Account=(DB_Account)lvct_AccountToDel.elementAt(i);
					if ((i%2)==0){
						bgcolor=StaticContext.bgColorRigaPariTabella;
					}else{
						bgcolor=StaticContext.bgColorRigaDispariTabella;
					}%>		
					<tr>
						<td bgcolor='<%=bgcolor%>' class='text'><%=lobj_Account.getCODE_ACCOUNT()%></td>
						<td bgcolor='<%=bgcolor%>' class='text'><%=lobj_Account.getDESC_ACCOUNT()%></td>
					</tr>
				<%}%>
					<tr>
						<td colspan="2" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
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
			<table width="50%" align='center' border="0" cellspacing="0" cellpadding="0">
				<tr>
		            <td align=center class=text>
		        		<sec:ShowButtons td_class="textB"/>
		            </td>
		        </tr>
			</table>
			
	  <%}
	  session.setAttribute("vctAccountDaEliminare", lvct_AccountToDel);
	}
	else
	{
		strPageAction = "CONGELA";
	}
	
	//procede con il conngelamento
	if(strPageAction.equals("CONGELA"))
	{
		//estrazione del code utente loggato dalla sessione
			clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
			String strCodeUtente = objInfoUser.getUserName();
			strParameterToLog = Misc.buildParameterToLog(lvct_AccountRisultato);
			String strLogMessage = "remoteCtr_ValAttiva.congela(" + "CodeTipoContratto=" + lstr_CodeTipoContratto
																	+ ";CodeUtente=" + strCodeUtente 
																	+ ";" + strParameterToLog +")";%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(3502,strLogMessage)%>
			</logtag:logData>
		  <%
			session.removeAttribute("vctAccountElaborati");
			session.removeAttribute("vctAccountDaEliminare");
			strResult = remoteCtr_NoteCredito.congela(lstr_CodeTipoContratto,strCodeUtente,lvct_AccountRisultato); 
			if(strResult.equals(""))
			{
				strLogMessage += ": Successo";
			}
			else
			{
				strLogMessage += ": " + strResult;
			}%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(3502,strLogMessage)%>
			</logtag:logData>
			<%
				String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset); 
				response.sendRedirect(strUrl);
			%>
	<%}%>

</form>
</BODY>
</HTML>
