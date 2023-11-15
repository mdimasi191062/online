<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page import="com.ejbSTL.*, com.utl.*, com.usr.*,java.util.Collection,java.util.*" %>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"stampa_repdecomm.jsp")%>
</logtag:logData>
<%
  int j=0;
  Collection collection=null;
  Vector aRemote2 = null;
  aRemote2 = (Vector) session.getAttribute("aRemote2");
  String strlistaOAO = null;
  String strFilename = null;
  
  strlistaOAO = (String) session.getAttribute("strlistaOAO");
  strFilename = (String) session.getAttribute("strFilename");
  if (strlistaOAO.equalsIgnoreCase("-1"))
  {
    strlistaOAO = "";
  }
 
  if (strFilename.equalsIgnoreCase("-1"))
  {
    strFilename = "";
  }
%>

<HTML>
<HEAD>
<TITLE>Report Decommissioning</TITLE>
</HEAD>
<BODY >
    <table>
    <tr><td>Filtri di ricerca</td></tr>
    <tr>
      <td bgcolor='#D5DDF1' class="textB" width="8%">Nome File: <%=strFilename%></td>
                          <td>Codice OAO: <%=strlistaOAO%></td>
    </tr>
     <tr>
     <td bgcolor='#D5DDF1' class="textB" width="8%"></td>
                          <td></td>
     </tr>
    </table>
    
  <table>
  <tr>
            
  <td bgcolor='#D5DDF1' class="textB" width="8%">File Name</td>
                        <td>Codice <br> OAO</td>            
                        <td>ID Ordine OAO Cess</td>         
                        <td>Id Risorsa Cess</td>            
                        <td>Data DRO Cess</td>              
                        <td>Data Des Cess</td>              
                        <td>Tipo Contr Cess</td>            
                        <td>Codice Contr Cess</td>          
                        <td>Tipo Ordine Cess</td>           
                        <td>Data NDC CNT Cess</td>          
                        <td>Codice NDC CNT Cess</td>        
                        <td>Id Ordine OAO Att</td>          
                        <td>Id Risorsa Att</td>             
                        <td>Data Dro Att</td>               
                        <td>Data Des Att</td>               
                        <td>Tipo Contr Att</td>             
                        <td>Codice Contr Att</td>           
                        <td>Tipo Ordine Att</td>            
                        <td>Data Ndc CAN Att</td>           
                        <td>Codice Ndc CAN Att</td>         
                        <td>Data Ndc CNT Att</td>           
                        <td>Codice Ndc CNT Att</td>         
                        <td>Esito Elab</td>                 
                        <td>Descr Scarto</td>               
                        <td>Data Elab</td>                  
                        <td>Flag Canoni</td>                
                        <td>Flag Contributi</td>            
                        <td>Code Invent Old</td>            
                        <td>Code Ps Old</td>                
                        <td>Code Tariffa Canone Old</td>    
                        <td>Code Pr Tariffa Canone Old</td> 
                        <td>Tipo Tariffa Canone Old</td>    
                        <td>Code Tariffa Contrib Old</td>   
                        <td>Code Pr Tariffa Contrib Old</td>
                        <td>Tipo Tariffa Contrib Old</td>   
                        <td>Code Invent New</td>            
                        <td>Code Ps New</td>                
                        <td>Code Tariffa Canone New</td>    
                        <td>Code Pr Tariffa Canone New</td> 
                        <td>Tipo Tariffa Canone New</td>    
                        <td>Code Tariffa Contrib New</td>   
                        <td>Code Pr Tariffa Contrib New</td>
                        <td>Tipo Tariffa Contrib New</td>   
                        <td>Deco</td>                       
  </tr>
                        
<%
                String FILE_NAME=null;                  
                String CODICE_OAO=null;                 
                String ID_ORDINE_OAO_CESS=null;         
                String ID_RISORSA_CESSE=null;           
                String DATA_DRO_CESSE=null;             
                String DATA_DES_CESS=null;              
                String TIPO_CONTR_CESS=null;            
                String CODICE_CONTR_CESSE=null;         
                String TIPO_ORDINE_CESSE=null;          
                String DATA_NDC_CNT_CESS=null;          
                String CODICE_NDC_CNT_CESS=null;        
                String ID_ORDINE_OAO_ATT=null;          
                String ID_RISORSA_ATT=null;             
                String DATA_DRO_ATT=null;               
                String DATA_DES_ATT=null;               
                String TIPO_CONTR_ATT=null;             
                String CODICE_CONTR_ATT=null;           
                String TIPO_ORDINE_ATT=null;            
                String DATA_NDC_CAN_ATT=null;           
                String CODICE_NDC_CAN_ATT=null;         
                String DATA_NDC_CNT_ATT=null;           
                String CODICE_NDC_CNT_ATT=null;         
                String ESITO_ELAB=null;                 
                String DESCR_SCARTO=null;               
                String DATA_ELAB=null;                  
                String FLAG_CANONI=null;                
                String FLAG_CONTRIBUTI=null;            
                String CODE_INVENT_OLD=null;            
                String CODE_PS_OLD=null;                
                String CODE_TARIFFA_CANONE_OLD=null;    
                String CODE_PR_TARIFFA_CANONE_OLD=null; 
                String TIPO_TARIFFA_CANONE_OLD=null;    
                String CODE_TARIFFA_CONTRIB_OLD=null;   
                String CODE_PR_TARIFFA_CONTRIB_OLD=null;
                String TIPO_TARIFFA_CONTRIB_OLD=null;   
                String CODE_INVENT_NEW=null;            
                String CODE_PS_NEW=null;                
                String CODE_TARIFFA_CANONE_NEW=null;    
                String CODE_PR_TARIFFA_CANONE_NEW=null; 
                String TIPO_TARIFFA_CANONE_NEW=null;    
                String CODE_TARIFFA_CONTRIB_NEW=null;   
                String CODE_PR_TARIFFA_CONTRIB_NEW=null;
                String TIPO_TARIFFA_CONTRIB_NEW=null;   
                String DECO=null;                       

if ( aRemote2 != null ) {
     for(j=0;(j<aRemote2.size());j++)
     {
    
        I5_5DECO_ACCESSI_NOW_JPUB aRemote = (I5_5DECO_ACCESSI_NOW_JPUB)aRemote2.elementAt(j);
                              FILE_NAME=aRemote.getFILE_NAME();                                     
                              CODICE_OAO=aRemote.getCODICE_OAO();                                    
                              ID_ORDINE_OAO_CESS=aRemote.getID_ORDINE_OAO_CESS();                            
                              ID_RISORSA_CESSE=aRemote.getID_RISORSA_CESSE();                                           
                              DATA_DRO_CESSE=aRemote.getDATA_DRO_CESSE();                                
                              DATA_DES_CESS=aRemote.getDATA_DES_CESS();                                 
                              TIPO_CONTR_CESS=aRemote.getTIPO_CONTR_CESS();                               
                              CODICE_CONTR_CESSE=aRemote.getCODICE_CONTR_CESSE();                            
                              TIPO_ORDINE_CESSE=aRemote.getTIPO_ORDINE_CESSE();                             
                              DATA_NDC_CNT_CESS=aRemote.getDATA_NDC_CNT_CESS();                             
                              CODICE_NDC_CNT_CESS=aRemote.getCODICE_NDC_CNT_CESS();                           
                              ID_ORDINE_OAO_ATT=aRemote.getID_ORDINE_OAO_ATT();                             
                              ID_RISORSA_ATT=aRemote.getID_RISORSA_ATT();                                
                              DATA_DRO_ATT=aRemote.getDATA_DRO_ATT();                                  
                              DATA_DES_ATT=aRemote.getDATA_DES_ATT();                                  
                              TIPO_CONTR_ATT=aRemote.getTIPO_CONTR_ATT();                                
                              CODICE_CONTR_ATT=aRemote.getCODICE_CONTR_ATT();                              
                              TIPO_ORDINE_ATT=aRemote.getTIPO_ORDINE_ATT();                                             
                              DATA_NDC_CAN_ATT=aRemote.getDATA_NDC_CAN_ATT();                                                                       
                              CODICE_NDC_CAN_ATT=aRemote.getCODICE_NDC_CAN_ATT();                                                                                                
                              DATA_NDC_CNT_ATT=aRemote.getDATA_NDC_CNT_ATT();                              
                              CODICE_NDC_CNT_ATT=aRemote.getCODICE_NDC_CNT_ATT();                            
                              ESITO_ELAB=aRemote.getESITO_ELAB();                                                                                                 
                              DESCR_SCARTO=aRemote.getDESCR_SCARTO();                                                                                                 
                              DATA_ELAB=aRemote.getDATA_ELAB();                                                                                                                           
                              FLAG_CANONI=aRemote.getFLAG_CANONI();                                                                                                                                                     
                              FLAG_CONTRIBUTI=aRemote.getFLAG_CONTRIBUTI();                                                                                                                                                     
                              CODE_INVENT_OLD=aRemote.getCODE_INVENT_OLD();                                              
                              CODE_PS_OLD=aRemote.getCODE_PS_OLD();                                              
                              CODE_TARIFFA_CANONE_OLD=aRemote.getCODE_TARIFFA_CANONE_OLD();                                              
                              CODE_PR_TARIFFA_CANONE_OLD=aRemote.getCODE_PR_TARIFFA_CANONE_OLD();                                              
                              TIPO_TARIFFA_CANONE_OLD=aRemote.getTIPO_TARIFFA_CANONE_OLD();                       
                              CODE_TARIFFA_CONTRIB_OLD=aRemote.getCODE_TARIFFA_CONTRIB_OLD();                                               
                              CODE_PR_TARIFFA_CONTRIB_OLD=aRemote.getCODE_PR_TARIFFA_CONTRIB_OLD();                                                                         
                              TIPO_TARIFFA_CONTRIB_OLD=aRemote.getTIPO_TARIFFA_CONTRIB_OLD();                                                                         
                              CODE_INVENT_NEW=aRemote.getCODE_INVENT_NEW();                                                                         
                              CODE_PS_NEW=aRemote.getCODE_PS_NEW();                                                                                                   
                              CODE_TARIFFA_CANONE_NEW=aRemote.getCODE_TARIFFA_CANONE_NEW();                       
                              CODE_PR_TARIFFA_CANONE_NEW=aRemote.getCODE_PR_TARIFFA_CANONE_NEW();                    
                              TIPO_TARIFFA_CANONE_NEW=aRemote.getTIPO_TARIFFA_CANONE_NEW();                                              
                              CODE_TARIFFA_CONTRIB_NEW=aRemote.getCODE_TARIFFA_CONTRIB_NEW();                      
                              CODE_PR_TARIFFA_CONTRIB_NEW=aRemote.getCODE_PR_TARIFFA_CONTRIB_NEW();                    
                              TIPO_TARIFFA_CONTRIB_NEW=aRemote.getTIPO_TARIFFA_CONTRIB_NEW();                                                                     
                              DECO=aRemote.getDECO();                                          
%>
                        <TR>
                  	      <TD><%if(FILE_NAME!=null){out.print(FILE_NAME);}else{out.print("&nbsp;");}%></TD>                                     
                              <TD><%if(CODICE_OAO!=null){out.print(CODICE_OAO);}else{out.print("&nbsp;");}%></TD>                                    
                              <TD><%if(ID_ORDINE_OAO_CESS!=null){out.print(ID_ORDINE_OAO_CESS);}else{out.print("&nbsp;");}%></TD>                            
                              <TD><%if(ID_RISORSA_CESSE!=null){out.print(ID_RISORSA_CESSE);}else{out.print("&nbsp;");}%></TD>                                           
                              <TD><%if(DATA_DRO_CESSE!=null){out.print(DATA_DRO_CESSE);}else{out.print("&nbsp;");}%></TD>                                
                              <TD><%if(DATA_DES_CESS!=null){out.print(DATA_DES_CESS);}else{out.print("&nbsp;");}%></TD>                                 
                              <TD><%if(TIPO_CONTR_CESS!=null){out.print(TIPO_CONTR_CESS);}else{out.print("&nbsp;");}%></TD>                               
                              <TD><%if(CODICE_CONTR_CESSE!=null){out.print(CODICE_CONTR_CESSE);}else{out.print("&nbsp;");}%></TD>                            
                              <TD><%if(TIPO_ORDINE_CESSE!=null){out.print(TIPO_ORDINE_CESSE);}else{out.print("&nbsp;");}%></TD>                             
                              <TD><%if(DATA_NDC_CNT_CESS!=null){out.print(DATA_NDC_CNT_CESS);}else{out.print("&nbsp;");}%></TD>                             
                              <TD><%if(CODICE_NDC_CNT_CESS!=null){out.print(CODICE_NDC_CNT_CESS);}else{out.print("&nbsp;");}%></TD>                           
                              <TD><%if(ID_ORDINE_OAO_ATT!=null){out.print(ID_ORDINE_OAO_ATT);}else{out.print("&nbsp;");}%></TD>                             
                              <TD><%if(ID_RISORSA_ATT!=null){out.print(ID_RISORSA_ATT);}else{out.print("&nbsp;");}%></TD>                                
                              <TD><%if(DATA_DRO_ATT!=null){out.print(DATA_DRO_ATT);}else{out.print("&nbsp;");}%></TD>                                  
                              <TD><%if(DATA_DES_ATT!=null){out.print(DATA_DES_ATT);}else{out.print("&nbsp;");}%></TD>                                  
                              <TD><%if(TIPO_CONTR_ATT!=null){out.print(TIPO_CONTR_ATT);}else{out.print("&nbsp;");}%></TD>                                
                              <TD><%if(CODICE_CONTR_ATT!=null){out.print(CODICE_CONTR_ATT);}else{out.print("&nbsp;");}%></TD>                              
                              <TD><%if(TIPO_ORDINE_ATT!=null){out.print(TIPO_ORDINE_ATT);}else{out.print("&nbsp;");}%></TD>                                             
                              <TD><%if(DATA_NDC_CAN_ATT!=null){out.print(DATA_NDC_CAN_ATT);}else{out.print("&nbsp;");}%></TD>                                                                       
                              <TD><%if(CODICE_NDC_CAN_ATT!=null){out.print(CODICE_NDC_CAN_ATT);}else{out.print("&nbsp;");}%></TD>                                                                                                
                              <TD><%if(DATA_NDC_CNT_ATT!=null){out.print(DATA_NDC_CNT_ATT);}else{out.print("&nbsp;");}%></TD>                              
                              <TD><%if(CODICE_NDC_CNT_ATT!=null){out.print(CODICE_NDC_CNT_ATT);}else{out.print("&nbsp;");}%></TD>                            
                              <TD><%if(ESITO_ELAB!=null){out.print(ESITO_ELAB);}else{out.print("&nbsp;");}%></TD>                                                                                                 
                              <TD><%if(DESCR_SCARTO!=null){out.print(DESCR_SCARTO);}else{out.print("&nbsp;");}%></TD>                                                                                                 
                              <TD><%if(DATA_ELAB!=null){out.print(DATA_ELAB);}else{out.print("&nbsp;");}%></TD>                                                                                                                           
                              <TD><%if(FLAG_CANONI!=null){out.print(FLAG_CANONI);}else{out.print("&nbsp;");}%></TD>                                                                                                                                                     
                              <TD><%if(FLAG_CONTRIBUTI!=null){out.print(FLAG_CONTRIBUTI);}else{out.print("&nbsp;");}%></TD>                                                                                                                                                     
                              <TD><%if(CODE_INVENT_OLD!=null){out.print(CODE_INVENT_OLD);}else{out.print("&nbsp;");}%></TD>                                              
                              <TD><%if(CODE_PS_OLD!=null){out.print(CODE_PS_OLD);}else{out.print("&nbsp;");}%></TD>                                              
                              <TD><%if(CODE_TARIFFA_CANONE_OLD!=null){out.print(CODE_TARIFFA_CANONE_OLD);}else{out.print("&nbsp;");}%></TD>                                              
                              <TD><%if(CODE_PR_TARIFFA_CANONE_OLD!=null){out.print(CODE_PR_TARIFFA_CANONE_OLD);}else{out.print("&nbsp;");}%></TD>                                              
                              <TD><%if(TIPO_TARIFFA_CANONE_OLD!=null){out.print(TIPO_TARIFFA_CANONE_OLD);}else{out.print("&nbsp;");}%></TD>                       
                              <TD><%if(CODE_TARIFFA_CONTRIB_OLD!=null){out.print(CODE_TARIFFA_CONTRIB_OLD);}else{out.print("&nbsp;");}%></TD>                                               
                              <TD><%if(CODE_PR_TARIFFA_CONTRIB_OLD!=null){out.print(CODE_PR_TARIFFA_CONTRIB_OLD);}else{out.print("&nbsp;");}%></TD>                                                                         
                              <TD><%if(TIPO_TARIFFA_CONTRIB_OLD!=null){out.print(TIPO_TARIFFA_CONTRIB_OLD);}else{out.print("&nbsp;");}%></TD>                                                                         
                              <TD><%if(CODE_INVENT_NEW!=null){out.print(CODE_INVENT_NEW);}else{out.print("&nbsp;");}%></TD>                                                                         
                              <TD><%if(CODE_PS_NEW!=null){out.print(CODE_PS_NEW);}else{out.print("&nbsp;");}%></TD>                                                                                                   
                              <TD><%if(CODE_TARIFFA_CANONE_NEW!=null){out.print(CODE_TARIFFA_CANONE_NEW);}else{out.print("&nbsp;");}%></TD>                       
                              <TD><%if(CODE_PR_TARIFFA_CANONE_NEW!=null){out.print(CODE_PR_TARIFFA_CANONE_NEW);}else{out.print("&nbsp;");}%></TD>                    
                              <TD><%if(TIPO_TARIFFA_CANONE_NEW!=null){out.print(TIPO_TARIFFA_CANONE_NEW);}else{out.print("&nbsp;");}%></TD>                                              
                              <TD><%if(CODE_TARIFFA_CONTRIB_NEW!=null){out.print(CODE_TARIFFA_CONTRIB_NEW);}else{out.print("&nbsp;");}%></TD>                      
                              <TD><%if(CODE_PR_TARIFFA_CONTRIB_NEW!=null){out.print(CODE_PR_TARIFFA_CONTRIB_NEW);}else{out.print("&nbsp;");}%></TD>                    
                              <TD><%if(TIPO_TARIFFA_CONTRIB_NEW!=null){out.print(TIPO_TARIFFA_CONTRIB_NEW);}else{out.print("&nbsp;");}%></TD>                                                                     
                              <TD><%if(DECO!=null){out.print(DECO);}else{out.print("&nbsp;");}%></TD>                                          
                        </tr>
<%
        }
}
%>
</table>
</BODY>
</HTML>
