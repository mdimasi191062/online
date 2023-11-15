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
<%=StaticMessages.getMessage(3006,"estrazioniCA.jsp")%>
</logtag:logData>

<EJB:useHome id="homeEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContrattoHome" location="Ent_TipiContratto" />
<EJB:useBean id="remoteEnt_TipiContratto" type="com.ejbSTL.Ent_TipiContratto" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipiContratto.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeEstrazioniConfSTL" type="com.ejbSTL.EstrazioniConfSTLHome" location="EstrazioniConf" />
<EJB:useBean id="remoteEstrazioniConfSTL" type="com.ejbSTL.EstrazioniConfSTL" scope="session">
    <EJB:createBean instance="<%=homeEstrazioniConfSTL.create()%>" />
</EJB:useBean>

<% 
  response.addHeader("Pragma", "no-cache"); 
  response.addHeader("Cache-Control", "no-store");
    //---------------------------------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    

  ClassEstrazioniConsAttive remote = null;       
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
  String bgcolor="";
    //Flag per individuare se una riga é selezionata

  int i=0;
  int j=0;
  int iPagina=0;  

    Vector aRemote2 = null;

    String strCodeServizio = Misc.nh(request.getParameter("strCodeServizio"));
    String strDataCompDa = Misc.nh(request.getParameter("strDataCompDa"));
    String strDataCompA = Misc.nh(request.getParameter("strDataCompA"));
    String strCodeAccount = Misc.nh(request.getParameter("strCodeAccount"));
    String strDescAccount = Misc.nh(request.getParameter("strDescAccount"));
    String strCodeProdotto =  Misc.nh(request.getParameter("strCodeProdotto"));
    String strDescProdotto =  Misc.nh(request.getParameter("strDescProdotto"));
    
    Vector servizioVector = new Vector();//remoteEnt_Inventari.getServizi();
    servizioVector.addAll(remoteEnt_TipiContratto.getTipiContratto(null,null));

//RIMOZIONE SERVIZI IAV
//COD_SERVIZIO not in ('62','63','64','65','66','67','68','69','70','71','72','73','74')
    String[] valoriIav = {"62","63","64","65","66","67","68","69","70","71","72","73","74"};
    for(int xy=servizioVector.size()-1;xy>=0;xy--) {
        for(String item : valoriIav){
            if (((DB_TipiContratto)servizioVector.get(xy)).getCODE_TIPO_CONTR().equals(item)) {
                servizioVector.remove(xy);
            }
        }
    }

  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
 
    //eventuale Filtro di ricerca
  String strCodRicerca= request.getParameter("txtCodRicerca");

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
      
    if ( strCodeServizio != null && !"".equals(strCodeServizio)) 
        aRemote2=remoteEstrazioniConfSTL.getEstrazioniConsistenzeAttive(strCodeServizio,strDataCompDa,strDataCompA,strCodeAccount,strCodeProdotto);
        
    session.setAttribute( "aRemote2", aRemote2);  
  }
  //------------------------------------------------------------------------------
  //Fine Standard Ricerca
  //------------------------------------------------------------------------------  

String dataUltimoAgg = remoteEstrazioniConfSTL.getUltimoAggiornamento();

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

  /*var codServizio = document.frmSearch.strCodeServizio.value;
  var codAccount =  document.frmSearch.strCodeAccount.value;
  var dataInizio = document.frmSearch.strDataCompDa.value;
  var dataFine = document.frmSearch.strDataCompA.value;
  var flagFunzione = typeExport;
  var codeProdotto = document.frmSearch.strCodeProdotto.value;
    
  carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};  
  var asyncFunz= function(){ handler_generico(http,carica,errore);};
  
  var sendMessage='codeFunz=40&id_funz=1&codServizio='+codServizio+'&codAccount='+codAccount+'&dataInizio='+dataInizio+'&dataFine='+dataFine+'&flagFunzione='+flagFunzione+'&codeProdotto='+codeProdotto+'&codeTipoContr='+codServizio;
  
  chiamaRichiesta(sendMessage,'ExportCsvConsAttive',asyncFunz);*/
  
  openDialog("stampa_estrazioniCA.jsp", 30, 50, " ,scrollbars=1, resizable=1, toolbar=0, status=0, menubar=1");
}

function click_cmdAccount(){
      var URL = '';
      var URLParam = '?Servizio=' + document.frmSearch.comboTipoContr[document.frmSearch.comboTipoContr.selectedIndex].value+ '&CodAccountSel='+frmSearch.txtCodeAccount.value+ '&DescAccountSel=' + encodeURI(frmSearch.txtDescAccount.value)// +frmSearch.txtDescAccount.value;
      URL='seleziona_account.jsp' + URLParam;
      openCentral(URL,'Account','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}


function click_cmdProdotto() {

  var URL = '';
  var URLParam = '?Servizio=' + document.frmSearch.comboTipoContr[document.frmSearch.comboTipoContr.selectedIndex].value + '&CodProdottoSel='+frmSearch.txtCodeProdotto.value+ '&DescProdottoSel='+ encodeURI(frmSearch.txtDescProdotto.value);
  URL = 'seleziona_prodotto.jsp' + URLParam;
  openCentral(URL,'Prodotto','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',600,400);
}

function onChangeTipoContr() {

   if(frmSearch.txtDataCompA.value != "" && frmSearch.txtDataCompDa.value != "" && frmSearch.comboTipoContr.selectedIndex >0) {
    Enable(frmSearch.Esegui);
<%
if ( aRemote2 != null && aRemote2.size() > 0 ) {
%>
    Enable(frmSearch.Esporta);
<% } %>

   } else {
    Disable(frmSearch.Esegui);
    Disable(frmSearch.Esporta);
   }
   
   if (frmSearch.comboTipoContr.selectedIndex >0) {
    Enable(frmSearch.cmdAccount);
    Enable(frmSearch.txtCodeAccount);
    Enable(frmSearch.txtDescAccount);
    Enable(frmSearch.cmdProdotto);
    Enable(frmSearch.txtCodeProdotto);
    Enable(frmSearch.txtDescProdotto);
   } else {
    Disable(frmSearch.cmdAccount);
    Disable(frmSearch.txtCodeAccount); frmSearch.txtCodeAccount.value="";
    Disable(frmSearch.txtDescAccount); frmSearch.txtDescAccount.value="";
    Disable(frmSearch.cmdProdotto);
    Disable(frmSearch.txtCodeProdotto); frmSearch.txtCodeProdotto.value="";
    Disable(frmSearch.txtDescProdotto); frmSearch.txtDescProdotto.value="";
   }
   
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.strCodeServizio.value=document.frmSearch.comboTipoContr[document.frmSearch.comboTipoContr.selectedIndex].value;
  document.frmSearch.strDataCompDa.value=document.frmSearch.txtDataCompDa.value;
  document.frmSearch.strDataCompA.value=document.frmSearch.txtDataCompA.value;
  document.frmSearch.strCodeAccount.value=document.frmSearch.txtCodeAccount.value;
  document.frmSearch.strDescAccount.value=document.frmSearch.txtDescAccount.value;
  document.frmSearch.strCodeProdotto.value=document.frmSearch.txtCodeProdotto.value;
  document.frmSearch.strDescProdotto.value=document.frmSearch.txtDescProdotto.value;
  document.frmSearch.txtTypeLoad.value='0';
  //document.frmSearch.submit();
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
  
   if(frmSearch.txtDataCompA.value == "") {
            alert("Il campo Data Competenza DA e' obbligatorio!");
            // do il fuoco all'oggetto corrente
            setFocus(frmSearch.txtDataCompA);
            return false;
   } else if(frmSearch.txtDataCompDa.value == "") {
            alert("Il campo Data Competenza A e' obbligatorio!");
            // do il fuoco all'oggetto corrente
            setFocus(frmSearch.txtDataCompDa);
            return false;
   } else if(frmSearch.comboTipoContr.selectedIndex <=0) {
            alert("Il campo Servizio e' obbligatorio!");
            // do il fuoco all'oggetto corrente
            setFocus(frmSearch.comboTipoContr);
            return false;

   } else {
   
    var today = new Date();
    var mm1 = parseInt(frmSearch.txtDataCompDa.value.substr(3,2),10);
    var mm2 = parseInt(frmSearch.txtDataCompA.value.substr(3,2),10);
    var date1 = new Date(frmSearch.txtDataCompDa.value.substr(6,4), mm1-1, frmSearch.txtDataCompDa.value.substr(0,2));
    var date2 = new Date(frmSearch.txtDataCompA.value.substr(6,4), mm2-1, frmSearch.txtDataCompA.value.substr(0,2));
    var diff = new Date(date2.getTime() - date1.getTime());
    
    if ( parseInt(frmSearch.txtDataCompDa.value.substr(3,2))-1 > today.getUTCMonth() && today.getUTCFullYear() <= date1.getUTCFullYear() ) {
        alert ("Data di competenza da successivo al mese corrente.");

    } else if ( parseInt(frmSearch.txtDataCompA.value.substr(3,2))-1 > today.getUTCMonth() && today.getUTCFullYear() <= date1.getUTCFullYear() ) {
        alert ("Data di competenza a successivo al mese corrente.");
        
    } else if ( diff.getUTCFullYear() <= 1970  ) { 
   
      document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
      document.frmSearch.strCodeServizio.value=document.frmSearch.comboTipoContr[document.frmSearch.comboTipoContr.selectedIndex].value;
      document.frmSearch.strDataCompDa.value=document.frmSearch.txtDataCompDa.value;
      document.frmSearch.strDataCompA.value=document.frmSearch.txtDataCompA.value;
      document.frmSearch.strCodeAccount.value=document.frmSearch.txtCodeAccount.value;
      document.frmSearch.strDescAccount.value=document.frmSearch.txtDescAccount.value;
      document.frmSearch.strCodeProdotto.value=document.frmSearch.txtCodeProdotto.value;
      document.frmSearch.strDescProdotto.value=document.frmSearch.txtDescProdotto.value;
      
      document.frmSearch.txtTypeLoad.value=typeLoad;
      
      orologio.style.visibility='visible';
      orologio.style.display='inline'  
  
      maschera.style.visibility='hidden';
      maschera.style.display='none'  

      document.frmSearch.submit();
    } else {
        alert ("Data di competenza a e Data di competenza da devono avere una finestra temporale massima di un anno.");
    }
  }
}  

function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

function dettaglioConsAtt(Servizio,
                          DescServizio,
                          Operatore,
                          DescOperatore,
                          Prodotto,
                          DescProdotto,
                          MeseAnnoComp, 
                          strDataCompDa, 
                          strDataCompA)
{
      var URL = '';
      var URLParam = '?Servizio=' + Servizio + 
                     '&DescServizio=' + DescServizio.replace("'","") + 
                     '&Operatore=' + Operatore + 
                     '&DescOperatore=' + DescOperatore.replace("'","") +                     
                     '&Prodotto=' + Prodotto + 
                     '&DescProdotto=' + DescProdotto.replace("'","") +
                     '&MeseAnnoComp=' + MeseAnnoComp + 
                     '&strDataCompDa='+ strDataCompDa + 
                     '&strDataCompA=' + strDataCompA;
                     
      URL='dettaglioEstrazioniCA.jsp' + URLParam;
      openCentral(URL,'Dettaglio','directories=no,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no',1000,600);
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
<BODY onload="setnumRec();inizializza();" onfocus="onChangeTipoContr();">


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
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="estrazioniCA.jsp">
<input type=hidden name="strCodeServizio" value="<%=strCodeServizio%>">
<input type=hidden name="strDataCompDa" value="<%=strDataCompDa%>">
<input type=hidden name="strDataCompA" value="<%=strDataCompA%>">
<input type=hidden name="strCodeAccount" value="<%=strCodeAccount%>">
<input type=hidden name="strDescAccount" value="<%=strDescAccount%>">
<input type=hidden name="strCodeProdotto" value="<%=strCodeProdotto%>">
<input type=hidden name="strDescProdotto" value="<%=strDescProdotto%>">


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPaginaCA.GIF" alt="" border="0"></td>
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
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Estrazioni Consistenze Attive</td>
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
                        <td width="30%" class="textB" align="right">Data di competenza da:&nbsp;</td>
                        <td width="50%" class="text">
                                <input type='text' name='txtDataCompDa' value='<%=strDataCompDa%>' class="text" readonly="" onfocus="onChangeTipoContr();">
                                <a href="javascript:showCalendar('frmSearch.txtDataCompDa','');" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                                <a href="javascript:clearField(frmSearch.txtDataCompDa);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                        </td>
                        <td width="20%" class="textB" align="right">Ultimo aggiornamento:<br><%=dataUltimoAgg%></td>
                    </tr>
                    <tr>
                        <td width="30%" class="textB" align="right">Data di competenza a:&nbsp;</td>
                        <td width="50%" class="text">
                                <input type='text' name='txtDataCompA' value='<%=strDataCompA%>' class="text" readonly="" onfocus="onChangeTipoContr();" >
                                <a href="javascript:showCalendar('frmSearch.txtDataCompA','');" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                                <a href="javascript:clearField(frmSearch.txtDataCompA);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                        </td>
                        <td width="20%" class="textB"></td>
                    </tr>                    
        
                      <tr>
                        <td width="30%" class="textB" align="right">Servizio:&nbsp;</td>
                        <td width="50%" class="text"><select name="comboTipoContr" width="10px" class="text" onchange="onChangeTipoContr();">
                        <option class="text" value="0">Seleziona Servizio</option>
                        <%
                            if ((servizioVector!=null)&&(servizioVector.size()!=0))
                            {
                                String selected = "";
                                for (j=0; j<servizioVector.size();j++) {
                                    
                                        DB_TipiContratto myelement=new DB_TipiContratto();
                                        myelement=(DB_TipiContratto)servizioVector.elementAt(j);
                                        if ( strCodeServizio.equals(myelement.getCODE_TIPO_CONTR()) ) {
                                            selected = "selected";
                                        } else {
                                            selected = "";
                                        }
                                    %>
                                    <option class="text" <%=selected %> value="<%=myelement.getCODE_TIPO_CONTR()%>"><%=myelement.getDESC_TIPO_CONTR()%></option>
                                    <%
                                }
                            }
                        %>
                        
                        </select></td>
                        <td width="20%" class="textB"></td>
                      </tr>
        
                      <tr>
                        <td width="30%" class="textB" align="right">Operatore/i:&nbsp;</td>
                        <td width="50%" class="text">
                        <span>
                            <INPUT type="hidden" class="text" id="txtCodeAccount" name="txtCodeAccount" disabled readonly obbligatorio="si" tipocontrollo="intero" label="Codice Account" Update="false" size="13" value="<%=strCodeAccount%>">
                            <textarea  class="text" id="txtDescAccount" name="txtDescAccount" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Account" Update="false" rows="5" cols="40"><%=strDescAccount%></textarea>
                            <input disabled class="text" title="Selezione Account" type="button" maxlength="30" name="cmdAccount" value="..." onClick="click_cmdAccount();">
                            <a style="VERTICAL-ALIGN: text-bottom" href="javascript:clearField(frmSearch.txtCodeAccount);clearField(frmSearch.txtDescAccount);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                        </span>
                        </td>
                        <td class="textB"></td>
                      </tr>
        
                      <tr>
                        <td width="30%" class="textB" align="right">Prodotto/i:&nbsp;</td>
                        <td width="50%" class="text">
                        <span>
                              <INPUT type="hidden" class="text" id="txtCodeProdotto" name="txtCodeProdotto" disabled readonly obbligatorio="si" tipocontrollo="intero" label="Codice Prodotto" Update="false" size="13" value="<%=strCodeProdotto%>">
                              <textarea  class="text" id="txtDescProdotto" name="txtDescProdotto" readonly obbligatorio="si" tipocontrollo="intero" label="Descrizione Prodotto" Update="false" rows="5" cols="40"><%=strDescProdotto%></textarea>
                              <input disabled class="text" title="Selezione Prodotto" type="button" maxlength="30" name="cmdProdotto" value="..." onClick="click_cmdProdotto();" >
                              <a style="VERTICAL-ALIGN: text-bottom" href="javascript:clearField(frmSearch.txtCodeProdotto);clearField(frmSearch.txtDescProdotto);" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                        </span>
                        <%--<select name="comboProdotti" multiple width="10px" class="text" onchange=""></select>
                        --%></td>
                        <td class="textB"></td>
                      </tr>                    
                            
                    
                    <tr>
                      <td width="30%" class="textB" align="right"></td>
                      <td  width="50%" class="text"></td>
                      <td width="20%" rowspan='2' class="textB" valign="center" align="center">
                        <input disabled class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
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
                          <td bgcolor='#D5DDF1' class="textB" width="10%">Servizio</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Operatore</td>
                          <td bgcolor='#D5DDF1' class="textB" width="20%">Prodotto</td>
                          <td bgcolor='#D5DDF1' class="textB" width="30%">Mese Competenza</td>                         
                          <td bgcolor='#D5DDF1' class="textB" width="15%">Numero Consistenze</td> 
                          <td bgcolor='#D5DDF1' class="textB" width="5%">Dettaglio</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote2.size()%>">
<pg:param name="txtTypeLoad" value="1"></pg:param>
<pg:param name="strCodeServizio" value="<%=strCodeServizio%>"></pg:param>
<pg:param name="strDataCompDa" value="<%=strDataCompDa%>"></pg:param>
<pg:param name="strDataCompA" value="<%=strDataCompA%>"></pg:param>
<pg:param name="strCodeAccount" value="<%=strCodeAccount%>"></pg:param>
<pg:param name="strDescAccount" value="<%=strDescAccount%>"></pg:param>
<pg:param name="strCodeProdotto" value="<%=strCodeProdotto%>"></pg:param>
<pg:param name="strDescProdotto" value="<%=strDescProdotto%>"></pg:param>

<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%

      //Scrittura dati su lista
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote2.size()) && (j<pagerPageNumber.intValue()*records_per_page));j++)      
      {
         remote = (ClassEstrazioniConsAttive) aRemote2.elementAt(j);                                                
         if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";

%>
                        <TR>
                           <td bgcolor='white'></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><div title="<%= remote.getDescServizio() %>"><%= remote.getDescServizio() %></div></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><div title="<%= remote.getDescOperatore() %>"><%= remote.getDescOperatore() %></div></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><div title="<%= remote.getDescProdotto() %>"><%= remote.getDescProdotto() %></div></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getMeseAnnoComp() %></TD>                           
                           <TD bgcolor='<%=bgcolor%>' class='text'><%= remote.getNumConsistenze() %></TD>
                           <TD bgcolor='<%=bgcolor%>' class='text' style='TEXT-ALIGN: center'>
                              <a style="VERTICAL-ALIGN: text-bottom" href="javascript:dettaglioConsAtt('<%= remote.getServizio() %>',
                                                                                                       '<%= remote.getDescServizio() %>',
                                                                                                       '<%= remote.getOperatore() %>',
                                                                                                       '<%= remote.getDescOperatore() %>',
                                                                                                       '<%= remote.getProdotto() %>',
                                                                                                       '<%= remote.getDescProdotto() %>',
                                                                                                       '<%= remote.getMeseAnnoComp() %>', 
                                                                                                       '<%=strDataCompDa%>',
                                                                                                       '<%=strDataCompA%>');">
                                <img style="BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; BORDER-LEFT: 0px" src="../images/dettaglio.gif" >
                              </a>
                            </TD>
                        </tr>
                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/pixel.gif" width="1" height='2'></td>
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
