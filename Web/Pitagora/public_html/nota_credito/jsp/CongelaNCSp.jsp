<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"CongelaNCSp.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");

if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
String codeFunzBatch                   = request.getParameter("codeFunzBatch");
if (codeFunzBatch!=null && codeFunzBatch.equals("null")) codeFunzBatch=null;
String sys=request.getParameter("hidFlagSys");
if (sys==null) sys=request.getParameter("sys");
if (sys==null) sys=(String)session.getAttribute("sys");

String sizeLst=request.getParameter("sizeLst");
String lancioBatch           = request.getParameter("lancioBatch");
if (lancioBatch!=null && lancioBatch.equals("null")) lancioBatch=null;

String account=request.getParameter("account");
String descAccount=request.getParameter("descAccount");
String codeParam=request.getParameter("codeParam");
String congela=request.getParameter("congela");
String congelaTutti=request.getParameter("congelaTutti");
String appomsg=request.getParameter("appomsg");
String appoParam=request.getParameter("appoParam");
String notaCredito=request.getParameter("notaCredito");
String numNCTrovate=request.getParameter("numNCTrovate");
String code_elabNC=request.getParameter("code_elabNC");
if (code_elabNC==null) code_elabNC=(String)session.getAttribute("code_elabNC");
String rtrnAcc=request.getParameter("rtrnAcc");
String entra =request.getParameter("entra");

if(rtrnAcc!=null && rtrnAcc.equals("false"))
    response.sendRedirect((String)session.getAttribute("URL_COM_TC"));



// Vettore contenente risultati query
Collection  accElab;
Collection  accElabTotal; //17-06-2003
int appo_salto = 0;
int nrgCsv = 0;
int nrgPS = 0;
int nrgLst = 0;

int nrgElab = 0; 
String act      = request.getParameter("act");
String blnExit  = request.getParameter("blnExit");
String hidStep ="";
String strResult = "";
String strUrlDiPartenza = request.getContextPath() + "/common/jsp/GenericMsgSp.jsp";
	strUrlDiPartenza += "?CONTINUA=true";
int intStepNow ;
if(Misc.nh(request.getParameter("hidStep")).equals(""))
{
 intStepNow = 1;
}
else
{
 intStepNow = Integer.parseInt(Misc.nh(request.getParameter("hidStep")));
}

		Integer lInt_SessionStep = null;
		lInt_SessionStep = (Integer)request.getSession().getAttribute("NUMBER_STEP_LANCIO_BATCH");
		if(lInt_SessionStep == null)
    {
			lInt_SessionStep = new Integer(0);
		}

	//CONTROLLO DEGLI STEPS
	if(!Misc.gestStepXLancio(request,intStepNow) && intStepNow!=1) //250603
  {
    String strDestinationURL = Misc.nh((String)session.getAttribute("URL_COM_TC"));
    response.sendRedirect(strDestinationURL); 
  }
%>
   <EJB:useHome id="homeLstAccElab2" type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
   <EJB:useHome id="homeLstAccElab3" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />
   <EJB:useHome id="homeLstAccElab4" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />

<%

//CASO 0 ci sono elaborazioni batch i n corso
//Congela Selezionato
//CASO 1 Generato NC=sì, Generato CSV=sì, Lancio Batch
//CASO 2 Generato NC=sì, Generato CSV=no, messaggio non generato CSV e Blocco
//CASO 3 Generato NC=no, Generato CSV=non controllo, Lancio Batch
//Congela Tutti
//CASO 4 Generato NC=tutti no, quelli che hanno gen NC Generato CSV=non controllo, POP_UP1 e Lancio Batch
//CASO 5 Generato NC=almeno 1 sì e almeno 1 no, quelli che hanno gen NC Generato CSV=sì, POP_UP1 e Lancio Batch
//CASO 6 Generato NC=almeno 1 sì e almeno 1 no, quelli che hanno gen NC Generato CSV=no, POP_UP2 e blocco
//CASO 7 Generato NC=sì, quelli che hanno gen NC Generato CSV=sì, Lancio Batch
//CASO 8 Generato NC=sì, quelli che hanno gen NC Generato CSV=almeno 1 no, POP_UP2 e blocco

        int size=0;
        int occ=0;
        int occ1=0;
        String visualizza="false";
        if(congela!=null && congela.equals("true"))
        {
         size=1;
         if (numNCTrovate!=null && (new Integer(numNCTrovate)).intValue()>0)
            notaCredito = "-";
         else  
            notaCredito = "0";
        }
        else
        if (sizeLst!=null)
        {
          Integer tmpsize=new Integer(sizeLst);
          size=tmpsize.intValue();
        }
        int[] nLst= new int[size];
        int[] nPS=new int[size];
        String[] accountSelTutto = new String[size];
        String[] vectCodeParam = new String[size];
              
        accElab = (Collection) session.getAttribute("accElab");
        Object[] objs=accElab.toArray();
        if(congelaTutti.equals("true") && size>1)
        {
          for (int i=0;i<accElab.size();i++)
          {
            LstAccElabElem obj=(LstAccElabElem)objs[i];
            accountSelTutto[i] =obj.getCodeAccount();
            vectCodeParam[i] = obj.getCodeParam();
          } 
        }
        else
        {
           vectCodeParam[0] = codeParam;
           accountSelTutto[0] =account;
        } 

        clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
        String codUtente=strUserName.getUserName();
        if(rtrnAcc!=null && rtrnAcc.equals("true"))
        {  
          lancioBatch="true";
          congelaTutti="true";
        }  

    switch (intStepNow)
    {
		case 2:
                   //flagTipoContr 0 oppure 1 a seconda del tipo contratto
                   nrgElab = (homeLstAccElab4.findElabBatchUguali(Integer.parseInt(flagTipoContr))).getElabUguali();

                   if (nrgElab!=0)
                   {
                       act="no_batch"; //CASO 0
                       blnExit = "true";
                    }
                   else  //CASO 4, CASO 5
                   {
                       String messaggio= codeFunzBatch+"$"+codUtente+"$"+"_"; 
                       for(int i=0;i<size;i++)
                       {
                        //if(notaCredito.charAt(i)!='0') //deve inviare anche se non è stata generata Nota Di Credito
                           messaggio=messaggio+"$"+vectCodeParam[i];
                       }
                              //System.out.println("messaggio"+messaggio);
                              //int p=0; //forzatura
                       
                      LancioBatch oggLancioBatch= new LancioBatch();
                      int p=oggLancioBatch.Esecuzione(messaggio);
                      if(p==0)
                        act="batchOK";
                      else
                        act="batchNO";
                      blnExit = "true";
                    }
                
           break;
          case 4:
                       //CASO 1, CASO 3
                       String messaggio= codeFunzBatch+"$"+codUtente+"$"+"_";
                       for(int i=0;i<size;i++)
                       {
                          messaggio=messaggio+"$"+vectCodeParam[i];
                       }

                      //System.out.println("messaggio"+messaggio);
                      //int p=0; //forzatura
                       
                      LancioBatch oggLancioBatch= new LancioBatch();
                      int p=oggLancioBatch.Esecuzione(messaggio);
                      if(p==0)
                         act="batchOK";
                      else
                         act="batchNO";
                      blnExit = "true";
                  
          break;

          case 3:
                  //flagTipoContr 0 oppure 1 a seconda del tipo contratto
                   nrgElab = (homeLstAccElab4.findElabBatchUguali(Integer.parseInt(flagTipoContr))).getElabUguali();

                   if (nrgElab!=0)
                   {
                       act="no_batch"; //CASO 0
                       blnExit = "true";
                    }
                    else   //CASO 1, CASO 3
                    {
                     //intStepNow=4;
                      blnExit = "false";
                   }
          break;


          default:

          //notaCredito="1-------------------1" ; //250603 simulazione
          if((entra==null || (entra!=null && entra.equals("null"))) && notaCredito.indexOf("-")==-1) //non trovo -
          { 
             if(congelaTutti.equals("true")&& size>1)
             {
               //act="accountNO";
               blnExit = "false";
               }
             else {
               act="account_nc";
               blnExit = "false";
             }
          intStepNow=0;//rientra nel default per verificare la nota di credito   
          entra="NO";//non rientra nell if iniziale 
          }
          else
          {//1 nota
             if(rtrnAcc.equals("true"))
             {
              //intStepNow=2;
              blnExit = "false";
             }  
             else 
             {//1.1  
              for(int i=0;i<size;i++)
              {
                //if(cod_tipo_contr.equals(StaticContext.ULL))
               visualizza="false";//250603
               nrgCsv=1;//250603
              if(notaCredito.charAt(i)!='0') //250603
              {
                if(flagTipoContr.equals("0"))
                {
                   nrgCsv = (homeLstAccElab2.findCsvSPNC(accountSelTutto[i])).getCsv();
                   //nrgCsv=0 nrgCsv significa che il CSV non è stato generato per l'ACCOUNT");
                   //nrgCsv=0;   //simulatione tutti Report OK   se = 1  NON OK con 0              
                }
                else  
                {
                  if(flagTipoContr.equals("1"))
                    nrgCsv = (homeLstAccElab2.findCsvXDSLNC(accountSelTutto[i])).getCsv();
                }
               }//250603
               //if(nrgCsv==0 && notaCredito.charAt(i)!='0') //250603
               if(nrgCsv==0) 
                {
                   visualizza="true";   
                   //CSV non generato per l'ACCOUNT e notaCredito trovate");
                   break;
                }   
              }//for 
               
              if(visualizza.equals("true"))
              {
                  //if(notaCredito.indexOf("1")!=-1 && congelaTutti.equals("true")&& size>1) //se esiste almeno un account con NC
                  if(congelaTutti.equals("true")&& size>1) //se esiste almeno un account con NC
                  { 
                     //CSV almeno un account non ha il report e non generato per tutti gli ACCOUNT chiamo POP UP congelaTutti=true size>1");
                     act="POP_UP2";  //CASO 6, CASO 8
                     blnExit = "alt";
                  }
                  else
                  {
                     //CSV non generato NON POSSO CONGELARE");                    
                     act="congelaNO"; //CASO 2
                     blnExit = "true";
                  }
              }//if
              else
              {
                  //ha trovato 0 cioè non sono sono tutti !=0, il caso tutti =0 era stato bloccato prima
                  if(notaCredito.indexOf("0")!=-1 && congelaTutti.equals("true")&& size>1)
                  {
                      act="POP_UP1";
                      blnExit = "alt";
                  }
                  else
                  {
                     //CSV generato per tutti gli ACCOUNT");
 //                  intStepNow=intStepNow+1;
                     int appo_num_step = ((Integer)request.getSession().getAttribute("NUMBER_STEP_LANCIO_BATCH")).intValue();
                     appo_num_step =appo_num_step+1;
                     request.getSession().setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(appo_num_step));
                     appo_salto=1;
                     blnExit = "false";
                  }    
              }//else
             }//else 1.1
          }//else 1
        
break;
}

 if(lancioBatch!=null && lancioBatch.equals("true"))
   lancioBatch="false";
 if(lancioBatch==null)
   lancioBatch="true";
  if(rtrnAcc!=null)
   rtrnAcc=null;  
%> 

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lancio Report </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>

</HEAD>

<BODY onload="setInitialValue();">

<form name="lancioForm" action="CongelaNCSp.jsp" method="post">

<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value=<%=cod_tipo_contr%>>
<input type="hidden" name=des_tipo_contr    id=des_tipo_contr     value="<%=des_tipo_contr%>">
<input type = "hidden" name = "hidStep" value="<%=intStepNow%>">
<input type = "hidden" name = "hidTypeLoad" value="">
<input type="hidden" name=sizeLst id=sizeLst value="<%=sizeLst%>">
<input type="hidden" name=act id= act  value= "<%=act%>">
<input type="hidden" name=blnExit id=blnExit  value= "<%=blnExit%>">
<input type="hidden" name=lancioBatch id= lancioBatch  value= <%=lancioBatch%>>
<input class="textB" type="hidden" name="rtrnAcc" value="<%=rtrnAcc%>">
<input type="hidden" name=account    id=account      value="<%=account%>">
<input type="hidden" name=descAccount    id=descAccount      value="<%=descAccount%>">
<input type="hidden" name=codeParam    id=codeParam      value="<%=codeParam%>">
<input type="hidden" name=congela    id=congela      value=<%=congela%>>
<input type="hidden" name=congelaTutti    id=congelaTutti      value=<%=congelaTutti%>>
<input type="hidden" name=notaCredito    id=notaCredito      value="<%=notaCredito%>">
<input type="hidden" name=numNCTrovate    id=numNCTrovate      value=<%=numNCTrovate%>>
<input type="hidden" name=appomsg    id=appomsg      value="<%=appomsg%>">
<input type="hidden" name=appoParam    id=appoParam      value="<%=appoParam%>">
<input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">  
<input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
<input type="hidden" name=entra           id=entra            value="<%=entra%>">
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

function goNextStep()
{

	document.lancioForm.hidStep.value = parseInt(document.lancioForm.hidStep.value) + 1 + <%=appo_salto%>;
	document.lancioForm.submit();	
}

function VisualizzaAccount(contr)
{
     document.lancioForm.blnExit.value="STOP";
     document.lancioForm.lancioBatch.value="false";
     var controllo = contr;
     rtrnAcc = document.lancioForm.rtrnAcc.value;
     var stringa='../../nota_credito/jsp/NCAccountSp.jsp?controllo='+controllo+'&rtrnAcc='+rtrnAcc+'&cod_tipo_contr=<%=cod_tipo_contr%>&code_elabNC=<%=code_elabNC%>&flagTipoContr=<%=flagTipoContr%>';
     openDialog(stringa, 700, 400, handleReturnedValueAccount);
}

function handleReturnedValueAccount()
{
  if(document.lancioForm.rtrnAcc.value=="true")
  {
       document.lancioForm.congelaTutti.value="true";
       goNextStep();
  }
       
}
function setInitialValue()
{

 <%
	if(blnExit!=null && blnExit.equals("true"))
  {
    if (act!=null && act.equals("no_batch")) 
       strResult="Processo interrotto.Vi sono elaborazioni batch in corso."; 
    else if (act!=null && act.equals("batchOK"))
      strResult="Elaborazione batch avviata correttamente!"; 
    else if (act!=null && act.equals("batchNO"))
      strResult="Errore nel lancio della procedura batch."; 
   /*else if (act!=null && act.equals("accountNO"))
     {
        strResult="Gli account presenti nella lista non hanno generato nota di credito."; 
     }
     else if (act!=null && act.equals("account_nc"))
     {
        strResult="L'account selezionato non ha generato nota di credito."; 
     }*/
    else 
    if (act!=null && act.equals("congelaNO"))
    {
       //strResult="Non è possibile effettuare il congelamento perchè per l'account  selezionato non è stato generato il file Csv."; 
       if(congelaTutti!=null && congelaTutti.equals("true")) //se dopo la POP-UP 2 si vuole questo messaggio
          strResult="Non è possibile effettuare il congelamento perchè ci sono account selezionati per i quali non è stato generato il file Csv.";        
       else 
         strResult="Non è possibile effettuare il congelamento perchè per l'account selezionato non è stato generato il file Csv.";          
     //response.sendRedirect(request.getContextPath()+"/common/jsp/GenericMsgSp.jsp?message=" + java.net.URLEncoder.encode(strResult)); 
     }

     String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
     strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
     response.sendRedirect(strUrl);
  }
  else if(blnExit==null || blnExit.equals("false"))
  {
   if (act=="account_nc")
   {%>
      alert("L'account selezionato non ha generato nota di credito.");
   <%}%>
     goNextStep();
<%}  
  else if(blnExit!=null && blnExit.equals("alt"))
  {
  if (act!=null && act.equals("POP_UP1")) 
    {%>
       VisualizzaAccount("accNoNC");
  <%}
  if (act!=null && act.equals("POP_UP2")) 
    { %>
       VisualizzaAccount("csv");
  <%}
  }
  %>
}
</SCRIPT>
 
 

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
