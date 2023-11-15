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
<%=StaticMessages.getMessage(3006,"Tariffe_sconti_Upd.jsp")%>
</logtag:logData>
<%
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//@@@@@@@@@@@@@@@PARAMETRI PROVENIENTI DAL RADIO BUTTON@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//reperisco  parametri
String viewStateModifica = Misc.nh(request.getParameter("viewStateModifica"));

//ricevo i prametri per l'individuazione della tariffa nel db
String strCODE_TARIFFA = Misc.getParameterValue(viewStateModifica,"CODE_TARIFFA");
String strCODE_PR_TARIFFA = Misc.getParameterValue(viewStateModifica,"CODE_PR_TARIFFA");
String strCODE_SCONTO = Misc.getParameterValue(viewStateModifica,"CODE_SCONTO");
String strDATA_INIZIO_VALID = Misc.getParameterValue(viewStateModifica,"DATA_INIZIO_VALID");
int intAction = Integer.parseInt(Misc.getParameterValue(viewStateModifica,"intAction"));
int intFunzionalita = Integer.parseInt(Misc.getParameterValue(viewStateModifica,"intFunzionalita"));

String strCodeContr = Misc.getParameterValue(viewStateModifica,"strCodeContr");
String strCodeCliente = Misc.getParameterValue(viewStateModifica,"strCodeCliente");
//DESCRIZIONI
String strDescCliente = Misc.getParameterValue(viewStateModifica,"strDescCliente");
String strDescContratto = Misc.getParameterValue(viewStateModifica,"strDescContratto");
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
%>


<SCRIPT LANGUAGE="JAVASCRIPT">

function inizialize()
{
  objForm = document.frmDati;
  DisableAllControls(objForm);
	Enable(objForm.txtDataFineVal);
  Enable(objForm.CONFERMA);
  Enable(objForm.CHIUDI);
}

function ONCHIUDI()
{
  window.close();
}

function ONCONFERMA()
{

  if(objForm.txtDataFineVal.value == "")
  {
     alert("La data di fine validita' e' obbligatoria");
  }else{
          var dataInizio = new Date(objForm.txtDataInizioVal.value);
          var dataFine = new Date(objForm.txtDataFineVal.value);
          var DataDuas = new Date(objForm.hidDataDuas.value);

          if (dataFine >= DataDuas || objForm.hidDataDuas.value == "")
          {   
                  if(dataInizio >= dataFine)
                  {
                  //errore differenza date inizio e fine
                     alert("La Data Fine Validita' deve essere maggiore della Data Inizio Validita'");
                  }else{
                      if(window.confirm("procedere con la disattivazione?"))
                      {
                       objForm.action = "Tariffe_Sconti_Upd_2.jsp?CODE_TARIFFA=<%=strCODE_TARIFFA%>&CODE_PR_TARIFFA=<%=strCODE_PR_TARIFFA%>&CODE_SCONTO=<%=strCODE_SCONTO%>&DATA_INIZIO_VALID=<%=strDATA_INIZIO_VALID%>&DataFineValid="+ objForm.txtDataFineVal.value;
                       objForm.submit();
                      }
                  }
          }else{
          //errore data duas
            alert("La Data Fine Validità deve essere strettamente maggiore della data utlima applicazione canoni.("+ objForm.hidDataDuas.value + ").");
          }
  }
}

</SCRIPT>
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

<EJB:useHome id="homeEnt_TariffeSconti" type="com.ejbSTL.Ent_TariffeScontiHome" location="Ent_TariffeSconti" />
<EJB:useBean id="remoteEnt_TariffeSconti" type="com.ejbSTL.Ent_TariffeSconti" scope="session">
    <EJB:createBean instance="<%=homeEnt_TariffeSconti.create()%>" />
</EJB:useBean>
<%
Vector vctTariffeSconti = null;
vctTariffeSconti = remoteEnt_TariffeSconti.getDettaglioTariffaSconto( intAction,
                                                                        intFunzionalita,
                                                                        strCODE_TARIFFA,
                                                                        strCODE_PR_TARIFFA,
                                                                        strCODE_SCONTO,
                                                                        strDATA_INIZIO_VALID);
DB_TariffeSconti lobj_TariffaSconti = (DB_TariffeSconti)vctTariffeSconti.elementAt(0);

%> 

</HEAD>
<BODY onload="inizialize();">
<form name="frmDati" method="post" action="">
	<input type="hidden" name="hidCodeUnitaMisura" value="">
	<input type="hidden" name="hidViewState" value="">
  <input type="hidden" name="hidDataDuas" value="<%=Misc.nh(lobj_TariffaSconti.getDATA_DUAS())%>">
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"> DISATTIVAZIONE ASSOCIAZIONE TARIFFA SCONTO</td>
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
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dati identificativi tariffa</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
<tr>
	<td height="30" width="15%" class="textB">Cliente:</td>
	<td height="30" width="15%" class="text"><%=strDescCliente%></td>

	<td height="30" width="15%" class="textB">Contratto:</td>
	<td height="30" width="15%" class="text"><%=strDescContratto%></td>

</tr>
<tr>
    <td height="30" width="15%" class="textB">Prodotto/Servizio:</td>
    <td height="30" width="35%" class="text"><%=Misc.nh(lobj_TariffaSconti.getDESC_ES_PS())%></td>
    <td height="30" width="15%" class="textB">Prest.Aggiuntiva:</td>
    <td height="30" width="35%" class="text"><%=Misc.nh(lobj_TariffaSconti.getDESC_PREST_AGG())%></td>
</tr>
<tr>
    <td height="30" width="15%" class="textB">Classe oggetto di Fatturazione:</td>
	<td height="30" width="35%" class="text"><%=Misc.nh(lobj_TariffaSconti.getDESC_CLAS_OGG_FATRZ())%></td>
    <td height="30" width="15%" class="textB">Oggetto di Fatturazione:</td>
	<td height="30" width="35%" class="text"><%=Misc.nh(lobj_TariffaSconti.getDESC_OGG_FATRZ())%></td>
</tr>
<tr>
	<td height="30" width="15%" class="textB">Tipo Causale:</td>
	<td height="30" width="35%" class="text"><%=Misc.nh(lobj_TariffaSconti.getDESC_TIPO_CAUS())%></td>
	<td height="30" width="15%" class="textB">Tipo Offerta:</td>
	<td height="30" width="35%" class="text"><%=Misc.nh(lobj_TariffaSconti.getDESC_TIPO_OFF())%></td>
</tr>
<tr>
    <td height="30" width="15%"class="textB">Modalita applicazione:</td>
    <td height="30" width="35%" class="text"><!--%=Misc.nh(lobj_TariffaSconti.getTIPO_FLAG_MODAL_APPL_TARIFFA())%--></td>
   <td height="30" width="15%" class="text">&nbsp;</td>
   <td height="30" width="35%" class="text">&nbsp;</td>
</tr>
</table>
<!-- fine dati di riepilogo-->
<!-- tabella intestazione -->
<table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Dettagli</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
  <tr>
    <td>
        <table align='right' width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
          <tr>
            <td  colspan=2 align=center bgcolor="<%=StaticContext.bgColorHeader%>" class="white" >Classe di Sconto</td>
          </tr>
          <tr>
            <td align=right class="textB">Codice:</td>
            <td><input type="text" name="txtCodiceSconto" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getCODE_CLAS_SCONTO())%>" size="20" maxlength="20"></td>
          </tr>
          <tr>
            <td align=right class="textB">Importo minimo:</td>
            <td align=left><input type="text" name="txtImportoMin" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getIMPT_MIN_SPESA())%>" size="20" maxlength="20"></td></tr>
          <tr>
            <td align=right class="textB">Importo massimo:</td>
            <td align=left><input type="text" name="txtImportoMax" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getIMPT_MAX_SPESA())%>" size="20" maxlength="20"></td></tr>
        </table>
    </td>
    <td>
        <table width="100%" border="0" cellspacing="0" height="100%" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
          <tr>
            <td  colspan=4 align=center bgcolor="<%=StaticContext.bgColorHeader%>" class="white" >Fascia</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td class="textB" align=center>Valore Massimo</td>
            <td class="textB" align=center>Valore Minimo</td>
          </tr>
          <tr>
            <td align=right class="textB" valign=top colspan="2" width="100%">Codice:<input type="text" name="txtCodiceFascia" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getCODE_FASCIA())%>" size="10" maxlength="20">
            </td>
            <td colspan=2 class="textB" align=center height="100">
                <div style="overflow:auto;height:100px;width:300px;">
                   <table border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                   <%
                    //ciclo per popolamento div
                    

int NumRecord = vctTariffeSconti.size();
                    for(int i=0;i<NumRecord; i+=1)
                    {
                    DB_TariffeSconti lobj_TariffaScontiFascia = (DB_TariffeSconti)vctTariffeSconti.elementAt(i);
                   %>
                          <tr>
                              <td>
                                  <input type="text" name="txtMax1" class="text" value = "<%=Misc.nh(lobj_TariffaScontiFascia.getVALO_LIM_MIN())%>" size="20" maxlength="20">
                              </td>
                               <td align=center>
                                  <input type="text" name="txtMin1" class="text" value = "<%=Misc.nh(lobj_TariffaScontiFascia.getVALO_LIM_MAX())%>" size="20" maxlength="20">
                              </td>
                          </tr>
                    <%
                    }
                    //fine ciclo%>
                       </table>
                </div>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr>
    <td>
        <table width="100%" border="0" cellspacing="0" height="100%" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
          <tr>
            <td  colspan=2 align=center bgcolor="<%=StaticContext.bgColorHeader%>" class="white" >Sconto</td>
          </tr>
          <tr>
            <td align=right class="textB">Sconto:</td>
            <td><input type="text" name="txtSconto" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getDESC_SCONTO())%>" size="20" maxlength="20"></td>
          </tr>
          <tr>
            <td align=right class="textB">Importo di decremento:</td>
            <td align=left><input type="text" name="txtImportoDecr" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getVALO_DECR_TARIFFA())%>" size="20" maxlength="20"></td></tr>
          <tr>
            <td align=right class="textB">Valore percentuale(%):</td>
            <td align=left><input type="text" name="txtValPerc" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getVALO_PERC_SCONTO())%>" size="20" maxlength="20"></td></tr>
        </table>
    </td>
    <td>
        <table align=center width="100%" border="0" cellspacing="0" height="100%" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
          <tr>
            <td  colspan=3 align=center bgcolor="<%=StaticContext.bgColorHeader%>" class="white" >Validità</td>
          </tr>
          <tr>
            <td align=right class="textB">Data inizio validità:</td>
            <td align=left><input type="text" name="txtDataInizioVal" class="text" value = "<%=Misc.nh(lobj_TariffaSconti.getDATA_INIZIO_VALID())%>" size="20" maxlength="20"></td>
            <td height="30" width="35%" valign="" nowrap>
          		&nbsp;
            </td>
          </tr>
          <tr>
            <td align=right class="textB">Data fine validità:</td>
            <td align=left><input type="text" name="txtDataFineVal" class="text" value = "<%=DataFormat.getDate()%>" size="20" maxlength="20"></td>
          	<td height="30" width="35%" valign="" nowrap>
          		<a href="javascript:showCalendar('frmDati.txtDataFineVal','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
          		<a href="javascript:clearField(objForm.txtDataFineVal);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
          	</td>
        	</tr>
        </table>
    </td>
  </tr>
</table>
 <!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td bgcolor="white"><img src="<=StaticContext.PH_COMMON_IMAGES>pixel.gif" width="1" height="3"></td>
		</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	  <tr>
	    <td class="textB" bgcolor="<=StaticContext.bgColorTestataTabella>" align="left">
			<sec:ShowButtons td_class="textB"/>
	    </td>
	  </tr>
	</table>

</form>

</BODY>
</HTML>
