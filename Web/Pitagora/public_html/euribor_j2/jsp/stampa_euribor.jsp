<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_euroribor.jsp")%>
</logtag:logData>

<%
  int j=0;
  EURIBOR_CICLI_X_SERV_ROW[] aRemoteEURIBOR = null;
  aRemoteEURIBOR = (EURIBOR_CICLI_X_SERV_ROW[]) session.getAttribute("aRemoteEURIBOR");
%>

<HTML>
<HEAD>
<TITLE>Stampa Euribor</TITLE>
</HEAD>
<BODY >
<table>
<tr>
 <td>Valore % Euribor</td>
 <td>Periodo di Riferimento Euribor</td>
 <td>Data Inizio Ciclo Fatt.</td>
 <td>Data Fine Ciclo Fatt.</td>                         
</tr>
                        
<%
     Float  VALO_EURIBOR;

     for(j=0;(j<aRemoteEURIBOR.length);j++)
     {
         String DATA_CONCAT    = aRemoteEURIBOR[j].getPeriodo_rif();   
         VALO_EURIBOR = aRemoteEURIBOR[j].getValo_euribor();                                                          
         java.text.SimpleDateFormat di = new java.text.SimpleDateFormat ("dd/MM/yyyy");
         String strDATA_INIZIO_CICLO = di.format(aRemoteEURIBOR[j].getData_inizio_ciclo());
         String strDATA_FINE_CICLO = di.format(aRemoteEURIBOR[j].getData_fine_ciclo());   
%>
                        <TR>
                           <TD ><%= VALO_EURIBOR.toString().replace('.',',') %></TD>
                           <TD ><%= DATA_CONCAT %></TD>            
                           <TD ><%= strDATA_INIZIO_CICLO %></TD>                                 
                           <TD ><%= strDATA_FINE_CICLO %></TD>                                 
                       </tr>
<%
        }

%>
</table>
</form>
</BODY>
</HTML>
