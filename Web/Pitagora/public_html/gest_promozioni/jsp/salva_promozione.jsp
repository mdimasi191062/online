<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<!-- % @ taglib uri="/webapp/sec" prefix="sec" % -->
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<!--%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%-->
<!--sec:ChkUserAuth isModal="true" /-->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_promozione.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strQueryString = "";
  Boolean ret =false;
  /*strQueryString = "txtTipoPromo=" + request.getParameter("txtTipoPromo");
  strQueryString += "&txtValore=" + request.getParameter("txtValore");
  strQueryString += "&txtTypeLoad=0"; */

  String txtTipoPromo = request.getParameter("txtTipoPromo");
  String txtValore = request.getParameter("txtValore");
  String txtStored = request.getParameter("txtStored");  
  String txtDesc=request.getParameter("txtDesc");    
  String txtServizi=request.getParameter("txtServizi");    
  int intClasseOF = Integer.parseInt(request.getParameter("txtClasseOF"));
  
  strQueryString="?operazione=1";
  strQueryString=strQueryString+"&txtTipoPromo="+java.net.URLEncoder.encode(txtTipoPromo,com.utl.StaticContext.ENCCharset)
                                +"&txtValore="+java.net.URLEncoder.encode(txtValore,com.utl.StaticContext.ENCCharset)
                                +"&txtStored="+java.net.URLEncoder.encode(txtStored,com.utl.StaticContext.ENCCharset)
                                +"&txtDesc="+java.net.URLEncoder.encode(txtDesc,com.utl.StaticContext.ENCCharset)
                                +"&txtClasseOF="+java.net.URLEncoder.encode((request.getParameter("txtClasseOF")),com.utl.StaticContext.ENCCharset)
                                +"&txtServizi="+java.net.URLEncoder.encode(txtServizi,com.utl.StaticContext.ENCCharset); 
  
  int operazione=0;
    try {
        operazione=Integer.parseInt(request.getParameter("operazione")); 
    } catch (Exception e) {
        response.sendRedirect("messaggio.jsp?messaggio=Operazione" + java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
    }
           
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_2PROMOZIONIHome" location="I5_2PROMOZIONI" />  
<EJB:useBean id="promo" type="com.ejbSTL.I5_2PROMOZIONI" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<TITLE>Verifica Promozione</TITLE>
<META content="text/html; charset=windows-1252" http-equiv=Content-Type>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
</HEAD>

<%
I5_2PROMOZIONI_ROW row = new I5_2PROMOZIONI_ROW();
row.setCODE_PROMOZIONE(0);
row.setDESCRIZIONE(java.net.URLDecoder.decode(txtDesc,com.utl.StaticContext.ENCCharset));
row.setSTORED_PROCEDURE(java.net.URLDecoder.decode(txtStored,com.utl.StaticContext.ENCCharset));
try {
    row.setTIPO_PROMOZIONE(Integer.parseInt(txtTipoPromo.replace(',','.')));
} catch (Exception e) {
    response.sendRedirect("messaggio.jsp?messaggio=txtTipoPromo-"+txtTipoPromo+"-"+ java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
}
try {
    row.setVALORE(Float.parseFloat(txtValore.replace(',','.')));
} catch (Exception e) {
    response.sendRedirect("messaggio.jsp?messaggio=txtValore-" + java.net.URLEncoder.encode(e.toString() ,com.utl.StaticContext.ENCCharset));
}

switch (operazione){
  case 0:
     ret = promo.checkPromizioni(row);
     if(!ret)
     { // Promozione già esistente
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
                    <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tipo Promozione&nbsp; : <%=txtTipoPromo%>
                    <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Valore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <%=txtValore%>
                    <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stored Procedure : <%=txtStored%>
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
     ret = promo.insertPromizioni(row);
     if(!ret)
     {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Impossibile inserire la promozione",com.utl.StaticContext.ENCCharset));
     }   
     else
     {
       int i=0;
       String[] servizio = txtServizi.split("_");
       for (i=0;i<servizio.length;i++){
          if (!servizio[i].equals("-1")){
          promo.insertPromizioniOF(0,intClasseOF,Integer.parseInt(servizio[i]));
          }
       }
     }
     //ret = associa.modifyAssociazione(txtCODE_PROF_UTENTE, txtCODE_FUNZ, txtCODE_OP_ELEM,CODE_PROF_UTENTE, CODE_FUNZ, CODE_OP_ELEM);
     //if(ret != null)
     //  response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode(ret,com.utl.StaticContext.ENCCharset));
     break;       
   }
  
  if ( ret && operazione == 0 ) {
    response.sendRedirect("salva_promozione.jsp" + strQueryString);
  } else if ( ret && operazione == 1 ) {
  
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.location.href="gest_promozioni.jsp"
  window.opener.location.reload();
  this.close();
</SCRIPT>
<% } %>
<form name="formSalva" method="post" action="salva_promozione.jsp<%=strQueryString%>">
    <input type="hidden" name=txtTipoPromo id=txtTipoPromo value="<%=txtTipoPromo%>"> 
    <input type="hidden" name=txtValore id=txtValore value="<%=txtValore%>">
    <input type="hidden" name=txtStored id=txtStored value="<%=txtStored%>">
    <input type="hidden" name=txtDesc id=txtDesc value="<%=txtDesc%>">
</form>
</BODY>
</HTML>