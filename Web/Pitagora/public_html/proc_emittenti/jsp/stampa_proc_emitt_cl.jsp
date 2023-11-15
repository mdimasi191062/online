<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="javax.rmi.*,com.ejbBMP.*, com.utl.*, com.usr.*,java.util.Date" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_proc_emitt_cl.jsp")%>
</logtag:logData>
<%
  I5_2ProcedureEmittenti remote;
  int j=0;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  I5_2ProcedureEmittenti[] aRemote = null;
  aRemote = (I5_2ProcedureEmittenti[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Selezione Tipo Contratto</TITLE>
</HEAD>
<BODY >
            <table>
            <tr>
              <td>Procedure Emittente</td>
              <td>Codice Emittente</td>
              <td>Data creazione</td>
            </tr>
<%

      //Scrittura dati su lista
      for(j=0;(j<aRemote.length);j++)
      {
         remote = (I5_2ProcedureEmittenti) PortableRemoteObject.narrow(aRemote[j],I5_2ProcedureEmittenti.class);                                                

         String CODE_PROC_EMITT    = remote.getCODE_PROC_EMITT();                                                    
         String DESC_PROC_EMITT    = remote.getDESC_PROC_EMITT();
         String DESC_VALO_PROC_EMITT    = remote.getDESC_VALO_PROC_EMITT();
         Date DATA_CREAZ    = remote.getDATA_CREAZ();         

%>
            <TR>
              <TD><%= DESC_PROC_EMITT %></TD>
              <TD><%= DESC_VALO_PROC_EMITT %></TD>
              <TD><%=  df.format(DATA_CREAZ) %></TD>      
            </tr>
<%
        }
%>        
</table>
</form>
</BODY>
</HTML>
