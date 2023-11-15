<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
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
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,java.lang.*,java.text.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,com.filter.*" %>

<sec:ChkUserAuth/>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>
  <EJB:useHome id="homeEB"      type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />
  <EJB:useHome id="homeAccount" type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" />
  <EJB:useHome id="homeParam"   type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" />

<%
//dichiarazioni delle variabili
//paginatore
int esegui = 0;
int intRecXPag = 0;
int intRecTotali = 0;
if(request.getParameter("cboNumRecXPag")==null){
	intRecXPag=5;
}else{
	intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
}
String strtypeLoad = request.getParameter("hidTypeLoad");
String strSelected = "";
//fine paginatore

int i=0;
String bgcolor = "";
String strTitle = "";
String strCodeFunz = "";
String strImageTitle = "";
String strCodeFunzPkg = "";
String accountparam = "";
String provenienza = "lancio";
String strNameFirstPage = "1_SEZIONEOPERA_LAN.jsp";
strTitle = "Lancio Sezione Opera";
strCodeFunz = "10040"; //Batch Lancio Package
strCodeFunzPkg = ""; // 3_SEZIONEOPERA_TAB // 4_SEZIONEOPERA_CSV
strImageTitle =StaticContext.PH_CONSUNT_SWN_IMAGES;
%>
<%
String tipooperazione = request.getParameter("tipooperazione");
String tipoelaborazione = request.getParameter("tipoelaborazione");
String ciclo = request.getParameter("ciclo");
String codetipocontr = request.getParameter("listServizi");
String operazione = Misc.nh(request.getParameter("operazione"));
String strAccount = Misc.nh(request.getParameter("strAccount"));
String numeroAccount = Misc.nh(request.getParameter("numeroAccount"));


String act = null;
act = Misc.nh(request.getParameter("act"));  
if (act.equals("lancio_batch"))
{
    clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
    String codUtente=strUserName.getUserName();
    String codProfile=strUserName.getUserProfile();

// inizio lancio batch
          int lancioOK=-1;
          String stringaAccDat = "";
          String codeFunzBatch = "";
          String codetipoelaborazione = "";
          String datiBatch = "";
          
          if (tipoelaborazione.equals("valorizzazione")) {
             codetipoelaborazione = "V";
          } else {
                 codetipoelaborazione = "R";
            }

          if (tipooperazione.equals("caricamentotabelle")) {
             if (codetipoelaborazione.equals("V")) {
                 codeFunzBatch = "PV_OPERA";
             } else {
                 codeFunzBatch = "PR_OPERA";
             }             
          } else if (tipooperazione.equals("creazionefilecsv")) {
             if (codetipoelaborazione.equals("V")) {
                 codeFunzBatch = "FV_OPERA";
             } else {
                 codeFunzBatch = "FR_OPERA";
             }             
            }
         
          strAccount = strAccount.replace("*","$");
          strAccount = strAccount.substring(0, strAccount.length() - 1);   // rimuovo ultimo carattere
          
          String messaggio= codeFunzBatch+"$"+codUtente+"$"+"0"+"$_$"+codetipoelaborazione+"$"+codetipocontr+"$"+strAccount;
          LancioBatch oggLancioBatch= new LancioBatch();
          lancioOK=oggLancioBatch.Esecuzione(messaggio);
          %>
          <SCRIPT LANGUAGE="JavaScript">
          alert("Batch startato con successo");
          document.frmDati.act.value="ritornolancio";
          document.frmDati.action = "1_SEZIONEOPERA_LAN.jsp";
          document.frmDati.submit();
          </SCRIPT>
<%
//fine lancio batch
}
%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	<%=strTitle%>
</TITLE>
        <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
var stringaAccDat="";
	var objForm = null;
	function Initialize()
	{
		objForm = document.frmDati;
//                Disable(document.frmDati.comboAccount);  
                Disable(document.frmDati.comboRiepilogoAccount);
                Disable(document.frmDati.LANCIOBATCH);
                Enable(document.frmDati.comboRiepilogoAccount);

               if (document.frmDati.numeroAccount.value>0){
                    Enable(document.frmDati.LANCIOBATCH);
                }

                
                
	}
	
	function ONAGGIORNA(){
		reloadPage('0','<%=strNameFirstPage%>');
	}

	function validaciclo(){
		var mese = parseFloat (document.frmDati.ciclo.value.substring(0,2));
		var anno = parseFloat (document.frmDati.ciclo.value.substring(2,6));
		var annocorrente = new Date().getFullYear();
        if (mese.length == 1) {
			mese = "0" + mese;
			}

		if (isNaN(mese)) {
			alert("Errore Ciclo di Valorizzazione - Mese non numerico");
                        document.frmDati.ciclo.focus();
                        return;
			} else if (isNaN(anno)) {
				alert("Ciclo di Valorizzazione - Anno non numerico");
                                document.frmDati.ciclo.focus();
                                return;
				} else if ((mese <"1") || (mese>"12")) {
                                        document.frmDati.ciclo.focus();
					alert("Ciclo di Valorizzazione - Valore Mese errato :" + mese);
                                        return;
					} else if (anno > annocorrente) {
                                                document.frmDati.ciclo.focus();
						alert("Ciclo di Valorizzazione - Valore anno maggiore anno corrente : " + anno);
                                                return;
						} else if (anno < 2020) {
                                                        document.frmDati.ciclo.focus();
							alert("Ciclo di Valorizzazione - Valore anno minore 2020 : " + anno);
                                                        return;
							} else if (anno < annocorrente-1) {
                                                                document.frmDati.ciclo.focus();
								alert("Ciclo di Valorizzazione - Valore anno minore anno precedente : " + anno);
                                                                return;
								}
          document.frmDati.act.value="";
          document.frmDati.action = "1_SEZIONEOPERA_LAN.jsp";
          document.frmDati.submit();
	}

function handleblur(ogg)
{
}

function cancelLink ()
{
  return false;
}

function cancelCalendar (obj)
{
  obj.value="";
}

function showMessage (field)
{
  if (field=='seleziona1')
		self.status=msg1;
 	else
 		self.status=msg2;
}


function ONINSERISCI_SEL()
{
    document.frmDati.comboRiepilogoAccount.focus();
    if (document.frmDati.comboAccount.selectedIndex>-1)
    {
          testo=document.frmDati.comboAccount.options[document.frmDati.comboAccount.selectedIndex].text;
          valore=document.frmDati.comboAccount.options[document.frmDati.comboAccount.selectedIndex].value;
          seloption=new Option(testo, valore);
          document.frmDati.comboRiepilogoAccount.options[document.frmDati.comboRiepilogoAccount.length] = seloption;
          document.frmDati.comboAccount.options[document.frmDati.comboAccount.selectedIndex] = null;	
          DisabilitaBotton();
          if (document.frmDati.comboRiepilogoAccount.length==0)
             document.frmDati.comboAccount[0].selected ="true";
     }
    else
      window.alert("Attenzione! Selezionare prima un account da Dati Cliente.");
}

function ONINSERISCI_TUTTI()
{
//    document.frmDati.comboRiepilogoAccount.focus();
    for (i=0;document.frmDati.comboAccount.length>i;i++) 
    {
      testo=document.frmDati.comboAccount.options[i].text;
  	  valore=document.frmDati.comboAccount.options[i].value;
      seloption=new Option(testo, valore);
  	  document.frmDati.comboRiepilogoAccount.options[document.frmDati.comboRiepilogoAccount.length] = seloption;
    }
    for (i=document.frmDati.comboAccount.length;i>=0;i--) 
        document.frmDati.comboAccount.options[i] = null;	
    DisabilitaBotton();
}


function DisabilitaBotton()
{
  if(document.frmDati.comboRiepilogoAccount.length!=0)
    {
    Enable(document.frmDati.LANCIOBATCH);
    Enable(document.frmDati.ELIMINA);

    if(document.frmDati.comboRiepilogoAccount.length==0){
      if (attivaCalendarioSched) f_calendarioSched(document.frmDati.schedulazione);
    }
    }
  else
  {
    Disable(document.frmDati.LANCIOBATCH);
    Disable(document.frmDati.ELIMINA);
  }
  if(document.frmDati.comboAccount.length==0) 
  {
    Disable(document.frmDati.INSERISCI_SEL);
    Disable(document.frmDati.INSERISCI_TUTTI);
  }
  else
  {
    Enable(document.frmDati.INSERISCI_SEL);
    Enable(document.frmDati.INSERISCI_TUTTI);
  }
}

function ONELIMINA()
{
    document.frmDati.comboAccount.focus();
    if (document.frmDati.comboRiepilogoAccount.selectedIndex>-1)
    {
        testo=document.frmDati.comboRiepilogoAccount.options[document.frmDati.comboRiepilogoAccount.selectedIndex].text;
        valore=document.frmDati.comboRiepilogoAccount.options[document.frmDati.comboRiepilogoAccount.selectedIndex].value;
        seloption=new Option(testo,valore);
        document.frmDati.comboAccount.options[document.frmDati.comboAccount.length] = seloption;
        document.frmDati.comboRiepilogoAccount.options[document.frmDati.comboRiepilogoAccount.selectedIndex] = null;
        DisabilitaBotton();
        document.frmDati.comboAccount[document.frmDati.comboAccount.length-1].selected=true;
    }
    else
      window.alert("Attenzione! Selezionare prima un account dal riepilogo.");
}

function clear()
{
     document.frmDati.comboAccount.length=0;
     document.frmDati.comboRiepilogoAccount.length=0;
     DisabilitaBotton();
}

function carPeriodi()
{
 validaciclo();
 var selezione=document.frmDati.listServizi.value;
 
 var tipooperazione=document.frmDati.tipooperazione.value;
 var caricamentotabelle=document.frmDati.caricamentotabelle.value;
 var ciclo=document.frmDati.ciclo.value;
 Disable(document.frmDati.LANCIOBATCH);

 clear();
 if (selezione!=-1)
 {
       document.frmDati.tipooperazione.value=tipooperazione;
       document.frmDati.caricamentotabelle.value=caricamentotabelle;
       document.frmDati.ciclo.value = ciclo;
       document.frmDati.listServizi.value = selezione;
       document.frmDati.submit(); 
 }  
}

function handle_change_ciclo()
{
  Enable(document.frmDati.comboAccount);  
  Enable(document.frmDati.comboRiepilogoAccount);
  
  DisabilitaBotton();
}

function ONLANCIOBATCH()
{
    document.frmDati.act.value="lancio_batch";
 
    var accountLength = document.frmDati.comboRiepilogoAccount.length;
 
      if( document.frmDati.LAccount.value=="0" ){
          for (var i=0; document.frmDati.comboRiepilogoAccount.length>i;i++) {
          
            stringaAccDat=stringaAccDat+document.frmDati.ciclo.value.substring(2,6)+document.frmDati.ciclo.value.substring(0,2)+"01"+document.frmDati.comboRiepilogoAccount.options[i].value+"*";
          }
      } else {
         stringaAccDat=stringaAccDat+document.frmDati.ciclo.value.substring(2,6)+document.frmDati.ciclo.value.substring(0,2)+"01"+document.frmDati.comboRiepilogoAccount.value+"*";
      }
        document.frmDati.strAccount.value=stringaAccDat;     
        Disable(frmDati.LANCIOBATCH);
        document.frmDati.action = "1_SEZIONEOPERA_LAN.jsp";
        document.frmDati.submit();
}

</SCRIPT>

</HEAD>
<BODY onload="Initialize();">

<form name="frmDati" method="post" action="">
<input type="hidden" name=act                     id=act                      value="">
<input type="hidden" name=strAccount              id=strAccount               value="">
<input type="hidden" name="hidTypeLoad" value="">

<!-- inizio filtro -->
<table align=center width="95%" border="0" cellspacing="0" cellpadding="0">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=strTitle%></td>
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
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro Dati Elaborazione</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%">
                          <tr>
                            <td class="textB">Tipo Operazione</td>
                            <td class="textB">Tipo Elaborazione</td>
                            <td class="textB">Ciclo di Valorizzazione</td>
                            <td class="textB">Servizio Reg/Xdsl</td>
                          </tr>
                          <tr>
                            <td class="text">
                            <%if (tipooperazione==null) {tipooperazione="0";}
                             if (tipoelaborazione==null) {tipoelaborazione="0";} %>
                            <%if (!tipooperazione.equals("creazionefilecsv")) {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="caricamentotabelle" checked  onclick="validaciclo()">
                            <%} else {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="caricamentotabelle" onclick="validaciclo()">
                            <%}%>
                                <label for="male">Caricamento Tabelle</label><br>
                            <%if (tipooperazione.equals("creazionefilecsv")) {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="creazionefilecsv" checked onclick="validaciclo()">
                            <%} else {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="creazionefilecsv" onclick="validaciclo()">
                            <%}%>
                                <label for="female">Creazione file CSV</label><br>
                            </td>
                            <td class="text">
                            <%if (!tipoelaborazione.equals("repricing")) {%>
                                <input type="radio" id="caricamentotabelle" name="tipoelaborazione" value="valorizzazione" checked onclick="validaciclo()">
                            <%} else {%>
                                <input type="radio" id="caricamentotabelle" name="tipoelaborazione" value="valorizzazione" onclick="validacsiclo()">
                            <%}%>
                                <label for="male">Valorizzazione</label><br>
                            <%if (tipoelaborazione.equals("repricing")) {%>
                                <input type="radio" id="creazionefilecsv" name="tipoelaborazione" value="repricing" checked onclick="validaciclo()">
                            <%} else {%>
                                <input type="radio" id="creazionefilecsv" name="tipoelaborazione" value="repricing" onclick="validaciclo()">
                            <%}%>
                                <label for="female">Repricing</label><br>
                            </td>
                            <td class="text">                        
                                <input type="text" name="ciclo" size="8" maxsize="6"  onchange="validaciclo()" value=<%if (ciclo != null) {%><%=ciclo%><%}%>> 
                            </td>
                            <td class="text">                        
                                <select class="text" title="servizi" id="listServizi" name="listServizi" onchange="carPeriodi();" >
<%if (codetipocontr != null){ 
//recupero descrizione account
                            String code_tipo_contr = codetipocontr;
                            GestioneServizioOpera gestServiziOpera4 = new GestioneServizioOpera();
                            Vector<TypeDescrizione> listDescrizione = gestServiziOpera4.listDescrizione(code_tipo_contr);
                              for(int indDescrizione = 0; indDescrizione < listDescrizione.size(); indDescrizione++){
%>
                                <option value=<%=codetipocontr%>><%=listDescrizione.get(indDescrizione).getDesc()%></option>                                   
<%
                              }
%>
<%}%>

<%
                            GestioneServizioOpera gestServiziOpera2 = new GestioneServizioOpera();
                            Vector<TypeServizi> listServizi = gestServiziOpera2.listServizi(provenienza);
                              for(int indservizi = 0; indservizi < listServizi.size(); indservizi++){
                                if (!listServizi.get(indservizi).getCode().equals(codetipocontr)) {
%>
                                <option value=<%=listServizi.get(indservizi).getCode()%>><%=listServizi.get(indservizi).getDesc()%> </option>                                   
<%
                                }
                              }
%>
                                </select>
                                <input type="hidden" name="codiceservizio" value="">
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
<!-- inizio account -->
<tr>
<td cospan=4>
<!-- CARICO LISTA ACCOUNT -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
             <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati Cliente</td>
             <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
            </tr>
            <tr>
             <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="#cfdbe9">
		 	          <tr>
           				<td <td colspan='2'>&nbsp;</td>
                </tr>
               <tr> 
                  <td class="textB" valign="top" width="30%">&nbsp;Account</td>
           				<td class="text" align="left" width="70%">
<!--
                    <Select name="comboAccount" size="7" style="width: 80%;" width="400px" class="text">
                    </select>
-->
<%
if (!tipooperazione.equals("creazionefilecsv")) {%>
                    <input type="hidden" name="numeroAccount" value="0">
                    <input type="hidden" name="LAccount" value="0">
                    <select class="text" title="account" id="comboAccount" name="comboAccount" size="7" style="width: 80%;" width="400px" class="text">
                
<%}%>
<%
if (codetipocontr!=""){
    if (!tipooperazione.equals("creazionefilecsv")) {

                            String code_tipo_contr = codetipocontr;
                            GestioneServizioOpera gestServiziOpera3 = new GestioneServizioOpera();
                            Vector<TypeAccount> listAccount = gestServiziOpera3.listAccount(code_tipo_contr,ciclo,"0",tipoelaborazione);

                              for(int indaccount = 0; indaccount < listAccount.size(); indaccount++){
%>
                                <option value=<%=listAccount.get(indaccount).getCode()%>><%=listAccount.get(indaccount).getDesc()%></option>                                   
<%
                              }
    } else {
                            String code_tipo_contr = codetipocontr;
                            GestioneServizioOpera gestServiziOpera3 = new GestioneServizioOpera();
                            Vector<TypeAccount> listAccount = gestServiziOpera3.listAccount(code_tipo_contr,ciclo,"1",tipoelaborazione);
                            if (listAccount.size() > 0) {
%>
                                <input type="hidden" name="LAccount" value="1">
                                <input type="hidden" name="comboAccount" value="<%=listAccount.get(0).getCode()%>">
                                <input type="hidden" name="comboRiepilogoAccount" value="<%=listAccount.get(0).getCode()%>">
<%
                                } else {
%>
                                <input type="hidden" name="LAccount" value="1">
                                <input type="hidden" name="comboAccount" value="">
                                <input type="hidden" name="comboRiepilogoAccount" value="">
<%                              }%>
                                <input type="hidden" name="numeroAccount" value="1">
<%
                              for(int indaccount = 0; indaccount < listAccount.size(); indaccount++){
                              out.print("<br>"+listAccount.get(indaccount).getDesc());
%>
<%
                              }
        if (listAccount.size() > 0) {
            esegui =1;
        }
    } 
}
%>
<%
if (!tipooperazione.equals("creazionefilecsv")) {%>
                    </select>
<%}%>
                  </td>
               </tr>
                <tr>
           				<td colspan='2'>&nbsp;</td>
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
<%    if (!tipooperazione.equals("creazionefilecsv")) {%>
      <tr>
       <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
<!-- INSERISCO ISTRUZIONI PER LA 2 LISTA  -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <tr>
             <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Riepilogo</td>
             <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
            </tr>
            <tr>
             <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="#cfdbe9">
                <tr>
           				<td <td colspan='2'>&nbsp;</td>
                </tr>
                <tr>
                  <td class="textB" valign="top" width="30%">&nbsp;Account</td>
           				<td class="text" align="left" width="70%">
                     <Select name="comboRiepilogoAccount" size="7" width="400px" style="width: 80%;" class="text"></select>
                 </td>
               </tr>
                <tr>
           				<td colspan='2'>&nbsp;</td>
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
<% }%>
      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>

</td>
</tr>
<!-- fine account -->
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>

			</td>
		</tr>
  </table>

<!-- fine filtro -->
<!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
	    <tr>
    		<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    	</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
				<sec:ShowButtons td_class="textB"/>
			</td>
		</tr>
	</table> 
</form>

</BODY>
</HTML>
<%
if (esegui==1) {%>
            <SCRIPT LANGUAGE="JavaScript">
                Disable(document.frmDati.ELIMINA);
                Disable(document.frmDati.INSERISCI_SEL);
                Disable(document.frmDati.INSERISCI_TUTTI);
                Enable(document.frmDati.LANCIOBATCH);
            </SCRIPT>
<%}
%>