<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>

<!-- % @ taglib uri="/webapp/sec" prefix="sec" % -->
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<!--%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%-->
<!--sec:ChkUserAuth isModal="true" /-->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"modifica_codice_sap.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strQueryString = "";
  Boolean ret =false;
    /*strQueryString = "txtTipoPromo=" + request.getParameter("txtTipoPromo");
  strQueryString += "&txtValore=" + request.getParameter("txtValore");
  strQueryString += "&txtTypeLoad=0"; */

  String code_gest_sap = request.getParameter("txtCodGestoreSap");
  String code_gest = request.getParameter("txtCodGestore");
  String data_inizio_valid = request.getParameter("txtDataIni");  
  String data_fine_valid=request.getParameter("txtDataFin");    
  int operazione=0;
  operazione=Integer.parseInt(request.getParameter("operazione"));     
  operazione=1;

strQueryString="?operazione=1";
/*  
    strQueryString=strQueryString+"&code_gest_sap="+java.net.URLEncoder.encode(code_gest_sap,com.utl.StaticContext.ENCCharset)
                                +"&code_gest="+java.net.URLEncoder.encode(code_gest,com.utl.StaticContext.ENCCharset)
                                +"&txtDataIni="+java.net.URLEncoder.encode(data_inizio_valid,com.utl.StaticContext.ENCCharset)
                                +"&txtDataFin="+java.net.URLEncoder.encode(data_fine_valid,com.utl.StaticContext.ENCCharset);
*/
    strQueryString=strQueryString+"&code_gest_sap="+code_gest_sap
                                +"&code_gest="+code_gest
                                +"&txtDataIni="+data_inizio_valid
                                +"&txtDataFin="+data_fine_valid;

  /*
  int operazione=0;
    try {
        operazione=Integer.parseInt(request.getParameter("operazione")); 
    } catch (Exception e) {
        response.sendRedirect("messaggio.jsp?messaggio=Operazione" + java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
    }
*/
           
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_3GEST_SAP_SPHome" location="I5_3GEST_SAP_SP" />  
<EJB:useBean id="promo" type="com.ejbSTL.I5_3GEST_SAP_SP" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<TITLE>Verifica Gestione Codica Sap</TITLE>
<META content="text/html; charset=windows-1252" http-equiv=Content-Type>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
</HEAD>

<%
I5_3GEST_SAP_SP_ROW row = new I5_3GEST_SAP_SP_ROW();

/*
row.setCODE_GEST_SAP(java.net.URLDecoder.decode(code_gest_sap,com.utl.StaticContext.ENCCharset));
row.setCODE_GEST(java.net.URLDecoder.decode(code_gest,com.utl.StaticContext.ENCCharset));
row.setDATA_INIZIO_VALID(java.net.URLDecoder.decode(data_inizio_valid,com.utl.StaticContext.ENCCharset));
row.setDATA_FINE_VALID(java.net.URLDecoder.decode(data_fine_valid,com.utl.StaticContext.ENCCharset));
*/
row.setCODE_GEST_SAP(code_gest_sap);
row.setCODE_GEST(code_gest);
row.setDATA_INIZIO_VALID(data_inizio_valid);
row.setDATA_FINE_VALID(data_fine_valid);

switch (operazione){
  case 0:
     ret = true;
     //ret = promo.checkcodicesap(row);
     if(!ret)
     { // Codice SAP non presente in jpub

    
%>



<BODY bgColor="#ffffff" text="#000000">
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
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; Gestione Codice Sap</TD>
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
<td>row: <%=row.getCODE_GEST()%><%=row.getCODE_GEST_SAP()%><%=row.getDATA_INIZIO_VALID()%><%=row.getDATA_FINE_VALID()%><%=code_gest%><%=code_gest_sap%><%=data_inizio_valid%><%=data_fine_valid%></td>
</tr>
	      <tr>
                <td class="textB" bgcolor="#D5DDF1" align="center">
                    <input class="textB" type="button" name="Conferma" value="Conferma" onclick = "window.document.formSalva.submit();">
                    <input class="textB" type="button" name="Indietro" value="Annulla" onclick = "window.close();">
	        </td>
	      </tr>
         </table>

    </TD>
  </TR>
</TABLE>

   
     
<%
     }   
     break; 
  case 1:
    
    //int controlloDataInizio = Integer.parseInt(data_inizio_valid.substring(6,10).trim()) + Integer.parseInt(data_inizio_valid.substring(3,5).trim()) + Integer.parseInt(data_inizio_valid.substring(0,2).trim()) ;
    int controlloDataInizio = Integer.parseInt(data_inizio_valid.substring(6,10).trim() + data_inizio_valid.substring(3,5).trim() + data_inizio_valid.substring(0,2).trim()) ;
    int controlloDataFine = 99999999;
    if (!(data_fine_valid.equalsIgnoreCase("")))
       //controlloDataFine = Integer.parseInt(data_fine_valid.substring(6,10).trim()) + Integer.parseInt(data_fine_valid.substring(3,5).trim()) + Integer.parseInt(data_fine_valid.substring(0,2).trim())   ;
       controlloDataFine = Integer.parseInt(data_fine_valid.substring(6,10).trim() + data_fine_valid.substring(3,5).trim() + data_fine_valid.substring(0,2).trim()) ;    
//    String controlloDataInizio = data_inizio_valid.substring(6,10) + data_inizio_valid.substring(3,5) + data_inizio_valid.substring(0,2) ;
//    String controlloDataFine = data_fine_valid.substring(6,10)+ data_fine_valid.substring(3,5) + data_fine_valid.substring(0,2)   ;      
 
    
    if (controlloDataFine < controlloDataInizio)
    {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Data fine " +  data_fine_valid +  " minore di Data inizio " + data_inizio_valid,com.utl.StaticContext.ENCCharset));
       break;        
    }
/*    String dataStr = formatter.format(new Date());
    int idata = dataStr.int();
    if (controlloDataFine < dataStr)
    {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Data fine " +  data_fine_valid +  " minore di Data inizio " + data_inizio_valid,com.utl.StaticContext.ENCCharset));
       break;        
    }
    /*ret = promo.checkGestoreSap(row);
     if(!ret)
     {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Codice Gestore Sap attivo per la data selezionata.",com.utl.StaticContext.ENCCharset));
       break;
    } */
       
   ret = promo.modifyGestoreSap(row);
     if(ret)
     {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Codice Gestore Sap modificato con successo.",com.utl.StaticContext.ENCCharset));
    } else
    {
       response.sendRedirect("messaggio.jsp?messaggio="+ java.net.URLEncoder.encode("Codice Gestore non presente in JPUB",com.utl.StaticContext.ENCCharset));
    }
     break;       
   }


  
  if ( ret && operazione == 0 ) {
    response.sendRedirect("modifica_codice_sap.jsp" + strQueryString);
  } else if ( ret && operazione == 1 ) {
  
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="gest_codice_sap.jsp"
  window.opener.location.reload();
  this.close();
</SCRIPT>
<% } %>
<form name="formSalva" method="post" action="modifica_codice_sap.jsp<%=strQueryString%>">

   <input type="hidden" name=txtCodGestoreSap id=txtCodGestoreSap value="<%=code_gest_sap%>"> 
    <input type="hidden" name=txtCodGestore id=txtCodGestore value="<%=code_gest%>">
    <input type="hidden" name=txtDataIni id=txtDataIni value="<%=data_inizio_valid%>">
    <input type="hidden" name=txtDataFin id=txtDataFin value="<%=data_fine_valid%>">

</form>
</BODY>
</HTML>
