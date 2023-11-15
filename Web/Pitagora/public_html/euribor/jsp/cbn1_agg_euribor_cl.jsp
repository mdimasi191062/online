<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_agg_euribor_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strMessaggioFunz="";
  I5_2PARAM_VALORIZ_CL_ROW riga = null;
  Float VALO_EURIBOR=null;
  String DATA_CONCAT="";
  String strDATA_INIZIO_CICLO_FATRZ = "";
  String strDATA_FINE_CICLO_FATRZ = ""; 

    //Gestione Paramteri Navigazione
  String CodSel = request.getParameter("CodSel");
  int operazione = Integer.parseInt(request.getParameter("operazione"));  
  //Paremtro in ingresso con valore = 0 pagina richiamata da nuovo Euribor
  //                     con valore = 1 pagina richiamata da aggiorna Euribor
  //                     con valore = 2 pagina richiamata da elimina Euribor
  String strQueryString = request.getQueryString();
  String strTitolo =null;
 

  // Gestione del Titolo
  if (operazione==0)
  {    
      strTitolo="Inserimento Valore Percentuale Euribor";
  }  
  else if (operazione==1)
  {  
      strTitolo="Aggiornamento Valore Percentuale Euribor";
  }    
  else if (operazione==2)
  {
      strTitolo="Cancellazione Valore Percentuale Euribor";
  }

%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<title>
  PITAGORA - FATTURAZIONE NON TRAFFICO
</title>
</head>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>



<script language="javascript">
var operazione=<%=operazione%>

function impostaFocus()
{
   if(operazione!=2)
   {
      document.forms[0].VALO_EURIBOR.focus();
   }
}   



function ONANNULLA()
{
   window.close();
}   
function ONCONFERMA()
{
   if(operazione==2){
      Elimina();
   }
   else{
      Salva();
   }
      
      
}   

function Elimina()
{
    if (confirm('Si conferma la cancellazione del Valore Percentuale Euribor?')==true)
    {
       window.document.frmDati.submit();
    }
}
function Salva()
{
  if(window.document.frmDati.VALO_EURIBOR.value.length==0){
    alert('Il campo Valore Euribor é obbligatorio');
    window.document.frmDati.VALO_EURIBOR.focus();
    return;
  }
  if(parseInt(window.document.frmDati.VALO_EURIBOR.value)==0){
    alert('Il Valore Percentuale Euribor deve essere un valore numerico diverso da zero');
    window.document.frmDati.VALO_EURIBOR.focus();
    return;
  }
  if(parseInt(window.document.frmDati.VALO_EURIBOR.value) < 0)
  {
    alert('Il Valore Percentuale Euribor deve essere un valore numerico positivo');
    window.document.frmDati.VALO_EURIBOR.focus();
    return;
  }
  if(parseInt(window.document.frmDati.VALO_EURIBOR.value)>1000){
    alert('Il formato del Valore Percentuale Euribor deve essere composto al massimo da tre cifre intere e tre decimali');
    window.document.frmDati.VALO_EURIBOR.focus();
    return;
  }  
  if(!CheckNum(window.document.frmDati.VALO_EURIBOR.value,6,3)){
    alert('Il formato del Valore Percentuale Euribor deve essere numerico e composto al massimo da tre cifre intere e tre decimali');
    window.document.frmDati.VALO_EURIBOR.focus();
    return(false);
  }   

  if (operazione==1) {
    if (confirm('Si conferma l\'aggiornamento del Valore Percentuale Euribor?')==true)
    {
       window.document.frmDati.submit();
    }
    return;
  }  
  if (operazione==0) {
    if (confirm('Si conferma l\'inserimento del Valore Percentuale Euribor?')==true)
    {
       window.document.frmDati.submit();
    }
    return;
  }
}

</script>
<body onLoad="impostaFocus()">
<form name="frmDati" method="post" action='gestione_euribor_cl.jsp?<%=strQueryString%>'>
<!--<input type="hidden" name="operazione" value="<%=operazione%>">-->                       
<EJB:useHome id="home" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />  
<EJB:useBean id="eur" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>

<% 
  if (operazione==0) // caso inserimento
  {    
      if (eur.checkxInserimento()==0) // significa che non si può procedere con l'inserimento
      {
        strMessaggioFunz = "Non sono presenti periodi di riferimento validi per poter associare ";
        strMessaggioFunz += "il valore % Euribor. Impossibile effettuare l'inserimento!";
        response.sendRedirect("messaggio_euribor_cl.jsp?a=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
      }
      else
      {
        java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
        riga = eur.loadObjectInsert();
        DATA_CONCAT = riga.getPeriodo_rif();
        strDATA_INIZIO_CICLO_FATRZ = df.format(riga.getData_inizio_ciclo_fatrz());
        strDATA_FINE_CICLO_FATRZ = df.format(riga.getData_fine_ciclo_fatrz());        
      }
  }  
  else // caso modifica e cancellazione
  {  
        I5_2PARAM_VALORIZ_CL_ROW[] aRemote = (I5_2PARAM_VALORIZ_CL_ROW[]) session.getAttribute("aRemote");
        riga = aRemote[Integer.parseInt(CodSel)];
        Float valore = riga.getValo_euribor();
        java.util.Date DATA_INIZIO_CICLO_FATRZ = riga.getData_inizio_ciclo_fatrz();
        java.util.Date DATA_FINE_CICLO_FATRZ = riga.getData_fine_ciclo_fatrz();   
        if(eur.checkBatch()>0)
        {
                strMessaggioFunz = "Attenzione! Impossibile proseguire a causa della presenza di elaborazioni batch in corso.";
                response.sendRedirect("messaggio_euribor_cl.jsp?a=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));        
        }
        if (strMessaggioFunz.equals(""))
        {
               if (eur.checkCongelamento(valore,DATA_INIZIO_CICLO_FATRZ,DATA_FINE_CICLO_FATRZ)>0)
              {
                        strMessaggioFunz = "Il valore Percentuale Euribor non può essere aggiornato in quanto è stato congelato.";
                        response.sendRedirect("messaggio_euribor_cl.jsp?a=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));
              }     
        }
        if (strMessaggioFunz.equals(""))
        {
                java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
                VALO_EURIBOR = valore;
                DATA_CONCAT = riga.getPeriodo_rif();
                strDATA_INIZIO_CICLO_FATRZ = df.format(DATA_INIZIO_CICLO_FATRZ);
                strDATA_FINE_CICLO_FATRZ = df.format(DATA_FINE_CICLO_FATRZ);                        
        }

  }    




%>
<!--<input type="hidden" name="strQueryString" value="<%=strQueryString%>">-->
<br>
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/euribor.gif" alt="" border="0"></td>
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
        <td  class="textB" align="left">Valore % Euribor:</td>
        <% if ( operazione==0 ){ %>        
            <td  class="text" align="left"><input type="text" class="text" size="7"  maxlength="7" name="VALO_EURIBOR" value=""></td>                
        <%}%>  
        <% if ( operazione==1 ){ %>
            <td  class="text" align="left"><input type="text" class="text" size="7"  maxlength="7" name="VALO_EURIBOR" value="<%=VALO_EURIBOR.toString().replace('.',',')%>"></td>        
        <% } %>
        <% if ( operazione==2 ){ %>
            <td  class="text" align="left"><%=VALO_EURIBOR.toString().replace('.',',')%>
             <input type="hidden" name="VALO_EURIBOR" value="<%=VALO_EURIBOR.toString().replace('.',',')%>"></td>        
        <%}%>   
      </tr>   
      <tr>
        <td  class="textB" align="left">Periodo di riferimento Euribor:</td>      
        <td  class="text" align="left"><%= DATA_CONCAT %></TD>
      </tr>           
      <tr>
        <td  class="textB" align="left">Data Inizio Ciclo Fatt.:</td>            
        <td  class="text" align="left"><%= strDATA_INIZIO_CICLO_FATRZ %>
        <input type="hidden" name="DATA_INIZIO_CICLO_FATRZ" value="<%=strDATA_INIZIO_CICLO_FATRZ%>"></TD>                                 
      </tr>           
      <tr>
        <td  class="textB" align="left">Data Fine Ciclo Fatt.:</td>              
        <td  class="text" align="left"><%= strDATA_FINE_CICLO_FATRZ %>
        <input type="hidden" name="DATA_FINE_CICLO_FATRZ" value="<%=strDATA_FINE_CICLO_FATRZ%>"></TD>            
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