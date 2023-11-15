<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioPreValSp.jsp")%>
</logtag:logData>
<%--sec:ChkUserAuth/--%>

<%!
String[] CodeAccountRiep1 = null;
String[] CodeAccountRiep2 = null;
%>

<%
//response.addHeader("Pragma", "no-cache");
//response.addHeader("Cache-Control", "no-store");

String comboCicloFattSelez = request.getParameter("comboCicloFattSelez");
String codeFunzBatch       = request.getParameter("codeFunzBatch");
String txtDataFineAcq      = request.getParameter("txtDataFineAcq");
String comboServizi      = request.getParameter("comboServizi");

if(txtDataFineAcq== null)
  txtDataFineAcq = "";
  
int lancioOK=0;
Collection remoteAccNoteCred =null;
Collection remoteAccRepricing=null;

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


       if (act!=null && act.equals("non_lanciare_batch"))  //CASE 4, CASE 5, CASE 8
       {
         act="non_lanciare_batch";
         blnExit = "true";
       }
       else
       {//1
         //if ((act!=null && act.equals("lanciare_batch")) || (act!=null && act.equals("lanciare_batch_Note_Repricing")))// CASE 1, CASE 2 ,CASE 3, CASE 6, CASE 7, CASE 9, CASE 10
         if ((act!=null && act.equals("lancio_batch")) || (act!=null && act.equals("lanciare_batch_Note_Repricing")))// CASE 1, CASE 2 ,CASE 3, CASE 6, CASE 7, CASE 9, CASE 10
         { 
           String datiBatch="";
           String dataAAAAMMGG="";
           int indice=0;
           
          String messaggio = "";
          System.out.println("txtDataFineAcq ["+txtDataFineAcq+"]");
          java.text.SimpleDateFormat sdfSrc = new java.text.SimpleDateFormat("dd/MM/yyyy");
          java.text.SimpleDateFormat sdfDst = new java.text.SimpleDateFormat("yyyyMMdd");
          txtDataFineAcq = sdfDst.format(sdfSrc.parse(txtDataFineAcq));
          System.out.println("txtDataFineAcq ["+txtDataFineAcq+"]");
          System.out.println("comboServizi ["+comboServizi+"]");
          

          codeFunzBatch = "PREVAL_SPE";
          messaggio= codeFunzBatch+"$"+codUtente+"$"+comboServizi+"$"+txtDataFineAcq;
          

          System.out.println(messaggio);
          
          if (lancioOK!=-1)
          {
             LancioBatch oggLancioBatch= new LancioBatch();
             lancioOK=oggLancioBatch.Esecuzione(messaggio);
             //lancioOK=0;//FORZATURA
          }   


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
     <%}}//else 1
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
   codeFunzBatch  ="<%=codeFunzBatch%>";
   var stringaAcc="";
   <%
   if  ((codeFunzBatch.equals("21") || codeFunzBatch.equals("23"))
        &&
        ((act.equals("accountNoteCred") ) 
          ||(act.equals("accountRepricing")))
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

   
   System.out.println("LancioPreValSp.jsp => URL ["+strUrl+"]");
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
<form name="frmDati" action="LancioPreValSp.jsp" method="post">
<input type="hidden" name=comboCicloFattSelez id= comboCicloFattSelez  value= "<%=comboCicloFattSelez%>">
<input type="hidden" name=codeFunzBatch   id= codeFunzBatch   value= "<%=codeFunzBatch%>">
<input type="hidden" name="hidTypeLoad"                       value="">
<input type="hidden" name="hidStep"                           value="<%=intStepNow%>"> 
<input type="hidden" name=act             id= act             value= "<%=act%>">
<input type="hidden" name=blnExit         id=blnExit          value= "<%=blnExit%>">
<input type="hidden" name=button          id=button           value="">


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
