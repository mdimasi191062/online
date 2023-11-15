<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Stati di Elaborazione Batch")%>
<%=StaticMessages.getMessage(3006,"StatiElabBatchSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String codeUtente        = request.getParameter("codeUtente");
if (codeUtente==null) codeUtente=request.getParameter("codeUtente");
if (codeUtente==null) codeUtente=(String)session.getAttribute("codeUtente");

String selFunz           = request.getParameter("selFunz");
String selStato          = request.getParameter("selStato");
String selUtente         = request.getParameter("selUtente");
String codeFunzione      = request.getParameter("codeFunzione");
String codeStatoBatch    = request.getParameter("codeStatoBatch");
String data_ini_mmdd    = Utility.getDateMMDDYYYY();
String data_fine_mmdd    = Utility.getDateMMDDYYYY();
//data_ini_mmdd = request.getParameter("data_ini_mmdd");
//data_fine_mmdd = request.getParameter("data_fine_mmdd");

String data_ini          = request.getParameter("data_ini");
if (data_ini==null) data_ini=request.getParameter("data_ini");
if (data_ini==null) data_ini=(String)session.getAttribute("data_ini");
//String data_ini = Utility.getDateDDMMYYYY();
//data_ini          = request.getParameter("data_ini");
//System.out.println("data_ini: "+data_ini);

String data_fine         = request.getParameter("data_fine");
if (data_fine==null) data_fine=request.getParameter("data_fine");
if (data_fine==null) data_fine=(String)session.getAttribute("data_fine");

String data_ini_tmp          = request.getParameter("data_ini_tmp");
if (data_ini_tmp==null) data_ini_tmp=request.getParameter("data_ini_tmp");
if (data_ini_tmp==null) data_ini_tmp=(String)session.getAttribute("data_ini_tmp");
Date DataOggi = new Date();
DataOggi = new Date(DataOggi.getTime()-(1000L*60*60*24*30)); 
//System.out.println("DataOggi: "+DataOggi);
java.text.SimpleDateFormat lastYearDateFmt = new java.text.SimpleDateFormat ("dd'/'MM'/'yyyy");


String data_fine_tmp         = request.getParameter("data_fine_tmp");
if (data_fine_tmp==null) data_fine_tmp=request.getParameter("data_fine_tmp");
if (data_fine_tmp==null) data_fine_tmp=(String)session.getAttribute("data_fine_tmp");

String act=request.getParameter("act");

if (codeFunzione == null)
    codeFunzione = "";
if (codeStatoBatch == null)
    codeStatoBatch = "";
if (codeUtente == null)
    codeUtente = "";

String title="";

if (act == null) 
{
    data_ini = "";
    data_ini_mmdd = "";
    data_fine = "";
    data_fine_mmdd = "";
    selUtente = "";
    selFunz = "";
    selStato = "";
    data_ini_tmp = "";
    data_ini_tmp = lastYearDateFmt.format(DataOggi);
}

Vector funzioni=null; // per il caricamento della combo Funzioni
Vector stati_batch=null; //per il caricamento della combo degli stati batch
Vector utenti=null; //per il caricamento della combo degli utenti
Collection StatiElabBatch; //per il caricamento della lista degli stati elab batch

// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null)
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }

// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
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
if (data_ini_tmp != null && !data_ini_tmp.trim().equalsIgnoreCase(""))
{
//String tmpTxtDataDal = data_fine_tmp;
data_ini = data_ini_tmp;
}
if (data_fine_tmp != null && !data_fine_tmp.trim().equalsIgnoreCase(""))
{
//String tmpTxtDataAl = strDataFine;
data_fine = data_fine_tmp;
}

%>
<EJB:useHome id="homeStatiElabBatch" type="com.ejbSTL.StatiElabBatchSTLHome" location="StatiElabBatchSTL" /> 
<EJB:useBean id="remoteStatiElabBatch" type="com.ejbSTL.StatiElabBatchSTL" value="<%=homeStatiElabBatch.create()%>" scope="session"></EJB:useBean>
<%
   if (typeLoad!=0)
   {
     StatiElabBatch = (Collection) session.getAttribute("StatiElabBatch");
   }
   else
   {
           StatiElabBatch = remoteStatiElabBatch.getStatiElabBatch(codeFunzione, codeStatoBatch, codeUtente, data_ini, data_fine);
           if (StatiElabBatch!=null)
              session.setAttribute("StatiElabBatch", StatiElabBatch);
   }

%>
<EJB:useHome id="homeComboFunzioni"   type="com.ejbSTL.CmbFunzioniSTLHome"   location="CmbFunzioniSTL" />
<EJB:useBean id="remoteComboFunzioni" type="com.ejbSTL.CmbFunzioniSTL" value="<%=homeComboFunzioni.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeComboStatiBatch" type="com.ejbSTL.CmbStatiBatchSTLHome" location="CmbStatiBatchSTL" />
<EJB:useBean id="remoteComboStatiBatch" type="com.ejbSTL.CmbStatiBatchSTL" value="<%=homeComboStatiBatch.create()%>" scope="session"></EJB:useBean>
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
<SCRIPT LANGUAGE='Javascript'>
//IExplorer =document.all?true:false;
//Navigator =document.layers?true:false;

//Variabili locali
var SelCodeElab = "";
var SelFlagSys = "";
var codStatiBatchSel = "";
var mese = "";
//var Data = new Date();
//alert("Data:"+Data);

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
Disable(document.frmSearch.DETTAGLI);
Disable(document.frmSearch.data_ini);
Disable(document.frmSearch.data_fine);
  if (document.frmSearch.comboFunzioni.value!=-1)
  {
      document.frmSearch.selFunz.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;
      //document.frmSearch.codeFunzione.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;      
  }
  if (document.frmSearch.comboStati.value!=-1)
  {
      document.frmSearch.selStato.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
      //document.frmSearch.codeStatoBatch.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
  }
  if (document.frmSearch.comboUtenti.value!=-1)
  {
      document.frmSearch.selUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;     
      //document.frmSearch.codeUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;           
  }
  if (document.frmSearch.num_rec.value != null && document.frmSearch.num_rec.value != 0)
      Enable(document.frmSearch.DETTAGLI); 

  if (document.frmSearch.data_ini.value == "null")
      document.frmSearch.data_ini.value = "";
  if (document.frmSearch.data_fine.value == "null")
      document.frmSearch.data_fine.value = "";

//  mese = Data.getMonth() - 1;
//  alert("mese:"+mese);
//  Data.setMonth(mese);
//  alert("Data:"+Data);
//  document.frmSearch.data_ini_tmp.value = Data;
//  alert("data_ini_tmp:"+document.frmSearch.data_ini_tmp.value);
//submitFrmSearch(0);    
  typeLoad = "0";
  document.frmSearch.typeLoad.value = typeLoad;

  //Setta il numero di record  
eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
//Setta il primo elemento della lista
  if (String(document.frmSearch.SelCodeElab)!="undefined")
  {
    if (document.frmSearch.SelCodeElab.lenght=="undefined")
    {
      document.frmSearch.SelCodeElab.checked=true; 
    }
    else
    {
      if (document.frmSearch.SelCodeElab[1])
      {
         document.frmSearch.SelCodeElab[0].checked=true;
         codeElab = document.frmSearch.SelCodeElab[0].value;
         flagSys =  document.frmSearch.SelFlagSys[0].value;
      }
      else   
      {
         codeElab = document.frmSearch.SelCodeElab.value;
         flagSys =  document.frmSearch.SelFlagSys.value;
      }
    }
       ChangeSel(codeElab,flagSys);
  }
}

function CancelMe()
{
  self.close();
	return false;
}

var message1="Click per selezionare la data";
var message2="Click per cancellare la data selezionata";

function cancelLink ()
{
  return false;
}

function cancelCalendar1 ()
{
  document.frmSearch.data_ini.value="";
}

function cancelCalendar2 ()
{
  document.frmSearch.data_fine.value="";
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
    document.frmSearch.data_ini.value = "";
    document.frmSearch.data_fine.value = "";
    document.frmSearch.comboFunzioni[0].selected = true;
    //document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value = -1;
    document.frmSearch.comboStati[0].selected = true;
    //document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value = -1;
    document.frmSearch.comboUtenti[0].selected = true;
    //document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value = -1;
    index=0;
    document.frmSearch.strIndex = null;
    document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
    Enable(document.frmSearch.data_ini);
    Enable(document.frmSearch.data_fine);
}

function ChangeSel(SelCodeElab,SelFlagSys)
{
  codeElab = SelCodeElab;
  flagSys =  SelFlagSys;
  if (flagSys =="S" || flagSys =="s")
  {
//     alert("S "+flagSys) ;
     Enable(document.frmSearch.DETTAGLI);
  }   
  else   
  {
//     alert("C "+flagSys) ;
     Disable(document.frmSearch.DETTAGLI);
  }   
}

function ONDETTAGLI()
{
    document.frmSearch.act.value="DETTAGLI";    
    var ElencoAccountPsSp = "../../stati_elab/jsp/ElencoAccountPsSp.jsp?codeElab="+codeElab+"&flagSys="+flagSys;
    openDialog(ElencoAccountPsSp, 569, 400, handleReturnedValuePS);
    handleReturnedValuePS();
}

function handleReturnedValuePS()
{
//window.alert("ritorno dalla ElencoAccountPsSp");
}

function disabilitato()
{
  if (Navigator)
  {
    document.frmSearch.POPOLALISTA.focus();
    alert('campo protetto');
  }
}

function ONPOPOLALISTA()
{
    document.frmSearch.act.value = "POPOLALISTA";
    document.frmSearch.data_ini_tmp.value = document.frmSearch.data_ini.value;
    document.frmSearch.data_fine_tmp.value = document.frmSearch.data_fine.value;
    document.frmSearch.selFunz.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;
    document.frmSearch.codeFunzione.value = document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value;
    if (document.frmSearch.comboFunzioni[document.frmSearch.comboFunzioni.selectedIndex].value==-1)
    {
        document.frmSearch.selFunz.value = "";
        document.frmSearch.codeFunzione.value = "";
    }

    document.frmSearch.selStato.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
    document.frmSearch.codeStatoBatch.value = document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value;
    if (document.frmSearch.comboStati[document.frmSearch.comboStati.selectedIndex].value==-1)
    {
        document.frmSearch.selStato.value = "";
        document.frmSearch.codeStatoBatch.value = "";
    }   

    document.frmSearch.selUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;
    document.frmSearch.codeUtente.value = document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value;
    if (document.frmSearch.comboUtenti[document.frmSearch.comboUtenti.selectedIndex].value==-1)
    {
        document.frmSearch.selUtente.value = "";
        document.frmSearch.codeUtente.value = "";
    }

    //controllo le date
    if ((document.frmSearch.data_ini.value != null && document.frmSearch.data_ini.value != "") &&
        (document.frmSearch.data_fine.value  != null && document.frmSearch.data_fine.value  != ""))
    {
      ProvaDataDal = document.frmSearch.data_ini.value.substring(10,6)
             + document.frmSearch.data_ini.value.substring(5,3)
             + document.frmSearch.data_ini.value.substring(2,0);
      ProvaDataAl  = document.frmSearch.data_fine.value.substring(10,6)
             + document.frmSearch.data_fine.value.substring(5,3)
             + document.frmSearch.data_fine.value.substring(2,0);
      if (ProvaDataDal > ProvaDataAl) 
      {
            window.alert("Attenzione: 'Data dal:' maggiore di 'Data al:'");
            return;
      }
    }
    Enable(document.frmSearch.data_ini);
    Enable(document.frmSearch.data_fine);
    submitFrmSearch(0);
}

</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="StatiElabBatchSp.jsp">
<input type="hidden" name="selFunz" id=selFunz value="<%=selFunz%>"> 
<input type="hidden" name="selStato" id=selStato value="<%=selStato%>"> 
<input type="hidden" name="selUtente" id=selUtente value="<%=selUtente%>"> 
<input type="hidden" name="codeFunzione" id=selFunz value="<%=codeFunzione%>"> 
<input type="hidden" name="codeStatoBatch" id=selStato value="<%=codeStatoBatch%>"> 
<input type="hidden" name="codeUtente" id=codeUtente value="<%=codeUtente%>">
<input type="hidden" name=data_ini_mmdd id=data_ini_mmdd value= <%=data_ini_mmdd%>> 
<input type="hidden" name=data_fine_mmdd id=data_fine_mmdd value= <%=data_fine_mmdd%>>
<input type="hidden" name=act id=act value="<%=act%>">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Stati Elaborazione Batch</td>
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
                             <td width="50%" class="textB" align="Right" >&nbsp;Dal:&nbsp;
                                 <input type="hidden" name=data_ini_tmp id=data_ini_tmp value= "<%=data_ini%>"> 
                                  <input size=10 class="text" type="text" align="right" name="data_ini" value="<%=data_ini%>"></td>
                                  <td size=5> &nbsp;    <a href="javascript:showCalendar('frmSearch.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                  <td size=5>  &nbsp;   <a href="javascript:cancelCalendar1();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td>
                            
                         </tr>
            </table>
          </td>
        </tr>
        <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                        <tr>
                           <td width="10%" class="textB" align="Left">&nbsp;Stati:<%=Utility.getSpazi(7)%></td>
                           <td width="40%" class="text" align="Left">                             
                           <%
                           //CmbStatiBatchSTL remote= home.create();
                            Vector StatiBatch = remoteComboStatiBatch.getStatiBatch();
                            if ((StatiBatch!=null)&&(StatiBatch.size()!=0))
                            {
                             // Visualizzo elementi
                            %>
                            <select class="text" title="Combo Stati" name="comboStati" onchange="setInitialValue();">
                            <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                            <%
                              //if (selStato != null)
                              //    codeStatoBatch = selStato;
                              for(Enumeration e = StatiBatch.elements();e.hasMoreElements();)
                              {
                                ClassStatiBatchElem elem = new ClassStatiBatchElem();
                                elem=(ClassStatiBatchElem)e.nextElement();
                                String selB="";
                                if (selStato.equals(elem.getCodeStatoBatch())) 
                                    selB="selected";
                            %>
                                <option value="<%=elem.getCodeStatoBatch()%>" <%=selB%>><%=elem.getDescStatoBatch()%></option>
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
                            <select class="text" title="Combo Stati" name="comboStati" onchange="setInitialValue();">
                            <option value="-1" selected>[Seleziona Opzione]<%=Utility.getSpazi(22)%></option>
                            </select>         
                            <%
                            }
                            %>
                            </td>
                            <td width="50%" class="textB" align="Right">&nbsp;&nbsp;Al:&nbsp;
                                <input type="hidden" name=data_fine_tmp id=data_fine_tmp value= "<%=data_fine%>"> 
                                <input size=10 class="text" type="text" align="right" name="data_fine" value="<%=data_fine%>"></td>
                                <td size=5> &nbsp;      <a href="javascript:showCalendar('frmSearch.data_fine','<%=data_fine_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img src="../../common/images/body/calendario.gif" border="0" valign="Bottom" alt="Click per selezionare una data"  WIDTH="24" HEIGHT="24"></a></td>
                                <td size=5> &nbsp;      <a href="javascript:cancelCalendar2();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0" valign="Bottom" WIDTH="24" HEIGHT="24"></a>&nbsp;</td>
                            
                        </tr>
            </table>
          </td>
        </tr>
        <tr>
            <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                        <tr>
                           <td width="10%" class="textB" align="Left">&nbsp;Utenti:<%=Utility.getSpazi(5)%></td>
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
                         <sec:ShowButtons PageName="STATIELABBATCHSP_1" />
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
                  //StatiElabBatch = remoteStatiElabBatch.getStatiElabBatch(codeFunzione, codeStatoBatch, codeUtente, data_ini, data_fine);
                  if ((StatiElabBatch==null)||(StatiElabBatch.size()==0))
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
              <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Codice </td>
              <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Funzionalità </td>
              <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Utente </td>
              <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Stato elaborazione </td>
              <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data/Ora Inizio </td>
              <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Esito </td>
            </tr>


          <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=StatiElabBatch.size()%>">
            <pg:param name="typeLoad" value="1"></pg:param> 
            <pg:param name="codeFunzione" value="<%=codeFunzione%>"></pg:param> 
            <pg:param name="codeStatoBatch" value="<%=codeStatoBatch%>"></pg:param> 
            <pg:param name="codeUtente" value="<%=codeUtente%>"></pg:param>
            <pg:param name="comboUtenti" value="<%=strComboUtente%>"></pg:param>
            <pg:param name="comboStati" value="<%=strComboStato%>"></pg:param>
            <pg:param name="comboFunzioni" value="<%=strComboFunzione%>"></pg:param>
            <pg:param name="txtDataDal" value="<%=data_ini%>"></pg:param> 
            <pg:param name="txtDataAl" value="<%=data_fine%>"></pg:param> 
            <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
            <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>

            <pg:param name="data_ini" value="<%=data_ini%>"></pg:param>
            <pg:param name="data_fine" value="<%=data_fine%>"></pg:param>
            <pg:param name="data_ini_tmp" value="<%=data_ini_tmp%>"></pg:param>
            <pg:param name="data_fine_tmp" value="<%=data_fine_tmp%>"></pg:param>
            <pg:param name="act" value="<%=act%>"></pg:param>


                

                <%
                String bgcolor="";
                String checked;  
                Object[] objs=StatiElabBatch.toArray();
                boolean first_rec=true;
                if ((StatiElabBatch!=null)&&(StatiElabBatch.size()!=0))
                    // Visualizzo elementi
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<StatiElabBatch.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                    {
                    //OggFattBMP obj=(OggFattBMP)objs[i];
                    ClassStatiElabBatchElem obj=(ClassStatiElabBatchElem)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                           <% 
                           String flagSys=obj.getFlagSys();
                           if (flagSys==null || ( flagSys!=null &&  (!flagSys.equalsIgnoreCase("S") && !flagSys.equalsIgnoreCase("C"))))
                                  flagSys=" ";%>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelCodeElab' checked = 'true' value='<%=obj.getCodeElab()%>' onClick="ChangeSel('<%=obj.getCodeElab()%>','<%=flagSys%>')">
                            <input type='hidden'  name='SelFlagSys' value='<%=obj.getFlagSys()%>'>
                        </td>

                         <td bgcolor='<%=bgcolor%>' class='text' width="7%"><%=obj.getCodeElab()%><%=obj.getFlagSys()%></td>
                         <td bgcolor="<%=bgcolor%>" class='text' width="20%"><%=obj.getDescFunz()%></td>
                         <td bgcolor='<%=bgcolor%>' class='text' width="13%"><%=obj.getCodeUtente()%></td>
                         <td bgcolor="<%=bgcolor%>" class='text' width="31%"><%=obj.getDescStato()%></td>
                        
                <%    
                        if (obj.getDataOraIniBatch()==""){ 
                %>
                        <td bgcolor="<%=bgcolor%>" class="text">&nbsp;</td>
                <%    
                       } else{
                %>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataOraIniBatch()%></td>

                    <%} %>
                 <% if ((obj.getEsitoBatch()==null) || (obj.getEsitoBatch().equals("")))
                    {%>
                    <td bgcolor="<%=bgcolor%>" class='text' width="8%">&nbsp;</td>
                 <% }else{ %>
                     <td bgcolor="<%=bgcolor%>" class='text' width="8%"><%=obj.getEsitoBatch()%></td>
                 <% } %>                    
            </tr>
                <%    
                    }
                %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
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
                                  <%//pageUrl +"&data_ini="+data_ini+"&data_fine="+data_fine+"&data_ini_tmp="+data_ini_tmp+"&data_fine_tmp="+data_fine_tmp+"&act="+act;%>
                                <%
                                  } 
                                %>
                                
                          </pg:pages>

                          <pg:next>
                                 <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>

<%//                                 pageUrl +"&data_ini="+data_ini+"&data_fine="+data_fine+"&data_ini_tmp="+data_ini_tmp+"&data_fine_tmp="+data_fine_tmp+"&act="+act;%>
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
        <input type="hidden" name=num_rec id=num_rec value="<%=StatiElabBatch.size()%>">
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
             <sec:ShowButtons VectorName="BOTTONI" /> 
           </td>  
          </tr>
      </table>       
   </td>  
</tr>
</table>
                             <!--input type="hidden" name="txtnumPag" value="1">
                             <input type="hidden" name="typeLoad" value="">
                             <input type="hidden" name="txtnumRec" value=""-->
                             <input class="textB" type="hidden" name="typeLoad" value="">
                             <input class="textB" type="hidden" name="txtnumRec" value="<%=index%>">
                             <input class="textB" type="hidden" name="txtnumPag" value="1">
</form>
</BODY>
</HTML>
