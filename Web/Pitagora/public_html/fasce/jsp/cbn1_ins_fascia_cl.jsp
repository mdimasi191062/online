<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection,java.util.Iterator" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_ins_fascia_cl.jsp")%>
</logtag:logData>
<%

  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    //-----------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
    //Interfaccia Remota
  I5_2FASCIE remote = null;       
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bErrore = null;
    //Numero delle righe presenti su tabella
  int iElementi=0;
  int j=0;
      //Individua l'operazione che stiamo effetuando
      //                     con valore = 0 Inserimento
      //                     con valore = 1 Modifica
  String strOperazione = null;
    //Paremetro in ingresso con valore = 0i pagina richiamata da lista fascie Inserimento
    //Paremetro in ingresso con valore = 0m pagina richiamata da lista fascie Modifica    
    //                     con valore = 1 pagina richiamata da gestione fascie Inserimento nuova riga 
    //                     con valore = 2 pagina richiamata da gestione fascie Eliminazione ultima riga 
    //                     con valore = 3 pagina richiamata da gestione fascie Annulla
  String strProvenienza = null;
    //Codice della fascia che stiamo inserendo/modificando
  String CODE_FASCIA = null;
    //Data Inizio della fascia che stiamo inserendo/modificando
  String txtDataInizio = null;
    //Array contenti i dati presentati all'interno della tabella
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
  if (strProvenienza.equals("0m")){   
    strOperazione="1";
    CODE_FASCIA = request.getParameter("CodiceFascia");      
    java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");        
%>  
<EJB:useHome id="home" type="com.ejbBMP.I5_2FASCIEHome" location="I5_2FASCIE" />    
<%  
    collection = home.findAllByCodeFascia(CODE_FASCIA);              
    iterator = collection.iterator();
    txtDescrizioneIntervallo= new  String[collection.size()] ;
    txtValoreMinimo = new  String[collection.size()];
    txtValoreMassimo = new  String[collection.size()];
    iElementi = collection.size()-1;      
    while (iterator.hasNext())
    {
      remote = (I5_2FASCIE) iterator.next();
      if (j==0){
        if (remote.AssociazioneTariffe()!=0){
          AssociazioneTariffe = remote.AssociazioneTariffe();
          break;
        }
      }  
      txtDataInizio = df.format(remote.getDATA_INIZIO_VALID());
      txtDescrizioneIntervallo[j]= remote.getDESC_FASCIA();
      txtValoreMinimo[j] = Integer.toString(remote.getVALO_LIM_MIN());      
      if (j<iElementi){
        txtValoreMassimo[j] = Integer.toString(remote.getVALO_LIM_MAX());      
      }
      j=j+1;
    }
  }else{
    if (strProvenienza.equals("0i")){    
      strOperazione="0";
      Sequence sequence = new Sequence();
      CODE_FASCIA = sequence.NewSequence("i5q21_fascia");
      txtDescrizioneIntervallo= new  String[1] ;
      txtValoreMinimo = new  String[1];
      txtValoreMassimo = new  String[1];  
    }else{
      CODE_FASCIA = request.getParameter("CodiceFascia");  
      strOperazione = request.getParameter("strOperazione");  
      if (strProvenienza.equals("3")){    
        iElementi = 0;
        txtDescrizioneIntervallo= new  String[1] ;
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

  //      txtDataInizio = java.text.DateFormat.getInstance().parse(request.getParameter("txtDataInizio"));
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
  if (AssociazioneTariffe!=0){
     response.sendRedirect("messaggio.jsp?a=1&messaggio=" + java.net.URLEncoder.encode("Attenzione! Impossibile aggiornare una fascia associata a una o più tariffe attive!",com.utl.StaticContext.ENCCharset));
  }else{
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
function toggleLink ()
{

  link=document.links[0];
  if (link.disabled)
  {
    window.document.frmDati.bottone.value="Disabilita";
  	window.document.frmDati.calendar.src="../../common/images/body/calendario.gif";
  	window.document.frmDati.cancel.src="../../common/images/body/cancella.gif";
    enableLink (document.links[0]);
    enableLink (document.links[1]);
  	message1="Click per selezionare la data selezionata";
	  message2="Click per cancellare la data selezionata";

  }
  else
  {
  	window.document.frmDati.bottone.value="Abilita";
  	window.document.frmDati.calendar.src="../../common/images/body/calendario_dis.gif";
  	window.document.frmDati.cancel.src="../../common/images/body/cancella_dis.gif";
  	disableLink (document.links[0]);
  	disableLink (document.links[1]);
	message1="Link disabilitato";
	message2="Link disabilitato";

  }
  link.disabled = !link.disabled;
}
function showMessage (field)
{
	if (field=='seleziona')
		self.status=message1;
	else
		self.status=message2;
}

<!--fino a qui-->
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

  //Disabilito il testo del codice fascia 
var objForm=window.document.frmDati;  
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
function ONINSRIGA()
{
  //Controllo che l'ultima riga sia valorizzata ???
  objForm.action="cbn1_ins_fascia_cl.jsp?strProvenienza=1"
  Enable(objForm.txtDataInizio);  
  objForm.submit();
}
function ONCANCRIGA()
{
  objForm.action="cbn1_ins_fascia_cl.jsp?strProvenienza=2"
  Enable(objForm.txtDataInizio);    
  objForm.submit();
}
function ONCANCELLA()
{
  objForm.action="cbn1_ins_fascia_cl.jsp?strProvenienza=3"
  Enable(objForm.txtDataInizio);    
  objForm.submit();
}
function ONCONFERMA()
{  
  if( objForm.txtDataInizio.value.length==0){
    alert('La Data Inizio Validità é obligatoria');
    Enable(objForm.txtDataInizio);    
    objForm.txtDataInizio.focus();
    Disable(objForm.txtDataInizio);        
    return(false);
  }
	if (!chkDataOdierna(objForm.txtDataInizio.value)){
    Enable(objForm.txtDataInizio);    
    objForm.txtDataInizio.focus();
    Disable(objForm.txtDataInizio);        
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
  if( ! CheckNum(objForm.txtValoreMinimo<%=Integer.toString(j)%>.value,5)){   
    alert('Il "Valore Minimo" deve essere un numero intero di 5 cifre');
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
  if( ! CheckNum(objForm.txtValoreMassimo<%=Integer.toString(j)%>.value,5)){   
    alert('Il "Valore Massimo" deve essere un numero intero di 5 cifre');  
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
  if (confirm('Si conferma l\'<%=strTitolo%> della Fascia')==true)
  {
    Enable(objForm.txtDataInizio);    
    window.document.frmDati.submit();
  }
  
}

</SCRIPT>


<TITLE><%=strTitolo%> Fascia</TITLE>
</HEAD>
<BODY>
<form name="frmDati" method="post" action='cbn_1_agg_fascia_cl.jsp'>
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
<input type="hidden" name="CodiceFascia" value="<%=CODE_FASCIA%>">
<input type="hidden" name="strOperazione" value="<%=strOperazione%>">          
<input type="hidden" name="txtFlag" value="">          
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/fascia.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/image/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%=strTitolo%> fascia</td>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="right">Codice Fascia</td>
        <td  class="text" align="right">
          <input type="text" class="text" name="txtCodiceFascia" value="<%=CODE_FASCIA%>">
        </td>
      </tr>   
      <tr>
        <td  class="textB" align="right">Data inizio validità (gg/mm/aaaa)</td>
        <td  class="text" align="right">        
        <% if (txtDataInizio==null) {%>
          <input type="text" class="text" name="txtDataInizio" maxlength="10" size="10">
        <%}else{%>
          <input type="text" class="text" name="txtDataInizio" value="<%=txtDataInizio%>" maxlength="10" size="10">
        <%}%>
        </td>        
        <td>
         <a href="javascript:showCalendar('frmDati.txtDataInizio','sysdate');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar' src="../../common/images/body/calendario.gif" border="no"></a>
        </td>        
        <td>         
         <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel' src="../../common/images/body/cancella.gif" border="0"></a>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="right">Descrizione Intervallo</td>
        <td  class="textB" align="right">Valore Minimo</td>
        <td  class="textB" align="right">Valore Massimo</td>
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
        <td  class="text" align="right"><input type="text" class="text" name="txtValoreMinimo<%=j%>" value="<%=txtAppValoreMinimo%>" maxlength="5" size="5" onblur="objForm.txtFlag.value=1"></td>
        <td  class="text" align="right"><input type="text" class="text" name="txtValoreMassimo<%=j%>" value="<%=txtAppValoreMassimo%>" maxlength="5" size="5" onblur="objForm.txtFlag.value=1"></td>        
      </tr>
      <%}%>
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
<script language="javascript">
  //Disabilito il testo del codice fascia 
var objForm=window.document.frmDati;  
Disable(objForm.txtCodiceFascia);
Disable(objForm.txtDataInizio);
<%
if (iElementi==0) {
%> 
Disable(objForm.CANCRIGA);
<%
}
%>
</script>
</BODY>
</HTML>
<%}%>