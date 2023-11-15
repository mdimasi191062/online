<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="VIS_STORICO_CODE_ISTANZA_PROD"/>
<%--<sec:ChkUserAuth />--%>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"vis_storico_code_istanza_prod.jsp")%>
</logtag:logData>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<title></title>
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
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_EVENTI_JS%>generatoreEventi.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
</head>
<BODY  onfocus="ControllaFinestra()" onmouseover=" ControllaFinestra()">
<%
	
	/* MA*/
  String sistema_mittente="";
	/* FINE MA */  

  String srcIdEvento = Misc.nh(request.getParameter("srcIdEvento"));
  
  //String srcIdEvento = "";
  session.setAttribute("hidTypeLoadProd", "0");
  session.setAttribute("hidTypeLoadCompo", "0");
  session.setAttribute("hidTypeLoadPP", "0");
  session.setAttribute("hidTypeLoadMP", "0");
  session.setAttribute("hidTypeLoadRPVD", "0");
  session.setAttribute("hidTypeLoadATM", "0");
  session.setAttribute("ableCreaEvento", "0");
  
  session.setAttribute("parsrcDescSede1","0");
  
  session.setAttribute("elemNonModif","0");
  
 
  DataFormat dataOdierna = new DataFormat();
%>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
  var objWindows = null;
var noteRet= null;
  var dialogWin = new Object();
 	function Initialize(){
//alert ('Initialize');
    if (frmSearch.cmdDate.value == '+'){
  
 }
   
	}
  
  function controllaSuperRipristino() 
  {
  //   alert('controllaSuperRipristino');
    carica = function(dati){ONRITORNO(dati[0].messaggio);};
    errore = function(dati){ONRITORNO(dati[0].messaggio);};  
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
   
  // alert('<%=(String)session.getAttribute("hidsrcIdEvento")%>');
    chiamaRichiesta('srcIstanzaProd='+document.frmSearch.srcIstanzaProd.value+'&srcIdEvento='+document.frmSearch.srcIdEvento.value+'@'+document.frmSearch.srcIdEventoIniziale.value,'CheckRettificaSuperRipr',asyncFunz);
   //alert('controllaSuperRipristino');
  }
  
    function ONRITORNO(messaggio){
         if (messaggio == '2') {    
              alert("Attenzione! L'evento è stato oggetto di un super-ripristino.");
          }    
          if (messaggio == '3') {    
              alert("Attenzione! L'evento è un super-ripristino.");
          }  
          
          if (messaggio == '4') {    
              alert("Attenzione! L'evento è una rettifica.");
          }   

          if (messaggio == '1') {    
          
              if (confirm("Attenzione! Proseguendo verranno eliminate le modifiche oggetto della precedente rettifica. Proseguire?")){
                     
                     dialogWin.returnFunc = ONCHIUDI();    
                     //URL = 'crea_ripristino.jsp?IdEvento=' + frmSearch.srcIdEvento.value + '&DataElab=' + frmSearch.strDataElaborazione.value ;
                     URL = 'crea_ripristino.jsp?IdEvento=' + frmSearch.srcIdEvento.value + '&DataElab=' + frmSearch.strDataElaborazione.value + '&srcIstanzaProd=' + frmSearch.srcIstanzaProd.value+ '&sistema_mittente=' + frmSearch.sistema_mittente.value;
                     dialogWin.win = openCentral(URL,'CreaEvento','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);
              }
          } 
         if (messaggio == '0') {      

                   dialogWin.returnFunc = ONCHIUDI();    
                 //URL = 'crea_ripristino.jsp?IdEvento=' + frmSearch.srcIdEvento.value + '&DataElab=' + frmSearch.strDataElaborazione.value ;
                 URL = 'crea_ripristino.jsp?IdEvento=' + frmSearch.srcIdEvento.value + '&DataElab=' + frmSearch.strDataElaborazione.value + '&srcIstanzaProd=' + frmSearch.srcIstanzaProd.value+ '&sistema_mittente=' + frmSearch.sistema_mittente.value;
                 dialogWin.win = openCentral(URL,'CreaEvento','directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no',600,400);
         }
  }
  
  function ONCREAEVENTOLocal(strIdEventoIniziale,all_eventi){
  //   alert('ONCREAEVENTOLocal');
 /*  
  var lArr_GlobalString = all_eventi.split("@");
	var lbln_Esito=false;
  for(i=0;i<lArr_GlobalString.length;i++){
		if(lArr_GlobalString[i]==strIdEventoIniziale){
			lbln_Esito=true;//trovata etichetta da cancellare
		}
	}
  if (lbln_Esito==false) {
       alert('ID Evento non tra i selezionabili.');
        return;
  }
   
  */    var URL='';
      if(frmSearch.msg.value != ''){
            alert(frmSearch.msg.value);
            return;
      }
      if(frmSearch.srcIdEvento.value==''){
            alert('Occorre Inserire un Identificativo Di Evento.');
            frmSearch.srcIdEvento.focus();
            return;
      }
      if(frmSearch.strDataElaborazione.value==''){
            alert('Occorre Specificare la data di elaborazione.');
            frmSearch.strDataElaborazione.focus();
            return;
      }
  //   alert(strIdEventoIniziale);
       inserisciNote();
        controllaSuperRipristino(); 
      
           
 
  }

 function OnMostraNascondiDATE(){ 
 if (frmSearch.cmdDate.value == '+'){
   MostraColonna('Dati','Data Ric. Ordine')
   MostraColonna('Dati','Data Rich. Cess.');
   MostraColonna('Dati','Data Eff. Evento');
   frmSearch.cmdDate.value = '-';
 }else{  
    NascondiColonna('Dati','Data Ric. Ordine');
   NascondiColonna('Dati','Data Rich. Cess.');
   NascondiColonna('Dati','Data Eff. Evento');
   frmSearch.cmdDate.value = '+';

  } 
   
}
function OnRettifica(){
    URL = 'istanza_dettaglio_prodotto.jsp?Istanza=' + frmSearch.srcIstanzaProd.value + '&aggiorna=1';
    //alert (URL);
      objWindows = window.open(URL,'_new','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
  }
  function ONCHIUDI(){
    location.replace('ripristina_inventario.jsp');
  }


function NascondiColonna(IDtabella,voce){
ModificaColonna(IDtabella,voce,"none");
}

function MostraColonna(IDtabella,voce){
ModificaColonna(IDtabella,voce,"");
}

function ModificaColonna(IDtabella,voce,display){
ths=document.getElementById(IDtabella).tHead.rows[0].cells;
for(i=0;i<ths.length;i++){
    htext=ths[i].firstChild.nodeValue;
    if(htext==voce)
        colonna=i;
    }
if(colonna>=ths.length) return;
ths[colonna].style.display=display;
trs=document.getElementById(IDtabella).tBodies[0].rows;
for(i=0;i<trs.length;i++){
    tds=trs[i].cells;
    tds[colonna].style.display=display;
    }
}

function Ripristina(IDtabella){
var trs=document.getElementById(IDtabella).tHead.rows;
ths=trs[0].cells;
for(i=0;i<ths.length;i++) ths[i].style.display="";
trs=document.getElementById(IDtabella).tBodies[0].rows;
for(i=0;i<trs.length;i++){
    tds=trs[i].cells;
    for(j=0;j<tds.length;+j++)
        tds[j].style.display="";
    }
} 

function CallAlert()
{
 //alert("This is parent window's alert function.");
 self.location.reload();
}
function passaNote(nota)
{
 //alert("This is parent window's alert function.");
noteRet= nota;
}
</SCRIPT>

  <EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
  <EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
  <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
  </EJB:useBean>

<%
  //out.flush();
  String srcIstanzaProd = Misc.nh(request.getParameter("srcIstanzaProd"));
  Vector vctStorico = remoteEnt_Inventari.getStoricoCodeIstanzaProdXRipr(srcIstanzaProd);
  DB_StoricoCodeIstanzaProd storico = null;
  String strNameFirstPage = "vis_storico_code_istanza_prod.jsp?srcIstanzaProd=" + srcIstanzaProd;
  String strtypeLoad = request.getParameter("hidTypeLoad");
  int intRecXPag = 300;
  String id_evento = "";
  String all_eventi="";
  if (request.getParameter("cboNumRecXPag")!=null)
    intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
  
%>

  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="../images/GeneratoreEventi.gif" alt="" border="0"></td>
    </tr>
  </table>
  <BR>
  	<!--TITOLO PAGINA-->
  <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
    <tr>
      <td>
        <table width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
          <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">RIPRISTINA RETTIFICA INVENTARIO</td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>

<div name="orologio" id="orologio"  style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>


<form name="frmSearch" onsubmit="submitfrmSearch('0');return false" method="post" action="ripristina_inventario.jsp">
  <!-- ELENCO STORICO EVENTI -->
  <table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr height="20">
      <td>
        <table>
          <tr>
            <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
            <td  class="text">
              <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>')">
              <%for(int k = 300;k >= 50; k=k-50){%>
                <option class="text" value="<%=k%>"><%=k%></option>
              <%}%>
              </select>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr height="20">
      <td>
        <table width="100%" border="1" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" bordercolor="<%=StaticContext.bgColorHeader%>">
          <tr>
            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">
              Elenco Storico 
            </td>
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr height="20">
     <td>
          <input class="text" title="Visualizza Date" type="button" maxlength="30" name="cmdDate" value="+" onClick="OnMostraNascondiDATE();">
      </td>
    </tr>
    <TR valign="top">
      <TD>
        <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=vctStorico.size()%>">
    <!--   <div style="width: 800px; overflow: hidden;  border: 0; ">-->
        <table name ="Dati" id="Dati" cellspacing="1" align="center">
          <%
          int ritorno = 0;
             String appo_DATA_RIC_CESS = "          ";
          if(vctStorico.size()!=0){
            storico = (DB_StoricoCodeIstanzaProd)vctStorico.get(0);
            if (storico.getCODE_ISTANZA_PROD().equals("")&&
                storico.getCODE_ISTANZA_COMPO().equals("")
               ){
              ritorno = 1;
            }else{
              ritorno = 0;
            }
          }


          %>
          <%if(vctStorico.size()!=0 && ritorno==0){%>
          <!--  <tr class="rowHeader" height="20" align="center">
                <td>ID Evento</td>
                <td>Mitt.</td>
                <td>Evento</td>
                <td>Evento HD</td>
                <td>Desc. Offerta</td>
                <td>Desc. Servizio</td>
                <td>Cod. Istanza Prodotto</td>
                <td>Desc. Prodotto</td>
                <td>Cod. Istanza Componente</td>
                <td>Desc. Componente</td>
                <td>Data Elab.</td>
                                 <td>Data Eff. Evento</td> 
                <td>Data Rich. Ordine</td>
                <td>Data Rich. Cess.</td>
            </tr>-->
                <thead>
					    <tr class="rowHeader" height="20" align="center">
					              <th>ID Evento</th>
                <th>Mitt.</th>
                <th>Evento</th>
                <th>Evento HD</th>
                <th>Desc. Offerta</th>
                <th>Desc. Servizio</th>
                <th>Cod. Istanza Prodotto</th>
                <th>Desc. Prodotto</th>
                <th>Cod. Istanza Componente</th>
                <th>Desc. Componente</th>
                <th>Data Elab.</th>
                <th>Data Eff. Evento</th> 
                <th>Data Ric. Ordine</th>
                <th>Data Rich. Cess.</th>
					    </tr>
           </thead>
          <%
            String classRow = "row2";
//            SimpleDateFormat datafmt = new SimpleDateFormat ("dd/MM/yyyy hh:mm:ss");
      
            String msg = "";
            
            for(int i=((pagerPageNumber.intValue()-1)*intRecXPag);((i < vctStorico.size()) && (i < pagerPageNumber.intValue()*intRecXPag));i++){
              classRow = classRow.equals("row2") ? "row1" : "row2";
              storico = (DB_StoricoCodeIstanzaProd)vctStorico.get(i);
              if(i == 0){
              /*MA*/
                sistema_mittente=storico.getID_SISTEMA_MITTENTE();                
              /*FINE MA*/ 
                id_evento = storico.getEVENTO();
                all_eventi=all_eventi + '@' +  id_evento;
                /* MS 17/12/2009*/
                session.setAttribute("hidsrcIdEvento",id_evento);
  
                if(storico.getDESC_TIPO_EVENTO_HD().equals("Rettifica") || 
                   storico.getDESC_TIPO_EVENTO_HD().equals("Ripristino")){
                  msg = "Non è possibile effettuare un ripristino su un elemento di rettifica.";
                }
              }
               %>
              <TR>    
                <td class="<%=classRow%>" align="center"><%=storico.getEVENTO()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getID_SISTEMA_MITTENTE()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDESC_EVENTO()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDESC_TIPO_EVENTO_HD()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDESC_OFFERTA()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDESC_SERVIZIO()%></td>      
                <td class="<%=classRow%>" align="center"><%=storico.getCODE_ISTANZA_PROD()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDESC_PRODOTTO()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getCODE_ISTANZA_COMPO()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDESC_COMPONENTE()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDATA_ELAB()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDATA_EFF_EVENTO()%></td>
                <td class="<%=classRow%>" align="center"><%=storico.getDATA_RIC_ORD()%></td>
                <%if ( !storico.getDATA_RIC_CESS().equals("")){%>
                  <td class="<%=classRow%>" align="center"><%=storico.getDATA_RIC_CESS()%></td>
                <%}else{%>  
                   <td class="<%=classRow%>" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                 <% }%>             
                    
                
              </TR>
               <%
            }
            %>
            <input type="hidden" name="msg" value="<%=msg%>"> 
            <%
          }
          else
          {
          %>
            <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
              <td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
            </tr>
            <input type="hidden" name="msg" value=""> 
          <%
          }
          %>
        </table>
   <!--</div>-->
      </TD>
    <TR>
    <tr height="28" class="text">
      <td >
        <pg:index>
           Risultati Pag.
        <pg:prev>
        <A HREF="javaScript:goPage('<%= pageUrl %>&srcIstanzaProd=<%=srcIstanzaProd%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
        </pg:prev>
        <pg:pages>
          <%if (pageNumber == pagerPageNumber){%>
                 <b><%=pageNumber%></b>&nbsp;
          <%}else{%>
                  <A HREF="javaScript:goPage('<%= pageUrl %>&srcIstanzaProd=<%=srcIstanzaProd%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
          <%}%>
        </pg:pages>
        <pg:next>
          <A HREF="javaScript:goPage('<%= pageUrl %>&srcIstanzaProd=<%=srcIstanzaProd%>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
        </pg:next>
        </pg:index>
        </pg:pager>
      </td>
    </tr>
    <!-- FINE ELENCO STORICO EVENTI -->
    <TR>
      <TD colspan="4">
        <HR>
      </TD>
    </TR>
    <tr>
      <td>
      <div name="maschera" id="maschera" style="overflow: hidden;" >
        <table width="90%"  cellspacing="1" align="center" class="row1">
          <tr>
            <%
            /* controllo se per l'ultimo ID_EVENTO utile è già stato effettuato un ripristino */
            /* controllo nei preinventari con il code_istanza_prod e like su ID_EVENTO start with HD */
            String disabled = "";
            
            if(remoteEnt_Inventari.getCheckRipristino(srcIstanzaProd) > 0){
              disabled = "disabled";
            }
  
            %>
            <TD class="text" align="center">
              Identificativo Evento:
            
              <INPUT class="text" id="srcIdEvento" name="srcIdEvento" value='<%=id_evento%>' onchange="javascript:frmSearch.msg.value = '';  return true;" >
            </td>
                       <TD class="text" align="center">
               &nbsp;
            </td>          
            <TD class="text" align="center">
              Data di elaborazione:
              <INPUT class="text" id="strDataElaborazione" name="strDataElaborazione" readonly obbligatorio="si" tipocontrollo="data" label="Data Elaborazione" Update="false" size="13" value="<%=dataOdierna.getDate()%>">
              <a href="javascript:showCalendar('frmSearch.strDataElaborazione','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name="imgCalendar" alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
              <a href="javascript:clearField(frmSearch.strDataElaborazione);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name="imgCancel" alt="Cancella data"  src="<%=StaticContext.PH_COMMON_IMAGES%>remove.gif"   border="0"></a>
            </td>


         
          <% if (!disabled.equals("")){%>
          <tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
              <td colspan=3 width="8%" height="20" class="textB" align="center">Ripristino o Rettifica già presente in preinventario!</td>
          </tr>
          <%}%>
        </table>
       </div> 
      </td>
    </tr>
          </tr>
              <TR>
      <TD colspan="4">
        <HR>
      </TD>
    </TR>
    <tr>
      <td>
        <table width="100%" cellspacing="1" align="center" class="row1">
          <tr>
                      <TD class="text" align="center">
              <input class="textB" type="button" name="cmdRipristino" value="Crea Ripristino" onClick="ONCREAEVENTOLocal('<%=id_evento%>','<%=all_eventi%>');" <%= disabled %> >           
      <!--     </td>
                  <TD class="text" align="center"> 
         
            </td>
            <TD class="text" align="center"> -->
              &nbsp;&nbsp;&nbsp;   <input class="textB" type="button" name="cmdRettifica" value="Crea Rettifica" onClick="OnRettifica();" <%= disabled %> >
             <!--     </td>    
            <TD class="text" align="center">-->
            &nbsp;&nbsp;&nbsp;  <input class="textB" type="button" name="cmdChiudi" value="Chiudi" onClick="ONCHIUDI();">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  <!--  <tr>-->
      <INPUT type="hidden" id="srcIdEventoIniziale" name="srcIdEventoIniziale" value='<%=id_evento%>' readonly>
    <INPUT type="hidden" id="srcIstanzaProd" name="srcIstanzaProd" value='<%=srcIstanzaProd%>' readonly>
    <INPUT type="hidden" id="sistema_mittente" name="sistema_mittente" value='<%=sistema_mittente%>' readonly>                 
  </table>
</form>

<script>
var http=getHTTPObject();
  //alert ('Nascondi');
 NascondiColonna('Dati','Data Ric. Ordine');
 NascondiColonna('Dati','Data Rich. Cess.');
 NascondiColonna('Dati','Data Eff. Evento');
	
</script>

</body>
</html>