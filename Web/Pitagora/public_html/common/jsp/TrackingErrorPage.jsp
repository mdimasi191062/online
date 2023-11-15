<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page isErrorPage="true" session="false"%>
<%@ page import="com.utl.CustomException,com.utl.CustomEJBException,com.utl.StaticContext,com.utl.StaticMessages"%>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=request.getContextPath()%>/css/Style.css" TYPE="text/css">
<TITLE>Tracking Error Page</TITLE>
</HEAD>
<BODY>
<FORM method="post" ACTION="<%=request.getContextPath()%>/SendMail">

<BR><!-- nuovo layout inizio -->
<TABLE align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
  <TR>
    <td valign="top"><img src="<%=request.getContextPath()%>/common/images/body/pixel.gif" width="6" height="10"></td>
    <TD>
      <TABLE border="0" cellPadding="0" cellSpacing="0">
        <TR>
          <TD vAlign="top"><IMG border="0" src="<%=request.getContextPath()%>/common/images/body/erroreTitolo.gif"></TD>
        <TR>
      </TABLE>
      <TABLE bgColor="#ffffff" border="0" cellPadding="1" cellSpacing="0" width="602">
        <TR>
          <TD bgColor="#ffffff"><IMG height="3" src="<%=request.getContextPath()%>/common/images/body/pixel.gif" width="1"></TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#006699" border="0" cellPadding="1" cellSpacing="0" width="602">
        <TR>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="602">
              <TR>
                <TD bgColor="#006699" class="white" vAlign="top" width="88%">&nbsp; Errore</TD>
                <TD align="middle" bgColor="#ffffff" class="white" width="12%"><IMG height="11" src="<%=request.getContextPath()%>/common/images/body/tre.gif" width="28"></TD>
              </TR>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <TABLE bgColor="#ebf2ff" border="0" cellPadding="0" cellSpacing="0" width="600">
        <TR>
          <TD>&nbsp; </TD>
          <TD>
            <TABLE bgColor="#006699" border="0" cellPadding="0" cellSpacing="0" width="100%">
              <!-- inizio tabella sfondo scuro -->
              <TR>
                <TD class='white' align='center'>Attenzione!</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>&nbsp;Non è possibile accedere alla pagina: <%= request.getServletPath()%></TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white' align='center'>&nbsp;E' consigliabile uscire e riprovare più tardi.</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD class='white'>&nbsp;Se il problema persiste si prega di inviare una e-mail all'amministratore.</TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE>
          </TD>
          <TD>&nbsp;</TD>
          <TD>&nbsp;</TD>
          <TD><IMG align="right" src="<%=request.getContextPath()%>/common/images/body/log3.gif"></TD>
        </TR>
        <tr>
          <td>&nbsp;</td>
          <td colspan="4" NOWRAP align="CENTER" >
            <input class='textB' type="submit" value="Invia E-mail">
          </td>
        </tr>
      </TABLE>
    </TD>
  </TR>
</TABLE>
<br>
<br>
<br>

<%
String message="Non disponiblie";
String codice="Non disponiblie";
String tipo="Non disponiblie";
String nome_funzione="Non disponiblie";
String nome_ejb="Non disponiblie";
if (exception instanceof CustomException) 
{
  CustomException my = (CustomException)exception;
  message=my.getExceptionDescription();
  codice=my.getCodice();
  tipo=my.getTipo();
  nome_funzione=my.getNomeFunz();
  nome_ejb=my.getNomeEjb();
}
if (exception instanceof CustomEJBException) 
{
  CustomEJBException my = (CustomEJBException)exception;
  message=my.getExceptionDescription();
  codice=my.getCodice();
  tipo=my.getTipo();
  nome_funzione=my.getNomeFunz();
  nome_ejb=my.getNomeEjb();
}

%>
<logtag:logData id="<%=StaticContext.ID_MASTER_LOG%>">
<%= StaticMessages.getMessage(5002,"PAGINA="+request.getContextPath()+request.getServletPath())+"EXCEPTION CLASS NAME="+exception.getClass().getName()+" EXCEPTION CODICE="+codice+" EXCEPTION TIPO="+tipo+" EXCEPTION NOME FUNZIONE="+nome_funzione+" EXCEPTION NOME EJB/SERVLET="+nome_ejb+" EXCEPTION STACKTRACE:"%><%java.io.PrintWriter pw1 = new java.io.PrintWriter(out);exception.printStackTrace(pw1);%>

</logtag:logData>

<input type='hidden' name='message' value='<%=exception.getClass().getName()%>'>
<input type='hidden' name='stack_trace' value='<%java.io.PrintWriter pw = new java.io.PrintWriter(out);exception.printStackTrace(pw);%>'>
<input type='hidden' name='codice' value='<%=codice%>'>
<input type='hidden' name='tipo' value='<%=tipo%>'>
<input type='hidden' name='nome_funzione' value='<%=nome_funzione%>'>
<input type='hidden' name='nome_ejb' value='<%=nome_ejb%>'>
<input type='hidden' name='remoteAddr' value='<%=request.getRemoteAddr()%>'>
<input type='hidden' name='servletContext' value='<%=request.getContextPath()+request.getServletPath()%>'>
<input class='textB' type="hidden" name="ERRORE" value="SISTEMA">
</FORM>
</CENTER>
</BODY>
</HTML>
