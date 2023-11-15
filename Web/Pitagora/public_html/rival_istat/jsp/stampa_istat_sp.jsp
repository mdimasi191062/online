<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Vector" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_anag_funz.jsp")%>
</logtag:logData>
<%
  int j=0;
     //Il campo contiene l'elemento selezionato dall'utente
  String selANNO=null;
    // This is the variable we will store all records in.
    // Collection collection=null;
  Vector indiciVector = null;
    // Variabile per la memorizzazione delle informazioni dalla variabile collection
  IndiceIstat[] aRemote = null;
  String anno = null;
  Float indice_istat = null;
  IndiceIstat indiceIstat =  null;
  aRemote = (IndiceIstat[]) session.getAttribute("aRemote");  
%>

<HTML>
<HEAD>
<TITLE> Lista Indice Istat</TITLE>
</HEAD>
<BODY>

<table>
<tr>
  <td>Anno</td>
  <td>Indice Istat</td>                                              
</tr>                        
<%
      //Scrittura dati su lista
    for(j=0;j<aRemote.length;j++) {
      indiceIstat = new IndiceIstat();
      indiceIstat = (IndiceIstat) aRemote[j];                                                
      anno = indiceIstat.getAnno();
      indice_istat =indiceIstat.getIndice();
%>
                        <TR>
                           <TD><%=anno%></TD>
                           <TD><%= indice_istat.toString().replace('.',',') %></TD>            
                        </tr>                   
<%
        }
%>
</table>
</form>
</BODY>
</HTML>