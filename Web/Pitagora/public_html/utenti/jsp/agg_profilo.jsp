<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"agg_profilo.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  I5_6PROF_UTENTE_ROW riga = null;

  String strMessaggioFunz="";
  

    //Gestione Paramteri Navigazione
  String CodSel = request.getParameter("CodSel");
  int operazione = Integer.parseInt(request.getParameter("operazione"));  
  //Parametro in ingresso con valore = 0 pagina richiamata da nuovo 
  //                     con valore = 1 pagina richiamata da aggiorna 
  //                     con valore = 2 pagina richiamata da elimina 
  String strQueryString = request.getQueryString();
  String strTitolo =null;
 

  String            CODE_PROF_UTENTE =null;
  String            DESC_PROF_UTENTE =null;
  
  CODE_PROF_UTENTE = request.getParameter("CodSel");

  // Gestione del Titolo
  if (operazione==0)
  {    
      strTitolo="Inserimento Profili Utente";
  }  
  else if (operazione==1)
  {  
      strTitolo="Modifica Profili Utente";
  }    
  else if (operazione==2)
  {
      strTitolo="Cancellazione Profili Utente";
  }  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  Gestione profilo
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>

<script language="javascript">
var operazione=<%=operazione%>

function impostaFocus()
{

  for(var i=0;i<document.forms[0].elements.length;i++)
  {
      if(document.forms[0].elements[i].type=="text")
      {      
        document.forms[0].elements[i].focus();
        break;
      }
  }
}   



function ONANNULLA()
{
   window.close();
}   
function ONCONFERMA()
{
    if(operazione==2)
    {
      Cancella();
    }
    else
    {
      Salva();
    }
}   

function Cancella()
{
   document.frmDati.submit();
} 


function Salva()
{
  var esiste = (document.forms[0].CODE_PROF_UTENTE)? true:false;
  if(esiste){
    if(document.frmDati.CODE_PROF_UTENTE.value.length==0){
      alert('Il Codice Profilo è obbligatorio.');
      document.frmDati.CODE_PROF_UTENTE.focus();
      return;
    } 
  }
  if(document.frmDati.DESC_PROF_UTENTE.value.length==0){
    alert('La Descrizione del Profilo è obbligatoria.');
    document.frmDati.DESC_PROF_UTENTE.focus();
    return;
  } 
  window.document.frmDati.submit();

}

</script>
<body onLoad="impostaFocus()">
<form name="frmDati" method="post" action='salva_profilo.jsp?<%=strQueryString%>'>
<EJB:useHome id="home" type="com.ejbSTL.I5_6PROF_UTENTEejbHome" location="I5_6PROF_UTENTEejb" />
<EJB:useBean id="profili" type="com.ejbSTL.I5_6PROF_UTENTEejb" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<% 
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  if (operazione!=0) // aggiornamento
  {    
    riga = profili.loadProfilo(CODE_PROF_UTENTE);
    CODE_PROF_UTENTE = riga.getCODE_PROF_UTENTE();
    DESC_PROF_UTENTE = riga.getDESC_PROF_UTENTE();
  }  
%>
<!--<input type="hidden" name="strQueryString" value="<%=strQueryString%>">-->
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/gestprofutenti.gif" alt="" border="0"></td>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
						<tr>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;<%= strTitolo %></td>
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
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="left">Codice Profilo:</td>
        <td  class="text" align="left">
        <%if(operazione==0){%>
            <input type="text" class="text" name="CODE_PROF_UTENTE" maxlength="3" size="10">
        <%}else{out.println(CODE_PROF_UTENTE);%>
            <input type="hidden" name="CODE_PROF_UTENTE" value="<%=CODE_PROF_UTENTE%>">
        <%}%>
        </td>                
      </tr>
      <tr>
        <td  class="textB" align="left">Descrizione Profilo:</td>
        <td  class="text" align="left">
        <%if(operazione==2){out.println(DESC_PROF_UTENTE);}else{%>
          <input type="text" class="text" name="DESC_PROF_UTENTE" maxlength="50" size="30" value="<%if(operazione==1){out.println(DESC_PROF_UTENTE);}%>">
        <%}%>          
        </td>                
      </tr>   

    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='10'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>
</BODY>
</HTML>