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
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_circ_parziali_2_cl.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto per il popolamento della lista-->
<EJB:useHome id="homeEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferteHome" location="Ent_TipiOfferte" />
<EJB:useBean id="remoteEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferte" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiOfferte.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEnt_ProdottiServizi" type="com.ejbSTL.Ent_ProdottiServiziHome" location="Ent_ProdottiServizi" />
<EJB:useBean id="remoteEnt_ProdottiServizi" type="com.ejbSTL.Ent_ProdottiServizi" scope="session">
    <EJB:createBean instance="<%=homeEnt_ProdottiServizi.create()%>" />
</EJB:useBean>

<%
	int i = 0;
	Vector vctTipiOfferta = null;

	String strOn = "obbligatorio=si|disabilitato=no";
	String strOff = "obbligatorio=no|disabilitato=si";

	String strFieldIndex1 = "1" ;
	String strFieldIndex2 = "2" ;
	String strFieldIndex3 = "3" ;

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

	// reperimento dei parametri dal viewState
	String strViewState = "";
	strViewState = Misc.nh(request.getParameter("hidViewState"));
	
	//codici
	String strCodeTipoContratto = Misc.getParameterValue(strViewState,"vsCodeTipoContratto");
	String strCodiciTipiCausali = Misc.getParameterValue(strViewState,"vsCodiciTipiCausali");
	String strCodePs = Misc.getParameterValue(strViewState,"vsCodePs");
	String strCodePsCompFatt = Misc.getParameterValue(strViewState,"vsCodePsCompFatt");
	String strCodePrestAgg = Misc.getParameterValue(strViewState,"vsCodePrestAgg");
	String strCodeOggFatt = Misc.getParameterValue(strViewState,"vsCodeOggFatt");
	String strCodeClassOggFatt = Misc.getParameterValue(strViewState,"vsCodeClassOggFatt");
	String strCodeClassOggPs = Misc.getParameterValue(strViewState,"vsCodeClassOggPs");
	
	//descrizioni
	String strDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
	String strDescTipiCausali = Misc.getParameterValue(strViewState,"vsDescTipiCausali");
	String strDescPs = Misc.getParameterValue(strViewState,"vsDescPs");
	String strDescPsCompFatt = Misc.getParameterValue(strViewState,"vsDescPsCompFatt");
	String strDescPrestAgg = Misc.getParameterValue(strViewState,"vsDescPrestAgg");
	String strDescOggFatt = Misc.getParameterValue(strViewState,"vsDescOggFatt");
	
	String lstrPageAction = Misc.getParameterValue(strViewState,"vsPageAction");
	String lstrTitoloPagina = "";
	if(lstrPageAction.equals("INS")){
		lstrTitoloPagina = "INSERIMENTO";
	}
	if(lstrPageAction.equals("DEL")){
		lstrTitoloPagina = "ELIMINAZIONE";
	}
	if(lstrPageAction.equals("UPD")){
		lstrTitoloPagina = "MODIFICA";
	}
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	
</TITLE>
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
    var strCodePs = "<%=strCodePs%>";
	var strCodePsCompFatt = "<%=strCodePsCompFatt%>";
	var strCodeOggFatt = "<%=strCodeOggFatt%>";
	var strCodeClassOggFatt = "<%=strCodeClassOggFatt%>";
	var blnDebbug = false;

	function Initialize()
	{
		objForm = document.frmDati;
		//impostazione delle proprietà dei controlli
		setDefaultProp(objForm);

		setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=si");

		setObjProp(objForm.txtContributo,"label=Contributo |obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>"); 
		setObjProp(objForm.txtAccesso,"label=Accesso |obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");

		<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
			setObjProp(objForm.txt1_Range,"label=Fino a 2 Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
			setObjProp(objForm.txt2_Range,"label=Da 2,1 Km a 5 Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		<%}else{%>
			setObjProp(objForm.txt2_Range,"label=Fino a 5 Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		<%}%>
		
		setObjProp(objForm.txt3_Range,"label=Da 5,1 Km a 15 Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txt4_Range,"label=Oltre 15,1 Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");

		setObjProp(objForm.txtDescrizioneTariffa, "label=Descrizione Tariffa|obbligatorio=si");
		setObjProp(objForm.txtDataInizioValidita, "label=Data Inizio Validità|tipocontrollo=data|obbligatorio=si");

		//disabilito tutti i controlli e abilito solo quelli necessari in base alle condizioni
		DisableAllControls(objForm);


    Enable(objForm.CHIUDI);
    

		Enable(objForm.ANNULLA);
		Enable(objForm.CONFERMA);
		Enable(objForm.txtDescrizioneTariffa);
		//Enable(objForm.txtDataInizioValidita);

		if(strCodeClassOggFatt == "<%=StaticContext.CL_CONTRIBUTO%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Enable(objForm.txtContributo);
			Disable(objForm.txtAccesso);
			setFocus(objForm.txtContributo);
			Disable(objForm.txt1_Range);
			Disable(objForm.txt2_Range);
			Disable(objForm.txt3_Range);
			Disable(objForm.txt4_Range);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value=""
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributo.value="";
			objForm.txtAccesso.value="";
			objForm.txt1_Range.value="";
			objForm.txt2_Range.value="";
			objForm.txt3_Range.value="";
			objForm.txt4_Range.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"obbligatorio=no");
			setObjProp(objForm.txtAccesso,"obbligatorio=no");
			setObjProp(objForm.txt1_Range,"obbligatorio=no");
			setObjProp(objForm.txt2_Range,"obbligatorio=no");
			setObjProp(objForm.txt3_Range,"obbligatorio=no");
			setObjProp(objForm.txt4_Range,"obbligatorio=no");
		}
		if(strCodeClassOggFatt == "<%=StaticContext.CL_CANONE%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributo);
			Enable(objForm.txtAccesso);
			setFocus(objForm.txtAccesso);
			Disable(objForm.txt1_Range);
			Disable(objForm.txt2_Range);
			Disable(objForm.txt3_Range);
			Disable(objForm.txt4_Range);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value=""
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributo.value="";
			objForm.txtAccesso.value="";
			objForm.txt1_Range.value="";
			objForm.txt2_Range.value="";
			objForm.txt3_Range.value="";
			objForm.txt4_Range.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"obbligatorio=no");
			setObjProp(objForm.txtContributo,"obbligatorio=no");
			setObjProp(objForm.txt1_Range,"obbligatorio=no");
			setObjProp(objForm.txt2_Range,"obbligatorio=no");
			setObjProp(objForm.txt3_Range,"obbligatorio=no");
			setObjProp(objForm.txt4_Range,"obbligatorio=no");
		}
   // inizio modifica

    
		if((strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE%>"))
    {
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributo);
			Disable(objForm.txtAccesso);
			Enable(objForm.txt1_Range);
			Enable(objForm.txt2_Range);
			Enable(objForm.txt3_Range);
			Enable(objForm.txt4_Range);
			<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
				setFocus(objForm.txt1_Range);
			<%}else{%>
				setFocus(objForm.txt2_Range);
			<%}%>
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value=""
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[1].checked=true;
			objForm.txtContributo.value="";
			objForm.txtAccesso.value="";
			objForm.txt1_Range.value="";
			objForm.txt2_Range.value="";
			objForm.txt3_Range.value="";
			objForm.txt4_Range.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"obbligatorio=no");
			setObjProp(objForm.txtContributo,"obbligatorio=no");
			setObjProp(objForm.txtAccesso,"obbligatorio=no");
			<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
				setObjProp(objForm.txt1_Range,"obbligatorio=si");
			<%}else{%>
				setObjProp(objForm.txt1_Range,"obbligatorio=no");
			<%}%>
			setObjProp(objForm.txt2_Range,"obbligatorio=si");
			setObjProp(objForm.txt3_Range,"obbligatorio=si");
			setObjProp(objForm.txt4_Range,"obbligatorio=si");
		}
	//}


    if((strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_TRASM_FISSO%>"))
    {
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributo);
			Disable(objForm.txtAccesso);
			Enable(objForm.txt1_Range);
			Enable(objForm.txt2_Range);
			Enable(objForm.txt3_Range);
			Enable(objForm.txt4_Range);
			<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
				setFocus(objForm.txt1_Range);
			<%}else{%>
				setFocus(objForm.txt2_Range);
			<%}%>
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value=""
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributo.value="";
			objForm.txtAccesso.value="";
			objForm.txt1_Range.value="";
			objForm.txt2_Range.value="";
			objForm.txt3_Range.value="";
			objForm.txt4_Range.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"obbligatorio=no");
			setObjProp(objForm.txtContributo,"obbligatorio=no");
			setObjProp(objForm.txtAccesso,"obbligatorio=no");
			<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
				setObjProp(objForm.txt1_Range,"obbligatorio=si");
			<%}else{%>
				setObjProp(objForm.txt1_Range,"obbligatorio=no");
			<%}%>
			setObjProp(objForm.txt2_Range,"obbligatorio=si");
			setObjProp(objForm.txt3_Range,"obbligatorio=si");
			setObjProp(objForm.txt4_Range,"obbligatorio=si");
		}
	}



//  MODIFICA DEL 4/5/2004
  function ONCHIUDI()
  {
    window.close();
  }
//  FINE MODIFICA

	function ONANNULLA()
	{
		clearField(objForm.txtContributo);
		clearField(objForm.txtAccesso);
		clearField(objForm.txt1_Range);
		clearField(objForm.txt2_Range);
		clearField(objForm.txt3_Range);
		clearField(objForm.txt4_Range);
		clearField(objForm.txtDescrizioneTariffa);
	}

	function ONCONFERMA()
	{
		if(validazioneCampi(objForm)){
			//completo il view state
			updVS(objForm.hidViewState,"vsCodeTipoImporto",getRadioButtonValue(objForm.rdoTipoImporto));
			updVS(objForm.hidViewState,"vsCodeUnitaMisura",objForm.hidCodeUnitaMisura.value);
			updVS(objForm.hidViewState,"vsDescrizioneTariffa",objForm.txtDescrizioneTariffa.value);
			updVS(objForm.hidViewState,"vsDataInizioValidita",objForm.txtDataInizioValidita.value);
			updVS(objForm.hidViewState,"vsImporti",objForm.txt1_Range.value + "$" + objForm.txt2_Range.value + "$" + objForm.txt3_Range.value + "$" + objForm.txt4_Range.value);
			updVS(objForm.hidViewState,"vsContributo",objForm.txtContributo.value);
			updVS(objForm.hidViewState,"vsAccessoCanone",objForm.txtAccesso.value);
			objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_circ_parziali_3_cl.jsp";
			EnableAllControls(objForm);
			objForm.submit();
		}
	}

</SCRIPT>
</HEAD>
<BODY onload="Initialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="hidCodeUnitaMisura" value="">
	<input type="hidden" name="hidViewState" size = "200" value="<%=request.getParameter("hidViewState")%>">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=lstrTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO CIRCUITI PARZIALI</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<br>
<!-- dati di riepilogo -->
<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Oggetto di Fatturazione</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	<td height="30" width='30%' class="textB" align="right">Tipologia Contratto:&nbsp;&nbsp;</td>
	<td height="30" width='70%' class="text">
		<%=strDescTipoContratto%>
	</td>
</tr>
<tr>
    <td height="30" width="30%"class="textB" align="right">Prodotto/Servizio:&nbsp;&nbsp;</td>
    <td height="30" width="70%" colspan="3" class="text">
		<%=strDescPs%>
	</td>
</tr>
<tr>
    <td height="30" width="30%"class="textB" align="right">P/S Componenti&nbsp;&nbsp;<BR>di Fatturazione:&nbsp;&nbsp;</td>
    <td height="30" width="70%" colspan="3" class="text">
		<%=strDescPsCompFatt%>
	</td>
</tr>
<tr>
    <td height="30" width="30%" class="textB" align="right">Prest.Aggiuntiva:&nbsp;&nbsp;</td>
	<td height="30" width="70%" class="text">
		<%=strDescPrestAgg%>
	</td>
</tr>
<tr>
	<td height="30" width="30%" class="textB" align="right">Tipo Causale:&nbsp;&nbsp;</td>
	<td height="30" width="70%" nowrap class="text">
		 <%=strDescTipiCausali%>
	</td>
</tr>
<tr>
    <td height="30" width="30%" class="textB" align="right">Oggetto di Fatturazione:&nbsp;&nbsp;</td>
	<td height="30" width="70%" class="text">
		<%=strDescOggFatt%>
	</td>
</tr>
</table>
<!-- fine dati di riepilogo-->

<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Tariffa</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="2" cellpadding="2" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="40" width="15%" class="textB">Unità di misura</td>
		<td height="40" width="35%">
			<input type="text" name="txtUnitaMisura" class="text" value = "" size="20" maxlength="20">
		</td>
		<td height="40" width="15%" class="textB">Tipo Importo</td>
		<td height="40" width="35%" class="textB" nowrap>
			<input class="text" checked type="radio" name="rdoTipoImporto" value="F">Fisso
			<input class="text"  type="radio" name="rdoTipoImporto" value="V">Variabile
			<input class="text"  type="radio" name="rdoTipoImporto" value="A">Scaglioni
		</td>
	</tr>
</table>

<table align='center' width="80%" border="0" cellspacing="2" cellpadding="2" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width="18%" valign="bottom" class="textB">Contributo </td>
		<td width="18%" valign="bottom" class="textB">Accesso</td>
		<td width="18%">&nbsp;</td>
		<td width="50%">&nbsp;</td>
	</tr>
	<tr>
		<td width="18%" height="30" class="text">
			<input type="text" name="txtContributo" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txtAccesso" class="text" value = "" size="12">
		</td>
		<td width="18%">&nbsp;</td>
		<td width="50%">&nbsp;</td>
	</tr>
	<tr>
		<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
			<td width="18%" valign="bottom" class="textB">Fino a 2 Km</td>
			<td width="18%" valign="bottom" class="textB">Da 2,1 Km a 5 Km</td>
		<%}else{%>
			<td width="18%" valign="bottom" class="textB">Fino a 5 Km</td>
		<%}%>
		<td width="18%" valign="bottom" class="textB">Da 5,1 Km a 15 Km</td>
		<td width="18%" valign="bottom" class="textB">Oltre 15,1 Km</td>
		<td width="50%">&nbsp;</td>
	</tr>
	<tr>
		<%if(strCodePs.equalsIgnoreCase(StaticContext.PS_34_MBITS)){%>
			<td width="18%" class="text">
				<input type="text" name="txt1_Range" class="text" value = "" size="12">
			</td>
		<%}else{%>
			<input type="hidden" name="txt1_Range" class="text" value = "" size="12">
		<%}%>
		<td width="18%" class="text">
			<input type="text" name="txt2_Range" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txt3_Range" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txt4_Range" class="text" value = "" size="12">
		</td>
		<td width="50%">&nbsp;</td>
	</tr>
</table>
<table align='center' width="80%" border="0" cellspacing="2" cellpadding="2" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td height="30" width="50%" valign="bottom" class="textB">Descrizione Tariffa</td>
		<td height="30" width="50%" valign="bottom" class="textB">Data Inizio Validità</td>
	</tr>
	<tr>
		<td height="30" width="50%"><input type="text" name="txtDescrizioneTariffa" class="text" value = "" size="45"></td>
		<td height="30" width="50%" nowrap><input type="text" name="txtDataInizioValidita" class="text" value = "" size="12">
			<a href="javascript:showCalendar('frmDati.txtDataInizioValidita','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
			<a href="javascript:clearField(objForm.txtDataInizioValidita);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
		</td>
	</tr>
</table>

 <!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
		</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	  <tr>
	    <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="left">&nbsp;&nbsp;
	    	<sec:ShowButtons td_class="textB"/>
		</td>
	  </tr>
	</table>
</form>

</BODY>
</HTML>
