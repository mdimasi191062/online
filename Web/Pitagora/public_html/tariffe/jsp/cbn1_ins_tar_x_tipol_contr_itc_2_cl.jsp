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
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_tar_x_tipol_contr_itc_2_cl.jsp")%>
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
	String strCodePrestAgg = Misc.getParameterValue(strViewState,"vsCodePrestAgg");
	String strCodeOggFatt = Misc.getParameterValue(strViewState,"vsCodeOggFatt");

	//descrizioni
	String strDescTipoContratto = Misc.getParameterValue(strViewState,"vsDescTipoContratto");
	String strDescTipiCausali = Misc.getParameterValue(strViewState,"vsDescTipiCausali");
	String strDescPs = Misc.getParameterValue(strViewState,"vsDescPs");
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
	var strCodePsCompFatt = "";
	var strCodeOggFatt = "<%=strCodeOggFatt%>";
	var blnDebbug = false;

	function Initialize()
	{
		objForm = document.frmDati;
		//impostazione delle proprietà dei controlli
		setDefaultProp(objForm);

		setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=si");

		setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>"); 
		setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txtAccessoCanoneFriaco,"label=Accesso/Canone Friaco|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");

		setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");
		setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");

		setObjProp(objForm.txtDescrizioneTariffa, "label=Descrizione Tariffa|obbligatorio=si");
		setObjProp(objForm.txtDataInizioValidita, "label=Data Inizio Validità|tipocontrollo=data|obbligatorio=si");

		//disabilito tutti i controlli e abilito solo quelli necessari in base alle condizioni
		DisableAllControls(objForm);

    Enable(objForm.CHIUDI);

		Enable(objForm.ANNULLA);
		Enable(objForm.CONFERMA);
		Enable(objForm.txtDescrizioneTariffa);
		//Enable(objForm.txtDataInizioValidita);

		if((strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_INSTALLAZIONE%>")||(strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_INSTALLAZIONE_AMPL%>")){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Enable(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Disable(objForm.txtAccessoCanoneFriaco);
			setFocus(objForm.txtContributoFriaco);
			Disable(objForm.txt0_20KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt61_300KM);
			Disable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value=""
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txtAccessoCanoneFriaco,"label=Accesso/Canone Friaco|obbligatorio=no");
			setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=no");
			setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=no");
			setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=no");
			setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=no");
		}
		
		if((strCodeOggFatt == "50")||(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_ITC%>")||(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_AMPL_CANALI%>")){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributoFriaco);
			Enable(objForm.txtCanonePorta);
			setFocus(objForm.txtCanonePorta);
			Disable(objForm.txtAccessoCanoneFriaco);
			Disable(objForm.txt0_20KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="Chilometro (Km)";
			objForm.hidCodeUnitaMisura.value = "1";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=no"); 
			setObjProp(objForm.txtAccessoCanoneFriaco,"label=Accesso/Canone Friaco|obbligatorio=no");
			setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=no");
			setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=no");
			setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=no");
			setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=no");
		}
		if(strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_INSTALLAZIONE_TRASM%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			DisableRadio(objForm.rdoTipoImporto,true);
			Enable(objForm.txtContributoFriaco);
			setFocus(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Disable(objForm.txtAccessoCanoneFriaco);
			Disable(objForm.txt0_20KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt61_300KM);
			Disable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="";
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtAccessoCanoneFriaco,"obbligatorio=no");
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=si"); 
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=no");
			setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=no");
			setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=no");
			setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=no");
		}
		if(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_RACC_CENTRALE%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Enable(objForm.txtAccessoCanoneFriaco);
			setFocus(objForm.txtAccessoCanoneFriaco);
			Disable(objForm.txt0_20KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt61_300KM);
			Disable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="";
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=no"); 
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=no");
			setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=no");
			setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=no");
			setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=no");
		}
		if(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_TRASM_FISSO%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Disable(objForm.txtAccessoCanoneFriaco);
			Enable(objForm.txt0_20KM);
			Enable(objForm.txt21_60KM);
			Enable(objForm.txt61_300KM);
			Enable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="Chilometro (Km)";
			objForm.hidCodeUnitaMisura.value = "1";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=no"); 
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txtAccessoCanoneFriaco,"label=Accesso/Canone Friaco|obbligatorio=no");
		}
		if(strCodeOggFatt == "<%=StaticContext.OF_CANONE_MENSILE_TRASM_KM_FRAZIONE%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Disable(objForm.txtAccessoCanoneFriaco);
			Enable(objForm.txt0_20KM);
			Enable(objForm.txt21_60KM);
			Enable(objForm.txt61_300KM);
			Enable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="Chilometro (Km)";
			objForm.hidCodeUnitaMisura.value = "1";
			objForm.rdoTipoImporto[1].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=no"); 
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txtAccessoCanoneFriaco,"label=Accesso/Canone Friaco|obbligatorio=no");
		}
		if(strCodeOggFatt == "<%=StaticContext.OF_CONTRIBUTO_VARIAZIONE_SWAP%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Enable(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Disable(objForm.txtAccessoCanoneFriaco);
			Disable(objForm.txt0_20KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt61_300KM);
			Disable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="";
			objForm.hidCodeUnitaMisura.value = "";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txtAccessoCanoneFriaco,"label=Accesso/Canone Friaco|obbligatorio=no");
			setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=no");
			setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=no");
			setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=no");
			setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=no");
		}
		if(strCodeOggFatt == "<%=StaticContext.OF_CANONE_AGGIUNTIVO_FRIACO%>"){
			Disable(objForm.txtUnitaMisura);
			DisableRadio(objForm.rdoTipoImporto,true);
			Disable(objForm.txtContributoFriaco);
			Disable(objForm.txtCanonePorta);
			Enable(objForm.txtAccessoCanoneFriaco);
			Disable(objForm.txt0_20KM);
			Disable(objForm.txt21_60KM);
			Disable(objForm.txt61_300KM);
			Disable(objForm.txtOltre300KM);
			Enable(objForm.txtDescrizioneTariffa);
			objForm.txtUnitaMisura.value="";
			objForm.rdoTipoImporto[0].checked=true;
			objForm.txtContributoFriaco.value="";
			objForm.txtCanonePorta.value="";
			objForm.txtAccessoCanoneFriaco.value="";
			objForm.txt0_20KM.value="";
			objForm.txt21_60KM.value="";
			objForm.txt61_300KM.value="";
			objForm.txtOltre300KM.value="";
			objForm.txtDescrizioneTariffa.value="<%=strDescPs%> - <%=strDescOggFatt%>";
			objForm.txtDataInizioValidita.value="<%=DataFormat.getDate()%>";
			//disabilito i controlli sui campi che rimarranno vuoti
			setObjProp(objForm.txtUnitaMisura,"label=Unita di Misura|obbligatorio=no");
			setObjProp(objForm.txtContributoFriaco,"label=Contributo/Contributo Friaco|obbligatorio=no"); 
			setObjProp(objForm.txtCanonePorta,"label=Canone Porta|obbligatorio=no");
			setObjProp(objForm.txt0_20KM,"label=0_20Km|obbligatorio=no");
			setObjProp(objForm.txt21_60KM,"label=21_60Km|obbligatorio=no");
			setObjProp(objForm.txt61_300KM,"label=61_300Km|obbligatorio=no");
			setObjProp(objForm.txtOltre300KM,"label=Oltre300Km|obbligatorio=no");
		}
	}

  function ONCHIUDI()
  {
    window.close();
  }

	function ONANNULLA()
	{
		clearField(objForm.txtContributoFriaco);
		clearField(objForm.txtCanonePorta);
		clearField(objForm.txtAccessoCanoneFriaco);
		clearField(objForm.txt0_20KM);
		clearField(objForm.txt21_60KM);
		clearField(objForm.txt61_300KM);
		clearField(objForm.txtOltre300KM);
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
			
			updVS(objForm.hidViewState,"vsImporti",objForm.txt0_20KM.value + "$" + objForm.txt21_60KM.value + "$" + objForm.txt61_300KM.value + "$" + objForm.txtOltre300KM.value);
			updVS(objForm.hidViewState,"vsContributoFriaco",objForm.txtContributoFriaco.value);
			updVS(objForm.hidViewState,"vsCanonePorta",objForm.txtCanonePorta.value);
			updVS(objForm.hidViewState,"vsAccessoCanoneFriaco",objForm.txtAccessoCanoneFriaco.value);
			
			objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_ins_tar_x_tipol_contr_itc_3_cl.jsp";
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"><%=lstrTitoloPagina%> TARIFFA PER TIPOLOGIA DI CONTRATTO ITC</td>
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
    <td height="30" width="30%" class="textB" align="right">Prestazione Aggiuntiva:&nbsp;&nbsp;</td>
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

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
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

<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width="18%" valign="bottom" class="textB">Contributo/<br>Contributo Friaco</td>
		<td width="18%" valign="bottom" class="textB">Canone Porta</td>
		<td width="18%" valign="bottom" class="textB">Accesso/<br> Canone Friaco</td>
		<td width="18%">&nbsp;</td>
		<td width="28%">&nbsp;</td>
	</tr>
	<tr>
		<td width="18%" height="30" class="text">
			<input type="text" name="txtContributoFriaco" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txtCanonePorta" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txtAccessoCanoneFriaco" class="text" value = "" size="12">
		</td>
		<td width="18%">&nbsp;</td>
		<td width="28%">&nbsp;</td>
	</tr>
	<tr>
		<td width="18%" valign="bottom" class="textB">0-20 Km.</td>
		<td width="18%" valign="bottom" class="textB">21-60 Km.</td>
		<td width="18%" valign="bottom" class="textB">61-300 Km.</td>
		<td width="18%" valign="bottom" class="textB">Oltre 300 Km.</td>
		<td width="28%">&nbsp;</td>
	</tr>
	<tr>
		<td width="18%" class="text">
			<input type="text" name="txt0_20KM" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txt21_60KM" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txt61_300KM" class="text" value = "" size="12">
		</td>
		<td width="18%" class="text">
			<input type="text" name="txtOltre300KM" class="text" value = "" size="12">
		</td>
		<td width="28%">&nbsp;</td>
	</tr>
</table>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
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
