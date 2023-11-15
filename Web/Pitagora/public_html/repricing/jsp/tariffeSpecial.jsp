<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"tariffeSpecial.jsp")%>
</logtag:logData>
<%
  String data_ini_mmdd    = Utility.getDateMMDDYYYY();
  String strUserName    = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
%>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/misc.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/tariffeSpecial.js"></SCRIPT>

<SCRIPT LANGUAGE='Javascript'>
var pathImg = '<%=StaticContext.PH_COMMON_IMAGES%>';

function caricaContratti()
{
  carica = function(dati){onCaricaAccount(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('codiceTipoContratto='+<%=request.getParameter("codiceTipoContratto")%>,'listaContrattiXTariffe',asyncFunz); 
}

function caricaTariffe()
{
  carica = function(dati){onCaricaTariffe(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('of='+code_of+'&code_contr='+code_contr+'&code_ps='+code_ps+'&causale='+code_tipo_caus+'&codiceTipoContratto='+<%=request.getParameter("codiceTipoContratto")%>,'listaTariffe',asyncFunz);
}

function caricaOF()
{
  carica = function(dati){onCaricaOF(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('code_contr='+code_contr+'&code_ps='+code_ps+'&codiceTipoContratto='+<%=request.getParameter("codiceTipoContratto")%>,'listaOF_PSXTariffe',asyncFunz);
}

function caricaPs()
{
  carica = function(dati){onCaricaPs(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('code_contr='+code_contr+'&codiceTipoContratto='+<%=request.getParameter("codiceTipoContratto")%>,'listaPsXTariffe',asyncFunz);
}

function onChangeOF()
{
  indice= document.formPag.comboOggFatt.selectedIndex;
  if(indice>=0)
  {
    code_of =document.formPag.comboOggFatt.options[indice].value;
    document.formPag.desc_tariffa.value=document.formPag.comboOggFatt.options[indice].text.toUpperCase();
  }
  else
  {
    code_of='';
    repricing='';
    document.formPag.desc_tariffa.value='';
  }
  carica = function(dati){onCaricaCausale(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  
  //R1I-13-0124 Servizi Promozioni 
  var code_classe_of  = datiOF[indice].classe;
  var codiceTipoContratto = <%=request.getParameter("codiceTipoContratto")%>;
  //alert(code_classe_of);
  //alert(codiceTipoContratto);
  document.formPag.code_classe_of.value = code_classe_of;
  document.formPag.codiceTipoContratto.value = codiceTipoContratto;

  chiamaRichiesta('code_classe_of='+datiOF[indice].classe+'&codiceTipoContratto='+<%=request.getParameter("codiceTipoContratto")%>,'listaCausaliXTariffa',asyncFunz); 

  if((datiOF[indice].classe=='2' || datiOF[indice].classe=='13') || ( 
                                      (<%=request.getParameter("codiceTipoContratto")%>=='41' 
                                       || <%=request.getParameter("codiceTipoContratto")%>=='7' 
                                       || <%=request.getParameter("codiceTipoContratto")%>=='8' 
                                       ) 
                                       && datiOF[indice].classe!='2'
                                    ) 
    )
  {
      showMascheraCanone(true);
  }
  else
  {
      showMascheraCanone(false);
      tipo_importo='F';
      unitadimisura='';
  }
  resetPromozioni();
}


function AggiungiPromozione(codePromozione,descPromozione,div,dfv,divc,dfvc,codeProgBill,numMesi){
  if(checkPromozione(codePromozione,descPromozione,div,dfv,divc,dfvc,codeProgBill,numMesi)){
    var objTable = document.all('TableRegole');
    var objRow;
    var objCell; 
    
    if(colorRow=='row1')colorRow = 'row2'; else colorRow='row1';
    
    objRow = objTable.insertRow();
    objRow.className=colorRow;
    objRow.height = '18';
      
    objCell = objRow.insertCell();
    objCell.innerHTML = descPromozione;
    objCell.align = 'center';
    objCell.width = '46%';
    objCell.innerHTML += '<INPUT typeTxt="PROMOZIONE" type="hidden" name="PROMO-'+codePromozione+'_'+conta_promozioni+'" id="PROMO-'+codePromozione+'_'+conta_promozioni+'" value="'+descPromozione+'" promozioneId="'+codePromozione+'" div="'+div+'" dfv="'+dfv+'" divc="'+divc+'" dfvc="'+dfvc+'" cpb="'+codeProgBill+'" numMesiCanoni="'+numMesi+'">';
    
    objCell = objRow.insertCell();
    objCell.width = '10%';
    objCell.align = 'center';
    objCell.innerHTML = '<a href="javascript:openPromozioneAdd(\'PROMO-'+codePromozione+'_'+conta_promozioni+'\')">Dettagli...</a>';
    
    objCell = objRow.insertCell();    
    objCell.width = '8%';
    objCell.align = 'center';
    objCell.innerHTML = '<IMG alt="Cancella" onclick="deleteTableRow(this,'+conta_promozioni+')" src="' + pathImg + 'delete.gif" style="CURSOR: hand">';

    arrayPromozioniAss[conta_promozioni] = 'PROMO-'+codePromozione+'_'+conta_promozioni;
    
    conta_promozioni++;
    
  }else{
    alert('Impossibile associare la promozione selezionata!');
  }
}

function deleteTableRow(object,conta_promozione){
  var i=object.parentNode.parentNode.rowIndex;
  document.getElementById('TableRegole').deleteRow(i);
  delete arrayPromozioniAss[conta_promozione];
  //arrayPromozioniAss.splice(conta_promozione, 1);
}

function deleteTableRowAll(){
  var numeroRighe = document.getElementById('TableRegole').rows.length;
  app = numeroRighe;
  for(i = 0; i < numeroRighe; i++){
    document.getElementById('TableRegole').deleteRow(0);
  }
  
  if(arrayPromozioniAss.length > 0){
    for(i = 0; i<arrayPromozioniAss.length; i++){
      if(arrayPromozioniAss[i] != undefined){
        delete arrayPromozioniAss[i];
      }
    }
  }
}

</SCRIPT>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
  <LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
  <title>

  </title>
</head>
  <body onUnload="removeSessionPromozioni();" onload=vaiAvanti();>
  <div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
    <form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
    </form>
  </div>
  <div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
  </div>

  <div name="maschera" id="maschera">
    <form name="formPag" method="post">
    <input type="hidden" name="conta_righe_prom">
    <input type="hidden" name="userName" value="<%=strUserName%>">
    <input type="hidden" name="code_classe_of" value="">
    <input type="hidden" name="codiceTipoContratto" value="">
      <table align="center" width="95%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td><img src="../../tariffe/images/titoloPagina.gif" alt="" border="0"></td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Listini</td>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                        <img src="../../common/images/body/tre.gif" width="28"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" heigth="100%">
                  <div align="center">
                    <div name="divTabella" id="divTabella">
                    </div>
                    <div name="divIns" id="divIns" style="visibility:hidden;display:none;" >
                      <table width="95%" border="0" cellspacing="0" cellpadding="1" >
                        <tr>
                          <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                              <tr>
                                <td width="49%" class="textB" align="left">&nbsp; Listino </td>
                                <td class="text" align="left" width="100%" colspan="2">
                                  <div name="riepilogoListino" id="riepilogoListino" />
                                </td>
                              </tr>
                              <tr>
                                <td width="49%" class="textB" align="left">&nbsp; Prodotto </td>
                                <td class="text" align="left" width="100%" colspan="2">
                                  <div name="riepilogoPS" id="riepilogoPS"/>
                                </td>
                              </tr>
                              <tr>
                                <td width="49%" class="textB" align="left">&nbsp; Oggetto di fatturazione</td>
                                <td  class="text">&nbsp;</td>
                                <td class="textB" align="left">
                                  <DIV id="causale" >
                                    &nbsp; Causale 
                                  </DIV>
                                </td>
                              </tr>
                              <tr>
                                <td  class="text">&nbsp;
                                  <select class="text" title="Oggetto di Fatturazione" name="comboOggFatt" onchange="onChangeOF();">
                                  </select>
                                </td>
                                <td  class="text">&nbsp;</td>
                                <td  class="text" >&nbsp;
                                  <select id="comboCausale" class="text" name="comboCausale" onchange='onChangeCausale()' >
                                  </select>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
                        <tr>
                          <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                              <tr>
                                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tariffa in vigore</td>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                                  <img src="../../common/images/body/quad_blu.gif"></td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                              <tr>
                                <td colspan='2'>
                                  <div id="divTabellaTariffa" name="divTabellaTariffa">
                                  </div>
                                </td>
                              </tr>
                              <tr>
                                <td colspan='2'>
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                                    <tr>
                                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati inserimento tariffa</td>
                                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <td>
                                  <div id="divCanone" name="divCanone" style="visibility:hidden;display:none">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                                      <tr>
                                        <td width="50%" class="textB" align="left">&nbsp; Tipo importo &nbsp;
                                          <INPUT type="RADIO" name="Tipo_Importo"  value="F" checked onclick="onChangeTipoImporto(false);"/>
                                          Fisso
                                          <INPUT type="RADIO" name="Tipo_Importo"  value="V" onclick="onChangeTipoImporto(true);"/>
                                          Variabile</td>
                                        <td width="50%" class="textB" align="left">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td colspan="2">
                                          <div id="divUnitaDiMisura" name="divUnitaDiMisura" style="visibility:hidden;display:none">
                                            <table>
                                              <tr>
                                                <td width="50%" class="textB" align="left">&nbsp; Unità di misura</td>
                                                <td width="50%" class="text" align="left">&nbsp;
                                                  <select class="text" name="comboUnitaMisura" onchange='onChangeUnitaDiMisura();'>
                                                  </select>
                                                </td>
                                              </tr>
                                            </table>
                                          </div>
                                        </td>
                                      </tr>
                                    </table>
                                  </div>
                                </td>
                              </tr>
                              <tr>
                                <td  class="textB" align="left">&nbsp  </td>
                              </tr>
                              <tr>
                                <td class="textB" align="left">&nbsp; Tipo Inserimento:&nbsp;&nbsp;&nbsp;
                                  <div name='divRepricing' id='divRepricing'>
                                    <INPUT type="RADIO" name="Tipo_Inserimento"  id="Tipo_Inserimento" value="R" onchange='onChangeRepricing(true);'  />
                                    Repricing
                                    <INPUT type="RADIO" name="Tipo_Inserimento" id="Tipo_Inserimento" value="V" onchange='onChangeRepricing(false);' checked />
                                    Normale
                                  </div>
                                  <div name='divNoRepricing' id='divNoRepricing' style="visibility:hidden;display:none;">
                                    &nbsp I Regolamentati non possono effettuare repricing!
                                  </div>
                                </td>
                              </tr>
                              <tr>
                                <td class="textB" align="left">&nbsp  </td>
                              </tr>
                              <tr>
                                <td class="textB" align="left">&nbsp; Descrizione Tariffa</td>
                              </tr>
                              <tr>
                                <td class="text">&nbsp; 
                                  <input type="TEXT" class="text" name="desc_tariffa" id="desc_tariffa" size="100" maxlength ="255" value="">
                                </td>
                              </tr>
                              <tr>
                                <td class="textB" align="left">&nbsp; Descrizione offerta di riferimento</td>
                              </tr>
                              <tr>
                                <td class="text">&nbsp; 
                                  <input type="TEXT" class="text" name="desc_listino_applicato" id="desc_listino_applicato" size="100" maxlength ="512" value="">
                                </td>
                              </tr>
                              
                                  <input type="hidden" class="text" name="desc_listino_applicato_old" id="desc_listino_applicato_old">
                               
                              <tr>
                                <td>
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                                    <tr>
                                      <td align="center" class="textB" class="text">Data inizio validità
                                        <input title="Data inizio" type="text" class="text" size="10" name="data_ini" value="" />
                                        <a href="javascript:showCalendar('formPag.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true">
                                        <img width="24" name='calendario' src="../../common/images/body/calendario.gif" border="no"/></a>
                                        <a href="javascript:cancelCalendar('formPag.data_ini');" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true">
                                        <img width="24" name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a>
                                      </td>
                                      <td  class="textB" align="center" >Importo Tariffa 
                                        <input type="TEXT" class="text" size="10" name="importo_tariffa" maxlength="17"  value=""/>
                                        &nbsp;
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
<!-- PROMOZIONI - INIZIO -->
                              <tr>
                                <td colspan='2'>
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                                    <tr>
                                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Promozioni</td>
                                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr>
                                <td colspan='2' class="textB">Promozioni disponibili&nbsp;
                                  <select class="text" title="Promozioni" name="comboPromozioni">
                                  </select>
                                  <INPUT class="textB" type="button" name="btnAggiungiPromozione" id="btnAggiungiPromozione" value="Aggiungi" onclick="AddPromoOpener()">
                                </td>
                              </tr>
                              <TR>
                                <TD>
                                  <TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <TR bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
                                      <TD class="white" width="46%">
                                        Promozione Associata
                                      </TD>
                                      <TD class="white" bgcolor="<%=StaticContext.bgColorCellaBianca%>" width="8%">
                                        <IMG height=8 alt="immagine " src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif" width=8 >
                                      </TD>
                                    </TR>
                                 </TABLE>
                               </TD>
                              </TR>
                              <tr>
                                <td>
                                  <TABLE width="100%" border="0" cellspacing="1" cellpadding="0" name="TableRegole" id="TableRegole">
                                  </TABLE>
                                </td>
                              </tr>
                              <tr><td>&nbsp;</td></tr>
                              <tr><td>&nbsp;</td></tr>
                              
                   </div> <!-- fine divIns -->
                              
                              
<!-- PROMOZIONI - FINE -->
                              <tr>
                                <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center" >
                                  <sec:ShowButtons VectorName="bottonSp" />
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>

                </td>
              </tr>

            </table>
  </div><!-- fine divCenter -->
  </td>
  </tr>
  <tr>
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td align='center'>
      <table width='100%' align='center'>
        <tr>
          <td align='right'>
            <input type='button' name='btnIndietro' value='<< Indietro' onClick='vaiIndietro();' class='textB'/>
          </td>
          <td align='left'>
            <input type='button' name='btnAvanti' value='Avanti >>' onClick='vaiAvanti();' class='textB'/>
          </td>
        </tr>
      </table>
    </td>
  </tr>

  </TABLE>
  </form>
  </div><!-- fine divMaschera -->
  </body>
  <script>
  var http=getHTTPObject();
  </script>
</html>

