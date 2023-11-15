<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"ReportSp.jsp")%>
</logtag:logData>


<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
BatchElem  datiBatch=null;

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

String sys=request.getParameter("hidFlagSys");
if (sys==null) sys=request.getParameter("sys");
if (sys==null) sys=(String)session.getAttribute("sys");

String comboFunzSelez   = request.getParameter("comboFunzSelez");
String PeriodoRifSelez  = request.getParameter("PeriodoRifSelez");
String descPeriodoSelez  = request.getParameter("descPeriodoSelez");

String caricaPeriodi    = request.getParameter("caricaPeriodi");
String caricaDatiCli      = request.getParameter("caricaDatiCli");

String appoggio      = request.getParameter("appoggio");

// Vettore contenente risultati query per il caricamento della lista
Collection datiCli=null;    
Collection dati=null;
String Desc_Account = null;
int elaborBatch = 0;
int elaborBatch2 =0;
int elaborBatch3 =0;
String codeElab=null;
String sSELECTED = null;    

//RESET VARIABILE DEGLI STEPS X IL LANCIO BATCH
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));
%>

<EJB:useHome id="homeFunzionalita" type="com.ejbSTL.FunzionalitaSTLHome" location="FunzionalitaSTL" />
<EJB:useBean id="remoteFunzionalita" type="com.ejbSTL.FunzionalitaSTL" value="<%=homeFunzionalita.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeDatiCli" type="com.ejbBMP.DatiCliBMPHome"      location="DatiCliBMP" />
<EJB:useHome id="homePeriodo" type="com.ejbBMP.PeriodoRifBMPHome"   location="PeriodoRifBMP" />
<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lancio Report </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/ReportSp.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>

<script language="JavaScript" src="../../common/js/calendar1.js"></script>

<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;
var attivaCalendarioSchedReport=true;

function ONINSERISCI_SEL()
{
  if (document.reportForm.cmbAccount.selectedIndex>-1)
  {
    testo=document.reportForm.cmbAccount.options[document.reportForm.cmbAccount.selectedIndex].text;
    valore=document.reportForm.cmbAccount.options[document.reportForm.cmbAccount.selectedIndex].value;
    seloption=new Option(testo, valore);
    document.reportForm.cmbRiepilogoAccount.options[document.reportForm.cmbRiepilogoAccount.length] = seloption;
    document.reportForm.cmbAccount.options[document.reportForm.cmbAccount.selectedIndex] = null;	
    DisabilitaBotton();
  }
  else
    window.alert('Attenzione! Selezionare prima un account da Dati Cliente.');
}

function ONINSERISCI_TUTTI()
{
   for (i=0;document.reportForm.cmbAccount.length>i;i++) 
   {
    testo=document.reportForm.cmbAccount.options[i].text;
  	valore=document.reportForm.cmbAccount.options[i].value;
    seloption=new Option(testo, valore);
  	document.reportForm.cmbRiepilogoAccount.options[document.reportForm.cmbRiepilogoAccount.length] = seloption;	
    }
    for (i=document.reportForm.cmbAccount.length;i>=0;i--) 
       document.reportForm.cmbAccount.options[i] = null;	
    DisabilitaBotton();
}

function DisabilitaBotton()
{
  if(document.reportForm.cmbRiepilogoAccount.length!=0)
  {
    Enable(document.reportForm.LANCIOBATCH);
    Enable(document.reportForm.ELIMINA);
    document.reportForm.ELIMINA.focus();
/*    if(document.reportForm.sys.value == 'S'){
      Enable(document.reportForm.schedulazione);
      if(document.reportForm.cmbRiepilogoAccount.length==0){
        if (attivaCalendarioSchedReport) f_calendarioSchedReport(document.reportForm.schedulazione);
      }
    }
*/
  }
  else
  {
    Disable(document.reportForm.LANCIOBATCH);
    Disable(document.reportForm.ELIMINA);
/*
    Disable(document.reportForm.schedulazione);
    if(document.reportForm.sys.value == 'S'){
      document.reportForm.schedulazione.checked=false;
      document.reportForm.schedulazione.value="N";
      document.reportForm.dataSched.value="";
      if (attivaCalendarioSchedReport) f_calendarioSchedReport(document.reportForm.schedulazione);
    }
*/
  }
  if(document.reportForm.cmbAccount.length==0)
  {
    Disable(document.reportForm.INSERISCI_SEL);
    Disable(document.reportForm.INSERISCI_TUTTI);
  }
  else
  {
    Enable(document.reportForm.INSERISCI_SEL);
    Enable(document.reportForm.INSERISCI_TUTTI);
    document.reportForm.INSERISCI_SEL.focus();
    document.reportForm.INSERISCI_TUTTI.focus();
  }
}

function ONELIMINA()
{
    if (String(document.reportForm.cmbRiepilogoAccount)!="undefined" && document.reportForm.cmbRiepilogoAccount.selectedIndex>-1) 
    {
        testo=document.reportForm.cmbRiepilogoAccount.options[document.reportForm.cmbRiepilogoAccount.selectedIndex].text;
        valore=document.reportForm.cmbRiepilogoAccount.options[document.reportForm.cmbRiepilogoAccount.selectedIndex].value;
        seloption=new Option(testo, valore);
        document.reportForm.cmbAccount.options[document.reportForm.cmbAccount.length] = seloption;
        document.reportForm.cmbRiepilogoAccount.options[document.reportForm.cmbRiepilogoAccount.selectedIndex] = null;
        DisabilitaBotton();
    }
    else
        window.alert('Attenzione! Selezionare prima un account dal riepilogo.');
}

function ONLANCIOBATCH()
{
  document.reportForm.appoggio.value=document.reportForm.cmbRiepilogoAccount.options[0].value;
  for (i=1; document.reportForm.cmbRiepilogoAccount.length>i; i++) 
  {
    document.reportForm.appoggio.value=document.reportForm.appoggio.value+"$"+document.reportForm.cmbRiepilogoAccount.options[i].value;
  }
  document.reportForm.action = "LancioBatchSp.jsp";
  EnableAllControls(document.reportForm);

/*
  if(document.reportForm.sys.value == 'S'){
    if(document.reportForm.schedulazione.checked){
      if(document.reportForm.dataSched.value == "" || document.reportForm.dataSched.value == undefined){
        alert("Inserire la Data/Ora Schedulazione");
      }else{
        document.reportForm.submit();
      }
    }else{
     document.reportForm.submit();
    }
  }
*/

  document.reportForm.submit();
}

function f_calendarioSchedReport(obj)
{
	if(obj.checked){
  	attivaCalendarioSchedReport=true;
    document.reportForm.dataSched.value="";
    EnableLink(document.links[0],document.reportForm.calendarioSched);
    EnableLink(document.links[1],document.reportForm.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.reportForm.LANCIOBATCH.value = "Schedula Batch";
  }else{
    attivaCalendarioSchedReport=false;
    document.reportForm.dataSched.value="";
    DisableLink(document.links[0],document.reportForm.calendarioSched);
    DisableLink(document.links[1],document.reportForm.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.reportForm.LANCIOBATCH.value = "Lancio Batch";    
  }
}
</SCRIPT>
</HEAD>

<BODY onload="DisabilitaBotton();">
<form  name="reportForm" method="post" action="ReportSp.jsp">
<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr    value="<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr    id=des_tipo_contr    value="<%=des_tipo_contr%>">
<input type="hidden" name=sys               id=sys               value="<%=sys%>">
<input type="hidden" name=comboFunzSelez    id= comboFunzSelez   value="<%=comboFunzSelez%>">
<input type="hidden" name=caricaPeriodi     id= caricaPeriodi    value="<%=caricaPeriodi%>">
<input type="hidden" name=PeriodoRifSelez   id= PeriodoRifSelez  value= "<%=PeriodoRifSelez%>">
<input type="hidden" name=descPeriodoSelez  id= descPeriodoSelez value= "<%=descPeriodoSelez%>">
<input type="hidden" name=caricaDatiCli     id= caricaDatiCli    value= "<%=caricaDatiCli%>">
<input type="hidden" name=appoggio          id= appoggio         value= "<%=appoggio%>">

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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Report : <%=des_tipo_contr%></td>
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
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;</td><!--titolo2-->
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
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td width="50%" class="textB" align="left">&nbsp Funzionalità</td>
                      <td width="50%" class="textB" align="left">&nbsp Periodo di riferimento</td>
                    </tr>
                    <tr>    
					           <td  class="text"> &nbsp
                          <%
                          Vector classFunz= remoteFunzionalita.getOfs(cod_tipo_contr,sys);
                            if ((classFunz!=null)&&(classFunz.size()!=0))
                            {
                              // Visualizzo elementi%>
                              <select class="text" title="Combo funzionalita" name="comboFunz" onchange="carPeriodi();">
                              <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(21)%></option>
                              <%
                                for(Enumeration e = classFunz.elements();e.hasMoreElements();)
                                {
                                  ClassFunzElem elem=new ClassFunzElem();
                                  elem=(ClassFunzElem)e.nextElement();
                                  String sel="";
                                  if (comboFunzSelez!=null && comboFunzSelez.equals(elem.getCodeFunz())) sel="selected";
                                     %>
                                     <option value="<%=elem.getCodeFunz()%>" <%=sel%>><%=elem.getDescFunz()%></option>
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
                                <SCRIPT LANGUAGE='Javascript'>
                                Disable(document.reportForm.comboFunz);
                               </SCRIPT>
                               <select class="text" name="comboFunz" onfocus="this.blur(); window.alert('Funzionalità non disponibili per il contratto selezionato');">
                                     <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(21)%></option>
                               </select>         
                              <%
                              }
                          %>
                         </td>
                        
					           <td  class="text"> &nbsp
                     <%   
                     if (caricaPeriodi == null || !caricaPeriodi.equals("true")){%>
                     <SCRIPT LANGUAGE='Javascript'> Disable(document.reportForm.comboPeriodo);  </SCRIPT>
                           <select class="text" name="comboPeriodo" onfocus="this.blur(); window.alert('Bisogna selezionare una funzionalità');" >
                                    <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(21)%></option>
                           </select>     
                         <% } else { 
                           Collection classPeriodo = null;
                           if(sys!=null && sys.equalsIgnoreCase("C"))
                           { 
                              if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_CL))
                                  classPeriodo = homePeriodo.findValAttClass(cod_tipo_contr);
                              else    
                              if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_SAR))
                                  classPeriodo = homePeriodo.findAvanzRicClass(cod_tipo_contr);
                              else    
                              if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CREDITO_CL))
                                  classPeriodo = homePeriodo.findNotaCreClass(cod_tipo_contr);
                              else    
                              if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_CAMBI_TARIFFA_CL))
                                  classPeriodo = homePeriodo.findRepricClass(cod_tipo_contr, StaticContext.INFR_BATCH_CAMBI_TARIFFA_CL);  
                          }
                          else
                            {
                             datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"RP",comboFunzSelez,"S");
                             if(datiBatch!=null)
                                   flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString();  

                             if(sys!=null && sys.equalsIgnoreCase("S"))
                             {
                               if(flagTipoContr!=null && flagTipoContr.equals("0"))  //ULL, NP,CPS, COLOCATION
                               {
                                 if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_SP))//23
                                     classPeriodo = homePeriodo.findValAttSpec1(cod_tipo_contr);
                                 else 
                                 if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CREDITO_SP))//24
                                     classPeriodo = homePeriodo.findNotaCreSpec1(cod_tipo_contr);
                                 else 
                                 if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_CAMBI_TARIFFA_SP))//25
                                     classPeriodo = homePeriodo.findRepricing(cod_tipo_contr, StaticContext.INFR_BATCH_CAMBI_TARIFFA_SP);  
                              }
                              else
                              {
                                 if(flagTipoContr!=null && flagTipoContr.equals("1"))  //CVP, ADSL, EASYIP, CPVSA
                                 {
                                   if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_XDSL))
                                      classPeriodo = homePeriodo.findValAttSpec2(cod_tipo_contr);
                                   else 
                                   if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CRED_XDSL))
                                       classPeriodo = homePeriodo.findNotaCreSpec2(cod_tipo_contr);
                                  if(comboFunzSelez!=null && comboFunzSelez.equals("26"))
                                      classPeriodo = homePeriodo.findRepSpec2(cod_tipo_contr);
                                  if(comboFunzSelez!=null && comboFunzSelez.equals("29"))
                                      classPeriodo = homePeriodo.findFattMan(cod_tipo_contr);
                                 }//if
                              }//else
                             }//if
                            }//else
                            
                            Object[] objs=classPeriodo.toArray();
                  
                           if ((classPeriodo!=null)&&(classPeriodo.size()!=0))
                            {
                              // Visualizzo elementi
                              %>
                               <select class="text" title="Classe combo periodi di riferimento" name="comboPeriodo" onfocus="if (this.disabled) {window.alert('Bisogna selezionare una funzionalità');}" onchange="carDatiCli();">
                                  <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(21)%></option>
                               <%
                               for (int i=0; i<classPeriodo.size(); i++)
                                {
                                  PeriodoRifBMP obj=(PeriodoRifBMP)objs[i];
                                  String sel="";
                                  if((PeriodoRifSelez!=null) && (PeriodoRifSelez.equals(obj.getCode()))) 
                                      sel="selected";%>
                                  <option value="<%=obj.getCode()%>" <%=sel%>><%=obj.getDesc()%></option>
                               <%}//for%> 
                               </select>
                              <%   
                              }//if
                            else
                              {
                                
                              // Visualizzo solo [Seleziona Opzione]
                              %>
                              <SCRIPT LANGUAGE='Javascript'>
                                Disable(document.reportForm.comboPeriodo);
                               </SCRIPT>
                               <select class="text" name="comboPeriodo" onfocus="this.blur(); window.alert('Periodi di riferimento non disponibili per la funzionalità selezionata');">
                                 <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(21)%></option>
                               </select>
                              <%
                              }
                          %>
                         </td>
                          <% } %>
                    </tr>
                 </table>  
                </td>
                
              </tr>
                 
            </table>
					</td>
        </tr>
        
        <tr>
       <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
      
<!-- INSERISCO ISTRUZIONI PER LA LISTA INIZIO -->
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
                <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/body/pixel.gif" width="1" height='2'></td>
              </tr>
               <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                          <tr>
           				           <td <td colspan='2'>&nbsp;</td>
                          </tr>
                          <tr> 
                            <td class="textB" valign="top" width="30%">&nbsp;Account</td>
                            <td class="text" align="left" width="70%">
                            <Select name="cmbAccount" size="7" style="width: 80%;" width="400px" class="text">
<%
                       if(caricaDatiCli!= null && caricaDatiCli.equals("true"))
                         {
                           if(sys!=null && sys.equalsIgnoreCase("C"))
                             {
                               if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_CL))
                                  datiCli = homeDatiCli.findValAttClass(descPeriodoSelez.substring(0,10), descPeriodoSelez.substring(13), cod_tipo_contr,comboFunzSelez,sys);//data inizio, data fine
                               else    
                               if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_SAR))
                                  datiCli = homeDatiCli.findAvanzRicClass(PeriodoRifSelez.substring(4), PeriodoRifSelez.substring(0,4), cod_tipo_contr,sys);
                               else    
                               if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CREDITO_CL))
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////              datiCli = homeDatiCli.findNotaCreClass(descPeriodoSelez.substring(0,10), cod_tipo_contr,sys);
//////   Modificata da MIMMO il 20/05/2003 per bug su vilualizzazione degli ACCOUNT (report note di credito)
//////   Nota: viene passata l'intera stringa e la sustr viene fatta nel package
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                   datiCli = homeDatiCli.findNotaCreClass(descPeriodoSelez, cod_tipo_contr,sys);
                               else    
                               if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_CAMBI_TARIFFA_CL))
                                 {
                                   codeElab=(homeDatiCli.findCodElabBatch(comboFunzSelez, descPeriodoSelez.substring(0,19), sys)).getCodElabBatch();  
                                   datiCli = homeDatiCli.findRepricClass(cod_tipo_contr,comboFunzSelez, codeElab, sys);  
                                 }
                             } 
                             else
                               {
                                 if(sys!=null && sys.equalsIgnoreCase("S"))
                                   {
                                     if(flagTipoContr!=null && flagTipoContr.equals("0")) // ULL, NP, CPS, COLOCATION
                                       {
                                          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_SP))
                                            datiCli = homeDatiCli.findValAttSpec1(descPeriodoSelez.substring(0,10), descPeriodoSelez.substring(13), cod_tipo_contr,comboFunzSelez,sys);
                                          else  
                                          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CREDITO_SP))
                                             datiCli = homeDatiCli.findNotaCreSpec1(descPeriodoSelez.substring(13), descPeriodoSelez.substring(0,10), cod_tipo_contr,sys);
                              
                                       }
                                     else
                                       {
                                         if(flagTipoContr!=null && flagTipoContr.equals("1")) //CVP, ADSL, EASYIP, CPVSA
                                           {
                                             if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_XDSL))
                                               datiCli = homeDatiCli.findValAttSpec2(descPeriodoSelez.substring(0,10), descPeriodoSelez.substring(13), cod_tipo_contr,comboFunzSelez,sys);
                                             else
                                             if(comboFunzSelez!=null && comboFunzSelez.equals("26"))
                                               datiCli = homeDatiCli.findRepricSpec(descPeriodoSelez.substring(0,10), descPeriodoSelez.substring(13), cod_tipo_contr,comboFunzSelez,sys);
                                             else
                                             if(comboFunzSelez!=null && comboFunzSelez.equals("29"))
                                               datiCli = homeDatiCli.findFattMan(descPeriodoSelez.substring(0,10), descPeriodoSelez.substring(13), cod_tipo_contr,comboFunzSelez,sys);
                                             else
                                             if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CRED_XDSL))
                                               datiCli = homeDatiCli.findNotaCreSpec2(descPeriodoSelez.substring(13), descPeriodoSelez.substring(0,10), cod_tipo_contr,sys);
                                            }
                                       }
                                   }
                               }
            
      if ((datiCli==null)||(datiCli.size()==0))
         {
            
%>        
       <!--   EEE    <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="7" class="textB" align="center">No Record Found</td>
              </tr>
EEE-->
<%              
         }else //(datiCli==null)||(datiCli.size()==0)
          {
              Object[] objs=datiCli.toArray();
                for (int i=0;i<datiCli.size();i++)
                {
                    DatiCliBMP obj=(DatiCliBMP)objs[i];
                 
                  if (i==0){
                      sSELECTED="SELECTED";
                   }else { 
                      sSELECTED="";
                   }
                   
                %>
                  <option value="<%=obj.getAccount()%>" <%=sSELECTED%>><%=obj.getDesc()%></option>
                <%    

                    }//for
               
          }//chiusura dell'else

       }//if su carica lista
      %>
         </select>
          </td>
              </tr>
              <tr>
           				<td <td colspan='2'>&nbsp;</td>
              </tr>
             </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
<!--DD--> </table>
    </td>
  </tr><!--DD--> 
        <tr>
       <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
    
<!-- iNSERISCO ISTRUZIONI PER LA 2 LISTA  -->
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
                   <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/body/pixel.gif" width="1" height='2'></td>
                 </tr>
                  <tr>
                   <td>
                      <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                        <tr>
           				        <td colspan='2'>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td class="textB" valign="top" width="30%">&nbsp;Account</td>
                    			<td class="text" align="left" width="70%">
                            <Select name="cmbRiepilogoAccount" size="7" width="400px" style="width: 80%;" class="text">
                            </select>
                          </td>
                        </tr>
                        <tr>
    	                     <td <td colspan='2'>&nbsp;</td>
                        </tr>
                      </table>
                    </td>                      
                  </tr>
                </table>
              </td>
            </tr>
            
            <tr>
              <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
            </tr>
            <%--
            if(sys!=null && sys.equalsIgnoreCase("S")){
            %>
            <!-- SCHEDULAZIONE -->
            <tr>
              <td>
                <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                  <tr>
                    <td  class="textB" align="right">
                     Schedulazione:
                     <input type=checkbox name=schedulazione value="N" onclick="f_calendarioSchedReport(document.reportForm.schedulazione)"> &nbsp;
                     Data/Ora Schedulazione :&nbsp;             
                     <input type="text" class="text" size=20 maxlength="20" name="dataSched" title="dataSched" value="" onblur="handleblur('data_ini');"> 
                     <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
                     <a href="javascript:cancelCalendar(document.reportForm.dataSched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
                     &nbsp;
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <!-- SCHEDULAZIONE -->
            <%}--%>
            
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
     <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/body/pixel.gif" width="1" height='3'></td>
  </tr>
  
  <tr>
    <td >
    <sec:ShowButtons VectorName="bottonSp" />
 
<!-- iNSERISCO ISTRUZIONI PER LA LISTA FINE -->
  </td>
 </tr>
  
</TABLE>
<input type="hidden" name=flagTipoContr id=flagTipoContr value="<%=flagTipoContr%>">
</form>
</BODY>
</HTML>
