<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_agg_sconto_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  
    //Gestione Paramteri Navigazione
  String CodSel = request.getParameter("CodSel");
  int operazione = Integer.parseInt(request.getParameter("operazione"));  
  //Parametro in ingresso con valore = 0 pagina richiamata da nuovo 
  //                     con valore = 1 pagina richiamata da aggiorna 
  //                     con valore = 2 pagina richiamata da elimina 
  String strQueryString = request.getQueryString();
  String strTitolo =null;
 

  String code_sconto = null;
  String desc_sconto= null;
  Integer valo_perc_sconto=null; 
  java.math.BigDecimal valo_decr_tariffa =null;
  code_sconto = request.getParameter("CodSel");

  // Gestione del Titolo
  if (operazione==0)
  {    
      strTitolo="Inserimento Sconto";
  }  
  else if (operazione==1)
  {  
      strTitolo="Aggiornamento Sconto";
  }    
  else if (operazione==2)
  {
      strTitolo="Cancellazione Sconto";
  }

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  PITAGORA - FATTURAZIONE NON TRAFFICO - Direzione Generale
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>



<script language="javascript">
var operazione=<%=operazione%>

function impostaFocus()
{

  for(var i=0;i<document.forms[0].elements.length;i++)
  {
      if(document.forms[0].elements[i].type=="text")
      {      
        document.forms[0].elements[0].focus();
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
      Salva();
}   

function ONELIMINA()
{
    if (confirm('Si conferma la cancellazione dello Sconto?')==true)
    {
       window.document.frmDati.submit();
    }
}
function Salva()
{
  if (operazione==2) {
    if (confirm('Si conferma la cancellazione dello Sconto?')==true)
    {
       window.document.frmDati.submit();
    }
    return;
  }  
  if(document.frmDati.desc_sconto.value.length==0){
    alert('La descrizione Sconto è obbligatoria.');
    document.frmDati.desc_sconto.focus();
    return;
  }
  if(document.frmDati.valo_perc_sconto.value.length>0 && document.frmDati.valo_decr_tariffa.value.length>0)
  {
    alert('Deve essere valorizzato un solo campo: Valore di Decremento oppure Percentuale di Sconto.');
    document.frmDati.valo_decr_tariffa.focus();
    return;
  }
  if(document.frmDati.valo_perc_sconto.value.length==0 && document.frmDati.valo_decr_tariffa.value.length==0)
  {
    alert('Deve essere valorizzato almeno un campo: Valore di Decremento oppure Percentuale di Sconto.');
    document.frmDati.valo_decr_tariffa.focus();
    return;
  }
  // controlli su percentuale di sconto
  if(!CheckNum(document.frmDati.valo_perc_sconto.value,3))
  {
    alert('La Percentuale di sconto deve essere un intero.');
    window.document.frmDati.valo_perc_sconto.focus();
    return;
  }
  if(parseInt(document.frmDati.valo_perc_sconto.value)>100 || parseInt(document.frmDati.valo_perc_sconto.value)<0)
  {
    alert('La Percentuale di Sconto deve essere compresa tra 0 e 100.');
    document.frmDati.valo_perc_sconto.focus();
    return;
  }
  if(!CheckNum(document.frmDati.valo_decr_tariffa.value,18,6,false))
  {
    alert('Il formato del campo Valore di Decremento deve essere composto\nal massimo da dodici cifre intere e sei decimali');
    window.document.frmDati.valo_decr_tariffa.focus();
    return;
  }
  if (operazione==1) {
    if (confirm('Si conferma l\'aggiornamento dello Sconto?')==true)
    {
       window.document.frmDati.submit();
    }
    return;
  }  
  if (operazione==0) {
    if (confirm('Si conferma l\'inserimento dello Sconto?')==true)
    {
       window.document.frmDati.submit();
    }
    return;
  }
  
  alert("ok")
}

</script>
<body onLoad="impostaFocus()">
<form name="frmDati" method="post" action='salva_sconto_cl.jsp?<%=strQueryString%>'>
<!--<input type="hidden" name="operazione" value="<%=operazione%>">-->                       
<EJB:useHome id="home" type="com.ejbSTL.I5_2SCONTO_CLHome" location="I5_2SCONTO_CL" />  
<EJB:useBean id="sconto" type="com.ejbSTL.I5_2SCONTO_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<% 
  if (operazione!=0) // aggiornamento e cancellazione
  {    
       I5_2SCONTO_CL_ROW riga = sconto.loadSconto(code_sconto);
       desc_sconto = riga.getDescSconto();
       valo_perc_sconto = riga.getPercSconto();
       valo_decr_tariffa = riga.getDecremento();  
  }  
  else// inserimento
  {  
      code_sconto = "";
      desc_sconto= "";
      valo_perc_sconto=null; 
      valo_decr_tariffa =null;
  }    




%>
<!--<input type="hidden" name="strQueryString" value="<%=strQueryString%>">-->
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/sconti.gif" alt="" border="0"></td>
  <tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
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
        <td  class="textB" align="left">Descrizione Sconto</td>
        <% if ( operazione==0 ){ %>        
            <td  class="text" align="left"><input type="text" class="text" name="desc_sconto" maxlength="50" size="30" ></td>                
        <%}else if (operazione==1){ %>
            <td  class="text" align="left"><input type="text" class="text" name="desc_sconto" value="<%=desc_sconto%>" maxlength="50" size="30">
            <input type="hidden" name="code_sconto" value=<%=code_sconto%>></td>        
        <% } else if (operazione==2){ %>
            <td  class="text" align="left"><%=desc_sconto%><input type="hidden" name="code_sconto" value=<%=code_sconto%>></td>        
        <% } %>
      </tr>   
      <tr>
        <td  class="textB" align="left">Valore di Decremento</td>
        <% if(operazione!=2){ %> 
            <% if ( valo_decr_tariffa==null ){ %>        
                <td  class="text" align="left"><input type="text" class="text" name="valo_decr_tariffa" maxlength="19" size="30"></td>                
            <%}else{ %>
                <td  class="text" align="left"><input type="text" class="text" name="valo_decr_tariffa" maxlength="19" size="30" value="<%=valo_decr_tariffa.toString().replace('.',',')%>"></td>        
            <% } 
           } else if (operazione==2){ 
               if ( valo_decr_tariffa==null ){ %>        
                <td  class="text" align="left">&nbsp;</td>                
            <%}else{ %>
                <td  class="text" align="left"><%=valo_decr_tariffa.toString().replace('.',',')%></td>        
            <% }         
          } %>
      </tr>   
      <tr>
        <td  class="textB" align="left">Percentuale di Sconto</td>      
        <% if(operazione!=2){ %> 
            <% if ( valo_perc_sconto==null ){ %>        
                <td  class="text" align="left"><input type="text" class="text" name="valo_perc_sconto" maxlength="3" size="30"></td>                
            <%}else{ %>
                <td  class="text" align="left"><input type="text" class="text" name="valo_perc_sconto" maxlength="3" size="30" value="<%=valo_perc_sconto%>"></td>        
            <% } 
           } else if (operazione==2){ 
               if ( valo_perc_sconto==null ){ %>        
                <td  class="text" align="left">&nbsp;</td>                
            <%}else{ %>
                <td  class="text" align="left"><%=valo_perc_sconto.toString().replace('.',',')%></td>        
            <% }         
          } %>

      </tr>            
        
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
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