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
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*,java.lang.reflect.Array"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_modifica_tariffe_cl.jsp")%>
</logtag:logData>
<%!
    //costante che indica se l'oggetto fatturazione è canone
	private static final String constStrIsCanone = "2";
%>

<!-- instanziazione degli oggetti remoti-->
<EJB:useHome id="homeEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggiHome" location="Ent_AnagraficaMessaggi" />
<EJB:useBean id="remoteEnt_AnagraficaMessaggi" type="com.ejbSTL.Ent_AnagraficaMessaggi" scope="session">
    <EJB:createBean instance="<%=homeEnt_AnagraficaMessaggi.create()%>" />
</EJB:useBean>
<!-- instanziazione dell'oggetto remoto per i Tipi di Offerte-->
<EJB:useHome id="homeEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferteHome" location="Ent_TipiOfferte" />
<EJB:useBean id="remoteEnt_TipiOfferte" type="com.ejbSTL.Ent_TipiOfferte" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiOfferte.create()%>" />
</EJB:useBean>

<!-- instanziazione dell'oggetto remoto per le Unità di Misura-->
<EJB:useHome id="homeEnt_UnitaMisura" type="com.ejbSTL.Ent_UnitaMisuraHome" location="Ent_UnitaMisura" />
<EJB:useBean id="remoteEnt_UnitaMisura" type="com.ejbSTL.Ent_UnitaMisura" scope="session">
    <EJB:createBean instance="<%=homeEnt_UnitaMisura.create()%>" />
</EJB:useBean>

<!-- instanziazione dell'oggetto remoto per le Classi di sconto-->
<EJB:useHome id="homeEnt_ClassiSconto" type="com.ejbSTL.Ent_ClassiScontoHome" location="Ent_ClassiSconto" />
<EJB:useBean id="remoteEnt_ClassiSconto" type="com.ejbSTL.Ent_ClassiSconto" scope="session">
    <EJB:createBean instance="<%=homeEnt_ClassiSconto.create()%>" />
</EJB:useBean>

<!-- instanziazione dell'oggetto remoto per le fasce-->
<EJB:useHome id="homeEnt_Fasce" type="com.ejbSTL.Ent_FasceHome" location="Ent_Fasce" />
<EJB:useBean id="remoteEnt_Fasce" type="com.ejbSTL.Ent_Fasce" scope="session">
    <EJB:createBean instance="<%=homeEnt_Fasce.create()%>" />
</EJB:useBean>

<!-- instanziazione dell'oggetto remoto per le Tariffe(modifica ed eliminazione)-->
<EJB:useHome id="homeEnt_Tariffe" type="com.ejbSTL.Ent_TariffeHome" location="Ent_Tariffe" />
<EJB:useBean id="remoteEnt_Tariffe" type="com.ejbSTL.Ent_Tariffe" scope="session">
    <EJB:createBean instance="<%=homeEnt_Tariffe.create()%>" />
</EJB:useBean>

<%  
//dichiarazione variabili
int i=0;
String bgcolor = "";
Vector vctTipoOfferta = null;
Vector vctUnitaMisura = null;
Vector vctClassiSconto = null;
Vector vctCodiciFascia = null;
String strSelected = "";
String strChecked = "";
DB_Tariffe objTariffa = null;   
// recupero i parametri provanienti dalla pagina di ricerca
String strCodiceTipoContratto = Misc.nh(request.getParameter("codiceTipoContratto"));
String strCodeContr = Misc.nh(request.getParameter("cboContratto"));
String strCodePrestAgg = Misc.nh(request.getParameter("cboPrestAgg"));
String strCodePs = Misc.nh(request.getParameter("PsSel"));
String strCodeOggFatGlobal = Misc.nh(request.getParameter("cboOggFat"));
String strTipoTariffa = Misc.nh(request.getParameter("campoTipoTariffa"));
String strDataCreazioneTariffa = Misc.nh(request.getParameter("DataCreazioneTariffa"));
String strPageAction = Misc.nh(request.getParameter("txtAction"));
//estrazione codice dell'oggetto fatturazione
String strCodeOggFat="";
String strCodeClassOggFat="";
Vector vctDettaglioTariffa = null;

String strArrayRadio[][]={{"F","FISSO"},
						  {"V","VARIABILE"},
						  {"A","SCAGLIONI"}}; 
						  
//RICEZIONE DESCRIZIONI DAL VIEWSTATE
String strViewState = Misc.nh(request.getParameter("viewState"));
String strDescTipoContratto=Misc.getParameterValue(strViewState,"vsDescTipoContratto");
String strDescCliente=Misc.getParameterValue(strViewState,"vsDescCliente");
String strDescContratto=Misc.getParameterValue(strViewState,"vsDescContratto");
String strDescPS=Misc.getParameterValue(strViewState,"vsDescPS");
String strDescPrestAgg=Misc.getParameterValue(strViewState,"vsDescPrestAgg");
String strDescOggFatt=Misc.getParameterValue(strViewState,"vsDescOggFatt");
String strDescTipoCaus=Misc.getParameterValue(strViewState,"vsDescTipoCaus");
//FINE RICEZIONE DESCRIZIONI DAL VIEWSTATE	
						  
//estrazione dei codici provenienti dalla combo dell'oggetto fatturazione

if(!strCodeOggFatGlobal.equals(""))
{
	Vector vctOggFatt = Misc.split(strCodeOggFatGlobal,"$");
	strCodeOggFat = (String)vctOggFatt.elementAt(0);
	strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
}
if(request.getParameter("txtCodeClassOggFat")!=null)
{
	strCodeClassOggFat = request.getParameter("txtCodeClassOggFat");
}
//estrazione codice del Tipo Causale					
String strCodeTipoCaus = Misc.nh(request.getParameter("cboTipoCaus"));
String strCODE_PR_PS_PA_CONTR="";
String strDATA_INIZIO_VALID_OF="";
String strDATA_INIZIO_VALID_OF_PS="";

vctDettaglioTariffa = remoteEnt_Tariffe.getDettaglioTariffa(StaticContext.UPDATE, strTipoTariffa, strDataCreazioneTariffa);

%>
<%if(vctDettaglioTariffa != null && vctDettaglioTariffa.size() > 0 ){
	objTariffa = (DB_Tariffe)vctDettaglioTariffa.elementAt(0);
}%>
<HTML>
<HEAD>
    <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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

    //modifiche fabio del 27-04-2004 - inizio
		function ONCHIUDI()
		{
      window.close();
		}
    //modifiche fabio del 27-04-2004 - fine

        function ONELIMINA()
        {
				<%if(!objTariffa.getTIPO_FLAG_PROVVISORIA().equalsIgnoreCase("N")){%>
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"3531")%>");
					return;
				<%}else{%>
					var blnReturn = true;//se esistono sconti associati scatta il messaggio!
					<%if(!objTariffa.getTARIFFA_SCONTO().equals("")){%>
						blnReturn = window.confirm(("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"CCB420033")%>"));
					<%}%>
					if(blnReturn){ 
		                objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_lista_tariffe_2_cl.jsp";
		                objForm.txtOperazione.value = "<%=StaticContext.DELETE%>";
						EnableAllControls(objForm);
		                objForm.submit();
					}
				<%}%>
        }
        function ONAGGIORNA()
        {
            if(validazioneCampi(objForm))
            {
				/*
					Se la Data Of >= Data OF/PS e la Data inizio validità tariffa impostata < Data Of, allora deve comparire il messaggio 'CCB420029'
					‘La data inizio validità tariffa deve essere maggiore della data inizio validità dell’Oggetto di fatturazione’
					Il cursore si posiziona sul campo Data Inizio Validità.
					Se la Data Of < Data OF/PS e la Data inizio validità tariffa impostata nella maschera < Data OF/PS, allora deve comparire il messaggio 'CCB420030':
					‘La data inizio validità tariffa deve essere maggiore della data inizio validità dell’OF/PS’
					Il cursore si posiziona sul campo Data Inizio Validità.

				*/
				//controlli specifici della funzionalità
				if(dateToInt(objForm.DATA_INIZIO_VALID_OF.value) >= dateToInt(objForm.DATA_INIZIO_VALID_OF_PS.value) 
				&& dateToInt(objForm.txtDataInizioValidita.value) < dateToInt(objForm.DATA_INIZIO_VALID_OF.value)){
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"CCB420029")%>");
					return;
				}
				
				if(dateToInt(objForm.DATA_INIZIO_VALID_OF.value) < dateToInt(objForm.DATA_INIZIO_VALID_OF_PS.value) 
				&& dateToInt(objForm.txtDataInizioValidita.value) < dateToInt(objForm.DATA_INIZIO_VALID_OF_PS.value)){
					alert("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"CCB420030")%>");
					return;
				}
				
				var blnReturn = true;//se esistono sconti associati scatta il messaggio!
				<%if(!objTariffa.getTARIFFA_SCONTO().equals("")){%>
					blnReturn = window.confirm(("<%=remoteEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.LIST,"CCB420033")%>"));
				<%}%>
				
				if(blnReturn && checkContinua())
				{
	                objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_lista_tariffe_2_cl.jsp";
	                objForm.txtOperazione.value = "<%=StaticContext.UPDATE%>";
					EnableAllControls(objForm);
	                objForm.submit();
				}
            }
        }
        
        function change_cboCodFascia()
        {
			EnableAllControls(objForm);
            objForm.submit();
        }
        
        function change_cboClassiSconto()
        {
			EnableAllControls(objForm);
           objForm.submit();
        }
        function initialize()
        {
          objForm = document.frmDati;

          //impostazione delle proprietà di default per tutti gli oggetti della form
          setDefaultProp(objForm);

          //disabilitazione del campo data
          Disable(objForm.txtDataInizioValidita);

          // impostazione delle proprietà degli elementi di input per la validazione dei campi
          setObjProp(objForm.txtDataInizioValidita, "label=Data Inizio Validità|tipocontrollo=data|obbligatorio=si");
          setObjProp(objForm.txtDescrizioneTariffa, "label=Descrizione Tariffa|obbligatorio=si");

          //in questa fase vengono generati i controlli lato client per i campi importo associati alle fasce
          <%if(vctDettaglioTariffa != null && vctDettaglioTariffa.size() > 1 ){
              // se il vettore è stato caricato si prosegue con il caricamento della lista
              for(i=0;i < vctDettaglioTariffa.size();i++){
                objTariffa = (DB_Tariffe)vctDettaglioTariffa.elementAt(i);%>
          //lato client
          setObjProp(objForm.txtImporto<%=i+1%>,"label=Importo|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");  
              <%}
          }else{%>
              <%objTariffa = (DB_Tariffe)vctDettaglioTariffa.elementAt(0);%>
          setObjProp(objForm.txtImporto1,"label=Importo|obbligatorio=si|tipocontrollo=importo|maxnumericvalue=999999999999,999999|maschera=<%=StaticContext.nfInputMask%>");  
          <%}%>

          <%
          //Memorizzazione Date provenienti dal DB DettaglioTariffa
          strDATA_INIZIO_VALID_OF = objTariffa.getDATA_INIZIO_VALID_OF();
          strDATA_INIZIO_VALID_OF_PS = objTariffa.getDATA_INIZIO_VALID_OF_PS();
          strCODE_PR_PS_PA_CONTR = objTariffa.getCODE_PR_PS_PA_CONTR();
          %>

          <%if(strPageAction.equalsIgnoreCase("UPD")){%>
          //caso di visualizzazione vengono disabilitati solo alcuni controlli
					Disable(objForm.cboUnitaMisura);
					Disable(objForm.cboCodFascia);
          Disable(objForm.cboTipoOfferta);
          Disable(objForm.cboClassiSconto);
          Disable(objForm.rdoTipoImporto[0]);
          Disable(objForm.rdoTipoImporto[1]);
          Disable(objForm.rdoTipoImporto[2]);
          <%}else{%>
          //caso di visualizzazione vengono disabilitati tutti i controlli
					DisableAllControls(objForm);

          //modifiche fabio del 27-04-2004 - inizio
          Enable(objForm.CHIUDI);
          //modifiche fabio del 27-04-2004 - fine
          <%}%>
        }
       
    </SCRIPT>
</HEAD>
<BODY onload = "initialize()">

<form name="frmDati" method="post" action='<%=StaticContext.PH_TARIFFE_JSP%>cbn1_modifica_tariffe_cl.jsp'>
    <!-- campi hidden per il passaggio dei valori quando viene richiesto il dettaglio -->
	<input type = "hidden" name = "codiceTipoContratto" value = "<%= strCodiceTipoContratto %>">
    <input type = "hidden" name = "cboContratto" value = "<%= strCodeContr %>">
    <input type = "hidden" name = "cboPrestAgg" value = "<%= strCodePrestAgg %>">
    <input type = "hidden" name = "PsSel" value = "<%= strCodePs %>">
	<input type = "hidden" name = "cboOggFat" value = "<%= strCodeOggFatGlobal %>">
	<input type = "hidden" name = "txtCodeClassOggFat" value = "<%= strCodeClassOggFat %>">
    <input type = "hidden" name = "cboTipoCaus" value = "<%= strCodeTipoCaus %>">
    <input type = "hidden" name = "CODE_PR_PS_PA_CONTR" value = "<%= strCODE_PR_PS_PA_CONTR%>">
    <input type = "hidden" name = "DATA_INIZIO_VALID_OF" value = "<%= strDATA_INIZIO_VALID_OF%>">
    <input type = "hidden" name = "DATA_INIZIO_VALID_OF_PS" value = "<%= strDATA_INIZIO_VALID_OF_PS%>">
    <!--  campo hidden per il tipo operazione -->
    <input type = "hidden" name = "txtOperazione" value = "">
    <!-- campi per la modifica-->
	<input type = "hidden" name = "campoTipoTariffa" value = "<%=objTariffa.getCODE_TARIFFA()%>">
    <input type = "hidden" name = "DataCreazioneTariffa" value = "<%=objTariffa.getDATA_CREAZ_TARIFFA()%>">
	<input type = "hidden" name = "hidDataInizioValiditaOld" value = "<%= objTariffa.getDATA_INIZIO_TARIFFA() %>">
	<input type = "hidden" name = "hidData_Fine_Tariffa" value = "<%= objTariffa.getDATA_FINE_TARIFFA() %>">
	<input type = "hidden" name = "hidFlag_Cong_Repr" value = "<%= objTariffa.getTIPO_FLAG_CONG_REPR() %>">
	<input type = "hidden" name = "hidData_Creaz_Tariffa" value = "<%= objTariffa.getDATA_CREAZ_TARIFFA() %>">
	<input type = "hidden" name = "hidTipo_Flag_Provvisoria" value = "<%= objTariffa.getTIPO_FLAG_PROVVISORIA() %>">
	<input type = "hidden" name = "hidData_Creaz_Modifica" value = "<%= objTariffa.getDATA_CREAZ_MODIF() %>">
	<input type = "hidden" name = "viewState" value="<%=strViewState%>">
	<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
	  <tr>
	</table>
	
	<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td>
	      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
					<tr>
						<td>
						  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
							<tr>
							  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Tariffe</td>
							  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
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
	      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	      <tr>
	        <td  width='15%' class="textB" align="right">Cliente:&nbsp;</td>
	        <td  width='35%' class="text">
	         	<%=strDescCliente%>
	        </td>
	        <td  width='20%'class="textB" align="right">Contratto:&nbsp;</td>
	        <td  width='30%'class="text">
	          <%=strDescContratto%>
	        </td>
	      </tr>
	      <tr>
	        <td class="textB" align="right">P/S:&nbsp;</td>
	        <td class="text">
	          <%=strDescPS%>
	        </td>
	        <td class="textB" align="right">Prest. Agg.:&nbsp;</td>
	        <td class="text">
	           <%=strDescPrestAgg%>
	        </td>
	      </tr>
	      <tr>
	        <td class="textB" align="right">Ogg. Fat.:&nbsp;</td>
	        <td class="text">
	         <%=strDescOggFatt%>
	        </td>
	        <td class="textB" align="right">Tipo Causale:&nbsp;</td>
	        <td class="text">
	           <%=strDescTipoCaus%>
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
				  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
				  	<%if(strPageAction.equalsIgnoreCase("UPD")){%>
						Modifica
					<%}else{%>
						Visualizzazione
					<%}%>
				  </td>
				  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
				</tr>
			  </table>
			</td>
		</tr>
     </table>
    <!-- tabella principale -->
    <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <!-- prima riga -->
        <tr>
            <td>
                <table width="100%" border="0">
                    <tr>
                        <td class="textB" align="left">Tipo Offerta:</td>
                        <td class="text" align = "left" valign = "top">
                            <select class="text" name="cboTipoOfferta">
                                <option class="text"  value="">[Seleziona Opzione]</option> 
                              <%
							  //invoca il metodo per reperire la lista delle offerte
							  vctTipoOfferta = null;
    						  vctTipoOfferta = remoteEnt_TipiOfferte.getTipiOfferte(StaticContext.INSERT);                                               
                              // se il vettore è stato caricato si prosegue con il caricamento della lista
                              if (vctTipoOfferta!=null)
                                {
                                  for(Enumeration e = vctTipoOfferta.elements();e.hasMoreElements();)
                                    {
                                      DB_TipiOfferte lobj_TipiOfferte = new DB_TipiOfferte();
                                      lobj_TipiOfferte = (DB_TipiOfferte)e.nextElement();
									  if(request.getParameter("cboTipoOfferta") != null){
                                          //setta l'ultima opziona selezionata
                                          if(request.getParameter("cboTipoOfferta").equalsIgnoreCase(lobj_TipiOfferte.getCODE_TIPO_OFF())){
                                            strSelected = "selected";
                                          }
                                          else{
                                            strSelected = "";
                                          }
                                      }else{
                                        //setta l'opzione in base alla tariffa da modificare
                                          if(objTariffa.getCODE_TIPO_OFF().equalsIgnoreCase(lobj_TipiOfferte.getCODE_TIPO_OFF())){
                                            strSelected = "selected";
                                          }
                                          else{
                                            strSelected = "";
                                          }
                                      }
                                      %>
                                        <option class="text" <%=strSelected %> value="<%=lobj_TipiOfferte.getCODE_TIPO_OFF()%>"><%=lobj_TipiOfferte.getDESC_TIPO_OFF()%></option>
                                  <%}
                                }%>
                            </select>
                        </td>
                        <td class="textB" align="right">Unita' di misura:</td>
                        <td class="text" align = "left" valign = "top">
                            <select class="text" name="cboUnitaMisura">
                                <option class="text"  value="">[Seleziona Opzione]</option> 
                              <%
							  //invoca il metodo per reperire la lista delle unità di misura
							  vctUnitaMisura = null;
    						  vctUnitaMisura = remoteEnt_UnitaMisura.getUnitaMisura(StaticContext.INSERT);                                               
                              // se il vettore è stato caricato si prosegue con il caricamento della lista
                              if (vctUnitaMisura!=null)
                                {
                                  for(Enumeration e = vctUnitaMisura.elements();e.hasMoreElements();){
                                      DB_UnitaMisura lobj_UnitaMisura = new DB_UnitaMisura();
                                      lobj_UnitaMisura = (DB_UnitaMisura)e.nextElement();
									  if(request.getParameter("cboUnitaMisura") != null){
                                          if(request.getParameter("cboUnitaMisura").equalsIgnoreCase(lobj_UnitaMisura.getCODE_UNITA_MISURA()))
                                                strSelected = "selected";
                                          else
                                                strSelected = "";
                                      }else{
                                           if(objTariffa.getCODE_UNITA_MISURA().equalsIgnoreCase(lobj_UnitaMisura.getCODE_UNITA_MISURA()))
                                                strSelected = "selected";
                                           else
                                                strSelected = "";
                                      }
									  %>
                                        <option class="text" <%= strSelected %> value="<%=lobj_UnitaMisura.getCODE_UNITA_MISURA()%>"><%=lobj_UnitaMisura.getDESC_UNITA_MISURA()%></option>
                                  <%}
                                }%>
                            </select>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!--seconda riga -->
        <tr>
            <td>
                <table width="100%" border="0">
                    <tr>
                        <td class="textB" align = "left">Tipo importo:</td>
                        <td class="text" align = "left">
							  <!-- crea i radio button  -->
							  <%for(i=0;i <  Array.getLength(strArrayRadio);i++){
								  if(request.getParameter("rdoTipoImporto") != null){
                                       if(request.getParameter("rdoTipoImporto").equals(strArrayRadio[i][0])) 
                                             strChecked = "checked"; 
                                       else	
                                             strChecked = "";
								  }else{
										if(objTariffa.getTIPO_FLAG_MODAL_APPL_TARIFFA().equals(strArrayRadio[i][0])) 
                                            strChecked = "checked"; 
                                        else 
                                            strChecked = "";
								  }
                               %>
								   <input class="text" type="radio"  name="rdoTipoImporto" <%=strChecked%> value="<%= strArrayRadio[i][0]%>"><%= strArrayRadio[i][1]%>
							  <%}%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!-- terza riga -->
        <tr>
            <td>
                <table width="100%" border="0">
                    <tr>
                        <td width="40%" align = "left" valign="top">
                             <!-- classi di sconto -->
							 <table width="100%" cellspacing="0">
								<tr>
									<td class="textB">Codice classe di sconto:</td>
								</tr>
								<tr>
									<td class="text">
										<select style="width:250;" class="text" name="cboClassiSconto" onchange="change_cboClassiSconto()" >
		                                  <option value="">[Seleziona Opzione]</option>   
		                                  <%  
									  //invoca il metodo per reperire la lista delle classi di sconto
									  	  vctClassiSconto = null;
		  								  vctClassiSconto = remoteEnt_ClassiSconto.getClassiSconto(StaticContext.INSERT);                                             
		                                    // se il vettore è stato caricato si prosegue con il caricamento della lista
		                                    if (vctClassiSconto!=null)
		                                      {
		                                        for(i =0; i < vctClassiSconto.size(); i++)
		                                          {
		                                            DB_ClasseSconto lobj_ClassiSconto = new DB_ClasseSconto();
		                                            lobj_ClassiSconto = (DB_ClasseSconto)vctClassiSconto.elementAt(i);
		                                            if(request.getParameter("cboClassiSconto") != null)
		                                            {
		                                                if(request.getParameter("cboClassiSconto").equalsIgnoreCase(lobj_ClassiSconto.getCODE_CLAS_SCONTO()))
		                                                {
		                                                  strSelected = "selected";
		                                                }
		                                                else
		                                                {
		                                                  strSelected = "";
		                                                }
		                                            }else{
                                                        if(objTariffa.getCODE_CLAS_SCONTO().equalsIgnoreCase(lobj_ClassiSconto.getCODE_CLAS_SCONTO()))
		                                                {
		                                                  strSelected = "selected";
		                                                }
		                                                else
		                                                {
		                                                  strSelected = "";
		                                                }
                                                    }
		                                           %>
		                                            <option class="text" <%= strSelected %> value="<%=lobj_ClassiSconto.getCODE_CLAS_SCONTO()%>"><%= lobj_ClassiSconto.getCODE_CLAS_SCONTO()%></option>  
		                                        <%}
		                                      }%>
		                              </select>
									</td>
								</tr>
							</table>
                        </td>
                        <td width="60%" align="right" valign = "top">
                            <!-- tabella delle classi di sconto -->
                            <table width="100%" cellspacing="1">
                                <!-- intestazione -->
                                <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                                    <td width="47%" height="20" class="textB">Minimo classe sconto</td>
                                    <td width="47%" height="20" class="textB">Massimo classe sconto</td>
                                    <td width="6%" height="20" class="textB">&nbsp;</td>
                                </tr>
                                <tr bgcolor="<%=bgcolor%>">
                                    <td width="47%" class="textNumber"><%= CustomNumberFormat.setToNumberFormat(objTariffa.getIMPT_MIN_SPESA())%></td>
                                    <td width="47%" class="textNumber"><%= CustomNumberFormat.setToNumberFormat(objTariffa.getIMPT_MAX_SPESA())%></td>
                                    <td width="47%" class="textNumber">&nbsp;
                                        <input type = "hidden" name = "rdoClasse" value = "<%=objTariffa.getCODE_PR_CLAS_SCONTO()%>">
                                    </td>
                                 </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
         <!-- quarta riga -->
         <tr>
            <td>
                <table width="100%" border="0">
                    <tr>
                        <td  width="40%" align = "left" valign="top">
						<table width="100%" cellspacing="0">
							<tr>
								<td class="textB">Codice Fascia:</td>
							</tr>
							<tr>
								<td class="text">
									<select style="width:250;" class="text" name="cboCodFascia" onchange="change_cboCodFascia()">
		                                <option value="">[Seleziona Opzione]</option>  
		                                <%                                               
		                                  // se il vettore è stato caricato si prosegue con il caricamento della lista
										  //invoca il metodo per reperire la lista dei codici fascia
										  vctCodiciFascia = null;
		    							  vctCodiciFascia = remoteEnt_Fasce.getFasce(StaticContext.INSERT);
		                                  if (vctCodiciFascia!=null)
		                                    {
		                                      for(i =0; i < vctCodiciFascia.size(); i++)
		                                        {
		                                          DB_Fascia lobj_Fascia = new DB_Fascia();
		                                          lobj_Fascia = (DB_Fascia)vctCodiciFascia.elementAt(i);
		                                          if(request.getParameter("cboCodFascia") != null)
		                                          {
		                                                  if(request.getParameter("cboCodFascia").equalsIgnoreCase(lobj_Fascia.getCODE_FASCIA()))
		                                                  {
		                                                    strSelected = "selected";
		                                                  }
		                                                  else
		                                                  {
		                                                    strSelected = "";
		                                                  }
		                                          }else{
                                                        if(objTariffa.getCODE_FASCIA().equalsIgnoreCase(lobj_Fascia.getCODE_FASCIA()))
		                                                  {
		                                                    strSelected = "selected";
		                                                  }
		                                                  else
		                                                  {
		                                                    strSelected = "";
		                                                  }
                                                  }
                                                  
		                                          %>
		                                            <option class="text" <%= strSelected %> value="<%=lobj_Fascia.getCODE_FASCIA()%>"><%=lobj_Fascia.getCODE_FASCIA()%></option>
		                                      <%}
		                                    }%>
		                            </select>
								</td>
							</tr>
						</table>

                        </td>
                        <td  width="60%" align = "right" valign = "top">
                             <!-- tabella delle fasce -->
                            <table width="100%" cellspacing="1">
                                <!-- intestazione -->
                                <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                                    <td width="33%" height="20" class="textB">Minimo Fascia</td>
                                    <td width="33%" height="20" class="textB">Massimo Fascia</td>
                                    <td width="34%" height="20" class="textB">Importo</td>
                                </tr>
                                <!-- ciclo -->
                                <%
    
                                   if(vctDettaglioTariffa != null && vctDettaglioTariffa.size() > 1 ){
                                       for(i=0;i < vctDettaglioTariffa.size();i++){
                                            objTariffa = (DB_Tariffe)vctDettaglioTariffa.elementAt(i);
                                            //cambia il colore delle righe
                                             if ((i%2)==0)
                                               bgcolor=StaticContext.bgColorRigaPariTabella;
                                             else
                                               bgcolor=StaticContext.bgColorRigaDispariTabella;
                                            %>
                                            <tr>
                                              
                                               <td width="33%" class="textNumber" bgcolor="<%=bgcolor%>"><%= CustomNumberFormat.setToNumberFormat(objTariffa.getVALO_LIM_MIN())%></td>
                                               <td width="33%" class="textNumber" bgcolor="<%=bgcolor%>"><%= CustomNumberFormat.setToNumberFormat(objTariffa.getVALO_LIM_MAX())%></td>
                                               <td width="34%" bgcolor="<%=bgcolor%>" align="center">
											   		 <input type = "hidden" name = "txtCodeFascia<%=i+1%>" value = "<%=objTariffa.getCODE_FASCIA()%>">
                                               		 <input type = "hidden" name = "txtCodePrFascia<%=i+1%>" value = "<%=objTariffa.getCODE_PR_FASCIA()%>">
							 				   		 <input type = "hidden" name = "campoPrTariffa<%=i+1%>" value = "<%=objTariffa.getCODE_PR_TARIFFA()%>">
											   		 <input  class="textNumber" type = "text" maxlength="20" size="11" name = "txtImporto<%=i+1%>" value = "<%= CustomNumberFormat.setToNumberFormat(objTariffa.getIMPT_TARIFFA(),false)%>">
												</td>
                                            </tr>
                                      <%}
                                   }	
                                %>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
         </tr>
         <!-- quinta riga -->
         <tr>
            <td align = "left" valign = "top">
                <table width="100%" border="0">
                    <tr>
                        <td class="textB">Descrizione Tariffa</td>
                        <td nowrap><input class="text" type = "text" name = "txtDescrizioneTariffa" maxlength="255" value = "<%= objTariffa.getDESC_TARIFFA() %>"></td>
                        <td class="textB">Data Inizio Validita'</td>
                        <td nowrap>
							<input  class="text" type = "text" name = "txtDataInizioValidita" maxlength="10" size = "10" value = "<%= objTariffa.getDATA_INIZIO_TARIFFA() %>">
							<a href="javascript:showCalendar('frmDati.txtDataInizioValidita','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
							<a href="javascript:clearField(objForm.txtDataInizioValidita);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
						</td>
                        <!-- se la size del vettore è uguale a 1 significa che non ci sono fasce  quindi visualizzo l'importo-->
						<%if(vctDettaglioTariffa.size()==1)  
						 {%>
							<td class="textB">Importo</td>
                        	<td><input class="textNumber" type = "text" name = "txtImporto1" size = "12" maxlength="20" value = "<%=CustomNumberFormat.setToNumberFormat(objTariffa.getIMPT_TARIFFA(),false)%>"></td>
								<input type = "hidden" name = "campoPrTariffa1" value = "<%=objTariffa.getCODE_PR_TARIFFA()%>">
						<%}%>
                    </tr>
                </table>
            </td>
         </tr>
    </table>
     <!-- pulsantiera -->
    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
      <tr>
        <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
			<sec:ShowButtons td_class="textB"/>
        </td>
      </tr>
    </table>
    </form>
</BODY>
</HTML>
