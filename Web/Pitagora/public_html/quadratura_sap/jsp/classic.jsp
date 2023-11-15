<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<%@ page import="javax.ejb.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth  RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"classic.jsp")%>
</logtag:logData>

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>

<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    

  DB_QuadratureSap remote = null;      
  String ciclo = request.getParameter("ciclo");
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bgcolor="";
    //Flag per individuare se una riga é selezionata

  int i=0;
  int j=0;
  int iPagina=0;  

    Vector aRemote2 = null;

    String strTipoExport =  Misc.nh(request.getParameter("strTipoExport"));
    String strCicloVal =  Misc.nh(request.getParameter("strCicloVal"));
    

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
 
    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null && !"".equals(strIndex))
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }  

//Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session

  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
  {
    aRemote2 = (Vector)session.getAttribute("aRemote2");
  }
  else
  {
      
    /*if ( strCodeServizio != null && !"".equals(strCodeServizio)) 
        aRemote2=remoteEstrazioniConfSTL.getEstrazioniConsistenzeAttive(strCodeServizio,strDataCompDa,strDataCompA,strCodeAccount,strCodeProdotto);
      */  
      if ( strCicloVal != null && !"".equals(strCicloVal)) 
            aRemote2=remoteCtr_Utility.getQuadratureSapClassic(strTipoExport,strCicloVal);
    session.setAttribute( "aRemote2", aRemote2);  

  }
  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  



%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">

function exportCsv(typeExport){

 
  openDialog("stampa_quadratSapCl.jsp", 30, 50, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
}


	function resetTxtCiclo(){

        if (document.frmSearch.chkTuttiCicli.checked) {
        
        document.frmSearch.ciclo.value = " ";
        document.frmSearch.ciclo.disabled = true;

        }
        else{
        document.frmSearch.ciclo.disabled = false;
         
        }
        }
	function validaciclo(){
		var mese = parseFloat (document.frmSearch.ciclo.value.substring(0,2));
		var anno = parseFloat (document.frmSearch.ciclo.value.substring(2,6));
		var annocorrente = new Date().getFullYear();
        if (mese.length == 1) {
			mese = "0" + mese;
			}

		if (isNaN(mese)) {
			alert("Errore Ciclo di Valorizzazione - Mese non numerico");
                        document.frmSearch.ciclo.focus();
                        return true;
			} else if (isNaN(anno)) {
				alert("Ciclo di Valorizzazione - Anno non numerico");
                                document.frmSearch.ciclo.focus();
                                return true;
				} else if ((mese <"1") || (mese>"12")) {
                                        document.frmSearch.ciclo.focus();
					alert("Ciclo di Valorizzazione - Valore Mese errato :" + mese);
                                        return true;
					} else if (anno > annocorrente) {
                                                document.frmSearch.ciclo.focus();
						alert("Ciclo di Valorizzazione - Valore anno maggiore anno corrente : " + anno);
                                                return true;
						} else 
                                                                {
                                                                return false;
                                                                }
	}


function enableEsporta() {

<%
if ( aRemote2 != null && aRemote2.size() > 0 ) {
%>
    Enable(frmSearch.Esporta);
<% } else { %>
        Disable(frmSearch.Esporta);
<%   } %>

}


function ONSTAMPA()
{
  var W=800;
  var H=600;
  openDialog("stampa_fascia_cl.jsp", 800, 600, "","print");  
}

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
var ret = false;
    if (!document.frmSearch.chkTuttiCicli.checked) {
    ret = validaciclo();  
    
    document.frmSearch.strCicloVal.value="01"+document.frmSearch.ciclo.value;

    }
    else
    {
    document.frmSearch.strCicloVal.value="Tutti";
    }
     if (!ret){

        for (var i=0; i<document.frmSearch.optTipoExport.length; i++)
        {
            if(document.frmSearch.optTipoExport[i].checked)
            {
                document.frmSearch.strTipoExport.value=document.frmSearch.optTipoExport[i].value;
            }
        }

       if ((document.frmSearch.strCicloVal.value == "Tutti") &&
          (document.frmSearch.strTipoExport.value == "S" || document.frmSearch.strTipoExport.value == "T"))
          {
            alert('Attenzione: per la tipologia di Export selezionata è necessario selezionare un solo ciclo di valorizzazione');
          }
          else 
          {   
   
            document.frmSearch.txtTypeLoad.value=typeLoad;
              
              orologio.style.visibility='visible';
              orologio.style.display='inline'  
          
              maschera.style.visibility='hidden';
              maschera.style.display='none'  
              document.frmSearch.ciclo.value = " ";
        
              document.frmSearch.submit();
           }
      }
}  

function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}


  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none'  
}

</SCRIPT>


<TITLE>Selezione Fascia</TITLE>

</HEAD>
<BODY onload="setnumRec();inizializza();" onfocus="enableEsporta();" >


<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">
  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="classic.jsp">
<input type=hidden name="strTipoExport" value="<%=strTipoExport%>">
<input type=hidden name="strCicloVal" value="<%=strCicloVal%>">


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloClassic.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
        <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Quadratura SAP Classic</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
                  </tr>
              </table>
            </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                    <td width="30%" class="textB" align="right"></td>
                    </tr>
                    <tr>
                           <td width="30%" class="textB" align="right">Selezionare il ciclo di valorizzazione/repricing:&nbsp;</td>
                           <td width="50%" class="text">
                              <input type='checkbox' id='chkTuttiCicli' name='chkTuttiCicli' value='Tutti' onclick ="resetTxtCiclo();" checked onfocus="enableEsporta();"> Tutti i cicli
                           </TD>
                     </tr>
                     <tr>
                     <td width="30%" class="textB" align="right"></td>
                             <td width="50%" class="text">
                              <input type="text" name="ciclo" size="8" maxlength="6" onfocus="enableEsporta();"   disabled value=<%if (ciclo != null) {%><%=ciclo%><%}%>> Digitare il ciclo formato MMYYYY
                            </TD>
                    </tr>
                    <tr>
                    <td width="30%" class="textB" align="right"></td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                           <td width="30%" class="textB" align="right">Selezionare la tipologia di export:&nbsp;</td>
                           <td width="50%" class="text">
                              <INPUT  type="radio" id='optTipoExport' name='optTipoExport' value='S' checked >Ordini di vendita riscontrati             
                            </TD>
                     </tr>
                     <tr>
                     <td width="30%" class="textB" align="right"></td>
                             <td width="50%" class="text">
                              <INPUT  type="radio" id='optTipoExport' name='optTipoExport' value='N'  >Ordini di vendita non riscontrati
                            </TD>
                    </tr>
                     <tr>
                            <td width="30%" class="textB" align="right"></td>
                             <td width="50%" class="text">
                              <INPUT  type="radio" id='optTipoExport' name='optTipoExport' value='T'  >Tutti gli ordini di vendita
                            </TD>
                    </tr>
                    
                    <tr>
                      <td width="30%" class="textB" align="right"></td>
                      <td  width="50%" class="text"></td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
                        <input disabled class="textB" type="button" name="Esporta" value="Esporta" onclick="exportCsv('0');">
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    <tr>
                      <td width="30%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  width="40%" class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='cbn1_dis_fascia_cl.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote2==null)||(aRemote2.size()==0)){
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                          <td bgcolor='white' class="textB" width="0%">&nbsp;</td>      
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Ciclo di Valorizzazione / Repricing</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Codice Account</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Desc Account</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Tipo Documento</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Id Richiesta</td>                         
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Riscontrato</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="4%">Flag Repricing/Valorizzazione</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Data Emis</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Data Acquisizione Riscontro</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Data Scadenza</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Num. Doc.</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Num. Doc. FI</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Imponibile</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Imponibile Iva</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Esercizio</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">Flusso SAP ORIGINE</td>
                          <td bgcolor='#D5DDF1' class="textB" width="8%">NR_FATT_RIF</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote2.size()%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="strTipoExport" value="<%=strTipoExport%>"></pg:param>
<pg:param name="strCicloVal" value="<%=strCicloVal%>"></pg:param>

<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote2.size()) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (DB_QuadratureSap) aRemote2.elementAt(j);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

%>
                        <TR>
                           <td bgcolor='white'></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_DI_VALORIZZAZIONE() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getCODE_ACCOUNT() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDESC_ACCOUNT() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getTIPO_DOCUMENTO() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getID_RICHIESTA() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getFLAG_RISCONTRO_SAP() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getFLAG_REPRICING() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_EMISSIONE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_ELABORAZIONE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getDATA_SCADENZA() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getNR_FATTURA_SD() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getNR_DOC_FI() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getIMPORTO_FATTURA() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getIMPORTO_IVA() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getESERCIZIO() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getFLUSSO_SAP_ORIGINE() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getNR_FATT_RIF() %></TD>
                        </tr>
                        <tr>
                          <td  bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
                        </tr>

<%
          i+=1;
        }
%>        
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="27" class="text" align="center">
                          Risultati Pag.
                          <pg:prev> 
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                          </pg:prev>
<pg:pages>
<% 
    if (pageNumber == pagerPageNumber) 
    {
%>
                            <b><%= pageNumber %></b>&nbsp;

<% 
    }
    else
    {
%>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
<%
    } 
%>
</pg:pages>
                          <pg:next>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>
                          </td>
                        </tr>
</pg:index>
</pg:pager>
<%
}
%>
                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
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
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</div>
</BODY>
<script>
var http=getHTTPObject();
</script>
</HTML>
