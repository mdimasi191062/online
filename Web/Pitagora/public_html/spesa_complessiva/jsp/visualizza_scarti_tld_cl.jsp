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
<%@ page import="com.utl.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>

<EJB:useHome id="homeEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessivaHome" location="Ent_SpesaComplessiva" />
<EJB:useBean id="remoteEnt_SpesaComplessiva" type="com.ejbSTL.Ent_SpesaComplessiva" scope="session">
    <EJB:createBean instance="<%=homeEnt_SpesaComplessiva.create()%>" />
</EJB:useBean>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"visualizza_scarti_tld_cl.jsp")%>
</logtag:logData>
<%	
	String strCodeAccountPerScarti = Misc.nh(request.getParameter("hidCodeAccountPerScarti"));
	String strCodeFunz = Misc.nh(request.getParameter("hidCodeFunz"));
	String strCodeTestSpesaCompl = Misc.nh(request.getParameter("hidCodeTestSpesaCompl"));
	
	String strCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
	String strDescTipoContratto = Misc.nh(request.getParameter("hidDescTipoContratto"));
	String strOggetto = "";
	String strCodice = "";
	int intAction;
	int intFunzionalita;
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
%>
<html>
<title>VISUALIZZA SCARTI TLD</title>
<head>
	<link rel="STYLESHEET" type="text/css" HREF="<%=StaticContext.PH_CSS%>Style.css">
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
			//impostazione delle proprietà di default per tutti gli oggetti della form
			setDefaultProp(objForm);
			if(objForm.chkScarto == null){
				Disable(objForm.cmdConferma);
			}
        }
		function click_cmdConferma(){
			if(checkContinua()){
				preparePageFields()
				objForm.action="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>cbn1_scarti_2_cl.jsp";
				objForm.submit();
			}
		}
		function click_cmdAnnulla(){	
			self.close();
		}
		function preparePageFields()
		{
			var strAppo = "";
			var i = 0;
			if(objForm.chkScarto.length==null){
				strAppo = objForm.chkScarto.value + "=" + valueChecked(objForm.chkScarto.checked);
			}else{
				for(i=0;i<objForm.chkScarto.length;i++)
				{
					if(strAppo != ""){
						strAppo +=  "|" + objForm.chkScarto[i].value + "=" + valueChecked(objForm.chkScarto[i].checked);
					}else{
						strAppo += objForm.chkScarto[i].value + "=" + valueChecked(objForm.chkScarto[i].checked);
					}
				}
			}
			objForm.hidViewState.value = strAppo;
		}
		function valueChecked(pstrCheck){
			if(pstrCheck==true){
				return "S";
			}else{
				return "N";
			}
		}
	 </SCRIPT>
</head>
<body onload="initialize()">
<form name="frmDati" method="post" action=''>
<input type="hidden" name="intAction" value="<%=intAction%>">
<input type="hidden" name="intFunzionalita" value="<%=intFunzionalita%>">
<input type="hidden" name="hidViewState" value="">
<br>
<!-- Dati -->
<table border="0" align="center" width="85%" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" cellspacing="0" cellpadding="0">
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
				  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Visualizza Scarti TLD</td>
				  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
				</tr>
			 </table>
		</td>
	</tr>
</table>
<!-- Dati -->
<table border="0" align="center" width="85%" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="95%" border="0" cellspacing="1" cellpadding="1" align="center">
				<tr bgcolor="<%=StaticContext.bgColorTestataTabella%>">
					<td class="textB" width="10%">Tipo</td>
					<td class="textB" width="70%">Motivo</td>
					<td class="textB" width="20%">Codice</td>
				</tr>
				<%String strChecked = "";%>
				<%String strBgColor = StaticContext.bgColorRigaDispariTabella;%>
				<%Vector lvct_Scarti = null;%>
				<%lvct_Scarti = (Vector)remoteEnt_SpesaComplessiva.getScartiTLD(strCodeFunz);
    			if (lvct_Scarti!=null)
    			{%>
    				<%for(int i=0;i < lvct_Scarti.size();i++)
      				{
        				DB_Scarti objScarto = new DB_Scarti();
        				objScarto=(DB_Scarti)lvct_Scarti.elementAt(i);
        				if ((i%2)==0){
          					strBgColor=StaticContext.bgColorRigaDispariTabella;
				        }else{
				          	strBgColor=StaticContext.bgColorRigaPariTabella;
						}%>
						
						<tr bgcolor="<%=strBgColor%>">
							<td class="text" align="center"><%=objScarto.getTIPO_FLAG_TIPO_SCARTO()%></td>
							<td class="text"><%=objScarto.getDESC_MOTIVO_SCARTO()%></td>
							<td class="text" align="center"><%=objScarto.getCODE_SCARTO()%></td>
						</tr>
					<%}
				}else{%>
					<tr>
						<td colspan="10">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="10" class="text" align="center">Nessuno Scarto Presente!</td>
					</tr>
					<tr>
						<td colspan="10">&nbsp;</td>
					</tr>
				<%}%>
			</table>
		</td>
	</tr>
    <tr>
      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    </tr>
</table>
<!-- pulsantiera-->
 <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
   <tr>
	 <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
         <!-- <input class="textB" type="button" name="cmdConferma" value="Conferma" onClick = "click_cmdConferma();"> -->
		 <input class="textB" type="button" name="cmdAnnulla" value="Annulla" onClick = "click_cmdAnnulla();">
     </td>
   </tr>
 </table>	
</form>

</body>
</html>