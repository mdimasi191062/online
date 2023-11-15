<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_anag_funz.jsp")%>
</logtag:logData>
<%
  int j=0;
  I5_2SCONTO_CL_ROW[] aRemote = null;
  aRemote = (I5_2SCONTO_CL_ROW[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Stampa Sconti</TITLE>
</HEAD>
<BODY >

<table>
<tr>
<td>Descrizione Sconto</td>
<td>Valore di Decremento</td>
<td>Percentuale Sconto</td>                         
</tr>
                        
<%
    String desc_sconto=null;
    Integer valo_perc_sconto=null;
    java.math.BigDecimal valo_decr_tariffa=null;

     for(j=0;(j<aRemote.length);j++)
     {
         desc_sconto = aRemote[j].getDescSconto();
         valo_perc_sconto = aRemote[j].getPercSconto();
         valo_decr_tariffa = aRemote[j].getDecremento();
%>
                        <TR>
                           <TD><%= desc_sconto %></TD>
                           <TD><% if(valo_decr_tariffa!=null){out.println(valo_decr_tariffa.toString().replace('.',','));}else{out.println("&nbsp;");} %></TD>                                 
                           <TD><% if(valo_perc_sconto!=null){out.println(valo_perc_sconto);}else{out.println("&nbsp;");}%></TD>            
<%
        }
%>
</table>
</form>
</BODY>
</HTML>
