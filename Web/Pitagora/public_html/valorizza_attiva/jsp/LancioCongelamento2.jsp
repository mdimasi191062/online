<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioCongelamento2.jsp")%>
</logtag:logData>
<sec:ChkUserAuth/>

<EJB:useHome id="homeLstAccElab"   type="com.ejbSTL.AccountElabSTLHome" location="AccountElabSTL" />
<EJB:useBean id="remoteLstAccElab" type="com.ejbSTL.AccountElabSTL" value="<%=homeLstAccElab.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeLstAccElab2"  type="com.ejbBMP.CsvBMPHome" location="CsvBMP" />
<EJB:useHome id="homeLstAccElab3"  type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />
<EJB:useHome id="homeLstAccElab4"  type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />


<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");


String tipoBatch = request.getParameter("tipoBatch");
if(tipoBatch == null)
  tipoBatch = (String)session.getAttribute("tipoBatch");
session.setAttribute("tipoBatch",tipoBatch);

String strCodeTipoContr[] = request.getParameterValues("comboAccorpati");
if(strCodeTipoContr == null)
  strCodeTipoContr = (String[])session.getAttribute("strCodeTipoContr");

session.setAttribute("strCodeTipoContr",strCodeTipoContr);

String urlComTc= Misc.nh((String)session.getAttribute("URL_COM_TC"));


String appomsg=request.getParameter("appomsg");
String errore=request.getParameter("errore");
String erroreSel=request.getParameter("erroreSel");

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
  intAction = 0;
else
  intAction =Integer.parseInt(Misc.nh(request.getParameter("intAction")));

if(Misc.nh(request.getParameter("intFunzionalita")).equals(""))
  intFunzionalita = 0;
else
  intFunzionalita =Integer.parseInt(Misc.nh(request.getParameter("intFunzionalita")));

//Modifica 11/11/02 inizio
String strUrlDiPartenza = request.getContextPath() + "/common/jsp/GenericMsgSp.jsp";
	strUrlDiPartenza += "?CONTINUA=true";
//Modifica 11/11/02 fine
    
if(Misc.nh(request.getParameter("hidStep")).equals(""))
  intStepNow = 1;
else
  intStepNow =Integer.parseInt(Misc.nh(request.getParameter("hidStep")));


//CONTROLLO DEGLI STEPS
/*
if(! Misc.gestStepXLancio(request,intStepNow)){
  response.sendRedirect((String)session.getAttribute("URL_COM_TC"));
}
*/
int countCsv = 0;
int countCsvSenzaPs = 0;
visualizza="false";
          
switch (intStepNow){
    case 1: //controllo assenza csv

        for(int i=0;i<strCodeTipoContr.length && countCsv == 0; i++){
          
          
          Collection  accCong;
          accCong = remoteLstAccElab.getLstAccLanCongSpecial(strCodeTipoContr[i]);
//          accCong = remoteLstAccElab.getLstAccCongSpecial(strCodeTipoContr[i]);
          Object[] objs=accCong.toArray();
          for (int y=0;y<accCong.size() && countCsv==0;y++)
          {
            LstAccElabElem obj=(LstAccElabElem)objs[y];
            countCsv = (homeLstAccElab2.findCsvXDSL(obj.getCodeAccount(), obj.getDataIni())).getCsv();
            System.out.println("strCodeTipoContr["+strCodeTipoContr[i]+"] countCsv["+i+"] "+countCsv);
            
          }

        }

        if(countCsv == 0)
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

          for(int i=0;i<strCodeTipoContr.length && nrgElab == 0; i++){
            //countCsv = (homeLstAccElab2.findCsvXDSL(accountSelTutto[i], cicloIni)).getCsv();
            System.out.println("strCodeTipoContr["+strCodeTipoContr[i]+"] countCsv["+i+"] "+countCsv);   

            nrgElab = (homeLstAccElab4.findElabBatchCodeTipoContrUguali(strCodeTipoContr[i])).getElabUguali();
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
          }
          
    break;
		case 4:
      default:
            if(tipoBatch.equals("V"))
                codiceBatch = StaticContext.INFR_BATCH_CONG_VAL_ATT_XDSL;
            else  if(tipoBatch.equals("R"))
              codiceBatch = StaticContext.INFR_BATCH_CONG_REPR_ATT_XDSL;
            else
              codiceBatch = StaticContext.INFR_BATCH_CONG_FATT_MAN_XDSL;
            //String messaggio= codiceBatch+"$"+codUtente+"_"+"$"+account;
            messaggio= codiceBatch+"$"+codUtente+"$"+"_";
            codeParam="";
          
            for(int i=0;i<strCodeTipoContr.length; i++)
            {
              //determina elenco account per tipologia di contratto
              Collection  accCong;
              accCong = remoteLstAccElab.getLstAccLanCongSpecial(strCodeTipoContr[i]);
              Object[] objs=accCong.toArray();
              for (int y=0;y<accCong.size();y++)
              {
                LstAccElabElem obj=(LstAccElabElem)objs[y];
                codeParam = codeParam+"$"+obj.getCodeParam();
              }
            } 
            messaggio=messaggio+codeParam;

            System.out.println("messaggio "+messaggio);  
            LancioBatch oggLancioBatch= new LancioBatch();
            //Simulazione inizio 
            int p=oggLancioBatch.Esecuzione(messaggio);//originale    
           
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
                  System.out.println("congelamento strUrl ["+strUrl+"]");
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
         var stringa="../../valorizza_attiva/jsp/VisualAccountSp.jsp?controllo="+controllo+"&cod_contratto=1&code_elab=1&flagTipoContr=1";
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

<form name="frmDati" action="LancioCongelamento2.jsp" method="post">
<input type = "hidden" name = "hidTypeLoad" value="">
<input type = "hidden" name = "message" value="">
<input class="textB" type="hidden" name="typeLoad1" value="<%=typeLoad1%>">
<input type="hidden" name=blnExit id=blnExit  value= "<%=blnExit%>">
<input type = "hidden" name="hidStep" value="<%=intStepNow%>"> 
<input type="hidden" name="act" id="act"  value="<%=act%>">

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
	Lancio Congelamento Valorizzazione xDLS in Corso...<br>
	Attendere
	</h1>
	
</center>
</BODY>
</HTML>

