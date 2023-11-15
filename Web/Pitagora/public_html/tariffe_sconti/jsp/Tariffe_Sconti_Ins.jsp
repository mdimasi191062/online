<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*" %>
<%@ page import="java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"Tariffe_sconti_Ins.jsp")%>
</logtag:logData>
  <!-- insatnziazione dell'oggetto remoto  -->
        <EJB:useHome id="homeEnt_Tariffe" type="com.ejbSTL.Ent_TariffeHome" location="Ent_Tariffe" />
        <EJB:useBean id="remoteEnt_Tariffe" type="com.ejbSTL.Ent_Tariffe" scope="session">
            <EJB:createBean instance="<%=homeEnt_Tariffe.create()%>" />
        </EJB:useBean>

        <EJB:useHome id="homeEnt_Sconti" type="com.ejbSTL.Ent_ScontiHome" location="Ent_Sconti" />
        <EJB:useBean id="remoteEnt_Sconti" type="com.ejbSTL.Ent_Sconti" scope="session">
            <EJB:createBean instance="<%=homeEnt_Sconti.create()%>" />
        </EJB:useBean>
        <%
                //per log
                String strLogMessage = "";
                int intNumMessage = 0;
                String strParameterToLog = "";


                //RICEZIONE DESCRIZIONI DAL VIEWSTATE
                String strViewState = request.getParameter("viewState");
                String strDescTipoContratto=Misc.getParameterValue(strViewState,"vsDescTipoContratto");
                String strDescCliente=Misc.getParameterValue(strViewState,"vsDescCliente");
                String strDescContratto=Misc.getParameterValue(strViewState,"vsDescContratto");
                String strDescPS=Misc.getParameterValue(strViewState,"vsDescPS");
                String strDescPrestAgg=Misc.getParameterValue(strViewState,"vsDescPrestAgg");
                String strDescOggFatt=Misc.getParameterValue(strViewState,"vsDescOggFatt");
                String strDescTipoCaus=Misc.getParameterValue(strViewState,"vsDescTipoCaus");
                //FINE RICEZIONE DESCRIZIONI DAL VIEWSTATE

                //dichiarazione variabili
                int i=0;
                int intRecTotali = 0;
                Date DataTariffaMin = null;
                String strDataTariffaMin= null;
                String bgcolor = "";
                Vector vctTariffeVector = null;
                String strChecked = ""; 
                // recupero i parametri provanienti dalla pagina di ricerca
                String strCodeContr = request.getParameter("cboContratto");
                String strCodePrestAgg = "";
                String strCODE_PR_PS_PA_CONTR = "";
                //estrazione della prestzione aggiuntiva e del code_pr_ps_pa_contr
                strCodePrestAgg = Misc.nh(request.getParameter("cboPrestAgg"));
                String strCodePs = request.getParameter("PsSel");
                String strCodeOggFatGlobal = request.getParameter("cboOggFat");
                //estrazione codice dell'oggetto fatturazione
                String strCodeOggFat="";
                String strCodeClassOggFat="";
                //estrazione codice dell'oggetto fatturazione
                if(strCodeOggFatGlobal!=null){
                  Vector vctOggFatt = Misc.split(strCodeOggFatGlobal,"$");
                  strCodeOggFat = (String)vctOggFatt.elementAt(0);
                  strCodeClassOggFat = (String)vctOggFatt.elementAt(1);    
                }
                int intAction = Integer.parseInt(request.getParameter("intAction"));
                int intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));

                String strCodeTipoCaus = request.getParameter("cboTipoCaus");
                String strCodeTariffa = request.getParameter("campoTipoTariffa");
                String strCodePrTariffa = request.getParameter("campoPrTariffa1");
                String strDataCreazioneTariffa = request.getParameter("DataCreazioneTariffa");


        %>
        <HTML>
        <HEAD>

            <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
            <TITLE>Associazione Nuove Tariffe Sconti</TITLE>
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

        </HEAD>
        <script language="javascript">
        var objForm;
        function inizialize()
        {
        objForm = document.frmDati;
        }

        function ValorizzaSconto()
        {

        var Sconto = objForm.cboSconto.value;
        appo= Sconto.split("|");

        ValoPerc = appo[1];
        ValoDecr = appo[2];
        objForm.hidCodeSconto.value = appo[0];
        objForm.txtImportoDecremento.value=ValoDecr;
        objForm.txtPerc.value = ValoPerc;

        }

        function ONCHIUDI()
        {
        window.close();
        }

        </script>
        <BODY onload="inizialize();">
            <form name="frmDati" method="post" action="">
            <input type="hidden" name="hidAction" value="">
            <input type="hidden" name="hidCodeSconto" value="">
        <!-- visualizzazione delle descrizioni  -->
        <table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
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
              <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td  width='15%' class="textB" align="right" valign="top">Cliente:&nbsp;</td>
                <td  width='35%' class="text" valign="top">
                  <%=strDescCliente%>
                </td>
                <td  width='20%'class="textB" align="right" valign="top">Contratto:&nbsp;</td>
                <td  width='30%'class="text" valign="top">
                  <%=strDescContratto%>
                </td>
              </tr>
              <tr>
                <td class="textB" align="right" valign="top">P/S:&nbsp;</td>
                <td class="text" valign="top">
                  <%=strDescPS%>
                </td>
                <td class="textB" align="right">Prest. Agg.:&nbsp;</td>
                <td class="text">
                   <%=strDescPrestAgg%>
                </td>
              </tr>
              <tr>
                <td class="textB" align="right" valign="top">Ogg. Fat.:&nbsp;</td>
                <td class="text" valign="top">
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
        </table>		
        <!--TITOLO PAGINA-->			
        <table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
          </tr>
        </table>
        <table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dettaglio</td>
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
                <CENTER>
            <table width="90%" border="0" cellspacing="1" cellpadding="1" align="center">
              <tr>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Offerta</td>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Cl.Sc.</td>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Cl.Sc.</td>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo Tar.</td>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Fascia</td>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Fascia</td>
                      <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Importo</td>
              </tr>
                  <%//se è stata effettuata una ricerca
               if(strCodeContr != null)
               {
                //invoca il metodo per reperire la lista delle tariffe
                vctTariffeVector = null;
                   vctTariffeVector = remoteEnt_Tariffe.getListaTariffe(StaticContext.LIST,
                                                                            strCodeContr,
                                                                            strCodePs,
                                                                            strCodePrestAgg,
                                                                            strCodeTipoCaus,
                                                                            strCodeOggFat);
                intRecTotali = vctTariffeVector.size();
              }
                %>
              <%                                               
                    // se il vettore è stato caricato si prosegue con il caricamento della lista
              String strPopolamento="S";
                    if ((vctTariffeVector==null)||(vctTariffeVector.size()==0)){
                strPopolamento="N";%>
                  <tr>
                    <td class="text" colspan="10" align="center">
                    &nbsp;<BR>no record found
                  </td>
                  </tr>

                  <%
                     }else{
        %>          
                  <tr>
                    <td colspan=7>
                        <div style="overflow:auto;width:620px;height:100px;">
                        <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
                              <tr>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Tipo Offerta</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Min Cl.Sc.</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Max Cl.Sc.</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Importo Tar.</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Min Fascia</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Max Fascia</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'><font color="<%=StaticContext.bgColorTestataTabella%>">Tipo Importo</td>
                              </tr>
        <%
                            Vector lvct_IdentTariffe = new Vector();
                            DateFormat formatDataTariffa = new SimpleDateFormat("dd/MM/yyyy");
                    
                    
                            for(i=0;i < intRecTotali;i++)
                            {
                          
                                   DB_Tariffe lobj_Tariffa = (DB_Tariffe)vctTariffeVector.elementAt(i);
                                   if(DataTariffaMin == null)
                                   {
                                        DataTariffaMin = (Date)formatDataTariffa.parse(lobj_Tariffa.getDATA_INIZIO_TARIFFA());
                                        strDataTariffaMin = lobj_Tariffa.getDATA_INIZIO_TARIFFA();
                                   }else{
                           
                                        if(DataTariffaMin.compareTo((Date)formatDataTariffa.parse(lobj_Tariffa.getDATA_INIZIO_TARIFFA())) > 0)
                                          {
                                            DataTariffaMin = (Date)formatDataTariffa.parse(lobj_Tariffa.getDATA_INIZIO_TARIFFA());
                                            strDataTariffaMin = lobj_Tariffa.getDATA_INIZIO_TARIFFA();
                                          }
                                   }
                                    //preparo il vettore per l'inserimento della nuova associazione
                                    lvct_IdentTariffe.add(lobj_Tariffa.getCODE_TARIFFA()+"|"+lobj_Tariffa.getCODE_PR_TARIFFA());
                            
                                    if ((i%2)==0)
                                        bgcolor=StaticContext.bgColorRigaPariTabella;
                                    else
                                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                                    %>
                                        <tr>
                                          <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getDESC_TIPO_OFF()%></td>
                                          <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MIN_SPESA())%></td>
                                          <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_MAX_SPESA())%></td>
                                          <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=CustomNumberFormat.setToNumberFormat(lobj_Tariffa.getIMPT_TARIFFA())%></td>
                                          <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MIN()%></td>
                                          <td bgcolor='<%=bgcolor%>' class='textNumber'>&nbsp;<%=lobj_Tariffa.getVALO_LIM_MAX()%></td>
                                          <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;<%=lobj_Tariffa.getTIPO_FLAG_MODAL_APPL_TARIFFA()%></td>
                                        </tr>
                                
                          <%}
                           session.setAttribute("VectorTariffeList", lvct_IdentTariffe);
                          %>
                        </table>
                      </div>
                    </td>
                  </tr>
                           <%}%>
              
               </table>

                </CENTER>
            </td>
          </tr>
        </table>
        <table align='center' width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
          <td align="center">
            <table align='center' border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                <tr>
                    <td  colspan=4 align=center bgcolor="<%=StaticContext.bgColorHeader%>" class="white" >Sconto</td>
                </tr>
                <tr>
                    <td class="textB" align="center" rowspan="2">Sconto:&nbsp;
                     <select class="text" title="Sconto" name="cboSconto" onchange="ValorizzaSconto();">
                      <option class="text" selected value="">[Seleziona Opzione]</option>
                      <%
                      Vector vctTariffeVectorSconti = null;
                      vctTariffeVectorSconti = remoteEnt_Sconti.getSconti(intFunzionalita,intAction);
                      intRecTotali = vctTariffeVectorSconti.size();
                
                      for(i=0; i<intRecTotali; i++)
                      {
                       DB_Sconti lobj_Sconti = new DB_Sconti();
                       lobj_Sconti = (DB_Sconti)vctTariffeVectorSconti.elementAt(i);
                      %>
                      <option value='<%=lobj_Sconti.getCODE_SCONTO()%>|<%=lobj_Sconti.getVALO_PERC()%>|<%=lobj_Sconti.getVALO_DECR()%>'>&nbsp;<%=lobj_Sconti.getDESC_SCONTO()%></option>
                      <%}%>
                      </select>
                  </td>
                  <td class="textB" align="center">
                          Importo di decremento:&nbsp;
                  </td>
                  <td class="textB" align="center">
                          <input class="text" disabled title="Importo di decremento" type="text" maxlength="100" name="txtImportoDecremento" value="">
                  </td>
                </tr>
                <tr>
                  <td class="textB" align="center">
                        Valore percentuale:&nbsp;
                  </td>
                  <td class="textB" align="center">
                        <input class="text" disabled title="Valore percentuale" type="text" maxlength="100" name="txtPerc" value="">
                  </td>
                </tr>
            </table>
          </td>
          <td>
              <table align="center" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                 <tr>
                  <td class="textB" align="center">
                        Data inizio validita':&nbsp;
                  </td>
                  <td class="textB" align="center">
                        <input class="text" title="Data inizio validita" type="text" size="10" maxlength="10" name="txtDataInizioVal" value="">
                  </td>
                  <td height="30" valign="" nowrap>
                      <a href="javascript:showCalendar('frmDati.txtDataInizioVal','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                      <a href="javascript:clearField(objForm.txtDataInizioVal);"        onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                    </td>
                </tr>
              </table>
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
            <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
            <sec:ShowButtons td_class="textB"/>
            </td>
          </tr>
        </table>
        <script language="javascript">
        function ONCONFERMA()
        {

        if(objForm.txtDataInizioVal.value == "")
          {
          alert("La data di inizio validita' e' obbligatoria");
          return false;
          }
          else
          {
  
          var DataInizioValid = new Date(objForm.txtDataInizioVal.value);
  
          var DataInizioMin = new Date("<%=strDataTariffaMin%>");
          if(document.frmDati.cboSconto.value == "")
          {
            alert("Lo sconto e' obbligatorio");
            return false;
          }else{
                if(DataInizioMin >  DataInizioValid)
                {
                  alert("la data inizio validita' deve essere compresa nel periodo di valdita' delle tariffe selezionate");
                  return false;
                }
                else
                {
                  objForm.hidAction.value="Ins";
                  objForm.action ="Tariffe_Sconti_Ins_2.jsp";
                  objForm.submit();
                }
            }
          }
        
        }
        </script>
        </form>
        </BODY>
        </HTML>
