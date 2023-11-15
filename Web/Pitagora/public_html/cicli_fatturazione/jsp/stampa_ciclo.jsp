<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.utl.*, com.usr.*,java.util.Collection" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_ciclo.jsp")%>
</logtag:logData>
<%
  I5_2ANAG_CICLI_FATRZ_ROW riga=null;
  int j=0;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");  
     // This is the variable we will store all records in.
  Collection collection=null;
  I5_2ANAG_CICLI_FATRZ_ROW[] aRemote = null;
 
  aRemote = (I5_2ANAG_CICLI_FATRZ_ROW[]) session.getAttribute("aRemote");
%>

<html>
<head>

<TITLE>Stampa Lista Cicli di fatturazione</TITLE>
</HEAD>
<BODY>
    <table>
    <tr>
      <td>Descrizione ciclo</td>
      <td>Data creazione</td>
      <td>Giorni inizio ciclo</td>
    </tr>
<%
        //Scrittura dati su lista
      for(j=0;(j<aRemote.length);j++)
      {
         String CODE_CICLO_FATRZ          = aRemote[j].getCODE_CICLO_FATRZ();                                                    
         String DESC_CICLO_FATRZ          = aRemote[j].getDESC_CICLO_FATRZ();
         int VALO_GG_INIZIO_CICLO         = aRemote[j].getVALO_GG_INIZIO_CICLO();
         java.util.Date DATA_CREAZ_CICLO  = aRemote[j].getDATA_CREAZ_CICLO(); 
%>
                        <TR>
                           <TD ><%= DESC_CICLO_FATRZ %></TD>
                           <TD ><%= df.format(DATA_CREAZ_CICLO) %></TD>      
                           <TD ><%= VALO_GG_INIZIO_CICLO %></TD>
                        </tr>

<%
        }

%>
</table>
</form>
</BODY>
</HTML>
