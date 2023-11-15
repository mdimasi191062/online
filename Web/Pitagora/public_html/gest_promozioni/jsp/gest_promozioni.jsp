<%@ include file="../../common/jsp/gestione_cache.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,javax.swing.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vectorButton" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"gest_promozioni.jsp")%>
</logtag:logData>

<EJB:useHome id="home" type="com.ejbSTL.I5_2PROMOZIONIHome" location="I5_2PROMOZIONI" />  
<EJB:useBean id="promo" type="com.ejbSTL.I5_2PROMOZIONI" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeClasseFatt" type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
<EJB:useHome id="homeOggFatt" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />

<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive" />
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
    <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>" />
</EJB:useBean>
<%
  Vector servizi_vect=null;
  Vector servizi =null;  
  servizi_vect = promo.getServizi();

  //ServiziElem
  
  Vector classFatt_vect=null;
  ClasseFattSTL remoteClasseFatt= homeClasseFatt.create();
  classFatt_vect=remoteClasseFatt.getCfs();
  
  String messaggio = "";
  String strPromo = request.getParameter("strPromo");
  String operazione = Misc.nh(request.getParameter("operazione"));  
  String offset = Misc.nh(request.getParameter("pager.offset"));
  String serviziSel = request.getParameter("serviziSel"); 
  String oggFattSel = request.getParameter("oggFattSel"); 
  
  
  

  if(operazione.equals("D"))
  {
        
        int ret = promo.eliminaPromo(strPromo);
        if (ret==0) 
        {
           messaggio = "Eliminazione eseguita correttamente.";
        }
        else
        {
           messaggio = "La promozione selezionata non puo' essere eliminata in queanto gia' associata al listino.";
        }
        operazione="";
  }
 String txtDescPromoTMP = ""; 
 String comboTipoPromoTMP = ""; 
 String oggFattComboTMP = ""; 
 String txtValoreTMP = ""; 
 String comboStoredProcedureTMP = ""; 
  
    //Vector servizi = promo.getServiziXPromo(request.getParameter("codicePromo"));
  if(operazione.equals("M"))
  {
    //Enable(formPag.Modifica);
    txtDescPromoTMP = request.getParameter("txtDescPromoH");  
    comboTipoPromoTMP = request.getParameter("comboTipoPromoH");
    oggFattComboTMP = request.getParameter("oggFattComboH");
    txtValoreTMP =request.getParameter("txtValoreH");
    comboStoredProcedureTMP = request.getParameter("comboStoredProcedureH");
    try {
    servizi = promo.getServiziXPromo(strPromo);
     }
    catch (Exception e) {}
  }
  
  if(operazione.equals("A"))
  {
  
    txtDescPromoTMP = request.getParameter("txtDescPromo");  
    comboTipoPromoTMP = request.getParameter("comboTipoPromo");
    oggFattComboTMP = request.getParameter("txtFattCombo");
    txtValoreTMP =request.getParameter("txtValore");
    comboStoredProcedureTMP = request.getParameter("comboStoredProcedure");
    String txtServiziSel = request.getParameter("txtServiziSel");
    
    
    
    
    I5_2PROMOZIONI_ROW row = new I5_2PROMOZIONI_ROW();
    row.setCODE_PROMOZIONE(0);
    row.setDESCRIZIONE(java.net.URLDecoder.decode(txtDescPromoTMP,com.utl.StaticContext.ENCCharset));
    row.setSTORED_PROCEDURE(java.net.URLDecoder.decode(comboStoredProcedureTMP,com.utl.StaticContext.ENCCharset));
    try {
        row.setTIPO_PROMOZIONE(Integer.parseInt(comboTipoPromoTMP.replace(',','.')));
    } catch (Exception e) {
        response.sendRedirect("messaggio.jsp?messaggio=txtTipoPromo-"+comboTipoPromoTMP+"-"+ java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
    }
    try {
        row.setVALORE(Float.parseFloat(txtValoreTMP.replace(',','.')));
    } catch (Exception e) {
        response.sendRedirect("messaggio.jsp?messaggio=txtValore-" + java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
    }
    boolean ret;
    try {
    ret = promo.checkPromizioni(row);
    }
    catch (Exception e) { ret= false;}
    if(!ret)
        { 
        txtDescPromoTMP = request.getParameter("txtDescPromo");  
    comboTipoPromoTMP = request.getParameter("comboTipoPromo");
    oggFattComboTMP = request.getParameter("txtFattCombo");
    txtValoreTMP =request.getParameter("txtValore");
    comboStoredProcedureTMP = request.getParameter("comboStoredProcedure");
    txtServiziSel = request.getParameter("txtServiziSel");
        %>
        <form name="formPag" method="post">
<input type=hidden name="strPromo" value="">
<input type=hidden name="txtDescPromo" value="<%=txtDescPromoTMP%>">
<input type=hidden name="comboTipoPromo" value="<%=comboTipoPromoTMP%>">
<input type=hidden name="oggFattCombo" value="<%=oggFattComboTMP%>">
<input type=hidden name="txtValore" value="<%=txtValoreTMP%>">
<input type=hidden name="operazione" value="<%=operazione%>">
<input type=hidden name="comboStoredProcedure" value="<%=comboStoredProcedureTMP%>">
<input type=hidden name="txtServiziSel" value="<%=txtServiziSel%>">
<input type=hidden name="txtFattCombo" value="<%=oggFattComboTMP%>">
</form>
            <SCRIPT LANGUAGE="JavaScript">
            window.document.formPag.operazione.value = "A1";
            window.document.formPag.action = "gest_promozioni.jsp";
            window.document.formPag.submit();
            </SCRIPT><%}
        else
        {
        try {
            ret = promo.insertPromizioni(row);
            }
            catch (Exception e) { ret= false;}
         if(!ret)
         {
           response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Impossibile inserire la promozione",com.utl.StaticContext.ENCCharset));
         }   
         else
         {
           int i=0;
           String[] serviziSelezionati = txtServiziSel.split("_");
           for ( i=0;i<serviziSelezionati.length;i++) {
              try {
              promo.insertPromizioniOF(0,Integer.parseInt(oggFattComboTMP),Integer.parseInt(serviziSelezionati[i]));
              }
                catch (Exception e) { }
              }
           }
            txtDescPromoTMP = "";
     }
     
    }

if (operazione.equals("A2")){
    boolean ret;
        txtDescPromoTMP = request.getParameter("txtDescPromoH");  
    comboTipoPromoTMP = request.getParameter("comboTipoPromoH");
    oggFattComboTMP = request.getParameter("txtFattCombo");
    txtValoreTMP =request.getParameter("txtValoreH");
    comboStoredProcedureTMP = request.getParameter("comboStoredProcedureH");
    //txtServiziSel = request.getParameter("txtServiziSel");
    
    try {
        I5_2PROMOZIONI_ROW row = new I5_2PROMOZIONI_ROW();
        row.setCODE_PROMOZIONE(0);
        row.setDESCRIZIONE(java.net.URLDecoder.decode(txtDescPromoTMP,com.utl.StaticContext.ENCCharset));
        row.setSTORED_PROCEDURE(java.net.URLDecoder.decode(comboStoredProcedureTMP,com.utl.StaticContext.ENCCharset));
        try {
            row.setTIPO_PROMOZIONE(Integer.parseInt(comboTipoPromoTMP.replace(',','.')));
        } catch (Exception e) {
            response.sendRedirect("messaggio.jsp?messaggio=txtTipoPromo-"+comboTipoPromoTMP+"-"+ java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
        }
        try {
            row.setVALORE(Float.parseFloat(txtValoreTMP.replace(',','.')));
        } catch (Exception e) {
            response.sendRedirect("messaggio.jsp?messaggio=txtValore-" + java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
        }    
           ret = promo.insertPromizioni(row);
    }
    catch (Exception e) { ret= false;}
         if(!ret)
         {
           response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Impossibile inserire la promozione",com.utl.StaticContext.ENCCharset));
         }   
         else
         {
           int i=0;
           String txtServiziSel = request.getParameter("txtServiziSel");
           String[] serviziSelezionati = txtServiziSel.split("_");
           for ( i=0;i<serviziSelezionati.length;i++) {
              try {
              promo.insertPromizioniOF(0,Integer.parseInt(oggFattComboTMP),Integer.parseInt(serviziSelezionati[i].replace("null","")));
              }
                catch (Exception e) { }
              }
           
     } 
     
     txtDescPromoTMP = "";
  }
if(operazione.equals("A1"))
  {  
  txtDescPromoTMP = request.getParameter("txtDescPromo");  
    comboTipoPromoTMP = request.getParameter("comboTipoPromo");
    oggFattComboTMP = request.getParameter("txtFattCombo");
    txtValoreTMP =request.getParameter("txtValore");
    comboStoredProcedureTMP = request.getParameter("comboStoredProcedure");
    String txtServiziSel = request.getParameter("txtServiziSel");
  %>

<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
 <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
        

<SCRIPT  LANGUAGE="JavaScript" >
function conf() 
{
window.document.formPag.operazione.value="A2";
window.document.formPag.submit();
}
function esci() 
{
window.document.formPag.operazione.value="";
window.document.formPag.submit();
}

</SCRIPT>
<BODY bgColor="#ffffff" text="#000000">

 <form name="formPag" method="post">
          
    
<input type=hidden name="strPromo" value="">
<input type=hidden name="txtDescPromoH" value="<%=txtDescPromoTMP%>">
<input type=hidden name="comboTipoPromoH" value="<%=comboTipoPromoTMP%>">
<input type=hidden name="oggFattComboH" value="<%=oggFattComboTMP%>">
<input type=hidden name="txtValoreH" value="<%=txtValoreTMP%>">
<input type=hidden name="operazione" value="A2">
<input type=hidden name="comboStoredProcedureH" value="<%=comboStoredProcedureTMP%>">
<input type=hidden name="txtServiziSel" value="<%=txtServiziSel%>">
<input type=hidden name="txtFattCombo" value="<%=oggFattComboTMP%>">
</form>
<TABLE border="0" cellPadding="0" cellSpacing="0" width="100%" >
  <TR>
    <td valign="top"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0" width="500" align="center">
        <TR>
          <TD vAlign="top" width="80"><IMG border="0"  src="../../common/images/body/info.gif" ></TD>
        <TR>
      </TABLE>

      <TABLE bgColor="#006699" border="0" cellPadding="1" cellSpacing="0" width="502" align="center">
        <TR>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="502">
              <TR>
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; Promozione</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="../../common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="500" align="center">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <td align='left' class='white'>&nbsp;
                    <BR>La seguente Promozione è già esistente : 
                    <BR>&nbsp;
                    <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo Promozione&nbsp; : <%=comboTipoPromoTMP%>
                    <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Valore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <%=txtValoreTMP%>
                    <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stored Procedure : <%=comboStoredProcedureTMP%>
                    <BR>&nbsp;
                    <BR>si vuole procedere comunque all'inserimento ?
                    <BR>&nbsp;</td>
                <TD>&nbsp;</TD>
              </TR>

            </TABLE>
          </TD>
          <TD><IMG align="right" src="../../common/images/body/log3.gif"></TD>
        </TR>
      </TABLE>
      <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
                 <td align="center">
                    <img src="Images/pixel.gif" width="1" height='1'>
	        </td>
	      </tr>

	      <tr>
                <td class="textB" bgcolor="#D5DDF1" align="center">
                
                    <input class="textB" type="button" name="Conferma" value="Conferma" onclick = "conf();">
                    <input class="textB" type="button" name="Indietro" value="Annulla" onclick = "esci();">
	        </td>
	      </tr>
         </table>

    </TD>
  </TR>
</TABLE>

   
     
<%
    } 
if(operazione.equals("V"))
  {
    String[] serviziSelezionati = serviziSel.split(";");
    int ret , retTotale = 0;
    for (int i=0;i<serviziSelezionati.length;i++) {
       ret = promo.modificaPromo(strPromo,serviziSelezionati[i],oggFattSel);
       retTotale = retTotale + ret;
       }
        if (retTotale==0) 
        {
           messaggio = "Variazione eseguita correttamente.";
        }
        else
        {
           messaggio = "La variazione non è stata eseguita correttamente.";
        }    
        operazione="";
  }  
I5_2PROMOZIONI_ROW[] aRemote = null;
// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;

String strNumRec=null;

  strNumRec = request.getParameter("numRec");

if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

String cod_tipo_contr="";
String des_tipo_contr="";
String checkvalue="";
int index=0;

Vector promozioni = promo.findAll();
Vector tipiPromozioni = promo.findTipiAll();
Vector storedPromozioni = promo.findStoredAll();
%>

<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

function inizializza(){
  orologio.style.visibility='hidden';
  orologio.style.display='none';
        
}

function RESET()
{
        document.formPag.operazione.value = "";
        document.formPag.action = "gest_promozioni.jsp";
        document.formPag.submit();
}
function ONAGGIUNGI()
{ 
    if ( document.formPag.oggFattCombo.value == '-1' ) {
        alert("La classe dell'oggetto di fatturazione è obbligatoria.");
        document.formPag.oggFattCombo.focus();
        return;
    }
    var trovato = false;
    for (var i=0;i<document.formPag.oggServizi.length;i++)
      {
        if ((document.formPag.oggServizi[i].selected) && (!(document.formPag.oggServizi[i].value == '-1')))
        {
            trovato = true;
        }
      }
    
    if  (!trovato)  {
        alert("Selezionare almeno un servizio.");
        document.formPag.oggServizi.focus();
        return;
    }
    
    if ( document.formPag.txtDescPromo.value == '' ) {
        alert('La Descrizione della Promozione è obbligatoria.');
        document.formPag.txtDescPromo.focus();
        return;
    }

    if (document.formPag.comboTipoPromo.selectedIndex==0)
    {
        alert('La Tipologia della Promozione è obbligatoria.');
        document.formPag.comboTipoPromo.focus();
        return;
    }

    if ( document.formPag.txtValore.value == '' ) {
        alert('Il Valore è obbligatorio.');
        document.formPag.txtValore.focus();
        return;
    }
    
    if (document.formPag.comboTipoPromo.value >= 1 ) {  
        //Float
        var val = parseFloat(document.formPag.txtValore.value.replace(',','.'));
        if(isNaN(val)) {
            alert("Il Valore non è di tipo decimale.");
            return;
        }
    }

    if (document.formPag.comboStoredProcedure.selectedIndex==0)
    {
        alert('La Procedura di Validazione è obbligatoria.');
        document.formPag.comboStoredProcedure.focus();
        return;
    }
    
    if (confirm("Procedere con l'inserimento della Promozione ?")==true)
    {
      document.formPag.txtServiziSel.value = "";
      for (var i=0;i<document.formPag.oggServizi.length;i++)
      {
        if (document.formPag.oggServizi[i].selected)
        {
            document.formPag.txtServiziSel.value = document.formPag.txtServiziSel.value +encodeURI(document.formPag.oggServizi[i].value) + '_';    
        }
      }
      
               for (var i=0;i<document.formPag.oggFattCombo.length;i++) 
               {
                    
                        if ((document.formPag.oggFattCombo[i].selected) && (!(document.formPag.oggFattCombo[i].value == '-1')))
                        {
                            document.formPag.txtFattCombo.value = document.formPag.oggFattCombo[i].value;
                        }
               }      
      
        document.formPag.operazione.value = "A";
        document.formPag.action = "gest_promozioni.jsp";
        document.formPag.submit();
    }
}
function ELIMINA(strPromo)
{ 

//var varPromo = document.formPag.strPromo.value;
var varPromo = strPromo;
document.formPag.strPromo.value =  strPromo;
if (varPromo == "")
{
    alert("Selezionare la promozione da eliminare");
}
else
{
    var risposta = window.confirm(" Vuoi procedere alla cancellazione della promozione selezionata? ");
    if (risposta) 
    {
        document.formPag.operazione.value = "D";
        document.formPag.action = "gest_promozioni.jsp";
        document.formPag.submit();
    }
}
}
function MODIFICA(strPromo)
{ 
    var varPromo = strPromo;
    document.formPag.strPromo.value =  strPromo;
    
    if (varPromo == "")
    {
        alert("Selezionare la promozione da modificare");
    }
    else
    {
       
        var serviziSel = "";
        var oggFattSel = "";
        for (var i=0;i<document.formPag.oggServizi.length;i++) 
        {
            
                if ((document.formPag.oggServizi[i].selected) && (!(document.formPag.oggServizi[i].value == '-1')))
                {
                    serviziSel = serviziSel + document.formPag.oggServizi[i].value + ";";
                }
        }
        if (serviziSel=="")
        {
               alert("Selezionare almeno un servizio da associare alla promozione.");
               return;
        }
        var risposta = window.confirm(" Vuoi procedere alla modifica della promozione selezionata? ");
        if (risposta) 
        {
               document.formPag.serviziSel.value =  serviziSel;
            
               for (var i=0;i<document.formPag.oggFattCombo.length;i++) 
               {
                    
                        if ((document.formPag.oggFattCombo[i].selected) && (!(document.formPag.oggFattCombo[i].value == '-1')))
                        {
                            oggFattSel = document.formPag.oggFattCombo[i].value;
                        }
               }
            
               document.formPag.oggFattSel.value =  oggFattSel;
               document.formPag.operazione.value = "V";
               document.formPag.action = "gest_promozioni.jsp";
               document.formPag.submit();
        }
        
        
    }

}

function ChangeSel(codicePromo,descPromo,tipoPromo,valore,stored,fattCombo)
{
    
    document.formPag.txtCodPromo.value=codicePromo;
    document.formPag.strPromo.value=codicePromo;
    document.formPag.txtDescPromoH.value=descPromo;
    document.formPag.comboTipoPromoH.value=tipoPromo;
    document.formPag.oggFattComboH.value=fattCombo;
    document.formPag.txtValoreH.value=valore.replace('.',',');
    document.formPag.comboStoredProcedureH.value=stored;
 
    document.formPag.operazione.value = "M";
    document.formPag.action = "gest_promozioni.jsp?pager.offset=<%=offset%>";
    orologio.style.visibility='visible';
    orologio.style.display='inline';
    document.formPag.submit();
}
</SCRIPT>
<% if (!operazione.equals("A1")){
String txtServiziSel = request.getParameter("txtServiziSel");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title></title>
 <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>
<body onload="inizializza();">
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">
<form name="formPag" method="post">
<input type=hidden name="strPromo" value="">
<input type=hidden name="txtDescPromoH" value="<%=txtDescPromoTMP%>">
<input type=hidden name="comboTipoPromoH" value="<%=comboTipoPromoTMP%>">
<input type=hidden name="oggFattComboH" value="<%=oggFattComboTMP%>">
<input type=hidden name="txtValoreH" value="<%=txtValoreTMP%>">
<input type=hidden name="operazione" value="<%=operazione%>">
<input type=hidden name="comboStoredProcedureH" value="<%=comboStoredProcedureTMP%>">
<input type=hidden name="txtServiziSel" value="<%=txtServiziSel%>">
<input type=hidden name="txtFattCombo" value="<%=oggFattComboTMP%>">

<input type=hidden name="serviziSel" value="">
<input type=hidden name="oggFattSel" value="">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
        <td>
          <table width="95%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%"></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif"></td>
              </tr>
          </table>
        </td>
      </tr>
      </table>
      <br>
      <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr HEIGHT='35px'>
            <td class="textB" >Codice Promozione</td>
            <%
                if (!operazione.equals("M")) {%>
            <td class="text" width="25%"><input type='text' name='txtCodPromo' value="" class="text" readonly="readonly" disabled ></td>
            <% } else { %>
            <td class="text" width="25%"><input type='text' name='txtCodPromo' value="<%=strPromo%>" class="text" readonly="readonly" disabled ></td>
            <% } %>
            <td class="textB" >Descrizione</td>
            <%
                if (!operazione.equals("M")) {%>
            <td class="text" width="50%"><input type='text' name='txtDescPromo' value="<%=txtDescPromoTMP%>" class="text" maxlength=255 size=50></td>
            <% } else { %>
            <td class="text" width="50%"><input readonly="readonly" disabled type='text' name='txtDescPromo' value="<%=txtDescPromoTMP%>" class="text" maxlength=255 size=50></td>
            <% } %>
        </tr>
        <tr HEIGHT='15px'>
            <td class="textB" ></td>
            <td class="text" width="25%"></td>
            <td class="textB" ></td>
            <td class="text" width="50%"></td>
        </tr>
        <tr height="35px">
            <td class="textB">Tipo Promozione</td>
            <td class="text" width="25%">
                
                <%
                if (!operazione.equals("M")) {%>
                    <select name="comboTipoPromo" width="10px" class="text" onchange="" >
                    <option value="-99" Selected>Selezionare Tipo Promozione</option>
                    <% Object[] objsTipi=tipiPromozioni.toArray();
                        for (int i=0;i<tipiPromozioni.size();i++) {
                            I5_2PROMOZIONI_TIPI_ROW objTipo=(I5_2PROMOZIONI_TIPI_ROW)objsTipi[i];
                    %>
                        <option value="<%=objTipo.getTIPO_PROMOZIONE()%>"><%=objTipo.getDESCRIZIONE()%></option>
                    <%}} else {  %>
                        <select readonly="readonly" disabled name="comboTipoPromo" width="10px" class="text" onchange="" >
                    <%  Object[] objsTipi=tipiPromozioni.toArray();
                        for (int i=0;i<tipiPromozioni.size();i++) {
                         
                            I5_2PROMOZIONI_TIPI_ROW objTipo=(I5_2PROMOZIONI_TIPI_ROW)objsTipi[i]; 
                            if (objTipo.getTIPO_PROMOZIONE().toString().equals(comboTipoPromoTMP)){%>
                                <option  Selected value="<%=comboTipoPromoTMP%>"><%=objTipo.getDESCRIZIONE()%></option>
                    <% }else{ %><option  value="<%=comboTipoPromoTMP%>"><%=objTipo.getDESCRIZIONE()%></option> <%} 
                    }}
                    %>
                </select>
            </td>
            <td class="textB" >Valore</td>
            <%
                if (!operazione.equals("M")) {%>
            <td class="text" width="50%"><input type='text' name='txtValore' value="" class="text" maxlength="19" size="19" ></td>
           <% } else { %>
            <td class="text" width="50%"><input readonly="readonly" disabled type='text' name='txtValore' value="<%=txtValoreTMP%>" class="text" maxlength="19" size="19" ></td>
            <% } %>
        </tr>
        <tr HEIGHT='15px'>
            <td class="textB" ></td>
            <td class="text" width="25%"></td>
            <td class="textB" ></td>
            <td class="text" width="50%"></td>
        </tr>
         </table>
        <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr height="35px">
            <td class="textB" >Procedura di Validazione</td>
            <td class="text" width="25%">
                
                
                
                <%
                if (!operazione.equals("M")) {%>
                    <select name="comboStoredProcedure" width="10px" class="text" onchange="" >
                    <option value="0" Selected>Selezionare Procedura di Validazione</option>
                    <% Object[] objsStored=storedPromozioni.toArray();
                        for (int i=0;i<storedPromozioni.size();i++) {
                            I5_2PROMOZIONI_ROW objStored=(I5_2PROMOZIONI_ROW)objsStored[i];
                    %>
                        <option value="<%=objStored.getSTORED_PROCEDURE()%>"><%=objStored.getDESCR_ESTESA()%></option>
                    <%}} else {  %>
                        <select readonly="readonly" disabled name="comboStoredProcedure" width="10px" class="text" onchange="" >
                    <%  Object[] objsStored=storedPromozioni.toArray();
                        for (int i=0;i<storedPromozioni.size();i++) {
                            I5_2PROMOZIONI_ROW objStored=(I5_2PROMOZIONI_ROW)objsStored[i]; 
                            if (objStored.getSTORED_PROCEDURE().equals(comboStoredProcedureTMP)){%>
                                <option  Selected value="<%=comboStoredProcedureTMP%>"><%=objStored.getDESCR_ESTESA()%></option>
                    <% }else{ %><option  value="<%=comboStoredProcedureTMP%>"><%=objStored.getDESCR_ESTESA()%></option> <%} 
                    }}
                    %>
                </select>
                
            </td>
            <td class="textB" ></td>
            <td class="textB" width="50%"></td>
        </tr>
        <!-- combo classe di fatturazione -->
           <tr>
            <td class="textB" >Classe OF:</td>
  	        <td width="25%" class="text"> 
              
               <%
                if (!operazione.equals("M")) {%>
                    <select name="oggFattCombo" class="text" onchange="" >
                    <option value="-1">[Seleziona Opzione]</option>
                    <% 
                        if ((classFatt_vect!=null)&&(classFatt_vect.size()!=0))
                        for(Enumeration e=classFatt_vect.elements();e.hasMoreElements();)
                    {
                       ClasseFattElem elem=(ClasseFattElem)e.nextElement();
                    %>
                        <option value="<%=elem.getCodeClasseOf()%>"><%=elem.getDescClasseOf()%></option>
                    <%}} else {  %>
                        <select readonly="readonly" disabled name="oggFattCombo" class="text" onchange="" >
                    <%  if ((classFatt_vect!=null)&&(classFatt_vect.size()!=0))
                        for(Enumeration e=classFatt_vect.elements();e.hasMoreElements();)
                    {
                       ClasseFattElem elem=(ClasseFattElem)e.nextElement();
                            if (elem.getCodeClasseOf().equals(oggFattComboTMP)){%>
                                <option  Selected value="<%=elem.getCodeClasseOf()%>"><%=elem.getDescClasseOf()%></option>
                    <% }else{ %><option  value="<%=elem.getCodeClasseOf()%>"><%=elem.getDescClasseOf()%></option> <%} 
                    }}
                    %>
                </select>
                
                
            </td>
            <td class="textB" ></td>
            <td class="textB" width="50%"></td>
           </tr>
        <tr HEIGHT='15px'>
            <td class="textB" ></td>
            <td class="text" width="25%"></td>
            <td class="textB" ></td>
            <td class="text" width="50%"></td>
        </tr>
        </table>
        <table width="90%" border="0" cellspacing="0" cellpadding="4" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <!-- combo servizi -->
           <tr>
            <td align="right" class="textB" >Servizi:</td>
  	        <td align="left" width="25%" class="text"> 
               
              
              <%
                if (!operazione.equals("M")) {%>
                    <select align="left" class="text" name="oggServizi" onchange='' multiple size="10">
                    <option value="-1" selected>[Seleziona Servizi]</option>
                    <% 
                        if ((servizi_vect!=null)&&(servizi_vect.size()!=0))
                         for(Enumeration e=servizi_vect.elements();e.hasMoreElements();)
                    {
                      I5_1CONTR elem=(I5_1CONTR)e.nextElement();
                    %>
                        <option value="<%=elem.getCODE_TIPO_CONTR()%>"><%=elem.getDESC_CONTR()%></option>
                    <%}} else {  %>
                        <select align="left" name="oggServizi" class="text"  multiple size="10">
                        <option value="-1">Servizi associabili</option>  
                    <%  boolean trovato = false;
                    if ((servizi_vect!=null)&&(servizi_vect.size()!=0))
                         for(Enumeration e=servizi_vect.elements();e.hasMoreElements();)
                    {
                       I5_1CONTR elem=(I5_1CONTR)e.nextElement();
                         trovato = false;
                         for(Enumeration es=servizi.elements();es.hasMoreElements();) {
                            I5_2PROMOZIONI_ROW item_servizio = (I5_2PROMOZIONI_ROW)es.nextElement();
                            if (elem.getCODE_TIPO_CONTR().equals(item_servizio.getCODE_SERVIZIO())){
                                trovato = true;
                                }
                            }
                            if (!trovato){
                            %>
                                
                               <option value="<%=elem.getCODE_TIPO_CONTR()%>"><%=elem.getDESC_CONTR()%></option> <%} 
                    }
                    
                    }
                    %>
                </select>
            </td>
             <!-- combo servizi scelti -->
               
             
              
              <%
                if (!operazione.equals("M")) {%>
                    <td width="50%" class="text" > </td>
                    <td  class="textB"  >&nbsp;</td>   
                   
                <% } else { %>
                        
                        <td align="right" class="textB"  >Servizi Associati: </td>
                         <td align="left" width="25%" class="text"> 
                        <select readonly="readonly" name="oggServiziASS" class="text"  multiple size="10">
                    <%  boolean trovato = false;
                    if ((servizi_vect!=null)&&(servizi_vect.size()!=0))
                         for(Enumeration e=servizi_vect.elements();e.hasMoreElements();)
                    {
                       I5_1CONTR elem=(I5_1CONTR)e.nextElement();
                         trovato = false;
                         for(Enumeration es=servizi.elements();es.hasMoreElements();) {
                            I5_2PROMOZIONI_ROW item_servizio = (I5_2PROMOZIONI_ROW)es.nextElement();
                            if (elem.getCODE_TIPO_CONTR().equals(item_servizio.getCODE_SERVIZIO())){
                                trovato = true;
                                }
                            }
                            if (trovato){
                            %>
                                
                               <option value="<%=elem.getCODE_TIPO_CONTR()%>"><%=elem.getDESC_CONTR()%></option> <%} 
                    }}
                    %>
                </select>
                
          </td>
            
            <!-- combo servizi scelti -->
               
           </tr>
       <tr>
        <td rowSpan="1" colSpan="6">
          <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Risultati Promozioni</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
          </table>
        </td>
        </tr>

        </table>

    </td>
    </tr>
     <tr>
    <td>


       <table width="90%" align='center' width="100%" border="0" cellspacing="0" cellpadding="6" bgcolor="#CFDBE9">
        <tr>
          <td bgcolor='#D5DDF1' class="textB" width="0%" >&nbsp;</td>      
          <td bgcolor='#D5DDF1' class="textB" width="10%">Codice Promozione</td>
          <td bgcolor='#D5DDF1' class="textB" width="40%">Descrizione</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Tipo Promozione</td>
          <td bgcolor='#D5DDF1' class="textB" width="10%">Valore</td>
          <td bgcolor='#D5DDF1' class="textB" width="30%">Procedura di Validazione</td>          
          <td bgcolor='#D5DDF1' class="textB" width="30%">Oggetto di Fatturazione</td> 
        </tr>

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=promozioni.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>
                <pg:param name="disattivi" value="<%=checkvalue%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
<%
                String bgcolor="";
                String checked;  
                Object[] objs=promozioni.toArray();
                boolean  caricaDesc=true;
%>
                <input type="hidden" name=Nrec id=Nrec value="<%=promozioni.size()%>">
<%

                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<promozioni.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                   {
                    I5_2PROMOZIONI_ROW obj=(I5_2PROMOZIONI_ROW)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                        
                   %>
                       <tr>
                        <td bgcolor="<%=bgcolor%>" width='2%'>
                        <% boolean found = false;
                        if (!operazione.equals("M")) {%>
                        <input bgcolor='<%=bgcolor%>'  type='radio'  name='SelOf' value='<%=obj.getCODE_PROMOZIONE()%>'
                        onclick="ChangeSel('<%=obj.getCODE_PROMOZIONE()%>',
                                                 '<%=obj.getDESCRIZIONE()%>',
                                                 '<%=obj.getTIPO_PROMOZIONE()%>',
                                                 '<%=obj.getVALORE()%>',
                                                 '<%=obj.getSTORED_PROCEDURE()%>',
                                                 '<%=obj.getCODE_CLASSE_OF()%>')"
                        <% } else    { 
                        if (obj.getCODE_PROMOZIONE().toString().equals(strPromo)) {
                            found = true;
                          }}
                          if (!found) {
                          %>
                           <input bgcolor='<%=bgcolor%>'  type='radio'  name='SelOf' value='<%=strPromo%>'
                            onclick="ChangeSel('<%=obj.getCODE_PROMOZIONE()%>',
                                                 '<%=obj.getDESCRIZIONE()%>',
                                                 '<%=obj.getTIPO_PROMOZIONE()%>',
                                                 '<%=obj.getVALORE()%>',
                                                 '<%=obj.getSTORED_PROCEDURE()%>',
                                                 '<%=obj.getCODE_CLASSE_OF()%>')"   
                          <% } else    { found =false;    %>
                          <input checked bgcolor='<%=bgcolor%>'  type='radio'  name='SelOf' value='<%=strPromo%>'
                            onclick="ChangeSel('<%=obj.getCODE_PROMOZIONE()%>',
                                                 '<%=obj.getDESCRIZIONE()%>',
                                                 '<%=obj.getTIPO_PROMOZIONE()%>',
                                                 '<%=obj.getVALORE()%>',
                                                 '<%=obj.getSTORED_PROCEDURE()%>',
                                                 '<%=obj.getCODE_CLASSE_OF()%>')" 
                            <% }    %>
                       </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getCODE_PROMOZIONE()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDESCRIZIONE()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getTIPO_PROMOZIONE()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getVALORE().toString().replace('.',',')%></td> 
                       <!-- <% if (obj.getTIPO_PROMOZIONE() >= 1 ) { %>
                            <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getVALORE().toString().replace('.',',')%></td> 
                        <% } else { %>
                            <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getVALORE()%></td> 
                        <% } %> --> 
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDESCR_ESTESA()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getCLASSE_OF()%></td>
                      </tr>
                <%    
                    }
                %>
                    <tr>
                      <td colspan='6' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="6" class="text" align="center">
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
          </table>
    </td>
    </tr>
</table>
<br>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center">
<% if (operazione.equals("M")){ %>     
        <input class="textB" type="button" name="Elimina" value="Elimina" onclick="ELIMINA('<%=strPromo%>');">
        <input class="textB" type="button"  name="Modifica" value="Modifica" onclick="MODIFICA('<%=strPromo%>');">
        <input class="textB" type="button" name="Pulisci" value="Pulisci Campi" onclick="RESET();">
         <input class="textB" type="button" disabled name="Aggiungi" value="Aggiungi">
<% } else { %>        
        <input class="textB" type="button" disabled name="Elimina" value="Elimina">
        <input class="textB" type="button" disabled name="Modifica" value="Modifica" onclick="MODIFICA();">
        <input class="textB" type="button" disabled name="Pulisci" value="Pulisci Campi">
         <input class="textB" type="button" name="Aggiungi" value="Aggiungi" onclick="ONAGGIUNGI();">
<% } %>        
       
    </td>
  </tr>
</table>
</form>
</div>
</body>
<script>
var http=getHTTPObject();
if(document.formPag.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>
</html>
<%}%>