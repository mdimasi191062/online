<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.utl.*,com.usr.*,java.util.Date" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_agg_ciclo_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  I5_2ANAG_CICLI_FATRZ_ROW remote=null;
  String CodiceCiclo = "";
  String DescCiclo = "";
  String strMessaggioFunz = "";
  Date DataCiclo = new Date();
  String GiorniCiclo = "";
  String bErrore = request.getParameter("bErrore");
  String modo = request.getParameter("modo");
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy"); 
  
  if (bErrore!=null){
    DescCiclo=(String) session.getAttribute("txtDescCiclo");
    GiorniCiclo = (String) session.getAttribute("txtGiorniCiclo");
  }

  String sParametri=null;
%>
<EJB:useHome id="home2" type="com.ejbSTL.I5_2PARAM_VALORIZ_CLHome" location="I5_2PARAM_VALORIZ_CL" />  
<EJB:useBean id="eur" type="com.ejbSTL.I5_2PARAM_VALORIZ_CL" scope="session">
  <EJB:createBean instance="<%=home2.create()%>" />
</EJB:useBean>
<%
  if(eur.checkBatch()>0)
  {
        strMessaggioFunz = "Elaborazione Batch in corso. Impossibile continuare!";
        response.sendRedirect("messaggio.jsp?a=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));    
  }


  if ( modo.equals("1") )
  {
%>  
<EJB:useHome id="home" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJBHome" location="I5_2ANAG_CICLI_FATRZEJB" />
<EJB:useBean id="ciclo" type="com.ejbSTL.I5_2ANAG_CICLI_FATRZEJB" scope="session">
  <EJB:createBean instance="<%=home.create()%>" /> 
</EJB:useBean>
<%

      CodiceCiclo = request.getParameter("CodSel");
      remote = ciclo.loadCiclo(CodiceCiclo);      
      DescCiclo = remote.getDESC_CICLO_FATRZ();
      GiorniCiclo = Integer.toString(remote.getVALO_GG_INIZIO_CICLO());
      DataCiclo = remote.getDATA_CREAZ_CICLO();

      sParametri= "&CodSel=" + CodiceCiclo;  
      if (ciclo.controlloAccount(CodiceCiclo)>0)
      {
        strMessaggioFunz = "Non è possibile modificare un ciclo a cui è associato un Account.";
        response.sendRedirect("messaggio.jsp?a=1&messaggio=" + java.net.URLEncoder.encode(strMessaggioFunz,com.utl.StaticContext.ENCCharset));    
     }
  }
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function ONANNULLA()
{  
     window.close();
}

function ONCONFERMA()
{
  if( window.document.frmDati.txtDescCiclo.value.length==0){
    alert('Il campo descrizione ciclo è obbligatorio');
    window.document.frmDati.txtDescCiclo.focus();
    return(false);
  }

  if( window.document.frmDati.txtGiorniCiclo.value.length==0){
    alert('Il campo giorni ciclo è obbligatorio');
    window.document.frmDati.txtGiorniCiclo.focus();
    return(false);
  }

  if (!GestioneNumerico(window.document.frmDati.txtGiorniCiclo,2,31))
  {
    window.document.frmDati.txtGiorniCiclo.focus();
    return(false);
  }

  if (parseInt(window.document.frmDati.txtGiorniCiclo.value) <0)
  {
    alert('Il numero dei giorni deve essere positivo');
    window.document.frmDati.txtGiorniCiclo.focus();
    return(false);
  }
  if (parseInt(window.document.frmDati.txtGiorniCiclo.value) ==0)
  {
    alert('Il numero dei giorni non può essere uguale a zero');
    window.document.frmDati.txtGiorniCiclo.focus();
    return(false);
  }
  var iPosVirgola=window.document.frmDati.txtGiorniCiclo.value.search(',');
  if (iPosVirgola>-1)
  {
    var sDecimali=substring(window.document.frmDati.txtGiorniCiclo.value,iPosVirgola)
    if (sDecimali.length>0)
    {
      alert('Il numero dei giorni deve essere un valore intero');
      window.document.frmDati.txtGiorniCiclo.focus();
      return(false);
    } 
  } 
  if (window.document.frmDati.modo.value =="0")
  {
     if (confirm('Si conferma l\'inserimento del ciclo')==true)
     {
         window.document.frmDati.submit();
     }
  }
  if (window.document.frmDati.modo.value =="1")  
  {
     if (confirm('Si conferma l\'aggiornamento del ciclo')==true)
     {
         window.document.frmDati.submit();
     }
  }

}

</SCRIPT>

<% if ( modo.equals("0") ){ %>
<TITLE>Inserimento</TITLE>
<% }else{ %>
<TITLE>Modifica</TITLE>
<%}%>   
</HEAD>
<BODY>
<form name="frmDati" method="post" action='salva_ciclo_cl.jsp'>
<%
  //Gestione Paramteri Navigazione
  String txtnumRec = request.getParameter("txtnumRec");
  String NumRec = request.getParameter("numRec");  
  String txtnumPag=request.getParameter("txtnumPag");
  String txtCodRicerca = request.getParameter("txtCodRicerca");
%>
<input type="hidden" name="modo" value="<%=modo%>">
<input type="hidden" name="txtnumRec" value="<%=txtnumRec%>">
<input type="hidden" name="numRec" value="<%=NumRec%>">
<input type="hidden" name="txtnumPag" value="<%=txtnumPag%>">
<input type="hidden" name="txtCodRicerca" value="<%=txtCodRicerca%>">
<input type="hidden" name="CodSel" value="<%=CodiceCiclo%>">
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td><img src="../images/ciclidifatt.gif" alt="" border="0"></td>
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
            <% if ( modo.equals("0") ){ %>
						  <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Inserimento ciclo di fatturazione</td>
            <% }else{ %>
              <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Aggiornamento ciclo di fatturazione</td>
              <input type="hidden" name="code_ciclo" value="<%=CodiceCiclo%>">
            <%}%>   
				  	  <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
    				</tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
      <tr>
        <td  class="textB" align="right">Desc. ciclo:</td>
        <td  class="text" align="left"><input type="text" class="text" name="txtDescCiclo" value="<%=DescCiclo%>" size="30" maxlength="50"></td>
      </tr>   
      <tr>
        <td  class="textB" align="right">Data creazione ciclo:</td>
        <td  class="text" align="left"><input type="text" class="text" name="txtDataCiclo" value="<%=df.format(DataCiclo)%>"></td>
      </tr>   
      <tr>
        <td  class="textB" align="right">Giorno inizio ciclo:</td>
        <td  class="text" align="left"><input type="text" class="text" name="txtGiorniCiclo" value="<%=GiorniCiclo%>" size="2" maxlength="2"></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
  
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	      <tr>
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />                
	      </tr>
	    </table>
    </td>
  </tr>
</table>
<script language="javascript">
Disable(document.frmDati.txtDataCiclo);
</script>
</form>
</BODY>
</HTML>