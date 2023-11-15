<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>

<!-- % @ taglib uri="/webapp/sec" prefix="sec" % -->
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="com.ejbSTL.*,com.ejbSTL.impl.*,com.utl.*,com.usr.*" %>
<!--%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%-->
<!--sec:ChkUserAuth isModal="true" /-->
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"salva_inib_sap.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");

  String strQueryString = "";
  Boolean ret =false;
  String ritorno ="";
  //String desc_account = request.getParameter("txtDescAccount");
  String code_account = request.getParameter("txtCodeAccount");
  String data_inizio_valid = request.getParameter("txtDataIni").replace("%20"," ");  
  String data_fine_valid=request.getParameter("txtDataFin").replace("%20"," ");    
  String Flag_Sap=request.getParameter("txtFlagSap");  
  String Flag_Res_Sap=request.getParameter("txtFlagResSap");  
  String Tipo_Doc=request.getParameter("txtTipoDoc");  
  String Note=request.getParameter("txtNote");  
  String Note_Res_Sap=request.getParameter("txtNoteResSap");  
  int operazione=0;
  operazione=Integer.parseInt(request.getParameter("operazione"));     
  operazione=1;

  strQueryString="?operazione=1";

    //strQueryString=strQueryString+"&desc_account="+desc_account
      strQueryString=strQueryString+"&code_account="+code_account
                                +"&txtDataIni="+data_inizio_valid
                                +"&txtDataFin="+data_fine_valid
                                +"&txtFlagSap="+Flag_Sap
                                +"&txtFlagResSap="+Flag_Res_Sap
                                +"&txtNote="+Note
                                +"&txtNoteResSap="+Note_Res_Sap
                                +"&txtTipoDoc="+Tipo_Doc
                                ;
           
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbSTL.I5_2INIBIZIONE_INVIO_SAPHome" location="I5_2INIBIZIONE_INVIO_SAP" />  
<EJB:useBean id="promo" type="com.ejbSTL.I5_2INIBIZIONE_INVIO_SAP" scope="session">
  <EJB:createBean instance="<%=home.create()%>" />
</EJB:useBean>
<TITLE>Verifica Gestione Codica Sap</TITLE>
<META content="text/html; charset=windows-1252" http-equiv=Content-Type>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
</HEAD>

<%
I5_2INIBIZIONE_INVIO_SAP_ROW row = new I5_2INIBIZIONE_INVIO_SAP_ROW();

row.setCODE_ACCOUNT(code_account);
row.setDATA_INIZIO_VALID(data_inizio_valid);
row.setDATA_FINE_VALID(data_fine_valid);
row.setFLAG_SAP(Flag_Sap);
row.setFLAG_RESOCONTO_SAP(Flag_Res_Sap);
row.setNOTE(Note);
row.setNOTE_RESOCONTO_SAP(Note_Res_Sap);
row.setTIPO_DOC(Tipo_Doc);
row.setFLAG_SYS("C");


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
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; Salvataggio Regola</TD>
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

<td>row: <%=row.getCODE_ACCOUNT()%><%=row.getDATA_INIZIO_VALID()%><%=row.getDATA_FINE_VALID()%><%=Flag_Sap%><%=Flag_Res_Sap%><%=Note%><%=Note_Res_Sap%></td>
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
      
    long controlloDataInizio = Long.parseLong(data_inizio_valid.substring(6,10).trim() + data_inizio_valid.substring(3,5).trim() + data_inizio_valid.substring(0,2).trim() +  data_inizio_valid.substring(12,13).trim()+  data_inizio_valid.substring(15,16).trim()+  data_inizio_valid.substring(18,19).trim());
    long controlloDataFine = 9999999999999L;
    if (!(data_fine_valid.equalsIgnoreCase("")))
    
       controlloDataFine = Long.parseLong(data_fine_valid.substring(6,10).trim() + data_fine_valid.substring(3,5).trim() + data_fine_valid.substring(0,2).trim() +  data_fine_valid.substring(12,13).trim()+  data_fine_valid.substring(15,16).trim()+  data_fine_valid.substring(18,19).trim()) ;    
 
    
    if (controlloDataFine < controlloDataInizio)
    {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Data fine " +  data_fine_valid +  " minore di Data inizio " + data_inizio_valid,com.utl.StaticContext.ENCCharset));
       break;        
    }
  
       
   //ret = promo.insertInibSap(row);
   ritorno = promo.insertInibSap(row);
     //if(ret)
     if(ritorno.equals("1"))
     {
       response.sendRedirect("messaggio.jsp?messaggio=" + java.net.URLEncoder.encode("Regola inserita con successo.",com.utl.StaticContext.ENCCharset));
    } else
        if(ritorno.equals("5"))
        {  
           response.sendRedirect("messaggio.jsp?messaggio="+ java.net.URLEncoder.encode("Regola attiva gia' presente nell'intervallo di date",com.utl.StaticContext.ENCCharset));
           
        }
        else
        {  
           response.sendRedirect("messaggio.jsp?messaggio="+ java.net.URLEncoder.encode("Errore in salvataggio Regola",com.utl.StaticContext.ENCCharset));
        }
     break;       
   }


  
  if ( ret && operazione == 0 ) {
    response.sendRedirect("salva_inib_sap.jsp" + strQueryString);
  } else if ( ret && operazione == 1 ) {
  
%>
<SCRIPT LANGUAGE="JavaScript">
  window.opener.document.formPag.txtEsitoIns.value = formSalva.txtRitorno.value;
  //window.opener.location.href="inibsapsp.jsp?ritorno="+<%=ritorno%>;
  //window.opener.location.reload();
  self.close();

  //this.close();
</SCRIPT>
<% } %>
<form name="formSalva" method="post" action="salva_inib_sap.jsp<%=strQueryString%>">
    <input type="hidden" name=txtCodeAccount id=txtCodeAccount value="<%=code_account%>"> 
    <input type=hidden name="txtRitorno" value="<%=ritorno%>">    
    <input type="hidden" name=txtDataIni id=txtDataIni value="<%=data_inizio_valid%>">
    <input type="hidden" name=txtDataFin id=txtDataFin value="<%=data_fine_valid%>">
    <input type="hidden" name=txtFlagSap id=txtFlagSap value="<%=Flag_Sap%>">
    <input type="hidden" name=txtFlagResSap id=txtFlagResSap value="<%=Flag_Res_Sap%>">
    <input type="hidden" name=txtNote id=txtNote value="<%=Note%>">
    <input type="hidden" name=txtNoteResSap id=txtNoteResSap value="<%=Note_Res_Sap%>">
    <input type="hidden" name=txtTipoDoc id=txtTipoDoc value="<%=Tipo_Doc%>">
</form>
</BODY>
</HTML>
