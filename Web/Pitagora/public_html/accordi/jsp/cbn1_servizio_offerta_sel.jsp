<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*" %>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth isModal="true"/>


<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_inserimento_offerteVis.jsp")%>
</logtag:logData>

<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeEnt_Accordo" type="com.ejbSTL.Ent_AccordoHome" location="Ent_Accordo" />
<EJB:useBean id="remoteEnt_Accordi" type="com.ejbSTL.Ent_Accordo" scope="session">
  <EJB:createBean instance="<%=homeEnt_Accordo.create()%>" />
</EJB:useBean>
<EJB:useHome id="homeEnt_Offerte" type="com.ejbSTL.Ent_OfferteHome" location="Ent_Offerte" />
<EJB:useBean id="remoteEnt_Offerte" type="com.ejbSTL.Ent_Offerte" scope="session">
    <EJB:createBean instance="<%=homeEnt_Offerte.create()%>" />
</EJB:useBean>
<!-- instanziazione dell'oggetto remoto -->
<EJB:useHome id="homeEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioniHome" location="Ent_TipoRelazioni" />
<EJB:useBean id="remoteEnt_TipoRelazioni" type="com.ejbSTL.Ent_TipoRelazioni" scope="session">
    <EJB:createBean instance="<%=homeEnt_TipoRelazioni.create()%>" />
</EJB:useBean>


<%
  Vector vctOfferte = remoteEnt_Accordi.getOfferte();
  Vector vctAccount = remoteEnt_TipoRelazioni.getAccount();
/*  String xmlAccount = "";
  DB_ElabAttive objElabAttiva = null;
  objElabAttiva = new DB_ElabAttive();  
  xmlAccount = remoteCtr_ElabAttive.getXmlAccount("getaccount");
 
  //PARAMETRI DI INPUT DELLA PAGINA+++++++++++++++++++++++++++++++++

     int Code_Offerta;
     if(request.getParameter("CodeOfferta") == null){
         Code_Offerta = StaticContext.LIST;
     }else{
        Code_Offerta = Integer.parseInt(request.getParameter("CodeOfferta"));
     }

  
      int intAction;
      if(request.getParameter("intAction") == null){
        intAction = StaticContext.LIST;
      }else{
        intAction = Integer.parseInt(request.getParameter("intAction"));
      }
      int intFunzionalita;
      if(request.getParameter("intFunzionalita") == null){
        intFunzionalita = StaticContext.FN_TARIFFA;
      }else{
        intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
      }
      
      int intAggiornamento; //     1 - INSERIMENTO
                            //     2 - AGGIORNAMENTO
                            //     3 - CANCELLAZIONE
      if (request.getParameter("intAggiornamento") == null){
        intAggiornamento = 0;
      }else{
        intAggiornamento = Integer.parseInt(request.getParameter("intAggiornamento"));
      }
    
      //Controllo se effettuare l'inserimento o no dopo l'apertura del popup
      String esito = "";
      String messaggio = "";
  
      DB_Accordo newAccordo;
      
      String codice = Misc.nh(request.getParameter("strCodeAcco"));
      String descrizione = Misc.nh(request.getParameter("strDescAcco"));
    
      String strCodeAccordo = Misc.nh(request.getParameter("CodeAccordo"));
    
 
      // AP Aggiunta modifica gestione descrizione
      String strFlagModificaDescrizione = Misc.nh(request.getParameter("strFlagModificaDescrizione"));
    
        
      if(!codice.equals("")&& intAggiornamento != 0){
        newAccordo = new DB_Accordo();
        newAccordo.setCODE_ACCORDO(codice);
        newAccordo.setDESC_ACCORDO(descrizione);
        //AP Aggiunta modifica gestione descrizione 
        newAccordo.setFLAG_MODIF(strFlagModificaDescrizione);
    
        // INSERIMENTO 
        if(intAggiornamento==1)
        {
          esito = remoteEnt_Accordi.insAccordo(newAccordo.getCODE_ACCORDO(),newAccordo.getDESC_ACCORDO());
          if(esito.equals("")){
            messaggio = "Inserimento nuovo accordo effettuato correttamente.";
          }else{
            messaggio = esito;
          }
        }
        
        // AGGIORNAMENTO 
        else if(intAggiornamento==2)
        {
          esito = remoteEnt_Accordi.aggiorna_accordo(newAccordo);
          
          if(esito.equals("")){
            messaggio = "Aggiornamento accordo effettuato correttamente.";
          }else{
            messaggio = esito;
          }
        }
        
         //CANCELLAZIONE 
        else if(intAggiornamento==3)
        {
          esito = remoteEnt_Accordi.cancella_accordo(strCodeAccordo);
          
          if(esito.equals("")){
            messaggio = "Cancellazione accordo effettuata correttamente.";
          }else{
            messaggio = esito;
          }
        }
      }
   */  
     //PARAMETRI DI INPUT DELLA PAGINA+++++++++++++++++++++++++++++++++
      String strAccordo = Misc.nh(request.getParameter("txtAccordo"));
      String strDescAccordo = Misc.nh(request.getParameter("txtDescAccordo"));  
      String strOfferta = Misc.nh(request.getParameter("CodeOfferta"));
      String strAccount = Misc.nh(request.getParameter("CodeAccount"));  
      //String strValorizzati = Misc.nh(request.getParameter("chkValorizzati"));  
      String stroptStatoAccordo = Misc.nh(request.getParameter("optStatoAccordo"));  
   
      if(strAccordo.equals(""))
        strAccordo = "%";
      if(strDescAccordo.equals(""))
        strDescAccordo = "%";
       if(strOfferta.equals(""))
        strOfferta = "%";
      if(strAccount.equals(""))
        strAccount = "%";  
    
      String strtypeLoad = request.getParameter("hidTypeLoad");
      String strSelected = "";
      //FINE PARAMETRI DI INPUT DELLA PAGINA++++++++++++++++++++++++++++++
      
      //GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      int typeLoad=0;
      Vector vctAccordi=null;

     vctAccordi = remoteEnt_Accordi.getAccordiFiltro(strAccordo,strDescAccordo,strAccount,strOfferta,stroptStatoAccordo);

     /*
      if (strtypeLoad!=null && strtypeLoad!="")
      {
        Integer tmptypeLoad=new Integer(strtypeLoad);
        typeLoad=tmptypeLoad.intValue();
      }
      if (typeLoad!=0 && request.getParameter("CodeOfferta") == null)
        vctAccordi = (Vector) session.getAttribute("vctAccordi");
      
      else if (typeLoad==0 && request.getParameter("CodeOfferta") != null)
      {
          vctAccordi = remoteEnt_Accordi.getAccordi(request.getParameter("CodeOfferta"));
    
      }else{
        vctAccordi = remoteEnt_Accordi.getAccordiFiltro(strAccordo,strDescAccordo,request.getParameter("CodeAccount"),request.getParameter("CodeOfferta"));
        if (vctAccordi!=null)
          session.setAttribute("vctAccordi", vctAccordi);
      }
      */
      //FINE GESTIONE CARICAMENTO VETTORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    
      //memorizza il numero di record totali
      int intRecTotali=vctAccordi.size();

      //determina il numero di elementi per pagina
      int intRecXPag;
      if(request.getParameter("cboNumRecXPag")==null){
        intRecXPag=50;
      }else{
        intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
      }

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
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
<script src="<%=StaticContext.PH_COMMON_JS%>XML.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_TARIFFE_JS%>Tariffe.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"  type="text/javascript"></SCRIPT>

<TITLE>Seleziona Account</TITLE>
<SCRIPT LANGUAGE='Javascript'>
var objForm = null;
var valCboOfferta = '';


function initialize()
{
	objForm = document.frmDati;
  setCheckedValue('<%=stroptStatoAccordo%>')
}

function setCheckedValue(newValue) {
if (newValue == ''){
newValue= '99';
}
	for(var i = 0; i < document.frmDati.optStatoAccordo.length; i++) {
		document.frmDati.optStatoAccordo[i].checked = false;
		if(document.frmDati.optStatoAccordo[i].value == newValue.toString()) {
			document.frmDati.optStatoAccordo[i].checked = true;
		}
	}
}
function checkOptStatoAccordo(){

}
  function change_cboOfferta(){
    if (valCboOfferta!=frmDati.cboOfferta.value){
      valCboOfferta=frmDati.cboOfferta.value;
 
    }
  }  
function ONSELEZIONA() {
var val;
var selezionato = 0;

 	if(objForm.optCodeAccordo.length==null)
	{
		if(objForm.optCodeAccordo.checked == true)
		{
		   selezionato=1;
		}
    
	}else{
    for(var i=0;i<objForm.optCodeAccordo.length;i++){

      if(objForm.optCodeAccordo[i].checked){
        
        selezionato= 1;

        break;
      }
    }
  
  }




  
if (selezionato==1 ){
var intIndex = getRadioButtonIndex(objForm.optCodeAccordo);
 			if(intIndex == -1){
				 val = objForm.optCodeAccordo.value;
			}else{
          val=objForm.optCodeAccordo[intIndex].value;
			}

//alert(val) ;
var obj= 'hdStatoAccordo_'+val;
 URL = 'cbn1_accordi_aggiungi_modifica.jsp?optCodeAccordo=' + val; 
 URL += '&StatoAccordo=' + document.all(obj).value;
 

 objForm.action = URL;
 objWindows = window.open(URL,'_new','fullscreen=yes,scrollbars=no');
}else{
 alert("Nessun elemento selezionato"); 
}
 //objForm.target = '_new';
 //objForm.submit();
}

function CallAlert()
{
 //alert("This is parent window's alert function.");
 self.location.reload();
}

function ONNUOVO() {
//alert("NUOVO");
//objForm.optCodeAccordo.value = '';
 URL = 'cbn1_accordi_aggiungi_modifica.jsp?nuovo=y'; 
 objForm.action = URL;
 objWindows = window.open(URL,'_new','fullscreen=yes,scrollbars=no');
 //objWindows = window.open(URL,'_new','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,top=0,left=0');
 //objForm.target = '_new';
 //objForm.submit();
}

function submitRicerca(typeLoad)
{

  
    for(var i=0;i<document.frmDati.optStatoAccordo.length;i++){

      if(document.frmDati.optStatoAccordo[i].checked){
        val=document.frmDati.optStatoAccordo[i].value;
       // alert(val);
        break;
      }
    } 

URL = 'cbn1_servizio_offerta_sel.jsp?Code_Accordo=' + frmDati.txtAccordo.value; 
 URL += '&Desc_Accordo=' + frmDati.txtDescAccordo.value + '&CodeOfferta=' + frmDati.cboOfferta.value;
 URL += '&CodeAccount=' + frmDati.cboAccountDisp.value;
  URL += '&optStatoAccordo=' + val;
 objForm.action = URL;
 objForm.submit();
}
   
 function caricaDati(){
     frmDati.txtAccordo.value       = '<%=Misc.nh(request.getParameter("txtAccordo"))%>';
     frmDati.txtDescAccordo.value   = '<%=Misc.nh(request.getParameter("txtDescAccordo"))%>';
     var codeOfferta    = '<%=request.getParameter("CodeOfferta")%>';
     var codeAccount = '<%=request.getParameter("CodeAccount")%>';      
  }
function CancelMe()
{
  self.close();
  return false;
}


 

 
  function setSelezionato(){
 //alert('setSelezionato');
    for(var i=0;i<document.frmDati.optCodeAccordo.length;i++){

      if(document.frmDati.optCodeAccordo[i].checked){
        val=document.frmDati.optCodeAccordo[i].value;
        selezionato= 1;
         //alert(val);
        break;
      }
    }
  }
  

  
  


</SCRIPT>
</HEAD>
<BODY onload="initialize()" >
<form name="frmDati" onsubmit="submitRicerca('0');return false" method="post" action="">
<!--<input type="hidden" name="intAction" value="">
<input type="hidden" name="intFunzionalita" value="">
<input type="hidden" name="intAggiornamento" value="">
<input type="hidden" name="messaggio" id="messaggio" value="">
<input type="hidden" name="hidPaginaRichiesta" value="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="strCodeAcco" value="">
<input type="hidden" name="strDescAcco" value="">-->









<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <!-- <tr>
    <td><img src="../images/bglabel.gif" alt="" border="0"></td>
  <tr>
 <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>-->
  
  <tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Accordi</td>
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
</table>

<table align=center width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                      <tr>
                          <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                      </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                      <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="20%" class="textB" align="right">Offerta:&nbsp;</td>
                
                      <td width="20%" colspan='5' class="text">
               		<select class="text" title="Offerta" name="cboOfferta" id="cboOfferta" onchange="change_cboOfferta();" >
                          <option class="text"  value="">[Seleziona Offerta]</option>
                                 <%
                                //Caricamento combo offerte in base al parametro della querystring
                                DB_Offerta lcls_Offerta = null;
                                for (int i = 0;i < vctOfferte.size();i++){
                                  lcls_Offerta = (DB_Offerta)vctOfferte.get(i);
                                  if (lcls_Offerta.getCODE_OFFERTA().equals(strOfferta)){
                                      strSelected = "selected";
                                  }else{
                                      strSelected = "";
                                  }
                                  %><OPTION value="<%=lcls_Offerta.getCODE_OFFERTA()%>" <%=strSelected%> ><%=lcls_Offerta.getDESC_OFFERTA()%>  </OPTION><%
                                  
                                }%>
     
                      
                        </select>
                      </td>
                     
                   </tr>

                   <tr>
                    <td width="20%" class="textB" align="right" nowrap>Account:&nbsp;</td>
                      <td width="20%"  colspan='5' class="text">
                          <Select class="text" name="cboAccountDisp" id="cboAccountDisp" >
                            <option class="text"  value="">[Seleziona Account]</option>
                                             <%
                                //Caricamento combo offerte in base al parametro della querystring
                                DB_Account lcls_Account = null;
                                for (int i = 0;i < vctAccount.size();i++){
                                  lcls_Account = (DB_Account)vctAccount.get(i);
                                  if (lcls_Account. getCODE_ACCOUNT().equals(strAccount)){
                                      strSelected = "selected";
                                  }else{
                                      strSelected = "";
                                  }
                                  %><OPTION value="<%=lcls_Account.getCODE_ACCOUNT()%>" <%=strSelected%> ><%=lcls_Account.getDESC_ACCOUNT()%>  </OPTION><%
                                  
                                }%>
                          </Select>
                      </td>
                
                    </tr>
                    <tr>
                      <td width="20%" class="textB" align="right">Codice accordo:&nbsp;</td>
                     <%if (strAccordo == "%") {
                          strAccordo = "";  
                     }  %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtAccordo' value='<%=strAccordo%>' size='15'></td>
                      <td width="20%" class="textB" align="right" nowrap>Descrizione accordo:&nbsp;</td>
                     <%if (strDescAccordo == "%") {
                          strDescAccordo = "";  
                     } 
                     %>
                      <td width="20%" class="text"><input class="text" type='text' name='txtDescAccordo' value='<%=strDescAccordo%>' size='15'></td>
                  
                    </tr>
                              <TR>
            <TD class="text" nowrap align="center" colspan="4">
              <INPUT  type="radio" name="optStatoAccordo" value="99" checked  onchange="checkOptStatoAccordo()" Update="false">Tutti
              <INPUT  type="radio" name="optStatoAccordo" value="0" checked onchange="checkOptStatoAccordo()" Update="false">Attivi
              <INPUT  type="radio" name="optStatoAccordo" value="1" onchange="checkOptStatoAccordo()" Update="false">Valorizzati
              <INPUT  type="radio" name="optStatoAccordo" value="2" onchange="checkOptStatoAccordo()" Update="false">Cessati
              <!--<INPUT  type="radio" name="optStatoAccordo" value="6" onchange="checkOptStatoAccordo()" Update="false">Annullati-->
            </TD>
          </TR>
                    <tr>
                      <td class="textB"  colspan='2' align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="cboNumRecXPag" onchange="submitRicerca('1');">
                        <%for(int k = 50;k <= 300; k=k+50){
                          if(k==intRecXPag){
                            strSelected = "selected";
                          }else{
                            strSelected = "";
                          }
                          %>
                          <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
                        <%
                        }
                        %>
                        </select>
                      </td>
                          <td width="20%"  colspan='2' class="textB" valign= "center" align="left">
                       <input type="button"  class="textB" name="Esegui" value="Ricerca" onclick="submitRicerca(this.value);">
                      </td>
                    </tr>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Accordi Selezionati</td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                          int i=0;
                          int j=0;
                  
                          if ((vctAccordi==null)||(vctAccordi.size()==0))
                          {
                          %>
                          <tr>
                              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">No Record Found</td>
                          </tr>
                          <%
                          }
                          else
                          {
                          %>
                          <tr>
                            <td bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB">&nbsp;</td>
                            <td bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB">Codice </td>
                            <td bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB">Descrizione </td>
                             <td bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>" class="textB">Stato </td>
                          </tr>
                          <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                          <%

                          String classRow = "row1";
                          String statoAccordo = "";
                        //  String curSubClass_Row = "";
                        //  String curSubClassRow = "";
                        //  String curSubClassRow_new = "";
                          
                          for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                          {
                            DB_Accordo myelement=new DB_Accordo();
                            myelement=(DB_Accordo)vctAccordi.elementAt(j);
                       
                              if (myelement.getATTIVATO().equals("Valorizzato")) { 
                                 statoAccordo = "1";
                                        
                              }else if (myelement.getATTIVATO().equals("Cessato")) { 
                                 statoAccordo = "2";
                                        
                              }else if (myelement.getATTIVATO().equals("Eliminato")) { 
                                 statoAccordo = "6";
                                        
                              }
                              else{
                                  statoAccordo = "0";
                              }
                            
                      /*  
                          String strbgcolor ="";
                          if (myelement.getVALORIZZATO().equals("1")) { 
                              strbgcolor="StaticContext.bgColorMsgPageBg1";
                          }else{
                             strbgcolor="StaticContext.bgColorCellaBianca"; 
                          }
                       */ 
                    
                            %>
                       
                          <tr class="<%=classRow%>" >
                        
                            <td class='text' >
                              <!--<input type="radio" name="CodeAccordo" value="<%=myelement.getCODE_ACCORDO()%>" onClick="setCodeHidden(this);">-->
                              <input type="radio" name="optCodeAccordo" value="<%=myelement.getCODE_ACCORDO()%>" onClick="setSelezionato();" >
                            <!--  <input type="hidden" name="tipo_sistema_mittente_<%=myelement.getCODE_ACCORDO()%>" value="myelement.getTIPO_SISTEMA_MITTENTE()">-->
                             <INPUT type="hidden" id="hdStatoAccordo" name="hdStatoAccordo_<%=myelement.getCODE_ACCORDO()%>" value="<%=statoAccordo%>">
                            </td>
                            <td><%=myelement.getCODE_ACCORDO()%></td>
                            <td><%=myelement.getDESC_ACCORDO()%></td>
                            <td><%=myelement.getATTIVATO()%></td>
                          </tr>
                          <tr>
                            <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                          </tr>
                          <%
                            i+=1;
                          }
                          %>
                          <tr>
                            <td colspan="6" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                              <!--paginatore-->
                              <pg:index>
                                Risultati Pag.
                                <pg:prev> 
                                  <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                                </pg:prev>
                                <pg:pages>
                                  <%
                                  if (pageNumber == pagerPageNumber){
                                  %>
                                    <b><%= pageNumber %></b>&nbsp;
                                  <%
                                  }else{
                                  %>
                                    <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                  <%
                                  }
                                  %>
                                </pg:pages>
                                <pg:next>
                                  <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                                </pg:next>
                              </pg:index>
                              </pg:pager>
                            </td>
                          </tr>
                          <%
                          }
                          %>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
	    <table width="80%" border="1" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
<%
  if ((vctAccordi==null)||(vctAccordi.size()==0))
  {
%>
    <script>
      Disable(document.frmDati.Seleziona);
    </script>
<%
  }
%>

</form>
<script language="JavaScript">
 // if(document.frmDati.messaggio.value != "") 
//    alert("messaggio");
 caricaDati();
  Disable(document.frmDati.AGGIORNA);
  Disable(document.frmDati.CANCELLA);
  <!-- AP Aggiunta modifica gestione descrizione -->
  Disable(document.frmDati.MODIFICA_DESC);
</script>
</BODY>
</HTML>

