<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Vector" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_scarti_inventario_cl.jsp")%>
</logtag:logData>

<%
  int j=0;
  I5_2RECORD_SCARTATO_CL_ROW[] aRemote = null;
  String bgcolor="";
  Vector appoVector=null;  
  String Code_elab=null;
  String flag_sys=null;
  String Code_account=null;  
  String Code_Scarto;
  String Desc_Motivo_Scarto;
  String Code_Istanza_Ps;
  String Desc_Valo_Attuale;
  String Desc_Valo_St;    
  aRemote = (I5_2RECORD_SCARTATO_CL_ROW[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Stampa Scarti Inventario</TITLE>
</HEAD>
<BODY >
<table>
<tr>
  <td>Motivo</td>      
  <td>Codice Istanza P/S</td>
  <td>Valore ad inventario</td>      
  <td>Valore a storico</td>
</tr>
<%
//Scrittura dati su lista
for(j=0;(j<aRemote.length) ;j++)      
{
   Code_Scarto=aRemote[j].getCode_Scarto();
   Desc_Motivo_Scarto=aRemote[j].getDesc_Motivo_Scarto();
   Code_Istanza_Ps=aRemote[j].getCode_Istanza_Ps();
   Desc_Valo_Attuale=aRemote[j].getDesc_Valo_Attuale();
   Desc_Valo_St=aRemote[j].getDesc_Valo_St();         
%>
                        <TR>
                           <TD><%= Desc_Motivo_Scarto %></TD>
                           <TD><%= Code_Istanza_Ps %></TD>
<%                           
         if (Desc_Valo_Attuale != null){
%>         
                           <TD><%= Desc_Valo_Attuale %></TD>
<%                           
         } else {
%>
                           <TD>&nbsp;</TD>
<%
         }
         if (Desc_Valo_St != null){
%>                                    
                           <TD><%= Desc_Valo_St %></TD>                           
<%                           
         } else {
%>
                           <TD>&nbsp;</TD>
<%
         }                           
%>         
                        </tr>

<%
      }
%>      
</table>
</form>
</BODY>
</HTML>