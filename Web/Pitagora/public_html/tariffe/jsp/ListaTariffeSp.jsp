<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottoni" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Tariffe")%>
<%=StaticMessages.getMessage(3006,"ListaTariffeSp.jsp")%>
</logtag:logData>


<%
  response.addHeader("Pragma", "no-cache");
	response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

String hidFlagSys=request.getParameter("hidFlagSys");
if (hidFlagSys==null) hidFlagSys=request.getParameter("hidFlagSys");
if (hidFlagSys==null) hidFlagSys=(String)session.getAttribute("hidFlagSys");


String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");


String cod_tar          = request.getParameter("cod_tar");
String cod_PS           = request.getParameter("cod_PS");
//if (cod_PS==null) cod_PS=(String)session.getAttribute("cod_PS");


String des_PS           = request.getParameter("des_PS");
//String des_PS =(String)session.getAttribute("des_PS");
if (des_PS==null) des_PS=(String)session.getAttribute("des_PS");

String desc_tariffa     = request.getParameter("desc_tariffa");
String importo_tariffa  = request.getParameter("importo_tariffa");
String oggFattSelez     = request.getParameter("oggFattSelez");

String clasOggFattSelez = request.getParameter("clasOggFattSelez");
String causaleSelez     = request.getParameter("causaleSelez");
String caricaOggFatt    = request.getParameter("caricaOggFatt");
String caricaUniMis     = request.getParameter("caricaUniMis");
String misuraDisp       = request.getParameter("misuraDisp");
String richSave         = request.getParameter("richSave");
String cof              = request.getParameter("cof");
String tipo_pannello    = request.getParameter("tipo_pannello");
String descr_causale    = request.getParameter("descr_causale");
String caricaCausale    = request.getParameter("caricaCausale");
String caricaLista      = request.getParameter("caricaLista");

//modifiche opzioni inizio 18-02-03
String opzioneSelez     = request.getParameter("opzioneSelez");
String caricaOpzione    = request.getParameter("caricaOpzione");
String descr_opzione    = request.getParameter("descr_opzione");
//modifiche opzioni fine 18-02-03

int indice=0;

//Inserimento istruzioni per la paginazione inizio
// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null)
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }



// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
//Inserimento istruzione per la paginazione fine

// Vettore contenente risultati query per il caricamento della lista
Collection tariffe=null;    

Vector classFatts2 = null;
//modifiche opzioni inizio 18-02-03
Vector classOpzioniTariffa = null;
//modifiche opzioni fine 18-02-03

//MMMMMMMMMMMMMMMMMMMMM
%>
  <EJB:useHome id="homeOggFatt" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />
<%
  Object[] objs1=null;
  Collection oggfatt=null;

if (cod_PS!=null)
{
  oggfatt= homeOggFatt.findOggFatt(cod_PS);
  if (oggfatt!=null) //valeria 17-10-02
    objs1=oggfatt.toArray();
}  

//Valeria inizio 17-10-02 
if (caricaCausale!= null && caricaCausale.equals("true"))
{%>
  <EJB:useHome id="homeCausale" type="com.ejbSTL.CausaleSTLHome" location="CausaleSTL" />
<%
   CausaleSTL remoteCausale= homeCausale.create();
   classFatts2=remoteCausale.getCausTar(cod_tipo_contr,cod_PS,oggFattSelez);
   //Valeria fine 17-10-02
   if ( (classFatts2==null) || ( (classFatts2!=null) && (classFatts2.size()==0)) )  //12/03/03
       caricaCausale="false";                                                       //12/03/03
}
  
//modifiche opzioni inizio 28-02-03
   caricaOpzione="false";
   if ( (oggFattSelez!=null && !(oggFattSelez.equalsIgnoreCase("")) && !(oggFattSelez.equalsIgnoreCase("-1"))) && (caricaCausale!=null && caricaCausale.equalsIgnoreCase("false")))
   {%>
    <EJB:useHome id="homeOpzioniTariffa" type="com.ejbSTL.OpzioniTariffaSTLHome" location="OpzioniTariffaSTL" />
    <%
      OpzioniTariffaSTL remoteOpzioniTariffa= homeOpzioniTariffa.create();
      classOpzioniTariffa = remoteOpzioniTariffa.getOpzTarXTipoContr(oggFattSelez,cod_PS); //04-03-03
      if ((classOpzioniTariffa!=null)&&(classOpzioniTariffa.size()!=0))
         caricaOpzione="true";

   }   
//modifiche opzioni fine 28-02-03

%>
<EJB:useHome id="homeTariffa" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lista Tariffe </TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/ListaTariffeSp.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>


var codOggFattSel="";
var carCausaleBoolean=true;
var UnitaMisuraDisp=false;
var appoggio;

function handleReturnedValuePS()
{

if ((document.oggFattForm.cod_PS.value==appoggio) || (document.oggFattForm.cod_PS.value=="" && appoggio=="null"))
  {
      Disable(document.oggFattForm.des_PS);
  }
  else
  {
    if (document.oggFattForm.cod_PS.value=="")
    {
      //da qui
      if (document.oggFattForm.comboOggFatt.selectedIndex==0)
      {
        selezione=-1;
      }
      else
      {
       selezione=document.oggFattForm.ccof[document.oggFattForm.comboOggFatt.selectedIndex-1].value;
      }
    //a qui
    
      document.oggFattForm.caricaLista.value="false";
      if (document.oggFattForm.caricaCausale.value=="true")
      { 
      // document.oggFattForm.causaleSelez.value=document.oggFattForm.comboCausale.value;
      document.oggFattForm.causaleSelez.value=document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value;
      }
      //modifica opzioni 18-02-03 inizio
      if (document.oggFattForm.caricaOpzione.value=="true")
      { 
          document.oggFattForm.opzioneSelez.value=document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value;
      }

      //modifica opzioni 18-02-03 fine
      Enable(document.oggFattForm.des_PS);
      Enable(document.oggFattForm.comboOggFatt);

      document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
      document.oggFattForm.clasOggFattSelez.value=selezione;
      document.oggFattForm.oggFattSelez.value="";
      Disable(document.oggFattForm.POPOLALISTA);
      document.oggFattForm.submit();
    }
    else
    {
       Disable(document.oggFattForm.POPOLALISTA);
       document.oggFattForm.caricaLista.value="false";
       
       document.oggFattForm.oggFattSelez.value="";
       document.oggFattForm.caricaCausale.value="false";
        //modifica opzioni 18-02-03 inizio
       document.oggFattForm.caricaOpzione.value="false";
       //modifica opzioni 18-02-03 fine
       cod_PS_appoggio=document.oggFattForm.cod_PS.value;
       des_PS_appoggio=document.oggFattForm.des_PS.value;
       //ONANNULLA();
       document.oggFattForm.cod_PS.value=cod_PS_appoggio;
       document.oggFattForm.des_PS.value=des_PS_appoggio;
       Enable(document.oggFattForm.cod_tipo_contr);
       Enable(document.oggFattForm.cod_PS);
       Enable(document.oggFattForm.des_PS);
       document.oggFattForm.submit();
     }  
  }
 }


function selezionaPs()
{
  
  appoggio=document.oggFattForm.cod_PS.value;
  Disable(document.oggFattForm.des_PS);
  var stringa="../../tariffe/jsp/ProdServSp.jsp?cod_tipo_contr="+<%=cod_tipo_contr%>+"&des_tipo_contr="+"<%=des_tipo_contr%>"+"&chiamante=<%="ListaTariffeSp"%>";  
  openDialog(stringa, 750, 400, handleReturnedValuePS);
}

function ChangeSel(cod1,cod2)
{
  document.oggFattForm.cod_tar.value=cod1;
  document.oggFattForm.prog_tar.value=cod2;
}

function handleReturnedValueDett()
{
}

function ONDETTAGLI()
{
   if ( (document.oggFattForm.cod_tar.value!="")&&(document.oggFattForm.cod_tar.value!=null)) 
   {
     codtarSel=document.oggFattForm.cod_tar.value;
     var stringa="../../tariffe/jsp/DettaglioTariffaSp.jsp?cod_tar="+codtarSel+"&cod_ogg_fatt=<%=oggFattSelez%>&cod_causale=<%=causaleSelez%>&cod_opzione=<%=opzioneSelez%>";
     openDialog(stringa, 700, 400, handleReturnedValueDett);
   }
    
}


function ONPOPOLALISTA()
{
 
 if ((isie)||((isnn)&&(check_form())))
 {
  //da qui
     if (document.oggFattForm.comboOggFatt.selectedIndex==0)
     {
        selezione=-1;
     }
     else
     {
       selezione=document.oggFattForm.ccof[document.oggFattForm.comboOggFatt.selectedIndex-1].value;
     }
    //a qui
    
    document.oggFattForm.caricaLista.value="true";

    if (document.oggFattForm.caricaCausale.value=="true")
    {
      document.oggFattForm.causaleSelez.value=document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value;
    }
    //modifiche opzione tariffa 18-02-03 inizio
    if (document.oggFattForm.caricaOpzione.value=="true")
    {
      document.oggFattForm.opzioneSelez.value=document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value;
    }
     //modifiche opzione tariffa 18-02-03 fine
      Enable(document.oggFattForm.des_PS);
      Enable(document.oggFattForm.comboOggFatt);
      document.oggFattForm.oggFattSelez.value=document.oggFattForm.comboOggFatt[document.oggFattForm.comboOggFatt.selectedIndex].value;
      document.oggFattForm.clasOggFattSelez.value=selezione;
      document.oggFattForm.submit();
   }
}



function ONDISATTIVA()
{
  document.oggFattForm.tipo_pannello.value="DIS";
  Enable(document.oggFattForm.tipo_pannello);
  Enable(document.oggFattForm.cod_tipo_contr);
  Enable(document.oggFattForm.cod_PS);
  Enable(document.oggFattForm.oggFattSelez);
  Enable(document.oggFattForm.cod_tarEnable);
  Enable(document.oggFattForm.prog_tarEnable);
  Enable(document.oggFattForm.des_tipo_contr);
  Enable(document.oggFattForm.cod_tar);
  Enable(document.oggFattForm.prog_tar);
  document.oggFattForm.action="ElabTariffaSp.jsp";
  document.oggFattForm.submit();
}

function ONCANCELLA()
{
  Enable(document.oggFattForm.des_PS);
  Enable(document.oggFattForm.descr_estesa_ps);
  Enable(document.oggFattForm.cod_tipo_contr);
  Enable(document.oggFattForm.cod_PS);
  Enable(document.oggFattForm.oggFattSelez);
  Enable(document.oggFattForm.des_tipo_contr);
  Enable(document.oggFattForm.cod_tar);
  Enable(document.oggFattForm.prog_tar);
  document.oggFattForm.tipo_pannello.value="CAN";
  document.oggFattForm.action="ElabTariffaSp.jsp";
  document.oggFattForm.submit();
}
function ONAGGIORNA()
{
  Enable(document.oggFattForm.des_PS);
  Enable(document.oggFattForm.cod_tipo_contr);
  Enable(document.oggFattForm.cod_PS);
  Enable(document.oggFattForm.oggFattSelez);
  Enable(document.oggFattForm.cod_tar);
  Enable(document.oggFattForm.prog_tar);
  Enable(document.oggFattForm.des_tipo_contr);
  document.oggFattForm.tipo_pannello.value="AGG";
  document.oggFattForm.action="ElabTariffaSp.jsp";
  document.oggFattForm.submit();
  
   
}
function ONVISUALIZZA()
{
  Enable(document.oggFattForm.des_PS);
  Enable(document.oggFattForm.cod_tipo_contr);
  Enable(document.oggFattForm.cod_PS);
  Enable(document.oggFattForm.oggFattSelez);
  Enable(document.oggFattForm.cod_tar);
  Enable(document.oggFattForm.prog_tar);
  Enable(document.oggFattForm.des_tipo_contr);
  document.oggFattForm.tipo_pannello.value="VIS";
  document.oggFattForm.action="ElabTariffaSp.jsp";
  document.oggFattForm.submit();
  
}

function setInitialValue()
{
     document.oggFattForm.tipo_pannello.value='null';
     Disable(document.oggFattForm.des_PS);
     Enable(document.oggFattForm.POPOLALISTA);
     if ((document.oggFattForm.comboOggFatt.disabled)||(document.oggFattForm.comboOggFatt.value==-1))
          Disable(document.oggFattForm.POPOLALISTA);
       
     if (document.oggFattForm.caricaCausale.value=="true")
     {  
      if ((document.oggFattForm.comboOggFatt.disabled)||(document.oggFattForm.comboCausale[document.oggFattForm.comboCausale.selectedIndex].value==-1))
         Disable(document.oggFattForm.POPOLALISTA);
     } 
     //modifiche opzione tariffa 18-02-03 inizio
     if (document.oggFattForm.caricaOpzione.value=="true")
     {  
      if ((document.oggFattForm.comboOggFatt.disabled)||(document.oggFattForm.comboOpzioneTariffa[document.oggFattForm.comboOpzioneTariffa.selectedIndex].value==-1))
         Disable(document.oggFattForm.POPOLALISTA);
     }      
     //modifiche opzione tariffa 18-02-03 fine   
}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">

<%

if ((tipo_pannello!=null)&&((tipo_pannello.equalsIgnoreCase("CAN"))||(tipo_pannello.equalsIgnoreCase("AGG"))||(tipo_pannello.equalsIgnoreCase("DIS"))))
  //caricaLista="false";
  caricaLista="true";
if ((caricaLista!= null) && (caricaLista.equals("true")))
{
   tariffe=homeTariffa.findAll(cod_PS,oggFattSelez,causaleSelez,opzioneSelez); //03-03-03
}

%>

<FORM name="oggFattForm" method="GET" action="ListaTariffeSp.jsp">


<input type="hidden" name=cod_PS            id=cod_PS             value="<%=cod_PS%>">
<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value="<%=cod_tipo_contr%>">
<input type="hidden" name=caricaCausale     id=caricaCausale      value= "<%=caricaCausale%>">
<input type="hidden" name=caricaLista       id=caricaLista        value= "<%=caricaLista%>">
<input type="hidden" name=caricaUniMis      id=caricaUniMis       value= "<%=caricaUniMis%>"> 
<input type="hidden" name=oggFattSelez      id= oggFattSelez      value= "<%=oggFattSelez%>"> 
<input type="hidden" name=clasOggFattSelez  id= clasOggFattSelez  value= "<%=clasOggFattSelez%>"> 
<input type="hidden" name=causaleSelez      id= causaleSelez      value= "<%=causaleSelez%>"> 
<input type="hidden" name=misuraDisp        id= misuraDisp        value= "<%=misuraDisp%>"> 
<input type="hidden" name=richSave          id= richSave          value= "<%=richSave%>"> 
<input type="hidden" name=des_tipo_contr    id= des_tipo_contr    value= "<%=des_tipo_contr%>"> 
<input type="hidden" name=descr_estesa_ps   id= descr_estesa_ps   value="<%=des_PS%>"> 
<input type="hidden" name=descr_causale     id= descr_causale     value="<%=descr_causale%>">
<input type="hidden" name=tipo_pannello     id= tipo_pannello     value="<%=tipo_pannello%>">
<input type="hidden" name=hidFlagSys        id= hidFlagSys        value="<%=hidFlagSys%>">
<!--modifica opzioni 18-02-03 inizio-->
<input type="hidden" name=caricaOpzione     id=caricaOpzione      value= "<%=caricaOpzione%>">
<input type="hidden" name=opzioneSelez      id= opzioneSelez      value= "<%=opzioneSelez%>"> 
<input type="hidden" name=descr_opzione     id= descr_opzione     value="<%=descr_opzione%>">
<!--modifica opzioni 18-02-03 inizio-->
<input type="hidden" name=des_PS_1          id= des_PS_1          value="<%=des_PS%>">



<table align="center" width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1-->
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_2-->
				<tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_3-->
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Tariffe</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>  <!--TABELLA_3_FINE-->
					</td>
				</tr>
      </table> <!--TABELLA_2_FINE-->
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center"> <!--TABELLA_4-->

        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_5-->
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_6-->
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table> <!--TABELLA_6_FINE-->
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>"> <!--TABELLA_7-->
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td  colspan='3' width="50%" class="textB" align="left">&nbsp Tipo contratto:&nbsp;</td>
                    </tr>
                     <tr>
                       <td  colspan='3' width="50%" class="text" align="left">&nbsp;&nbsp; <%=des_tipo_contr%>&nbsp;</td>        
                     </tr>
                    
                    <tr>
                      <td colspan='3' width="50%" class="textB" align="left">&nbsp P/S:&nbsp;</td>
                    </tr>
                    <tr>
                      <td  colspan='3' width="80%" class="text">
                            <% if (cod_PS==null){ des_PS="";}%>
                            &nbsp;<input class="text" type="TEXT" name="des_PS" id= "des_PS" size="65%" value="<%=des_PS%>"> 
                              <SCRIPT LANGUAGE='Javascript'> 
                                  Disable(document.oggFattForm.des_PS);
                              </script>
                          <input class="text" type="button" name="btnPS" value="..." onclick='selezionaPs();'>&nbsp; 
                      </td>
                    </tr>
                </table> <!--TABELLA_7_FINE-->

                     <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">  <!--TABELLA_8-->
                    <tr>
                      
                      <% if ((caricaCausale==null ||  caricaCausale.equals("false")) && (caricaOpzione==null || caricaOpzione.equals("false")))
                       {%>
                         <td colspan='3' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione</td> 
                     <%} 
                      else 
                      {
                        if (caricaCausale!= null && caricaCausale.equals("true"))
                        {%>
                          <td colspan='2' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione:</td>      
                          <td colspan='1' width="50%" class="textB" align="left">&nbsp Causale:</td>
                        <%}
                         else 
                         if (caricaOpzione!= null && caricaOpzione.equals("true"))
                         {%>
                          <td colspan='2' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione:</td>      
                          <td colspan='1' width="50%" class="textB" align="left">&nbsp Tipo Opzione:</td>
                        <%}
                          else
                          {%>
                            <td colspan='3' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione:</td> 
                        <%}
                      }%> 
                    </tr>
                    <tr>    
		                 <td  class="text"> &nbsp
                     <% if (cod_PS==null || des_PS.equals(""))
                     {%>
                     
                           <select class="text" name="comboOggFatt">
                                <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                           </select> 
                           <SCRIPT LANGUAGE='Javascript'> Disable(document.oggFattForm.comboOggFatt)</SCRIPT>

                     <% }
                         else
                        {
                     %>
                     <!--aaaa-->
                        
                     <!--AAAAA FINE-->    
                          <%
                            
                            
                            //Collection oggfatt= homeOggFatt.findOggFatt(cod_PS);
                            //Object[] objs=oggfatt.toArray();
                            if ((oggfatt!=null)&&(oggfatt.size()!=0))
                            {
                                                           
                              // Visualizzo elementi
                             %>
                               <select class="text" title="Classe Oggetto di Fatturazione" name="comboOggFatt" onchange='caricaCausaleTipoOpz()'>
                                <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                               <%
                                for (int i=0; i<oggfatt.size(); i++)
                                {
                                  
                                  OggFattBMP obj=(OggFattBMP)objs1[i];
                                  
                                  String sel="";
                                  
                                  if((oggFattSelez!=null) && (oggFattSelez.equals(obj.getCodeOggFatt()))) 
                                      sel="selected";
                                                                     
                                    %>
                                     
                                     <option value="<%=obj.getCodeOggFatt()%>" <%=sel%>><%=obj.getDescOggFatt()%></option>
                                     
                                     <%
                                     
                                  }//for
                               %> 
                               </select>
                              
                              

                              
                             <!--DAQUI-->
                                  <%
                                for (int i=0; i<oggfatt.size(); i++)
                                {
                                  
                                  OggFattBMP obj=(OggFattBMP)objs1[i];
                                  
                                %>
                                     <input type="hidden" name=ccof   id=ccof value=<%=obj.getCodeCOf()%>> 
                                <%
                                  }//for
                                  if (oggfatt.size()==1)
                                  {
                                    OggFattBMP obj=(OggFattBMP)objs1[0];
                                %>
                                  <input type="hidden" name=ccof   id=ccof value="-2"> 
                                <%}%>
                             <!--AQUI-->
                              
<%   
                              }
                            else
                            {
                              des_PS = "";
                              cod_PS = null;
                              
                                
                              // Visualizzo solo [Seleziona Opzione]
%>
                               <select class="text" name="comboOggFatt">
                                    <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                               </select>
                               <SCRIPT LANGUAGE="JavaScript">
                                  document.oggFattForm.des_PS.value = "";
                                  //03-03-03Disable(document.oggFattForm.btnPS);
                                  Disable(document.oggFattForm.comboOggFatt);
                               </SCRIPT>
<%
                              }//else
%>
<%
                         } //(cod_PS==null || des_PS.equals(""))
                         %>
                        </td> 
                        <td  colspan='2' class="text"> &nbsp
                        
                        <% if (caricaCausale!= null && caricaCausale.equals("true")){
                             if ((classFatts2!=null)&&(classFatts2.size()!=0))
                             {
                                
                              // Visualizzo elementi
                              %>
                               
                               <select class="text" name="comboCausale" onchange='abilitaCampiResidui()'>   
                                  <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                               <%
                               for(Enumeration e = classFatts2.elements();e.hasMoreElements();)
                                  {
                                  CausaleElem elem2=new CausaleElem();
                                  elem2=(CausaleElem)e.nextElement();
                                  String sel="";
                                  if (causaleSelez!=null && causaleSelez.equals(elem2.getCodeTipoCausFat())) 
                                       sel="selected";
                                    %>
                                     <option value="<%=elem2.getCodeTipoCausFat()%>" name="<%=elem2.getDescTipoCausFat()%>" <%=sel%>><%=elem2.getDescTipoCausFat()%></option>
                                     <%
                                 }//for
                               %>  
                               </select>
                               <%
                               }//if (classFatts2!=null)&&(classFatts2.size()!=0)
                               else 
                                {
                                
                               %>
                                  <select class="text" name="comboCausale">
                                     <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                                  </select>
                                  <SCRIPT LANGUAGE="JavaScript">
                                     Disable(document.oggFattForm.comboCausale);
                                  </SCRIPT>

                      <%
                              }//else aggiunto da me
                      } //(caricaCausale!= null && caricaCausale.equals("true"))
                      /*********************************************************************/
                      //modifiche opzioni inizio 18-02-03
                      else
                         if (caricaOpzione!= null && caricaOpzione.equals("true"))
                         {
                            //classOpzioniTariffa = remoteOpzioniTariffa.getOpz();
                            if ((classOpzioniTariffa!=null)&&(classOpzioniTariffa.size()!=0))
                             {
                              // Visualizzo elementi
                              %>

                               <select class="text" name="comboOpzioneTariffa" onchange='abilitaCampiResidui()'>   
                                  <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                               <%
                               for(Enumeration e = classOpzioniTariffa.elements();e.hasMoreElements();)
                                  {
                                  OpzioniElem elem_opz =new OpzioniElem();
                                  elem_opz = (OpzioniElem)e.nextElement();
                                  String sel_opz="";
                                  if (opzioneSelez!=null && opzioneSelez.equals(elem_opz.getCodeOpzione())) 
                                       sel_opz="selected";
                                    %>
                                     <option value="<%=elem_opz.getCodeOpzione()%>" name="<%=elem_opz.getDescOpzione()%>" <%=sel_opz%>><%=elem_opz.getDescOpzione()%></option>
                                     <%
                                 }//for
                               %>  
                               </select>
                               <%
                               }//if (classOpzioniTariffa!=null)&&(classOpzioniTariffa.size()!=0)
                               else 
                                {
                                
                               %>
                                  <select class="text" name="comboOpzioneTariffa">
                                     <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                                  </select>
                                  <SCRIPT LANGUAGE="JavaScript">
                                     Disable(document.oggFattForm.comboOpzioneTariffa);
                                  </SCRIPT>
                      <%
                               }//else aggiunto da me
                      } //(caricaOpzione!= null && caricaOpzione.equals("true"))
                      
                      //modifiche opzioni fine 18-02-03
                      /*********************************************************************/
                      
                      if ((caricaCausale== null || caricaCausale.equals("false")) && (caricaOpzione== null || caricaOpzione.equals("false")))
                      { %>
                          <SCRIPT LANGUAGE='Javascript'>
                          if(isie)
                          {
                              if (document.oggFattForm.caricaCausale.value=="true")
                                   nascondi(document.oggFattForm.comboCausale);
//                            //nascondi(document.oggFattForm.causale); //03-03-03
                              //modifiche opzioni inizio 18-02-03
                              if (document.oggFattForm.caricaOpzione.value=="true")
                                   nascondi(document.oggFattForm.comboOpzionTariffa);
                              //modifiche opzioni fine 18-02-03


                          }
                          </SCRIPT>
                          
                      <% }%>
                          
                      </td>
                    </tr>
                  <tr><td colspan='3' >&nbsp; </td>  </tr>
              </table> <!--TABELLA_8_FINE-->
            </td>
          </tr>
        </table> <!--TABELLA_5_FINE-->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"> <!--TABELLA_9-->
        <tr>
          <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
      </table> <!--TABELLA_9_FINE-->
<!--Valeria 09-10-02 inizio -->
</td></tr></table>
</td></tr> </table> <!--così ho chiuso tabella 4 e 1-->
<!--riapro tabella_1_intermedia-->
<table align="center" width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1_INTERMEDIA-->
<tr><td>
                <sec:ShowButtons PageName="ListaTariffeSp1" />
</td></tr>
</table> <!--TABELLA_1_INTERMEDIA_FINE-->
<!--ora riapro tabella 1 e 4 -->
<%if((caricaLista!= null) && (caricaLista.equals("true")))
 {
  if ((tariffe!=null) && (tariffe.size()>0))
  {
    %>

<table align="center" width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1_NUOVA-->
      <tr>
       <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
     <tr>
  	  <td>
      <table width="90%" border="0" cellspacing="0" cellpadding="1" align = "center" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_10-->
         <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" align = "center" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_11-->
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tariffe</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table> <!--TABELLA_11_FINE-->
          </td>
        </tr>
         </table> <!--TABELLA_10_FINE-->
 	    <table width="90%" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_Valeria_prova-->
       <tr>
          <td>
            <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_12-->
              <tr>
                <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/body/pixel.gif" width="1" height='2'></td>
              </tr>
      <!--
      qui va il puntamento al bean
      -->
            <%
               //tariffe=homeTariffa.findAll(cod_PS,oggFattSelez,causaleSelez);
               if (tariffe!=null) 
                 session.setAttribute("tariffe", tariffe);
             %>
                 <tr>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Min Cl. Sc.</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Max Cl. Sc.</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo tariffa (Euro)</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Importo</td>
                    <td colspan='2' bgcolor='<%=StaticContext.bgColorTestataTabella%>' class="white">&nbsp;</td>
                 </tr>
            <%
            //}
            %>
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=tariffe.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <%
                   String bgcolor="";
                   String checked;
                   boolean flg_first=true; //18-03-03
                   Object[] objs=tariffe.toArray();
                   for (int i=0;i<tariffe.size();i++)
                   {
                     TariffaBMP obj=(TariffaBMP)objs[i];
                     if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                     else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                    if(flg_first)
                    {%>
                      <input type="hidden" name=prog_tar  id=prog_tar  value="<%=obj.getProgTar()%>">
                      <input type="hidden" name=cod_tar   id=cod_tar   value="<%=obj.getCodTar()%>">
                  <%}%>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' value='<%=obj.getCodTar()%>' <%if (flg_first) {out.print("checked");flg_first=false;} %> onclick="ChangeSel('<%=obj.getCodTar()%>','<%=obj.getProgTar()%>')">
                        </td>
                        <!--MMM 24/10/02 CustomNumberFormat.setToCurrencyFormat(obj.get***().toString(),4)-->
                        <td bgcolor='<%=bgcolor%>' class='text'><%=CustomNumberFormat.setToNumberFormat(obj.getImpMinSps().toString(),4,false,true)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=CustomNumberFormat.setToNumberFormat(obj.getImpMaxSps().toString(),4,false,true)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=CustomNumberFormat.setToNumberFormat(obj.getImpTar().toString(),4,false,true)%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getFlgMat()%></td>  
                        <td colspan='2' bgcolor="<%=bgcolor%>" class="white">&nbsp;</td>  
                      </tr>
                 <%    
                    }//for
                 %>
                    <tr>
                      <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../image/pixel.gif" width="3" height='2'></td>
                    </tr>
                <pg:index>
                         <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="7" class="text" align="center">
                                Risultati Pag.
                          <pg:prev> 
                                <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
                          </pg:prev>
    
                          <pg:pages>

                                <% 
                                if (pageNumber == pagerPageNumber) 
                                  {
                                %>
                                  <b><%= pageNumber %></b>&nbsp;
                                <% 
                                  }
                               else
                                  {
                                %>
                                  <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                                
                          </pg:pages>
                          <pg:next>
                                 <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>

                            </td>
                          </tr>
                </pg:index>
                </pg:pager>
          </td>
        </tr>
      </table> <!--TABELLA_12_FINE-->
    </td>
  </tr>
  </table> <!--Tabella_Valeria_prova_fine-->
<!--</table>--> <!--TABELLA_1_NUOVA_FINE-->  
<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0"> <!---->  
    <tr>
      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>    
    </tr>
    <tr>
      <td> <sec:ShowButtons VectorName="bottoni" /> </td>
    </tr>        
</table>
</table> <!--PROVA-->

<%
  }//(tariffe!=null) && (tariffe.size()>0)
}//((caricaLista!= null) && (caricaLista.equals("true")))
%>

 </FORM>
</BODY>

</HTML>
