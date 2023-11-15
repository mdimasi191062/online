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
<%@ page import="com.utl.*,java.lang.reflect.Array"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<!-- inclusione della tagLib che permette l'instanziazione dell'oggetto remoto  -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_canc_tar_X_tipol_contr_2_cl.jsp")%>
</logtag:logData>

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
<%  
//dichiarazione variabili
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

int i=0;
String bgcolor = "";
Vector vctTipoOfferta = null;
Vector vctUnitaMisura = null;
Vector vctClassiSconto = null;
Vector vctCodiciFascia = null;
String strSelected = "";
String strSelected2 = "";
String strChecked = "";
String strCODE_PR_PS_PA_CONTR = "";
// recupero i parametri provanienti dalla pagina di ricerca
String strCodeContr = request.getParameter("cboContratto");
String strCodePrestAgg = Misc.nh(request.getParameter("cboPrestAgg"));
String strCodePs = request.getParameter("PsSel");
String strCodeOggFatGlobal = request.getParameter("cboOggFat");

//estrazione codice dell'oggetto fatturazione
String strCodeOggFat="";
String strCodeClassOggFat="";

String strArrayRadio[][]={{"F","FISSO"},
						  {"V","VARIABILE"},
						  {"A","SCAGLIONI"}}; 
						  
//RICEZIONE DESCRIZIONI DAL VIEWSTATE
String strViewState = request.getParameter("viewState");
System.out.println(strViewState);
String strDescTipoContratto=Misc.getParameterValue(strViewState,"vsDescTipoContratto");
//String strDescCliente=Misc.getParameterValue(strViewState,"vsDescCliente");
//String strDescContratto=Misc.getParameterValue(strViewState,"vsDescContratto");
String strDescPS=Misc.getParameterValue(strViewState,"vsDescPS");
String strDescPrestAgg=Misc.getParameterValue(strViewState,"vsDescPrestAgg");
String strDescOggFatt=Misc.getParameterValue(strViewState,"vsDescOggFatt");
String strDescTipoCaus=Misc.getParameterValue(strViewState,"vsDescTipoCaus");
String strCodeTipoContratto=Misc.getParameterValue(strViewState,"vsCodeTipoContratto");

//FINE RICEZIONE DESCRIZIONI DAL VIEWSTATE						  

//estrazione dei codici provenienti dalla combo dell'oggetto fatturazione
if(strCodeOggFatGlobal!=null)
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
String strCodeTipoCaus = request.getParameter("cboTipoCaus");
String strDATA_INIZIO_VALID_OF="";
String strDATA_INIZIO_VALID_OF_PS="";
%>
<!-- se arrivano i campi vuoti la pagina deve essere bianca -->
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
        function ONELIMINA()
        {
            if(validazioneCampi(objForm))
            {
				//controlli specifici della funzionalità
				//se non è stata selezionata una fascia e il tipo importo scelto è (scaglioni) la fascia è obbligatoria 
				if(getComboValue(objForm.cboCodFascia) == "")
				{
					//verifica che sia stato scelto (scaglioni) come tipo importo
					if(getRadioButtonValue(objForm.rdoTipoImporto) == "A")
					{
						alert("Selezionare un Fascia!!");
						return;
					}
				}
				popUpClienti();
            }
        }
        function popUpClienti(){
			var stringa="<%=StaticContext.PH_CLASSIC_COMMON_JSP%>com_sel_gest_lista_cl.jsp";
			stringa+="?intAction=<%=intAction%>";
			stringa+="&intFunzionalita=<%=intFunzionalita%>";
			stringa+="&codeTipoContratto=<%=strCodeTipoContratto%>";
			stringa+="&codeTipoCaus=<%=strCodeTipoCaus%>";
			stringa+="&codePS=<%=strCodePs%>";
			stringa+="&codeOggFatt=<%=strCodeOggFat%>";
			stringa+="&codePrestAgg=<%=strCodePrestAgg%>";
			openDialog(stringa, 569, 300, handleReturnedValueCliente);
		}
		function handleReturnedValueCliente(){
			if(dialogWin.returnedValue=="ok"){
				objForm.action = "<%=StaticContext.PH_TARIFFE_JSP%>cbn1_canc_tar_X_tipol_contr_3_cl.jsp";
	        	objForm.txtOperazione.value = "<%=StaticContext.INSERT%>";
				EnableAllControls(objForm);
            	objForm.submit();	
			}
		}
		function ONANNULLA()
		{
			clearField(objForm.cboTipoOfferta);
            clearField(objForm.cboUnitaMisura);
            objForm.rdoTipoImporto[0].checked=true;
            clearField(objForm.cboClassiSconto);
            clearField(objForm.cboCodFascia);
			objForm.submit();
		}
        function change_cboCodFascia()
        {
            objForm.submit();
        }
        
        function change_cboClassiSconto()
        {
           objForm.submit();
        }
        function initialize()
        {
			objForm = document.frmDati;
			//impostazione delle proprietà di default per tutti gli oggetti della form
			setDefaultProp(objForm);
            // impostazione delle proprietà degli elementi di input per la validazione dei campi
			<% if(!strCodeClassOggFat.equals(StaticContext.CL_CANONE)){ %>
				setObjProp(objForm.cboUnitaMisura,"label=Unità di misura|obbligatorio=no");
				Disable(objForm.cboUnitaMisura);
				Disable(objForm.cboCodFascia);
			<%}else{%>			
				setObjProp(objForm.cboUnitaMisura,"label=Unità di misura|obbligatorio=si");
			<%}%>
			
			<%if(strCodeOggFat.equals(Integer.toString(StaticContext.OF_CANONE_MENSILE_TRASM_FISSO))){%>
				objForm.rdoTipoImporto[1].checked = true;
				Disable(objForm.rdoTipoImporto[0]);
				Disable(objForm.rdoTipoImporto[1]);
				Disable(objForm.rdoTipoImporto[2]);
			<%}%>
        }
       
    </SCRIPT>
</HEAD>
<!-- l'inizializzazione della form viene fatta solo nel caso i cui vengono spediti i parametri -->
<BODY onload = "initialize()">

<form name="frmDati" method="post" action=''>
<!-- se arrivano i parametri dal frame superiore faccio vedere il resto della form -->
    <!-- campi hidden per il passaggio dei valori quando viene richiesto il dettaglio -->
	<input type = "hidden" name = "codiceTipoContratto" value = "<%= strCodeTipoContratto %>">
    <input type = "hidden" name = "cboContratto" value = "<%= strCodeContr %>">
    <input type = "hidden" name = "cboPrestAgg" value = "<%= strCodePrestAgg %>">
    <input type = "hidden" name = "PsSel" value = "<%= strCodePs %>">
	<input type = "hidden" name = "cboOggFat" value = "<%= strCodeOggFatGlobal %>">
	<input type = "hidden" name = "txtCodeClassOggFat" value = "<%= strCodeClassOggFat %>">
    <input type = "hidden" name = "cboTipoCaus" value = "<%= strCodeTipoCaus %>">
    <input type = "hidden" name = "CODE_PR_PS_PA_CONTR" value = "<%= strCODE_PR_PS_PA_CONTR%>">
    <input type = "hidden" name = "DATA_INIZIO_VALID_OF" value = "<%= strDATA_INIZIO_VALID_OF%>">
    <input type = "hidden" name = "DATA_INIZIO_VALID_OF_PS" value = "<%= strDATA_INIZIO_VALID_OF_PS%>">
	<input type = "hidden" name = "viewState" value="<%=strViewState%>">
    <input type = "hidden" name = "txtOperazione" value = "">
	<table align='center' width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="<%=StaticContext.PH_TARIFFE_IMAGES%>titoloPagina.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
						<tr>
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Eliminazione Tariffe X Tipologia di Contratto</td>
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
        <td width="30%" height="25" class="textB" align="right">P/S:&nbsp;&nbsp;</td>
        <td width="70%" height="25" class="text">
          <%=strDescPS%>
        </td>
	  </tr>
	  <tr>
        <td width="30%" height="25" class="textB" align="right">Prestazione Aggiuntiva:&nbsp;&nbsp;</td>
        <td width="70%" height="25" class="text">
           <%=strDescPrestAgg%>
        </td>
      </tr>
      <tr>
        <td width="30%" height="25" class="textB" align="right">Oggetto Fatturazione:&nbsp;&nbsp;</td>
        <td width="70%" height="25" class="text">
         <%=strDescOggFatt%>
        </td>
	  </tr>
	  <tr>
        <td width="30%" height="25" class="textB" align="right">Tipo Causale:&nbsp;&nbsp;</td>
        <td width="70%" height="25" class="text">
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
				  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;ELIMINAZIONE</td>
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
									  if(request.getParameter("cboTipoOfferta") != null)
                                      {
                                          if(request.getParameter("cboTipoOfferta").equalsIgnoreCase(lobj_TipiOfferte.getCODE_TIPO_OFF()))
                                          {
                                            strSelected = "selected";
                                          }
                                          else
                                          {
                                            strSelected = "";
                                          }
                                      }%>
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
                                  for(Enumeration e = vctUnitaMisura.elements();e.hasMoreElements();)
                                    {
                                      DB_UnitaMisura lobj_UnitaMisura = new DB_UnitaMisura();
                                      lobj_UnitaMisura = (DB_UnitaMisura)e.nextElement();
									  if(request.getParameter("cboUnitaMisura") != null)
                                      {
                                          if(request.getParameter("cboUnitaMisura").equalsIgnoreCase(lobj_UnitaMisura.getCODE_UNITA_MISURA()))
                                          {
                                            strSelected = "selected";
                                          }
                                          else
                                          {
                                            strSelected = "";
                                          }
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
							  <%for(i=0;i <  Array.getLength(strArrayRadio);i++){%>
								   <%if(request.getParameter("rdoTipoImporto") != null){%>
										<%if(request.getParameter("rdoTipoImporto").equals(strArrayRadio[i][0])) strChecked = "checked"; else	strChecked = "";%> 
											<!-- <input class="text" type="radio" name="rdoTipoImporto" <%=strChecked%> value="<%= strArrayRadio[i][0]%>"><%= strArrayRadio[i][1]%>	 -->
								   <%}else{%>
										<%if(i==0)strChecked = "checked"; else strChecked = "";%>
											<!-- <input class="text" type="radio" name="rdoTipoImporto" <%=strChecked%> value="<%= strArrayRadio[i][0]%>"><%= strArrayRadio[i][1]%> -->
								   <%}%>
								   <input class="text" type="radio" name="rdoTipoImporto" <%=strChecked%> value="<%= strArrayRadio[i][0]%>"><%= strArrayRadio[i][1]%>
								   <% System.out.println("strCodeClassOggFat: " + strCodeClassOggFat);%>
								   <%//se non è canone deve esistere un solo radioButton("FISSO")%>
								   <%if(!strCodeClassOggFat.equalsIgnoreCase(StaticContext.CL_CANONE)){%>
									 	<%if(i == 0)break;%>
								   <%}%>
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
										<select style="width:250;" class="text" name="cboClassiSconto" onchange="change_cboClassiSconto()">
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
		                                            }
		                                           %>
		                                            <option class="text" <%= strSelected %> value="<%=lobj_ClassiSconto.getCODE_CLAS_SCONTO()%>"><%=lobj_ClassiSconto.getCODE_CLAS_SCONTO()%></option>  
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
                                <!-- ciclo -->
                                <%
                                 // se le combo è stata selezionata
                                  if(request.getParameter("cboClassiSconto") != null)
                                  {
                                        vctClassiSconto = null;
                                        // carico il vettore con il dettaglio delle classi
                                        vctClassiSconto = remoteEnt_ClassiSconto.getDettaglioClassiSconto(StaticContext.INSERT,request.getParameter("cboClassiSconto"));
                                        if(vctClassiSconto != null)
                                        {
                                             // se il vettore è stato caricato si prosegue con il caricamento della lista
                                            for(i =0; i < vctClassiSconto.size(); i++)
                                            {
                                                  DB_ClasseSconto lobj_ClassiSconto = new DB_ClasseSconto();
                                                  lobj_ClassiSconto = (DB_ClasseSconto)vctClassiSconto.elementAt(i);
												  if ((i%2)==0)
								                   	bgcolor=StaticContext.bgColorRigaPariTabella;
								                  else
								                   	bgcolor=StaticContext.bgColorRigaDispariTabella;%>
                                                 <tr bgcolor="<%=bgcolor%>">
                                                    <td width="47%" class="textNumber"><%= CustomNumberFormat.setToNumberFormat(lobj_ClassiSconto.getIMPT_MIN_SPESA())%></td>
                                                    <td width="47%" class="textNumber"><%= CustomNumberFormat.setToNumberFormat(lobj_ClassiSconto.getIMPT_MAX_SPESA(),true)%></td>
													<% if(i==0){
														strChecked = "checked";
													   }else{
													   	strChecked = "";	
													   }	
													%>
                                                    <td width="6%"><input type = "radio" name = "rdoClasse" value = "<%=lobj_ClassiSconto.getCODE_PR_CLAS_SCONTO()%>" <%= strChecked%>></td>
                                                 </tr>
                                          <%}
                                        }
                                  }
                                %>
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
		                                                    strSelected2 = "selected";
		                                                  }
		                                                  else
		                                                  {
		                                                    strSelected2 = "";
		                                                  }
		                                              }
		                                          %>
		                                            <option class="text" <%= strSelected2 %> value="<%=lobj_Fascia.getCODE_FASCIA()%>"> <%=lobj_Fascia.getCODE_FASCIA()%></option>
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
                                </tr>
                                <!-- ciclo -->
                                <%
                                 // se le combo è stata selezionata
                                  if(request.getParameter("cboCodFascia") != null)
                                  {
                                        vctCodiciFascia = null;
                                        // carico il vettore con il dettaglio delle fasce
                                        vctCodiciFascia = remoteEnt_Fasce.getDettaglioFasce(StaticContext.INSERT,request.getParameter("cboCodFascia"));
                                        if(vctClassiSconto != null)
                                        {
                                             // se il vettore è stato caricato si prosegue con il caricamento della lista
                                            for(i =0; i < vctCodiciFascia.size(); i++)
                                            {
                                                  DB_Fascia lobj_Fascia = new DB_Fascia();
                                                  lobj_Fascia = (DB_Fascia)vctCodiciFascia.elementAt(i);
												  //cambia il colore delle righe
												  if ((i%2)==0)
								                   	bgcolor=StaticContext.bgColorRigaPariTabella;
								                  else
								                   	bgcolor=StaticContext.bgColorRigaDispariTabella;%>
                                                 <tr>
												 	<input type = "hidden" name = "txtCodeFascia<%=i+1%>" value = "<%=lobj_Fascia.getCODE_FASCIA()%>">
													<input type = "hidden" name = "txtCodePrFascia<%=i+1%>" value = "<%=lobj_Fascia.getCODE_PR_FASCIA()%>">
                                                    <td width="33%" class="textNumber" bgcolor="<%=bgcolor%>"><%= CustomNumberFormat.setToNumberFormat(lobj_Fascia.getVALO_LIM_MIN())%></td>
                                                    <td width="33%" class="textNumber" bgcolor="<%=bgcolor%>"><%= CustomNumberFormat.setToNumberFormat(lobj_Fascia.getVALO_LIM_MAX(),true)%></td>
                                                 </tr>
                                          <% 
										  	}
                                        }
                                  }
                                %>
                            </table>
                        </td>
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
