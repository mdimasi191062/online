<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioBatchNCSp.jsp")%>
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
String codeFunzBatch                   = request.getParameter("codeFunzBatch");
if (codeFunzBatch!=null && codeFunzBatch.equals("null")) codeFunzBatch=null;
String codeFunzBatchNC                 = request.getParameter("codeFunzBatchNC");
if (codeFunzBatchNC!=null && codeFunzBatchNC.equals("null")) codeFunzBatchNC=null;
String codeFunzBatchRE                 = request.getParameter("codeFunzBatchRE");
if (codeFunzBatchRE!=null && codeFunzBatchRE.equals("null")) codeFunzBatchRE=null;
String flagTipoContr                   = request.getParameter("flagTipoContr");
if (flagTipoContr!=null && flagTipoContr.equals("null")) flagTipoContr=null;
String sys=request.getParameter("hidFlagSys");
if (sys==null) sys=request.getParameter("sys");
if (sys==null) sys=(String)session.getAttribute("sys");

String sizeLst=request.getParameter("sizeLst");
String lancioBatch           = request.getParameter("lancioBatch");
if (lancioBatch!=null && lancioBatch.equals("null")) lancioBatch=null;
String conf   = request.getParameter("conf");

String appomsg=request.getParameter("appomsg");
String appoData=request.getParameter("appoData");

// Vettore contenente risultati query per il caricamento della lista
Collection datiNoteCredito=null;
Collection datiRepricing=null;

String   AccountPerReprStr="";       //stringa contenete la scrematura (tutti se non apro la POPO-UP) dopo la chiamata alla prima POP_UP1
Vector   AccountPerReprVec = null;   //Vettore contenete la scrematura (tutti se non apro la POPO-UP) della POP_UP1
String   AccountPerLancioStr="";     //stringa contenete la scrematura (tutti se non apro la POPO-UP) dopo la chiamata alla prima POP_UP2
Vector   AccountPerLancioVec = null; //Vettore contenete la scrematura (tutti se non apro la POPO-UP) della POP_UP2

//SCHEDULAZIONE
String dataSched = request.getParameter("dataSched");
if(dataSched == null)
  dataSched = "";

System.out.println("DATASCHED ["+dataSched+"]");


int nrgElab = 0;
int flagContratto = 0;
String act       = request.getParameter("act");
String blnExit   = request.getParameter("blnExit");
String strResult = "";
String urlComTc= Misc.nh((String)session.getAttribute("URL_COM_TC"));
boolean lanciato=false;
int lancioOK=0;
String messaggio = request.getParameter("messaggio");
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

if (codeFunzBatch==null) codeFunzBatch="";

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

//CASO 0  Ci sono elaborazioni Batch in corso e non si lancia
//CASO 1  non apro POP-UP ValAtt, non apro POP-UP Repr, Lancio su tutto
//CASO 2  non apro POP-UP ValAtt, apro POP-UP Repr senza scremare, Lancio su tutto
//CASO 3  non apro POP-UP ValAtt, apro POP-UP Repr scremo, scrematura non vuota, Lancio scrematura
//CASO 4  non apro POP-UP ValAtt, apro POP-UP Repr scremo, scrematura vuota, non Lancio
//CASO 5  apro POP-UP ValAtt scremo, scrematura vuota, non Lancio
//CASO 6  apro POP-UP ValAtt scremo, scrematura non vuota, non apro POP-UP Repr, Lancio scrematura
//CASO 7  apro POP-UP ValAtt non scremo, non apro POP-UP Repr, Lancio su tutto
//CASO 8  apro POP-UP ValAtt scremo, scrematura non vuota, apro POP-UP Repr scremo, scrematura vuota, non Lancio
//CASO 9  apro POP-UP ValAtt scremo, scrematura non vuota, apro POP-UP Repr scremo, scrematura non vuota, Lancio scrematura
//CASO 10 apro POP-UP ValAtt scremo, scrematura non vuota, apro POP-UP Repr non scremo, Lancio prima scrematura
  
%>

<EJB:useHome id="homecmbAcc"      type="com.ejbBMP.DatiCliBMPHome"       location="DatiCliBMP" />
<EJB:useHome id="homeLstAccElab4" type="com.ejbBMP.ElaborBatchBMPHome"   location="ElaborBatchBMP" />
<EJB:useHome id="homeLstAccElab3" type="com.ejbBMP.DoppioListinoBMPHome" location="DoppioListinoBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lancio Batch Note di Credito </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/misc.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/LancioNCSp.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

function handleReturnedValueVA() //ritorno da POP_UP
{
    if (document.frmDati.conf.value=="false")
    {
      document.location.replace("<%=urlComTc%>");
    }  
    else
    {
       document.frmDati.blnExit.value="false";
       goNextStep();
    }
}
 
function VisualizzaAccount(POP_UP)
{
    document.frmDati.blnExit.value="STOP";
    conf = document.frmDati.conf.value;
    var stringa='../../nota_credito/jsp/LancioAccountSp.jsp?conf='+conf+'&chiamante=LBNCSP'+'&POP_UP='+POP_UP;
    openDialog(stringa, 580, 380, handleReturnedValueVA);
}

function setInitialValue()
{
<%
    clsInfoUser strUserName=(clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER);
    String codUtente=strUserName.getUserName();
    int size=0;
    int occ=0;
    int occ1=0;
    if (sizeLst!=null)
     {
              Integer tmpsize=new Integer(sizeLst);
              size=tmpsize.intValue();
     }
     String[] accountSelTutto     = new String[size];
     String appoggio = appomsg;
     String dataConvert=appoData.substring(6,10)+appoData.substring(3,5)+appoData.substring(0,2);
     for(int i=0;i<size;i++)
      {
        occ=appoggio.indexOf("$");
        if(occ!=-1)
        {
          accountSelTutto[i] = appoggio.substring(0,occ);
          appoggio= appoggio.substring(occ+1);
          }
          else 
          {
             accountSelTutto[i] = appoggio;
           }
         }
 
 if (lancioBatch==null) lancioBatch="true";
 //if (lancioBatch!=null && lancioBatch.equals("true") && !lanciato) 
 if (!lanciato) 
 {
 if (intStepNow<7)  
 {
    switch (intStepNow)
    {
    case 1:   
      //System.out.println(">>>>>>>>> CASE 1 - Batch in corso");
      nrgElab = (homeLstAccElab4.findElabBatchUguali(Integer.parseInt(flagTipoContr))).getElabUguali();
      if (nrgElab!=0)  //CASO 0
      {
            act="no_batch";
            blnExit = "true";%>
            document.frmDati.act.value="<%=act%>";
            document.frmDati.blnExit.value="<%=blnExit%>"
    <%}
    break;
    
    case 2:
          datiNoteCredito = homecmbAcc.findAccountNoCong(codeFunzBatch, cod_tipo_contr);
    break;

    case 3:
          //System.out.println(">>>>>>>>> CASE 3 - POP_UP 1");
          if(conf!=null && conf.equals("true"))  //torno dalla POP-UP1 confermando
          {
             datiNoteCredito = (Collection) session.getAttribute("dati");
             Object[] objs5=datiNoteCredito.toArray();
             int indice=-1;
             AccountPerReprStr="";
             for (int j=0;j<size;j++) //for 1
             {
                boolean trovato= false;
                for (int i=0; i<datiNoteCredito.size()  ;i++)  //for 2
                {
                  DatiCliBMP obj5=(DatiCliBMP)objs5[i];
                  if(accountSelTutto[j].equals(obj5.getAccount()))
                  {
                     //System.out.println(">>>>>>>>> elimino l'account della POP_UP 1 "+obj5.getAccount());
                     trovato=true;
                     break;
                   } 
                }//for 2 
                if(!trovato)
                {
                   indice++; 
                   AccountPerReprStr=AccountPerReprStr+accountSelTutto[j]+"*";
                }  
             }//for 1

             if (indice==-1) //niente da lanciare al ritorno dalla POP_UP1
             {
                act="accountNO";
                blnExit = "true";%>
                document.frmDati.act.value="<%=act%>";
                document.frmDati.blnExit.value="<%=blnExit%>"
           <%}
             else //lancio
             {   
                act="verRepricing";
                session.setAttribute("AccountPerReprStr",AccountPerReprStr);
                %>
          <%}//else
          }//if su conf
          else if(conf!=null && conf.equals("false")) //ho selezionato annulla sulla POP-UP1
          {
              //System.out.println(">>>>>>>>> ho selezionato annulla dalla pop_UP 1 ESCO");
              act="accountNO";
              blnExit = "true";%>
              document.frmDati.act.value="<%=act%>";
              document.frmDati.blnExit.value="<%=blnExit%>"
              document.frmDati.conf.value="false";
         <%}
          else  //non ho lanciato la POP_UP1
          {
            //System.out.println(">>>>>>>>> non ho aperto la POP_UP1 faccio il test repricing su tutto");
            act="verRepricing";
            AccountPerReprStr="";
            for (int i=0; i<accountSelTutto.length;i++)  //for 2 --scarico tutti gli account in AccountPerRepr
                AccountPerReprStr=AccountPerReprStr+accountSelTutto[i]+"*";
            session.setAttribute("AccountPerReprStr",AccountPerReprStr);
            %>
           <%}
           //System.out.println(">>>>>>>>> Fine passo 3 AccountPerReprStr "+AccountPerReprStr);
      break;

      case 4:
            //System.out.println(">>>>>>>>> CASE 4");
            if (flagTipoContr.equalsIgnoreCase("0")) //famiglia di ULL
              datiRepricing= homecmbAcc.findAllAccRepricing("LancioBatchNCSp",codeFunzBatchRE,cod_tipo_contr);
            else  //famiglia di xDSL flagTipoContr=1
              datiRepricing=null;
              //datiRepricing=null; //simulazione
      break;            
            
      case 5:             
            //System.out.println(">>>>>>>>> CASE 5 - POP_UP2");      
            AccountPerReprStr=(String)session.getAttribute("AccountPerReprStr");

           //System.out.println(">>>>>>>>>>>>> conf "+conf);
           if(conf!=null && conf.equals("true"))  //torno dalla POP-UP2 confermando
           {
             //costruisce un Vector di account in input AccountPerReprStr ,una stringa nel formato account1*sccount2*account3* ecc...
             AccountPerReprVec=Misc.split(AccountPerReprStr,"*");
             datiRepricing = (Collection) session.getAttribute("dati");
             Object[] objs5=datiRepricing.toArray();
             int indice=-1;
             AccountPerLancioStr="";
             String accountTest="";
             for (int j=0;j<AccountPerReprVec.size()-1;j++) //for 1
             {
                boolean trovato= false;
                for (int i=0; i<datiRepricing.size()  ;i++)  //for 2
                {
                  DatiCliBMP obj5=(DatiCliBMP)objs5[i];
                  accountTest = (String)AccountPerReprVec.get(j);
                  if(accountTest.equals(obj5.getAccount()))
                  {
                     //System.out.println(">>>>>>>>> elimino l'account della POP_UP2 "+obj5.getAccount());
                     trovato=true;
                     break;
                   } 
                }//for 2 
                if(!trovato)
                {
                   indice++; 
                   AccountPerLancioStr=AccountPerLancioStr+accountTest+"*";
                }  
             }//for 1

             if (indice==-1) //niente da lanciare al ritorno dalla POP_UP2
             {
                act="accountNO";
                blnExit = "true";%>
                document.frmDati.act.value="<%=act%>";
                document.frmDati.blnExit.value="<%=blnExit%>"
           <%}
             else //lancio
             {   
                act="lancio";
                //System.out.println(">>>>>>>>> AccountPerLancioStr risultante "+AccountPerLancioStr);
                session.setAttribute("AccountPerLancioStr",AccountPerLancioStr);
                %>
          <%}//else
          }//if su conf
          else if(conf!=null && conf.equals("false")) //ho selezionato annulla sulla POP-UP
          {
              //System.out.println("ho selezionato annulla dalla pop_UP 2 ");
              act="accountNO";
              blnExit = "true";%>
              document.frmDati.act.value="<%=act%>";
              document.frmDati.blnExit.value="<%=blnExit%>"
              document.frmDati.conf.value="false";
         <%}
          else  //non ho lanciato la POP_UP2
          {
            //System.out.println(">>>>>>>>> non ho aperto la pop_UP2 lancio su tutto della POP_UP1");
            act="lancio";
            AccountPerLancioStr=AccountPerReprStr;
            session.setAttribute("AccountPerLancioStr",AccountPerLancioStr);
          }
      break;

      case 6: //era 4 250603
          default:
           //System.out.println(">>>>>>>>> default");
           AccountPerLancioStr=(String)session.getAttribute("AccountPerLancioStr");   
           //System.out.println(">>>>>>>>> default AccountPerLancioStr "+AccountPerLancioStr);

           messaggio= codeFunzBatchNC+"$"+codUtente+"$"+"_";
           String codeParam="";
           String nota=""; 
           AccountPerLancioVec=Misc.split(AccountPerLancioStr,"*");

           for (int j=0;j<AccountPerLancioVec.size()-1;j++)
           {
                  String accountCandidato = (String)AccountPerLancioVec.get(j);
                  int elabBatch= homeLstAccElab4.findElabBatchEsistNC(codeFunzBatchNC,accountCandidato).getElabBatch();
                  if(elabBatch==0)
                  {
                     nota="I";
                     codeParam = accountCandidato;
                     if (codeParam==null || codeParam.equals("null")) 
                     {
                        lancioOK=-1;
                        j=size;
                     }
                  }  
                  else  
                  {
                     nota="U";
                     codeParam = (homeLstAccElab3.findCodeParamNC(accountCandidato,codeFunzBatchNC)).getCodeParam();
                     if (codeParam==null || codeParam.equals("null")) 
                     {
                        lancioOK=-1;
                        j=size;
                     }
                  }
                  if (lancioOK!=-1)
                      messaggio=messaggio+"$"+nota+codeParam+"#"+dataConvert;
           }//for

           //SCHEDULAZIONE
           if(dataSched != null && !dataSched.equals(""))
           {
              //INSERISCO LA SCHEDULAZIONE
              messaggio = "$"+dataSched+"$"+messaggio;
              System.out.println("MESSAGGIO ["+messaggio+"]");
              LancioBatch oggLancioBatch= new LancioBatch();
              //System.out.println("messaggio "+messaggio);
              int p=oggLancioBatch.Esecuzione(messaggio);
              //int p=0; //forzatura
              if(p==0)
                act="batchOK";
              else if(p==1)
                act="schedOk";
              else
                act="batchNO";
                blnExit = "true";
                %>
                document.frmDati.act.value="<%=act%>";
                document.frmDati.blnExit.value="<%=blnExit%>";
                <%
           }else{
              if(messaggio.equals(codeFunzBatchNC+"$"+codUtente+"$"+"_"))
              {
                act="batchNO";
                blnExit = "true";
                %>
                document.frmDati.act.value="<%=act%>";
                document.frmDati.blnExit.value="<%=blnExit%>";
                <%
              }
              else
              {
                LancioBatch oggLancioBatch= new LancioBatch();
                //System.out.println("messaggio "+messaggio);
                int p=oggLancioBatch.Esecuzione(messaggio);
                //int p=0; //forzatura
                if(p==0)
                  act="batchOK";
                else
                 act="batchNO";
                blnExit = "true";
                %>
                document.frmDati.act.value="<%=act%>";
                document.frmDati.blnExit.value="<%=blnExit%>";
                <%
              }
            }
    break;

  }//switch   
}%>
       //document.frmDati.conf.value = "false";
<%
 if(lancioBatch!=null && lancioBatch.equals("true"))
   lancioBatch="false";
 if(lancioBatch==null)
   lancioBatch="true";
 if(conf!=null && conf.equals("true"))
   conf=null; 
}

	if(blnExit!=null && blnExit.equals("true"))
  {
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
      else if (act!=null && act.equals("schedOk"))
     {
        strResult="Schedulazione batch avviata correttamente."; 
     }
     else if (act!=null && act.equals("accountNO"))
     {
        strResult="Non ci sono account elaborabili."; 
     }
    
          String strUrl = strUrlDiPartenza+"&message=" + java.net.URLEncoder.encode(strResult,com.utl.StaticContext.ENCCharset);
          strUrl += "&URL=" + java.net.URLEncoder.encode(strUrlDiPartenza,com.utl.StaticContext.ENCCharset);
          response.sendRedirect(strUrl);
  }
  else if(blnExit==null  || blnExit.equals("null") || blnExit.equals("false"))
  {
%>
        <%
        if (act!=null && act.equals("lancio"))
        {%>
        					goNextStep();
        <%} 
        else if ((act!=null && act.equals("verRepricing")) && datiRepricing==null)
        {%>
        					goNextStep();
        <%} 
        else if ((datiRepricing!=null)&&(datiRepricing.size()!=0))
            {
             session.setAttribute("dati", datiRepricing);%> 
             VisualizzaAccount("POP_UP2");
				  <%}
        else if ((datiNoteCredito!=null)&&(datiNoteCredito.size()!=0))
            {
             session.setAttribute("dati", datiNoteCredito);%> 
             VisualizzaAccount("POP_UP1");
				  <%}
        else
        {%>
   	 	 		 goNextStep();
	     <%}
 }%>
}//function
</SCRIPT>

</HEAD>

<BODY onload="setInitialValue();">

<form name="frmDati" action="LancioBatchNCSp.jsp" method="post">
<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value="<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr    id=des_tipo_contr     value="<%=des_tipo_contr%>">
<input type="hidden" name=conf id=conf    value=<%=conf%>>
<input type="hidden" name=chiamante id=chiamante  value="LBNCSP"> 
<input type="hidden" name=sizeLst id=sizeLst value="<%=sizeLst%>">
<input type="hidden" name=appomsg    id=appomsg value="<%=appomsg%>">
<input type="hidden" name=appoData    id=appoData value="<%=appoData%>">
<input type="hidden" name=act id= act value="<%=act%>" >
<input type="hidden" name=blnExit id=blnExit  value="<%=blnExit%>">
<input type="hidden" name=lancioBatch id= lancioBatch  value="<%=lancioBatch%>">
<input type = "hidden" name = "hidStep" value="<%=intStepNow%>"> 
<input type = "hidden" name = "hidTypeLoad" value="">
<input type = "hidden" name = "messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
<input type="hidden" name=codeFunzBatchNC         id=codeFunzBatchNC          value="<%=codeFunzBatchNC%>">
<input type="hidden" name=codeFunzBatchRE         id=codeFunzBatchRE          value="<%=codeFunzBatchRE%>">
<input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">
<input type="hidden" name=dataSched               id=dataSched                value="<%=dataSched%>">

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
