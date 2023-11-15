<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="javax.rmi.*,com.ejbBMP.*, com.utl.*, com.usr.*,java.util.Collection" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_mov_non_ric_cl.jsp")%>
</logtag:logData>
<%

  I5_2MOV_NON_RICEJB remote=null;
  int j=0;
     // This is the variable we will store all records in.
  Collection collection=null;
  I5_2MOV_NON_RICEJB[] aRemote = null;
  java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");
  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Stampa movimenti non ricorrenti</title>
<TITLE>Stampa Movimenti</TITLE>
</HEAD>
<BODY>
<%
  if (session.getAttribute("aRemote")!=null){
      aRemote = (I5_2MOV_NON_RICEJB[]) session.getAttribute("aRemote");
  }
%>
  <table>
  <tr>
    <td>Fornitore</td>
    <td>Account</td>
    <td>Descrizione Movimento non Ricorrente</td>
    <td>Data Fatturazione</td>
    <td>Data Transazione</td>
    <td>Data Fatturabilità</td>
  </tr>
<%

      //Scrittura dati su lista
for(j=0;(j<aRemote.length);j++)
      {
         remote = (I5_2MOV_NON_RICEJB) PortableRemoteObject.narrow(aRemote[j],I5_2MOV_NON_RICEJB.class);                                                

         String CODE_MOVIM                = remote.getId_movim();                                                    
         String DESC_ACCOUNT              = remote.getDesc_acc();
         String DESC_FORN                 = remote.getNome_Rag_Soc_Gest();
         String DESC_MOV                  = remote.getDesc_mov();
         java.util.Date DATA_FATRB        = remote.getData_fatrb();
         java.util.Date DATA_EFF_FATRZ    = remote.getData_eff_fatrz();
         java.util.Date DATA_TRANSAZ      = remote.getData_transaz();

%>
                        <TR>
                           <TD ><%= DESC_FORN %></TD>
                           <TD><%= DESC_ACCOUNT %></TD>
                           <TD><%= DESC_MOV %></TD>
<%
if (DATA_EFF_FATRZ==null)
{
%>
                           <TD>&nbsp;</TD>      
<%
} else {
%>
                           <TD><%= df.format(DATA_EFF_FATRZ) %></TD>      
<%
}
if (DATA_TRANSAZ==null)
{
%>
                           <TD>&nbsp;</TD>      
<%
} else {
%>
                           <TD><%= df.format(DATA_TRANSAZ) %></TD>      
<%
}
if (DATA_FATRB==null)
{
%>
                           <TD>&nbsp;</TD>      
<%
} else {
%>
                           <TD><%= df.format(DATA_FATRB) %></TD>      
<%
}
%>

<%
        }
%>
                        </tr>


</table>
</form>

</BODY>
</HTML>
