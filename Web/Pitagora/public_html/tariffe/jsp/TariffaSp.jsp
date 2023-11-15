<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Tariffa per tipo contratto")%>
<%=StaticMessages.getMessage(3006,"TariffaSp.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
String codUt=strUserName.getUserName();
String data_ini    ="";
String data_ini_mmdd    = Utility.getDateMMDDYYYY();
String cod_tipo_contr    =request.getParameter("codiceTipoContratto");
String des_tipo_contr=request.getParameter("hidDescTipoContratto");

Vector unitaMisuraV;
String desc_tariffa;
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Inserimento Nuova Tariffa </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/TariffaSp.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
</HEAD>

<BODY onload="setInitialValue();">
<form name="oggFattForm" method="get" action="TariffaSp.jsp">
<input type="hidden" name=cod_PS           id=cod_PS             value= "">
<input type="hidden" name=cod_tipo_contr   id=cod_tipo_contr     value= "<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr    id=des_tipo_contr    value= "<%=des_tipo_contr%>">
<input type="hidden" name=codUt            id=codUt              value= "<%=codUt%>">
<input type="hidden" name=oggFattSelez     id=oggFattSelez       value= "">
<input type="hidden" name=clasOggFattSelez id=clasOggFattSelez   value= "">
<input type="hidden" name=causaleSelez     id=causaleSelez       value= "">
<input type="hidden" name=uniMisSelez      id=uniMisSelez        value= "">
<input type="hidden" name=tipoImpSelez     id=tipoImpSelez       value= "">
<input type="hidden" name=act              id=act                value= "">
<input type="hidden" name=tipoOpzSelez     id=tipoOpzSelez       value= "">
<input type="hidden" name=caricaOpz        id=caricaOpz       value= "">


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Inserimento Nuova Tariffa</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center' bgcolor="<%=StaticContext.bgColorHeader%>"> 
        <tr>
					<td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Oggetto di Fatturazione</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="50%" class="textB" align="left">&nbsp; Tipo contratto:</td>
                      <td width="25%" class="textB" align="left">&nbsp;</td>
                      <td width="25%" class="textB" align="left">&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="50%" class="text"> &nbsp; <%=des_tipo_contr%> </td>
                      <td width="25%" class="textB" align="left">&nbsp;</td>
                      <td width="25%" class="textB" align="left">&nbsp;</td>
                    </tr>
                   <tr>
                      <td colspan='3' width="50%" class="textB" align="left">&nbsp P/S:&nbsp;</td>
                    </tr>
                    <tr>
                      <td  colspan='3'  class="text">
                            &nbsp;&nbsp;<input type="TEXT" class="text" name="des_PS" id= "des_PS" size="70%" value=""> 
                          <input class="text" type="button" name="btnPS" value="..." onclick='selezionaPs();'>&nbsp; 
                       </td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td width="50%" class="textB" align="left">&nbsp; Oggetto di fatturazione</td>
                        <td class="textB" align="left"> 

                           <DIV id="causale" >&nbsp; Causale </DIV>
                        </td>
                    </tr>
                    <tr>    
					           <td  class="text"> &nbsp;
                        <select class="text" title="Oggetto di Fatturazione" name="comboOggFatt" onchange="change_oggFatturazione();">
                              <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                                <option value="-2"></option>
                                <option value="-3">&nbsp;</option>
                                <option value="-4">&nbsp;</option>
                                <option value="-5">&nbsp;</option>
                                <option value="-6">&nbsp;</option>
                                <option value="-7">&nbsp;</option>
                                <option value="-8">&nbsp;</option>
                                <option value="-9">&nbsp;</option>
                                <option value="-10">&nbsp;</option>
                          </select>
                        </td>
                        <td  class="text"> &nbsp;
                          <select id="comboCausale" class="text" name="comboCausale" onchange='abilitaCampiResidui()'>
                                <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                                <option value="-2"></option>
                                <option value="-3">&nbsp;</option>
                                <option value="-4">&nbsp;</option>
                                <option value="-5">&nbsp;</option>
                                <option value="-6">&nbsp;</option>
                                <option value="-7">&nbsp;</option>
                                <option value="-8">&nbsp;</option>
                                <option value="-9">&nbsp;</option>
                                <option value="-10">&nbsp;</option>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tariffa</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                         <tr>
                           <td width="50%" class="textB" align="left">&nbsp;</td>
                           <td width="50%" class="textB" align="left">&nbsp; Unità di misura</td>
                         </tr>
                         <tr>
                           <td width="50%" class="textB" align="left">&nbsp; Tipo importo &nbsp;
                              <INPUT type="RADIO" name="Tipo_Importo"  value="F" checked onclick="disattivaComboUnitaMisura();"> Fisso
                              <INPUT type="RADIO" name="Tipo_Importo"  value="V" onclick="attivaComboUnitaMisura();"> Variabile
                           </td>
                           <td width="50%" class="text" align="left"> &nbsp;
                             <select class="text" name="comboUnitaMisura" onchange='catturaItemUnitaMisura();'>
                               <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                                <option value="-2">&nbsp;</option>
                                <option value="-3">&nbsp;</option>
                                <option value="-4">&nbsp;</option>
                                <option value="-5">&nbsp;</option>
                                <option value="-6">&nbsp;</option>
                                <option value="-7">&nbsp;</option>
                                <option value="-8">&nbsp;</option>
                                <option value="-9">&nbsp;</option>
                                <option value="-10">&nbsp;</option>
                          </select>                           
                           </td>
                         
                        </tr>
                       </table>
                     </td>
                   </tr>
                   <!--
                   <tr> 
                     <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                           <tr>
                              <td width="25%" class="textB" align="left">&nbsp; Codice Classe di Sconto</td>
                              <td width="30%" class="textB" align="left">&nbsp; Minimo Classe Sconto</td>
                              <td width="30%" class="textB" align="left">&nbsp; Massimo Classe Sconto</td>
                              <td width="5%"  class="textB" align="left">&nbsp;</td>
                              <td width="10%" class="textB" align="left">&nbsp;</td>
                            </tr>
                            <tr>
                              <td width="25%" class="text"> &nbsp;
                               <select class="text" name="comboClasseSconto">
                                <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(2)%></option>
                               </select>
                               <Script language="javascript"> Disable(document.oggFattForm.comboClasseSconto);</Script>
                              </td>
                              <td width="30%"> &nbsp;<input name="scontoA" type=text class="text" size=25> </td>  
                              <Script language="javascript"> Disable(document.oggFattForm.scontoA);</Script>
                              <td width="30%"> &nbsp;<input name="scontoB" type=text class="text" size=25> </td>  
                              <Script language="javascript"> Disable(document.oggFattForm.scontoB);</Script>
                              <td width="5%"> <input type="checkbox" name="Sconto" align="left" ></td>
                              <Script language="javascript"> Disable(document.oggFattForm.Sconto);</Script>
                              <td width="10%" class="textB" align="left">&nbsp;</td>
                            </tr>
                            <% for (int i=0; i<3; i++)
                            { %>
                            <tr>
                              <td>&nbsp;</td>
                              <td> &nbsp;<input name=scontoC<%=i%> type=text class="text" size=25 > </td>   
                              <Script language="javascript"> Disable(document.oggFattForm.scontoC<%=i%>);</Script>
                              <td> &nbsp;<input name=scontoD<%=i%> type=text class="text" size=25 > </td>    
                              <Script language="javascript"> Disable(document.oggFattForm.scontoD<%=i%>);</Script>
                              <td> <input type="checkbox" name=ScontoE<%=i%> align="left"></td>
                              <Script language="javascript"> Disable(document.oggFattForm.ScontoE<%=i%>);</Script>
                              <td>&nbsp;</td>
                            </tr>
                            <% } %>
                       </table>
                    </td> 
                   </tr>  
                   !-->
                  <tr>
                      <td  class="textB" align="left">  &nbsp; Descrizione Tariffa</td>
                  </tr>
                  <tr>
                       <td   class="text"> &nbsp; <input type="TEXT" class="text" name="desc_tariffa" id="desc_tariffa" size="100" maxlength ="255" value=""></td>
                   </tr>
                   <tr>
                      <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                             <tr>
                               <td align="center" class="textB" class="text"> Data inizio validità
                                    <input title="Data inizio" type="text" class="text" size="10" name="data_ini" value="" onblur="handleblur('data_ini');"> 
                                    <a href="javascript:showCalendar('oggFattForm.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img width=24 name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                                    <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img width=24 name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                               </td>
                               <td  class="textB" align="center" > Importo Tariffa <input type="TEXT" class="text" size="10" name="importo_tariffa" maxlength="17"  value="">&nbsp;</td>
                             </tr>
                             <tr>
                                 <td  class="text" style="display:none"> &nbsp;
                                     <select class="text" title="Opzioni Tariffa" name="comboOpzioniTariffa" onchange="change_opzTariffa();">
                                         <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(2)%></option>
                                         <option value="-2"></option>
                                         <option value="-3">&nbsp;</option>
                                         <option value="-4">&nbsp;</option>
                                         <option value="-5">&nbsp;</option>
                                         <option value="-6">&nbsp;</option>
                                         <option value="-7">&nbsp;</option>
                                         <option value="-8">&nbsp;</option>
                                         <option value="-9">&nbsp;</option>
                                         <option value="-10">&nbsp;</option>
                                     </select>
                                </td>
                             </tr>
                       </table>
                    </td>
                   </tr>
                </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
    <tr> 
     <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
    </tr>
  <tr> 
     <td>  
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'> 
            <tr> <td colspan=5>  <sec:ShowButtons VectorName="vectorButton" />  </td> </tr>
        </table> 
     </td>
  </tr>
  </td> </tr>
  </table>
 </FORM>
</BODY>
</HTML>
