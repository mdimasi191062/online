<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"CongelaRepricing2Sp.jsp")%>
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
String repricing=request.getParameter("repricing");
String numRepricingTrovate=request.getParameter("numRepricingTrovate");
String code_elab=request.getParameter("code_elab");
if (code_elab==null) code_elab=(String)session.getAttribute("code_elab");
String rtrnAcc=request.getParameter("rtrnAcc");

// Vettore contenente risultati query
Collection  accElab;
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
	if(Misc.nh(request.getParameter("hidStep")).equals("")){
        intStepNow = 1;
    }else{
        intStepNow = Integer.parseInt(Misc.nh(request.getParameter("hidStep")));
    }
 


		Integer lInt_SessionStep = null;
		lInt_SessionStep = (Integer)request.getSession().getAttribute("NUMBER_STEP_LANCIO_BATCH");
		if(lInt_SessionStep == null){
			lInt_SessionStep = new Integer(0);
		}

	
	//CONTROLLO DEGLI STEPS
	if(! Misc.gestStepXLancio(request,intStepNow)){
String strDestinationURL = Misc.nh((String)session.getAttribute("URL_COM_TC"));

      response.sendRedirect(strDestinationURL);
    }
%>
   <EJB:useHome id="homeLstAccElab2" type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
   <EJB:useHome id="homeLstAccElab3" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />
   <EJB:useHome id="homeLstAccElab4" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />

<%
        int size=0;
        int occ=0;
        int occ1=0;
        String visualizza="false";
          if(congela!=null && congela.equals("true"))
          {
            size=1;
            if (numRepricingTrovate!=null && (new Integer(numRepricingTrovate)).intValue()>0)
             repricing = "-";
            else  repricing = "0";
           }
          else  if (sizeLst!=null)
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
 
   switch (intStepNow){
		case 2:  
    
        //flagTipoContr 0 oppure 1 a seconda del tipo contratto
                   nrgElab = (homeLstAccElab4.findElabBatchUguali(Integer.parseInt(flagTipoContr))).getElabUguali();
                   if (nrgElab!=0)
                   {
                             act="no_batch";
                             blnExit = "true";
                    }
                   else
                   {
                
                       String messaggio= codeFunzBatch+"$"+codUtente+"$"+"_";
                       for(int i=0;i<size;i++)
                       {
                        if(repricing.charAt(i)!='0')
                         messaggio=messaggio+"$"+vectCodeParam[i];
                       }
                              //System.out.println("messaggio"+messaggio);
                       
                       LancioBatch oggLancioBatch= new LancioBatch();
                       int p=oggLancioBatch.Esecuzione(messaggio);
                       if(p==0)
                          act="batchOK";
                      else    act="batchNO";
                      blnExit = "true";
                       
                      
                    }
                
           break;
          case 4:
                    
                       String messaggio= codeFunzBatch+"$"+codUtente+"$"+"_";
                       for(int i=0;i<size;i++)
                       {
                          messaggio=messaggio+"$"+vectCodeParam[i];
                       }
                      //System.out.println("messaggio"+messaggio);
                       
                      LancioBatch oggLancioBatch= new LancioBatch();
                      int p=oggLancioBatch.Esecuzione(messaggio);
                      if(p==0)
                           act="batchOK";
                       else    act="batchNO";
                       blnExit = "true";
                  
          break;
           case 3:
      
        //flagTipoContr 0 oppure 1 a seconda del tipo contratto
         
                   nrgElab = (homeLstAccElab4.findElabBatchUguali(Integer.parseInt(flagTipoContr))).getElabUguali();
                   if (nrgElab!=0)
                   {
                              act="no_batch";
                             blnExit = "true";
                       
                    }
                    else
                    {
                 
                   blnExit = "false";
                   }
                   
           break;
           default:
           if(repricing.indexOf("-")==-1)
           {
             if(congelaTutti.equals("true")&& size>1)
             {
               act="accountNO";
               blnExit = "true";
               }
             else {
               act="account_repricing";
               blnExit = "true";
             }
           }
           else
           {//nota
           
                  if(rtrnAcc.equals("true"))
                  {
                  //intStepNow=2;
                   blnExit = "false";
                  }  
                  else 
                  {  
                   //ha trovato 0 cioè non sono sono tutti !=0, il caso tutti =0 era stato bloccato prima
                   if(repricing.indexOf("0")!=-1 && congelaTutti.equals("true")&& size>1)
                   {
                            act="POP_UP1";
                             blnExit = "alt";
                             
                   }
                   else
                   {
//                   intStepNow=intStepNow+1;
                     int appo_num_step = ((Integer)request.getSession().getAttribute("NUMBER_STEP_LANCIO_BATCH")).intValue();
                     appo_num_step =appo_num_step+1;
                     request.getSession().setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(appo_num_step));
                     appo_salto=1;
                     blnExit = "false";
                  }    
                }//else
           }//else nota
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
<TITLE> Verifica Repricing </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>

</HEAD>

<BODY onload="setInitialValue();">

<form name="lancioForm" action="CongelaRepricing2Sp.jsp" method="post">

<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value="<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr    id=des_tipo_contr     value="<%=des_tipo_contr%>">
<input type = "hidden" name = "hidStep" value="<%=intStepNow%>">
<input type = "hidden" name = "hidTypeLoad" value="">
<input type="hidden" name=sizeLst id=sizeLst value="<%=sizeLst%>">
<input type="hidden" name=act id= act  value= "<%=act%>">
<input type="hidden" name=blnExit id=blnExit  value= "<%=blnExit%>">
<input type="hidden" name=lancioBatch id= lancioBatch  value= "<%=lancioBatch%>">
<input class="textB" type="hidden" name="rtrnAcc" value="<%=rtrnAcc%>">
<input type="hidden" name=account    id=account      value="<%=account%>">
<input type="hidden" name=descAccount    id=descAccount      value="<%=descAccount%>">
<input type="hidden" name=codeParam    id=codeParam      value="<%=codeParam%>">
<input type="hidden" name=congela    id=congela      value="<%=congela%>">
<input type="hidden" name=congelaTutti    id=congelaTutti      value="<%=congelaTutti%>">
<input type="hidden" name=repricing    id=repricing      value="<%=repricing%>">
<input type="hidden" name=numRepricingTrovate    id=numRepricingTrovate      value="<%=numRepricingTrovate%>">
<input type="hidden" name=appomsg    id=appomsg      value="<%=appomsg%>">
<input type="hidden" name=appoParam    id=appoParam      value="<%=appoParam%>">
<input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">  
<input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
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
     var stringa='../../conguagli_cambi_tariffa/jsp/RepricingAccountSp.jsp?controllo='+controllo+'&rtrnAcc='+rtrnAcc+'&cod_tipo_contr=<%=cod_tipo_contr%>&des_tipo_contr=<%=des_tipo_contr%>&code_elab=<%=code_elab%>&flagTipoContr=<%=flagTipoContr%>';

     openDialog(stringa, 580, 380, handleReturnedValueAccount);
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
          
	if(blnExit!=null && blnExit.equals("true")){
    if (act!=null && act.equals("no_batch")) 
    {
       strResult="Processo interrotto.Vi sono elaborazioni batch in corso.";
    }
     else if (act!=null && act.equals("batchOK"))
     {
       strResult="Elaborazione batch avviata correttamente!"; 
     }
      else if (act!=null && act.equals("batchNO"))
     {
        strResult="Errore nel lancio della procedura batch."; 
     }
     else if (act!=null && act.equals("accountNO"))
     {
        strResult="Gli account presenti nella lista non hanno non ha generato il CSV o non è stata congelata la Fattura/Nota di Credito."; 
     }
     else if (act!=null && act.equals("account_repricing"))
     {
        strResult="L'account selezionato non ha generato il CSV o non è stata congelata la Fattura/Nota di Credito."; 
     }
    /* else if (act!=null && act.equals("congelaNO"))
     {
        strResult="Non è possibile effettuare il congelamento perchè per l'account selezionato non è stato generato il file Csv."; 
     }*/
//     response.sendRedirect(request.getContextPath()+"/common/jsp/GenericMsgSp.jsp?message=" + java.net.URLEncoder.encode(strResult)); 
          String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
          strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
          response.sendRedirect(strUrl);
     
  }
  else if(blnExit==null || blnExit.equals("false"))
  {
       
   %>
  goNextStep();
 <% 
            
}
   else if(blnExit!=null && blnExit.equals("alt"))
  {
  if (act!=null && act.equals("POP_UP1")) 
    {
    %>

       VisualizzaAccount("accNoRPC");
       
       <%
    }
//  if (act!=null && act.equals("POP_UP2")) 
  //  { %>
    //   VisualizzaAccount("csv");
      // <%
   // }
  }
   
  if(rtrnAcc!=null && rtrnAcc.equals("false"))
  {

response.sendRedirect((String)session.getAttribute("URL_COM_TC"));
  %>
  //document.lancioForm.action="CongelaRepricingSp.jsp" ;
  goNextStep(); 
  <% }%>
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
