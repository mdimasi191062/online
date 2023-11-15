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
<%@ page import="com.usr.*"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_cvp_3_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->

<EJB:useHome id="homeCtr_Tariffe" type="com.ejbSTL.Ctr_TariffeHome" location="Ctr_Tariffe" />
<EJB:useBean id="remoteCtr_Tariffe" type="com.ejbSTL.Ctr_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeCtr_Tariffe.create()%>" />
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
String appoViewState = Misc.nh(request.getParameter("hidViewState"));
String strCODE_ACCOUNT_ESISTENTI = Misc.nh(request.getParameter("txtCODE_ACCOUNT_ESISTENTI"));
String strDESCTIPOLOGIACONTRATTO = "Accesso Rete Dati";
%>

<%!

//Oggetti riutilizzati nelle funzioni
HttpSession session=null;
HttpServletRequest request=null;

    String strViewState = "";

	//codici
	String strCodeTipoContratto = "";
	String strCodiciTipiCausali = "";
	String strCodePs = "";
	String strCodePsCompFatt = "";
	String strCodePrestAgg = "";
	String strCodeOggFatt = "";
	String strCodeClassOggFatt =  "";
	String strCodeClassPs = "";
	//dalla seconda pagina
	String strCodeTipoOfferta = "";
	String strCodeTipoImporto = "";
	String strCodeUnitaMisura = "";
	//descrizioni
	String strDescTipoContratto = "";
	String strDescTipiCausali = "";
	String strDescPs = "";
	String strDescPsCompFatt = "";
	String strDescPrestAgg = "";
	String strDescOggFatt = "";
	
	//dalla saconda pagina
	String strDescTariffa = "";
	
	//date
	String strDataInizioValidita = "";
	//azione
	String strPageAction = "";
	//altre
	String strTitoloPagina = "";
    String strCodeFascia = "";
    String strCodePrFascia = "";
    String strCodeClassSconto = "";
    String strCodePrClassSconto = "";
	String strCodeUtente="";
	boolean blnMascheraClassi = false;
	//per log
	String strLogMessage = "";
	int intNumMessage = 0;
	String strParameterToLog = "";
 

//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
Vector lvct_Tariffe = null;
private void inizializeTariffeVector(HttpSession psession, 
                                     HttpServletRequest prequest) throws Exception{
    session = psession;
    request = prequest;
    //estrazione del code utente loggato dalla sessione
	clsInfoUser objInfoUser =(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
	strCodeUtente = objInfoUser.getUserName();
	//se txtImporto � NULL allora c'� pi� di una tariffa
    lvct_Tariffe = new Vector();
    String strAppo = "";
    String strImportoContributi = "";
	String strImportoAccesso = "";
	String strImporto0_60KM = "";
	String strImporto61_300KM = "";
	String strImportoOltre300KM = "";
    String strAppoImporto = "";
    String strTipoImporto = "";
    String strImportoPortaAtm = "";
    DB_Tariffe l_objTariffa = null;
    int j;
    // reperimento dei parametri dal viewState
   
	String strViewState = Misc.nh(request.getParameter("hidViewState"));

	//codici
	strCodeTipoContratto = Misc.getParameterValue(strViewState,"vsCodeTipoContratto");
	strCodiciTipiCausali = Misc.getParameterValue(strViewState,"vsCodiciTipiCausali");
	strCodePs = Misc.getParameterValue(strViewState,"vsCodePs");
	strCodePsCompFatt = Misc.getParameterValue(strViewState,"vsCodePsCompFatt");
	strCodePrestAgg = Misc.getParameterValue(strViewState,"vsCodePrestAgg");
	strCodeOggFatt = Misc.getParameterValue(strViewState,"vsCodeOggFatt");
	strCodeClassOggFatt =  Misc.getParameterValue(strViewState,"vsCodeClassOggFatt");
	strCodeClassPs = Misc.getParameterValue(strViewState,"vsCodeClassPs");
	//dalla seconda pagina
	strCodeTipoOfferta = Misc.getParameterValue(strViewState,"vsCodeTipoOfferta");
	strCodeTipoImporto = Misc.getParameterValue(strViewState,"vsCodeTipoImporto");
	strCodeUnitaMisura = Misc.getParameterValue(strViewState,"vsCodeUnitaMisura");
	//descrizioni
	strDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
	strDescTipiCausali = Misc.getParameterValue(strViewState,"vsDescTipiCausali");
	strDescPs = Misc.getParameterValue(strViewState,"vsDescPs");
	strDescPsCompFatt = Misc.getParameterValue(strViewState,"vsDescPsCompFatt");
	strDescPrestAgg = Misc.getParameterValue(strViewState,"vsDescPrestAgg");
	strDescOggFatt = Misc.getParameterValue(strViewState,"vsDescOggFatt");
	
	//dalla saconda pagina
	strDescTariffa = Misc.getParameterValue(strViewState,"vsDescTariffa");
	
	//date
	strDataInizioValidita = Misc.getParameterValue(strViewState,"vsDataInizioValidita");
	
	blnMascheraClassi = Misc.bh(Misc.getParameterValue(strViewState,"vsMascheraClassi"));
	
	//azioni
	//determina l'azione da eseguire inserimento/modifica
	strPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	
 
	for(j=1;((strAppo = request.getParameter("txtContributi"+j))!=null);j++){
	     strImportoContributi = Misc.nh(request.getParameter("txtContributi"+j));
         strImportoAccesso = Misc.nh(request.getParameter("txtAccesso"+j));
         strImporto0_60KM = Misc.nh(request.getParameter("txt0_60KM"+j));
         strImporto61_300KM = Misc.nh(request.getParameter("txt61_300KM"+j));
         strImportoOltre300KM = Misc.nh(request.getParameter("txtOltre300KM"+j));
         strImportoPortaAtm = Misc.nh(request.getParameter("txtImportoPortaAtm"+j));
		 
		 if(!strImportoPortaAtm.equals(""))
		 {
		 	strTipoImporto = "PA"; //porta ATM
			strAppoImporto = strImportoPortaAtm;
			l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,strTipoImporto,j,"","");
            lvct_Tariffe.addElement(l_objTariffa);
            //imposto la condizione di uscita dal ciclo in quanto deve essere aggiunto un solo elemento
            break;
		 }
         if(!strImportoContributi.equals(""))
         {
            strTipoImporto = "C"; //contributi
            strAppoImporto = strImportoContributi;
            l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,strTipoImporto,j,"","");
            lvct_Tariffe.addElement(l_objTariffa);
         }
         if(!strImportoAccesso.equals(""))
         {
            strTipoImporto = "A"; //accessi
            strAppoImporto = strImportoAccesso;
            l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,strTipoImporto,j,"","");
            lvct_Tariffe.addElement(l_objTariffa);
         }
         if(!strImporto0_60KM.equals(""))
         {
            strTipoImporto = "F"; //fasce
            // in questo caso devo aggiungere 3 elementi uno per ogni importo
            strAppoImporto = strImporto0_60KM; 
            l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,strTipoImporto,j,"1","1");
            lvct_Tariffe.addElement(l_objTariffa);
            strAppoImporto = strImporto61_300KM; 
            l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,strTipoImporto,j,"2","1");
            lvct_Tariffe.addElement(l_objTariffa);
            strAppoImporto = strImportoOltre300KM; 
            l_objTariffa = (DB_Tariffe)inizializeTariffaObject(strAppoImporto,strTipoImporto,j,"3","1");
            lvct_Tariffe.addElement(l_objTariffa);
         }
	    
    }
}
//FUNZIONE CHE INIZIALIZZA IL VETTORE DELLE TARIFFE
//CON I DATI CHE ARRIVANO DALLA PAGINA
private DB_Tariffe inizializeTariffaObject(String p_strImporto,String p_strTipoImporto,int p_intNumRow,String p_strCodePrFascia,String p_strCodeFascia) throws Exception{
	DB_Tariffe lobj_Tariffe = new DB_Tariffe();
    
    if(blnMascheraClassi){ // ho le classi di sconto associate
		//strCodeFascia = "";
		//strCodePrFascia = p_strCodePrFascia;
		strCodeClassSconto = "4";
		strCodePrClassSconto = Integer.toString(p_intNumRow);
	}else{
		/*if(p_strTipoImporto.equals("A")){//accesso
	        //strCodeFascia = "";
	        //strCodePrFascia = p_strCodePrFascia;
	        
	    }
		
	    if(p_strTipoImporto.equals("C")){//contributi
	        //strCodeFascia = "";
	        //strCodePrFascia = p_strCodePrFascia;
	       
	    }
		
	    if(p_strTipoImporto.equals("F")){//fasce
	        //strCodeFascia = "1";
	        //strCodePrFascia = p_strCodePrFascia;
	        
	    }
		if(p_strTipoImporto.equals("PA")){//porta ATM
	        //strCodeFascia = "1";
	        //strCodePrFascia = p_strCodePrFascia;
	        
	    }*/
		strCodeClassSconto = "";
	    strCodePrClassSconto = "";
	}
    lobj_Tariffe.setCODE_CLAS_SCONTO(strCodeClassSconto);
    lobj_Tariffe.setCODE_FASCIA(p_strCodeFascia);
	lobj_Tariffe.setCODE_PR_FASCIA(p_strCodePrFascia);
    lobj_Tariffe.setCODE_OGG_FATRZ(strCodeOggFatt);
	lobj_Tariffe.setCODE_PR_CLAS_SCONTO(strCodePrClassSconto);
    lobj_Tariffe.setCODE_TIPO_CAUS(strCodiciTipiCausali);
    lobj_Tariffe.setCODE_TIPO_OFF(strCodeTipoOfferta);
    lobj_Tariffe.setCODE_UNITA_MISURA(strCodeUnitaMisura);
    lobj_Tariffe.setCODE_TIPO_CONTR(strCodeTipoContratto);
	lobj_Tariffe.setCODE_PS(strCodePsCompFatt); //code ps figlio
	lobj_Tariffe.setCODE_PREST_AGG(strCodePrestAgg);
    lobj_Tariffe.setCODE_UTENTE(strCodeUtente);
    lobj_Tariffe.setDATA_INIZIO_TARIFFA(strDataInizioValidita);//!!!!
    
    lobj_Tariffe.setDESC_TARIFFA(strDescTariffa);

	System.out.println("IMPORTO: "+CustomNumberFormat.getFromNumberFormat(p_strImporto));
    lobj_Tariffe.setIMPT_TARIFFA(CustomNumberFormat.getFromNumberFormat(p_strImporto));
    
    lobj_Tariffe.setTIPO_FLAG_MODAL_APPL_TARIFFA(strCodeTipoImporto);
	
    return lobj_Tariffe;
}

//FUNZIONI PER INSERIMENTO TARIFFE
private String InsertTariffa(String pstrCODE_ACCOUNT_ESISTENTI, com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    	String lstr_Msg = "";
    	lstr_Msg = remoteCtr_Tariffe.insTariffaXTipoContr(pstrCODE_ACCOUNT_ESISTENTI, lvct_Tariffe);
    	return lstr_Msg;
	}
//FUNZIONI PER UPDATE TARIFFE
private String UpdateTariffa(com.ejbSTL.Ctr_Tariffe remoteCtr_Tariffe) throws Exception{
    String lstr_Msg = "";
	lstr_Msg = remoteCtr_Tariffe.updTariffaXTipoContr(lvct_Tariffe);
	return lstr_Msg;
}
%>

<%

    String lstr_Message = "";
	String strMsgOutput = "";
	//valorizza il vettore 
    inizializeTariffeVector(session,
                            request);
							
	  
	  if(strPageAction.equals("INS"))
	  {
		//CHK CONTRATTI Esistenti.
		if(!blnCHKCONTRATTI){
			lvct_ContrattiEsistenti = (Vector) remoteEnt_Contratti.getAccountEsistenti((DB_Tariffe)lvct_Tariffe.elementAt(0));
		}
		if(lvct_ContrattiEsistenti.size() > 0){
			lbln_Redirect = false;
		}else{
			lbln_Redirect = true;%>
			<%
			strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe); 
			strLogMessage = "remoteCtr_Tariffe.insTariffaXTipoContr(" + strCODE_ACCOUNT_ESISTENTI + ", " + strParameterToLog  + ")";
			intNumMessage = 3503;
			%>
			<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
					<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
			</logtag:logData>
		  	<%lstr_Message = InsertTariffa(strCODE_ACCOUNT_ESISTENTI,remoteCtr_Tariffe);
		}
	  }
	  if(strPageAction.equals("UPD"))
	  {
	  	lbln_Redirect = true;
	  	strTitoloPagina = "MODIFICA";%>
		<% strParameterToLog = Misc.buildParameterToLog(lvct_Tariffe);
		   strLogMessage = "remoteCtr_Tariffe.updTariffaXTipoContr(" + strParameterToLog  + ")";
		   intNumMessage = 3504;
		%>
		<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
				<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
		</logtag:logData>
	  	<%lstr_Message=UpdateTariffa(remoteCtr_Tariffe);
	  }
	  
	  if(lstr_Message.equals("")){
		strMsgOutput = "Elaborazione terminata correttamente!!";
		strLogMessage += ": Successo";
	  }else{
	  	strMsgOutput = lstr_Message;
		strLogMessage += ": " + lstr_Message;
	  }%>
	  <logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
			<%=StaticMessages.getMessage(intNumMessage,strLogMessage)%>
  	  </logtag:logData>
	<%
	String strUrl = request.getContextPath() + "/classic_common/jsp/genericMsg_cl.jsp?message=" + java.net.URLEncoder.encode(strMsgOutput,com.utl.StaticContext.ENCCharset)+"&CHIUDI=true"; 
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
					strURL = "cbn1_ins_tar_x_tipol_contr_cvp_3_cl.jsp";
					strURL +="?CHKCONTRATTI=true";
					objForm.action = strURL;
					objForm.submit();
				}
				function ONANNULLA(){
					/*strURL = "SwitchInserimentoXTipologia_cl.jsp";
					strURL += "?codiceTipoContratto=<%=strCodeTipoContratto%>";
					strURL += "&intAction=<%=StaticContext.INSERT%>";
					strURL += "&hidDescTipoContratto=<%=strDESCTIPOLOGIACONTRATTO%>";
					objForm.action = strURL;
					objForm.submit();*/
          window.close();
				}
			</script>
		</head>
		<BODY onload="initialize()">
			<form name="frmDati" method="post" action=''>
			<input type="hidden" name="hidViewState" value="<%=appoViewState%>">
			<%for(int z=1;(request.getParameter("txtContributi"+z)!=null);z++){%>
				<input type="hidden" name="txtContributi<%=z%>" value="<%=Misc.nh(request.getParameter("txtContributi"+z))%>">
				<input type="hidden" name="txtAccesso<%=z%>" value="<%=Misc.nh(request.getParameter("txtAccesso"+z))%>">
				<input type="hidden" name="txt0_60KM<%=z%>" value="<%=Misc.nh(request.getParameter("txt0_60KM"+z))%>">
				<input type="hidden" name="txt61_300KM<%=z%>" value="<%=Misc.nh(request.getParameter("txt61_300KM"+z))%>">
				<input type="hidden" name="txtOltre300KM<%=z%>" value="<%=Misc.nh(request.getParameter("txtOltre300KM"+z))%>">
				<input type="hidden" name="txtImportoPortaAtm<%=z%>" value="<%=Misc.nh(request.getParameter("txtImportoPortaAtm"+z))%>">
			<%}%>
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
							  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=strTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO <%=strDESCTIPOLOGIACONTRATTO%></td>
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
                                           <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Per i seguenti Account � gi� presente la Struttura Tariffaria</td>
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
						Annulla per Interrompere l'inserimento della struttura tariffaria.
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
