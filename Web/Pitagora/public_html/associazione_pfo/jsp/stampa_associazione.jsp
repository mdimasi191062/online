<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_associazione.jsp")%>
</logtag:logData>

<%
  int j=0;
  Collection collection=null;
  I5_6MEM_FUNZ_PROF_OP_EL_ROW[] aRemote = null;
  aRemote = (I5_6MEM_FUNZ_PROF_OP_EL_ROW[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Stampa Associazioni Profilo - Funzione - Op. Elementare</TITLE>
</HEAD>
<BODY >
<table>
<tr>
 <td>Profilo</td>
 <td>Funzione</td>
 <td>Op. Elementare</td> 
</tr>
                        
<%
    String profilo   = null ;
    String funzione   = null;
    String operaz   = null;

     for(j=0;(j<aRemote.length);j++)
     {
          profilo = aRemote[j].getCODE_PROF_UTENTE();
          funzione = aRemote[j].getCODE_FUNZ();
          operaz = aRemote[j].getDESC_OP_ELEM();
%>
                        <TR>
                            <TD><%=profilo%></td>
                            <TD><%=funzione %></td>
                            <TD><%=operaz%></td> 
                       </tr>
<%
        }
%>
</table>
</form>
</BODY>
</HTML>
