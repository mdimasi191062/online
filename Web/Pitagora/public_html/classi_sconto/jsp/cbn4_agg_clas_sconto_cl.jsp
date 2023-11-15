<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Iterator" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_agg_clas_sconto_cl.jsp")%>
</logtag:logData>
<%

  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    //-----------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
    //Interfaccia Remota
  I5_2CLAS_SCONTOEJB remote = null;       
    //Numero delle righe presenti su tabella
  int iElementi=0;
  int j=0;
      //Individua l'operazione che stiamo effetuando
      //                     con valore = 0 Inserimento
      //                     con valore = 1 Modifica
  String strOperazione = null;
    //Parametro in ingresso con valore = 0i pagina richiamata da lista classi di sconto Inserimento
    //Parametro in ingresso con valore = 0m pagina richiamata da lista classi di sconto Modifica    
    //                      con valore = 1 pagina richiamata da aggiornamento classi di sconto Inserimento nuova riga 
    //                      con valore = 2 pagina richiamata da aggiornamento classi di sconto Eliminazione ultima riga 
    //                      con valore = 3 pagina richiamata daaggiornamento classi di sconto Annulla
  String strProvenienza = null;
    //Codice della classe di sconto che stiamo inserendo/modificando
  String CODE_CLAS_SCONTO = null;
    //Data Inizio della classe di sconto che stiamo inserendo/modificando
  String txtDataInizio = null;
    //Array contenti i dati presentati all'interno della tabella
  String Filtro = "";  
  java.math.BigDecimal ValoreMinimo = null;
  java.math.BigDecimal ValoreMassimo = null;    
  String txtDescrizioneIntervallo[]  = null;
  String txtValoreMinimo[] = null;      
  String txtValoreMassimo[] = null;      
  Collection collection = null;
  Iterator iterator = null;
  String strTitolo=null;

    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtCodRicerca = request.getParameter("txtCodRicerca");

  
  int AssociazioneTariffe=0;
  strProvenienza = request.getParameter("strProvenienza");  
  Filtro =  request.getParameter("chkClsDisatt");  
  if (strProvenienza.equals("0m")){   
    strOperazione="1";
    CODE_CLAS_SCONTO = request.getParameter("CodiceClsSconto"); 
    java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");        
%>
 <EJB:useHome id="home" type="com.ejbBMP.I5_2CLAS_SCONTOEJBHome" location="I5_2CLAS_SCONTOEJB" /> 
<%
    collection = home.findAll(Filtro, CODE_CLAS_SCONTO);              
    iterator = collection.iterator();
    txtDescrizioneIntervallo= new  String[collection.size()] ;
    txtValoreMinimo = new  String[collection.size()];
    txtValoreMassimo = new  String[collection.size()];
    iElementi = collection.size()-1;      
    while (iterator.hasNext()){
      remote = (I5_2CLAS_SCONTOEJB) iterator.next();
      if (j==0){
        AssociazioneTariffe = remote.AssociazioneTariffe();
        if (AssociazioneTariffe!=0){
          AssociazioneTariffe = remote.AssociazioneTariffe();
          response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Alla Classe di Sconto selezionata è associata una tariffa. Non è  possibile procedere con l\'aggiornamento!",com.utl.StaticContext.ENCCharset));
        }
      }                  
      txtDataInizio = df.format(remote.getIn_Valid());
      txtDescrizioneIntervallo[j]= remote.getDesc_Cls_Sconto();    
      ValoreMinimo = remote.getMin_Spesa();
      txtValoreMinimo[j] = ValoreMinimo.toString().replace('.',',');
      if (j<iElementi){
        ValoreMassimo = remote.getMax_Spesa();      
        txtValoreMassimo[j] = ValoreMassimo.toString().replace('.',',');
      }
      j=j+1;
    }      
  }else{
    if (strProvenienza.equals("0i")){    
      strOperazione="0";
      Sequence sequence = new Sequence();
      CODE_CLAS_SCONTO = sequence.NewSequence("I5Q21_CLAS_SCONTO");
      txtDescrizioneIntervallo= new  String[1] ;
      txtValoreMinimo = new  String[1];
      txtValoreMassimo = new  String[1];  
    }else{
      CODE_CLAS_SCONTO = request.getParameter("CodiceClsSconto");  
      strOperazione = request.getParameter("strOperazione");  
      if (strProvenienza.equals("3")){    
        iElementi = 0;
        txtDescrizioneIntervallo  = new  String[1];
        txtValoreMinimo = new  String[1];
        txtValoreMassimo = new  String[1];
      }else{
        iElementi = Integer.parseInt(request.getParameter("iElementi"));      
        if (strProvenienza.equals("1")){    
          iElementi = iElementi+1;
        }else{
          iElementi = iElementi-1;
        }
        txtDescrizioneIntervallo= new  String[iElementi+1] ;
        txtValoreMinimo = new  String[iElementi+1];
        txtValoreMassimo = new  String[iElementi+1];
        txtDataInizio = request.getParameter("txtDataInizio");      
        for(j=0;j<=iElementi;j++){
         txtDescrizioneIntervallo[j]= request.getParameter("txtDescrizioneIntervallo" + Integer.toString(j));
         txtValoreMinimo[j] = request.getParameter("txtValoreMinimo" + Integer.toString(j));      
         txtValoreMassimo[j] = request.getParameter("txtValoreMassimo" + Integer.toString(j));      
        }
      }
    }
  }   
  if (strOperazione.equals("0")){    
    strTitolo="Inserimento";
  }else{  
    strTitolo="Aggiornamento";
  }
  String sParametri= "&txtnumRec=" + txtnumRec;
  sParametri= sParametri + "&numRec=" + NumRec;
  sParametri= sParametri + "&chkClsDisatt=" + Filtro;    
  if (txtCodRicerca!=null){
    sParametri= sParametri + "&txtCodRicerca=" + txtCodRicerca; 
  }  
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">

<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

<!--da qui gestione calendarietto-->


var message1="Click per selezionare la data selezionata";
var message2="Click per cancellare la data selezionata";
function cancelCalendar ()
{
   window.document.frmDati.txtDataInizio.value="";
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

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}

var objForm=window.document.frmDati;  

function ONINSRIGA()
{
  objForm.action="cbn4_agg_clas_sconto_cl.jsp?strProvenienza=1"
  Enable(window.document.frmDati.txtDataInizio);
  objForm.submit();
}
function ONCANCRIGA()
{
  objForm.action="cbn4_agg_clas_sconto_cl.jsp?strProvenienza=2"
  Enable(window.document.frmDati.txtDataInizio);
  objForm.submit();
}

function ONCANCELLA()
{
  objForm.action="cbn4_agg_clas_sconto_cl.jsp?strProvenienza=3"
  Enable(window.document.frmDati.txtDataInizio);
  objForm.submit();
}
function ONANNULLA()
{ 
  <%
  if ((strProvenienza.equals("0m")) || (strProvenienza.equals("0i"))) {   
  %>
  var bControllo= (objForm.txtFlag.value.length != 0 );
  <%
  }else {
  %>
  var bControllo= true;
  <%
  }
  %>
  if (bControllo ) {
    if (confirm('Sono state apportate delle modifiche all\'elemento corrente.\nVuoi ignorarle?')==true)
    {
      window.close();
    }
   }else {
     window.close();
  }    
}  

function chkDataOdierna(strData){
			var appo = new Date();
			var dataDiOggi = new Date(appo.getYear(),appo.getMonth(), appo.getDate());
      var data = new Date(strData.substring(6,10),strData.substring(3,5)-1,strData.substring(0,2));
			if(!(data>=dataDiOggi))
      {
        alert("La data di inizio validità deve essere maggiore o uguale alla data odierna!");
				return false;
      } 
      return true;
}


function ONCONFERMA()
{  
  if( objForm.txtDataInizio.value.length==0){
    alert('La Data Inizio Validità é obligatoria');
    return(false);
  }
	if (!chkDataOdierna(objForm.txtDataInizio.value)){
    return(false);
  }  
<% 
if (iElementi==0){
%>
  alert('Devono essere inseriti almeno due intervalli');
  objForm.INSRIGA.focus();
  return(false);
<%
}else{
  for(j=0;j<=iElementi;j++){
%>  
  var iValoreMinimo=objForm.txtValoreMinimo<%=Integer.toString(j)%>.value;
  var iValoreMassimo=objForm.txtValoreMassimo<%=Integer.toString(j)%>.value;
  if( objForm.txtDescrizioneIntervallo<%=Integer.toString(j)%>.value.length==0){
    alert('La "Descrizione Intervallo" é obligatoria');
    objForm.txtDescrizioneIntervallo<%=Integer.toString(j)%>.focus();
    return(false);
  }
  if( iValoreMinimo.length==0){   
    alert('Il "Valore Minimo" é obligatorio');
    objForm.txtValoreMinimo<%=Integer.toString(j)%>.focus();
    return(false);
  }
   if(!CheckNum(objForm.txtValoreMinimo<%=Integer.toString(j)%>.value,18,6)){
      alert('Il formato del campo Valore Minimo deve essere composto al massimo da dodici cifre intere e sei cifre decimali'); 
      objForm.txtValoreMinimo<%=Integer.toString(j)%>.focus();
      return(false);
     }
<%  
    if (j==iElementi){
%>   
  if( ! (objForm.txtValoreMassimo<%=Integer.toString(j)%>.value.length==0)){   
    alert('Il Valore Massimo dell\'ultimo intervallo non deve essere valorizzato');
    objForm.txtValoreMassimo<%=Integer.toString(j)%>.focus();
    return(false);
  }
<%  
    }else{
%>   
  if( objForm.txtValoreMassimo<%=Integer.toString(j)%>.value.length==0){   
    alert('Il Valore Massimo delle righe diverse dall\'ultima deve essere valorizzato');
    objForm.txtValoreMassimo<%=Integer.toString(j)%>.focus();
    return(false);
  }
<%  
    }
%>   
  if(!CheckNum(objForm.txtValoreMassimo<%=Integer.toString(j)%>.value,18,6)){
      alert('Il formato del campo Valore Massimo deve essere composto al massimo da dodici cifre intere e sei cifre decimali'); 
      objForm.txtValoreMassimo<%=Integer.toString(j)%>.focus();
      return(false);
     }

<%  
    if (j==0){
%> 

  if(! (parseInt(iValoreMinimo)==0)){
    alert('Il Valore Minimo del primo intevallo deve essere uguale a zero');
    objForm.txtValoreMinimo0.focus();
    return(false);
  }
<%
    }
    if (j<iElementi){
%>
  if( parseInt(iValoreMinimo)>parseInt(iValoreMassimo)){
    alert('Il Valore Massimo deve essere maggiore del valore minimo di uno stesso intevallo');
    objForm.txtValoreMinimo<%=Integer.toString(j)%>.focus();
    return(false);
  }
<%
    }
    if (j>0){
%>  
  if (! ( parseInt(objForm.txtValoreMassimo<%=Integer.toString(j-1)%>.value)+1 ==parseInt(iValoreMinimo)) ){
    alert('Il Valore Minimo deve essere uguale al Valore Massimo della riga precedente incrementato di uno');
    objForm.txtValoreMinimo<%=Integer.toString(j)%>.focus();
    return(false);
  }
<%    
    }
  }
}  
%>
  if (confirm('Si conferma l\'<%=strTitolo%> della Classe di Sconto')==true)
  {
    Enable(window.document.frmDati.txtDataInizio);
    window.document.frmDati.submit();
  }
}
</SCRIPT>


<TITLE><%=strTitolo%> Sconti</TITLE>
</HEAD>
<BODY  onLoad='Disable(window.document.frmDati.txtDataInizio)'>
<form name="frmDati" method="post" action='salva_clas_sconto_cl.jsp?<%=sParametri%>'>
<input type="hidden" name="txtnumRec" value="<%=txtnumRec%>">
<input type="hidden" name="numRec" value="<%=NumRec%>">
<% 
if (txtCodRicerca != null) {
%>
<input type="hidden" name="txtCodRicerca" value="<%=txtCodRicerca%>">
<%
}
%>
<input type="hidden"  name="iElementi" value="<%=iElementi%>">
<input type="hidden" name="CodiceClsSconto" value="<%=CODE_CLAS_SCONTO%>">
<input type="hidden" name="strOperazione" value="<%=strOperazione%>">          
<input type="hidden" name="txtFlag" value="">          
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/classidisconto.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%=strTitolo%> Sconto</td>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="right">Codice Classe Di Sconto</td>
          <td  class="text" align=CENTER><%=CODE_CLAS_SCONTO%>
          <input type="hidden" class="text" name="txtCodiceClsSconto" value="<%=CODE_CLAS_SCONTO%>">
        </td>
      </tr>   
      <tr>
        <td  class="textB" align="right">Data inizio validità (gg/mm/aaaa):</td>        
        <td  class="text" align="right">
          <table>
            <tr>
              <td>
              <% if (txtDataInizio==null) {%>
                <input type="text" class="text" name="txtDataInizio" size="15"  maxlength="10" onfocus='javascript:blur();'>
              <%}else{%>
                <input type="text" class="text" name="txtDataInizio"   size="15"value="<%=txtDataInizio%>" maxlength="10" size="10" onfocus='javascript:blur();'>
              <%}%>          
              </td>          
              <td><a name="LinkCalendar" href="javascript:showCalendar('frmDati.txtDataInizio','sysdate');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar' src="../../common/images/body/calendario.gif" border="no"></a></td>
              <td><a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel' src="../../common/images/body/cancella.gif" border="0"></a></td>       
            </tr>              
          </table>            
      </tr>
    </table>
    </td>
  </tr>
    <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="right">Descrizione Intervallo</td>
        <td  class="textB" align="right">Valore Minimo</td>
        <td  class="textB" align="right">Valore Massimo</td>
        <td  class="textB" align="right"></td>
        <td  class="textB" align="right"></td>
      </tr>   
      <%
      String txtAppDescrizioneIntervallo=null;
      String txtAppValoreMinimo=null;
      String txtAppValoreMassimo=null;        
      
      for(j=0;j<=iElementi;j++){
        if (txtDescrizioneIntervallo[j]==null){
          txtAppDescrizioneIntervallo="";
        }else{
          txtAppDescrizioneIntervallo=txtDescrizioneIntervallo[j];
        }
        if (txtValoreMinimo[j]==null){
          txtAppValoreMinimo="";
        }else{
          txtAppValoreMinimo=txtValoreMinimo[j];
        }
        if (txtValoreMassimo[j]==null){
          txtAppValoreMassimo="";
        }else{
          txtAppValoreMassimo=txtValoreMassimo[j];
        }
        %>
      <tr>             
        <td  class="text" align="right"><input type="text" class="text" name="txtDescrizioneIntervallo<%=j%>" value="<%=txtAppDescrizioneIntervallo%>" maxlength="50" size="30" onblur="objForm.txtFlag.value=1"></td>
        <td  class="text" align="right"><input type="text" class="text" name="txtValoreMinimo<%=j%>" value="<%=txtAppValoreMinimo.toString().replace('.',',')%>" maxlength="19" size="19" onblur="objForm.txtFlag.value=1"></td>
        <td  class="text" align="right"><input type="text" class="text" name="txtValoreMassimo<%=j%>" value="<%=txtAppValoreMassimo.toString().replace('.',',')%>" maxlength="19" size="19" onblur="objForm.txtFlag.value=1"></td>        
      </tr>
      <%}%>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>  
    <td>
      <input type="hidden" name="chkClsDisatt" value="<%=Filtro%>">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />          
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
<script language="javascript">

var objForm=window.document.frmDati; 
//Disable(objForm.txtDataInizio);
Disable(objForm.txtCodiceClsSconto);
<%
if (iElementi==0) {
%>
objForm.CANCRIGA ? Disable(objForm.CANCRIGA):null;
<%
}
%>
</script>
</BODY>
</HTML>
