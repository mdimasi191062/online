<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection,java.util.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_replisco.jsp")%>
</logtag:logData>
<%
  int j=0;
  Collection collection=null;
  Vector aRemote2 = null;
  aRemote2 = (Vector) session.getAttribute("aRemote2");
  String strtipoCluster = null;
  String strcodeCluster = null;
  String istatComune = null;
  String dataIniVal = null;
  String dataFineVal = null;
  
  strtipoCluster = (String) session.getAttribute("strtipoCluster");
  strcodeCluster = (String) session.getAttribute("strcodeCluster");
  istatComune = (String) session.getAttribute("istatComune");
  dataIniVal = (String) session.getAttribute("dataIniVal");
  dataFineVal = (String) session.getAttribute("dataFineVal");
 
%>

<HTML>
<HEAD>
<TITLE>Report Listini Comuni CC e LIB</TITLE>
</HEAD>
<BODY >
    <table>
    <tr><td>Filtri di ricerca</td></tr>
    <tr>
      <td bgcolor='#D5DDF1' class="textB" width="8%">Tipo Cluster: <%=strtipoCluster%></td>
                          <td>Code Cluster: <%=strcodeCluster%></td>
                          <td>Codice Istat Comune: <%=istatComune%></td>                         
                          <td>Data Inizio validita' Pricing: <%=dataIniVal%></td> 
                          <td>Data Fine Validita' Pricing: <%=dataFineVal%></td>
    </tr>
     <tr>
     <td bgcolor='#D5DDF1' class="textB" width="8%"></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
     </tr>
    </table>
    
  <table>
  <tr>
            
  <td bgcolor='#D5DDF1' class="textB" width="8%">Descrizione Comune</td>
                          <td>Codice ISTAT</td>
                          <td>Codice Comune</td>                         
                          <td>Servizio</td> 
                          <td>Tipo Cluster</td> 
                          <td>Codice Cluster</td>
                          <td>Data Inizio Validita' Pricing</td>
                          <td>Data Fine Validita' pricing</td>
  </tr>
                        
<%
    String DESCRIZIONE_COMUNE=null;
    String CODICE_ISTAT=null;
    String CODICE_COMUNE=null;
    String SERVIZIO=null;
    String TIPO_CLUSTER=null;
    String CODICE_CLUSTER=null;
    String DATA_INIZIO_VALIDITA=null;    
    String DATA_FINE_VALIDITA=null;    
if ( aRemote2 != null ) {
     for(j=0;(j<aRemote2.size());j++)
     {
    
        I5_1COMUNI_CLUSTER_PRICING aRemote = (I5_1COMUNI_CLUSTER_PRICING)aRemote2.elementAt(j);
          DESCRIZIONE_COMUNE=aRemote.getDESCRIZIONE_COMUNE();
          CODICE_ISTAT=aRemote.getCODICE_ISTAT_COMUNE();
          CODICE_COMUNE=aRemote.getCODICE_COMUNE();
          SERVIZIO=aRemote.getCODE_TIPO_CONTR();
          TIPO_CLUSTER=aRemote.getTIPOLOGIA_CLUSTER_COMUNE();
          CODICE_CLUSTER=aRemote.getCODICE_CLUSTER();
          DATA_INIZIO_VALIDITA=aRemote.getDATA_INIZIO_VALIDITA_PRICING().substring(0,10);
          DATA_FINE_VALIDITA=aRemote.getDATA_FINE_VALIDITA_PRICING().substring(0,10);
          
 
%>
                        <TR>
                           <TD><%if(DESCRIZIONE_COMUNE!=null){out.print(DESCRIZIONE_COMUNE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(CODICE_ISTAT!=null){out.print(CODICE_ISTAT);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(CODICE_COMUNE!=null){out.print(CODICE_COMUNE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(SERVIZIO!=null){out.print(SERVIZIO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(TIPO_CLUSTER!=null){out.print(TIPO_CLUSTER);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(CODICE_CLUSTER!=null){out.print(CODICE_CLUSTER);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_INIZIO_VALIDITA!=null){out.print(DATA_INIZIO_VALIDITA);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_FINE_VALIDITA!=null){out.print(DATA_FINE_VALIDITA);}else{out.print("&nbsp;");}%></TD>
                        </tr>
<%
        }
}
%>
</table>
</BODY>
</HTML>
