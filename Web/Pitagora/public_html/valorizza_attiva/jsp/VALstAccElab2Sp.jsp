<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VALstAccElab2Sp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />


   <EJB:useHome id="homeLstAccElab" type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
   <EJB:useBean id="remoteLstAccElab" type="com.ejbSTL.AccountElabSTL" value="<%=homeLstAccElab.create()%>" scope="session"></EJB:useBean>
   <EJB:useHome id="homeLstAccElab2" type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
   <EJB:useHome id="homeLstAccElab3" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />
   <EJB:useHome id="homeLstAccElab4" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />


<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_contratto=request.getParameter("codiceTipoContratto");
if (cod_contratto==null) cod_contratto=request.getParameter("cod_contratto");
if (cod_contratto==null) cod_contratto=(String)session.getAttribute("cod_contratto");

String des_contratto=request.getParameter("hidDescTipoContratto");
if (des_contratto==null) des_contratto=request.getParameter("des_contratto");
if (des_contratto==null) des_contratto=(String)session.getAttribute("des_contratto");

String urlComTc= Misc.nh((String)session.getAttribute("URL_COM_TC"));


String flagTipoContr = request.getParameter("flagTipoContr");  //060203
//System.out.println(">>>>>>>>>>>>>>>>flagTipoContr VALstAccElab2Sp :"+flagTipoContr);

String account=request.getParameter("account");
String descAccount=request.getParameter("descAccount");
String congela=request.getParameter("congela");
String congelaTutti=request.getParameter("congelaTutti");
String appomsg=request.getParameter("appomsg");
String errore=request.getParameter("errore");
String erroreSel=request.getParameter("erroreSel");
String nScartiSel=request.getParameter("nScartiSel");
String cicloFine=request.getParameter("cicloFine");
if(cicloFine==null) cicloFine="";
String cicloIni=request.getParameter("cicloIni");
if(cicloIni==null) cicloIni="";
String code_elab=request.getParameter("code_elab");
String code_stato=request.getParameter("code_stato");
String sizeLst=request.getParameter("sizeLst");

//*********
Collection  accElab;//=(Collection) session.getAttribute("accElab");

int typeLoad1=0;
int nrgPS = 0;
int nrgLst = 0;
int flagContratto = 0;
int nrgElab = 0;
String strtypeLoad1 = request.getParameter("typeLoad1");
String blnExit  = request.getParameter("blnExit");
String strResult = "";
String act      = request.getParameter("act");
String visualizza;
String visualizza2;
String codiceBatch;
String messaggio;
String codeParam;
//luca

  int size=0;
  int occ=0;
  if(congela!=null && congela.equals("true"))
    size=1;
  else  if (sizeLst!=null)
  {
    Integer tmpsize=new Integer(sizeLst);
    size=tmpsize.intValue();
  }
  int[] nLst= new int[size];
  int[] nPS=new int[size];
  int[] nrgCsv=new int[size];
  
  String[] accountSelTutto = new String[size];
  accElab = (Collection) session.getAttribute("accElab");
  Object[] objs=accElab.toArray();


if (strtypeLoad1!=null && !strtypeLoad1.equals(""))
  {
    Integer tmptypeLoad1=new Integer(strtypeLoad1);
    typeLoad1=tmptypeLoad1.intValue();
  }

clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
String codUtente=strUserName.getUserName();

//
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
//int intAction = Integer.parseInt(request.getParameter("intAction"));

if(Misc.nh(request.getParameter("intFunzionalita")).equals(""))
{
        intFunzionalita = 0;
}
else
{
        intFunzionalita =Integer.parseInt(Misc.nh(request.getParameter("intFunzionalita")));
}

//Modifica 11/11/02 inizio

String strUrlDiPartenza = request.getContextPath() + "/common/jsp/GenericMsgSp.jsp";
	strUrlDiPartenza += "?CONTINUA=true";
//Modifica 11/11/02 fine
    
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
   //Modifica 11/11/02 inizio
		//response.sendRedirect(strUrlDiPartenza);
    response.sendRedirect((String)session.getAttribute("URL_COM_TC"));
   //Modifica 11/11/02 fine
	}
//
//****************************************************************
//********************************************************************************

//MMM
if((congela!=null && congela.equals("true"))||(congelaTutti!=null && congelaTutti.equals("true")))
{
  //switch (intStepNow){
		//case 1:
  
  
          if(congelaTutti.equals("true") && size>1)
          {
          
               for (int i=0;i<accElab.size();i++)
               {
                    
                     LstAccElabElem obj=(LstAccElabElem)objs[i];
                     accountSelTutto[i] =obj.getCodeAccount();
                            
               } 
          }
          else
          {
          
               accountSelTutto[0] =account;
               
          } 
          visualizza="false";
          
  switch (intStepNow){
		case 1:
//          System.out.println("size "+size);

          for(int i=0;i<size;i++)
          {
//            System.out.println("INIZIO i "+i+" - account "+accountSelTutto[i]);
            /*if(cod_contratto.equals(StaticContext.ULL) || cod_contratto.equals(StaticContext.NP) || cod_contratto.equals(StaticContext.CPS)
              || cod_contratto.equals(StaticContext.COLOCATION)) 060203*/

            //System.out.println(">>>>>>>>>>>>>>>>1 flagTipoContr VALstAccElab2Sp :"+flagTipoContr);
            if(flagTipoContr!=null && flagTipoContr.equals("0"))
            {
                nrgCsv[i] = (homeLstAccElab2.findCsvSP(accountSelTutto[i], cicloIni)).getCsv();
            }
            else
            {
                /*if(cod_contratto.equals(StaticContext.CVP) || cod_contratto.equals(StaticContext.ADSL) || cod_contratto.equals(StaticContext.EASYIP)
                  || cod_contratto.equals(StaticContext.CPVSA)) 060203*/
                if(flagTipoContr!=null && flagTipoContr.equals("1"))                  
            {
                        nrgCsv[i] = (homeLstAccElab2.findCsvXDSL(accountSelTutto[i], cicloIni)).getCsv();
//                     System.out.println("StaticContext.CVP nrgCsv["+i+"] "+nrgCsv[i]);
            }
            }
            if(nrgCsv[i]==0)
            {
                   nPS[i] = (homeLstAccElab2.findAccountSenzaPS(code_elab, accountSelTutto[i])).getPs();
//                   System.out.println("StaticContext.CVP nPS["+i+"] "+nPS[i]);
            }
            else  
                  nPS[i] = -1;
//           System.out.println("FINE i= "+i); 
          }//for





           for(int i=0;i<size;i++)
           {
                   if (nPS[i]==0 && nrgCsv[i]==0)
                   {
                       visualizza="true";
                    }
           }
           if(visualizza.equals("true"))
           {
//size=1;
              if(congelaTutti.equals("true")&& size>1)
              {
                act="pop_up1";
                blnExit = "true";
               %> 
               <%
               }
               else 
               {
                  act="no_CSV";
                  blnExit = "true";
               %> 
                  <SCRIPT LANGUAGE='Javascript'>
                        document.frmDati.act.value="<%=act%>";
                        document.frmDati.blnExit.value="<%=blnExit%>";
                  </SCRIPT>
                <%
                }
            }
    break;
    case 2:
                    /* questo controllo non è piu implementato*/
%>

                  <SCRIPT LANGUAGE='Javascript'>
                        document.frmDati.act.value="pop_up2";
                        document.frmDati.blnExit.value="true";
                  </SCRIPT>
<%
         
    break;
		case 3:
          /*if(cod_contratto.equals(StaticContext.ULL) || cod_contratto.equals(StaticContext.NP) || cod_contratto.equals(StaticContext.CPS)
            || cod_contratto.equals(StaticContext.COLOCATION))060203*/
            //System.out.println(">>>>>>>>>>>>>>>>3 flagTipoContr VALstAccElab2Sp :"+flagTipoContr);
            if(flagTipoContr!=null && flagTipoContr.equals("0"))
                flagContratto=0;
          else
          /*if(cod_contratto.equals(StaticContext.CVP) || cod_contratto.equals(StaticContext.ADSL) || cod_contratto.equals(StaticContext.EASYIP)
            || cod_contratto.equals(StaticContext.CPVSA)) 060203*/
            if(flagTipoContr!=null && flagTipoContr.equals("1"))
                flagContratto=1;
           nrgElab = (homeLstAccElab4.findElabBatchCodeTipoContrUguali(cod_contratto)).getElabUguali();
           //nrgElab = (homeLstAccElab4.findElabBatchUguali(flagContratto)).getElabUguali();
           if (nrgElab!=0)
           { 
                  act="el_in_corso";
                  blnExit = "true";
               %> 
                  <SCRIPT LANGUAGE='Javascript'>
                        //message="Non è possibile effettuare il congelamento perchè per l'account selezionato non è stato generato il file Csv.";
                        //document.frmDati.message.value=message;
                        //GenericMsg(message);
                        document.frmDati.act.value="<%=act%>";
                        document.frmDati.blnExit.value="<%=blnExit%>";
                  </SCRIPT>
                <%
            }
    break;
		case 4:
      default:
          codiceBatch="";
          /*if(cod_contratto.equals(StaticContext.ULL) || cod_contratto.equals(StaticContext.NP) || cod_contratto.equals(StaticContext.CPS)
            || cod_contratto.equals(StaticContext.COLOCATION)) 060203*/
            //System.out.println(">>>>>>>>>>>>>>>>4 flagTipoContr VALstAccElab2Sp :"+flagTipoContr);
            if(flagTipoContr!=null && flagTipoContr.equals("0"))
                          codiceBatch = StaticContext.INFR_BATCH_CONG_VAL_ATTIVA_SP;
          else
            /*if(cod_contratto.equals(StaticContext.CVP) || cod_contratto.equals(StaticContext.ADSL) || cod_contratto.equals(StaticContext.EASYIP)
                || cod_contratto.equals(StaticContext.CPVSA))060203*/
            if(flagTipoContr!=null && flagTipoContr.equals("1"))
                          codiceBatch = StaticContext.INFR_BATCH_CONG_VAL_ATT_XDSL;



           //String messaggio= codiceBatch+"$"+codUtente+"_"+"$"+account;
           messaggio= codiceBatch+"$"+codUtente+"$"+"_";
           codeParam="";
          
           for(int i=0;i<size;i++)
           {
                  //DoppioListinoBMP PK  =  homeLstAccElab3.findCodeParam(accountSelTutto[i]);
                  //codeParam = codeParam+"$"+PK.getCodeParam();
                  codeParam = codeParam+"$"+(homeLstAccElab3.findCodeParam(accountSelTutto[i])).getCodeParam();
           } 
           messaggio=messaggio+codeParam;

//         System.out.println("messaggio "+messaggio);  
           LancioBatch oggLancioBatch= new LancioBatch();
           //Simulazione inizio 
           int p=oggLancioBatch.Esecuzione(messaggio);//originale    
//            int p=0;
           //Simulazione fine
           
           if(p==0)
              act="batchOK";
           else
              act="batchNO";
           blnExit = "true";
           %>
          <Script language='JavaScript'>
          document.frmDati.act.value="<%=act%>";
          document.frmDati.blnExit.value="<%=blnExit%>";
          </Script>
<%
    
    break;

  }//switch
}// if((congela!=null && congela.equals("true"))||(congelaTutti!=null && congelaTutti.equals("true"))) chiuso
//********************************************************************************
//MMM
%>

<HTML>
<HEAD>
  <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/misc.js"></SCRIPT>
  <SCRIPT LANGUAGE="JavaScript">

		
      function initialize()
      {
        
         objForm = document.frmDati;
          <%
          if(blnExit!=null && blnExit.equals("true"))
          {
              if (act!=null && act.equals("pop_up1")) 
              {
              %>
                        VisualizzaAccount("1");
               <%   
              }
              else if (act!=null && act.equals("pop_up2"))
              {
              %>
                        VisualizzaAccount("2");
               <%  
              }
              else if (act!=null && act.equals("no_CSV"))
              {
                  strResult="Non è possibile effettuare il congelamento perchè per l'account selezionato non è stato generato il file Csv."; 
              }
           
              else if (act!=null && act.equals("el_in_corso"))
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
              
              if ((act!=null) && !(act.equals("pop_up1"))&&!(act.equals("pop_up2")))   //mostra l'esito dell'elaborazione
              {
                  /*String strUrl = request.getContextPath() + "/common/jsp/GenericMsgSp.jsp?message=" + java.net.URLEncoder.encode(strResult);
                  strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza);
                  response.sendRedirect(strUrl);*/
                  String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
                  strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
                  response.sendRedirect(strUrl);
              }   
          }
          else 
          {
          %>
            
            goNextStep();
            
          <%
          }
          %>
}//initialize

      function VisualizzaAccount(contr)
      {
         var controllo = contr;
         //060203
         var stringa="../../valorizza_attiva/jsp/VisualAccountSp.jsp?controllo="+controllo+"&cod_contratto=<%=cod_contratto%>&code_elab=<%=code_elab%>&flagTipoContr=<%=flagTipoContr%>";
         openDialog(stringa, 700, 400, handleReturnedValueDett);
      }

      function handleReturnedValueDett()
      {
         document.frmDati.act.value="<%=act%>";
         document.frmDati.blnExit.value="<%=blnExit%>";
         document.location.replace("<%=urlComTc%>");
      }

      function GenericMsg(message)
      {
          document.frmDati.action="../../common/jsp/genericMsgSp.jsp";
          document.frmDati.submit();
      }
      function ONCONFERMA()
      {
          document.frmDati.submit();
      }

      function ONANNULLA()
      {
          //torna sulla pagina di scelta del tipo contratto
          objForm.action = "VALstAccElabSp.jsp";
          objForm.submit();
      }
      
    </SCRIPT>
</HEAD>
<BODY onload="initialize()">


<form name="frmDati" action="VALstAccElab2Sp.jsp" method="post">
<input type = "hidden" name = "hidTypeLoad" value="">
<input type = "hidden" name = "message" value="">
<input type = "hidden" name = "cod_contratto"  id="cod_contratto" value="<%=cod_contratto%>">
<input type = "hidden" name = "flagTipoContr"  id="flagTipoContr" value="<%=flagTipoContr%>"> <!--060203-->
<input class="textB" type="hidden" name="typeLoad1" value="<%=typeLoad1%>">
<input type="hidden" name=congela id=congela  value= "<%=congela%>">
<input type="hidden" name=congelaTutti id=congelaTutti  value= "<%=congelaTutti%>">
<input type="hidden" name=blnExit id=blnExit  value= "<%=blnExit%>">
<input type = "hidden" name = "hidStep" value="<%=intStepNow%>"> 

<input type="hidden" name="act" id="act"  value="<%=act%>">

<input type="hidden" name=account id=account value= "<%=account%>">
<input type="hidden" name=sizeLst id=sizeLst value= "<%=sizeLst%>">
<input type="hidden" name=code_elab id=code_elab value= "<%=code_elab%>">


</form>
<!-- Immagine Titolo -->
<table align="center" width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td align="left"><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  <tr>
</table>

<!--TITOLO PAGINA-->
<table width="80%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align = "center">
	<tr>
		<td>
		 <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
			<tr>
			  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Lancio Batch</td>
			  <td bgcolor="<%=StaticContext.bgColorCellaBianca %>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"></td>
			</tr>
		 </table>
		</td>
	</tr>
</table>
<center>
	<h1 class="textB">
	Verifica Valorizzazione Attiva in Corso...<br>
	Attendere
	</h1>
	
</center>
</BODY>
</HTML>

