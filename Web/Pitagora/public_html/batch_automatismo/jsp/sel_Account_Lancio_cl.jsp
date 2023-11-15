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
<%@ page import="com.ejbSTL.Ctr_SpesaComplessiva"%>
<%@ page import="com.ejbSTL.Ctr_SpesaComplessivaHome"%>
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
<%=StaticMessages.getMessage(3006,"sel_Account_lancio_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_Batch_PRE" type="com.ejbSTL.Ent_Batch_PREHome" location="Ent_Batch_PRE" />
<EJB:useBean id="remoteEnt_Batch_PRE" type="com.ejbSTL.Ent_Batch_PRE" scope="session">
    <EJB:createBean instance="<%=homeEnt_Batch_PRE.create()%>" />
</EJB:useBean>

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
	
	//variabile del cliente
	String strCliente = "";
  String lstrCodiceTipoContratto = "";
	
	boolean blnNoRecord = false;
	int i = 0;
	String bgcolor="";
	
	String strCodeFunzionalitaRibes = Misc.nh(request.getParameter("Funzionalita"));
	
	Vector lvct_AccountPagina = new Vector();
	// carico il vettore
	int typeLoad=0;
	if (strtypeLoad!="")
	{
		Integer tmptypeLoad=new Integer(strtypeLoad);
		typeLoad=tmptypeLoad.intValue();
	}
	if (typeLoad!=0)
  {
		lvct_AccountPagina = (Vector) session.getAttribute("lvct_AccountPagina");
    lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
  }
	else
	{
	//scarico parametri utili al metodo
    lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
    strCliente = Misc.nh(request.getParameter("txtCliente"));
	
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	String strCodeUtente = objInfoUser.getUserName();
	
		lvct_AccountPagina = (Vector)remoteEnt_Batch_PRE.GetAccountValidi(lstrCodiceTipoContratto,strCliente);
		if (lvct_AccountPagina!=null)
			session.setAttribute("lvct_AccountPagina", lvct_AccountPagina);
      lstrCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	}
	intRecTotali = lvct_AccountPagina.size();
	if(intRecTotali == 0){
		blnNoRecord = true;
	}
%>
<HTML>
<HEAD>
	<title>Scelta Account</title>
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
		var blnNoRecord = <%=blnNoRecord%>;
		function initialize()
		{
			objForm = document.frmDati;
      //Disable(objForm.cboNumRecXPag);
			
			//inizializzazione attributi campi per la validazione
			if(blnNoRecord){
				Disable(objForm.CONFERMA);
			}
		}
		
		function ONCONFERMA(){
			//idBody.onunload = nothing;
			if (opener && !opener.closed) 
			{
				
				if(getRadioButtonValue(objForm.optCodeAccount)=="undefined"){
					opener.dialogWin.returnedValue = "|";
				}else{
					opener.dialogWin.returnedValue = getRadioButtonValue(objForm.optCodeAccount);
				}
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
		//inserimento funzione per la gestione della ricerca
		function submitRicerca(typeLoad)
			{
			  var stringa="";
			  stringa=objForm.txtCliente.value;
			  objForm.txtCliente.value=stringa.toUpperCase();
			  objForm.hidTypeLoad.value = "0";
			  objForm.action = "sel_Account_Lancio_cl.jsp";
			  objForm.submit();
			}
	</script>
</HEAD>
<BODY id="idBody" onload="initialize()" >
<form name="frmDati" action = "sel_Account_Lancio_cl.jsp" method="post">
<input type = "hidden" name = "hidTypeLoad" value="">
<input type = "hidden" name = "codiceTipoContratto" value="<%=lstrCodiceTipoContratto%>">

<!-- Immagine Titolo -->
		<!-- <table align="center" width="100%"  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td align="left"><img src="../../<%//=strImage%>/images/titoloPagina.gif" alt="" border="0"></td>
		  <tr>
		</table> -->
		<!--TITOLO PAGINA-->
		<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
		<%if(lvct_AccountPagina.size()!=0){%>
			<tr>
				<td>
				 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
					  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Account</td>
					  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
					</tr>
				 </table>
				</td>
			</tr>
		</table>
		
		<!-- faccio vedere i record da eliminare-->
		<table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		 <tr>
               <td class="text">Nome Cliente (ISP/OLO):&nbsp;<input class="text" type='text' name='txtCliente' value='<%=strCliente%>' size='15'>&nbsp;<input type="button" class="textB" name="Esegui" value="ESEGUI" onclick="submitRicerca('0');"></td>
               <td class="textB">&nbsp;</td>
                   

           </tr>
			<tr>
                    <td class="textB" align="left" bgcolor="<%=StaticContext.bgColorTestataTabella%>">
				 	Risultati per pag.:&nbsp;
					<select class="text" name="cboNumRecXPag" onchange="reloadPage('1','sel_Account_Lancio_cl.jsp?codiceTipoContratto=<%=lstrCodiceTipoContratto%>');">
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
		<br>
		<table width="70%" align='center' border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../img/pixel.gif" width="1" height='2'></td>
		</tr>
		<tr>
			<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">
				&nbsp;
			</td>
			<!-- <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">
				Codice Account
			</td> -->
			<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">
				Descrizione
			</td>
		</tr>
		<%}else{%>
			<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
				<td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
			</tr>
		<%}%>
		<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
    <pg:param name="codiceTipoContratto" value="<%=lstrCodiceTipoContratto%>"></pg:param>
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
					<input type="Radio" name="optCodeAccount" value="<%=lobj_Account.getCODE_ACCOUNT()%>|<%=lobj_Account.getDESC_ACCOUNT()%>">
				</td>
				<!-- <td bgcolor='<%=bgcolor%>' class='text'>
					<%=lobj_Account.getCODE_ACCOUNT()%>
				</td> -->
				<td bgcolor='<%=bgcolor%>' class='text'>
					<%=lobj_Account.getDESC_ACCOUNT()%>
				</td>
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