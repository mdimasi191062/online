<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottoni" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">

<%=StaticMessages.getMessage(3006,"NuovaCol.jsp")%>
</logtag:logData>


<%
String cod_tipo_col ="1";
String cod_tipo_contr ="12";
String act="insert";
int size=0;

String data_ini_mmdd =  Utility.getDateMMDDYYYY();
String data_ini_ddmm =  Utility.getDateDDMMYYYY();
String data_ini      = request.getParameter("data_ini");
if (data_ini==null) data_ini="";

//Inserimento istruzioni per la paginazione inizio
// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if ((strIndex!=null)&&(!(strIndex.equals(""))))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }

// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if ((strNumRec!=null)&&(!(strNumRec.equals(""))))
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");

if ((strtypeLoad!=null)&&!(strtypeLoad.equals("")))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
//Inserimento istruzione per la paginazione fine

// Vettore contenente risultati query per il caricamento della della combo contratti e della lista
Collection prodServ=null;
Vector utr=null;
Vector account=null;
Collection tariffe=null;
%>
<EJB:useHome id="homeUnTerRete"     type="com.ejbSTL.UnTerReteSTLHome"       location="UnTerReteSTL" />
<EJB:useHome id="homeElencoAccount" type="com.ejbSTL.ElencoAccountPsSTLHome" location="ElencoAccountPsSTL" /> 
<EJB:useHome id="homeProdServ"      type="com.ejbSTL.ProdServSTLHome"        location="ProdServSTL" />
<EJB:useBean id="remoteProdServ" type="com.ejbSTL.ProdServSTL" value="<%=homeProdServ.create()%>" scope="session"></EJB:useBean>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Inserimento sito di colocation all'interno dell'edificio di centrale </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/NuovaCol.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>


function handle_conferma()
{
 if (document.account.msg.value=="")
  {
    if (window.confirm("Si conferma l'inserimento dei dati Contrattuali Attivazione Sito?"))
    
      {
        Enable(document.account.data_ini);
        document.account.action='<%=request.getContextPath()%>/servlet/ColocationCNTL';
        document.account.submit();
      }
  }  
 else
  {
    if (document.account.msg.value=='no_elab')
        alert("Attenzione! Impossibile proseguire a causa della presenza di elaborazioni batch in corso.");
    if (document.account.msg.value=='no_data')
        alert("La data di consegna del sito, deve essere maggiore o uguale\ralla data di inizio validità dell'account."); //ossia: "+document.account.dataIniValAcc.value+".");
    if (document.account.msg.value=='no_acc_sito') 
       alert("L'account è già presente per il sito.");
    document.account.msg.value="";       
  }
}

</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">
<%
    //utr è messo in sessione dal pannello chiamante
     //utr = (Vector) session.getAttribute("utr");
     //if ((utr==null))
     //{  
          UnTerReteSTL remoteUnTerRete= homeUnTerRete.create();
          utr=remoteUnTerRete.getUTR();
          /*if (utr!=null)
          {
           session.setAttribute("utr", utr);
          } 
     }*/

   if(cod_tipo_contr!=null)
   {
      ElencoAccountPsSTL remoteElencoAccount=homeElencoAccount.create();
      account=remoteElencoAccount.getAccCol(cod_tipo_contr);
   }   
             
//  if ((typeLoad!=0)||(prodServ!=null))
//   {
//     prodServ = (Collection) session.getAttribute("prodServ");
//   }
//   else
//   {
      prodServ = remoteProdServ.getPsUm(cod_tipo_col);
//       if (prodServ!=null)
//          session.setAttribute("prodServ", prodServ);
//   }
 %>


<FORM name="account" method="get" action="NuovaCol.jsp">
<input type="hidden" name=utrSelez        id= utrSelez       value= "">
<input type="hidden" name=sitoSelez       id= sitoSelez      value= "">
<input type="hidden" name=accountSelez1   id= accountSelez1  value= "">
<input type="hidden" name=data_ini_ddmm   id=data_ini_ddmm   value= <%=data_ini_ddmm%>>
<input type="hidden" name=act             id=act             value= <%=act%>>
<input type="hidden" name=msg             id=msg             value= "">
<input type="hidden" name=size            id=size            value= "">
<!--input type="hidden" name=dataIniValAcc id=dataIniValAcc value= ""-->

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/colocation.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Inserimento Dati Contrattuali Attivazione Sito</td>
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
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td   width="50%" class="textB" align="left">&nbsp;&nbsp;U.T.R.:&nbsp;</td>
                      <td   width="50%" class="textB" align="left">&nbsp;Sito:&nbsp;</td>
                      <td >  &nbsp; </td>
                    </tr>
                     <tr>
                    <%
                    if ((utr==null)||(utr.size()==0))
                    {
                    %>
                      <td  width="50%" class="text">
							          &nbsp;<select class="text" title="utr" name="utr" >
					                      <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
      					              </select>
                      </td>
                      <Script language="javascript"> Disable(document.account.utr); </Script>
                    <%}
                      else
                      {
                      %>
                      <td  width="50%" class="text">
                          &nbsp;<select class="text" title="utr" name="utr" onchange='changeUTR()'>
                                  <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                               <%
                                Object[] objs=utr.toArray();
                                for (Enumeration e = utr.elements();e.hasMoreElements();)
                                {
                                  UnTerReteElem elem2=new UnTerReteElem();
                                  elem2=(UnTerReteElem)e.nextElement();
                                  String selez="";
                                    %>
                                     <option value="<%=elem2.getCodeUTR()%>"><%=elem2.getCodeUTR()%></option>
                                    <%
                                  }//for
                               %> 
                               </select>
                            </td>   
                      <%}//else%>
                         <td  width="50%" class="text">
                            <select class="text" title="sito" name="sito" onchange="changeSito();">
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
                             <Script language="javascript"> Disable(document.account.sito); </Script>
                         </td>
                         <td>
						               &nbsp;
						             </td>
                      <tr>
                        <td colspan='3'>
						              &nbsp;
						            </td>
                      </tr>
                     </tr>
                     </table>

                <!--a combo account-->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    
                    <tr>
                      <td   width="50%" class="textB" align="left">&nbsp;&nbsp;Account:&nbsp;</td>
                      <td   width="50%"> &nbsp;</td>
                    </tr>
                       <%
                        if ((account!=null)&&(account.size()!=0))
                        {
                        
                        %>
                         <td  width="50%" class="text">
                          &nbsp;<select class="text" title="account" name="account" onchange="changeAccount()">
                               <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                              <%
                                Object[] objs=account.toArray();
                                for (Enumeration e = account.elements();e.hasMoreElements();)
                                {
                                  ClassElencoAccountPsElem elem2=new ClassElencoAccountPsElem();
                                  elem2=(ClassElencoAccountPsElem)e.nextElement();
                                  String selez="";
                                    %>
                                     <option value="<%=elem2.getCodeAccountPs()%>" name="<%=elem2.getDescAccountPs()%>"> <%=elem2.getDescAccountPs()%></option>
                                    <%
                                  }//for
                               %> 
                               </select>
                               <%
                               //da qui
                              }//if (account!=null)&&(account.size()!=0)
                            %>
                            </td>   
                      <%//}//else%>
                      <td>
						            &nbsp;
						          </td>
                      <tr>
                      <td colspan='2'>
						            &nbsp;
						          </td>
                      </tr>
                     </tr>
                </table> 
              <!--a combo account fine-->
              <!--b text field editabili-->
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td   width="35%" class="textB" align="left">&nbsp;Data di consegna del sito:</td>
                      <td   width="35%" class="textB" align="left">&nbsp;Numero moduli ULL:</td>
                      <td   width="30%" class="textB" align="left">&nbsp;Numero moduli ITC:</td>
                    </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td  width="35%" align="left" class="text">
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                            <tr align="left">
                              <td align="left" class="text">
                                &nbsp; <input class="text" title="Data inizio" type="text" size="10" maxlength="10" name="data_ini" value="<%=data_ini%>"> 
                              <!--/td-->  
                              <!--td width="50%" align="left" class="text"-->
                                &nbsp;<a href="javascript:showCalendar('account.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                                      <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                              </td>
                            </tr>  
                        </table>
                      </td>
                      <td width="35%" class="text" align="left">
                       &nbsp;<input type="TEXTNumber" class="text" name="mod_ull" id= "mod_ull" maxlength="3" size="15%" value="" > 
                      </td>
                      <td width="30%" class="text" align="left">
                       &nbsp;<input type="TEXTnumber" class="text" name="mod_itc" id= "mod_itc" maxlength="3" size="15%" value="" > 
                      </td>
                    </tr>
              </table>

              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td   width="35%" class="textB" align="left">&nbsp;Importo annuale fitto:</td>
                      <td   width="60%" class="textB" align="left">&nbsp;Importo annuale consulenza per security:</td>
                      <td   width="5%" class="textB" align="left">&nbsp;</td>
                    </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td width="35%" class="text" align="left">
                       &nbsp;<input type="TEXT" class="text" name="imp_tar" id= "imp_tar" maxlength="17" size="15%" value="" > 
                      </td>
                      <td width="60%" class="text" align="left">
                       &nbsp;<input type="TEXT"  class="text" name="imp_cons" id= "imp_cons" maxlength="17" size="15%" value="" > 
                      </td>
                      <td width="5%" class="textB" align="left">
                       &nbsp;
                      </td>
                    </tr>
              </table>
              
            <!--bi textfields editabili fine-->
            <input class="textB" type="hidden" name="typeLoad" value="">
            <input class="textB" type="hidden" name="txtnumRec" value="">
            <input class="textB" type="hidden" name="txtnumPag" value="1">
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
           <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
         </tr>
       </table>
              
			</td>
    </tr>
      <tr>
       <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
      <%
//**************************CARICAMENTO LISTA***********************
      %>
     <tr>
  	  <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                    <td  bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;</td>
                    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
       <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/body/pixel.gif" width="1" height='2'></td>
              </tr>
            <%
               
               if ((prodServ==null)||(prodServ.size()==0))
               {
%>         
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
              </tr>
<%              
               }else 
               {
               
%>
                 <tr>
                    <td bgcolor='<%=StaticContext.bgColorCellaBianca%>'    class='white' width='2%' >&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB' width='87%'>Prodotti e Servizi</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class="white" width='2%' >&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB' width='9%'> Quantità</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='white' width='2%'> &nbsp;</td>
                 </tr>
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=prodServ.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
<%
               
                String bgcolor="";
                String checked;  
                Object[] objs=prodServ.toArray();

                  size=prodServ.size();
                  for (int i=0;i<prodServ.size();i++)
                {
                    ProdServElem obj=(ProdServElem)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

%>

                      <tr>                                                                                                      
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"              width='2%'> &nbsp; </td>
                        <td bgcolor='<%=bgcolor%>' name='umps' class='text' align="left" width='87%'><%=obj.getDescPs()%>
                           <input type="hidden" name="codePs" id= "codePs" size="4%" maxlength="5" value="<%=obj.getCodePs()%>" >
                           <input type="hidden" name="descPs" id= "descPs" size="4%" maxlength="5" value="<%=obj.getDescPs()%>" >
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text' width='2%'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' class='text' align="left" width='9%'>
                          <%if (!obj.getCodePs().equalsIgnoreCase("8021")) //Non è Punti di Segnalazione 
                          {%>
                             <input type="TEXT" class='text' name="qta" id= "qta" size="9%" maxlength="9" value=""> 
                          <%}
                          else
                          {%>
                             <input type="TEXT" class='text' name="qta" id= "qta" size="5%" maxlength="5" value=""> 
                         <%}%>   
                        </td>
                       <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='white' width='2%'> &nbsp;</td> 
                      </tr>
<%    
                    }//for
%>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="3" height='2'></td>
                    </tr>
                </pg:pager>
                <tr>
                  <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
             </table>
          </td>
        </tr>
<%
 }//else (se prodServ è pieno)   
%>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=4 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
</table>

    <tr> 
     <td>  
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'> 
  <tr>
    <td colspan=4>
        <sec:ShowButtons VectorName="bottoni" />
    </td>
   </tr>
</td>
   </tr>
  </table>
    </td>
   </tr>
  </table>
 </FORM>
</BODY>
</HTML>
