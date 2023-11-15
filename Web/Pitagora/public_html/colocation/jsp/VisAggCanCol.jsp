<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*" %>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"VISAGGCANCOL")%>
</logtag:logData>



<%
//******************** dati di input 
//******************** chiavi
String utrSelez      = request.getParameter("utrSelez");
String accountSelez  = request.getParameter("accountSelez"); 
String sitoSelez     = request.getParameter("sitoSelez");
String desUtrSelez      = request.getParameter("desUtrSelez");
String desAccountSelez  = request.getParameter("desAccountSelez"); 
String desSitoSelez     = request.getParameter("desSitoSelez");
String act = request.getParameter("act");
String question="";

//******************** attributi
String imp_tar     = request.getParameter("imp_tar");
String imp_cons    = request.getParameter("imp_cons");
String data_ini    = request.getParameter("data_ini");
String mod_ull     = request.getParameter("mod_ull");
String mod_itc     = request.getParameter("mod_itc");

String data_ini_mmdd =  Utility.getDateMMDDYYYY(data_ini);
String data_ini_ddmm =  Utility.getDateDDMMYYYY();//data di sistema


String eleQtaPs[]     = new String[10];
String eleCodePs[]     = new String[10];

if (request.getParameterValues("eleQtaPs")!=null){
 
for (int ieleQtaPs=0;eleQtaPs.length >ieleQtaPs && ieleQtaPs<request.getParameterValues("eleQtaPs").length;ieleQtaPs++)
   {
    eleQtaPs[ieleQtaPs] = request.getParameterValues("eleQtaPs")[ieleQtaPs];
    eleCodePs[ieleQtaPs] = request.getParameterValues("eleCodePs")[ieleQtaPs];

   } 
}

// dati della lista PS
// Vettore contenente risultati query per il caricamento della lista ps
Collection prodServ=null;
Collection bkprodServ=null;
Vector utr=null;
String listasize=request.getParameter("size");
String cod_tipo_col ="1";
String strNumRec = request.getParameter("numRec");

//MMMString typeLoad=request.getParameter("typeLoad");
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if ((strtypeLoad!=null)&&!(strtypeLoad.equals("")))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

int records_per_page=5;
int index=0;

// Elaborazione: Gestione abilitazione tasti
String tipo_operazione ="";
String fieldisabled="enabled";
if (act.equals("Vis"))
    {
      tipo_operazione= "Visualizzazione";
      fieldisabled="disabled";
    }
else if (act.equals("Agg"))  
     {
       tipo_operazione= "Aggiornamento";
       question="Si conferma l'aggiornamento dei dati Contrattuali Attivazione Sito?";
     }  
       
else if (act.equals("Can"))
    {
    fieldisabled="disabled";
    tipo_operazione= "Cancellazione";
    question="Si conferma la cancellazione dei dati Contrattuali Attivazione Sito?";
    }
%>

<EJB:useHome id="homeUnTerRete"   type="com.ejbSTL.UnTerReteSTLHome" location="UnTerReteSTL" />
<EJB:useHome id="homeControlli"   type="com.ejbSTL.ControlliSTLHome" location="ControlliSTL" />
<EJB:useBean id="remoteControlli" type="com.ejbSTL.ControlliSTL"     value="<%=homeControlli.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeProdServ"    type="com.ejbSTL.ProdServSTLHome"  location="ProdServSTL" />
<EJB:useBean id="remoteProdServ"  type="com.ejbSTL.ProdServSTL"      value="<%=homeProdServ.create()%>" scope="session"></EJB:useBean>
<EJB:useHome id="homeDatiSito"    type="com.ejbSTL.SitoSTLHome"      location="SitoSTL" />
<EJB:useBean id="remoteDatiSito"  type="com.ejbSTL.SitoSTL"          value="<%=homeDatiSito.create()%>" scope="session"></EJB:useBean>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Nuova Attivazione Sito </TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/ListaAccount.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/NuovaCol.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

var codOggFattSel="";
var carCausaleBoolean=true;
var UnitaMisuraDisp=false;
var appoggio;
var codtarSel="";

function handle_cancel_update()
{
  if (document.account.msg.value=="")
  {
  
    if (window.confirm("<%=question%>"))
      {
        Enable(document.account.data_ini);
        document.account.action='<%=request.getContextPath()%>/servlet/ColocationCNTL';
        document.account.submit();
      }
  }  
 else
  {
    if (document.account.msg.value=='no_elab')
        alert("Attenzione! Impossibile proseguire a causa della presenza di elaborazioni batch in corso.");
    if (document.account.msg.value=='no_data')
        alert("La data di consegna del sito, deve essere maggiore o uguale\ralla data di inizio validità dell'account."); //ossia: "+document.account.dataIniValAcc.value+".");
    document.account.msg.value="";       
  }
}

function ChangeSel(cod1,cod2)
{
  codtarSel=cod1;
  cod_prog_tar=cod2;
}

function ONANNULLA()
{
if ("<%=act%>"=="Vis")
{
  history.back();
}
else
{  
 document.account.data_ini.value=document.account.bkdata_ini.value;
  document.account.imp_tar.value=document.account.bkimp_tar.value;
  document.account.imp_cons.value=document.account.bkimp_cons.value;  
  document.account.mod_ull.value=document.account.bkmod_ull.value;
  document.account.mod_itc.value=document.account.bkmod_itc.value;
  for(var i=0;document.account.qta.length>i;i++)
  { document.account.qta[i].value = document.account.bkqta[i].value;}
}  
//  document.account.caricasiti.value='false';
}

function trasformaData(stringa_data)
{
  var nuova_data = stringa_data.substring(10,6) + stringa_data.substring(5,3)
                   + stringa_data.substring(2,0);
   return nuova_data;
}

function ONCONFERMA()
{
  messaggio="";
  document.account.typeLoad.value="1";

  data1=trasformaData(document.account.data_ini.value);
  data2=trasformaData(document.account.data_ini_ddmm.value);
  mod_itc_err=CheckNum(document.account.mod_itc.value,3,0,false);
  mod_ull_err=CheckNum(document.account.mod_ull.value,3,0,false); 
  ritorno=CheckNum(document.account.imp_tar.value,16,4,false);
  ritorno2=CheckNum(document.account.imp_cons.value,16,4,false);

  controlli();
      
  if (messaggio!="")   
     alert(messaggio);
  else
  {
     var strURL="NuovaColWf.jsp";
     strURL+="?act=update";
     strURL+="&accountSelez1="+document.account.accountSelez.value;
     //strURL+="&sitoSelez="+document.account.sitoSelez.value;
     strURL+="&data_ini="+document.account.data_ini.value;
     //window.alert(strURL);
     openDialog(strURL, 400, 5, handle_cancel_update);
   }
}



function ONCANCELLA()
{
     document.account.typeLoad.value="1";
     var strURL="NuovaColWf.jsp";
     strURL+="?act=cancel";
     openDialog(strURL, 400, 5, handle_cancel_update);
}


function avviso()
{
  document.account.btnPS.focus();
  alert("Selezionare un Prodotto/Servizi.");
}


function submitFrmSearch(typeLoad)
{
  
  document.account.typeLoad.value=typeLoad;
  document.account.submit();
}


function setInitialValue()
{
 Disable(document.account.data_ini);
  
 if ('<%=request.getParameter("mes")%>'=='no_elab')
  alert("Attenzione! Impossibile proseguire a causa della presenza di elaborazioni batch in corso.");

 if ('<%=request.getParameter("mes")%>'=='no_data')
 alert("La data di consegna del sito, deve essere maggiore o uguale\r alla data di inizio validità dell'account.");
  
 if ('<%=request.getParameter("mes")%>'=='no_acc_sito') 
  alert("L'account è già presente per il sito.");

}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<%
if ((utrSelez!=null))
   {
     utr = (Vector) session.getAttribute("utr");
   }
   else
   {  
        UnTerReteSTL remoteUnTerRete= homeUnTerRete.create();
        utr=remoteUnTerRete.getUTR();
        if (utr!=null)
          {
           session.setAttribute("utr", utr);
          } 
   }
     if (!request.getParameter("act").equals("Vis")){
         int verificaFatturazione= remoteControlli.verFattAccount(sitoSelez,accountSelez,data_ini);
         if (verificaFatturazione>0 ) {
                 response.sendRedirect(request.getContextPath()+
                 "/colocation/jsp/ListaAccountCol.jsp?act="+act+"&mes=noFatt");
         }
     }
  //MMMMif ((typeLoad==null || typeLoad.equals("0"))){
  if (!( typeLoad!=0))
  {
           
      SitoElem lSitoElem = remoteDatiSito.getDataImportoSito(sitoSelez,accountSelez);
      Double a=new Double(lSitoElem.getImportoTariffaSecuritySito());
      if (act.equals("Vis")||act.equals("Can"))
      {
        
          //imp_tar = CustomNumberFormat.setToCurrencyFormat((new Double(lSitoElem.getImportoTariffaFittoSito()).toString()),4);
          imp_tar = CustomNumberFormat.setToNumberFormat((new Double(lSitoElem.getImportoTariffaFittoSito()).toString()),4,false,true);
          
          if (0>=a.doubleValue()) imp_cons="";
          else
            //imp_cons =CustomNumberFormat.setToCurrencyFormat(a.toString(),4);
            imp_cons =CustomNumberFormat.setToNumberFormat(a.toString(),4,false,true);
          
      }
      else
      {
          //imp_tar =  CustomNumberFormat.getFromNumberFormat((new Double(lSitoElem.getImportoTariffaFittoSito()).toString()));
          imp_tar =  CustomNumberFormat.setToNumberFormat((new Double(lSitoElem.getImportoTariffaFittoSito()).toString()),4,false,false);

          if (0>=a.doubleValue()) imp_cons="";
          else
            //imp_cons =  CustomNumberFormat.getFromNumberFormat(a.toString());
            imp_cons =  CustomNumberFormat.setToNumberFormat(a.toString(),4,false,false);
      }
      data_ini =  lSitoElem.getDataSito();

      lSitoElem = remoteDatiSito.getNumModuli(sitoSelez,accountSelez);
      Integer mu=new Integer(lSitoElem.getnumModuliUll());
      Integer mi=new Integer(lSitoElem.getnumModuliItc());
      if (0>=mu.intValue()) mod_ull="";
      else
        mod_ull = (mu.toString());
      if (0>=mi.intValue()) mod_itc="";  
      else
        mod_itc = (mi.toString());
      session.setAttribute("bkdata_ini",data_ini);
      session.setAttribute("bkimp_tar",imp_tar);
      session.setAttribute("bkimp_cons",imp_cons);
      session.setAttribute("bkmod_ull",mod_ull);
      session.setAttribute("bkmod_itc",mod_itc);
  }
//******************** back up attributi in variabili di sessione 

//MMMMMMMif ((typeLoad!=null && !typeLoad.equals("0"))) 
   if (!(typeLoad==0))
   {
    prodServ = (Collection) session.getAttribute("prodServ");
    bkprodServ = (Collection) session.getAttribute("bkprodServ");
         
    Object[] objs=prodServ.toArray();
    int dimCol= prodServ.size();
    prodServ.clear();
    for (int i=0;i<dimCol;i++)
        {
        ProdServElem obj=(ProdServElem)objs[i];
        obj.setCodePs(eleCodePs[i]);
        
        if (eleQtaPs[i]!=null && !eleQtaPs[i].equals(""))
        {
          //MMM 24/10/02 
           //obj.setQtaPs(new Integer(eleQtaPs[i]).intValue());
           obj.setQtaPs(new Double(eleQtaPs[i]));
         }  
        else
           obj.setQtaPs(new Double(-1));
        prodServ.add(objs[i]);
       } 
   }
   else
   {
//      prodServ = remoteProdServ.getPsUm(cod_tipo_col);
      prodServ = remoteProdServ.getPsUmQta(cod_tipo_col,sitoSelez,accountSelez);
      if (prodServ!=null)
         {
          session.setAttribute("prodServ", prodServ);
          session.setAttribute("bkprodServ", prodServ);
         
         } 
   }


bkprodServ = (Collection) session.getAttribute("bkprodServ");

 %>

<FORM name="account" method="get" action="NuovaCol.jsp">
<input type="hidden" name=msg             id=msg              value= "">
<input type="hidden" name=utrSelez        id= utrSelez        value="<%=utrSelez%>">
<input type="hidden" name=accountSelez    id= accountSelez    value="<%=accountSelez%>">
<input type="hidden" name=sitoSelez       id= sitoSelez       value="<%=sitoSelez%>">
<input type="hidden" name=act             id=act              value="<%=act%>">
<input type="hidden" name=data_ini_ddmm   id=data_ini_ddmm    value="<%=data_ini_ddmm %>">

<% // TEXTFIELD PER IL RIPRISTINO %>
<input type="hidden" name=bkdata_ini    id= bkdata_ini value="<%=session.getAttribute("bkdata_ini")%>">
<input type="hidden" name=bkimp_tar    id= bkimp_tar   value="<%=session.getAttribute("bkimp_tar")%>">
<input type="hidden" name=bkimp_cons    id= bkimp_cons value="<%=session.getAttribute("bkimp_cons")%>">
<input type="hidden" name=bkmod_ull    id= bkmod_ull   value="<%=session.getAttribute("bkmod_ull")%>">
<input type="hidden" name=bkmod_itc    id= bkmod_itc   value="<%=session.getAttribute("bkmod_itc")%>">




<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/colocation.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%out.println(tipo_operazione);%> Dati Contrattuali Attivazione Sito</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>

        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Dati</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td  width="10%" class="textB" align="left">&nbsp;&nbsp;U.T.R.:</td>
                      <td  width="20%" class="text"  align="left">&nbsp;<%=desUtrSelez%>
                          <input type="hidden"  class="text" name="utr" value="<%=desUtrSelez%>">
                          <!--<input disabled onFocus="blocca();" title="U.T.R." type="text" size="45" maxlength="45" name="utr" value="<%=desUtrSelez%>">-->
                      </td>   
                      <td width="10%" class="textB" align="left">&nbsp;Sito:</td>
                      <td width="60%" class="text"  align="left">&nbsp;<%=desSitoSelez%>
                          <input type="hidden" class="text" maxlength="45" name="sito" value="<%=desSitoSelez%>">
                          <!-- &nbsp;<input disabled onFocus="blocca();" title="SITO" type="text" size="45" maxlength="45" name="sito" value="<%=desSitoSelez%>">-->
						          </td>
                    </tr>
                     <!--tr-->

                      <tr>
                      <td colspan='4'> &nbsp; </td>
                      </tr>
                     
                     <!--/tr-->
                     </table>

<!-- account-->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td  width="10%" class="textB" align="left"> &nbsp;&nbsp;Account:</td>
                      <td  width="90%" class="text"  align="left"> &nbsp;<%=desAccountSelez%>
                           <input type="hidden" class="text" size="45" maxlength="45" name="account" value="<%=desAccountSelez%>">                          
                      </td> 
                      <td colspan='2'> &nbsp;</td>
                    </tr>
                     <tr>
                      <td colspan='4'> &nbsp; </td>
                    </tr>
                </table> 
<!-- account fine-->



<!--b text field editabili-->
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td   width="35%" class="textB" align="left">&nbsp;&nbsp;Data di consegna del sito:</td>
                      <td   width="35%" class="textB" align="left">&nbsp;Numero moduli ULL:</td>
                      <td   width="30%" class="textB" align="left">&nbsp;Numero moduli ITC:</td>
                    </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td  width="35%" align="left" class="text">
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                            <tr align="left">
                             <td  align="left"  class="text"> 
                             <%if (fieldisabled.equals("enabled")) 
                             {%>                               
                               &nbsp; <input class="text" title="Data inizio" type="text" size="10" maxlength="10" name="data_ini" value="<%=data_ini%>"> 
                               <Script language="javascript"> Enable(document.account.data_ini);</Script>
                             <%}else{%>                               
                              &nbsp;&nbsp;<%=data_ini%>
                              <input type="hidden" size="10" maxlength="10" class="text" name="data_ini" value="<%=data_ini%>"> 
                             <%} %>                               
                             <!--/td-->
                             <!--td width="70%" align="left" class="text"-->
                             <%if (fieldisabled.equals("enabled")) 
                             {%>                               
                              &nbsp; <a href="javascript:showCalendar('account.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendario' src="../../common/images/body/calendario.gif" border="no"></a>
                                     <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancella_data' src="../../common/images/body/cancella.gif" border="0"></a> 
                             <%}%>                               
                             </td>
                            </tr>  
                        </table>
                      </td>
                      <td   width="35%" class="text" align="left">
                       <%if (fieldisabled.equals("enabled")) 
                       {%>                               
                         &nbsp;<input type="TEXT" class="text"  name="mod_ull" id= "mod_ull" maxlength="3" size="15%" value="<%=mod_ull%>" > 
                         <Script language="javascript"> Enable(document.account.mod_ull);</Script>
                     <%} else {%>                               
                        &nbsp;<%=mod_ull%>
                        <input type="hidden" class="text" name="mod_ull" id= "mod_ull" maxlength="3" size="15%" value="<%=mod_ull%>" > 
                      <%} %>                               
                      </td>
                      <td   width="30%" class="text" align="left">
                       <%if (fieldisabled.equals("enabled")) 
                       {%>                               
                        &nbsp;<input type="TEXT" class="text"  name="mod_itc" id= "mod_itc" maxlength="3" size="15%" value="<%=mod_itc%>" > 
                        <Script language="javascript"> Enable(document.account.mod_itc);</Script>
                    <%} else {%>                               
                       &nbsp;<%=mod_itc%>
                         <input type="hidden" name="mod_itc" id= "mod_itc" maxlength="3" size="15%" value="<%=mod_itc%>" > 
                      <%} %>                               
                      </td>
                     </tr>
              </table>

              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td   width="35%" class="textB" align="left">&nbsp;&nbsp;Importo annuale fitto:</td>
                      <td   width="60%" class="textB" align="left">&nbsp;Importo annuale consulenza per security:</td>
                      <td   width="5%" class="textB" align="left">&nbsp;</td>
                      <!--<td   width="10%" class="textB" align="left">&nbsp;</td>-->
                    </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td   width="35%" class="text" align="left">
                       <%if (fieldisabled.equals("enabled")) {%>                               
                       &nbsp;&nbsp;<input type="TEXT" class="text"  name="imp_tar" id= "imp_tar" maxlength="17" size="15%" value="<%=imp_tar%>" > 
                        <Script language="javascript"> Enable(document.account.imp_tar);</Script>
                             <%} else {%>                               
                        &nbsp;&nbsp;<%=imp_tar%>
                       <input type="hidden" class="text" name="imp_tar" id= "imp_tar" maxlength="17" size="15%" value="<%=imp_tar%>" >                         
                       <%} %>                               
                      </td>
                      
                      <td   width="60%" class="text" align="left">
                       <%if (fieldisabled.equals("enabled")) {%>                               
                       <input type="TEXT" class="text" name="imp_cons" id= "imp_cons" maxlength="17" size="15%" value="<%=imp_cons%>" > 
                          <Script language="javascript"> Enable(document.account.imp_cons);</Script>
                             <%} else {%>                               
                        &nbsp;<%=imp_cons%>
                       <input type="hidden" class="text" name="imp_cons" id= "imp_cons" maxlength="17" size="15%" value="<%=imp_cons%>" > 
                         <%} %>                               
                      </td>
                      
                      <td   width="5%" class="textB" align="left">
                      &nbsp;
                      </td>
                    </tr>
              </table>
              
<!--bi textfields editabili fine-->
<input class="textB" type="hidden" name="typeLoad" value="">
<input class="textB" type="hidden" name="txtnumRec" value="">
<input class="textB" type="hidden" name="txtnumPag" value="1">
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
           <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
         </tr>
       </table>
              
			</td>
    </tr>
      <tr>
       <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
<%//**************************CARICAMENTO LISTA***********************%>
     <tr>
  	  <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
         <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                    <td  bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;</td>
                    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
       <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/body/pixel.gif" width="1" height='2'></td>
              </tr>
            <%
               
               if ((prodServ==null)||(prodServ.size()==0))
               {%>         
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
              </tr>
             <%}else{%>
                 <tr>
                    <td bgcolor='<%=StaticContext.bgColorCellaBianca%>'    class='white' width='2%' >&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB' width='87%'>Prodotti e Servizi</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class="white" width='2%' >&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB' width='9%'> Quantità</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='white' width='2%'> &nbsp;</td>
                 </tr>
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=prodServ.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
<%
               
                String bgcolor="";
                String checked;  
                Object[] objs=prodServ.toArray();
                Object[] bkobjs=bkprodServ.toArray();
                
                //for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<prodServ.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                  int deltax=0;
                  for (int i=0;i<prodServ.size();i++)
                {
                    ProdServElem obj=(ProdServElem)objs[i];
                    ProdServElem bkobj=(ProdServElem)bkobjs[i];
                    
                    if ((deltax%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                    deltax++;
                    //MMM 24/10/02 
                      //if (obj.getQtaPs()!=-1 || fieldisabled.equals("enabled"))
                      if (obj.getQtaPs().doubleValue()!=-1 || fieldisabled.equals("enabled"))
                      {%>
                     <input class="textB" type="hidden" name="size" value="<%=listasize%>">
                      <tr>                                                                                                      
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' name='umps' class='text' width='87%'><%=obj.getDescPs()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text' width='2%'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' class='text' width='9%' align="left">
                             <input type="hidden" class="text" name="codePs" id= "codePs" size="4%" maxlength="7" value="<%=obj.getCodePs()%>" >
                             <input type="hidden" name="descPs" id= "descPs" size="4%" maxlength="5" value="<%=obj.getDescPs()%>" >
                          <%
                          String maxlength="";
                          int decimali=0;
                          if (obj.getCodePs().equalsIgnoreCase("8021")) //Punti di Segnalazione 
                          {
                            maxlength="5"; //per le 5 cifre intere
                            decimali=0; //per le 0 cifre decimali
                          }  
                          else
                          {
                            maxlength="9"; //per le 5 cifre intere + 3 decimali +la virgola
                            decimali=3; //per le 0 cifre decimali
                          }  
                          %>  

                             <input type="hidden" class="text" name="bkqta" id= "bkqta" size="4%" maxlength="<%=maxlength%>" value="<%=(bkobj.getQtaPs().doubleValue()!=-1 ?  CustomNumberFormat.setToNumberFormat(bkobj.getQtaPs().toString(),decimali,false,true):"")%>" >
                             <%if (fieldisabled.equals("enabled")) 
                             {%>                               
                                <input type="TEXT"  class="text" name="qta" id= "qta" size="<%=maxlength%>%" maxlength="<%=maxlength%>" value="<%=(obj.getQtaPs().doubleValue()!=-1 ?  CustomNumberFormat.setToNumberFormat(obj.getQtaPs().toString(),decimali,false,false):"")%>" >
                             <%}
                             else 
                             {%>   
                             <input type="hidden"  class="text" name="qta" id= "qta" size="4%" maxlength="<%=maxlength%>" value="<%=(obj.getQtaPs().doubleValue()!=-1 ?  CustomNumberFormat.setToNumberFormat(obj.getQtaPs().toString(),decimali,false,true):"")%>" >
                             <%=(obj.getQtaPs().doubleValue()!=-1 ?  CustomNumberFormat.setToNumberFormat(obj.getQtaPs().toString(),decimali,false,true):"")%>
                           <%}%>                               
                          </td>
                          <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='white' width='2%'> &nbsp;</td>
                      </tr>
                   <%}
                    else 
                      deltax--; 
                    }//for
                    %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/image/pixel.gif" width="3" height='2'></td>
                    </tr>
                </pg:pager>
                <tr>
                  <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/image/pixel.gif" width="1" height='2'></td>
                </tr>
             </table>
          </td>
        </tr>
<%
 }//else (se prodServè pieno)   
%>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="1" height='3'></td>
  </tr>

</table>

  <tr align=left>
    <td colspan=5 align=left>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'> 
     <tr>
       <td colspan=4>
<%
//            if (tipo_operazione.equalsIgnoreCase("Visualizzazione"))
//            {
%>
              <!--<sec:ShowButtons VectorName="BOTTONI" />-->
<%
            //}
            //else
            if (tipo_operazione.equalsIgnoreCase("Aggiornamento"))
            {
%>
              <sec:ShowButtons PageName="VisAggCanCol_AGG" />    
<%
            }
            else if (tipo_operazione.equalsIgnoreCase("Cancellazione"))
            {
%>
              <sec:ShowButtons PageName="VisAggCanCol_CAN" />                
<%
            }
%>
</td>
   </tr>
</td>

   </tr>
 </table>
  </td>
  </tr>
  </table>
 </FORM>

</BODY>
</HTML>









