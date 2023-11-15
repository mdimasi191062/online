<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioBatchSp.jsp")%>
</logtag:logData>

<sec:ChkUserAuth/>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");

String sys=request.getParameter("hidFlagSys");
if (sys==null) sys=request.getParameter("sys");
if (sys==null) sys=(String)session.getAttribute("sys");

String comboFunzSelez   = request.getParameter("comboFunzSelez");
String PeriodoRifSelez  = request.getParameter("PeriodoRifSelez");
String descPeriodoSelez  = request.getParameter("descPeriodoSelez");

String flagTipoContr = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;

String lancioBatch = request.getParameter("lancioBatch");
String appoggio = request.getParameter("appoggio"); //account selezionati
String act = request.getParameter("act");
String blnExit = request.getParameter("blnExit");

String dataSched = request.getParameter("dataSched");

if(dataSched== null)
  dataSched = "";
  
String datiBatch = null;
BatchElem  datiLancioBatch=null;
int elaborBatch = 0;
int elaborBatch2 =0;
int elaborBatch3 =0;
String codeElab=null;
String strResult = "";
String strFlagRepricing="V";
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

String codiceBatch=request.getParameter("codiceBatch");
if (codiceBatch==null) codiceBatch="";

if(Misc.nh(request.getParameter("hidStep")).equals(""))
{
        intStepNow = 1;
}
else
{
        intStepNow =Integer.parseInt(Misc.nh(request.getParameter("hidStep")));
}


	//CONTROLLO DEGLI STEPS

	if(! Misc.gestStepXLancio(request,intStepNow)){
    response.sendRedirect((String)session.getAttribute("URL_COM_TC"));
	}

%>

    <EJB:useHome id="homeElaborBatch" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />
    <EJB:useHome id="homeDatiCli"     type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" />
    <EJB:useHome id="homeBatchSTL" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
    <EJB:useBean id="remoteBatchSTL" type="com.ejbSTL.BatchSTL" scope="session">
       <EJB:createBean instance="<%=homeBatchSTL.create()%>" />
    </EJB:useBean>
<%

    clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
    String codUtente=strUserName.getUserName();

switch (intStepNow){
		case 1:
        if(sys!=null && sys.equalsIgnoreCase("S"))
        {
          if(flagTipoContr!=null && flagTipoContr.equals("0")){
//            elaborBatch = (homeElaborBatch.findElabBatchULL()).getElabBatch();
            if(dataSched.equals("") || dataSched == null)
              elaborBatch = (homeElaborBatch.findElabBatchCodeTipoContrUguali(cod_tipo_contr)).getElabUguali();               
          }
          else{
            if(flagTipoContr!=null && flagTipoContr.equals("1")){
//            elaborBatch = (homeElaborBatch.findElabBatchXDSL()).getElabBatch();
              if(dataSched.equals("") || dataSched == null)
                elaborBatch = (homeElaborBatch.findElabBatchCodeTipoContrUguali(cod_tipo_contr)).getElabUguali();               
            }
          }
       }
       else  
       if(sys!=null && sys.equalsIgnoreCase("C")) //CDN,Interconnessione,Acquisti,CVPA
              elaborBatch = (homeElaborBatch.findElabBatchCL()).getElabBatch();

      if (elaborBatch!=0)
      {
          act="no_batch";
          blnExit = "true";
          %>
          <Script language='JavaScript'>
              document.frmDati.act.value="<%=act%>";
              document.frmDati.blnExit.value="<%=blnExit%>"
          </Script> 
          <%
      }

      break;
      
    case 2:
      datiLancioBatch=remoteBatchSTL.getCodeFunzFlag(cod_tipo_contr,"RP",comboFunzSelez,sys);
      if (datiLancioBatch!=null)
        codiceBatch = datiLancioBatch.getCodeFunz();

      elaborBatch2 = 0;
      if (elaborBatch2!=0)
      {            
        act="no_batch";
        blnExit = "true";
      
        %>
        <Script language='JavaScript'>
            document.frmDati.act.value="<%=act%>";
            document.frmDati.blnExit.value="<%=blnExit%>"
        </Script> 
        <%
      }    
      break;
      
    case 3:
      elaborBatch3 = 0;
      if (elaborBatch3!=0)
      {
         act="no_batch";
         blnExit = "true";
        
         %>
         <Script language='JavaScript'>
            document.frmDati.act.value="<%=act%>";
            document.frmDati.blnExit.value="<%=blnExit%>"
         </Script> 
        <%
      }   
      break;
      
    case 4:
    default:
      if((sys!=null) && sys.equalsIgnoreCase("C"))
      {//A
        if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_CL))
          datiBatch = descPeriodoSelez.substring(6,10)+descPeriodoSelez.substring(3,5)+descPeriodoSelez.substring(0,2);
        else    
        if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_SAR))
          datiBatch = ""+"#"+"";
        else    
        if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CREDITO_CL))
          datiBatch = (homeDatiCli.findCodElabBatch(comboFunzSelez, descPeriodoSelez.substring(13), sys)).getCodElabBatch();  
        else    
        if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_CAMBI_TARIFFA_CL))
          datiBatch = (homeDatiCli.findCodElabBatch(comboFunzSelez, descPeriodoSelez, sys)).getCodElabBatch();//estraggo il CodeElab


      }//A 
      else
      if(sys!=null && sys.equalsIgnoreCase("S"))
      {//B1
       // ULL, NP, CPS, COLOCATION
        if(comboFunzSelez!=null && comboFunzSelez.equals("26"))
        {
          comboFunzSelez=StaticContext.INFR_BATCH_VAL_ATTIVA_XDSL;
          strFlagRepricing="R";
        }
        else if(comboFunzSelez!=null && comboFunzSelez.equals("29"))
        {
          comboFunzSelez=StaticContext.INFR_BATCH_VAL_ATTIVA_XDSL;
          strFlagRepricing="M";
        }
        else
        {
          strFlagRepricing="V";
        }
				if(flagTipoContr!=null && flagTipoContr.equals("0"))
        {//B2
          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_SP))
            datiBatch = descPeriodoSelez.substring(6,10)+descPeriodoSelez.substring(3,5)+descPeriodoSelez.substring(0,2);
          else  
          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CREDITO_SP))
            datiBatch = (homeDatiCli.findCodElabBatch(comboFunzSelez, descPeriodoSelez.substring(13), sys)).getCodElabBatch(); 
          else  
          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_CAMBI_TARIFFA_SP))
            datiBatch = (homeDatiCli.findCodElabBatch(comboFunzSelez,descPeriodoSelez, sys)).getCodElabBatch();//estraggo il CodeElab
        }//B2
        else
        if(flagTipoContr!=null && flagTipoContr.equals("1")) // CVP,ADSL,EASYIP,CPVSA
        {//B4
          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_VAL_ATTIVA_XDSL))
            datiBatch = descPeriodoSelez.substring(6,10)+descPeriodoSelez.substring(3,5)+descPeriodoSelez.substring(0,2);
          else  
          if(comboFunzSelez!=null && comboFunzSelez.equals(StaticContext.INFR_BATCH_NOTE_CRED_XDSL))
            datiBatch = (homeDatiCli.findCodElabBatch(comboFunzSelez, descPeriodoSelez.substring(13), sys)).getCodElabBatch(); 

						
        }//B4
      }//B1
      
      String messaggio;
      if(sys!=null && sys.equalsIgnoreCase("S")&&(flagTipoContr!=null && flagTipoContr.equals("1")))
      {
       
          if(dataSched.equals("") || dataSched == null){
            messaggio= codiceBatch+"$"+codUtente+"$"+datiBatch+"$"+strFlagRepricing+"$";
          }else{
            messaggio= "$"+dataSched+"$"+cod_tipo_contr+"$"+codiceBatch+"$"+codUtente+"$"+datiBatch+"$"+strFlagRepricing+"$";
          }
        
      }
      else{
        messaggio= codiceBatch+"$"+codUtente+"$"+datiBatch+"$";
      }

      messaggio=messaggio+appoggio;

      System.out.println("messaggio "+messaggio);
      %>
      <logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
          <%=StaticMessages.getMessage(3501,messaggio)%>
      </logtag:logData>
      <%
      LancioBatch oggLancioBatch= new LancioBatch();
      int p=oggLancioBatch.Esecuzione(messaggio);//originale
      //int p=0;

      /*
      if(p==0)
        act="batchOK";
      else    
        act="batchNO";
      blnExit = "true";
      */

      if(p==0){
        act="batchOK";
      }else if(p==1){  
        act="schedOK";
      }else{
        act="batchNO";
      }
      blnExit = "true";
      %>
      <Script language='JavaScript'>
      document.frmDati.act.value="<%=act%>";
      document.frmDati.blnExit.value="<%=blnExit%>";
      </Script>

      <%
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
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;

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
    else if (act!=null && act.equals("schedOK"))
        strResult="Schedulazione batch avviata correttamente!";     

    String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
    strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
    response.sendRedirect(strUrl);
  }
  else 
  {%>
    goNextStep();
<%}%>
}
</SCRIPT>

</HEAD>

<BODY onload="setInitialValue();">

<form name="frmDati" action="LancioBatchSp.jsp" method="post">
<input type="hidden" name=cod_tipo_contr   id=cod_tipo_contr    value=<%=cod_tipo_contr%>>
<input type="hidden" name=des_tipo_contr   id=des_tipo_contr    value="<%=des_tipo_contr%>">
<input type="hidden" name=sys              id=sys               value=<%=sys%>>
<input type="hidden" name=comboFunzSelez   id= comboFunzSelez   value="<%=comboFunzSelez%>">
<input type="hidden" name=PeriodoRifSelez  id= PeriodoRifSelez  value= "<%=PeriodoRifSelez%>">
<input type="hidden" name=descPeriodoSelez id= descPeriodoSelez value= "<%=descPeriodoSelez%>">
<input type="hidden" name=flagTipoContr    id=flagTipoContr     value="<%=flagTipoContr%>">
<input type="hidden" name=appoggio         id= appoggio         value= "<%=appoggio%>">
<input type="hidden" name=codiceBatch      id=codiceBatch       value= "<%=codiceBatch%>">
<input type="hidden" name=act              id= act              value= "<%=act%>">
<input type="hidden" name=blnExit          id=blnExit           value= "<%=blnExit%>">
<input type="hidden" name="hidStep"                             value="<%=intStepNow%>"> 
<input type="hidden" name="hidTypeLoad"                         value="">
<input type="hidden" name=lancioBatch      id= lancioBatch      value= <%=lancioBatch%>>
<input type="hidden" name=dataSched       id=dataSched        value= "<%=dataSched%>">
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
