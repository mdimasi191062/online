<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*,java.util.Vector"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- inclusione della tagLib che permette l'instanziazione dell'oggetto remoto  -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_ass_ofps_X_tipo_contr_2_cl.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPsHome" location="Ctr_AssociazioniOfPs" />
<EJB:useBean id="remoteCtr_AssociazioniOfPs" type="com.ejbSTL.Ctr_AssociazioniOfPs" scope="session">
    <EJB:createBean instance="<%=homeCtr_AssociazioniOfPs.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Contratti" type="com.ejbSTL.Ent_ContrattiHome" location="Ent_Contratti" />
<EJB:useBean id="remoteEnt_Contratti" type="com.ejbSTL.Ent_Contratti" scope="session">
    <EJB:createBean instance="<%=homeEnt_Contratti.create()%>" />
</EJB:useBean>
<%
Vector lvct_ContrattiEsistenti = new Vector();
boolean lbln_Redirect = false;
boolean blnCHKCONTRATTI = Misc.bh(request.getParameter("CHKCONTRATTI"));
String strBgColor="";
//String appoViewState = Misc.nh(request.getParameter("viewState"));
String strCODE_ACCOUNT_ESISTENTI = Misc.nh(request.getParameter("txtCODE_ACCOUNT_ESISTENTI"));
%>

<%
	//ESTRAZIONE CODE OGG FATT
	String lstr_ViewState = request.getParameter("viewState");
	String lstrCodeTipoContratto="";
	String lstrDescrTipoContratto = "";
	String lstrCodeContratto="";
	String lstrCodeOggFat="";
	String lstrCodeClassOggFat="";
	String lstrDataInizioValidOF="";
	String lstrDataFineValidOF="";
	String lstrTipiCausali="";
	String lstrCodePrestAgg="";
	String lstrCodePS="";
	String lstrDataInizioValidita="";
	String lstrDataFineValidita="";
	String lstrModalita="";
	String lstrShiftCanoni="";
	String lstrMsgOutput="";
	String strCodeUtente = "";
	Vector lvctSplit = null;
	lvctSplit = Misc.split(Misc.nh(request.getParameter("cboDescrizioneFat")),"$");
	lstrCodeOggFat=(String)lvctSplit.elementAt(0);
	lstrCodeClassOggFat=(String)lvctSplit.elementAt(1);
	lstrDataInizioValidOF = (String)lvctSplit.elementAt(2);
	lstrDataFineValidOF = (String)lvctSplit.elementAt(3);
	
	//estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	strCodeUtente = objInfoUser.getUserName();
	
	lstrCodeTipoContratto = Misc.getParameterValue(lstr_ViewState,"codeTipoContratto");
	lstrDescrTipoContratto = Misc.getParameterValue(lstr_ViewState,"hidDescTipoContratto");
	
	lstrTipiCausali = Misc.getParameterValue(lstr_ViewState,"tipiCausali");
	lstrCodeContratto = Misc.nh(request.getParameter("cboContratto"));
	lstrCodePrestAgg = Misc.nh(request.getParameter("cboPrestAgg"));
	lstrCodePS = Misc.getParameterValue(lstr_ViewState,"codePs");
	lstrDataInizioValidita = Misc.nh(request.getParameter("txtDataInizioValidita"));
	lstrDataFineValidita = Misc.nh(request.getParameter("txtDataFineValidita"));
	lstrModalita = Misc.nh(request.getParameter("cboModalita"));
	lstrShiftCanoni = Misc.nh(request.getParameter("txtShiftCanoni"));
	
	DB_OggettoFatturazione lobj_OggFatt = new DB_OggettoFatturazione();
	
	//INIZIALIZZAZIONE DEL DATABEAN CON I VALORI CHE ARRIVANO DALLA PAGINA
	lobj_OggFatt.setCODE_OGG_FATRZ(lstrCodeOggFat);//s
	lobj_OggFatt.setDATA_INIZIO_VALID_OF(lstrDataInizioValidOF);//s
	lobj_OggFatt.setCODE_CLAS_OGG_FATRZ(lstrCodeClassOggFat);//s
	lobj_OggFatt.setDATA_FINE_VALID_OF(lstrDataInizioValidOF);//s
	lobj_OggFatt.setCODE_CONTR(lstrCodeContratto);//s
	lobj_OggFatt.setCODE_PREST_AGG(lstrCodePrestAgg);//s
	lobj_OggFatt.setCODE_PS(lstrCodePS);//s
	lobj_OggFatt.setDATA_INIZIO_VALID_OF_PS(lstrDataInizioValidita);//s
	lobj_OggFatt.setDATA_FINE_VALID_OF_PS(lstrDataFineValidita);//s
	lobj_OggFatt.setCODE_FREQ_APPL(Misc.nh(request.getParameter("cboFrequenza")));//s
	lobj_OggFatt.setCODE_MODAL_APPL(Misc.nh(request.getParameter("cboModalitaProrata")));//s
	lobj_OggFatt.setTIPO_FLAG_ANTTO_POSTTO(Misc.nh(request.getParameter("cboModalita")));//s
	lobj_OggFatt.setQNTA_SHIFT_CANONI(Misc.nh(request.getParameter("txtShiftCanoni")));//s
	lobj_OggFatt.setCODE_TIPO_CAUS(lstrTipiCausali);//s
	lobj_OggFatt.setCODE_UTENTE(strCodeUtente);//s
	lobj_OggFatt.setCODE_TIPO_CONTR(lstrCodeTipoContratto);
	//FINE INIZIALIZZAZIONE DEL DATABEAN CON I VALORI CHE ARRIVANO DALLA PAGINA%>
<%
	//CHK CONTRATTI Esistenti.
	if(!blnCHKCONTRATTI){
		lvct_ContrattiEsistenti = (Vector) remoteEnt_Contratti.getAccountEsistentiOfPs(lobj_OggFatt);
	}
	if(lvct_ContrattiEsistenti.size() > 0){
		lbln_Redirect = false;
	}else{
		lbln_Redirect = true;%>

		<%String strLogMessage = "remoteCtr_AssociazioniOfPs.InsAssociazioneOfPsXTipoContr(" + lobj_OggFatt.FieldsToString() + ", " + strCODE_ACCOUNT_ESISTENTI + ")";%>
		<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3503,strLogMessage)%>
		</logtag:logData>
		<%	
		lstrMsgOutput = remoteCtr_AssociazioniOfPs.InsAssociazioneOfPsXTipoContr(lobj_OggFatt, strCODE_ACCOUNT_ESISTENTI);
		if(lstrMsgOutput.equalsIgnoreCase("")){
			lstrMsgOutput = "Inserimento avvenuto con successo!!";
			strLogMessage += " : Successo" ;
		}else{
			strLogMessage += " : " + lstrMsgOutput ;
		}%>
		<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(3503,strLogMessage)%>
		</logtag:logData>
	<%}
%>

<%//mostra l'esito dell'elaborazione
  //	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(lstrMsgOutput,com.utl.StaticContext.ENCCharset); 
  //	response.sendRedirect(strUrl);%>
  
  <%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?CHIUDI_POPUP=true&message=" + java.net.URLEncoder.encode(lstrMsgOutput,com.utl.StaticContext.ENCCharset); 
	if(lbln_Redirect){
		response.sendRedirect(strUrl);
	}else{%>
	<%
	//COSTRUZIONE VETTORE CON I CONTRATTI Esistenti!%>
	<html>
		<head>
			<title></title>
			<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
			<script>
				var objForm = null;
				function initialize()
				{
					objForm = document.frmDati;
				}
				function ONCONTINUA(){
					strURL = "cbn1_ins_ass_ofps_X_tipo_contr_2_cl.jsp";
					strURL +="?CHKCONTRATTI=true";
					objForm.action = strURL;
					objForm.submit();
				}
				function ONANNULLA(){
					/*strURL = "cbn1_ins_ass_ofps_X_tipo_contr_cl.jsp";
					strURL += "?codiceTipoContratto=<%//=lstrCodeTipoContratto%>";
					strURL += "&intAction=<%//=StaticContext.INSERT%>";
					strURL += "&intFunzionalita=<%//=StaticContext.FN_ASS_OFPS%>";
					strURL += "&hidDescTipoContratto=<%//=lstrDescrTipoContratto%>";
					objForm.action = strURL;
					objForm.submit();*/
					window.opener.dialogWin.returnFunc();
					window.parent.close();
				}
			</script>
		</head>
		<BODY onload="initialize()">
			<form name="frmDati" method="post" action=''>
			<input type="hidden" name="viewState" value="<%=lstr_ViewState%>">
			<input type="hidden" name="cboDescrizioneFat" value="<%=Misc.nh(request.getParameter("cboDescrizioneFat"))%>">
			<input type="hidden" name="cboContratto" value="<%=lstrCodeContratto%>">
			<input type="hidden" name="cboPrestAgg" value="<%=lstrCodePrestAgg%>">
			<input type="hidden" name="txtDataInizioValidita" value="<%=lstrDataInizioValidita%>">
			<input type="hidden" name="txtDataFineValidita" value="<%=lstrDataFineValidita%>">
			<input type="hidden" name="cboModalita" value="<%=lstrModalita%>">
			<input type="hidden" name="cboFrequenza" value="<%=Misc.nh(request.getParameter("cboFrequenza"))%>">
			<input type="hidden" name="cboModalitaProrata" value="<%=Misc.nh(request.getParameter("cboModalitaProrata"))%>">
			<input type="hidden" name="cboModalita" value="<%=Misc.nh(request.getParameter("cboModalita"))%>">
			<input type="hidden" name="txtShiftCanoni" value="<%=lstrShiftCanoni%>">
				<!-- Immagine Titolo -->
				<table align="center" width="95%"  border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td align="left"><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
				  <tr>
				</table>
				
				<!--TITOLO PAGINA-->
				<table width="95%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
					<tr>
						<td>
						 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
							<tr>
							  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Inserimento associazione OF a P/S: <%=lstrDescrTipoContratto%></td>
							  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
							</tr>
						 </table>
						</td>
					</tr>
				</table>
				<br>
				<!-- <table width="50%" border="0" bgcolor="<%=StaticContext.bgColorHeader%>" cellspacing="0" cellpadding="0" align='center'>
               	<tr>
                   <td> -->
                       <table align="center" width="50%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                           <tr>
                               <td>
                                   <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                                       <tr>
                                           <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Per i seguenti Account è già presente l'Associazione OF a P/S</td>
                                           <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                                       </tr>
                                   </table>
                              </td>
                           </tr>
                           <tr>
							<td>
								<table width="100%" border="0" bordercolor="red" cellspacing="0" cellpadding="0" align='center'>
									<tr>
										<!-- <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Codice Account</td> -->
										<td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB">Descrizione Account</td>
									</tr>
									<%strCODE_ACCOUNT_ESISTENTI = "";%>
									<%for (int i=0;i < lvct_ContrattiEsistenti.size();i++){
								        DB_Account objDB_Account = new DB_Account();
								        objDB_Account=(DB_Account)lvct_ContrattiEsistenti.elementAt(i);
										if ((i%2)==0){
								          strBgColor=StaticContext.bgColorRigaPariTabella;
								        }else{
								          strBgColor=StaticContext.bgColorRigaDispariTabella;
										}
										if(strCODE_ACCOUNT_ESISTENTI.equals(""))
											strCODE_ACCOUNT_ESISTENTI = objDB_Account.getCODE_ACCOUNT();
										else
											strCODE_ACCOUNT_ESISTENTI += "*" + objDB_Account.getCODE_ACCOUNT();
										%>
										<tr>
											<!-- <td bgcolor='<%=strBgColor%>' class='textNumber'>&nbsp;<%=objDB_Account.getCODE_ACCOUNT()%></td> -->
											<td bgcolor='<%=strBgColor%>' class='text'>&nbsp;<%=objDB_Account.getDESC_ACCOUNT()%></td>
										</tr>
									<%}%>
								</table>
							</td>
						</tr>
					</table>
					<!-- </td>
					</tr>
				</table> -->
				<br>
				<center>
					<font class="text">
						Conferma per proseguire escludendo gli account individuati.<br>
						Annulla per Interrompere l'inserimento dell'associazione OF a P/S.
					</font>
				</center>
				<br>
				<table width="95%" border="0" cellspacing="0" cellpadding="0" align='center'>
					<tr>
						<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
							<sec:ShowButtons td_class="textB"/>
						</td>
					</tr>
				</table>
				<input type="hidden" name="txtCODE_ACCOUNT_ESISTENTI" value="<%=strCODE_ACCOUNT_ESISTENTI%>">
			</form>
		</body>
	</html>
	<%
	}
	%>
