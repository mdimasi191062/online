<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_lista_mnr_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
  final int indiceTipoContrattoPassivo=6;
  String StrCliente;
  I5_2MOV_NON_RICEJB remote=null;
  String bgcolor="";
  int i=0;  
  int j=0;
  int iPagina=0;  
  String selCODE_MOVIM =null;
  String sChecked="checked";
    // Indici delle tipologie di contratto selezioante nelle maschere com_tc_001
  String codiceTipoContratto= request.getParameter("codiceTipoContratto");   
    // Label delle tipologie di contratto richieste
  String hidDescTipoContratto=null;
  if (codiceTipoContratto!=null){
    hidDescTipoContratto= request.getParameter("hidDescTipoContratto");    
    session.setAttribute("codiceTipoContratto",codiceTipoContratto);
    session.setAttribute("hidDescTipoContratto",hidDescTipoContratto);    
  }else{
    codiceTipoContratto= (String) session.getAttribute("codiceTipoContratto");
    hidDescTipoContratto= (String) session.getAttribute("hidDescTipoContratto");
  }
    //Controllo se la tipologia di contratto sia passiva
  if (indiceTipoContrattoPassivo==Integer.parseInt(codiceTipoContratto)){
    StrCliente="Fornitore";
  }else{
    StrCliente="Cliente";
  }
  
     // This is the variable we will store all records in.
  Collection collection=null;
  I5_2MOV_NON_RICEJB[] aRemote = null;
 
  selCODE_MOVIM =request.getParameter("CodSel");
 
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------   
 
  //eventuale Filtro di ricerca
// rivedere!!!

  String desc_gest = request.getParameter("txtDescFornitore"); 
  if (desc_gest==null){
    desc_gest="";
  }
  String code_gest = request.getParameter("txtCodeFornitore");
  String code_acc  = request.getParameter("txtCodeAccount");
  String desc_acc  = request.getParameter("txtDescAccount"); 
  if (desc_acc==null){
    desc_acc="";
  }
  int ind_tip_dat = 0;
  String tipo_data = request.getParameter("tipDat");
  if (tipo_data!=null){
     Integer tmptipodata =new Integer(tipo_data);
     ind_tip_dat = tmptipodata.intValue();
  }
  String data_da   = request.getParameter("txtDataDa");
  String data_a    = request.getParameter("txtDataA");
  if (data_da==null){
    data_da="";
  }
  if (data_a==null){
    data_a="";
  }

  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  java.util.Date data_dal = null;
  java.util.Date data_al = null;
  if(tipo_data!=null)
  {
     if(data_da!=null)
     {
       if (!data_da.equals(""))
       {
          data_dal = df.parse(data_da);
       }
     }
     if(data_a!=null)
     {
       if (!data_a.equals(""))
       {
          data_al = df.parse(data_a);
       }
     }
  }
  String strFornitore = request.getParameter("txtFornitore"); 
  
  //Lettura dell'indice Numero record per pagina della combo per ripristino dopo ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }
 
  //Lettura del valore Numero record per pagina della cisualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
    
 
  //Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
  // typeLoad=0 Fare query (default)
  // typeLoad=1 Variabile session
  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Lista movimenti non ricorrenti</title>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script language="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>

<script language="JavaScript">
<!--da qui gestione calendarietto-->
var message1="Click per selezionare la data selezionata";
var message2="Click per cancellare la data selezionata";
function cancelCalendar (objCalendar)
{
   objCalendar.value="";
}

function cancelLink ()
{
  return false;
}

function disableLink (link)
{
  if (link.onclick)
    link.oldOnClick = link.onclick;
  link.onclick = cancelLink;
  if (link.style)
    link.style.cursor = 'default';
}

function enableLink (link)
{
  link.onclick = link.oldOnClick ? link.oldOnClick : null;
  if (link.style)
    link.style.cursor = document.all ? 'hand' : 'pointer';
}
function showMessage (field)
{
	if (field=='seleziona')
		self.status=message1;
	else
		self.status=message2;
}

function selezionaPrimo()
{
  var n = document.frmDati.elements.length;
  var esiste=0;
  var selezionato=false;
  for(i=0;i<n;i++)
  {
    if(document.frmDati.elements[i].type=="radio")
    {
        esiste++;
        if(document.frmDati.elements[i].checked==true)
          selezionato=true;
    }
  }
  
  if(esiste>1 && !selezionato)
  {
      document.frmDati.CODE_MOVIM[0].click();
  }
  if(esiste==1 && !selezionato)
  {
      document.frmDati.CODE_MOVIM.click();  
  }  
}
<!--fino a qui-->

function GesAbilitaCalendar(){
  if (document.frmSearch.tipDat.options[0].selected==true){  
  	window.document.frmSearch.calendar_txtDataDa.src="../../common/images/body/calendario_dis.gif";
  	window.document.frmSearch.cancel_txtDataDa.src="../../common/images/body/cancella_dis.gif";
  	window.document.frmSearch.calendar_txtDataA.src="../../common/images/body/calendario_dis.gif";
  	window.document.frmSearch.cancel_txtDataA.src="../../common/images/body/cancella_dis.gif";    
    disableLink (acalendar_txtDataDa);
  	disableLink (acancel_txtDataDa);    
    disableLink (acalendar_txtDataA);
  	disableLink (acancel_txtDataA);        
    message1="Link disabilitato";
  	message2="Link disabilitato";
    cancelCalendar(window.document.frmSearch.txtDataDa);
    cancelCalendar(window.document.frmSearch.txtDataA);
  }else {
  	window.document.frmSearch.calendar_txtDataDa.src="../../common/images/body/calendario.gif";
  	window.document.frmSearch.cancel_txtDataDa.src="../../common/images/body/cancella.gif";
   	window.document.frmSearch.calendar_txtDataA.src="../../common/images/body/calendario.gif";
  	window.document.frmSearch.cancel_txtDataA.src="../../common/images/body/cancella.gif";  
    enableLink (acalendar_txtDataDa);
  	enableLink (acancel_txtDataDa);    
    enableLink (acalendar_txtDataA);
  	enableLink (acancel_txtDataA);        
   	message1="Click per selezionare la data selezionata";
	  message2="Click per cancellare la data selezionata";
  }
  document.links[0].disabled = !document.links[0].disabled;
}
function CercaFornitore()
{
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtFornitore=<%=strFornitore%>'; 
  sParametri= sParametri + '&modo=0'; 
  openDialog("lista_fornitori_cl.jsp" + sParametri, 600, 350);      
}
function CercaAccount()
{    
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
  sParametri= sParametri + '&txtFornitore=<%=strFornitore%>'; 
  sParametri= sParametri + '&txtCodeFornitore=' + document.frmSearch.txtCodeFornitore.value;
  sParametri= sParametri + '&txtProvenienza=1';
  sParametri= sParametri + '&modo=0'; 
  openDialog("lista_account_cl.jsp" + sParametri, 600,350);        
}

function ONNUOVO()
{    
  var sParametri='';
  /*sParametri= '?destinationPageClassic=/mov_non_ricorrenti/jsp/cbn1_ins_mnr_cl.jsp'
  sParametri= sParametri + '&destinationPageSpecial=/mov_non_ricorrenti/jsp/cbn1_ins_mnr_cl.jsp'
  sParametri= sParametri + '&strTitolo=/mov_non_ricorrenti/images/movnonric.gif&TCNonAmmessiSpecial=-';*/
  sParametri= sParametri + '?codiceTipoContratto=<%=codiceTipoContratto%>'
  sParametri= sParametri + '&hidDescTipoContratto=<%=hidDescTipoContratto%>'
  window.location.href="cbn1_ins_mnr_cl.jsp" + sParametri
}
function ONAGGIORNA()
{    
  var sParametri='';
  sParametri= '?Modifica=1';
  sParametri= sParametri + '&selCODE_MOVIM=' + window.document.frmDati.CodSel.value;
  sParametri= sParametri + '&codiceTipoContratto=<%=codiceTipoContratto%>'
  window.location.href="cbn1_ins_mnr_cl.jsp" + sParametri
}

function ONELIMINA()
{
  if(document.frmDati.controlloDataFatt.value.length==0)
  {  
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtFornitore=<%=strFornitore%>'; 
    sParametri= sParametri + '&CodSel=' + window.document.frmDati.CodSel.value;
    window.location.href="cbn1_canc_mnr_cl.jsp" + sParametri
   }
   else
   {
    alert("Non è possibile cancellare un movimento con data di fatturazione valorizzata!");
   }
}
function ONVISUALIZZA()
{
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtTypeLoad=1'; 
    sParametri= sParametri + '&txtFornitore=<%=strFornitore%>'; 
    sParametri= sParametri + '&CodSel=' + window.document.frmDati.CodSel.value;  
    window.location.href="cbn1_vis_mnr_cl.jsp" + sParametri
}
function ONSTAMPA()
{
    var sParametri='';
    sParametri= '?txtnumRec=<%=index%>';
    sParametri= sParametri + '&numRec=<%=records_per_page%>';
    sParametri= sParametri + '&txtFornitore=<%=strFornitore%>'; 
    sParametri= sParametri + '&CodSel=' + window.document.frmDati.CodSel.value;      
    openDialog("stampa_mov_non_ric_cl.jsp" + sParametri, 800, 600,"","print" );                        
}

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  /*if(document.frmSearch.txtDescFornitore.value=="")
  {
    alert("Impostare almeno il Fornitore!");
    return;
  }*/
  Enable(document.frmSearch.txtDescFornitore);
  Enable(document.frmSearch.txtDescAccount);
  Enable(document.frmSearch.txtDataDa);
  Enable(document.frmSearch.txtDataA);
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmDati.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  Disable(window.document.frmSearch.txtDataDa);
  Disable(window.document.frmSearch.txtDataA);  
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
  eval('document.frmSearch.tipDat.options[<%=ind_tip_dat%>].selected=true');  
  GesAbilitaCalendar();
  ControlloSeAbilit();
}  
function ChangeSel(codice,indice)
{
  document.frmDati.CodSel.value=codice;
  document.frmDati.controlloDataFatt.value=indice;
}

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}

function ControlloSeAbilit()
{
  if(document.frmSearch.txtCodeFornitore.value=="")
  {
    document.frmSearch.CercaAcc.disabled=true;
    document.frmSearch.canc2.disabled=true;
  }
  else
  {
    document.frmSearch.CercaAcc.disabled=false;
    document.frmSearch.canc2.disabled=false;
  }
  
  
}

  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

</SCRIPT>
<TITLE>Selezione Movimento</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<%
  if (typeLoad!=0)
  {
    if (session.getAttribute("aRemote")!=null){
      aRemote = (I5_2MOV_NON_RICEJB[]) session.getAttribute("aRemote");
    }
  }
  else
  {    

%>
<EJB:useHome id="home" type="com.ejbBMP.I5_2MOV_NON_RICEJBHome" location="I5_2MOV_NON_RICEJB" />

<%
    //if (code_gest!=null)
      collection = home.findAll(codiceTipoContratto,code_gest, data_dal, data_al, code_acc, tipo_data);   
    if (!(collection==null || collection.size()==0)) {
      aRemote = (I5_2MOV_NON_RICEJB[]) collection.toArray( new I5_2MOV_NON_RICEJB[1]);
      session.setAttribute( "aRemote", aRemote);
    } else {
      session.setAttribute( "aRemote", null);
    }  
  }
%>
<table align=center width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/movnonric.gif" alt="" border="0"></td>
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Movimenti non Ricorrenti</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>

  <!-- Gestione navigazione-->
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn1_lista_mnr_cl.jsp">
 
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="95%" align="center" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di ricerca</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='7' bgcolor="#FFFFFF"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td class="textB" colspan="7" >
                      <table>
                        <tr>
                        <td class="textB" colspan="2" align="left" width="20%">Tipol. di contratto:</td>
                        <td class="text" colspan="5" align="rigth"><%=hidDescTipoContratto%></td>
                        <tr>                        
                      </table>  
                      </td>
                    </tr>
                    <tr>
                      <td colspan='6'>
                      <table  width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                      <tr>
                      <td class="textB" align="left" width="15%">&nbsp;<%=StrCliente%>:</td>
                      <td class="text" nowrap>
                        <input class="text" type='text' name="txtDescFornitore" onChange="ControlloSeAbilit();" size='20' value="<%=desc_gest%>">                        
                        <% if (code_gest==null) {%>
                        <input type='hidden' name="txtCodeFornitore" > 
                        <% } else {%>
                        <input type='hidden' name="txtCodeFornitore" value="<%=code_gest%>">                         
                        <% }%>                                                
                        <input class="textB" type="button" name="CercaForn" value="..." onclick="CercaFornitore();">
                        <input class="textB" type="button" value="canc" onClick="deleteData('frmSearch.txtCodeFornitore');deleteData('frmSearch.txtDescFornitore');deleteData('frmSearch.txtCodeAccount');deleteData('frmSearch.txtDescAccount');ControlloSeAbilit();">
                      </td>
                      <td class="textB" align="right">&nbsp;Account:</td>
                      <td class="text" nowrap>
                        <input class="text" type='text' name="txtDescAccount"  size='25' value="<%=desc_acc%>">                        
                        <% if (code_acc==null) {%>
                        <input type='hidden' name="txtCodeAccount" > 
                        <% } else {%>
                        <input type='hidden' name="txtCodeAccount" value="<%=code_acc%>">                         
                        <% }%>                        
                        <input class="textB" type="button" name="CercaAcc" value="..." onclick="CercaAccount('0');">
                        <input class="textB" type="button" name="canc2" value="canc" onClick="deleteData('frmSearch.txtCodeAccount');deleteData('frmSearch.txtDescAccount');ControlloSeAbilit();">
                      </td>  
                      </tr>                        
                      </table>
                      </td>                      
                      <td rowspan='3' class="textB" valign="center" align="center" WIDTH=>
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE_MOVIM%>"> 
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name="hidDescTipoContratto" value="<%=hidDescTipoContratto%>">
                      </td>
                    </tr>
                    <tr>
                      <td colspan='6'>
                      <table  border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                        <tr>
                          <td class="textB" align="left" width="15%">&nbsp;Tipo data:</td>
                          <td class="text" width="20%">
                            <select class="text" name="tipDat" onchange="GesAbilitaCalendar();" >
                              <option class="text" value=0> </option>
                              <option class="text" value=1>Data Fatturazione</option>
                              <option class="text" value=2>Data Fatturabilità</option>
                              <option class="text" value=3>Data Transazione</option>
                            </select>
                          </td>        
                          <td class="textB" align="right" width="5%">Dal:</td>
                          <td  class="text" align="right" width="15%">                                                    
                          <% if (data_da==null) {%>
                            <input class="text" type="text" name="txtDataDa" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}else{%>
                            <input class="text" type="text" name="txtDataDa" value="<%=data_da%>" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}%>
                          </td>        
                          <td width="5%">
                           <a name="acalendar_txtDataDa" href="javascript:showCalendar('frmSearch.txtDataDa','sysdate');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar_txtDataDa' src="../../common/images/body/calendario.gif" border="no"></a>
                          </td>        
                          <td width="5%">         
                           <a name="acancel_txtDataDa"  href="javascript:cancelCalendar(window.document.frmSearch.txtDataDa);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_txtDataDa' src="../../common/images/body/cancella.gif" border="0"></a>
                          </td>        
                          <td  class="textB" align="right" width="5%">&nbsp;Al:</td>
                          <td width="15%">
                          <% if (data_a==null) {%>
                            <input class="text" type="text" name="txtDataA" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}else{%>
                            <input class="text" type="text" name="txtDataA" value="<%=data_a%>" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}%>
                          </td>        
                          <td width="5%">
                           <a name="acalendar_txtDataA" href="javascript:showCalendar('frmSearch.txtDataA','sysdate');"><img name='calendar_txtDataA' src="../../common/images/body/calendario.gif" border="no"></a>
                          </td>        
                          <td width="5%">         
                           <a name="acancel_txtDataA"  href="javascript:cancelCalendar(window.document.frmSearch.txtDataA);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_txtDataA' src="../../common/images/body/cancella.gif" border="0"></a>
                          </td>        
                        </tr>
                        </table>
                      </td>                          
                    </tr>
                    <tr>
                      <td colspan='3' WIDTH="50%" class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td colspan='3' class="text" align="left">
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
          <td colspan='3' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
        </tr>
  <!-- Gestione navigazione-->
  <tr>
    <td bgcolor="#FFFFFF"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
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
  <tr>
    <td bgcolor="#FFFFFF"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>  
</form>
<form name="frmDati">
  <tr>
    <td>
      <table border="0" width="95%" align="center" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
            <tr>
              <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Movimenti non ricorrenti selezionati</td>
              <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='1' bgcolor="#FFFFFF"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
              </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0))  
  
  {
    %>
              <tr>
                <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">Nessun Elemento da Visualizzare</td>
              </tr>
   <%
  } else {
  %>
                    
              <tr>
                <td>
                  <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                  <tr>
                    <td bgcolor='white' width="0%">&nbsp;</td>      
                    <td bgcolor='#D5DDF1' class="textB" width="24%"><%=StrCliente%></td>
                    <td bgcolor='#D5DDF1' class="textB" width="23%">Account</td>
                    <td bgcolor='#D5DDF1' class="textB" width="23%">Movimento</td>
                    <td bgcolor='#D5DDF1' class="textB" width="10%">Fatturazione</td>
                    <td bgcolor='#D5DDF1' class="textB" width="10%">Transazione</td>
                    <td bgcolor='#D5DDF1' class="textB" width="10%">Fatturabilità</td>
                  </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="typeLoad" value="1"></pg:param>
<pg:param name="txtDescFornitore" value="<%=desc_gest%>"></pg:param>
<pg:param name="txtCodeFornitore" value="<%=code_gest%>"></pg:param>
<pg:param name="txtCodeAccount" value="<%=code_acc%>"></pg:param>
<pg:param name="txtDescAccount" value="<%=desc_acc%>"></pg:param>
<pg:param name="tipDat" value="<%=ind_tip_dat%>"></pg:param>
<pg:param name="txtDataDa" value="<%=data_da%>"></pg:param>
<pg:param name="txtDataA" value="<%=data_a%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>   
<pg:param name="hidDescTipoContratto" value="<%=hidDescTipoContratto%>"></pg:param>   

<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
      {
         remote = (I5_2MOV_NON_RICEJB) PortableRemoteObject.narrow(aRemote[j],I5_2MOV_NON_RICEJB.class);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
         String CODE_MOVIM                = remote.getId_movim();                                                    
         String DESC_ACCOUNT              = remote.getDesc_acc();
         String DESC_FORN                 = remote.getNome_Rag_Soc_Gest();
         String DESC_MOV                  = remote.getDesc_mov();
         java.util.Date DATA_FATRB        = remote.getData_fatrb();
         java.util.Date DATA_EFF_FATRZ    = remote.getData_eff_fatrz();
         java.util.Date DATA_TRANSAZ      = remote.getData_transaz();
         sChecked="";
         if (selCODE_MOVIM!=null){
            if(CODE_MOVIM.equals(selCODE_MOVIM)){
              sChecked="checked";
              bCheck=true;
            }
         }  else {   
            if (i==0) {
              //sChecked="checked";
              bCheck=true;              
              selCODE_MOVIM=CODE_MOVIM;
            }
         }  

%>
                  <TR>
                   <td bgcolor='white' width="0%">
                      <input type="radio" name="CODE_MOVIM" value="<%= CODE_MOVIM %>" <%=sChecked%> onClick="ChangeSel('<%=CODE_MOVIM%>','<%if(DATA_EFF_FATRZ!=null){out.print("1");}%>')">
                   </td>
                   <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_FORN %></TD>
                   <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_ACCOUNT %></TD>
                   <TD bgcolor='<%=bgcolor%>' class='text'><%= DESC_MOV %></TD>
<%
if (DATA_EFF_FATRZ==null)
{
%>
                    <TD bgcolor='<%=bgcolor%>' class='text' value="">&nbsp;</TD>      
<%
} else {
%>
                    <TD bgcolor='<%=bgcolor%>' class='text'><%= df.format(DATA_EFF_FATRZ) %></TD>      
<%
}
if (DATA_TRANSAZ==null)
{
%>
                    <TD bgcolor='<%=bgcolor%>' class='text' value="">&nbsp;</TD>      
<%
} else {
%>
                    <TD bgcolor='<%=bgcolor%>' class='text'><%= df.format(DATA_TRANSAZ) %></TD>      
<%
}
if (DATA_FATRB==null)
{
%>
                    <TD bgcolor='<%=bgcolor%>' class='text' value="">&nbsp;</TD>      
<%
} else {
%>
                    <TD bgcolor='<%=bgcolor%>' class='text'><%= df.format(DATA_FATRB) %></TD>      
<%
}
%>
                    </tr>
                    <tr>
                      <td colspan='7' bgcolor="#FFFFFF"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>

<%
          i+=1;
        }
%>
<pg:index>
                      <tr>
                        <td bgcolor="#FFFFFF" colspan="7" class="text" align="center">
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
                        
                        </table>
                        <input type="hidden" name="CodSel" value="<%= selCODE_MOVIM %>" >
                        <input type="hidden" name="controlloDataFatt">
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
</table>
<script language="javascript">
    Disable(document.frmSearch.txtDescFornitore);
    Disable(document.frmSearch.CercaAcc);
    Disable(document.frmSearch.txtDescAccount);    
    Disable(document.frmSearch.canc2);
    Disable(document.frmSearch.txtDataDa);    
    Disable(document.frmSearch.txtDataA);    
<% 
if ((aRemote==null)||(aRemote.length==0)) { 
%>
    Disable(document.frmSearch.AGGIORNA);
    Disable(document.frmSearch.ELIMINA);
    Disable(document.frmSearch.VISUALIZZA);    
    Disable(document.frmSearch.STAMPA);        

   
    
<%
}else{
  if (!bCheck){
    if (i==1){
%>
    //document.frmDati.CODE_MOVIM.checked=true;
    //document.frmDati.CodSel.value=document.frmDati.CODE_MOVIM.value;
<%    
    }else{    
%>
    //document.frmDati.CODE_MOVIM[0].checked=true;
    //document.frmDati.CodSel.value=document.frmDati.CODE_MOVIM[0].value;
<% 
    }
  }
}  
%>
selezionaPrimo();
</script>
</form>
</BODY>
</HTML>
