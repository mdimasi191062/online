<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="com.utl.*" %>
<%@ page import="java.util.Vector" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth/>
<%
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
	String strMessage = Misc.nh(request.getParameter("strMessage"));
	String strImage = Misc.nh(request.getParameter("strImageDirPadre"));
	String strViewType = Misc.nh(request.getParameter("strViewType"));
	int i = 0;
	Vector lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
	intRecTotali = lvct_AccountPagina.size();
	
%>
<HTML>
<HEAD>
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
	<script language="JavaScript">
		var objForm = null;
		function initialize()
		{
			objForm = document.frmDati;
		}
		
		function ONCONFERMA(){
			//idBody.onunload = nothing;
			if (opener && !opener.closed) 
			{
				opener.dialogWin.state = "CONFERMA";
	            opener.dialogWin.returnFunc();
				self.close();
			}
			else
			{ 
				alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
				self.close();
			}
		}
		
		function ONANNULLA(){
			//idBody.onunload = nothing;
			if (opener && !opener.closed) 
			{
				opener.dialogWin.state = "ANNULLA";
	            opener.dialogWin.returnFunc();
				self.close();
			}
			else
			{ 
				alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
				self.close();
			}
		}
		
		function nothing()
		{}
	</script>
</HEAD>
<BODY id="idBody" onload="initialize()" >
<form name="frmDati" action = "PP_Pag_Account_cl.jsp" method="post">
<input type = "hidden" name = "hidTypeLoad" value="">
<input type = "hidden" name = "strMessage" value="<%=strMessage%>">
<input type = "hidden" name = "strImageDirPadre" value="<%=strImage%>">
<input type = "hidden" name = "strViewType" value="<%=strViewType%>">

<!-- Immagine Titolo -->
		<table align="center" width="100%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="../../<%=strImage%>/images/titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table>
		<!--TITOLO PAGINA-->
		<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
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
		<table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
			<tr>
                    <td class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
				 	Risultati per pag.:&nbsp;
					<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','PP_Pag_Account_cl.jsp');">
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
	                <%=strMessage%>?
	            </td>
	        </tr>
		</table>
		
		<table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='2'></td>
		</tr>
		<tr>
			<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">
				<%if(strViewType.equals("")){%>
					Codice Account
				<%}else{%>
					Codice Cliente
				<%}%>
			</td>
			<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">
				Descrizione
			</td>
		</tr>
		<%
		String bgcolor="";%>
		<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
		<%for(i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < intRecTotali) && (i < pagerPageNumber.intValue()*intRecXPag));i++){	
			DB_Account lobj_Account=new DB_Account();
			lobj_Account=(DB_Account)lvct_AccountPagina.elementAt(i);
			if ((i%2)==0){
				bgcolor=StaticContext.bgColorRigaPariTabella;
			}else{
				bgcolor=StaticContext.bgColorRigaDispariTabella;
			}%>		
			<tr>
				<td bgcolor='<%=bgcolor%>' class='text'>
					<%if(strViewType.equals("")){%>
						<%=lobj_Account.getCODE_ACCOUNT()%>
					<%}else{%>
						<%=lobj_Account.getCODE_GEST()%>
					<%}%>
				</td>
				<td bgcolor='<%=bgcolor%>' class='text'>
					<%if(strViewType.equals("")){%>
						<%=lobj_Account.getDESC_ACCOUNT()%>
					<%}else{%>
						<%=lobj_Account.getNOME_RAG_SOC_GEST()%>
					<%}%>
				</td>
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
	<table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
		<tr>
            <td align=center class=text>
        		<sec:ShowButtons td_class="textB"/>
            </td>
        </tr>
	</table>
</form>
</BODY>
</HTML>