<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %> 
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"PrePopolamento.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String dataSystem=Utility.getDateDDMMYYYY();
//RESET VARIABILE DEGLI STEPS X IL LANCIO BATCH
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));

clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
//String codUtente=strUserName.getUserName();
String codProfile=strUserName.getUserProfile();

String cod_tipo_contr                   = request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr = request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr = (String)session.getAttribute("cod_tipo_contr");

String des_tipo_contr                   = request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr = request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr = (String)session.getAttribute("des_tipo_contr");


String TProv=request.getParameter("prov");

String comboCicloFattSelez = null;
String dataIniCiclo = null;
String act=null;
String codeFunzBatch   = null;
String codeFunzBatchNC = null;
String codeFunzBatchRE = null;
String flagTipoContr   = null; 
String numAcc ="0" ;
String periodoFatturazione=null;
String dataFineCiclo=null;
String dataInizioCiclo=null;
String dataIniPerFattSel=null;
String dataFinePerFattSel=null;
String disabComboCicloFatt="";
// Vettore contenente risultati query per il caricamento della lista
Collection datiCli=null;   
Collection datiCliApp=null;   
Collection dati=null;
BatchElem  datiBatch=null;
String Desc_Account = null;
String codeElab=null;
String sSELECTED = null;    
String[] CodeAccountRiep = request.getParameterValues("CodeAccountRiep");
if (CodeAccountRiep==null) CodeAccountRiep = (String[])session.getAttribute("CodeAccountRiep");
String urlComTc= Misc.nh((String)session.getAttribute("URL_COM_TC"));
//RESET VARIABILE DEGLI STEPS X IL LANCIO BATCH
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));
%>
<EJB:useHome id="homePredValAtt" type="com.ejbBMP.DatiCliBMPHome" location="DatiCliBMP" />
<EJB:useHome id="homeParam" type="com.ejbBMP.DatiCliBMPHome" location="DatiCliBMP" />
<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeCicloFatt" type="com.ejbBMP.CicloFatBMPHome" location="CicloFatBMP" />
<%
 datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"PP",null,"S");
 if (datiBatch!=null)
 {
   codeFunzBatch = datiBatch.getCodeFunz();
   flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString(); 
 }  

 datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"VN",null,"S");
 if (datiBatch!=null)
     codeFunzBatchNC=  datiBatch.getCodeFunz();
 datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"VR",null,"S");
 if (datiBatch!=null)
     codeFunzBatchRE=  datiBatch.getCodeFunz();     
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lancio Valorizzazione Attiva
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/LancioValAttivaSp.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<!-- NUOVO CALENDARIO -->
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<!-- NUOVO CALENDARIO -->
<SCRIPT LANGUAGE="JavaScript">
var msg1="Click per selezionare la data";
var msg2="Click per cancellare la data selezionata";
var attivaCalendario=true;
var attivaCalendarioSched=true;
var codeFunzBatch   = "<%=codeFunzBatch%>";
var codeFunzBatchNC = "<%=codeFunzBatchNC%>";
var codeFunzBatchRE = "<%=codeFunzBatchRE%>";
var flagTipoContr   = "<%=flagTipoContr%>";
var comboCicloFattSelez;
var dataIniCiclo;
vectorAccount   = new Array();
vectorRiepXBatch= new Array();
var stringaAccDat="";
var accountSearch="";
var dataInizioSearch="";
var dataFineSearch="";
var objForm="document.lancioVAForm";

function add_combo_elem(Field,Value, Text)
{
var NS4 = (document.layers) ? true : false;
var IE4 = (document.all) ? true : false;
objForm='document.lancioVAForm';

if (NS4)
		{
			var newOpt  = new Option(Text,Value);
			var selLength = eval(objForm+'.'+Field+'.length');
			eval(objForm+'.'+Field+'.options[selLength]= newOpt') ;
		}
		else if (IE4)
		{
			var newOpt = document.createElement("OPTION");
			newOpt.text=Text;
			newOpt.value=Value;
			eval(objForm+'.'+Field+'.add(newOpt)');
		}
}

function impostaSoloScarti()
{
  if(document.lancioVAForm.soloScarti.checked)
  {
    Disable(document.lancioVAForm.soloPopolamento);
    Disable(document.lancioVAForm.paralPopolamento);
    document.lancioVAForm.soloPopolamento.checked=false;
    document.lancioVAForm.paralPopolamento.checked=false;
    document.lancioVAForm.soloPopolamento.value="S";
    document.lancioVAForm.paralPopolamento.value="V";
    document.lancioVAForm.dataFineA.value="";
    if (attivaCalendario) dis_calendario();
    
  }
  else
  {
    Enable(document.lancioVAForm.soloPopolamento);
    Enable(document.lancioVAForm.paralPopolamento);
    document.lancioVAForm.soloPopolamento.checked=false;
    document.lancioVAForm.paralPopolamento.checked=false;
    document.lancioVAForm.soloPopolamento.value="S";
    document.lancioVAForm.paralPopolamento.value="V";    
    if (!attivaCalendario) abi_calendario();
  }
}

function impostaParalPopolamento() {
   if(document.lancioVAForm.paralPopolamento.checked)  {
      Disable(document.lancioVAForm.soloScarti);
      document.lancioVAForm.soloScarti.checked=false;
      
      Enable(document.lancioVAForm.soloPopolamento);
      document.lancioVAForm.soloPopolamento.checked=true;
      document.lancioVAForm.soloPopolamento.value="S";      
    
      document.lancioVAForm.generaReport.checked=false;
      document.lancioVAForm.generaReport.value="0";
      Disable(document.lancioVAForm.generaReport);  
      
      document.lancioVAForm.paralPopolamento.value = 'P';
      
   } else {
        Enable(document.lancioVAForm.soloScarti);
        document.lancioVAForm.soloScarti.checked=false;
        
        Enable(document.lancioVAForm.soloPopolamento);
        document.lancioVAForm.soloPopolamento.checked=false;
        document.lancioVAForm.soloPopolamento.value="S";         
      
        document.lancioVAForm.generaReport.checked=false;
        document.lancioVAForm.generaReport.value="0";
        Enable(document.lancioVAForm.generaReport);  
   
       document.lancioVAForm.paralPopolamento.value = 'V';     
    }
}

function impostaSoloPopolamento()
{
  if(document.lancioVAForm.soloPopolamento.checked)
  {
    document.lancioVAForm.generaReport.checked=false;
    document.lancioVAForm.generaReport.value="0";
    Disable(document.lancioVAForm.generaReport);
    
    Enable(document.lancioVAForm.paralPopolamento);
    document.lancioVAForm.paralPopolamento.checked=false;
    document.lancioVAForm.paralPopolamento.value = 'V';   
    
    Disable(document.lancioVAForm.soloScarti);
    document.lancioVAForm.soloScarti.checked=false;    
  }
  else
  {
    Enable(document.lancioVAForm.generaReport);
    Enable(document.lancioVAForm.paralPopolamento);
    Enable(document.lancioVAForm.soloScarti);
    document.lancioVAForm.paralPopolamento.checked=false;
    document.lancioVAForm.paralPopolamento.value = 'V';      
  }
}

function clear_all_combo(Field)
	{
    objForm='document.lancioVAForm';
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
		var len = eval(objForm+'.'+Field+'.length');
		var NS4 = (document.layers) ? true : false;
		var IE4 = (document.all) ? true : false;
		for (i=0;len>i;i++)
		{
			if (NS4)
				eval(objForm+'.'+Field+'.options[0]=null');
			else if (IE4)
				eval(objForm+'.'+Field+'.remove(0)');
		}
	}

function handle_press_cambio_ciclo()
{
   if  (document.lancioVAForm.act.value=="no_batch")
      alert("Ci sono elaborazione Batch in corso di valorizzazione di Billing\rdunque non è possibile cambiare ciclo");
   else
   {
      document.lancioVAForm.dataFineA.value="";
      DisabilitaBotton();
  }      
}

function ONCAMBIA_CICLO()
{
    document.lancioVAForm.act.value="search_fatt";
    if  (codeFunzBatch=="23" || codeFunzBatch=="21" || codeFunzBatch=="PREP")
    {
       var strURL="AccountSp.jsp";
        strURL+="?act=search_fatt";
        strURL+="&codeFunzBatch="+codeFunzBatch;
        strURL+="&comboCicloFattSelez="+document.lancioVAForm.comboCicloF[document.lancioVAForm.comboCicloF.selectedIndex].value;
//        strURL+="&dataIniCiclo="+document.lancioVAForm.dataIniCiclo.value;
        strURL+="&dataIniCiclo=01/01/2000"+document.lancioVAForm.dataIniCiclo.value;
        strURL+="&codeFunzBatchNC="+codeFunzBatchNC;
        strURL+="&codeFunzBatchRE="+codeFunzBatchRE;        
        strURL+="&cod_tipo_contr="+document.lancioVAForm.cod_tipo_contr.value;
        strURL+="&des_tipo_contr="+document.lancioVAForm.des_tipo_contr.value;
        strURL+="&prov="+document.lancioVAForm.prov.value;
    openDialog(strURL, 400, 5,handle_press_cambio_ciclo);
    }
    else
       alert("Funzionalità Batch non valida");
}


function verificaInsSelez()
{
  if(!document.lancioVAForm.soloScarti.checked)
  {
     if (document.lancioVAForm.dataFineA.value==null || document.lancioVAForm.dataFineA.value=="null" || document.lancioVAForm.dataFineA.value=="")
    {
        messaggio="il campo \'DATA FINE PERIODO\' è obbligatorio!";
        return false;
    }

    else
    {
        dataFineAConv     = convertiData(document.lancioVAForm.dataFineA.value);
        dataFineCicloConv = convertiData(document.lancioVAForm.dataFineCiclo.value);
        dataSistemaConv   = "<%=dataSystem%>".substring(6,10) + "<%=dataSystem%>".substring(3,5)+ "<%=dataSystem%>".substring(0,2);
        dataMassimo=convertiData(document.lancioVAForm.comboRiepilogoAccount.options[0].text.substring(0,10));
        for (var i=1; document.lancioVAForm.comboRiepilogoAccount.length>i; i++)
        {
          dataAnalizzare=document.lancioVAForm.comboRiepilogoAccount.options[i].text.substring(0,10);
          if (dataAnalizzare>dataMassimo)
            dataMassimo=dataMassimo;
          }
          dataInizioAConv=dataMassimo;
          dataInizioARiConv=dataMassimo.substring(6,8)+"/"+dataMassimo.substring(4,6)+"/"+dataMassimo.substring(0,4)

          if (dataSistemaConv >= dataFineAConv)
          {
            if (dataFineAConv>dataInizioAConv)
            {
              if (dataFineCicloConv >=dataFineAConv)
              {
                return true;
            }  
            else
            {
              //messaggio="la data fine periodo deve essere minore o uguale alla data fine ciclo di fatturazione";
              return true;
            }
          }
          else
          {
            //messaggio="la data fine periodo deve essere strettamente maggiore della data di inizio periodo \rmaggiore tra quelle degli account da valorizzare e cioè "+dataInizioARiConv;
            return true;
          }
        }
        else
        {
          messaggio="la data fine periodo deve essere minore o uguale alla data di sistema";
          return false;
        }
      }
      
   }
   else
    return true;
}


function ONLANCIOBATCH()
{
    if (verificaInsSelez())
    {
        document.lancioVAForm.act.value="lancio_batch";
        if  (flagTipoContr=="0" || flagTipoContr=="1")
        {
          if (document.lancioVAForm.soloPopolamento.checked)
            document.lancioVAForm.soloPopolamento.value="S";
          else
            document.lancioVAForm.soloPopolamento.value="S";
            
          if (document.lancioVAForm.paralPopolamento.checked)
            document.lancioVAForm.paralPopolamento.value="P";
          else
            document.lancioVAForm.paralPopolamento.value="V";
            
//          if (document.lancioVAForm.soloScarti.checked)
//            document.lancioVAForm.soloScarti.value="1";
//          else
            document.lancioVAForm.soloScarti.value="0";

          if (document.lancioVAForm.generaReport.checked)
            document.lancioVAForm.generaReport.value="1";
          else
            document.lancioVAForm.generaReport.value="0";

          for (var i=0; document.lancioVAForm.comboRiepilogoAccount.length>i;i++)
            stringaAccDat=stringaAccDat+document.lancioVAForm.comboRiepilogoAccount.options[i].value+"*";

          document.lancioVAForm.strAccount.value=stringaAccDat;     
          cod_tipo_contr=document.lancioVAForm.cod_tipo_contr.value;
          Enable(document.lancioVAForm.dataFineA);
          Enable(document.lancioVAForm.dataSched);
          if(document.lancioVAForm.schedulazione.checked){
            if(document.lancioVAForm.dataSched.value == "" || document.lancioVAForm.dataSched.value == undefined){
              alert("Inserire la Data/Ora Schedulazione");
            }else{
              Disable(lancioVAForm.LANCIOBATCH);
              document.lancioVAForm.action = "LancioValAttiva2Sp.jsp";
              document.lancioVAForm.submit();
            }
          }else{
            Disable(lancioVAForm.LANCIOBATCH);
            document.lancioVAForm.action = "LancioValAttiva2Sp.jsp";
            document.lancioVAForm.submit();
          }
        }
        else
           alert("Tipo Contratto non valido");
    }       
   else
       window.alert(messaggio);
}

function handle_change_ciclo()
{
  if (document.lancioVAForm.comboCicloF.length>1)
      Enable(document.lancioVAForm.comboCicloF);
  Enable(document.lancioVAForm.comboAccount);  
  Enable(document.lancioVAForm.comboRiepilogoAccount);
  
  if (document.lancioVAForm.comboAccount.length>0)
  {
     Enable(document.lancioVAForm.CAMBIA_CICLO);
  }   
  
  if (document.lancioVAForm.ciclo.value=="")
  {
    alert("non esiste il periodo associato al ciclo selezionato");
    document.location.replace("<%=urlComTc%>"); //torna sulla pagina di scelta del tipo contratto
  }  
  DisabilitaBotton();
}

function carPeriodi2()
{
     var selezione=document.lancioVAForm.comboCicloF[document.lancioVAForm.comboCicloF.selectedIndex].value;
     clear();
   var strURL="LancioValAttivaWfSp.jsp";
   strURL+="?act=caricaTutto";
   strURL+="&resize=false";
   strURL+="&comboCicloFattSelez="+document.lancioVAForm.comboCicloF[document.lancioVAForm.comboCicloF.selectedIndex].value;
   strURL+="&cod_tipo_contr="+document.lancioVAForm.cod_tipo_contr.value;
   strURL+="&prov="+document.lancioVAForm.prov.value;
   
   openDialog(strURL, 400, 5,handle_change_ciclo);
}

function setInitialValue()
{
  objForm=document.lancioVAForm;
  DisableAllControls(objForm);
  if (document.lancioVAForm.comboCicloF.length>1)
      Enable(document.lancioVAForm.comboCicloF);
  document.lancioVAForm.dataFineA.value="";
  document.lancioVAForm.dataSched.value="";
  DisabilitaBotton();
}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<!--<BODY onload="start();">-->
<%homePredValAtt.findPredValAtt(cod_tipo_contr);%>
<form name="lancioVAForm" method="post" action="PrePopolamento.jsp">   
<input type="hidden" name=comboCicloFattSelez     id= comboCicloFattSelez     value="<%=comboCicloFattSelez%>">
<input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
<input type="hidden" name=codeFunzBatchNC         id=codeFunzBatchNC          value="<%=codeFunzBatchNC%>">
<input type="hidden" name=codeFunzBatchRE         id=codeFunzBatchRE          value="<%=codeFunzBatchRE%>">
<input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">
<input type="hidden" name=act                     id=act                      value="<%=act%>">
<input type="hidden" name=strAccount              id=strAccount               value="">
<input type="hidden" name="dataIniCiclo"          id="dataIniCiclo"           value="">
<input type="hidden" name="dataFineCiclo"         id="dataFineCiclo"          value="">
<input type="hidden" name="cod_tipo_contr"        id=cod_tipo_contr           value="<%=cod_tipo_contr%>">
<input type="hidden" name="des_tipo_contr"        id=des_tipo_contr           value="<%=des_tipo_contr%>">
<input type="hidden" name=soloPopolamento value="S">
<input type="hidden" name=soloScarti value="0">
<input type="hidden" name=generaReport value="0" >
<input type="hidden" name=paralPopolamento value="V">
<input type="hidden" name="PrePopolamento" value="S">     
<input type="hidden" name="prov" value="<%=TProv%>">

<script language='javascript'> 
     var selezione=1;
     clear();
   var strURL="LancioValAttivaWfSp.jsp";
       strURL+="?act=caricaTutto";
       strURL+="&resize=false";
       strURL+="&comboCicloFattSelez=1";
       strURL+="&cod_tipo_contr="+document.lancioVAForm.cod_tipo_contr.value;
       strURL+="&prov=<%=TProv%>";
       openDialog(strURL, 400, 5,handle_change_ciclo);
</script>
                              
<%if (CodeAccountRiep!=null)
 {
   for (int i=0; i<CodeAccountRiep.length; i++)
   {%>
   <input type="hidden" name=CodeAccountRiep id=CodeAccountRiep value=<%=CodeAccountRiep[i]%>>
 <%}%>
   <input type="hidden" name=numAcc id=numAcc value=<%=CodeAccountRiep.length%>>
<%}%>

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPaginaPrePopolamento.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="2"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lancio Batch Valorizzazione Attiva: &nbsp; <%=des_tipo_contr%> </td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
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
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
<div style="display:none">
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                     <td  class="textB" align="left">&nbsp Ciclo di fatturazione:</td>
 					           <td  class="text"  align="left">
                          <%
                            Collection oggfatt= homeCicloFatt.findCicloFat();
                            Object[] objs=oggfatt.toArray();
                            if ((oggfatt!=null)&&(oggfatt.size()!=0))
                              {// Visualizzo elementi
                              %>
                              
                               <select class="text" title="Combo ciclo Fatturazione" name="comboCicloF" onFocus="" onchange="carPeriodi2();">
                                  <option value="-1" >[Seleziona Opzione]</option>
                               <%
                                 CicloFatBMP obj=null;
                                 for (int i=0; i<oggfatt.size(); i++)
                                 {
                                 obj=(CicloFatBMP)objs[i];
                                 String sel="";
                                 if((comboCicloFattSelez!=null) && (comboCicloFattSelez.equals(obj.getCodeCicloFat()))) 
                                     sel="selected";%>
                                 <option value="<%=obj.getCodeCicloFat()%>" <%=sel%>> <%=obj.getDescCicloFat()%></option>
                             <%}%> 
                            </select> 
                            <script language='javascript'> 
                              if (document.lancioVAForm.comboCicloF.length==1)
                              {
                                  document.lancioVAForm.comboCicloF[0].selected=true;
                              }    
                              </script>
                              <%   
                              }
                            else
                              { 
                              // Visualizzo [Seleziona Opzione]
                              %>
                               <select class="text" title="Combo ciclo Fatturazione" name="comboCicloF">
                                 <option value="-1" selected>[Seleziona Opzione]</option>
                               </select>         
                              <%
                              }
                          %>
                     </td>
                       <td  class="text" align="right"> &nbsp <input type=hidden class="text" size=23 name="ciclo" value=""> </td>
                       <td  class="text" align="left"><!-- <sec:ShowButtons PageName="LANCIOVALATTIVASP_1" />--> </td>
                    </tr>
                </table>
</td>
              </tr>
            </table>
					</td>
        </tr>
</div>
        <tr>
        <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
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
                    <Select name="comboAccount" size="7" style="width: 80%;" width="400px" class="text">
                    </select>
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
                  <td>&nbsp;</td>              
                  <td class="textB" align="center">
                    <table width="50%" border="0" cellspacing="0" cellpadding="0">
     <!--                 <tr>
                        <td class="textB" nowrap align="left">
                        Solo popolamento: S <input type=checkbox name=soloPopolamento value="S" disabled>&nbsp;&nbsp;

                        </td>
                        <td class="textB" nowrap align="left">
                         Solo scarti: 0 <input type=checkbox name=soloScarti disabled value="0">&nbsp;&nbsp;
                        </td>
                        <td class="textB" nowrap align="left">
                         Genera Report: 0 <input type=checkbox name=generaReport value="0" disabled>&nbsp;&nbsp;
                        </td>
                        <td class="textB" nowrap align="left">
                        <%if (codProfile.equals("SVI")) {
                         %>     
                              Popolamento Parallelo: <input type=checkbox name=paralPopolamento value="V" onclick="impostaParalPopolamento();">&nbsp;&nbsp;     
                        <%} else { %>
                              <input style="visibility:hidden;" type=checkbox name=paralPopolamento value="V">&nbsp;&nbsp;
                        <% } %> 
                         </td>
                      </tr>
--> 
                <tr>
                        <td colspan=3 class="textB" nowrap align="left">
                         Data fine periodo :  
                         <input type="text"  class="text" size=10 maxlength="10" name="dataFineA" title="dataFineA" value="" onblur="handleblur('data_ini');"> 
                         <a href="javascript:showCalendar('lancioVAForm.dataFineA','dataFineA');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                         <a href="javascript:cancelCalendar(document.lancioVAForm.dataFineA);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                        </td>
                      </tr>
                    </table>
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
        </table>
       </td>
      </tr>
      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>
      <tr> 
       <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
      </tr>
      <tr>
       <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
 
           <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
            <tr>
             <td  class="textB" align="right">
               Schedulazione:
               <input type=checkbox name=schedulazione value="N" onclick="f_calendarioSched(document.lancioVAForm.schedulazione)"> &nbsp;
               Data/Ora Schedulazione :&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" name="dataSched" title="dataSched" value="" onblur="handleblur('data_ini');"> 
               <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancelCalendar(document.lancioVAForm.dataSched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
               &nbsp;
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>

</td>
      </tr>
      <tr>
       <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
 </table>
  <tr>
    <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
        <sec:ShowButtons VectorName="vectorButton" />
    </td>
  </tr>
</table>
    </td>
   </tr>
 </form>
 <script language="JavaScript">
			 /*var cal1 = new calendar1(document.forms['lancioVAForm'].elements['dataSched']);
			 cal1.year_scroll = true;
			 cal1.time_comp = false;*/
       var cal3 = new calendar1(document.forms['lancioVAForm'].elements['dataSched']);
       cal3.year_scroll = true;
			 cal3.time_comp = true;

      Enable(lancioVAForm.LANCIABATCH);

 </script>
</BODY>
</HTML>

