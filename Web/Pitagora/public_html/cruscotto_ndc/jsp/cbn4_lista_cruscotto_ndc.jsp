<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbSTL.*,com.utl.*,com.usr.*,java.util.Vector,java.util.Date" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=StaticMessages.getMessage(3006,"cbn4_lista_cruscotto_ndc.jsp")%>
</logtag:logData>
<%
  String refresh = request.getParameter("refresh");
  
  if ( !"".equals(refresh) && refresh != null ){
   session.removeAttribute("aRemote");
  }
  
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
  //Dichiarazioni
  DB_CruscottoNdc remote = null;   
  String bgcolor="";
  int i=0;
  int j=0;
  int iPagina=0;  

  // This is the variable we will store all records in.
  Vector collection=null;
  Vector aRemote = null;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

  //eventuale Filtro di ricerca
  String strDATA_INIZIO_CICLO_FATRZ =  request.getParameter("txtDataInizio");
  String strDATA_FINE_CICLO_FATRZ =  request.getParameter("txtDataFine");
  String strTIPO_FLAG_FUNZIONE_CREAZ_IMPT = request.getParameter("txtFlagFunzione");
  String strRIFERITO_FATTURA =  request.getParameter("txtRiferitoFattura");
  String strCODE_GEST = request.getParameter("txtCodGest");
  String strCODE_ACCOUNT = request.getParameter("txtCodAccount");
  String strDESC_ACCOUNT = request.getParameter("txtDescAccount");

  if ( strTIPO_FLAG_FUNZIONE_CREAZ_IMPT == null ) {
    strTIPO_FLAG_FUNZIONE_CREAZ_IMPT = "-1";
  }
  
  if ( strRIFERITO_FATTURA == null ) {
    strRIFERITO_FATTURA = "-1";
  }  
  
   //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

  //Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  int records_per_page=10;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
   
  //Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
  // typeLoad=1 Fare query (default)
  // typeLoad=0 Variabile session

  int typeLoad=1;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  if (typeLoad!=0)
  {
    aRemote = (Vector) session.getAttribute("aRemote");
  }
  else
  {
%>
<EJB:useHome id="home" type="com.ejbSTL.CruscottoNdcHome" location="CruscottoNdc" />
<EJB:useBean id="cruscottoNdc" type="com.ejbSTL.CruscottoNdc" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<%  

    collection = cruscottoNdc.findAll(strDATA_INIZIO_CICLO_FATRZ, strDATA_FINE_CICLO_FATRZ, strTIPO_FLAG_FUNZIONE_CREAZ_IMPT, strRIFERITO_FATTURA, strCODE_GEST, strCODE_ACCOUNT);      
    
    if (!(collection==null || collection.size()==0)) {
      aRemote = collection;
      session.setAttribute( "aRemote", collection);
    }else{  
      session.setAttribute( "aRemote", null);
    }
    
  }
  
  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">

  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
  <script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
  <script language="JavaScript" src="../../common/js/calendar1.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" type="text/javascript">


//------------------------------------------------------------------------------
//Gestione Standard Ricerca
//------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  


function openGestori(){
  openDialog("visualizza_gestori.jsp", 500, 350); 
}


function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true'); 
}

function gotoPage(page)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.txtTypeLoad.value=1;
  document.frmSearch.txtnumPag.value=page;
  document.frmSearch.submit();
}

//------------------------------------------------------------------------------
//Fine Gestione Standard Ricerca
//------------------------------------------------------------------------------  

function exportCsv(){

  var codGest = document.frmSearch.txtCodGest.value;
  var codAccount =  document.frmSearch.txtCodAccount.value;
  var dataInizio = document.frmSearch.txtDataInizio.value;
  var dataFine = document.frmSearch.txtDataFine.value;
  var flagFunzione = document.frmSearch.txtFlagFunzione.value;
  var rifFattura = document.frmSearch.txtRiferitoFattura.value;
    
  carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};  
  var asyncFunz= function(){ handler_generico(http,carica,errore);};
  
  var sendMessage='codiceTipoContratto=1&codeFunz=30&id_funz=20&codeTipoContr=&codeGest='+codGest+'&codAccount='+codAccount+'&dataInizio='+dataInizio+'&dataFine='+dataFine+'&flagFunzione='+flagFunzione+'&rifFattura='+rifFattura;
  
  chiamaRichiesta(sendMessage,'ExportCsv',asyncFunz);
}

function ONRITORNO(messaggio){
  alert('@'+ messaggio+'@');
}

function gestisciMessaggio(messaggio)
{
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';  
}

function initialize()
{
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='visible';
   maschera.style.display='block';
   dvMessaggio.style.display='none';
   dvMessaggio.style.visibility='hidden';  
   
}

</SCRIPT>


<TITLE>Cruscotto NDC</TITLE>
</HEAD>
<BODY onload="initialize();setnumRec();">

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:hidden;display:none">
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn4_lista_cruscotto_ndc.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/cruscotto_ndc.jpg" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Cruscotto Ndc</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
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
                      <td colspan='5' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    
                    <tr style="height: 30px;">
                      <td class="textB" align="right">Codice Gestore:&nbsp;</td>
                      <td class="text" >
                        <%
                        if (strCODE_GEST ==null){
                        %>
                          <input class="text" type='text' name='txtCodGest' style="background-color : lightgray"  size='10' readonly >                        
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtCodGest' value='<%=strCODE_GEST%>' style="background-color : lightgray"  size='10' readonly>                        
                        <%                        
                        }
                        %>
                        <a href="javascript:openGestori()" >[ Seleziona Gestore/Account ] </a>
                      </td>
                      <td class="textB" align="right" >Codice Account:&nbsp;</td>
                      <td class="text">
                        <%
                        if (strCODE_ACCOUNT ==null){
                        %>
                          <input class="text" type='text' name='txtCodAccount' style="background-color : lightgray" size='10' readonly>                        
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtCodAccount' value='<%=strCODE_ACCOUNT%>' style="background-color : lightgray" size='10' readonly>                        
                        <%                        
                        }
                        %>
                      </td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Data Inizio:&nbsp;</td>
                      <td class="text">
                        <%
                        if (strDATA_INIZIO_CICLO_FATRZ ==null){
                        %>
                          <input class="text" type='text' name='txtDataInizio'  size='10'>       
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtDataInizio' value='<%=strDATA_INIZIO_CICLO_FATRZ%>' size='10'>                        
                        <%                        
                        }
                        %>
                        <a href="javascript:showCalendar('frmSearch.txtDataInizio','txtDataInizio');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                        <a href="javascript:cancelCalendar(document.frmSearch.txtDataInizio);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                        
                        <%-- a href="javascript:cal1.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
                        <a href="javascript:cancelCalendar(document.frmSearch.txtDataInizio);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" style="height:15px; width: 15px;" border="0"></a> --%>
                      </td>
                      <td class="textB" align="right" >Data Fine:&nbsp;</td>
                      <td  class="text">
                        <%
                        if (strDATA_FINE_CICLO_FATRZ  ==null){
                        %>
                          <input class="text" type='text' name='txtDataFine'  size='10'>                        
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtDataFine' value='<%=strDATA_FINE_CICLO_FATRZ%>' size='10'>                        
                        <%                        
                        }
                        %>
                        <a href="javascript:showCalendar('frmSearch.txtDataFine','txtDataFine');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                        <a href="javascript:cancelCalendar(document.frmSearch.txtDataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                        
                        <%-- a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/img/cal.gif" border="no"></a>
                        <a href="javascript:cancelCalendar(document.frmSearch.txtDataFine);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/img/images7.gif" style="height:15px; width: 15px;" border="0"></a> --%>
                      </td>
                      <td rowspan='4' class="textB" valign="center" align="center">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                          <tr>
                            <td>
                              <input class="textB" type="submit" name="Esegui" value="Ricerca"    onclick="submitFrmSearch('0');">
                            </td>
                            <td>
                              <input class="textB" type="button" name="Export" value="ExportCsv"  onclick="exportCsv();">
                            </td>
                          </tr>
                        </table>
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    
                    <tr style="height: 31px;">
                      <td class="textB" align="right">Val. / Rep.:&nbsp;</td>
                      <td class="text">
                        <% 
                          String defaultSel = "";
                          String vSel = "";
                          String rSel = "";
                          if ( ("-1").equals(strTIPO_FLAG_FUNZIONE_CREAZ_IMPT) ){
                            defaultSel = "selected";
                          }
                          if ( ("V").equals(strTIPO_FLAG_FUNZIONE_CREAZ_IMPT) ){
                            vSel = "selected";
                          }
                          if ( ("R").equals(strTIPO_FLAG_FUNZIONE_CREAZ_IMPT) ){
                            rSel = "selected";                        
                          }
                        %>
                        <select id="txtFlagFunzione" name="txtFlagFunzione">
                          <option value="-1" <%= defaultSel %> >-- Tutti --</option>
                          <option value="V"  <%= vSel %> >V</option>
                          <option value="R"  <%=  rSel%> >R</option>
                        </select>
                      </td>
                      <td class="textB" align="right" >Riferito Fattura:&nbsp;</td>
                      <td class="text">
                         <% 
                          String defaultSelF = "";
                          String siSel = "";
                          String noSel = "";
                          if ( ("-1").equals(strRIFERITO_FATTURA) ){
                            defaultSelF = "selected";
                          }
                          if ( ("SI").equals(strRIFERITO_FATTURA) ){
                            siSel = "selected";
                          }
                          if ( ("NO").equals(strRIFERITO_FATTURA) ){
                            noSel = "selected";                        
                          }
                        %>
                        <select id="txtRiferitoFattura" name="txtRiferitoFattura">
                          <option value="-1" <%= defaultSelF %> >-- Tutti --</option>
                          <option value="SI" <%= siSel %> >SI</option>
                          <option value="NO" <%= noSel %> >NO</option>
                        </select>
                      </td>
                      <td>&nbsp;</td>                    
                    </tr>
                   
                    
                    
                    <tr style="display:none;">
                      <td class="textB" align="right">Descrizione Account:&nbsp;</td>
                      <td colspan="3" class="text">
                        <%
                        if (strDESC_ACCOUNT ==null){
                        %>
                          <input class="text" type='text' name='txtDescAccount'  size='60' readonly>                        
                        <%                        
                        }else{
                        %>
                          <input class="text" type='text' name='txtDescAccount' value='<%=strDESC_ACCOUNT%>' size='60' readonly>                        
                        <%                        
                        }
                        %>
                      </td>
                      <td>&nbsp;</td>
                    </tr>
                    
                    
                    
                    <tr  style="margin-top: 5px;">
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td colspan='3' class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                      <td>&nbsp;</td>
                    </tr>
                    
                    
                    
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>

  <!-- Gestione navigazione-->
<form name="frmDati" method="post" action='canc_proc_emitt_cl.jsp'>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Risultati Cruscotto Ndc</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.size()==0))
  {
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
          <td bgcolor='#D5DDF1' class="textB" width="10%">Gestore SAP &nbsp;</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Val/Rep FT &nbsp;</td>
          <td bgcolor='#D5DDF1' class="textB" width="5%">Rif. FT</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Nr FT logistico</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Nr FT contabile &nbsp;</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Esercizio &nbsp;</td>                    
          <td bgcolor='#D5DDF1' class="textB" width="10%">Data FT &nbsp;</td>  
          <td bgcolor='#D5DDF1' class="textB" width="9%">Gestore &nbsp;</td>
          <td bgcolor='#D5DDF1' class="textB" width="26%">Account</td>
      </tr>
              
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.size()%>">

<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
<pg:param name="txtDataInizio" value="<%=strDATA_INIZIO_CICLO_FATRZ%>"></pg:param>
<pg:param name="txtDataFine" value="<%=strDATA_FINE_CICLO_FATRZ%>"></pg:param> 
<pg:param name="txtFlagFunzione" value="<%=strTIPO_FLAG_FUNZIONE_CREAZ_IMPT%>"></pg:param> 
<pg:param name="txtRiferitoFattura" value="<%=strRIFERITO_FATTURA%>"></pg:param> 
<pg:param name="txtCodGest" value="<%=strCODE_GEST%>"></pg:param> 
<pg:param name="txtCodAccount" value="<%=strCODE_ACCOUNT%>"></pg:param> 

<%
      DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 
      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.size()) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         DB_CruscottoNdc myelement=new DB_CruscottoNdc();
         myelement=(DB_CruscottoNdc)aRemote.elementAt(j);
         
         String newDate = null;
         if ( myelement.getDATA_EMISSIONE() != null ) {
           String onlyDate = myelement.getDATA_EMISSIONE().split(" ")[0];
           String onlyDay = onlyDate.split("-")[2];
           String onlyMonth = onlyDate.split("-")[1];
           String onlyYear = onlyDate.split("-")[0];
           newDate = onlyDay + "/" + onlyMonth + "/" + onlyYear;
         }        
      
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
%>
         <tr>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getCODE_GEST_SAP() != null ? myelement.getCODE_GEST_SAP() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getTIPO_FLAG_FUNZIONE_CREAZ_IMPT() != null ? myelement.getTIPO_FLAG_FUNZIONE_CREAZ_IMPT() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getRIFERITO_FATTURA() != null ? myelement.getRIFERITO_FATTURA() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getNR_FATTURA_SD() != null ? myelement.getNR_FATTURA_SD() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getNR_DOC_FI() != null ? myelement.getNR_DOC_FI() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getESERCIZIO() != null ? myelement.getESERCIZIO() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= newDate != null ? newDate : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getCODE_GEST() != null ? myelement.getCODE_GEST() : "n.a." %></TD>
            <TD bgcolor='<%=bgcolor%>' class='text'><%= myelement.getDESC_ACCOUNT() != null ? myelement.getDESC_ACCOUNT() : "n.a." %></TD>
        </tr>
        <tr>
           <td colspan='9' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
<%
          i+=1;
      }
%>

<pg:index>
  <tr>
    <td bgcolor="#FFFFFF" colspan="9" class="text" align="center">
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
            }else{
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
                          <td colspan='9' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  
</table>
</form>
</div>

<script type="text/javascript" language="javascript" >
    // Calendario Data Inizio Validità
/*    var cal1 = new calendar1(document.forms['frmSearch'].elements['txtDataInizio']);
    cal1.year_scroll = true;
		cal1.time_comp = true;
    // Calendario Data Fine Validità       
    var cal2 = new calendar1(document.forms['frmSearch'].elements['txtDataFine']);
		cal2.year_scroll = true;
		cal2.time_comp = true; */

</script>

<script type="text/javascript" language="javascript">
  var http=getHTTPObject();
</script>

</BODY>



</HTML>
