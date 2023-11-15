<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection,java.util.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_estrazioniCA.jsp")%>
</logtag:logData>
<%
  int j=0;
  Collection collection=null;
  Vector aRemote2 = null;
  aRemote2 = (Vector) session.getAttribute("aRemote2");
%>

<HTML>
<HEAD>
<TITLE>Stampa Estrazioni Consistenze Attive</TITLE>
</HEAD>
<BODY >
  <table>
  <tr>
    <td>Servizio</td>
    <td>Operatore</td>
    <td>Descrizione Operatore</td>
    <td>Prodotto</td>
    <td>Descrizione Prodotto</td>
    <td>Mese Competenza</td>
    <td>Numero Consistenze</td>
  </tr>
                        
<%

    String SERVIZIO=null;
    String COD_OPERATORE=null;
    String OPERATORE=null;
    String COD_PRODOTTO=null;
    String PRODOTTO=null;
    String MESE_COMPETENZA=null;
    String NUMERO_CONSISTENZE=null;
if ( aRemote2 != null ) {
     for(j=0;(j<aRemote2.size());j++)
     {
        ClassEstrazioniConsAttive aRemote = (ClassEstrazioniConsAttive)aRemote2.elementAt(j);
          SERVIZIO=aRemote.getDescServizio();
          COD_OPERATORE=aRemote.getOperatore();
          OPERATORE=aRemote.getDescOperatore();
          COD_PRODOTTO=aRemote.getProdotto();
          PRODOTTO=aRemote.getDescProdotto();
          MESE_COMPETENZA=aRemote.getMeseAnnoComp();
          NUMERO_CONSISTENZE=aRemote.getNumConsistenze();
          
          //Pulizia spazi
          MESE_COMPETENZA=MESE_COMPETENZA.replaceAll("   "," ").replaceAll("  "," ");
%>
                        <TR>
                           <TD><%if(SERVIZIO!=null){out.print(SERVIZIO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(COD_OPERATORE!=null){out.print(COD_OPERATORE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(OPERATORE!=null){out.print(OPERATORE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(COD_PRODOTTO!=null){out.print(COD_PRODOTTO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(PRODOTTO!=null){out.print(PRODOTTO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(MESE_COMPETENZA!=null){out.print(MESE_COMPETENZA.replace(" ","&nbsp;"));}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(NUMERO_CONSISTENZE!=null){out.print(NUMERO_CONSISTENZE);}else{out.print("&nbsp;");}%></TD>
                        </tr>
<%
        }
}
%>
</table>
</BODY>
</HTML>
