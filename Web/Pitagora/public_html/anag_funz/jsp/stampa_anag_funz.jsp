<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_anag_funz.jsp")%>
</logtag:logData>

<%
  Collection collection=null;
  I5_6ANAG_FUNZ_ROW[] aRemote = null;
  aRemote = (I5_6ANAG_FUNZ_ROW[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Stampa Anagrafica Funzionalità</TITLE>
</HEAD>
<BODY >
<table>
  <tr>
    <td>Codice</td>
    <td>Descrizione</td>
    <td>Tipo Funzione</td> 
  </tr>
<%
    String code_funz   = null ;
    String desc_funz   = null;
    String tipo_funz   = null;
    int i=0;
     for(i=0;(i<aRemote.length);i++)
     {
          code_funz = aRemote[i].getCODE_FUNZ();
          desc_funz = aRemote[i].getDESC_FUNZ();
          tipo_funz = aRemote[i].getTIPO_FUNZ();
%>
            <TR>
                <TD><%=code_funz%></td>
                <TD><%=desc_funz %></td>
                <TD><%=tipo_funz %></td> 
           </tr>
<%
          i+=1;
        }

%>
</table>
</BODY>
</HTML>


