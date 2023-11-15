<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="VERIFICA_SCHEDULAZIONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Schedulazione Batch")%>
<%=StaticMessages.getMessage(3006,"verifica_schedulazioni.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String user = ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();

String codeUtente = request.getParameter("codeUtente");
if (codeUtente==null) codeUtente=request.getParameter("codeUtente");
if (codeUtente==null) codeUtente=(String)session.getAttribute("codeUtente");

String selFunz                 = request.getParameter("selFunz");
String selStato                = request.getParameter("selStato");
String selUtente               = request.getParameter("selUtente");
String codeFunzione            = request.getParameter("codeFunzione");
String codeStatoSched          = request.getParameter("codeStatoSched");
String data_ins_sched_mmdd     = Utility.getDateMMDDYYYY();
String data_sched_mmdd         = Utility.getDateMMDDYYYY();

//DATA INSERIMENTO
String data_ins_sched                    = request.getParameter("data_ins_sched");
if (data_ins_sched==null) data_ins_sched = request.getParameter("data_ins_sched");
if (data_ins_sched==null) data_ins_sched = (String)session.getAttribute("data_ins_sched");

//DATA SCHEDULAZIONE
String data_sched                = request.getParameter("data_sched");
if (data_sched==null) data_sched = request.getParameter("data_sched");
if (data_sched==null) data_sched = (String)session.getAttribute("data_sched");

//DATA INSERIMENTO TMP
String data_ins_sched_tmp                        = request.getParameter("data_ins_sched_tmp");
if (data_ins_sched_tmp==null) data_ins_sched_tmp = request.getParameter("data_ins_sched_tmp");
if (data_ins_sched_tmp==null) data_ins_sched_tmp = (String)session.getAttribute("data_ins_sched_tmp");

Date DataOggi = new Date();
DataOggi = new Date(DataOggi.getTime()-(1000L*60*60*24*30)); 
//System.out.println("DataOggi: "+DataOggi);



//DATA SCHEDULAZIONE TMP
String data_sched_tmp         = request.getParameter("data_sched_tmp");
if (data_sched_tmp==null) data_sched_tmp=request.getParameter("data_sched_tmp");
if (data_sched_tmp==null) data_sched_tmp=(String)session.getAttribute("data_sched_tmp");

String act=Misc.nh(request.getParameter("act"));

if (codeFunzione == null)
    codeFunzione = "";
if (codeStatoSched == null)
    codeStatoSched = "";
if (codeUtente == null)
    codeUtente = "";

String title="";

if (act == null || act == "") 
{
    data_ins_sched = "";
    data_ins_sched_mmdd = "";
    data_sched = "";
    data_sched_mmdd = "";
    selUtente = "";
    selFunz = "";
    selStato = "";
    data_ins_sched_tmp = "";
    data_ins_sched_tmp = "";
}

Vector funzioni=null; // per il caricamento della combo Funzioni
Vector stati_batch=null; //per il caricamento della combo degli stati batch
Vector utenti=null; //per il caricamento della combo degli utenti
Collection SchedBatch; //per il caricamento della lista degli stati elab batch

// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null)
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }

// Lettura del Numero di record per pagina (default 5)
int records_per_page=50;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
{
  Integer tmpnumrec=new Integer(strNumRec);
  records_per_page=tmpnumrec.intValue();
}

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
{
  Integer tmptypeLoad=new Integer(strtypeLoad);
  typeLoad=tmptypeLoad.intValue();
}

if (strtypeLoad!=null)
{
  Integer tmptypeLoad=new Integer(strtypeLoad);
  typeLoad=tmptypeLoad.intValue();
}

String strComboUtente = request.getParameter("comboUtenti");
String strComboStato = request.getParameter("comboStati");
String strComboFunzione = request.getParameter("comboFunzioni");

if (strComboUtente != null && strComboUtente != "")
{
  String tmpComboUtente = strComboUtente;
  if (!strComboUtente.equals("-1"))
    selUtente = strComboUtente;
  else
    selUtente = "";
}

if (strComboStato != null && strComboStato != "")
{
  String tmpComboStato = strComboStato;
  if (!strComboStato.equals("-1"))
    selStato = strComboStato;
  else
    selStato = "";
}

if (strComboFunzione != null && strComboFunzione != "")
{
  String tmpComboFunzione = strComboFunzione;
  if (!strComboFunzione.equals("-1"))
    selFunz = strComboFunzione;
  else
    selFunz = "";
}

if (data_ins_sched_tmp != null && !data_ins_sched_tmp.trim().equalsIgnoreCase(""))
{
  data_ins_sched = data_ins_sched_tmp;
}

if (data_sched_tmp != null && !data_sched_tmp.trim().equalsIgnoreCase(""))
{
  data_sched = data_sched_tmp;
}

%>
<EJB:useHome id="homeSchedBatch" type="com.ejbSTL.SchedBatchSTLHome" location="SchedBatchSTL" /> 
<EJB:useBean id="remoteSchedBatch" type="com.ejbSTL.SchedBatchSTL" value="<%=homeSchedBatch.create()%>" scope="session"></EJB:useBean>
<%
   if (typeLoad!=0)
   {
      SchedBatch = (Collection) session.getAttribute("SchedBatch");
   }
   else
   {
      SchedBatch = remoteSchedBatch.getSchedBatch(codeFunzione, codeStatoSched, codeUtente, data_sched, data_ins_sched);
      //SchedBatch = remoteSchedBatch.getSchedBatch(codeFunzione, codeStatoSched, "05005578", "", "");
      if (SchedBatch!=null)
         session.setAttribute("SchedBatch", SchedBatch);
   }

%>
<EJB:useHome id="homeComboFunzioni"   type="com.ejbSTL.CmbFunzioniSTLHome"   location="CmbFunzioniSTL" />
<EJB:useBean id="remoteComboFunzioni" type="com.ejbSTL.CmbFunzioniSTL" value="<%=homeComboFunzioni.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeComboUtenti"     type="com.ejbSTL.CmbUtentiSTLHome"     location="CmbUtentiSTL" />
<EJB:useBean id="remoteComboUtenti" type="com.ejbSTL.CmbUtentiSTL" value="<%=homeComboUtenti.create()%>" scope="session"></EJB:useBean>


<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Stati Elaborazione Batch
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<!-- NUOVO CALENDARIO -->
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<!-- NUOVO CALENDARIO -->

<SCRIPT LANGUAGE='Javascript'>

//Variabili locali
var SelCodeSched = "";
var SelIdSched = "";
var codStatiBatchSel = "";
var mese = "";

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  document.frmSearch.submit();
}

function submitME()
{
  document.frmSearch.submit();  
}

function setInitialValue()
{
  //Imposta lo stato dei bottoni
  Disable(document.frmSearch.AGGIORNA);
  Disable(document.frmSearch.CANCELLA);
  Disable(document.frmSearch.data_ins_sched);
  Disable(document.frmSearch.data_sched);
  if (document.frmSearch.comboFunzioni.value!=-1)
  {
      document.frmSearch.selFunz.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;
  }
  
  if (document.frmSearch.comboStati.value!=-1)
  {
      document.frmSearch.selStato.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
  }
  if (document.frmSearch.comboUtenti.value!=-1)
  {
      document.frmSearch.selUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;     
  }
      
  if (document.frmSearch.data_ins_sched.value == "null")
      document.frmSearch.data_ins_sched.value = "";
      
  if (document.frmSearch.data_sched.value == "null")
      document.frmSearch.data_sched.value = "";

  typeLoad = "0";
  document.frmSearch.typeLoad.value = typeLoad;

  //Setta il numero di record  
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');

  //Setta il primo elemento della lista
  if (String(document.frmSearch.SelIdSched)!="undefined")
  {
    if (document.frmSearch.SelIdSched.lenght=="undefined")
    {
      document.frmSearch.SelIdSched.checked=true; 
    }
    else
    {
      if (document.frmSearch.SelIdSched[1])
      {
         document.frmSearch.SelIdSched[0].checked=true;
         idSched = document.frmSearch.SelIdSched[0].value;
         idCodStatoSched = document.frmSearch.SelCodeStatoSched[0].value;         
      }
      else   
      {
         idSched =  document.frmSearch.SelIdSched.value;
         idCodStatoSched = document.frmSearch.SelCodeStatoSched.value;
      }
    }
    ChangeSel(idSched,idCodStatoSched,document.frmSearch.user.value);
  }
}

var message1="Click per selezionare la data";
var message2="Click per cancellare la data selezionata";

function cancelLink ()
{
  return false;
}

function showMessage (field)
{
	if (field=='seleziona1' || field=='seleziona2')
		self.status=message1;
  else
  	self.status=message2;
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

function ONANNULLA()
{
    document.frmSearch.act.value="ANNULLA";    
    document.frmSearch.selFunz.value = "";
    document.frmSearch.selStato.value = "";
    document.frmSearch.selUtente.value = "";
    document.frmSearch.data_ins_sched.value = "";
    document.frmSearch.data_sched.value = "";
    document.frmSearch.comboFunzioni[0].selected = true;
    document.frmSearch.comboStati[0].selected = true;
    document.frmSearch.comboUtenti[0].selected = true;
    index=0;
    document.frmSearch.strIndex = null;
    document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
    Enable(document.frmSearch.data_ins_sched);
    Enable(document.frmSearch.data_sched);
}

function ChangeSel(SelIdSched,SelCodStatoSched,SelUserSched)
{
  codeStatoSched = SelCodStatoSched;
  idSched =  SelIdSched;
  document.frmSearch.idSchedHidden.value = SelIdSched;
  if ((codeStatoSched =="SCHD" || codeStatoSched =="schd") &&
      SelUserSched == document.frmSearch.user.value)
  {
     Enable(document.frmSearch.CANCELLA);
     Enable(document.frmSearch.AGGIORNA);     
  }   
  else   
  {
     Disable(document.frmSearch.CANCELLA);
     Disable(document.frmSearch.AGGIORNA);
  }   
}

function ONPOPOLALISTA()
{
    document.frmSearch.act.value = "POPOLALISTA";
    document.frmSearch.data_ins_sched_tmp.value = document.frmSearch.data_ins_sched.value;
    document.frmSearch.data_sched_tmp.value = document.frmSearch.data_sched.value;
    document.frmSearch.selFunz.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;
    document.frmSearch.codeFunzione.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;
    if (document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value==-1)
    {
        document.frmSearch.selFunz.value = "";
        document.frmSearch.codeFunzione.value = "";
    }

    document.frmSearch.selStato.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
    document.frmSearch.codeStatoSched.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
    if (document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value==-1)
    {
        document.frmSearch.selStato.value = "";
        document.frmSearch.codeStatoSched.value = "";
    }   

    document.frmSearch.selUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;
    document.frmSearch.codeUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;
    if (document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value==-1)
    {
        document.frmSearch.selUtente.value = "";
        document.frmSearch.codeUtente.value = "";
    }

    //controllo le date
    if ((document.frmSearch.data_ins_sched.value != null && document.frmSearch.data_ins_sched.value != "") &&
        (document.frmSearch.data_sched.value  != null && document.frmSearch.data_sched.value  != ""))
    {
      ProvaDataDal = document.frmSearch.data_ins_sched.value.substring(10,6)
             + document.frmSearch.data_ins_sched.value.substring(5,3)
             + document.frmSearch.data_ins_sched.value.substring(2,0);
      ProvaDataAl  = document.frmSearch.data_sched.value.substring(10,6)
             + document.frmSearch.data_sched.value.substring(5,3)
             + document.frmSearch.data_sched.value.substring(2,0);
      if (ProvaDataDal > ProvaDataAl) 
      {
            window.alert("Attenzione: 'Data Inserimento:' maggiore di 'Data Schedulazione:'");
            return;
      }
    }
    Enable(document.frmSearch.data_ins_sched);
    Enable(document.frmSearch.data_sched);
    submitFrmSearch(0);
}

function ONAGGIORNA()
{
    esegui(1);
}

function ONCANCELLA()
{
  esegui(2);
}

function cancelCalendar (obj)
{
  obj.value="";
}

function esegui(operazione)
{
    var sParametri= '?idSched='+document.frmSearch.idSchedHidden.value;
    sParametri= sParametri + '&operazione=' + operazione;
    openDialog("agg_sched.jsp" + sParametri, 800, 270, "", "");
}

</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">

<form name="frmSearch" method="post" action="verifica_schedulazioni.jsp">

<input type="hidden" name="selFunz" id=selFunz value="<%=selFunz%>"> 
<input type="hidden" name="selStato" id=selStato value="<%=selStato%>"> 
<input type="hidden" name="selUtente" id=selUtente value="<%=selUtente%>"> 
<input type="hidden" name="codeFunzione" id=selFunz value="<%=codeFunzione%>"> 
<input type="hidden" name="codeStatoSched" id=selStato value="<%=codeStatoSched%>"> 
<input type="hidden" name="codeUtente" id=codeUtente value="<%=codeUtente%>">
<input type="hidden" name=data_ins_sched_mmdd id=data_ins_sched_mmdd value= <%=data_ins_sched_mmdd%>> 
<input type="hidden" name=data_sched_mmdd id=data_sched_mmdd value= <%=data_sched_mmdd%>>
<input type="hidden" name=act id=act value="<%=act%>">
<input type="hidden" name="idSchedHidden" id="idSchedHidden" value="">
<input type="hidden" name="user" id="user" value="<%=user%>">
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
	        <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Elenco Schedulazioni</td>
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
      <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
	  <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td width="10%" class="textB" align="Left">&nbsp;Funzioni:&nbsp;</td>
                <td width="40%" class="text" align="Left">                             
                <%
                //CmbFunzioniSTL remote= home.create();
                Vector Funz = remoteComboFunzioni.getFunzioni();
                if ((Funz!=null)&&(Funz.size()!=0))
                {
                  // Visualizzo elementi
                  %>
                  <select class="text" title="combo funzioni" name="comboFunzioni" onchange="setInitialValue();">
                    <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                    <%
                    //if (selFunz != null)
                    //    codeFunzione = selFunz;
                    for(Enumeration e = Funz.elements();e.hasMoreElements();)
                    {
                      Funzioni elem = new Funzioni();
                      elem=(Funzioni)e.nextElement();
                      String selA="";
                      if (selFunz.equals(elem.getCodeFunzione()))
                        selA="selected";
                      %>
                      <option value="<%=elem.getCodeFunzione()%>" <%=selA%>><%=elem.getDescFunzione()%></option>
                      <%
                    }
                    %> 
                  </select>
                  <%   
                }
                else
                {
                  // Visualizzo solo [Seleziona Opzione]
                  %>
                  <select class="text" title="combo Funzioni" name="comboFunzioni" onchange="setInitialValue();">
                    <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                  </select>         
                  <%
                }
                %>
                </td>   
                <td width="50%" class="textB" align="Right" >&nbsp;Data Inserimento:&nbsp;
                  <input type="hidden" name=data_ins_sched_tmp id=data_ins_sched_tmp value= "<%=data_ins_sched%>"> 
                  <input size=20 class="text" type="text" align="right" name="data_ins_sched" value="<%=data_ins_sched%>">
                </td>
                <td size=5> &nbsp; <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='data_ins_sched' src="../../common/images/img/cal.gif" border="no"></a></td>
                <td size=5> &nbsp; <a href="javascript:cancelCalendar(document.frmSearch.data_ins_sched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data_ins_sched' src="../../common/images/img/images7.gif" border="0"></a></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td width="10%" class="textB" align="Left">&nbsp;Stati:&nbsp;</td>
                <td width="40%" class="text" align="Left">                             
                  <select class="text" title="Combo Stati" name="comboStati" onchange="setInitialValue();">
                  <%
                  String selBusy  = "";
                  String selDone  = "";
                  String selDump  = "";
                  String selSched = "";                  
                  if (selStato.equals("BUSY"))
                      selBusy="selected";
                  if (selStato.equals("DONE"))
                      selDone="selected";
                  if (selStato.equals("DUMP"))
                      selDump="selected";
                  if (selStato.equals("SCHD"))
                      selSched="selected";                        
                  %>
                    <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                    <option value="BUSY" <%=selBusy%>>Invio in corso<%=Utility.getSpazi(22)%></option>
                    <option value="DONE" <%=selDone%>>Schedulato<%=Utility.getSpazi(22)%></option>
                    <option value="DUMP" <%=selDump%>>Errore<%=Utility.getSpazi(22)%></option>
                    <option value="SCHD" <%=selSched%>>Da Schedulare<%=Utility.getSpazi(22)%></option>
                  </select>
                </td>
                <td width="50%" class="textB" align="Right">&nbsp;&nbsp;Data Schedulazione:&nbsp;
                  <input type="hidden" name=data_sched_tmp id=data_sched_tmp value= "<%=data_sched%>"> 
                  <input size=20 class="text" type="text" align="right" name="data_sched" value="<%=data_sched%>">
                </td>
                <td size=5> &nbsp; <a href="javascript:cal2.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='data_sched' src="../../common/images/img/cal.gif" border="no"></a></td>
                <td size=5> &nbsp; <a href="javascript:cancelCalendar(document.frmSearch.data_sched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data_sched' src="../../common/images/img/images7.gif" border="0"></a></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td width="10%" class="textB" align="Left">&nbsp;Utenti:&nbsp;</td>
                <td width="40%" class="text" align="Left">                             
                <%
                //CmbUtentiSTL remote= home2.create();
                utenti = remoteComboUtenti.getUtenti();
                if ((utenti!=null)&&(utenti.size()!=0))
                {
                  // Visualizzo elementi
                  %>
                  <select class="text" title="combo Utenti" name="comboUtenti" onchange="setInitialValue();">
                    <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                    <%
                    //codeUtente = selUtente;
                    for(Enumeration e = utenti.elements();e.hasMoreElements();)
                    {
                      ClassUtentiElem elem = new ClassUtentiElem();
                      elem=(ClassUtentiElem)e.nextElement();
                      String sel = "";
                      if (selUtente.trim().equalsIgnoreCase(elem.getCodeUtente())) 
                        sel="selected";
                      %>
                      <option value="<%=elem.getCodeUtente()%>" <%=sel%>><%=elem.getCodeUtente()%></option>
                      <%
                    }
                    %> 
                  </select>
                  <%   
                }
                else
                {
                  // Visualizzo solo [Seleziona Opzione]
                  %>
                  <select class="text" title="combo Utenti" name="comboUtenti" onchange="setInitialValue();">
                    <option value="-1" >[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                  </select>         
                  <%
                }
                %>
                <!-- </select> -->
                </td>   
                <td width="50%" class="text" align="Center">Risultati per pag.:&nbsp;
                  <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                    <option class="text" value=50>50</option>
                    <option class="text" value=100>100</option>
                    <option class="text" value=150>150</option>
                    <option class="text" value=200>200</option>
                  </select>
                </td>
              </tr>
            </table>
          </td>   
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorTabellaForm%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorTabellaForm%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
              </tr>
              <tr>
                <td>   
                  <sec:ShowButtons PageName="VERIFICA_SCHEDULAZIONI_1" />
                </td>   
              </tr>
            </table>
          </td>
        </tr>
      </td>
    </tr>
  </table>
  </td> 
  </tr>
  <tr>
   <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  <td>
    <table  width="90%" border="0" cellspacing="0" cellpadding="1" align='center'>
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                     <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Risultato ricerca</td>
                     <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
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
      <table width="90%" align='center' border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <%
        if ((SchedBatch==null)||(SchedBatch.size()==0))
        {
          %>
          <tr> 
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="7" class="textB" align="center">No Record Found</td>
          </tr>
          <%
        }
        else
        {
          %>
          <tr> 
            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class='white'>&nbsp;</td>
            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Utente </td>              
            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Codice </td>
            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Funzionalità </td>
            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Stato </td>
            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data/Ora Inserimento </td>
            <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data/Ora Schedulazione </td>
          </tr>

          <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=SchedBatch.size()%>">
            <pg:param name="typeLoad" value="1"></pg:param> 
            <pg:param name="codeFunzione" value="<%=codeFunzione%>"></pg:param>
            <pg:param name="codeStatoSched" value="<%=codeStatoSched%>"></pg:param> 
            <pg:param name="codeUtente" value="<%=codeUtente%>"></pg:param>
            <pg:param name="comboUtenti" value="<%=strComboUtente%>"></pg:param>
            <pg:param name="comboStati" value="<%=strComboStato%>"></pg:param>
            <pg:param name="comboFunzioni" value="<%=strComboFunzione%>"></pg:param>
            <pg:param name="txtDataDal" value="<%=data_ins_sched%>"></pg:param> 
            <pg:param name="txtDataAl" value="<%=data_sched%>"></pg:param> 
            <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
            <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
            <pg:param name="data_ins_sched" value="<%=data_ins_sched%>"></pg:param>
            <pg:param name="data_sched" value="<%=data_sched%>"></pg:param>
            <pg:param name="data_ins_sched_tmp" value="<%=data_ins_sched_tmp%>"></pg:param>
            <pg:param name="data_sched_tmp" value="<%=data_sched_tmp%>"></pg:param>
            <pg:param name="act" value="<%=act%>"></pg:param>

            <%
            String bgcolor="";
            String checked;  
            Object[] objs=SchedBatch.toArray();
            boolean first_rec=true;
            if ((SchedBatch!=null)&&(SchedBatch.size()!=0))
               // Visualizzo elementi
               for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<SchedBatch.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
               {
                  //OggFattBMP obj=(OggFattBMP)objs[i];
                  ClassSchedBatchElem obj=(ClassSchedBatchElem)objs[i];
                  if ((i%2)==0)
                    bgcolor=StaticContext.bgColorRigaPariTabella;
                  else
                    bgcolor=StaticContext.bgColorRigaDispariTabella;
                  %>
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                      <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelIdSched' checked = 'true' value='<%=obj.getIdSched()%>' onClick="ChangeSel('<%=obj.getIdSched()%>','<%=obj.getCodeStatoSched()%>','<%=obj.getCodeUtente()%>')">
                      <input type='hidden' name='SelCodeStatoSched' value='<%=obj.getCodeStatoSched()%>'>
                      <input type='hidden' name='SelUserSched' value='<%=obj.getCodeUtente()%>'>
                    </td>
                    <td bgcolor='<%=bgcolor%>' class='text' width="7%"><%=obj.getCodeUtente()%></td>
                    <td bgcolor='<%=bgcolor%>' class='text' width="7%"><%=obj.getCodeElab()%></td>
                    <td bgcolor="<%=bgcolor%>" class='text' width="20%"><%=obj.getDescFunz()%></td>
                    <td bgcolor='<%=bgcolor%>' class='text' width="13%"><%=obj.getDescStatoSched()%></td>
                    <td bgcolor="<%=bgcolor%>" class='text' width="31%"><%=obj.getDataOraInsSched()%></td>
                    <td bgcolor="<%=bgcolor%>" class='text' width="31%"><%=obj.getDataOraSched()%></td>
                  </tr>
                  <%    
               }
               %>
               <tr>
                <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="3" height='2'></td>
               </tr>
               <pg:index>
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="7" class="text" align="center">
                    Risultati Pag.
                    <pg:prev> 
                      <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                      <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                      <%
                    } 
                    %>
                    </pg:pages>
                    <pg:next>
                      <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
                    </pg:next>
                  </td>
                </tr>
              </pg:index>

            </pg:pager>
            <%
        }//chiusura dell'else
        %>
        <tr>
          <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
      </td>
    </tr>
    </table>
    </td> 
    </tr>
    </table> 
    </td>
    <input type="hidden" name=num_rec id=num_rec value="<%=SchedBatch.size()%>">
    </tr> 
    </table>
  </td>
</tr>
<tr> 
   <td>
      <table width="90%" align=center border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
            <td colspan='1' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
         </tr>
         <tr> 
           <td>
             <sec:ShowButtons VectorName="VERIFICA_SCHEDULAZIONI" /> 
           </td>  
          </tr>
      </table>       
   </td>  
</tr>
</table>
<input class="textB" type="hidden" name="typeLoad" value="">
<input class="textB" type="hidden" name="txtnumRec" value="<%=index%>">
<input class="textB" type="hidden" name="txtnumPag" value="1">
</form>
<script language="JavaScript">
	 var cal3 = new calendar1(document.forms['frmSearch'].elements['data_ins_sched']);
	 cal3.year_scroll = true;
	 cal3.time_comp = true;
   var cal2 = new calendar1(document.forms['frmSearch'].elements['data_sched']);
   cal2.year_scroll = true;
   cal2.time_comp = true;
 </script>
</BODY>
</HTML>
