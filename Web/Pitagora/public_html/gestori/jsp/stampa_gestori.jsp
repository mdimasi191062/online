<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_gestori.jsp")%>
</logtag:logData>
<%
  int j=0;
  Collection collection=null;
  I5_3GEST_TLC_ROW[] aRemote = null;
  aRemote = (I5_3GEST_TLC_ROW[]) session.getAttribute("aRemote");
%>

<HTML>
<HEAD>
<TITLE>Stampa Gestori Normalizzati</TITLE>
</HEAD>
<BODY >
  <table>
  <tr>
    <td>Codice</td>
    <td>Tipologia<br>Operatore</td>
    <td>Tipo<br>Gestore</td>
    <td>Ragione<br>Sociale</td>
    <td>Sigla</td>
    <td>Partita<br>Iva</td>                          
    <td>Classic</td>
    <td>Special</td>                             
  </tr>
                        
<%
    String CODE_GEST=null;
    String CODE_TIPOL_OPERATORE=null;
    String CODE_TIPO_GEST=null;
    String NOME_RAG_SOC_GEST=null;
    String NOME_GEST_SIGLA=null;
    String CODE_PARTITA_IVA=null;
    String FLAG_CLASSIC=null;
    String FLAG_SPECIAL=null;


     for(j=0;(j<aRemote.length);j++)
     {
          CODE_GEST=aRemote[j].getCODE_GEST();
          CODE_TIPOL_OPERATORE=aRemote[j].getCODE_TIPOL_OPERATORE();
          CODE_TIPO_GEST=aRemote[j].getCODE_TIPO_GEST();
          NOME_RAG_SOC_GEST=aRemote[j].getNOME_RAG_SOC_GEST();
          NOME_GEST_SIGLA=aRemote[j].getNOME_GEST_SIGLA();
          CODE_PARTITA_IVA=aRemote[j].getCODE_PARTITA_IVA();
          FLAG_CLASSIC=aRemote[j].getFLAG_CLASSIC();
          FLAG_SPECIAL=aRemote[j].getFLAG_SPECIAL();
%>
                        <TR>
                           <TD><%if(CODE_GEST!=null){out.println(CODE_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(CODE_TIPOL_OPERATORE!=null){out.println(CODE_TIPOL_OPERATORE);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(CODE_TIPO_GEST!=null){out.println(CODE_TIPO_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(NOME_RAG_SOC_GEST!=null){out.println(NOME_RAG_SOC_GEST);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(NOME_GEST_SIGLA!=null){out.println(NOME_GEST_SIGLA);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(CODE_PARTITA_IVA!=null){out.println(CODE_PARTITA_IVA);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(FLAG_CLASSIC!=null){out.println(FLAG_CLASSIC);}else{out.println("&nbsp;");}%></TD>
                           <TD><%if(FLAG_SPECIAL!=null){out.println(FLAG_SPECIAL);}else{out.println("&nbsp;");}%></TD>
                       </tr>
<%
        }
%>
</table>
</form>
</BODY>
</HTML>
