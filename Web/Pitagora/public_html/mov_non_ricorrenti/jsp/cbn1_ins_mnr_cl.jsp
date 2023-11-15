<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_mnr_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
      //Codice dell' elemento che deve essere modificato in caso di modifica
  final int indiceTipoContrattoPassivo=6;
  String selCODE_MOVIM=null;
  String desc_gest= ""; 
  String code_gest= "";
  String code_acc= "";
  String desc_acc= ""; 
  String code_class= "";
  String desc_class= ""; 
  String code_ogg= "";
  String data_ogg= "";
  String desc_ogg  = "";
  String codeIstanza  = ""; 
  String descrizione  = "";
  String importo  = "";
  String anno  = "";
  String num_dest = "0";
  String num_mese = "0";
  String data_fatt = "";
  java.util.Date data_trans = new java.util.Date();
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  java.util.Date data_fattur = null;
  String strTitolo;
    /*'Individua se la pagina é in stato inserimento oppure in modifica 
     Vero siamo in modifica 
     Falso siamo in inserimento 
     Viene regolata in base al parametro Modifica Se valorizato*/
  boolean Modifica = false;
    /*'Individua se la pagina é in stato richiamata dalla pagina di errore 
     nel caso i dati devono essere presi dalla pagina precedente
     Vero i dati vengono richiamati dalla pagina precedente 
     Viene regolata in base al parametro Ricarica Se valorizato*/
  boolean Ricarica = false;
  String codiceTipoContratto=null;
  String hidDescTipoContratto= null;
  codiceTipoContratto= request.getParameter("codiceTipoContratto");
  if (request.getParameter("Modifica")!=null){
    Modifica=true;
    strTitolo="Aggiornamento";
    selCODE_MOVIM=request.getParameter("selCODE_MOVIM");    
  } else {
    strTitolo="Inserimento";
    
    if (codiceTipoContratto!=null){
       // Label delle tipologie di contratto richieste
      hidDescTipoContratto= request.getParameter("hidDescTipoContratto");    
      session.setAttribute("codiceTipoContratto_MRN_INS",codiceTipoContratto);
      session.setAttribute("hidDescTipoContratto_MRN_INS",hidDescTipoContratto);
    }else{
      codiceTipoContratto= (String) session.getAttribute("codiceTipoContratto_MRN_INS");
      hidDescTipoContratto= (String) session.getAttribute("hidDescTipoContratto_MRN_INS");
    }
  }
  String StrCliente;
  if (indiceTipoContrattoPassivo==Integer.parseInt(codiceTipoContratto)){
    StrCliente="Fornitore";
  }else{
    StrCliente="Cliente";
  }    
  
  if (request.getParameter("Ricarica")!=null){
    Ricarica=true;
  }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><%=strTitolo%> movimenti non ricorrenti</title>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<script language="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<script language="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<script language="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
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

<!--fino a qui-->
function ONANNULLA()
{  
     window.location.href="cbn1_lista_mnr_cl.jsp?txtTypeLoad=0";
}
function CercaFornitore()
{
  var sParametri='?chiamante=_MRN_INS';
  openDialog("lista_fornitori_cl.jsp" + sParametri,569, 400, "", "");    
}
function CercaAccount()
{    
  var sParametri='';
  sParametri= sParametri + '?txtCodeFornitore=' + document.frmSearch.txtCodeFornitore.value; 
  sParametri= sParametri + '&txtProvenienza=2'; 
  openDialog("lista_account_cl.jsp" + sParametri, 569, 400, "", "");      
}
function CercaClasse()
{ 
  openDialog("lista_classi_cl.jsp", 569, 400, "", "");      
}
function CercaOggetto() 
{    
  var sParametri='';
  sParametri= sParametri + '?txtCodeClasse=' + document.frmSearch.txtCodeClasse.value; 
  openDialog("lista_oggetti_cl.jsp" + sParametri,569, 400, "", "");        
}
function ONCONFERMA()
{    
  if(document.frmSearch.txtDescFornitore.value.length==0){
    alert('Il codice fornitore è obbligatorio');
    document.frmSearch.CercaForn.focus();
    return(false);}

  if(document.frmSearch.txtDescAccount.value.length==0){
    alert('Il codice account è obbligatorio');
    document.frmSearch.CercaAcc.focus();
    return(false);}

  if(document.frmSearch.txtDescClasse.value.length==0){
    alert('Il codice della classe dell\'oggetto di fatturazione è obbligatorio');
    document.frmSearch.CercaClas.focus();
    return(false);}

  if(document.frmSearch.txtDescOggetto.value.length==0){
    alert('Il codice dell\'oggetto di fatturazione è obbligatorio');
    document.frmSearch.CercaOgg.focus();
    return(false);}

  if(document.frmSearch.txtDescrizione.value.length==0){
    alert('La descrizione del movimento è obbligatoria'); 
    window.document.frmSearch.txtDescrizione.focus(); 
    return(false);}

  if(document.frmSearch.txtImporto.value.length==0){
    alert('L\'importo del movimento è obbligatorio'); 
    window.document.frmSearch.txtImporto.focus(); 
    return(false);}
  if(!CheckNum(document.frmSearch.txtImporto.value,18,6,false)){
    alert('Il campo deve essere un intero positivo di 18 cifre oppure un numero decimale positivo composto da 18 cifre intere e 2 decimali'); 
    window.document.frmSearch.txtImporto.focus(); 
    return(false);}

  if(document.frmSearch.txtDataFatt.value.length==0){
    alert('Attenzione! Il campo Data di Fatturabilità è obbligatorio'); 
    return(false);}

  if(document.frmSearch.numDest.value==2){
    if(document.frmSearch.numMese.value==0){
      alert('Attenzione! Il campo Mese Documento di Riferimento è obbligatorio'); 
      window.document.frmSearch.numMese.focus(); 
      return(false);}
    if(document.frmSearch.txtAnno.value.length==0){
      alert('Attenzione! Il campo Anno Documento di Riferimento è obbligatorio'); 
      window.document.frmSearch.txtAnno.focus(); 
      return(false);}
    if(!CheckNum(document.frmSearch.txtAnno.value,4,0,false)){
      alert('Il campo deve essere un intero numerico di 4 cifre'); 
      window.document.frmSearch.txtAnno.focus(); 
      return(false);}
    if(document.frmSearch.txtAnno.value < 1950 || document.frmSearch.txtAnno.value > 2050){
      alert("L'anno deve essere compreso tra il 1950 e il 2050!"); 
      window.document.frmSearch.txtAnno.focus(); 
      return(false);}
  }
    if (confirm('Si vuole confermare l\'operazione di <%=strTitolo%>?')==true)
     {
       Enable(document.frmSearch.txtDescFornitore);
       Enable(document.frmSearch.txtDescAccount);
       Enable(document.frmSearch.txtDescClasse);
       Enable(document.frmSearch.txtDescOggetto);
       Enable(document.frmSearch.txtDataFatt);    
       document.frmSearch.submit();
     }
}
function AbilitaMese()
{    
  if(document.frmSearch.numDest.selectedIndex==2){
    Enable(document.frmSearch.txtAnno);
    Enable(document.frmSearch.numMese);}
  else{
    deleteData('frmSearch.txtAnno');
    deleteData('frmSearch.numMese');
    Disable(document.frmSearch.txtAnno);
    Disable(document.frmSearch.numMese);}

}

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitfrmSearch(typeLoad)
{
  Enable(document.frmSearch.txtDescFornitore);
  Enable(document.frmSearch.txtDescAccount);
  Enable(document.frmSearch.txtDescClasse);
  Enable(document.frmSearch.txtDescOggetto);
  Enable(document.frmSearch.txtDataFatt);
  document.frmSearch.submit();
}  
function setnumRec()
{
  Disable(document.frmSearch.txtDescFornitore);
  Disable(document.frmSearch.txtDescAccount);
  Disable(document.frmSearch.txtDescClasse);
  Disable(document.frmSearch.txtDescOggetto);
  Disable(document.frmSearch.txtDataFatt);
  Disable(document.frmSearch.txtDataTrans);    
  ControlloSeAbilit();
}  

function ControlloSeAbilit()
{
<% if (!Modifica){%>
  if(document.frmSearch.txtCodeFornitore.value=="")
  {
    Disable(document.frmSearch.CercaAcc);
    Disable(document.frmSearch.canc2);
  }
  else
  {
    Enable(document.frmSearch.CercaAcc);
    Enable(document.frmSearch.canc2);
  }
  if(document.frmSearch.txtCodeAccount.value=="")
  {
    Disable(document.frmSearch.CercaClas);
    Disable(document.frmSearch.cancClas);
  }
  else
  {
    Enable(document.frmSearch.CercaClas);
    Enable(document.frmSearch.cancClas);
  }
<%}%>  
  if(document.frmSearch.txtCodeClasse.value=="")
  {
    Disable(document.frmSearch.CercaOgg);
    Disable(document.frmSearch.canc3);
  }
  else
  {
    Enable(document.frmSearch.CercaOgg);
    Enable(document.frmSearch.canc3);
  }
}

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}
  //------------------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

</SCRIPT>
<TITLE>Selezione Movimento</TITLE>
</HEAD>
<BODY onload="setnumRec();">
<%
if (Ricarica){
  desc_gest = request.getParameter("txtDescFornitore"); 
  code_gest = request.getParameter("txtCodeFornitore");
  code_acc  = request.getParameter("txtCodeAccount");
  desc_acc  = request.getParameter("txtDescAccount"); 
  code_class  = request.getParameter("txtCodeClasse");
  desc_class  = request.getParameter("txtDescClasse"); 
  code_ogg  = request.getParameter("txtCodeOggetto");
  data_ogg  = request.getParameter("txtDataOggetto");
  desc_ogg  = request.getParameter("txtDescOggetto"); 
  codeIstanza  = request.getParameter("txtCodeIstanza"); 
  descrizione  = request.getParameter("txtDescrizione"); 
  importo  = request.getParameter("txtImporto"); 
  anno  = request.getParameter("txtAnno"); 
  num_dest = request.getParameter("numDest");
  num_mese = request.getParameter("numMese");
  data_fatt = request.getParameter("txtDataFatt");  
  if(data_fatt!=null)
  {
    if (!data_fatt.equals(""))
    {
       data_fattur = df.parse(data_fatt);
    }
  }

} else if (Modifica){%>
<EJB:useHome id="homeejb" type="com.ejbBMP.I5_2MOV_NON_RICEJBHome" location="I5_2MOV_NON_RICEJB" />
<%
     I5_2MOV_NON_RICEJB remotoejb=null;
     remotoejb = homeejb.findByPrimaryKey (selCODE_MOVIM);      
     desc_gest = remotoejb.getNome_Rag_Soc_Gest();
     code_acc = remotoejb.getCode_account();
     desc_acc = remotoejb.getDesc_acc();
     code_class  = remotoejb.getCode_Clas_Ogg_Fatrz();
     desc_class  = remotoejb.getDesc_Clas_Ogg_Fatrz();
     code_ogg  = remotoejb.getCode_Ogg_Fatrz();
     desc_ogg  = remotoejb.getDesc_Ogg_Fatrz();
     if (remotoejb.getDATA_INIZIO_VALID_OF() != null){
       data_ogg = df.format(remotoejb.getDATA_INIZIO_VALID_OF());
     }  
     codeIstanza = remotoejb.getCode_Istanza_Ps();
     descrizione  = remotoejb.getDesc_mov();
     importo  = remotoejb.getImpt_Mov_Non_Ric().toString().replace('.',',');     
     if (remotoejb.getTipo_Flag_Nota_Cred_Fattura().equals("N")){
       num_dest="2";
       anno  = remotoejb.getData_aa();
       num_mese = remotoejb.getData_mm();
     } else if (remotoejb.getTipo_Flag_Nota_Cred_Fattura().equals("F")){ 
       if (remotoejb.getTipo_Flag_Dare_Avere().equals("C")){ 
         num_dest="0";
       } else {
         num_dest="1";
       }  
     }
     if (remotoejb.getData_fatrb() != null){
      data_fatt = df.format(remotoejb.getData_fatrb());
     } 
}
if (codeIstanza==null){
  codeIstanza="";
}
%>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%=strTitolo%> Movimenti non Ricorrenti</td>
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
<form name="frmSearch" method="get" action='salva_mov_non_ric_cl.jsp'> 
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dati di riferimento</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='4' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <% if (!Modifica){%>
                    <tr>
                      <td colspan="1" class="textB" align="right">Tipol. di contratto:</td>
                      <td colspan="3" class="text" colspan="7"><%=hidDescTipoContratto%></td>
                    </tr>
                    <%}%>
                    <tr>
                      <td class="textB" align="right"><%=StrCliente%>:</td>
                      <td class="text">
                        <input class="text" type='text' name="txtDescFornitore" onChange="ControlloSeAbilit();" size='25' value="<%=desc_gest%>">                        
                        <% if (code_gest==null) {%>
                        <input type='hidden' name="txtCodeFornitore" > 
                        <% } else {%>
                        <input type='hidden' name="txtCodeFornitore" value="<%=code_gest%>">                         
                        <% }%>         
                        <% if (!Modifica){%>
                        <input class="textB" type="button" name="CercaForn" value="..." onclick="CercaFornitore();">
                        <input class="textB" type="button" value="canc" onClick="deleteData('frmSearch.txtCodeFornitore');deleteData('frmSearch.txtDescFornitore');deleteData('frmSearch.txtCodeAccount');deleteData('frmSearch.txtDescAccount');ControlloSeAbilit();">
                        <%}%>
                      </td>
                      <td class="textB" align="right">Account:</td>
                      <td class="text">
                        <input class="text" type='text' name="txtDescAccount"  size='25' value="<%=desc_acc%>">                        
                        <% if (code_acc==null) {%>
                        <input type='hidden' name="txtCodeAccount" > 
                        <% } else {%>
                        <input type='hidden' name="txtCodeAccount" value="<%=code_acc%>">                         
                        <% }%>                        
                        <% if (!Modifica){%>
                        <input class="textB" type="button" name="CercaAcc" value="..." onclick="CercaAccount();">
                        <input class="textB" type="button" name="canc2" value="canc" onClick="deleteData('frmSearch.txtCodeAccount');deleteData('frmSearch.txtDescAccount');ControlloSeAbilit();">
                        <% }%>                                                
                      </td>
                    </tr>
                    <tr>
                      <td colspan="4" class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="1" class="textB" align="right">Classe Oggetto di Fatturazione:</td>
                      <td colspan="3" class="text">
                        <input class="text" type='text' name="txtDescClasse" onChange="ControlloSeAbilit();" size='50' value="<%=desc_class%>">                        
                        <% if (code_class==null) {%>
                        <input type='hidden' name="txtCodeClasse" > 
                        <% } else {%>
                        <input type='hidden' name="txtCodeClasse" value="<%=code_class%>">                         
                        <% }%>                                                
                        <input class="textB" type="button" name="CercaClas" value="..." onclick="CercaClasse();">
                        <input class="textB" type="button" name="cancClas" value="canc" onClick="deleteData('frmSearch.txtCodeClasse');deleteData('frmSearch.txtDescClasse');deleteData('frmSearch.txtCodeOggetto');deleteData('frmSearch.txtDescOggetto');ControlloSeAbilit();">
                      </td>
                    </tr>
                    <tr>
                      <td colspan="4" class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="1" class="textB" align="right">Oggetto di fatturazione:</td>
                      <td colspan="3" class="text">
                        <input class="text" type='text'  name="txtDescOggetto"  size='25' value="<%=desc_ogg%>">                        
                        <% if (code_ogg==null) {%>
                        <input type='hidden' name="txtCodeOggetto" > 
                        <input type='hidden' name="txtDataOggetto" >                               
                        <% } else {%>
                        <input type='hidden' name="txtCodeOggetto" value="<%=code_ogg%>">                         
                        <input type='hidden' name="txtDataOggetto" value="<%=data_ogg%>">                         
                        <% }%>                        
                        <input class="textB" type="button"  name="CercaOgg" value="..." onclick="CercaOggetto();">
                        <input class="textB" type="button"  name="canc3" value="canc" onClick="deleteData('frmSearch.txtCodeOggetto');deleteData('frmSearch.txtDescOggetto');deleteData('frmSearch.txtDataOggetto');ControlloSeAbilit();">
                      </td>
                    </tr>
                    <tr>
                      <td colspan="4" class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="1" class="textB" align="right">Codice Istanza PS:</td>
                      <td colspan="3" class="text" align="left"><input type="text" class="text" name="txtCodeIstanza" size='25' maxlength='20' value="<%=codeIstanza%>"></td>
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
      </table>
    </td>
  </tr>        
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>  
        <tr>          
          <td>
            <table border="0" width="100%" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Dati movimento</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='4' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td colspan='1' class="textB" align="right">Data transazione:</td>
                      <td colspan='3' class="text" align="left"><input type="text"  class="text" name="txtDataTrans" size='11' value="<%=df.format(data_trans)%>"></td>
                    </tr>   
                    <tr>
                      <td colspan='4' class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan='1' class="textB" align="right">Descrizione:</td>
                      <td colspan='3' class="text" align="left"><input type="text" class="text" name="txtDescrizione" size='40' maxlength='50' value="<%=descrizione%>"></td>
                    </tr>   
                    <tr>
                      <td colspan='4' class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan='1' class="textB" align="right">Importo:</td>
                      <td colspan='3' class="text" align="left"><input type="text" class="text" name="txtImporto" size='25' value="<%=importo%>"></td>
                    </tr>   
                    <tr>
                      <td colspan='4' class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan='1' class="textB" align="right">Data Fatturabilità:</td>
                      <td colspan='3' class="text" align="left">                                                    
                        <table>
                        <tr align="left">
                          <td >
                          <% if (data_fatt==null) {%>
                            <input class="text" type="text" name="txtDataFatt" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}else{%>
                            <input class="text" type="text" name="txtDataFatt" value="<%=data_fatt%>" maxlength="10" size="10" onfocus='javascript:blur();'>
                          <%}%>
                          </td>        
                          <td align="right">
                           <a name="acalendar_txtDataFatt" href="javascript:showCalendar('frmSearch.txtDataFatt','sysdate');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar_txtDataFatt' src="../../common/images/body/calendario.gif" border="no"></a>
                          </td>        
                          <td align="right">         
                           <a name="acancel_txtDataFatt"  href="javascript:cancelCalendar(window.document.frmSearch.txtDataFatt);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_txtDataFatt' src="../../common/images/body/cancella.gif" border="0"></a>
                          </td>        
                        </tr>
                        </table>
                      </td>                         
                    </tr>
                    <tr>
                      <td colspan='4' class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan='1' class="textB" align="right">Destinazione Movimento:</td>
                      <td colspan='3' class="text">
                        <select class="text" name="numDest" onclick="AbilitaMese();">
                          <option class="text" value="0" <%if(num_dest.equals("0")){out.println("selected");}%>>Fattura - Credito</option>
                          <option class="text" value="1" <%if(num_dest.equals("1")){out.println("selected");}%>>Fattura - Debito</option>
                          <option class="text" value="2" <%if(num_dest.equals("2")){out.println("selected");}%>>Nota di Credito</option>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='4' class="textB" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="textB" align="right">Mese Riferimento Fattura:</td>
                      <td class="text">
                        <select class='text' name='numMese' <%if(!num_dest.equals("2")){out.println("disabled");}%>>
                          <option class="text" value="0" <%if(num_mese.equals("0")){out.println("selected");}%>></option>
                          <option class="text" value="1" <%if(num_mese.equals("1")){out.println("selected");}%>>Gennaio</option>
                          <option class="text" value="2" <%if(num_mese.equals("2")){out.println("selected");}%>>Febbraio</option>
                          <option class="text" value="3" <%if(num_mese.equals("3")){out.println("selected");}%>>Marzo</option>
                          <option class="text" value="4" <%if(num_mese.equals("4")){out.println("selected");}%>>Aprile</option>
                          <option class="text" value="5" <%if(num_mese.equals("5")){out.println("selected");}%>>Maggio</option>
                          <option class="text" value="6" <%if(num_mese.equals("6")){out.println("selected");}%>>Giugno</option>
                          <option class="text" value="7" <%if(num_mese.equals("7")){out.println("selected");}%>>Luglio</option>
                          <option class="text" value="8" <%if(num_mese.equals("8")){out.println("selected");}%>>Agosto</option>
                          <option class="text" value="9" <%if(num_mese.equals("9")){out.println("selected");}%>>Settembre</option>
                          <option class="text" value="10" <%if(num_mese.equals("10")){out.println("selected");}%>>Ottobre</option>
                          <option class="text" value="11" <%if(num_mese.equals("11")){out.println("selected");}%>>Novembre</option>
                          <option class="text" value="12" <%if(num_mese.equals("12")){out.println("selected");}%>>Dicembre</option>
                        </select>
                      </td>  
                      <td  class="textB" align="right">Anno Riferimento Fattura:</td>
                      <td  class="text" align="right"><input type="text" class="text" name="txtAnno" size='8' <%if(!num_dest.equals("2")){out.println("disabled");}%> value="<%=anno%>"></td>
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
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
<%          
            if (Modifica){
%>            
            <input type="hidden" name="selCODE_MOVIM" value="<%=selCODE_MOVIM%>">          
            <input type="hidden" name="Modifica" value="<%=Modifica%>">          
<%
            }
%>            
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />	        
	      </tr>
	    </table>
    </td>
  </tr>
</table>  
</form>
</BODY>
</HTML>
