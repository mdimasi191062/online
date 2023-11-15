<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_euroribor.jsp")%>
</logtag:logData>

<%
  int j=0;
  I5_2PARAM_VALORIZ_CL_ROW[] aRemote = null;
  aRemote = (I5_2PARAM_VALORIZ_CL_ROW[]) session.getAttribute("aRemote");
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

     for(j=0;(j<aRemote.length);j++)
     {
         String DATA_CONCAT    = aRemote[j].getPeriodo_rif();   
         VALO_EURIBOR = aRemote[j].getValo_euribor();                                                          
         java.text.SimpleDateFormat di = new java.text.SimpleDateFormat ("dd/MM/yyyy");
         String strDATA_INIZIO_CICLO_FATRZ = di.format(aRemote[j].getData_inizio_ciclo_fatrz());
         String strDATA_FINE_CICLO_FATRZ = di.format(aRemote[j].getData_fine_ciclo_fatrz());   
%>
                        <TR>
                           <TD ><%= VALO_EURIBOR.toString().replace('.',',') %></TD>
                           <TD ><%= DATA_CONCAT %></TD>            
                           <TD ><%= strDATA_INIZIO_CICLO_FATRZ %></TD>                                 
                           <TD ><%= strDATA_FINE_CICLO_FATRZ %></TD>                                 
                       </tr>
<%
        }

%>
</table>
</form>
</BODY>
</HTML>
