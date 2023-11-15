<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection,java.util.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_quadratSapSpe.jsp")%>
</logtag:logData>
<%
  int j=0;
  Collection collection=null;
  Vector aRemote2 = null;
  aRemote2 = (Vector) session.getAttribute("aRemote2");
%>

<HTML>
<HEAD>
<TITLE>Stampa Quadrature Sap Classic</TITLE>
</HEAD>
<BODY >
  <table>
  <tr>
  <td bgcolor='#D5DDF1' class="textB" width="8%">Ciclo di Valorizzazione / Repricing</td>
                          <td>Codice Account</td>
                          <td>Desc Account</td>
                          <td>Tipo Documento</td>
                          <td>Id Richiesta</td>                         
                          <td>Riscontrato</td> 
                          <td>Flag Repricing/Valorizzazione</td> 
                          <td>Data Emis</td>
                          <td>Data Acquisizione Riscontro</td>
                          <td>Data Scadenza</td>
                          <td>Num. Doc.</td>
                          <td>Num. Doc. FI</td>
                          <td>Imponibile</td>
                          <td>Imponibile Iva</td>
                          <td>Esercizio</td>
                          <td>Flusso SAP ORIGINE</td>
                          <td>NR_FATT_RIF</td>
  </tr>
                        
<%
    String DATA_DI_VALORIZZAZIONE=null;
    String CODE_ACCOUNT=null;
    String DESC_ACCOUNT=null;
    String TIPO_DOCUMENTO=null;
    String ID_RICHIESTA=null;
    String FLAG_RISCONTRO_SAP=null;
    String FLAG_REPRICING=null;
    String DATA_EMISSIONE=null;
    String DATA_ELABORAZIONE=null;    
    String DATA_SCADENZA=null; 
    String NR_FATTURA_SD=null;
    String NR_DOC_FI=null;
    String IMPORTO_FATTURA=null;
    String IMPORTO_IVA=null;
    String ESERCIZIO=null;
    String FLUSSO_SAP_ORIGINE=null;
    String NR_FATT_RIF=null;
if ( aRemote2 != null ) {
     for(j=0;(j<aRemote2.size());j++)
     {
        DB_QuadratureSap aRemote = (DB_QuadratureSap)aRemote2.elementAt(j);
          DATA_DI_VALORIZZAZIONE=aRemote.getDATA_DI_VALORIZZAZIONE();
          CODE_ACCOUNT=aRemote.getCODE_ACCOUNT();
          DESC_ACCOUNT=aRemote.getDESC_ACCOUNT();
          TIPO_DOCUMENTO=aRemote.getTIPO_DOCUMENTO();
          ID_RICHIESTA=aRemote.getID_RICHIESTA();
          FLAG_RISCONTRO_SAP=aRemote.getFLAG_RISCONTRO_SAP();
          FLAG_REPRICING=aRemote.getFLAG_REPRICING();
          DATA_EMISSIONE=aRemote.getDATA_EMISSIONE();
          DATA_ELABORAZIONE=aRemote.getDATA_ELABORAZIONE();
          DATA_SCADENZA=aRemote.getDATA_SCADENZA();
          NR_FATTURA_SD=aRemote.getNR_FATTURA_SD();
          NR_DOC_FI=aRemote.getNR_DOC_FI();
          IMPORTO_FATTURA=aRemote.getIMPORTO_FATTURA();
          IMPORTO_IVA=aRemote.getIMPORTO_IVA();
          ESERCIZIO=aRemote.getESERCIZIO();          
          FLUSSO_SAP_ORIGINE=aRemote.getFLUSSO_SAP_ORIGINE(); 
          NR_FATT_RIF=aRemote.getNR_FATT_RIF(); 
 
%>
                        <TR>
                           <TD><%if(DATA_DI_VALORIZZAZIONE!=null){out.print(DATA_DI_VALORIZZAZIONE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(CODE_ACCOUNT!=null){out.print(CODE_ACCOUNT);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DESC_ACCOUNT!=null){out.print(DESC_ACCOUNT);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(TIPO_DOCUMENTO!=null){out.print(TIPO_DOCUMENTO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(ID_RICHIESTA!=null){out.print(ID_RICHIESTA);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(FLAG_RISCONTRO_SAP!=null){out.print(FLAG_RISCONTRO_SAP);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(FLAG_REPRICING!=null){out.print(FLAG_REPRICING);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_EMISSIONE!=null){out.print(DATA_EMISSIONE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_ELABORAZIONE!=null){out.print(DATA_ELABORAZIONE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(DATA_SCADENZA!=null){out.print(DATA_SCADENZA);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(NR_FATTURA_SD!=null){out.print(NR_FATTURA_SD);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(NR_DOC_FI!=null){out.print(NR_DOC_FI);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(IMPORTO_FATTURA!=null){out.print(IMPORTO_FATTURA);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(IMPORTO_IVA!=null){out.print(IMPORTO_IVA);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(ESERCIZIO!=null){out.print(ESERCIZIO);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(FLUSSO_SAP_ORIGINE!=null){out.print(FLUSSO_SAP_ORIGINE);}else{out.print("&nbsp;");}%></TD>
                           <TD><%if(NR_FATT_RIF!=null){out.print(NR_FATT_RIF);}else{out.print("&nbsp;");}%></TD>
                        </tr>
<%
        }
}
%>
</table>
</BODY>
</HTML>
