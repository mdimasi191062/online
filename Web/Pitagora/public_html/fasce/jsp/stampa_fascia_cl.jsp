<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="javax.rmi.*,com.ejbBMP.*, com.utl.*, com.usr.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_fascia_cl.jsp")%>
</logtag:logData>

<%
 //Interfaccia Remota
  I5_2FASCIE remote = null;       
  int j=0;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  I5_2FASCIE[] aRemote = null;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");        
  I5_2FASCIEPK PrimaryKey    = null;                                                     
  String DESC_FASCIA    = null;
  String VALO_LIM_MAX    = null;
  String VALO_LIM_MIN    = null;
  String DATA_INIZIO_VALID = null;  
  aRemote = (I5_2FASCIE[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">

<TITLE>Stampa Fascia</TITLE>
</HEAD>
<BODY >
<%
    aRemote = (I5_2FASCIE[]) session.getAttribute("aRemote");
%>
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td>Codice</td>
  <td>Descrizione</td>
  <td>Minimo</td>
  <td>Massimo</td>                         
  <td>Data Inizio</td>  
</tr>
<%
      //Scrittura dati su lista
      for(j=0;(j<aRemote.length);j++)
      {
         remote = (I5_2FASCIE) PortableRemoteObject.narrow(aRemote[j],I5_2FASCIE.class);                                                
         PrimaryKey    = (I5_2FASCIEPK) remote.getPrimaryKey();                                                     
         DESC_FASCIA    = remote.getDESC_FASCIA();
         VALO_LIM_MAX    = Integer.toString(remote.getVALO_LIM_MAX());
         VALO_LIM_MIN    = Integer.toString(remote.getVALO_LIM_MIN());
         DATA_INIZIO_VALID = df.format(remote.getDATA_INIZIO_VALID());
%>
                        <TR>
                           <TD><%= PrimaryKey.getCode_fascia() %></TD>                           
                           <TD><%= DESC_FASCIA %></TD>
                           <TD><%= VALO_LIM_MIN %></TD>
                           <TD><%= VALO_LIM_MAX %></TD>                           
                           <TD><%= DATA_INIZIO_VALID%></TD>      
                        </tr>
<%
     }
%>
</table>
</form>
</BODY>
</HTML>