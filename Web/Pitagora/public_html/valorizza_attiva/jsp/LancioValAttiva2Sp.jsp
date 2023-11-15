<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioValAttiva2Sp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth/>

<%!
String[] CodeAccountRiep1 = null;
String[] CodeAccountRiep2 = null;
//dichiarazione costanti per gli step
static final int gintStepElabBatchXlancio = 1;
static final int gintStepVerEsNoteCredito = 2;
static final int gintStepVerEsRepricing   = 3; 
static final int gintStepLancioBatch      = 4; 
%>

<%
//response.addHeader("Pragma", "no-cache");
//response.addHeader("Cache-Control", "no-store");

String comboCicloFattSelez = request.getParameter("comboCicloFattSelez");
String dataIniCiclo        = request.getParameter("dataIniCiclo");
String codeFunzBatch       = request.getParameter("codeFunzBatch");
String codeFunzBatchNC     = request.getParameter("codeFunzBatchNC");
String codeFunzBatchRE     = request.getParameter("codeFunzBatchRE");
String flagTipoContr       = request.getParameter("flagTipoContr");
String soloPopolamento     = request.getParameter("soloPopolamento");
String paralPopolamento     = request.getParameter("paralPopolamento");
String soloScarti          = request.getParameter("soloScarti");
String generaReport        = request.getParameter("generaReport");
String soloReport          = request.getParameter("soloReport");
String dataFineA           = request.getParameter("dataFineA");
String dataSched           = request.getParameter("dataSched");
if(dataSched== null)
  dataSched = "";
if(dataFineA==null)
  dataFineA="";
if (soloPopolamento==null || (soloPopolamento!=null  && soloPopolamento.equalsIgnoreCase("null")))
    soloPopolamento="N";
if (paralPopolamento==null || (paralPopolamento!=null  && paralPopolamento.equalsIgnoreCase("null")))
    paralPopolamento="V";    
if (soloScarti==null || (soloScarti!=null  && soloScarti.equalsIgnoreCase("null")))
    soloScarti="0";
if (generaReport==null || (generaReport!=null  && generaReport.equalsIgnoreCase("null")))
    generaReport="0";
int numElabInCorsoAcc=0;
int numAccNoteCred =0;
int numAccRepricing=0;
int lancioOK=-1;

Collection remoteAccNoteCred =null;
Collection remoteAccRepricing=null;
String[] CodeAccountRiep =request.getParameterValues("CodeAccountRiep1");
if (CodeAccountRiep==null) CodeAccountRiep = (String[])session.getAttribute("CodeAccountRiep1");
String       strAccount          = request.getParameter("strAccount"); 
String numAcc = request.getParameter("numAcc");
if (numAcc==null || numAcc.equals("null")) numAcc="0";
String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");
String urlComTc= Misc.nh((String)session.getAttribute("URL_COM_TC"));
String sys=request.getParameter("hidFlagSys");
if (sys==null) sys=request.getParameter("sys");
if (sys==null) sys=(String)session.getAttribute("sys");
String comboFunzSelez   = request.getParameter("comboFunzSelez");
String appoggio      = request.getParameter("appoggio");
String act      = request.getParameter("act");
String blnExit  = request.getParameter("blnExit");
String codeElab=null;
String strResult = "";

int intStepNow;
int intAction;
int	intFunzionalita;

if(Misc.nh(request.getParameter("intAction")).equals(""))
{
  intAction = 0;
}
else
{
  intAction =Integer.parseInt(Misc.nh(request.getParameter("intAction")));
}

if(Misc.nh(request.getParameter("intFunzionalita")).equals(""))
{
  intFunzionalita = 0;
}
else
{
  intFunzionalita =Integer.parseInt(Misc.nh(request.getParameter("intFunzionalita")));
}
String strUrlDiPartenza = request.getContextPath() + "/common/jsp/GenericMsgSp.jsp";
	 strUrlDiPartenza += "?CONTINUA=true";

if(Misc.nh(request.getParameter("hidStep")).equals(""))
{
    intStepNow = 1;
}
else
{
    intStepNow =Integer.parseInt(Misc.nh(request.getParameter("hidStep")));
}

//CONTROLLO DEGLI STEPS
if(! Misc.gestStepXLancio(request,intStepNow))
{
  response.sendRedirect((String)session.getAttribute("URL_COM_TC"));
}
%>
  <EJB:useHome id="homeEB"      type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />
  <EJB:useHome id="homeAccount" type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" />
  <EJB:useHome id="homeParam"   type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" />
<%
clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
String codUtente=strUserName.getUserName();
String codProfile=strUserName.getUserProfile();

//CASO 0  Ci sono elaborazioni Batch in corso e non si lancia
//CASO 1  non apro POP-UP NCred, non apro POP-UP Repr, Lancio su tutto
//CASO 2  non apro POP-UP NCred, apro POP-UP Repr senza scremare, Lancio su tutto
//CASO 3  non apro POP-UP NCred, apro POP-UP Repr scremo, scrematura non vuota, Lancio scrematura
//CASO 4  non apro POP-UP NCred, apro POP-UP Repr scremo, scrematura vuota, non Lancio
//CASO 5  apro POP-UP NCred scremo, scrematura vuota, non Lancio
//CASO 6  apro POP-UP NCred scremo, scrematura non vuota, non apro POP-UP Repr, Lancio scrematura
//CASO 7  apro POP-UP NCred non scremo, non apro POP-UP Repr, Lancio su tutto
//CASO 8  apro POP-UP NCred scremo, scrematura non vuota, apro POP-UP Repr scremo, scrematura vuota, non Lancio
//CASO 9  apro POP-UP NCred scremo, scrematura non vuota, apro POP-UP Repr scremo, scrematura non vuota, Lancio scrematura
//CASO 10 apro POP-UP NCred scremo, scrematura non vuota, apro POP-UP Repr non scremo, Lancio prima scrematura

switch (intStepNow)
{
		case gintStepElabBatchXlancio://1 Controllo elaborazioni Batch in corso
         if(flagTipoContr.equals("0") || flagTipoContr.equals("1"))
         {
               //numElabInCorsoAcc = (homeEB.findElabBatchUguali((new Integer(flagTipoContr)).intValue())).getElabBatch();
               if(dataSched.equals("") || dataSched == null)
                numElabInCorsoAcc = (homeEB.findElabBatchCodeTipoContrUguali(cod_tipo_contr)).getElabUguali();               
               if (numElabInCorsoAcc!=0) //CASO 0
               {
                   act="batch_in_corso";
                   blnExit = "true";   //blocco tutto perché ci sono Elaborazioni Batch in corso
                   %>
                   <Script language='JavaScript'>
                      document.frmDati.act.value="<%=act%>";
                      document.frmDati.blnExit.value="<%=blnExit%>"
                   </Script> 
             <%}
             else
                  act="next_step";  //vado al passo 2 perché non ci sono Elaborazioni Batch in corso  
         }
		break;
    
    case gintStepVerEsNoteCredito://2 Si verifica se esistono account per i quali non è stata congelata la Nota Di Credito
         if  (codeFunzBatchNC.equals("24") || codeFunzBatchNC.equals("22"))
         {
          //accountNoteCred(request,response);
          remoteAccNoteCred= homeAccount.findAllAccNoteCred(codeFunzBatchNC,cod_tipo_contr);
          if ((remoteAccNoteCred!=null))
              numAccNoteCred=remoteAccNoteCred.size();

         //costruisce un String[] di account in input strAccount ,una stringa nel formato account1*sccount2*account3* ecc...
         Vector vettore=Misc.split(strAccount,"*");
         CodeAccountRiep1 = new String[vettore.size()-1];
         CodeAccountRiep1[0]=new String("");
         for (int i=0; i< CodeAccountRiep1.length;i++)
             CodeAccountRiep1[i]=(String)vettore.get(i);

          request.getSession().setAttribute("CodeAccountRiep1",CodeAccountRiep1);                    

          if (numAccNoteCred!=0)
          {
               act="accountNoteCred"; //visualizza la POP-UP account Note Credito e torna act = lanciare_batch_Note_Repricing, se la scrematura non è vuota o non_lanciare_batch;
               session.setAttribute("account", remoteAccNoteCred);
          }     
          else
               act="next_step"; //non ho aperto la POP-UP e vado al passo 3
        }   
    break;

    case gintStepVerEsRepricing://3 Si verifica se esistono account della famiglia ULL per i quali non è stato congelato il Repricing

         if  (codeFunzBatchRE.equals("25")) //|| codeFunzBatchRE.equals(""))
         {
            //torno dalla POP-UP e ho account da esaminare(lanciare_batch_Note_Repricing) oppure non ho chiamato la POP-UP e devo eseguire comunque il controllo su Repricing (next_step)
            if  (act!=null &&  (act.equalsIgnoreCase("lanciare_batch_Note_Repricing") || act.equalsIgnoreCase("next_step"))) //1 
            {
              remoteAccRepricing= homeAccount.findAllAccRepricing("LancioValAttiva2Sp",codeFunzBatchRE,cod_tipo_contr);
              
              if ((remoteAccRepricing!=null))
                 numAccRepricing=remoteAccRepricing.size();

              Object[] objs=remoteAccRepricing.toArray();
              DatiCliBMP objScrem=null;

              for (int i=0;i<remoteAccRepricing.size();i++)
                   objScrem=(DatiCliBMP)objs[i];
            
              if (numAccRepricing!=0)
              {
                CodeAccountRiep2 = new String[new Integer(numAcc).intValue()];
                CodeAccountRiep2[0]=new String("");
                for (int i=0; i< new Integer(numAcc).intValue();i++)
                   CodeAccountRiep2[i]=CodeAccountRiep1[i];

                request.getSession().setAttribute("CodeAccountRiep1",CodeAccountRiep2);
                act="accountRepricing"; //visualizza finestra account Repricing;
                session.setAttribute("account", remoteAccRepricing);
             }     
            } 
            if (act!=null && act.equals("next_step"))  //non ho aperto le POP-UP
                act="lanciare_batch";  //vado al passo 4  e lancio su tutto CASE 2
         }//if 1  
         else //tipo contratto appartenente alla famiglia xDSL non controllo il Repricing
         {
           if (act!=null && act.equals("next_step"))  //non ho aperto le POP-UP
               act="lanciare_batch";  //vado al passo 4  e lancio su tutti gli account CASE 1
           //Se ho aperto la prima POP-UP e ho tipo contratto appartenente alla famiglia xDSL
           //o ho act=lanciare_batch_Note_Repricing oppure act=non_lanciare_batch
         }  
    break;

    case gintStepLancioBatch: //4 Si Lancia il Batch
       default:

       if (act!=null && act.equals("non_lanciare_batch"))  //CASE 4, CASE 5, CASE 8
       {
         act="non_lanciare_batch";
         blnExit = "true";
       }
       else
       {//1
         if ((act!=null && act.equals("lanciare_batch")) || (act!=null && act.equals("lanciare_batch_Note_Repricing")))// CASE 1, CASE 2 ,CASE 3, CASE 6, CASE 7, CASE 9, CASE 10
         { 
           String datiBatch="";
           String dataAAAAMMGG="";
           int indice=0;
           
           if (act!=null && act.equals("lanciare_batch")) // CASE 1, CASE 2, CASE 7, CASE 10
           {
              indice=CodeAccountRiep.length;
           }   
           else
           if (act!=null && act.equals("lanciare_batch_Note_Repricing")) // CASE 3, CASE 6, CASE 9
           {
              if (numAcc!=null)
              {
                 Integer numAccInt= new Integer(numAcc);
                 indice=numAccInt.intValue();
              }
           } 

           for (int i=0; i<indice ;i++)
           {
             DatiCliBMP codeParamBMP= homeParam.findCodeParamAccount(CodeAccountRiep[i]);  
             String codeParam=codeParamBMP.getCodeParam();
             if (codeParam!=null)
             {
               lancioOK=-2;
               if(soloScarti.equals("1"))
                dataAAAAMMGG="00000000";
               else
                dataAAAAMMGG=dataFineA.substring(6,10)+dataFineA.substring(3,5)+dataFineA.substring(0,2);
               if (i==(indice-1))
                 datiBatch=datiBatch+dataAAAAMMGG+codeParam;
               else
                 datiBatch=datiBatch+dataAAAAMMGG+codeParam+'$';
             }   
             else 
             {
               lancioOK=-1;
               i=indice;
             }
          }//for

          String messaggio = "";
          System.out.println("DATA_SCHED ["+dataSched+"]");
          if((codeFunzBatch.equals("21")) || (codeFunzBatch.equals("PREP")))
          {
             if (codProfile.equals("SVI")) { 
                  if(dataSched.equals("") || dataSched == null)
                    messaggio= codeFunzBatch+"$"+codUtente+"$"+generaReport+"$_$"+soloPopolamento+"$"+soloScarti+"$"+paralPopolamento+"$"+datiBatch;
                  else
                    messaggio= "$"+dataSched+"$"+cod_tipo_contr+"$"+codeFunzBatch+"$"+codUtente+"$"+generaReport+"$_$"+soloPopolamento+"$"+soloScarti+"$"+paralPopolamento+"$"+datiBatch;
            } else {
                  if(dataSched.equals("") || dataSched == null)
                    messaggio= codeFunzBatch+"$"+codUtente+"$"+generaReport+"$_$"+soloPopolamento+"$"+soloScarti+"$"+datiBatch;
                  else
                    messaggio= "$"+dataSched+"$"+cod_tipo_contr+"$"+codeFunzBatch+"$"+codUtente+"$"+generaReport+"$_$"+soloPopolamento+"$"+soloScarti+"$"+datiBatch;            
            }
          }          
          
          else
          {
            if(dataSched.equals("") || dataSched == null)
              messaggio= codeFunzBatch+"$"+codUtente+"$"+generaReport+"$_$"+soloPopolamento+"$"+datiBatch;
            else
              messaggio= "$"+dataSched+"$"+cod_tipo_contr+"$"+codeFunzBatch+"$"+codUtente+"$"+generaReport+"$_$"+soloPopolamento+"$"+datiBatch;
          }

          
          System.out.println(messaggio);
          
          if (lancioOK!=-1)
          {
             LancioBatch oggLancioBatch= new LancioBatch();
             lancioOK=oggLancioBatch.Esecuzione(messaggio);
             //lancioOK=0;//FORZATURA
          }   
         }//if 2

      if(lancioOK==0){
         act="batchOK";
      }else if(lancioOK==1){  
         act="schedOK";
      }else{
         act="batchNO";
      }
      blnExit = "true";%>
      <Script language='JavaScript'>
        document.frmDati.act.value="<%=act%>";
        document.frmDati.blnExit.value="<%=blnExit%>";
      </Script>
     <%}//else 1
    break;
  }//switch
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lancio Report </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/misc.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>

<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function handleReturnedOpenDialog()
{
   if (document.frmDati.button.value=="CONFERMA")
   {
      if (document.frmDati.act.value=="non_lanciare_batch")
      {
          document.frmDati.act.value="non_lanciare_batch";
          document.frmDati.blnExit.value="true";
      }
      goNextStep();
   }       
   else
   {
     document.location.replace("<%=urlComTc%>"); //torna sulla pagina di scelta del tipo contratto
   }
}

function window_account()
{

<%
  if (act!=null && ( act.equals("accountNoteCred") || act.equals("accountRepricing")))
  {%>
   var act="<%=act%>";
   dataIniCiclo   ="<%=dataIniCiclo%>";
   cod_tipo_contr ="<%=cod_tipo_contr%>";
   des_tipo_contr ="<%=des_tipo_contr%>";
   codeFunzBatch  ="<%=codeFunzBatch%>";
   codeFunzBatchNC="<%=codeFunzBatchNC%>";
   codeFunzBatchRE="<%=codeFunzBatchRE%>";
   soloPopolamento="<%=soloPopolamento%>";
   paralPopolamento="<%=paralPopolamento%>";   
   dataFineA      ="<%=dataFineA%>";
   dataSched      ="<%=dataSched%>";
   var stringaAcc="";
   <%
   if  ((codeFunzBatch.equals("21") || codeFunzBatch.equals("23"))
        &&
        ((act.equals("accountNoteCred") && (codeFunzBatchNC.equals("22") || codeFunzBatchNC.equals("24"))) 
          ||(act.equals("accountRepricing") && (codeFunzBatchRE.equals("25"))))
       )    
   {%>
       varstringa='../../valorizza_attiva/jsp/AccNoteCredSp.jsp?act='+act+'&codeFunzBatch='+codeFunzBatch+'&soloPopolamento='+soloPopolamento+'&dataSched='+dataSched+'&dataFineA='+dataFineA+'&dataIniCiclo='+dataIniCiclo+'&cod_tipo_contr='+cod_tipo_contr+'&des_tipo_contr='+des_tipo_contr+'&act='+act+'&codeFunzBatchNC='+codeFunzBatchNC+'&codeFunzBatchRE='+codeFunzBatchRE;//+stringaAcc;
       openDialog(varstringa, 650, 350, handleReturnedOpenDialog);
 <%}
  else
  {%>
      alert("Funzionalità Batch non gestita");
      document.location.replace("<%=urlComTc%>"); //torna sulla pagina di scelta del tipo contratto
  <%}
  }%>
}

function setInitialValue()
{
<%
	if(blnExit!=null && blnExit.equals("true"))
  {
    if (act!=null && act.equals("non_lanciare_batch")) 
        strResult="Elaborazione Batch non avviata per mancanza di Account validi!";
    else if (act!=null && act.equals("batch_in_corso")) 
        strResult="Processo interrotto.Vi sono elaborazioni batch in corso.";
    else if (act!=null && act.equals("batchOK"))
        strResult="Elaborazione batch avviata correttamente!"; 
    else if (act!=null && act.equals("schedOK"))
        strResult="Schedulazione batch avviata correttamente!";        
    else if (act!=null && act.equals("batchNO"))
        strResult="Errore nel lancio della procedura batch.";
    
    String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
   
//   strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);

   
   System.out.println("LancioValAttiva2Sp.jsp => URL ["+strUrl+"]");
   response.sendRedirect(strUrl);
  }
  else 
  {
    if (act!=null && ( act.equals("accountNoteCred") || act.equals("accountRepricing")))
    {
    %>
       window_account();
    <%}   
    else 
    if ( act!=null && 
        ( act.equals("next_step") || act.equals("lanciare_batch") || act.equals("lanciare_batch_Note_Repricing")))
    {%>
       goNextStep(); //esegue il prossimo step
   <%}%>
<% }%>
}
</SCRIPT>
</HEAD>

<BODY onload="setInitialValue();">
<form name="frmDati" action="LancioValAttiva2Sp.jsp" method="post">
<input type="hidden" name=strAccount      id= strAccount      value= "<%=strAccount%>">
<input type="hidden" name=comboCicloFattSelez id= comboCicloFattSelez  value= "<%=comboCicloFattSelez%>">
<input type="hidden" name=dataIniCiclo    id= dataIniCiclo    value= "<%=dataIniCiclo%>">
<input type="hidden" name=codeFunzBatch   id= codeFunzBatch   value= "<%=codeFunzBatch%>">
<input type="hidden" name=codeFunzBatchNC id= codeFunzBatchNC value= "<%=codeFunzBatchNC%>">
<input type="hidden" name=codeFunzBatchRE id= codeFunzBatchRE value= "<%=codeFunzBatchRE%>">
<input type="hidden" name=flagTipoContr   id= flagTipoContr   value= "<%=flagTipoContr%>">
<input type="hidden" name=cod_tipo_contr  id= cod_tipo_contr  value= "<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr  id= des_tipo_contr  value= "<%=des_tipo_contr%>">
<input type="hidden" name="hidTypeLoad"                       value="">
<input type="hidden" name="hidStep"                           value="<%=intStepNow%>"> 
<input type="hidden" name=act             id= act             value= "<%=act%>">
<input type="hidden" name=blnExit         id=blnExit          value= "<%=blnExit%>">
<input type="hidden" name=soloPopolamento id=soloPopolamento  value= "<%=soloPopolamento%>">
<input type="hidden" name=paralPopolamento id=paralPopolamento  value= "<%=paralPopolamento%>">
<input type="hidden" name=soloScarti      id=soloScarti       value= "<%=soloScarti%>">
<input type="hidden" name=generaReport    id=generaReport     value= "<%=generaReport%>">
<input type="hidden" name=soloReport      id=soloReport       value= "<%=soloReport%>">
<input type="hidden" name=dataFineA       id=dataFineA        value= "<%=dataFineA%>">
<input type="hidden" name=dataSched       id=dataSched        value= "<%=dataSched%>">
<input type="hidden" name=button          id=button           value="">

<%if (CodeAccountRiep1!=null)
 {
   for (int i=0; i<CodeAccountRiep1.length; i++)
   {%>
      <input type="hidden" name=CodeAccountRiep1 id=CodeAccountRiep1 value=<%=CodeAccountRiep1[i]%>>
 <%}
   if (intStepNow<3)
   {%>
     <input type="hidden" name=numAcc id=numAcc value=<%=CodeAccountRiep1.length%>> 
 <%}
   else
   {%>
     <input type="hidden" name=numAcc id=numAcc value=<%=numAcc%>>
<%}
}%>

</form>
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/titoloPagina.gif" alt="" border="0"></td> <tr>
</table>

<!--TITOLO PAGINA-->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lancio Batch</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<center>
	<h1 class="textB">
	Lancio Batch in Corso...<br>
	Attendere
	</h1>
</center> 
</BODY>
</HTML>
