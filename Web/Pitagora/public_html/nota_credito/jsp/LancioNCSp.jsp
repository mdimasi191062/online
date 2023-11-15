<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<!-- importazione della tagLib per l'instanziazione dell'oggetto remoto -->

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioNCSp.jsp")%>
</logtag:logData>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String data_ini_mmdd =  Utility.getDateMMDDYYYY();  
String max_data_fine_periodo="";
String dataSystem=Utility.getDateDDMMYYYY();
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

String dataFinePerFattSel=null;
String appomsg=request.getParameter("appomsg");
String appoData=request.getParameter("appoData");
// Vettore contenente risultati query per il caricamento della lista
Collection datiCli=null;   
Collection datiCli1=null;
Collection dati=null;
DatiCliBMP remotecmbAcc=null;
String Desc_Account = null;
String codeElab=null;
String sSELECTED = null;   
int nrgElab = 0;
int flagContratto = 0;
String codiceBatch=""; 
BatchElem  datiBatch=null;
//RESET VARIABILE DEGLI STEPS X IL LANCIO BATCH
session.setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));

%>
<EJB:useHome id="homecmbAcc" type="com.ejbBMP.DatiCliBMPHome" location="DatiCliBMP" />
<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>
<%
 datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"VA",null,"S");
 if(datiBatch!=null)
   codeFunzBatch = datiBatch.getCodeFunz();
 datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"VN",null,"S");
  if(datiBatch!=null)
  {
      codeFunzBatchNC=  datiBatch.getCodeFunz();
      flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString();
      //19-01-2004 remotecmbAcc=homecmbAcc.findMaxDataFine(codeFunzBatchNC);      //03-04-03
      //System.out.println("chiamo findMaxDataFine con "+ codeFunzBatchNC+" "+cod_tipo_contr);
      remotecmbAcc=homecmbAcc.findMaxDataFine(codeFunzBatchNC,cod_tipo_contr); 
      max_data_fine_periodo=remotecmbAcc.getMaxDataFine(); //03-04-03
  }
   datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"VR",null,"S");
   if (datiBatch!=null)
       codeFunzBatchRE=  datiBatch.getCodeFunz();  

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Lancio Nota di Credito
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/LancioNCSp.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<!-- NUOVO CALENDARIO -->
<script language="JavaScript" src="../../common/js/calendar1.js"></script>
<!-- NUOVO CALENDARIO -->
<SCRIPT LANGUAGE="JavaScript">
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;
var attivaCalendario=true;
var attivaCalendarioSched=true;
var message1="Click per selezionare la data";
var message2="Click per cancellare la data selezionata";
var max_data_fineConv;
var codeFunzBatch   = "<%=codeFunzBatch%>";
var codeFunzBatchNC = "<%=codeFunzBatchNC%>";
var codeFunzBatchRE = "<%=codeFunzBatchRE%>";
var flagTipoContr   = "<%=flagTipoContr%>";
var messaggio;


//---------------------- ANTONIO 23-06-2004
var dateComboAccount = new Array();
var dateComboRiepilogoAccount = new Array();

/**
 *Funzione che elimina un elemento da un array
 *o in base all'indice o in base all'elemento
 *e alla fine restituisce la nuova lista
 */
function togliElemento(laMiaLista, theIndex) {
	var k;
	var newList = new Array();
	for( k=0 ; k < laMiaLista.length ; k++) {
		if (theIndex != k) {
			newList.push(laMiaLista[k]);
		} 
	}
	return newList;
}
//---------------------- ANTONIO 23-06-2004

//----------------------------------------------------------------------------------------------------------------------
function verificaInsSelez(insTutti) {

      if (document.lancioNCForm.dataFineA.value=="null" || document.lancioNCForm.dataFineA.value=="") {
          messaggio="il campo \'DATA FINE PERIODO\' è obbligatorio!";
          return false;
      } else {
      	dataFineAConv     = convertiData(document.lancioNCForm.dataFineA.value);

//      	L'istruzione successiva è un bypass al controllo sulla max_data_fine_periodo.
//      	In futuro va implementato meglio, cioè va eseguito il controllo sulla max_data_fine_periodo del contratto
//      	selezionato.
//      	//document.lancioNCForm.max_data_fine_periodo.value = "null";
//	      /*ANTONIO 24-06-2004 cambiato tipo di controllo
//      	if(document.lancioNCForm.max_data_fine_periodo.value!="null") {
//                max_data_fineConv     = convertiData(document.lancioNCForm.max_data_fine_periodo.value);
//                if ( max_data_fineConv >= dataFineAConv)   //03-04-03
//                {
//                    messaggio="la data fine periodo deve essere maggiore di quella impostata nell'ultima Nota di Credito e cioè "+document.lancioNCForm.max_data_fine_periodo.value;
//                    return false;
//                 }  
//       	}

       	
       	//--------------ANTONIO 23-06-2004
        //Ciclo per tutti gli account selezionati e per ognuno di questi se la data impostata è superiore presente
        //nell'array dateComboRiepilogoAccount caso in cui non possono essere lanciati i batch.
          
        //Scorro tutti quelli di riepilogo
        //messaggio = "";
        arrMessages = new Array();
        for (i=0;document.lancioNCForm.comboRiepilogoAccount.length>i;i++) {
          	
          	max_data_fineConv     = convertiData(dateComboRiepilogoAccount[i]);
          	
          	if ( max_data_fineConv >= dataFineAConv)   
          	{
                    messaggioAppo = "Per " + document.lancioNCForm.comboRiepilogoAccount.options[i].text
                                    + " la data fine periodo non deve essere superiore al " 
                                    + dateComboRiepilogoAccount[i];

                    arrMessages.push(messaggioAppo);                
                    
                 }
         }
         //Se l'array viene riempito il controllo non viene 
         //passato.
         if (arrMessages.length != 0){
            if (arrMessages.length == 1) {
                     messaggio = arrMessages[0];
            } else {
                      messaggio = "Esiste almeno un account per cui la data fine periodo"
                      + " è superiore a quella dell'ultima Nota di Credito lanciata : \r\n"
                      + "   - " +  arrMessages[0]; 
            }
            return false;
         }
         
         //--------------ANTONIO 23-06-2004
          
       	if(document.lancioNCForm.max_data_fine_periodo.value=="null" || dataFineAConv > max_data_fineConv) {
            dataSistemaConv   = "<%=dataSystem%>".substring(6,10) + "<%=dataSystem%>".substring(3,5)+ "<%=dataSystem%>".substring(0,2);
            if (dataSistemaConv >= dataFineAConv) {
                return true;
            } else {
                 messaggio="la data fine periodo deve essere minore o uguale alla data di sistema";
                 return false;
            }
         }    
      }
}
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
function ONLANCIOBATCH() 
{
  if (verificaInsSelez(false)) 
  {
    document.lancioNCForm.appomsg.value=document.lancioNCForm.comboRiepilogoAccount.options[0].value;
    document.lancioNCForm.appoData.value=document.lancioNCForm.dataFineA.value.substring(0,10);
    for (i=1; document.lancioNCForm.comboRiepilogoAccount.length>i; i++) {
      document.lancioNCForm.appomsg.value=document.lancioNCForm.appomsg.value+"$"+document.lancioNCForm.comboRiepilogoAccount.options[i].value;
    }
    document.lancioNCForm.sizeLst.value = document.lancioNCForm.comboRiepilogoAccount.length;
            
    //new
    document.lancioNCForm.action = "LancioBatchNCSp.jsp";
    EnableAllControls(document.lancioNCForm);

    if(document.lancioNCForm.schedulazione.checked)
    {
      if(document.lancioNCForm.dataSched.value == "" || document.lancioNCForm.dataSched.value == undefined){
        alert('Inserire la Data/Ora Schedulazione');
      }else{
        document.lancioNCForm.submit();
      }
    }else
    {
      document.lancioNCForm.submit();
    }
				
    //new
    //document.lancioNCForm.submit();
            
  } 
  else 
  {
    window.alert(messaggio);
  }
}
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
function ONINSERISCI_SEL() {
	
    document.lancioNCForm.comboRiepilogoAccount.focus();
  
    if (document.lancioNCForm.comboAccount.selectedIndex>-1) {
          testo=document.lancioNCForm.comboAccount.options[document.lancioNCForm.comboAccount.selectedIndex].text;
          valore=document.lancioNCForm.comboAccount.options[document.lancioNCForm.comboAccount.selectedIndex].value;
          
          dataFinePerFatt=document.lancioNCForm.dataFineA.value;
          testoCompl=testo;
          seloption=new Option(testoCompl, valore);
          document.lancioNCForm.comboRiepilogoAccount.options[document.lancioNCForm.comboRiepilogoAccount.length] = seloption;
          
          //----------------ANTONIO 23-06-2004
          //Aggiungo anche da max data fine nell'array
          mioIndice = parseInt(document.lancioNCForm.comboAccount.selectedIndex, 10);
          //aler(mioIndice);
          dateComboRiepilogoAccount.push(dateComboAccount[mioIndice]);
          dateComboAccount = togliElemento(dateComboAccount, mioIndice);
          //----------------ANTONIO 23-06-2004
          
          document.lancioNCForm.comboAccount.options[document.lancioNCForm.comboAccount.selectedIndex] = null;	
          DisabilitaBotton();
          document.lancioNCForm.dataFineA.value="";
          if (document.lancioNCForm.comboRiepilogoAccount.length==0) {
             if (attivaCalendario)
                dis_calendario()
          } else {
              document.lancioNCForm.comboRiepilogoAccount[0].selected ="true";
              if (!attivaCalendario)
                 abi_calendario(); 
          }   
    } else
      window.alert("Attenzione! Selezionare prima un account da Dati Cliente.");
}
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
function ONINSERISCI_TUTTI() {
	document.lancioNCForm.comboRiepilogoAccount.focus();
	
        for (i=0;document.lancioNCForm.comboAccount.length>i;i++) {
                  //----------------
                  //Aggiungo anche da max data fine nell array
                  dateComboRiepilogoAccount.push(dateComboAccount[i]);
                  //----------------
                  
                  testo=document.lancioNCForm.comboAccount.options[i].text;
                  valore=document.lancioNCForm.comboAccount.options[i].value;
                  dataFinePerFatt=document.lancioNCForm.dataFineA.value;
                  testoCompl=testo;
                  seloption=new Option(testoCompl, valore);
                  document.lancioNCForm.comboRiepilogoAccount.options[document.lancioNCForm.comboRiepilogoAccount.length] = seloption;
         }
         
         for (i=document.lancioNCForm.comboAccount.length;i>=0;i--)  {
              document.lancioNCForm.comboAccount.options[i] = null;
              dateComboAccount = togliElemento(dateComboAccount, i);
         }
        
         DisabilitaBotton();
         document.lancioNCForm.dataFineA.value="";
         if (document.lancioNCForm.comboRiepilogoAccount.length!=0) {
                  document.lancioNCForm.comboRiepilogoAccount[0].selected ="true";
                  if (!attivaCalendario)
                    abi_calendario(); 
         }
}
//----------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------
function DisabilitaBotton() {
  
    if(document.lancioNCForm.comboRiepilogoAccount.length!=0) 
    {
	    Enable(document.lancioNCForm.LANCIOBATCH);
	    Enable(document.lancioNCForm.ELIMINA);
      Enable(document.lancioNCForm.schedulazione);
      if(!attivaCalendario) abi_calendario();
      if(document.lancioNCForm.comboRiepilogoAccount.length==0)
      {
        if(attivaCalendarioSched) f_calendarioSched(document.lancioNCForm.schedulazione);
      }
    } 
    else 
    {
	    Disable(document.lancioNCForm.LANCIOBATCH);
	    Disable(document.lancioNCForm.ELIMINA);
      Disable(document.lancioNCForm.schedulazione);

	    if (attivaCalendario)	dis_calendario();
   	  document.lancioNCForm.dataFineA.value="";

      //SCHEDULAZIONE
      document.lancioNCForm.schedulazione.checked=false;
      document.lancioNCForm.schedulazione.value="N";
      document.lancioNCForm.dataSched.value="";
      if (attivaCalendarioSched)	f_calendarioSched(document.lancioNCForm.schedulazione);
      //SCHEDULAZIONE
    }
    
    if(document.lancioNCForm.comboAccount.length==0) {
	    Disable(document.lancioNCForm.INSERISCI_SEL);
	    Disable(document.lancioNCForm.INSERISCI_TUTTI);
    } else {
	    Enable(document.lancioNCForm.INSERISCI_SEL);
	    Enable(document.lancioNCForm.INSERISCI_TUTTI);
    }
    Disable(document.lancioNCForm.dataFineA);
}
//----------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------
function ONELIMINA(){
    
    document.lancioNCForm.comboAccount.focus();
    if (document.lancioNCForm.comboRiepilogoAccount.selectedIndex>-1) {
    
        testo=document.lancioNCForm.comboRiepilogoAccount.options[document.lancioNCForm.comboRiepilogoAccount.selectedIndex].text;
        valore=document.lancioNCForm.comboRiepilogoAccount.options[document.lancioNCForm.comboRiepilogoAccount.selectedIndex].value;
        
        // ----------------- ANTONIO  23-06-2004
        mioIndice = parseInt(document.lancioNCForm.comboRiepilogoAccount.selectedIndex, 10);
        miaData   = dateComboRiepilogoAccount[mioIndice];
        
        dateComboAccount.push(miaData);
        dateComboRiepilogoAccount = togliElemento(dateComboRiepilogoAccount, mioIndice);
        // ----------------- ANTONIO  23-06-2004
        
        seloption=new Option(testo, valore);
        document.lancioNCForm.comboAccount.options[document.lancioNCForm.comboAccount.length] = seloption;
        document.lancioNCForm.comboRiepilogoAccount.options[document.lancioNCForm.comboRiepilogoAccount.selectedIndex] = null;
        DisabilitaBotton();
        document.lancioNCForm.comboAccount[document.lancioNCForm.comboAccount.length-1].selected=true;
    } else
      window.alert("Attenzione! Selezionare prima un account dal riepilogo.");
}
//----------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------
function setInitialValue() {
  objForm=document.lancioNCForm; 
  DisableAllControls(objForm); 
  Enable(document.lancioNCForm.comboAccount);  
  Enable(document.lancioNCForm.comboRiepilogoAccount);
  document.lancioNCForm.dataFineA.value = "";
  document.lancioNCForm.dataSched.value = "";
  DisabilitaBotton();
  //dis_calendario();
}
//----------------------------------------------------------------------------------------------------------------------

</SCRIPT>


</HEAD>
<BODY onload="setInitialValue();">


<form name="lancioNCForm" method="post" action="LancioNCSp.jsp">

<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value=<%=cod_tipo_contr%>>
<input type="hidden" name=des_tipo_contr    id=des_tipo_contr     value="<%=des_tipo_contr%>">
<input type="hidden" name=sizeLst id=sizeLst value="<%=sizeLst%>">
<input type="hidden" name=appomsg id=appomsg      value="<%=appomsg%>">
<input type="hidden" name=appoData id=appoData      value="<%=appoData%>">
<input type="hidden" name=codeFunzBatch           id=codeFunzBatch            value="<%=codeFunzBatch%>">
<input type="hidden" name=codeFunzBatchNC         id=codeFunzBatchNC          value="<%=codeFunzBatchNC%>">
<input type="hidden" name=codeFunzBatchRE         id=codeFunzBatchRE          value="<%=codeFunzBatchRE%>">
<input type="hidden" name=flagTipoContr           id=flagTipoContr            value="<%=flagTipoContr%>">
<input type="hidden" name=max_data_fine_periodo   id=max_data_fine_periodo    value="<%=max_data_fine_periodo%>">  <!--03-04-03-->



<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor=<%=StaticContext.bgColorCellaBianca%>><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorHeader%>>
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorHeader%>>
              <tr>
                <td bgcolor=<%=StaticContext.bgColorHeader%> class="white" valign="top" width="91%">&nbsp;Lancio Batch Nota di Credito: <%=des_tipo_contr%></td>
                <td bgcolor=<%=StaticContext.bgColorCellaBianca%> class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor=<%=StaticContext.bgColorCellaBianca%>><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td bgcolor=<%=StaticContext.bgColorCellaBianca%>><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
<!-- CARICO LISTA ACCOUNT -->
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorHeader%>>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorHeader%>>
                    <tr>
                      <td bgcolor=<%=StaticContext.bgColorHeader%> class="white" valign="top" width="91%">&nbsp;Dati Cliente</td>
                      <td bgcolor=<%=StaticContext.bgColorCellaBianca%> class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td bgcolor=<%=StaticContext.bgColorCellaBianca%>><img src="../../image/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorTabellaForm%>>
                          <tr>
                            <td <td colspan='2'>&nbsp;</td>
                          </tr>
                          <tr> 
                            <td class="textB" valign="top" width="30%">&nbsp;Account</td>
                            <td class="text" align="left" width="70%">
                              <Select name="comboAccount" class="text" size="7" style="width: 80%;" width="400px">
                                <%
                                datiCli = homecmbAcc.findAllAccXNC(codeFunzBatch, codeFunzBatchNC, cod_tipo_contr);
                                if ((datiCli==null)||(datiCli.size()==0)) {
                                    dataFinePerFattSel="";
                                } 
                                else //(datiCli==null)||(datiCli.size()==0)
                                {
                                    session.setAttribute("datiCli", datiCli);
                                    Object[] objs3=datiCli.toArray();
                                    DatiCliBMP obj3=null;
                                    String datafine="";
                                    //------------------ANTONIO 23/06/2004
                                    String maxDataFineCorr=""; 
                                    //------------------ANTONIO 23/06/2004
                              		
                                    for (int i=0;i<datiCli.size();i++) {
                                      obj3=(DatiCliBMP)objs3[i];
                                		
                                      //------------------ANTONIO 23/06/2004
                                		
                                      if (obj3.getDataFinePerFatt() != null) {
                                        maxDataFineCorr = obj3.getDataFinePerFatt();
                                      } else {
                                        maxDataFineCorr = "";
                                      }
                                      /*
                                      if (obj3.getMaxDataFine() != null) {
                                        maxDataFineCorr = obj3.getMaxDataFine();
                                      } else {
                                        maxDataFineCorr = "";
                                      }*/
                                      //------------------ANTONIO 23/06/2004
                                		
                                      if (i==0) {
                                          sSELECTED="SELECTED";
                                          if (obj3.getDataFinePerFatt()!=null)
                                              dataFinePerFattSel=obj3.getDataFinePerFatt();
                                          else  
                                              dataFinePerFattSel="";
                                     
                                      } else sSELECTED="";
                               
                                  %>
                              
                                  <option value="<%=obj3.getAccount()%>" <%=sSELECTED%>><%=obj3.getDesc()%></option>
                                  <!-- ANTONIO ----------- 23-06-2004 -->
                                <SCRIPT language='JavaScript'> dateComboAccount.push('<%= maxDataFineCorr %>'); </SCRIPT>
                                <!-- ANTONIO ----------- 23-06-2004 -->
                              
                                <%    
                              
                                  }//for
                                }//chiusura dell'else
                          
                                %>
                              </select>
                          </td>
                        </tr>
                        <tr>
                          <td colspan=2>&nbsp;</td>
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
       <td bgcolor=<%=StaticContext.bgColorCellaBianca%>><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
<!-- INSERISCO ISTRUZIONI PER LA 2 LISTA  -->
      <tr>
  	   <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorHeader%>>
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorHeader%>>
            <tr>
             <td bgcolor=<%=StaticContext.bgColorHeader%> class="white" valign="top" width="91%">&nbsp;Riepilogo</td>
             <td bgcolor=<%=StaticContext.bgColorCellaBianca%> class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
           </table>
          </td>
         </tr>
         <tr>
          <td>
           <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
            <tr>
             <td bgcolor=<%=StaticContext.bgColorCellaBianca%>><img src="../../image/body/pixel.gif" width="1" height='2'></td>
            </tr>
            <tr>
             <td>
              <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor=<%=StaticContext.bgColorTabellaForm%>>
               <tr>
           				<td colspan='2'>&nbsp;</td>
               </tr>
               <tr> 
                    <td class="textB" valign="top" width="30%">&nbsp;Account</td>
             				<td class="text" align="left" width="70%">
                       <Select class="text" style="width: 80%;" width="400px" name="comboRiepilogoAccount" size="7"><!--onDblClick="ONELIMINA()"-->
                         <%
                             datiCli = homecmbAcc.findAllAccXNCAbort(codeFunzBatch, codeFunzBatchNC);                             
                             if ((datiCli1==null)||(datiCli1.size()==0)){
                          %>        
                          <%
                             } else //(datiCli1==null)||(datiCli1.size()==0)
                             	   {
                      		      session.setAttribute("datiCli1", datiCli1);
                      		      Object[] objs4=datiCli1.toArray();
                      		      String datafine1="";
                              
	                              //------------------ANTONIO 23/06/2004
	                              String maxDataFineCorr2 = ""; 
	                              //------------------ANTONIO 23/06/2004
                              
                              	      for (int i=0;i<datiCli1.size();i++) {
                               		DatiCliBMP obj4=(DatiCliBMP)objs4[i];
                              		
                              		//------------------ANTONIO 23/06/2004
                                	if (obj4.getMaxDataFine() != null) {
                                		maxDataFineCorr2 = obj4.getDataFinePerFatt();
                                	} else {
                                		maxDataFineCorr2 = "";
                                	}
                                	//------------------ANTONIO 23/06/2004
                               
	                                if (obj4.getDataFinePerFatt()!=null)
                                  		datafine1=obj4.getDataFinePerFatt();
                               		else
                                 		datafine1 = "_________";
                              		String riepilogo=obj4.getDesc();
                           %>
                                                          
                              <option value="<%=obj4.getAccount()%>"><%=obj4.getDesc()%> </option>
                              <!-- ANTONIO ----------- 23-06-2004 -->
	                            <SCRIPT language='JavaScript'> dateComboRiepilogoAccount.push('<%= maxDataFineCorr2 %>'); </SCRIPT>
	                            <!-- ANTONIO ----------- 23-06-2004 -->
                           <%    
                             }//for
                            }//chiusura dell'else
                          %>
                        </select>
                  </td>
               </tr>
               <tr>
                  <td>&nbsp;</td>
                  <td bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="textB" align="right" width="12%">  
                      Data fine periodo :  
                      <input  class="text" title="dataFineA" type=text size=10 maxlength="10" name="dataFineA" value="111111"> 
                      <a href="javascript:showCalendar('lancioNCForm.dataFineA','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                      <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                      &nbsp;
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
               <input type=checkbox name=schedulazione value="N" onclick="f_calendarioSched(document.lancioNCForm.schedulazione)"> &nbsp;
               Data/Ora Schedulazione :&nbsp;             
               <input type="text" class="text" size=20 maxlength="20" name="dataSched" title="dataSched" value="" onblur="handleblur('data_ini');"> 
               <a href="javascript:cal3.popup();" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendarioSched' src="../../common/images/img/cal.gif" border="no"></a>
               <a href="javascript:cancelCalendar(document.lancioNCForm.dataSched);" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_dataSched' src="../../common/images/img/images7.gif" border="0"></a>
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
    <td >
     <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
    <td class="textB" bgcolor=<%=StaticContext.bgColorFooter%> align="center">
        <sec:ShowButtons VectorName="bottonSp" />
    </td>
  </tr>
</table>
    </td>
   </tr>
     </td>
  </tr>
</table>
</form>

 <script language="JavaScript">
  var cal3 = new calendar1(document.forms['lancioNCForm'].elements['dataSched']);
  cal3.year_scroll = true;
	cal3.time_comp = true;
 </script>
 
</BODY>
</HTML>

