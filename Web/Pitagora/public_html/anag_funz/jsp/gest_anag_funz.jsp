<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.ejb.*,com.ejbSTL.*,com.ejbSTL.impl.*, com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"gest_anag_funz.jsp")%>
</logtag:logData>
<%

  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
    //-----------------------------------------------------------
    //                                Dichiarazioni
    //---------------------------------------------------------------------------------    
  I5_6ANAG_FUNZ_ROW riga = null;
  String bgcolor="";
    //Se valorizzato ad uno indica che la pagina e richiamata dalla pagina di cancellazione 
    //e bisogna dare un avviso all'utente 
    //Numero delle righe presenti su tabella
  int j=0;
      //Individua l'operazione che stiamo effetuando
      //                     con valore = 0 Inserimento
      //                     con valore = 1 Modifica
      //                     con valore = 2 pagina richiamata da elimina 
  String strOperazione = "";
    //Parametro in ingresso con valore = 0i pagina richiamata da Inserimento
    //Parametro in ingresso con valore = 0m pagina richiamata da  Modifica    
   
  String strProvenienza = null;
    //Codice della classe di sconto che stiamo inserendo/modificando
  String CODE_FUNZ = null;
    //Data Inizio della classe di sconto che stiamo inserendo/modificando
  String txtCodeFunz = null;
  String txtCodiceFunz = null;
    //Array contenti i dati presentati all'interno della tabella
  String txtDescFunz  = null;
  String  txtTipoFunz  =null;
  String Tipo_Funzione =null;
  String flag_sys =null;
  String strTitolo=null;

    //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtnumPag=request.getParameter("txtnumPag");
  String txtCodRicerca = request.getParameter("txtCodRicerca");
  String selCODE_FUNZ =null;
 
  strProvenienza = request.getParameter("strProvenienza");  

  
   if (strProvenienza.equals("0i")){    
    strTitolo="Inserimento";
   }else if (strProvenienza.equals("0m")){    
     strTitolo="Aggiornamento";
   }else {  
    strTitolo="Cancellazione";
   }
%>  
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">

<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var objForm=window.document.frmDati;  


function ONANNULLA()
{
  window.close();

}
function ONCONFERMA()
{
<%
  if (strProvenienza.equals("2")){    
%>
  Cancella();
<%
  }else{
%>        
  Salva();
<%      
  }
%>    
}   

function Cancella()
{
   document.frmDati.submit();
} 

function Salva()
 { 
  var objForm=window.document.frmDati; 
  
  if (objForm.txtCodiceFunz.value=="")
  {
    alert('Il Codice Funzione è obbligatorio');
    objForm.txtCodiceFunz.focus();
    return(false);
  }
  if  (objForm.txtDescFunz.value=="")
  {
    alert('La Descrizione Funzione  è obbligatoria');
    objForm.txtDescFunz.focus();
    return(false);
  }
  if (objForm.flag_sys1.checked)
    objForm.flag_sys.value="C";
  else
  {
    if (objForm.flag_sys2.checked)
      objForm.flag_sys.value="S";
    else
      objForm.flag_sys.value="";
  }    
  if (confirm('Si conferma l\'<%=strTitolo%> della Funzionalità')==true)
  {
    window.document.frmDati.submit();
  }
  
}
function gestclick(check)
{
  if (check==1)
    document.frmDati.flag_sys2.checked=false;
  else
    document.frmDati.flag_sys1.checked=false;
}

</SCRIPT>


<TITLE><%=strTitolo%> Funzionalità</TITLE>
</HEAD>
<BODY>
<form name="frmDati" method="post" action='salva_funz.jsp'>
<EJB:useHome id="home" type="com.ejbSTL.I5_6ANAG_FUNZHome" location="I5_6ANAG_FUNZ" />
<EJB:useBean id="funzioni" type="com.ejbSTL.I5_6ANAG_FUNZ" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<input type="hidden" name="txtnumRec" value="<%=txtnumRec%>">
<input type="hidden" name="numRec" value="<%=NumRec%>">
<input type="hidden" name="txtnumPag" value="<%=txtnumPag%>">
<input type="hidden" name="flag_sys" value="">
<%
if (strProvenienza.equals("0i"))
{    
  strOperazione="0";
  CODE_FUNZ = "";
  txtDescFunz= "";
  txtTipoFunz="O";
  flag_sys="";
}
else
{   
  if (strProvenienza.equals("0m"))
  {
    strOperazione="1";
  }
  else
  {  
    strOperazione="2";  
  }
  CODE_FUNZ = request.getParameter("CodSel"); 
  txtTipoFunz = request.getParameter("tipo_funz"); 
  String Filtro =  request.getParameter("chkClsDisatt");

  riga = funzioni.loadFunz(CODE_FUNZ);              
  txtDescFunz = riga.getDESC_FUNZ();
  txtTipoFunz = riga.getTIPO_FUNZ();
  flag_sys    = riga.getFLAG_SYS();
  if(flag_sys==null)
    flag_sys="";   
}
String sParametri= "&txtnumRec=" + txtnumRec;
sParametri= sParametri + "&txtCodiceFunz=" + CODE_FUNZ;
%>
<% 
if (txtCodRicerca != null) 
{
%>
<input type="hidden" name="txtCodRicerca" value="<%=txtCodRicerca%>">
<%
}
%>
<input type="hidden" name="strOperazione" value="<%=strOperazione%>">          
<input type="hidden" name="txtFlag" value="">          
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td><img src="../images/gestfunz.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#0A6B98">
              <tr>
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%=strTitolo%> Funzionalità</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table  align = center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
        <tr> 
          <td  class="textB" align=right width="40%">Codice Funzione:&nbsp;</td>
          <td  class="text" align=left width="60%"> 
<% 
if (strOperazione.equals("0"))
{
%>
            <input type="text" class="text" name="txtCodiceFunz"  maxlength="30" size="30">
<%
}
else
{
%>
            <input type="hidden" name="txtCodiceFunz" value="<%=CODE_FUNZ%>">
<%
              out.println(CODE_FUNZ);
}
%>
          </td>
        </tr>
        <tr> 
          <td  class="textB" align=right width="35%">Descrizione Funzione:&nbsp;</td>
          <td  class="text" align=left width="65%"> 
<%
if(strOperazione.equals("2"))
{
            out.println(txtDescFunz);
}
else
{
%>
            <input type="text" class="text" name="txtDescFunz"  value="<%=txtDescFunz%>"  maxlength="30" size="30" >
<%}%> 
        </tr>
        <tr>
          <td colspan='2' class="textB">&nbsp;</td>
        </tr>
<%
String CheckPrima="";
String CheckSeconda="";
String strValore=""; 
if(txtTipoFunz.equals("O"))
{
  CheckPrima="checked";
  strValore="ONLINE";
}
else
{
  CheckSeconda="checked";  
  strValore="BATCH";  
}
if(strOperazione.equals("2"))
{
%>
        <tr>
          <td  class="textB" align="right" width="40%">Tipo Funzione:&nbsp;</td>
          <td  class="text" align="left" width="60%">
            <%=strValore%>
          </td>
        </tr>
<%
}
else
{
%>        
        <tr>
          <td  rowspan="2" class="textB" align="right" width="40%">Tipo Funzione:&nbsp;</td>
          <td  class="text" align="left" width="60%">
            <input type="radio" name="Tipo_Funzione" value="O" <%=CheckPrima%>  > ONLINE
          </td>
        </tr>
        <tr>
          <td  class="text" align="left" width="60%">
            <input type="radio" name="Tipo_Funzione" value="B" <%=CheckSeconda%> > BATCH
          </td>
        </tr>
<%
}
%>                
        <tr>        
          <td colspan='2' class="textB">&nbsp;</td>
        </tr>
<%
if(flag_sys.equals("C"))
{
  CheckPrima="checked";
  CheckSeconda="";  
  strValore="Classic";
}
else
{
  if(flag_sys.equals("S"))
  {
    CheckPrima="";
    CheckSeconda="checked";  
    strValore="Special";  
  }
  else
  {
    CheckPrima="";
    CheckSeconda="";  
    strValore="";  
  }
}
if(strOperazione.equals("2"))
{
%>        
        <tr>
          <td  class="textB" align="right" width="40%">Provenienza:&nbsp;</td>
          <td  class="text" align="left" width="60%"><%=strValore%></td>
        </tr>
<%
}
else
{
%>
        <tr>
          <td  rowspan="2" class="textB" align="right" width="40%">Provenienza:&nbsp;</td>
          <td  class="text" align="left" width="60%">
            <input type="checkbox" name="flag_sys1"  <%=CheckPrima%> value="C" onclick="javascript:gestclick(1);"> Classic
          </td>
        </tr>
        <tr>
          <td  class="text" align="left" width="60%">
            <input type="checkbox" name="flag_sys2" <%=CheckSeconda%> value="S" onclick="javascript:gestclick(2);"> Special
          </td>
        </tr>            
<%
}
%>
      </table>
    </td>
    
    
  </tr>

  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  
    <td>
      <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
    </td>
  </tr>
</table>
</form>

</BODY>
</HTML>
