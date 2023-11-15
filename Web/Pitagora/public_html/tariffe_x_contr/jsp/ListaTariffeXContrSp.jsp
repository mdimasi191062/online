<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*" %>

<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottoni" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Tariffe")%>
<%=StaticMessages.getMessage(3006,"ListaTariffeXContrSp.jsp")%>
</logtag:logData>


<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_tipo_contr=request.getParameter("codiceTipoContratto");
if (cod_tipo_contr==null) cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");

//Valeria 02-10-02
String prog_tar=request.getParameter("prog_tar");
if (prog_tar==null) prog_tar=request.getParameter("prog_tar");
if (prog_tar==null) prog_tar=(String)session.getAttribute("prog_tar");


String hidFlagSys=request.getParameter("hidFlagSys");
if (hidFlagSys==null) hidFlagSys=request.getParameter("hidFlagSys");
if (hidFlagSys==null) hidFlagSys=(String)session.getAttribute("hidFlagSys");


//String des_contratto=request.getParameter("des_tipo_contr");
String des_tipo_contr=request.getParameter("hidDescTipoContratto");
if (des_tipo_contr==null) des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");
//FINE

String cod_tar = request.getParameter("cod_tar");
String cod_PS   = request.getParameter("cod_PS");
//if (cod_PS==null) cod_PS=(String)session.getAttribute("cod_PS");

String des_PS           = request.getParameter("des_PS");
if (des_PS==null) des_PS=(String)session.getAttribute("des_PS");

String desc_tariffa     = request.getParameter("desc_tariffa");
String importo_tariffa  = request.getParameter("importo_tariffa");
String oggFattSelez     = request.getParameter("oggFattSelez");
String clasOggFattSelez = request.getParameter("clasOggFattSelez");
String causaleSelez     = request.getParameter("causaleSelez");
String caricaOggFatt    = request.getParameter("caricaOggFatt");

String caricaCausale    = request.getParameter("caricaCausale");
//if (caricaCausale==null) caricaCausale=(String)session.getAttribute("caricaCausale");


String caricaLista      = request.getParameter("caricaLista");
//if (caricaLista==null) caricaLista=(String)session.getAttribute("caricaLista");

//modifiche opzioni inizio 28-02-03
String opzioneSelez     = request.getParameter("opzioneSelez");
String caricaOpzione    = request.getParameter("caricaOpzione");
String descr_opzione    = request.getParameter("descr_opzione");
//modifiche opzioni fine 28-02-03


String caricaUniMis     = request.getParameter("caricaUniMis");
String misuraDisp       = request.getParameter("misuraDisp");
String richSave         = request.getParameter("richSave");

String contrSelez       = request.getParameter("contrSelez");
//if (contrSelez==null) contrSelez=(String)session.getAttribute("contrSelez");
//System.out.println("contrSelez "+contrSelez);

String des_contr        = request.getParameter("des_contr");
//if (des_contr==null) des_contr=(String)session.getAttribute("des_contr");
if (des_contr==null) des_contr="";

String descr_causale        = request.getParameter("descr_causale");
String cof           = request.getParameter("cof");
int indice=0;


String tipo_pannello= request.getParameter("tipo_pannello");

Vector unitaMisuraV;
Vector classFatts2 = null;


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

// Vettore contenente risultati query per il caricamento della della combo contratti e della lista
Vector contr=null;    
Collection tariffe=null;
//modifiche opzioni inizio 28-02-03
Vector classOpzioniTariffa = null;
//modifiche opzioni fine 28-02-03

//MMMMMMMMMMMMMMMMMMMMM 17/10/02 MMMMMMMMMMMMMMMMMMMMMM
%>
<EJB:useHome id="homeOggFatt" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />
<%
Collection oggfatt=null;
Object[] objs=null;


if ((cod_PS!=null)&&(contrSelez!=null))
{
  oggfatt= homeOggFatt.findOggFatt(contrSelez, cod_PS);
  if (oggfatt!=null)
     objs=oggfatt.toArray();
}
if (caricaCausale!= null && caricaCausale.equals("true"))
{
%>
  <EJB:useHome id="homeCausale" type="com.ejbSTL.CausaleSTLHome" location="CausaleSTL" />
<%
   CausaleSTL remoteCausale= homeCausale.create();
   classFatts2=remoteCausale.getCausTar(cod_tipo_contr, contrSelez, cod_PS,oggFattSelez);
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
      classOpzioniTariffa =remoteOpzioniTariffa.getOpzTarXCliente(contrSelez,oggFattSelez,cod_PS);//05-03-03
      if ((classOpzioniTariffa!=null)&&(classOpzioniTariffa.size()!=0))
         caricaOpzione="true";
   }   
//modifiche opzioni fine 28-02-03

//MMMMMMMMMMMMMMMMMMMMM 17/10/02 fine MMMMMMMMMMMMMMMMMMMMMM

%>
<EJB:useHome id="homeTariffa" type="com.ejbBMP.TariffaXContrBMPHome" location="TariffaXContrBMP" />
<EJB:useHome id="homeContratto" type="com.ejbSTL.ContrattoSTLHome" location="ContrattoSTL" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lista Tariffe </TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/ListaTariffeXContrSp.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>


var codOggFattSel="";
var carCausaleBoolean=true;
var UnitaMisuraDisp=false;
var appoggio;

function handleReturnedValuePS()
{
if ((document.contratto.cod_PS.value==appoggio) || (document.contratto.cod_PS.value=="" && appoggio=="null"))
  {
      Disable(document.contratto.des_PS);
  }
  else
  {
    if (document.contratto.cod_PS.value=="")
    {
      //da qui
      if (document.contratto.comboOggFatt.selectedIndex==0)
      {
        selezione=-1;
      }
      else
      {
       selezione=document.contratto.ccof[document.contratto.comboOggFatt.selectedIndex-1].value;
      }
    //a qui
    
      document.contratto.caricaLista.value="false";
      if (document.contratto.caricaCausale.value=="true")
      { 
      // document.contratto.causaleSelez.value=document.contratto.comboCausale.value;
      document.contratto.causaleSelez.value=document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value;
      }

      //modifica opzioni 28-02-03 inizio
      if (document.contratto.caricaOpzione.value=="true")
      { 
          document.contratto.opzioneSelez.value=document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value;
      }
      //modifica opzioni 28-02-03 fine
      
      Enable(document.contratto.des_PS);
      Enable(document.contratto.comboOggFatt);

      //document.contratto.oggFattSelez.value=document.contratto.comboOggFatt.value;
      document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value;

//DA QUI      
      document.contratto.contrSelez.value=document.contratto.contratti[document.contratto.contratti.selectedIndex].value;
      Enable(document.contratto.btnPS);

      document.contratto.clasOggFattSelez.value=selezione;
      document.contratto.oggFattSelez.value="";
      Disable(document.contratto.POPOLALISTA);
      document.contratto.submit();
    }
    else
    {
// da qui
      document.contratto.contrSelez.value=document.contratto.contratti[document.contratto.contratti.selectedIndex].value;
    
       document.contratto.oggFattSelez.value="";
       document.contratto.caricaCausale.value="false";
       //modifica opzioni 28-02-03 inizio
       document.contratto.caricaOpzione.value="false";
       //modifica opzioni 28-02-03 fine
       cod_PS_appoggio=document.contratto.cod_PS.value;
       des_PS_appoggio=document.contratto.des_PS.value;
       //ONANNULLA();
       document.contratto.cod_PS.value=cod_PS_appoggio;
       document.contratto.des_PS.value=des_PS_appoggio;
       Enable(document.contratto.cod_tipo_contr);
       Enable(document.contratto.cod_PS);
       Enable(document.contratto.des_PS);
       document.contratto.submit();
     }  
  }
 }


function selezionaPs()
{
  
  appoggio=document.contratto.cod_PS.value;
  Disable(document.contratto.des_PS);
  var stringa="../../tariffe_x_contr/jsp/ProdServXContrSp.jsp?cod_tipo_contr="+<%=cod_tipo_contr%>+"&cod_contr="+document.contratto.contrSelez.value+"&des_tipo_contr="+"<%=des_tipo_contr%>"+"&des_contr="+document.contratto.des_contr.value+"&chiamante=<%="ListaTariffeXContrSp"%>";
  openDialog(stringa, 750, 400, handleReturnedValuePS);
}

function ChangeSel(cod1,cod2)
{
  document.contratto.cod_tar.value=cod1;
  document.contratto.prog_tar.value=cod2;
}

function handleReturnedValueDett()
{
}

function ONDETTAGLI()
{
   if ( (document.contratto.cod_tar.value!="")&&(document.contratto.cod_tar.value!=null)) 
   {
     codtarSel=document.contratto.cod_tar.value; //18-03-03
     var stringa="../../tariffe_x_contr/jsp/DettaglioTariffaXContrSp.jsp?cod_tar="+codtarSel+"&contrSelez="+document.contratto.contrSelez.value+"&cod_ogg_fatt=<%=oggFattSelez%>&cod_causale=<%=causaleSelez%>&cod_opzione=<%=opzioneSelez%>";
     openDialog(stringa, 700, 400, handleReturnedValueDett);
   }  
}

function ONDISATTIVA()
{
  document.contratto.tipo_pannello.value="DIS";
  Enable(document.contratto.tipo_pannello);
  Enable(document.contratto.des_PS);
  Enable(document.contratto.descr_estesa_ps);
  Enable(document.contratto.cod_tipo_contr);
  Enable(document.contratto.contrSelez);
  Enable(document.contratto.cod_PS);
  Enable(document.contratto.oggFattSelez);
  Enable(document.contratto.cod_tar);
  Enable(document.contratto.prog_tar);
  Enable(document.contratto.des_tipo_contr);  
  document.contratto.action="ElabTariffaXContrSp.jsp";
  document.contratto.submit();
}

function ONCANCELLA()
{
  document.contratto.tipo_pannello.value="CAN";
  Enable(document.contratto.tipo_pannello);
  Enable(document.contratto.des_PS);
  Enable(document.contratto.descr_estesa_ps);
  Enable(document.contratto.cod_tipo_contr);
  Enable(document.contratto.contrSelez);
  Enable(document.contratto.cod_PS);
  Enable(document.contratto.oggFattSelez);
  Enable(document.contratto.cod_tar);
  Enable(document.contratto.prog_tar);
  Enable(document.contratto.des_tipo_contr);  
  document.contratto.action="ElabTariffaXContrSp.jsp";
  document.contratto.submit();
}

function ONAGGIORNA()
{
  document.contratto.tipo_pannello.value="AGG";
  Enable(document.contratto.tipo_pannello);
  Enable(document.contratto.des_PS);
  Enable(document.contratto.descr_estesa_ps);
  Enable(document.contratto.cod_tipo_contr);
  Enable(document.contratto.contrSelez);
  Enable(document.contratto.cod_PS);
  Enable(document.contratto.oggFattSelez);
  Enable(document.contratto.des_tipo_contr);  
  Enable(document.contratto.cod_tar);
  Enable(document.contratto.prog_tar);
  document.contratto.action="ElabTariffaXContrSp.jsp";
  document.contratto.submit();
}

function ONVISUALIZZA()
{
  document.contratto.tipo_pannello.value="VIS";
  Enable(document.contratto.tipo_pannello);
  Enable(document.contratto.des_PS);
  Enable(document.contratto.descr_estesa_ps);
  Enable(document.contratto.cod_tipo_contr);
  Enable(document.contratto.contrSelez);
  Enable(document.contratto.cod_PS);
  Enable(document.contratto.oggFattSelez);
  Enable(document.contratto.des_contr);  
  Enable(document.contratto.cod_tar);
  Enable(document.contratto.prog_tar);
  Enable(document.contratto.des_tipo_contr);  
  document.contratto.action="ElabTariffaXContrSp.jsp";
  document.contratto.submit();
}


function ONPOPOLALISTA()
{
 
 if ((isie)||((isnn)&&(check_form())))
 {
     if (document.contratto.comboOggFatt.selectedIndex==0)
     {
        selezione=-1;
     }
     else
     {
       selezione=document.contratto.ccof[document.contratto.comboOggFatt.selectedIndex-1].value;
     }
    
    document.contratto.caricaLista.value="true";

    if (document.contratto.caricaCausale.value=="true")
    {
      document.contratto.causaleSelez.value=document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value;
    }
    //modifiche opzione tariffa 28-02-03 inizio
    if (document.contratto.caricaOpzione.value=="true")
    {
      document.contratto.opzioneSelez.value=document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value;
    }
     //modifiche opzione tariffa 28-02-03 fine

    
      Enable(document.contratto.des_PS);
      Enable(document.contratto.comboOggFatt);
      document.contratto.oggFattSelez.value=document.contratto.comboOggFatt[document.contratto.comboOggFatt.selectedIndex].value;
//da qui
      document.contratto.contrSelez.value=document.contratto.contratti[document.contratto.contratti.selectedIndex].value;

      document.contratto.clasOggFattSelez.value=selezione;
      document.contratto.submit();
   }
}

function setInitialValue()
{
     document.contratto.tipo_pannello.value='null';
     Disable(document.contratto.des_PS);
     if (document.contratto.contratti.selectedIndex==0)
     {
        document.contratto.des_PS.value="";
        Disable(document.contratto.btnPS);
     }   
     else
         Enable(document.contratto.btnPS);

     if ((document.contratto.comboOggFatt.disabled)||(document.contratto.comboOggFatt.value==-1))
        Disable(document.contratto.POPOLALISTA);
     else
       Enable(document.contratto.POPOLALISTA);
     

     if (document.contratto.caricaCausale.value=="true")
     {  
      if ((document.contratto.comboOggFatt.disabled)||(document.contratto.comboCausale[document.contratto.comboCausale.selectedIndex].value==-1))
      {      
       Disable(document.contratto.POPOLALISTA);
      }       
     }    
     //modifiche opzione tariffa 28-02-03 inizio
     if (document.contratto.caricaOpzione.value=="true")
     {  
      if ((document.contratto.comboOggFatt.disabled)||(document.contratto.comboOpzioneTariffa[document.contratto.comboOpzioneTariffa.selectedIndex].value==-1))
         Disable(document.contratto.POPOLALISTA);
     }      
     //modifiche opzione tariffa 28-02-03 fine   
}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<%
if (
    (typeLoad!=0)||
    (contrSelez!=null) &&
    ( tipo_pannello==null || (tipo_pannello!=null)&&!(tipo_pannello.equalsIgnoreCase("CAN")))
)
   {
     contr = (Vector) session.getAttribute("contr");
   }
   else
   {  
      ContrattoSTL remoteContratto= homeContratto.create();
      contr=remoteContratto.getContratti(cod_tipo_contr);
      if (contr!=null)
           session.setAttribute("contr", contr);
   }

if ((tipo_pannello!=null)&&((tipo_pannello.equalsIgnoreCase("CAN"))||(tipo_pannello.equalsIgnoreCase("AGG"))||(tipo_pannello.equalsIgnoreCase("DIS"))))
  caricaLista="true";
if ((caricaLista!= null) && (caricaLista.equals("true")))
{
     tariffe=homeTariffa.findAll(contrSelez,cod_PS,oggFattSelez,causaleSelez,opzioneSelez); //03-03-03
}%>


<FORM name="contratto" method="post" action="ListaTariffeXContrSp.jsp">
<input type="hidden" name=cod_PS            id=cod_PS             value="<%=cod_PS%>">
<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value="<%=cod_tipo_contr%>">
<input type="hidden" name=caricaCausale     id=caricaCausale      value= "<%=caricaCausale%>">
<input type="hidden" name=caricaLista       id=caricaLista        value= "<%=caricaLista%>">
<input type="hidden" name=caricaUniMis      id=caricaUniMis       value= "<%=caricaUniMis%>"> 
<input type="hidden" name=oggFattSelez      id= oggFattSelez      value= "<%=oggFattSelez%>"> 
<input type="hidden" name=contrSelez        id= contrSelez        value= "<%=contrSelez%>">
<input type="hidden" name=des_contr         id= des_contr         value= "<%=des_contr%>">
<input type="hidden" name=clasOggFattSelez  id= clasOggFattSelez  value= "<%=clasOggFattSelez%>"> 
<input type="hidden" name=causaleSelez      id= causaleSelez      value= "<%=causaleSelez%>"> 
<input type="hidden" name=misuraDisp        id= misuraDisp        value= "<%=misuraDisp%>"> 
<input type="hidden" name=richSave          id= richSave          value= "<%=richSave%>"> 
<input type="hidden" name=des_tipo_contr    id= des_tipo_contr    value= "<%=des_tipo_contr%>"> 
<input type="hidden" name=descr_estesa_ps   id= descr_estesa_ps   value="<%=des_PS%>"> 
<input type="hidden" name=descr_causale     id=descr_causale      value="<%=descr_causale%>">
<input type="hidden" name=tipo_pannello     id= tipo_pannello     value="<%=tipo_pannello%>">
<input type="hidden" name=hidFlagSys        id= hidFlagSys        value="<%=hidFlagSys%>">

<!--modifica opzioni 03-03-03 inizio-->
<input type="hidden" name=caricaOpzione     id=caricaOpzione      value= <%=caricaOpzione%>>
<input type="hidden" name=opzioneSelez      id= opzioneSelez      value= <%=opzioneSelez%>> 
<input type="hidden" name=descr_opzione     id= descr_opzione     value="<%=descr_opzione%>">
<!--modifica opzioni 03-03-03 inizio-->


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1-->
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
                          <td   width="50%" class="textB" align="left">&nbsp;&nbsp;Tipo contratto:&nbsp;</td>

                      <td   width="50%" class="textB" align="left">&nbsp;Contratto:&nbsp;</td>
                      <td >  &nbsp; </td>
                    </tr>
                     <tr>
                         <td width="50%" class="text" align="left">&nbsp;&nbsp; <%=des_tipo_contr%>&nbsp;</td>        
                   <%if ((contr==null)||(contr.size()==0))
                    {
                      
                    %>
                      <td  width="50%" class="text">&nbsp;
                         <select class="text"  name="contratti" >
					                 <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
					              </select>
                        <SCRIPT LANGUAGE='Javascript'> Disable(document.contratto.contratti); </script>
                      </td>
                    <%}
                      else
                      {
                        
                      %>
                      <td  width="50%" class="text">
                          &nbsp;<select class="text" title="Contratti" name="contratti" onchange='carContratto()'>
                               <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                               <%
                               
                                Object[] objs1=contr.toArray();
                                for (Enumeration e = contr.elements();e.hasMoreElements();)
                                {
                                  
                                  ContrattoElem elem2=new ContrattoElem();
                                  elem2=(ContrattoElem)e.nextElement();
                                  String selez="";
                                  
                                  if(contrSelez!=null && contrSelez.equals(elem2.getCodeContratto())) 
                                  {
                                      selez="selected";
                                  }
                                                                    
                                    %>
                                     <option value="<%=elem2.getCodeContratto()%>" name="<%=elem2.getDescContratto()%>"  <%=selez%>><%=elem2.getDescContratto()%></option>
                                    <%
                                  }//for
                               %> 
                               </select>
                              <!--DAQUI-->
                              <input type="hidden" name=des  id=des value="-2"> 
                                  <%
                                for (Enumeration e = contr.elements();e.hasMoreElements();)
                                {
                                  
                                  ContrattoElem elem2=new ContrattoElem();
                                  elem2=(ContrattoElem)e.nextElement();
                                                                  
                                %>
                                     <input type="hidden" name=des  id=des value="<%=elem2.getDescContratto()%>"> 
                                <%
                                  }//for
                                %> 
                             <!--AQUI-->


                               
                            </td>   
                      <%}//else%>
                      <td>
						            &nbsp;
						          </td>
                     </tr>
                     </table> <!--TABELLA_7_FINE-->
                     
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>"> <!--TABELLA_8-->
                    <tr>
                      <td colspan='3' width="50%" class="textB" align="left">&nbsp P/S:&nbsp;</td>
                    </tr>
                    <tr>
                      <td  width="25%" class="text">
                            <% if (cod_PS==null){ des_PS="";}%>
                            &nbsp;&nbsp;<input class="text" type="TEXT" name="des_PS" id= "des_PS" size="60%" value="<%=des_PS%>"> 
                              <SCRIPT LANGUAGE='Javascript'> 
                                 Disable(document.contratto.des_PS);
                              </script>
                      </td>

                           <td    width="25%" class="text"> &nbsp; 
                             <input class="text" type="button" name="btnPS" value="..."   onclick='selezionaPs();'>&nbsp; 
                           </td>
                     

                       <td  class="text" width="25%">
												&nbsp;
						           </td>
                    </tr>
                </table> <!--TABELLA_8_FINE-->

                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>"> <!--TABELLA_9-->
                    <tr>
                      
                      <% if ((caricaCausale==null ||  caricaCausale.equals("false")) && (caricaOpzione==null || caricaOpzione.equals("false"))){ %>
                       <td colspan='3' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione</td> 
                      <%
                      } else 
                      {
                        if (caricaCausale!= null && caricaCausale.equals("true"))
                        {%>
                          <td colspan='2' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione:</td>      
                          <td colspan='1' width="50%" class="textB" align="left">&nbsp Causale:</td>
                        <%}//03-03-03-inizio}
                         else 
                         if (caricaOpzione!= null && caricaOpzione.equals("true"))
                         {%>
                          <td colspan='2' width="50%" class="textB" align="left">&nbsp Oggetto di fatturazione:</td>      
                          <td colspan='1' width="50%" class="textB" align="left">&nbsp Tipo Opzione:</td>
                        <%}//03-03-03-fine
                          else
                          {
                          %>
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
                           <SCRIPT LANGUAGE='Javascript'> Disable(document.contratto.comboOggFatt); </script>
                     <%}
                      else
                      { 
                      //Collection oggfatt= homeOggFatt.findOggFatt(contrSelez, cod_PS);
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
                                  OggFattBMP obj=(OggFattBMP)objs[i];
                                  String sel="";
                                  if((oggFattSelez!=null) && (oggFattSelez.equals(obj.getCodeOggFatt()))) 
                                      sel="selected";%>
                                     <option value="<%=obj.getCodeOggFatt()%>" <%=sel%>><%=obj.getDescOggFatt()%></option>
                               <%}//for%> 
                               </select>
                              
                             <!--DAQUI-->
                                  <%
                                for (int i=0; i<oggfatt.size(); i++)
                                {
                                  
                                  OggFattBMP obj=(OggFattBMP)objs[i];
                                  
                                %>
                                     <input type="hidden" name=ccof   id=ccof value=<%=obj.getCodeCOf()%>> 
                                <%
                                  }//for
                                  if (oggfatt.size()==1)
                                  {
                                    OggFattBMP obj=(OggFattBMP)objs[0];
                                %>
                                  <input type="hidden" name=ccof   id=ccof value="-2"> 
                                <%}%>
                             <!--AQUI-->
                              
                              <%   
                              }
                            else
                              {
                                
                              // Visualizzo solo [Seleziona Opzione]
                              %>
                               <select class="text" name="comboOggFatt" >
                                   <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(30)%></option>
                               </select>
                               <SCRIPT LANGUAGE='Javascript'> Disable(document.contratto.comboOggFatt); </script>
                              <%
                              }//else
                          %>
                         <%
                         } //(cod_PS==null || des_PS.equals(""))
                         %>
                        </td> 
                        <td  colspan='2' class="text"> &nbsp
                        
                        <% if (caricaCausale!= null && caricaCausale.equals("true"))
                        {
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
                                   <SCRIPT LANGUAGE='Javascript'> Disable(document.contratto.comboCausale); </script>
                      <%
                              }//else aggiunto da me
                      } //(caricaCausale!= null && caricaCausale.equals("true"))
                      //modifiche opzioni inizio 03-03-03
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
                                     Disable(document.contratto.comboOpzioneTariffa);
                                  </SCRIPT>
                      <%
                               }//else aggiunto da me
                      } //(caricaOpzione!= null && caricaOpzione.equals("true"))
                      
                      /*********************************************************************/
                      if ((caricaCausale== null || caricaCausale.equals("false")) && (caricaOpzione== null || caricaOpzione.equals("false")))
                      { //modifiche opzioni fine 03-03-03 %>
                         
                          <SCRIPT LANGUAGE='Javascript'>
                          if(isie)
                          {
                              if (document.contratto.caricaCausale.value=="true")
                                    nascondi(document.contratto.comboCausale);
                              //modifiche opzioni inizio 03-03-03
                              if (document.contratto.caricaOpzione.value=="true")
                                   nascondi(document.contratto.comboOpzionTariffa);
                              //modifiche opzioni fine 03-03-03
                          }
                          </SCRIPT>
                          
                      <% }//else%>
                          
                      </td>
                    </tr>
                  <tr><td colspan='3' >&nbsp; </td>  </tr>
              </table> <!--TABELLA_9_FINE-->
            </td>
          </tr>
        </table> <!--TABELLA_5_FINE-->
        <!--DA QUI-->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'> <!--TABELLA_10-->
          <tr>
           <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
         </tr>
       </table> <!--TABELLA_10_FINE-->
<!--Valeria 08-10-02 inizio -->
</td></tr></table> <!--TABELLA_4_FINE-->
</td></tr></table> <!--TABELLA_1_FINE--> <!--così ho chiuso tabella 4 e 1-->
<!--riapro tabella_1_intermedia-->
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1_INTERMEDIA-->
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
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_1_NUOVA-->
      <tr>
       <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
      <tr>
  	  <td>
      <table width="90%" border="0" cellspacing="0" cellpadding="1" align = "center" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_11-->
         <tr>
          <td>
            <table width="100%" border="0" cellspacing="0"  align = "center" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_12-->
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Tariffe</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table> <!--TABELLA_12_FINE-->
          </td>
        </tr>
      </table> <!--TABELLA_11_FINE-->
      <table width="90%" border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_Valeria_prova-->
       <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0" align = "center" bgcolor="<%=StaticContext.bgColorHeader%>"> <!--TABELLA_13-->
              <tr>
                <td colspan='7' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/image/body/pixel.gif" width="1" height='3'></td>
              </tr>
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
                   Object[] objs2=tariffe.toArray();

                   boolean  caricaDesc=true;
                     %>
                  <input type="hidden" name=tariffeSize id=tariffeSize value="<%=tariffe.size()%>">
                <%
                   for (int i=0;i<tariffe.size();i++)
                   {
                     TariffaXContrBMP obj=(TariffaXContrBMP)objs2[i];
                     if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                     else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;%>
                    <%if(flg_first)
                    {%>
                      <input type="hidden" name=prog_tar  id=prog_tar  value="<%=obj.getProgTar()%>">
                      <input type="hidden" name=cod_tar   id=cod_tar   value="<%=obj.getCodTar()%>">
                  <%}%>
                       <tr>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelOf' value='<%=obj.getCodTar()%>' <%if (flg_first) {out.print("checked");flg_first=false;} %> onclick="ChangeSel('<%=obj.getCodTar()%>','<%=obj.getProgTar()%>')">
                        </td>
                        <%
                         if (caricaDesc)
                         {
                          caricaDesc=false;%>
                         <%}%>
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

             </table> <!--TABELLA_13_FINE -->
          </td>
        </tr>
        </table> <!--Tabella_Valeria_prova_fine-->
</table> <!--TABELLA_1_NUOVA_FINE-->


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0"> <!--TABELLA_BOTTONI-->  
    <tr>
      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>    
    </tr>
    <tr>
      <td> <sec:ShowButtons VectorName="bottoni" /> </td>
    </tr>        
</table> <!--TABELLA_BOTTONI_FINE-->  

<%
  }//(tariffe!=null) && (tariffe.size()>0)
}//((caricaLista!= null) && (caricaLista.equals("true")))
%>
 </FORM>
</BODY>
</HTML>
