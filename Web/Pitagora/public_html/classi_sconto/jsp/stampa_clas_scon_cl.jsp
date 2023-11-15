<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="javax.rmi.*,com.ejbBMP.*, com.utl.*, com.usr.*,java.util.Collection" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_clas_scon_cl.jsp")%>
</logtag:logData>

<% 
  I5_2CLAS_SCONTOEJB remote = null;       
  int j=0;
    // This is the variable we will store all records in.
  Collection collection=null;  
  I5_2CLAS_SCONTOEJB[] aRemote = null;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");        
  I5_2CLAS_SCONTOPK PrimaryKey    = null; 
  String code_clas_sconto = null ;
  String desc_clas_sconto   = null;
  java.math.BigDecimal  impt_min_spesa=null;
  java.math.BigDecimal  impt_max_spesa=null;
  aRemote = (I5_2CLAS_SCONTOEJB[]) session.getAttribute("aRemote");    
%>

<HTML>
<HEAD>
<TITLE>Selezione Classe di sconto</TITLE>
</HEAD>
<BODY >
  <table>
  <tr>
   <td>Codice</td>
   <td>Descrizione</td>
   <td>Val. Minimo</td>
   <td>Val. Massimo</td>
   <td>Data Inizio</td>
   <td>Data Fine</td>                                               
  </tr>
<%

  //Scrittura dati su lista
  for(j=0;(j<aRemote.length);j++)
  {
     remote = (I5_2CLAS_SCONTOEJB) PortableRemoteObject.narrow(aRemote[j],I5_2CLAS_SCONTOEJB.class);                                                
       PrimaryKey    = (I5_2CLAS_SCONTOPK) remote.getPrimaryKey(); 

      code_clas_sconto = PrimaryKey.getId_Cls_Sconto();
      desc_clas_sconto = remote.getDesc_Cls_Sconto();
      impt_min_spesa = remote.getMin_Spesa();
      impt_max_spesa = remote.getMax_Spesa();
      String data_inizio_valid = df.format(remote.getIn_Valid());
      String data_fine_valid = "&nbsp;";
      if (remote.getFi_Valid()!=null)
      {          
       data_fine_valid = df.format(remote.getFi_Valid());          
      }

%>
      <TR>
          <TD><%=PrimaryKey.getId_Cls_Sconto()%></td>
          <TD><%=desc_clas_sconto%></td>
          <TD><% if(impt_min_spesa!=null){out.println(impt_min_spesa.toString().replace('.',','));}else{out.println("&nbsp;");} %></td>
          <TD><% if(impt_max_spesa!=null){out.println(impt_max_spesa.toString().replace('.',','));}else{out.println("&nbsp;");} %></td>
          <TD><%=data_inizio_valid%></td>
          <TD><%=data_fine_valid%></td>
      </tr>

<%
    }

%>
</table>
</form>
</BODY>
</HTML>