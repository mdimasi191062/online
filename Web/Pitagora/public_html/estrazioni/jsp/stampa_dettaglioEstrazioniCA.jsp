<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection,java.util.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_dettaglioEstrazioniCA.jsp")%>
</logtag:logData>
<%
  int j=0;
  Collection collection=null;
  Vector aDettConsAtt = null;
  aDettConsAtt = (Vector) session.getAttribute("aDettConsAtt");
  String strDescServizio = Misc.nh(request.getParameter("DescServizio"));
  String strDescAccount = Misc.nh(request.getParameter("DescAccount"));
  String strDescProdotto = Misc.nh(request.getParameter("DescProdotto"));
%>

<HTML>
<HEAD>
<TITLE>Stampa Estrazioni Consistenze Attive</TITLE>
</HEAD>
<BODY >
  <table>
  <tr>
    <td>Servizio</td>
    <td>Codice Operatore</td>
    <td>Operatore</td>
    <td>Codice Prodotto</td>
    <td>Prodotto</td>
    <td>Mese Competenza</td>
    <td>Code Istanza PS</td>
    <td>Data DRO</td>
    <td>Data Inizio Fatturazione</td>
    <td>Data Fine Fatturazione</td>
    <td>Data Cessazione</td>
    <td>Data Inizio Validit&agrave;</td>
    <td>Data Fine Validit&agrave;</td>
    <td>Data Variazione</td>
  </tr>
                       
<%
    String COD_SERVIZIO=null;
    String SERVIZIO=null;
    String COD_OPERATORE=null;
    String OPERATORE=null;
    String COD_PRODOTTO=null;
    String PRODOTTO=null;
    String MESE_COMPETENZA=null;
    String CODE_ISTANZA_PS=null;
    String DATA_DRO=null;
    String DATA_INIZIO_FATRZ=null;
    String DATA_FINE_FATRZ=null;
    String DATA_CESS=null;
    String DATA_INIZIO_VALID=null;
    String DATA_FINE_VALID=null;
    String DATA_VARIAZ=null;
if ( aDettConsAtt != null ) {
     for(j=0;(j<aDettConsAtt.size());j++)
     {
        ClassDettaglioConsAttive aRemote = (ClassDettaglioConsAttive)aDettConsAtt.elementAt(j);
          COD_SERVIZIO=aRemote.getServizio();
          SERVIZIO=strDescServizio;
          COD_OPERATORE=aRemote.getOperatore();
          OPERATORE=strDescAccount; 
          COD_PRODOTTO=aRemote.getProdotto();
          PRODOTTO=strDescProdotto;
          MESE_COMPETENZA=aRemote.getMeseAnnoComp();
          CODE_ISTANZA_PS=aRemote.getCODE_ISTANZA_PS();
          DATA_DRO=aRemote.getDATA_DRO();
          DATA_INIZIO_FATRZ=aRemote.getDATA_INIZIO_FATRZ();
          DATA_FINE_FATRZ=aRemote.getDATA_FINE_FATRZ();
          DATA_CESS=aRemote.getDATA_CESS();
          DATA_INIZIO_VALID=aRemote.getDATA_INIZIO_VALID();
          DATA_FINE_VALID=aRemote.getDATA_FINE_VALID();
          DATA_VARIAZ=aRemote.getDATA_VARIAZ();
          
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
                           <TD><%if(CODE_ISTANZA_PS!=null){out.print(CODE_ISTANZA_PS);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_DRO!=null){out.print(DATA_DRO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_INIZIO_FATRZ!=null){out.print(DATA_INIZIO_FATRZ);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_FINE_FATRZ!=null){out.print(DATA_FINE_FATRZ);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_CESS!=null){out.print(DATA_CESS);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_INIZIO_VALID!=null){out.print(DATA_INIZIO_VALID);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_FINE_VALID!=null){out.print(DATA_FINE_VALID);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_VARIAZ!=null){out.print(DATA_VARIAZ);}else{out.print("&nbsp;");}%></TD>
                        </tr>
<%
        }
}
%>
</table>
</BODY>
</HTML>
