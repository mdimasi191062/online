<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*,com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_profili.jsp")%>
</logtag:logData>

<%
  int j=0;
  I5_6PROF_UTENTE_ROW[] aRemote = null;
  aRemote = (I5_6PROF_UTENTE_ROW[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Stampa Profili</TITLE>
</HEAD>
<BODY >

  <table>
  <tr>
   <td>Codice Profilo</td>
   <td>Descrizione Profilo</td>
  </tr>
                        
<%
    String codice   = null ;
    String descrizione  = null;

     for(j=0;(j<aRemote.length);j++)
     {
          codice = aRemote[j].getCODE_PROF_UTENTE();
          descrizione = aRemote[j].getDESC_PROF_UTENTE();
%>
                        <TR>
                            <TD ><%=codice%></td>
                            <TD ><%=descrizione %></td>
                       </tr>
<%
        }
%>
</table>
</form>
</BODY>
</HTML>
