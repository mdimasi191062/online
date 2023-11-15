package com.ejbSTL.impl;

import com.ejbSTL.ResultEccezioniIav;
import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.TypeFlussoIav;

import com.model.ValorPathModel;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.*;

import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class VisualizzaOrdiniAcqIAVBean extends AbstractClassicEJB implements SessionBean 
{

    private Connection conn=null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs=null;
    
    private static final String queryGetAllFlusso = "SELECT TP.ID_FLUSSO, TP.TIPO_FLUSSO, TP.DESCRIPTION FROM I5_5IAV_TIPI_FLUSSO TP WHERE TP.AMBITO != 'Error' ";  
    private static final String queryGetAllServizi = "SELECT DISTINCT S.CODE_SERVIZIO, S.DESCRIZIONE_SERVIZIO FROM I5_5IAV_SERVIZI S ORDER BY lpad(S.CODE_SERVIZIO,4) ASC ";  
    
    private static final String queryGetFluxFromCode = "SELECT DESCRIPTION FROM I5_5IAV_TIPI_FLUSSO  ";  
    private static final String queryAnagraficaBatch = "SELECT D.DESC_FUNZ, D.TIPO_FUNZ, D.PATH_REPORT, D.PATH_REPORT_STORICI, D.ESTENSIONE_FILE, D.ESTENSIONE_FILE_STORICO, D.PATH_FILE_ZIP" + 
    " FROM i5_6sys_report_download D";  
    
    private static final String queryGetAllOperatori = "SELECT DISTINCT O.CODE_GEST, O.DESCRIZIONE_OLO FROM I5_5IAV_TRASCOD_OPERATORE O ORDER BY O.CODE_GEST ASC "; 
    
    
    private String tableName = null;
    private String tableName_err = null;

 public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }
  
    public Vector<ResultRefuseIav> getTableFromFluxCode(String code, String startDate, String endDate, String area, String serviziIav, String operatoreIav) throws SQLException,RemoteException{
           Vector<ResultRefuseIav> result = new Vector<ResultRefuseIav>();
           
           tableName = null;
           tableName_err = null;
                 
           if(startDate == null){
               startDate = "01/10/2019";
           }
           
           if(endDate == null){
               endDate = "01/11/2019 ";
           }
                 
           if(area.equals("STAG")){
               if(code.equals("ASS_MEN")){
                   tableName = "I5_5IAV_ASS_MEN";
                   tableName_err = tableName + "_ERR";
                   result = getAssuranceQuery(startDate, endDate,null,serviziIav,operatoreIav);
               } else if (code.equals("ASS_TRI")){
                   tableName = "I5_5IAV_ASS_TRI";
                   tableName_err = tableName + "_ERR";
                   result = getAssuranceQuery(startDate, endDate,null,serviziIav,operatoreIav);
               }else if (code.equals( "IFV_BTS")){
                   tableName = "I5_5IAV_PROV_BTS";
                   tableName_err = tableName + "_ERR";
                   result = getProvisioningQuery(startDate, endDate,null,serviziIav,operatoreIav);
               }else if (code.equals("IFV_ULL")){
                   tableName = "I5_5IAV_PROV_ULL";
                   tableName_err = tableName + "_ERR";
                   result = getProvisioningQuery(startDate, endDate,null,serviziIav,operatoreIav);
               }else 
                   //ini R1I-20-0356
                    if (code.equals("IFV_PRO")){
                                       tableName = "I5_5IAV_PROV_OPERA";
                                       tableName_err = tableName + "_ERR";
                                       result = getProvisioningQuery(startDate, endDate,code,serviziIav,operatoreIav);
                                   }else
                   //fine R1I-20-0356
               {
                   tableName = "I5_5IAV_PROV_WLR";
                   tableName_err = tableName + "_ERR";
                   result = getProvisioningQuery(startDate, endDate,null,serviziIav,operatoreIav);
               }
           } else {
               if(code.equals("ASS_MEN")){
                   tableName = "I5_5ITFR_FAT_IAV_ASS";
                   tableName_err = tableName + "_ERR";
                   result = getAssuranceQuery(startDate, endDate,code,serviziIav,operatoreIav);
               } else if (code.equals("ASS_TRI")){
                   tableName = "I5_5ITFR_FAT_IAV_ASS";
                   tableName_err = tableName + "_ERR";
                   result = getAssuranceQuery(startDate, endDate,code,serviziIav,operatoreIav);
               }else if (code.equals( "IFV_BTS")){
                   tableName = "I5_5ITFR_FAT_IAV_PROV";
                   tableName_err = tableName + "_ERR";
                   result = getProvisioningQuery(startDate, endDate,code,serviziIav,operatoreIav);
               }else if (code.equals("IFV_ULL")){
                   tableName = "I5_5ITFR_FAT_IAV_PROV";
                   tableName_err = tableName + "_ERR";
                   result = getProvisioningQuery(startDate, endDate,code,serviziIav,operatoreIav);
               }else 
               //ini R1I-20-0356
                if (code.equals("IFV_PRO")){
                                   tableName = "I5_5ITFR_FAT_IAV_PROV_OPERA";
                                   tableName_err = tableName + "ERR";
                                   result = getProvisioningQuery(startDate, endDate,code,serviziIav,operatoreIav);
                               }else
               //fine R1I-20-0356
               {
                   tableName = "I5_5ITFR_FAT_IAV_PROV";
                   tableName_err = tableName + "_ERR";
                   result = getProvisioningQuery(startDate, endDate,code,serviziIav,operatoreIav);
               }
           }
           
           
           return result;   
       }
       
       
     public Vector<ResultRefuseIav> getAllFieldsFromFileName(String fileName, String code, String startDate, String endDate, String area) throws SQLException,
                                                                                  RemoteException {
         
         Vector<ResultRefuseIav> result = new Vector<ResultRefuseIav>();
         
         tableName = null;
         tableName_err = null;
               
         if(startDate == null){
             startDate = "01/10/2019";
         }
         
         if(endDate == null){
             endDate = "01/11/2019 ";
         }
          
          //STAGING: TRUE & INTERFACCIA: ELSE     
         if(area.equals("STAG")){
             if(code.equals("ASS_MEN")){
                 tableName = "I5_5IAV_ASS_MEN";
                 tableName_err = tableName + "_ERR";
                 result = getAssuranceQueryAllFields(fileName,startDate, endDate);
             } else if (code.equals("ASS_TRI")){
                 tableName = "I5_5IAV_ASS_TRI";
                 tableName_err = tableName + "_ERR";
                 result = getAssuranceQueryAllFields(fileName,startDate, endDate);
             }else if (code.equals( "IFV_BTS")){
                 tableName = "I5_5IAV_PROV_BTS";
                 tableName_err = tableName + "_ERR";
                 result = getProvisioningStaginQueryAllFields(fileName,startDate, endDate);
             }else if (code.equals("IFV_ULL")){
                 tableName = "I5_5IAV_PROV_ULL";
                 tableName_err = tableName + "_ERR";
                 result = getProvisioningStaginQueryAllFields(fileName,startDate, endDate);
             }else
                 //ini R1I-20-0356
                 if (code.equals("IFV_PRO")){
                     tableName = "I5_5IAV_PROV_OPERA";
                     tableName_err = tableName + "_ERR";
                     result = getProvisioningStaginQueryAllFields(fileName,startDate, endDate);
                 }else
                 //fine R1I-20-0356
             {
                 tableName = "I5_5IAV_PROV_WLR";
                 tableName_err = tableName + "_ERR";
                 result = getProvisioningStaginQueryAllFields(fileName,startDate, endDate);
             }
         } else {
             if(code.equals("ASS_MEN")){
                 tableName = "I5_5ITFR_FAT_IAV_ASS";
                 tableName_err = tableName + "_ERR";
                 result = getAssuranceInterfacciaQueryAllFields(fileName, startDate, endDate);
             } else if (code.equals("ASS_TRI")){
                 tableName = "I5_5ITFR_FAT_IAV_ASS";
                 tableName_err = tableName + "_ERR";
                 result = getAssuranceInterfacciaQueryAllFields(fileName, startDate, endDate);
             }else if (code.equals( "IFV_BTS")){
                 tableName = "I5_5ITFR_FAT_IAV_PROV";
                 tableName_err = tableName + "_ERR";
                 result = getProvisioningInterfacciaQueryAllFields(fileName, startDate, endDate, code);
             }else if (code.equals("IFV_ULL")){
                 tableName = "I5_5ITFR_FAT_IAV_PROV";
                 tableName_err = tableName + "_ERR";
                 result = getProvisioningInterfacciaQueryAllFields(fileName, startDate, endDate, code);
             }else
             //ini R1I-20-0356
              if (code.equals("IFV_PRO")){
                 tableName = "I5_5ITFR_FAT_IAV_PROV_OPERA";
                 tableName_err = tableName + "ERR";
                 result = getProvisioningInterfacciaQueryAllFields(fileName, startDate, endDate, code);
              }else
             //fine R1I-20-0356
             {
                 tableName = "I5_5ITFR_FAT_IAV_PROV";
                 tableName_err = tableName + "_ERR";
                 result = getProvisioningInterfacciaQueryAllFields(fileName, startDate, endDate, code);
             }
         }
         
         
         return result;
     }
      
      public String getNameFluxFromCode(String code) throws SQLException,
                                                              RemoteException {
                                                              
            String name = "";
                                                              
          try{
            
            conn = getConnection(dsName);
            
              String concatQuery = "";
            
            if(code != null){
                concatQuery = queryGetFluxFromCode + "WHERE TIPO_FLUSSO = '"+ code + "'";
            } else {
                concatQuery = queryGetFluxFromCode;
            }
                    
            System.out.println(concatQuery);
            
              ps = conn.prepareStatement(concatQuery);
              
              rs = ps.executeQuery();
              
              while(rs.next()) {
                name = rs.getString(1);
              }
            
              closeConnection();
            
          }catch(SQLException e){
                  System.out.println (e.getMessage());
                  e.printStackTrace();
                  closeConnection();
              }  finally{
                    closeConnection();
                }
                
                return name;
      }
      
        
        public Vector<ResultRefuseIav> getProvisioningQuery(String startDate, String endDate, String code,String serviziIav,String operatoreIav) throws SQLException,
                                                                                RemoteException {
            try{
              
              conn = getConnection(dsName);
              
              startDate =  startDate + " 00:00:00";
              endDate = endDate + " 00:00:00";
              
              Vector<ResultRefuseIav> resultqueryDistinctOk = new Vector<ResultRefuseIav>();
              
              Vector<ResultRefuseIav> resultqueryDistinctKo = new Vector<ResultRefuseIav>();
              
                  String innerCode="";
                  String whereCode="";
                  
                  String whereCodeSer="";
                  String whereCodeOpe="";
                  
                  System.out.println(code);
                  
                  if(code!=null){
                      innerCode=" INNER JOIN I5_5IAV_TIPI_FLUSSO TIF ON TIF.ID_FLUSSO = PROV.ID_FLUSSO";
                      whereCode=" AND PROV.ID_FLUSSO=(SELECT ID_FLUSSO FROM I5_5IAV_TIPI_FLUSSO TP WHERE TP.TIPO_FLUSSO='"+code+"') ";
                  }    
                  
                  if(serviziIav!=null){
                      whereCodeSer=" AND PROV.SERVIZIO_IAV='"+serviziIav+"' ";
                      } 
                      
                  if(operatoreIav!=null){
                      whereCodeOpe=" AND PROV.CODE_GEST='"+operatoreIav+"' ";
                      } 
              
                  String queryDistinctOk = "SELECT DISTINCT PROV.NOME_FILE FROM " +tableName +" PROV"
                  + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = PROV.NOME_FILE "+innerCode
                  + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                  + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe;
                        
                  String queryDistinctKo = "SELECT DISTINCT PROV.NOME_FILE FROM " + tableName_err +  " PROV"
                  + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = PROV.NOME_FILE "+innerCode
                  + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                  + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe;
              
              System.out.println(queryDistinctOk);
              ps = conn.prepareStatement(queryDistinctOk);
              
              rs = ps.executeQuery();
              
              while(rs.next()) {
                        ResultRefuseIav result =  new ResultRefuseIav();
                        
                        String nameFile = rs.getString("NOME_FILE");
                        String[] partsOfNameFile = null;
                        
                        if(nameFile != null){
                            partsOfNameFile = nameFile.split(".");
                        }

                        result.setNameFile(nameFile != null ? nameFile : "");
                        result.setNameFlow(nameFile.replace(".csv", " "));
                    
                        resultqueryDistinctOk.add(result);
                } 
                
                
                  /*ps = conn.prepareStatement(queryDistinctKo);
                  
                  rs = ps.executeQuery();
                  
                  while(rs.next()) {
                            ResultRefuseIav result =  new ResultRefuseIav();
                            
                            String nameFile = rs.getString("NOME_FILE");
                            String[] partsOfNameFile = null;
                            
                            if(nameFile != null){
                                partsOfNameFile = nameFile.split(".");
                            }

                            result.setNameFile(nameFile != null ? nameFile : null);
                            result.setNameFlow(partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                            
                            resultqueryDistinctKo.add(result);
                    } */
              
                  String countQueryOk = "SELECT COUNT(*) FROM " + tableName + " PROV"
                      + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = PROV.NOME_FILE "+innerCode
                      + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                      + "TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe
                      + " AND PROV.NOME_FILE = ";
                  
                  String countQueryKo = "SELECT COUNT(*) FROM " + tableName_err + " PROV"
                      + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = PROV.NOME_FILE "+innerCode
                      + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                      + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe
                      + " AND PROV.NOME_FILE = ";
              
                  closeConnection();
              
              return buildResultSet( resultqueryDistinctOk, resultqueryDistinctKo,countQueryOk,countQueryKo);
              
              
              }catch(SQLException e){
                  System.out.println (e.getMessage());
                  e.printStackTrace();
                  closeConnection();
              }  finally{
                    closeConnection();
                }
                
             return null;                                                           
        }
        
    public Vector<ResultRefuseIav> getProvisioningStaginQueryAllFields(String nomeFlusso,String startDate, String endDate)throws SQLException,
                                                                          RemoteException {
    
        Vector<ResultRefuseIav> results = new Vector<ResultRefuseIav>();

          try{                    
          
              conn = getConnection(dsName);
              
              String nomeFile = nomeFlusso.trim() + ".csv";
              
                  String columns = "NOME_FILE, DATA_ACQUISIZIONE, ID_FLUSSO, PROGRESSIVO_RIGA, CODICE_OLO, NOME_RAG_SOC_GEST, CODICE_CAUSALE_OLO, DESCRIZIONE_CAUSALE_OLO"
                  + ", CODICE_PROGETTO, CODICE_ORDINE_OLO, STATO_AGGR, CARATTERISTICA, VIA_OLO, PARTICELLAOLO, CIVICOOLO, COMUNE, LOCALITA_OLO, PROV, IDRISORSA, CODICE_RICHULL_TI"
                  + ", DESC_IMPRESA, MITTENTE, CARATTERISTICA, TIPO_SERVIZIO, TIPOLOGIA, CODICE_CAUSALE_SOSP_OLO, DATA_INIZIO_SOSPENSIONE, DATA_FINE_SOSPENSIONE"
                  + ", DATA_RICEZIONE_ORDINE, CODICE_CAUSALE, DESCRIZIONE_CAUSALE, DATA_ULTIMA_MODIFICA_ORDINE, DATA_CHIUSURA, FLAG_NPD, FL_MOS_MOI"
                  + ", DESC_IMPRESA, MITTENTE, TIPOLOGIA, CODICE_CAUSALE_SOSP_OLO, DATA_FINE_SOSPENSIONE, DATA_INIZIO_SOSPENSIONE, DATA_INVIO_NOTIFICA_SOSP, DESCRIZIONE_CAUSALE_SOSP_OLO"
                  + ", COGNOME_REF, EMAIL_REF, FAX_REF, MOBILE_REF, NOME_REF, QUALIFICA_REFERENTE, STATOERRORE, CODE_ERRORE, DESCRIPTION";
                  
                  String query = "SELECT " + columns + " FROM " + tableName_err +" "
                      + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = NOME_FILE "
                      + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                     + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
                      + "NOME_FILE = '" + nomeFile + "'  ";
              
              System.out.println(query);
              
              ps = conn.prepareStatement(query);
              
              rs = ps.executeQuery();
              
              while(rs.next()) {
                        ResultRefuseIav result =  new ResultRefuseIav();
                        
                        String nameFile = rs.getString("NOME_FILE");
                        String[] partsOfNameFile = null;
                        
                        result.setNameFile(nameFile != null ? nameFile : "");
                        result.setNameFlow(nameFile.replace(".csv", " "));//partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                        result.setDataAcquisizione(rs.getString("DATA_ACQUISIZIONE"));
                        result.setIdFlusso(rs.getString("ID_FLUSSO"));
                        result.setProgressivoRiga(rs.getString("PROGRESSIVO_RIGA"));
                        result.setCodiceOlo(rs.getString("CODICE_OLO"));
                        result.setNomeRagSocGest(rs.getString("NOME_RAG_SOC_GEST"));
                        result.setCodiceCausaleOlo(rs.getString("CODICE_CAUSALE_OLO"));
                        result.setDescrizioneCausaleOlo(rs.getString("DESCRIZIONE_CAUSALE_OLO"));
                        result.setCodiceProgetto(rs.getString("CODICE_PROGETTO"));
                        result.setCodiceOrdineOlo(rs.getString("CODICE_ORDINE_OLO"));
                        result.setStatoAggr(rs.getString("STATO_AGGR"));
                        result.setCaratteristica(rs.getString("CARATTERISTICA"));
                        result.setViaOlo(rs.getString("VIA_OLO"));
                        result.setParticellaOlo(rs.getString("PARTICELLAOLO"));
                        result.setCivicoOlo(rs.getString("CIVICOOLO"));
                        result.setComune(rs.getString("COMUNE"));
                        result.setLocalitaOlo(rs.getString("LOCALITA_OLO"));
                        result.setProv(rs.getString(("PROV")));
                        result.setIdRisorsa(rs.getString(("IDRISORSA")));
                        result.setCodiceRichullTi(rs.getString("CODICE_RICHULL_TI"));
                        result.setDescImpresa(rs.getString("DESC_IMPRESA"));
                        result.setMittente(rs.getString("MITTENTE"));
                        result.setCaratteristica(rs.getString("CARATTERISTICA"));
                        result.setTipoServizio(rs.getString("TIPO_SERVIZIO"));
                        result.setTipologia(rs.getString("TIPOLOGIA"));
                        result.setCodiceCausaleSospOlo(rs.getString("CODICE_CAUSALE_SOSP_OLO"));
                        result.setDataInizioSospensione(rs.getString("DATA_INIZIO_SOSPENSIONE"));
                        result.setDataFineSospensione(rs.getString("DATA_FINE_SOSPENSIONE"));
                        result.setDataRicezioneOrdine(rs.getString("DATA_RICEZIONE_ORDINE"));
                        result.setCodiceCausale(rs.getString("CODICE_CAUSALE"));
                        result.setDescrizioneCausale(rs.getString("DESCRIZIONE_CAUSALE"));
                        result.setDataUltimaModificaOrdine(rs.getString("DATA_ULTIMA_MODIFICA_ORDINE"));
                        result.setDataChiusura(rs.getString("DATA_CHIUSURA"));
                        result.setFlagNpd(rs.getString("FLAG_NPD"));
                        result.setCognomeRef(rs.getString("COGNOME_REF"));
                        result.setEmailRef(rs.getString("EMAIL_REF"));
                        result.setFaxRef(rs.getString("FAX_REF"));
                        result.setMobileRef(rs.getString("MOBILE_REF"));
                        result.setNomeRef(rs.getString("NOME_REF"));
                        result.setQualificaReferente(rs.getString("QUALIFICA_REFERENTE"));
                        result.setStatoErrore(rs.getString("STATOERRORE"));
                        result.setCodeErrrore(rs.getString("CODE_ERRORE"));
                        result.setDescrizioneErrore(rs.getString("DESCRIPTION"));
                        
                        
                         results.add(result);
                } 
                
                                    
              
              }catch(SQLException e){
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
              }  finally{
                closeConnection();
              }
              
              return results;
                                                                            
    }
    
    //INTERFACCIA ASSURANCE
    public Vector<ResultRefuseIav> getAssuranceInterfacciaQueryAllFields(String nomeFlusso,String startDate, String endDate) throws SQLException,
                                                                          RemoteException {
                                                                          
       Vector<ResultRefuseIav> results = new Vector<ResultRefuseIav>();                                                           
    
        try{
        
           conn = getConnection(dsName);
           
           String nomeFile = nomeFlusso.trim() + ".csv";
           
           String columns = "FATIAV.CODE_ITRF_FAT_XDSL, FATIAV.CODE_RICH_XDSL_TI, FATIAV.DESC_ID_RISORSA, FATIAV.CODE_TIPO_PREST, FATIAV.CODE_PREST_AGG, FATIAV.CODE_CAUS_XDSL, FATIAV.CODE_TIPO_CAUS_VARIAZ, FATIAV.CODE_COMUNE, " + 
           " FATIAV.DATA_DRO, FATIAV.DATA_DVTC, FATIAV.DATA_DEST, FATIAV.CODE_STATO_PS_XDSL, FATIAV.CODE_PS_FATT, FATIAV.DATA_ACQ_CHIUS, FATIAV.CODE_CONTR, FATIAV.TIPO_FLAG_ACQ_RICH, FATIAV.CODE_AREA_RACCOLTA, FATIAV.CODE_GEST, FATIAV.SERVIZIO_IAV, " + 
           " FATIAV.NOME_FILE, FATIAV.ID_FLUSSO, FATIAV.PROGRESSIVO_RIGA, FATIAV.IDENTIFICATIVOTT, FATIAV.ID_IDENTIFICATIVO_TT, FATIAV.TIPOSERVIZIO, FATIAV.SERVIZIO_EROGATO, FATIAV.TIPOTICKETOLO, FATIAV.OGGETTO_SEGNALATO, FATIAV.RISCONTRO, FATIAV.DATAORAINIZIOSEGN, FATIAV.DATAORAFINEDISSERVIZIO, " +
           " FATIAV.CHIUSURATT_TTMWEB, FATIAV.NOMEOLO, FATIAV.CODICEFONTE, FATIAV.DESCCAUSACHIUSURAOLO, FATIAV.CLASSIFICAZIONE_TECNICA, FATIAV.COMPETENZA_CHIUSURA, FATIAV.ANNO_CHIUSURA, FATIAV.MESE_CHIUSURA, FATIAV.RISCONTRATI_AUTORIPR, FATIAV.REMOTO_ON_FIELD, FATIAV.CODICE_IMPRESA," + 
           " FATIAV.DESCRIZIONE_IMPRESA, FATIAV.ADDR_CIRCUITINFO, FATIAV.ADDR_CUST, FATIAV.LOCATIONDESC, FATIAV.TECHASSIGNED, FATIAV.DATA_CREAZIONE_WR, FATIAV.COMPCANDATETIME"; //FATIAV.STATOERRORE, FATIAV.CODE_ERRORE, FATIAV.DESCRIPTION";
            
           String query = "SELECT " + columns + " FROM " + tableName +" FATIAV  "
           + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = FATIAV.NOME_FILE "
           + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
           + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
           + "AND FATIAV.NOME_FILE = '" + nomeFile + "'  ";
           
           System.out.println("getAssuranceInterfacciaQueryAllFields \n"  + query);
           
           ps = conn.prepareStatement(query);
           
           rs = ps.executeQuery();
            
           while(rs.next()) {
           
               ResultRefuseIav result =  new ResultRefuseIav();
               
               String nameFile = rs.getString("NOME_FILE");

               result.setNameFile(nameFile != null ? nameFile : "");

               result.setNameFlow(nameFile.replace(".csv", " "));
               
               result.setCodeItrfFatXdsl(rs.getString("CODE_ITRF_FAT_XDSL"));
               result.setCodeRichXdslTi(rs.getString("CODE_RICH_XDSL_TI"));
               result.setDescIdRisorsa(rs.getString("DESC_ID_RISORSA"));
               result.setCodeTipoPrest(rs.getString("CODE_TIPO_PREST"));
               result.setCodePrestAgg(rs.getString("CODE_PREST_AGG"));
               result.setCodeCausXdsl(rs.getString("CODE_CAUS_XDSL"));
               result.setCodeTipoCausVariaz(rs.getString("CODE_TIPO_CAUS_VARIAZ"));
               result.setCodeComune((rs.getString("CODE_COMUNE")));
               result.setDataDro(rs.getString("DATA_DRO"));
               result.setDataDvct(rs.getString("DATA_DVTC"));
               result.setDataDest(rs.getString("DATA_DEST"));
               result.setCodeStatoPsXdsl(rs.getString("CODE_STATO_PS_XDSL"));
               result.setCodePsFatt(rs.getString("CODE_PS_FATT"));
               result.setDataAcqChius(rs.getString("DATA_ACQ_CHIUS"));
               result.setCodeContr(rs.getString("CODE_CONTR"));
               result.setTipoFlashAcqRich(rs.getString("TIPO_FLAG_ACQ_RICH"));
               result.setCodeAreaRaccolta(rs.getString("CODE_AREA_RACCOLTA"));
               result.setCodeGest(rs.getString("CODE_GEST"));
               result.setServizioIav(rs.getString("SERVIZIO_IAV"));
               result.setIdFlusso(rs.getString("ID_FLUSSO"));
               result.setProgressivoRiga(rs.getString("PROGRESSIVO_RIGA"));
               result.setIdentificativoTT(rs.getString("IDENTIFICATIVOTT"));
               result.setIdIdentificativoTT(rs.getString("ID_IDENTIFICATIVO_TT"));
               result.setTipoServizio(rs.getString("TIPOSERVIZIO"));
               result.setServizioErogato(rs.getString("SERVIZIO_EROGATO"));
               result.setTipoTicketOlo(rs.getString("TIPOTICKETOLO"));
               result.setOggettoSegnalato(rs.getString("OGGETTO_SEGNALATO"));
               result.setRiscontro(rs.getString("RISCONTRO"));
               result.setDataOraInizioSegn(rs.getString("DATAORAINIZIOSEGN"));
               result.setDataOraFineServizio(rs.getString("DATAORAFINEDISSERVIZIO"));
               result.setChiusuraTTTTMWeb(rs.getString("CHIUSURATT_TTMWEB"));
               result.setNomeOlo(rs.getString("NOMEOLO"));
               result.setCodiceFonte(rs.getString("CODICEFONTE"));
               result.setDescCausaChiusuraOlo(rs.getString("DESCCAUSACHIUSURAOLO"));
               result.setClassificazioneTecnica(rs.getString("CLASSIFICAZIONE_TECNICA"));
               result.setCompetenzaChiusura(rs.getString("COMPETENZA_CHIUSURA"));
               result.setAnnoChiusura(rs.getString("ANNO_CHIUSURA"));
               result.setMeseChiusura(rs.getString("MESE_CHIUSURA"));
               result.setRiscontratiAutorip(rs.getString("RISCONTRATI_AUTORIPR"));
               result.setRemotoOnField(rs.getString("REMOTO_ON_FIELD"));
               result.setCodiceImpresa(rs.getString("CODICE_IMPRESA"));
               result.setDescrizioneImpresa(rs.getString("DESCRIZIONE_IMPRESA"));
               result.setAddCircuitInfo(rs.getString("ADDR_CIRCUITINFO"));
               result.setAddrCust(rs.getString("ADDR_CUST"));
               result.setLocationDesc(rs.getString("LOCATIONDESC"));
               result.setTechAssigned(rs.getString("TECHASSIGNED"));
               result.setDataCreazioneWr(rs.getString("DATA_CREAZIONE_WR"));
               result.setCompCandaDateTime(rs.getString("COMPCANDATETIME"));
              // result.setStatoErrore(rs.getString("STATOERRORE"));
              // result.setCodeErrrore(rs.getString("CODE_ERRORE"));
              // result.setDescrizioneErrore(rs.getString("DESCRIPTION"));
               
               results.add(result);
           }
            
       }catch(SQLException e){
           System.out.println (e.getMessage());
           e.printStackTrace();
           closeConnection();
       }  finally{
             closeConnection();
         }
         
         return results;
    }
    
    
    //INTERFACCIA ASSURANCE
    public Vector<ResultRefuseIav> getProvisioningInterfacciaQueryAllFields(String nomeFlusso,String startDate, String endDate, String tipologia) throws SQLException,
                                                                          RemoteException {
                                                                          
       Vector<ResultRefuseIav> results = new Vector<ResultRefuseIav>();                                                           
    
        try{
        
           conn = getConnection(dsName);
           
           String nomeFile = nomeFlusso.trim() + ".csv";
           
           String columns = "FATIAV.CODE_ITRF_FAT_XDSL, FATIAV.CODE_RICH_XDSL_TI, FATIAV.DESC_ID_RISORSA, FATIAV.CODE_TIPO_PREST, FATIAV.CODE_PREST_AGG, FATIAV.CODE_CAUS_XDSL, FATIAV.CODE_TIPO_CAUS_VARIAZ, FATIAV.CODE_COMUNE, " + 
           " FATIAV.DATA_DRO, FATIAV.DATA_DVTC, FATIAV.DATA_DEST, FATIAV.CODE_STATO_PS_XDSL, FATIAV.CODE_PS_FATT, FATIAV.DATA_ACQ_CHIUS, FATIAV.CODE_CONTR, FATIAV.TIPO_FLAG_ACQ_RICH, FATIAV.CODE_AREA_RACCOLTA, FATIAV.CODE_GEST, FATIAV.SERVIZIO_IAV, " + 
           " FATIAV.NOME_FILE, FATIAV.ID_FLUSSO,"+//FATIAV.STATOERRORE, FATIAV.CODE_ERRORE, FATIAV.DESCRIPTION";
           
           " FATIAV.PROGRESSIVO_RIGA, FATIAV.CODICE_OLO, FATIAV.NOME_RAG_SOC_GEST, FATIAV.CODICE_ORDINE_OLO, FATIAV.IDRISORSA, FATIAV.CODICE_RICHULL_TI, FATIAV.CODICE_CAUSALE_OLO," +
           " FATIAV.DESCRIZIONE_CAUSALE_OLO, FATIAV.CARATTERISTICA, FATIAV.DATA_ULTIMA_MODIFICA_ORDINE, FATIAV.VIA_OLO, FATIAV.PARTICELLAOLO, FATIAV.LOCALITA_OLO," +
           " FATIAV.PROV, FATIAV.DESC_IMPRESA, FATIAV.MITTENTE, FATIAV.TIPOLOGIA, FATIAV.CODICE_CAUSALE_SOSP_OLO, FATIAV.DATA_INIZIO_SOSPENSIONE, FATIAV.DATA_FINE_SOSPENSIONE," +
           " FATIAV.DATA_CHIUSURA, FATIAV.FLAG_NPD, FATIAV.COGNOME_REF, FATIAV.EMAIL_REF, FATIAV.FAX_REF, FATIAV.MOBILE_REF, FATIAV.NOME_REF, FATIAV.QUALIFICA_REFERENTE";
            
            if ("IFV_PRO".equalsIgnoreCase(tipologia)) {
                columns += ", FATIAV.FLAG_REFERENTE, FATIAV.VERIFICA_4_REF, FATIAV.CHIAMATA_4_REF, FATIAV.PIN_4_REF, FATIAV.INDICATORE_4_REF";
            }
            
           String query = "SELECT " + columns + " FROM " + tableName +" FATIAV "
           + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = FATIAV.NOME_FILE "
           + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
           + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
           + " FATIAV.NOME_FILE = '" + nomeFile + "'  ";
           
           System.out.println("getAssuranceInterfacciaQueryAllFields \n"  + query);
           
           ps = conn.prepareStatement(query);
           
           rs = ps.executeQuery();
            
           while(rs.next()) {
           
               ResultRefuseIav result =  new ResultRefuseIav();
               
               String nameFile = rs.getString(isNull("NOME_FILE"));

               result.setNameFile(nameFile != null ? nameFile : "");

               result.setNameFlow(nameFile.replace(".csv", " "));
               
               result.setCodeItrfFatXdsl(isNull(rs.getString("CODE_ITRF_FAT_XDSL")));
               result.setCodeRichXdslTi(isNull(rs.getString("CODE_RICH_XDSL_TI")));
               result.setDescIdRisorsa(isNull(rs.getString("DESC_ID_RISORSA")));
               result.setCodeTipoPrest(isNull(rs.getString("CODE_TIPO_PREST")));
               result.setCodePrestAgg(isNull(rs.getString("CODE_PREST_AGG")));
               result.setCodeCausXdsl(isNull(rs.getString("CODE_CAUS_XDSL")));
               result.setCodeTipoCausVariaz(isNull(rs.getString("CODE_TIPO_CAUS_VARIAZ")));
               result.setCodeComune(isNull(rs.getString("CODE_COMUNE")));
               result.setDataDro(isNull(rs.getString("DATA_DRO")));
               result.setDataDvct(isNull(rs.getString("DATA_DVTC")));
               result.setDataDest(isNull(rs.getString("DATA_DEST")));
               result.setCodeStatoPsXdsl(isNull(rs.getString("CODE_STATO_PS_XDSL")));
               result.setCodePsFatt(isNull(rs.getString("CODE_PS_FATT")));
               result.setDataAcqChius(isNull(rs.getString("DATA_ACQ_CHIUS")));
               result.setCodeContr(isNull(rs.getString("CODE_CONTR")));
               result.setTipoFlashAcqRich(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));
               result.setCodeAreaRaccolta(isNull(rs.getString("CODE_AREA_RACCOLTA")));
               result.setCodeGest(isNull(rs.getString("CODE_GEST")));
               result.setServizioIav(isNull(rs.getString("SERVIZIO_IAV")));
               result.setIdFlusso(isNull(rs.getString("ID_FLUSSO")));
               
               result.setProgressivoRiga(isNull(rs.getString("PROGRESSIVO_RIGA")));
               result.setCodiceOlo(isNull(rs.getString("CODICE_OLO")));
               result.setNomeRagSocGest(isNull(rs.getString("NOME_RAG_SOC_GEST")));       
               result.setCodiceOrdineOlo(isNull(rs.getString("CODICE_ORDINE_OLO")));
               result.setIdRisorsa(isNull(rs.getString("IDRISORSA")));
               result.setCodiceRichullTi(isNull(rs.getString("CODICE_RICHULL_TI")));
               result.setCodiceCausaleOlo(isNull(rs.getString("CODICE_CAUSALE_OLO")));
               result.setDescrizioneCausaleOlo(isNull(rs.getString("DESCRIZIONE_CAUSALE_OLO")));
               result.setCaratteristica(isNull(rs.getString("CARATTERISTICA")));
               result.setDataUltimaModificaOrdine(isNull(rs.getString("DATA_ULTIMA_MODIFICA_ORDINE")));
               result.setViaOlo(isNull(rs.getString("VIA_OLO")));          
               result.setParticellaOlo(isNull(rs.getString("PARTICELLAOLO")));
               result.setLocalitaOlo(isNull(rs.getString("LOCALITA_OLO")));
               result.setProv(isNull(rs.getString("PROV")));
               result.setDescImpresa(isNull(rs.getString("DESC_IMPRESA")));
               result.setMittente(isNull(rs.getString("MITTENTE")));
               result.setTipologia(isNull(rs.getString("TIPOLOGIA")));
               result.setCodiceCausaleSospOlo(isNull(rs.getString("CODICE_CAUSALE_SOSP_OLO")));
               result.setDataInizioSospensione(isNull(rs.getString("DATA_INIZIO_SOSPENSIONE")));
               result.setDataFineSospensione(isNull(rs.getString("DATA_FINE_SOSPENSIONE")));               
               result.setDataChiusura(isNull(rs.getString("DATA_CHIUSURA")));
               result.setFlagNpd(isNull(rs.getString("FLAG_NPD")));
               result.setCognomeRef(isNull(rs.getString("COGNOME_REF")));
               result.setEmailRef(isNull(rs.getString("EMAIL_REF")));
               result.setFaxRef(isNull(rs.getString("FAX_REF")));
               result.setMobileRef(isNull(rs.getString("MOBILE_REF")));
               result.setNomeRef(isNull(rs.getString("NOME_REF")));
               result.setQualificaReferente(isNull(rs.getString("QUALIFICA_REFERENTE")));    

               result.setFlagReferente(isNull(rs.getString("FLAG_REFERENTE")));    
               result.setVerifica4Ref(isNull(rs.getString("VERIFICA_4_REF")));    
               result.setChiamata4Ref(isNull(rs.getString("CHIAMATA_4_REF")));    
               result.setPin4Ref(isNull(rs.getString("PIN_4_REF")));    
               result.setIndicatore4Ref(isNull(rs.getString("INDICATORE_4_REF")));    
               
               /*result.setStatoErrore(rs.getString("STATOERRORE"));
               result.setCodeErrrore(rs.getString("CODE_ERRORE"));
               result.setDescrizioneErrore(rs.getString("DESCRIPTION"));*/
               
               results.add(result);
           }
            
       }catch(SQLException e){
           System.out.println (e.getMessage());
           e.printStackTrace();
           closeConnection();
       }  finally{
             closeConnection();
         }
         
         return results;
    }
    
    private String isNull(String value) {
        if (value == null) {
            return "";
        } else {
            if ("null".equalsIgnoreCase(value)) {
                return "";
            }
            return value;
        }
    }
    
    // STAGING ASSURANCE
    public Vector<ResultRefuseIav> getAssuranceQueryAllFields(String nomeFlusso,String startDate, String endDate) throws SQLException,
                                                                          RemoteException {
              
            Vector<ResultRefuseIav> results = new Vector<ResultRefuseIav>();

               try{
                   
                   conn = getConnection(dsName);
                   
                   
                   String nomeFile = nomeFlusso.trim() + ".csv";
                   
                   String columns = "NOME_FILE, DATA_ACQUISIZIONE, ID_FLUSSO, PROGRESSIVO_RIGA, IDENTIFICATIVOTT, ID_IDENTIFICATIVO_TT, TIPOSERVIZIO, SERVIZIO_EROGATO, TIPOTICKETOLO,"
                   + " OGGETTO_SEGNALATO, RISCONTRO, DATAORAINIZIOSEGN, DATAORAFINEDISSERVIZIO, CHIUSURATT_TTMWEB, NOMEOLO, CODICEFONTE,"
                   + " DESCCAUSACHIUSURAOLO, CLASSIFICAZIONE_TECNICA, COMPETENZA_CHIUSURA, ANNO_CHIUSURA, MESE_CHIUSURA, RISCONTRATI_AUTORIPR, REMOTO_ON_FIELD,"
                   + " CODICE_IMPRESA, DESCRIZIONE_IMPRESA, ADDR_CIRCUITINFO, ADDR_CUST, LOCATIONDESC, TECHASSIGNED, DATA_CREAZIONE_WR, COMPCANDATETIME, STATOERRORE, CODE_ERRORE, DESCRIPTION";
                   
                   String query = "SELECT " + columns + " FROM " + tableName_err +" "
                   + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = NOME_FILE "
                   + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                   + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
                   + "NOME_FILE = '" + nomeFile + "'  ";
                   
                   System.out.println(query);
                   
                   ps = conn.prepareStatement(query);
                   
                   rs = ps.executeQuery();

                   
                   while(rs.next()) {
                             ResultRefuseIav result =  new ResultRefuseIav();
                             
                             String nameFile = rs.getString("NOME_FILE");
                             String[] partsOfNameFile = null;
                             
                             result.setNameFile(nameFile != null ? nameFile : "");
                             result.setNameFlow(nameFile.replace(".csv", " "));//partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                             result.setDataAcquisizione(rs.getString("DATA_ACQUISIZIONE"));
                            result.setIdFlusso(rs.getString("ID_FLUSSO"));
                             result.setProgressivoRiga(rs.getString("PROGRESSIVO_RIGA"));
                             result.setIdentificativoTT(rs.getString("IDENTIFICATIVOTT"));
                             result.setIdIdentificativoTT(rs.getString("ID_IDENTIFICATIVO_TT"));
                             result.setTipoServizio(rs.getString("TIPOSERVIZIO"));
                             result.setServizioErogato(rs.getString("SERVIZIO_EROGATO"));
                             result.setTipoTicketOlo(rs.getString("TIPOTICKETOLO"));
                             result.setOggettoSegnalato(rs.getString("OGGETTO_SEGNALATO"));
                             result.setRiscontro(rs.getString("RISCONTRO"));
                             result.setDataOraInizioSegn(rs.getString("DATAORAINIZIOSEGN"));
                             result.setDataOraFineServizio(rs.getString("DATAORAFINEDISSERVIZIO"));
                             result.setChiusuraTTTTMWeb(rs.getString("CHIUSURATT_TTMWEB"));
                             result.setNomeOlo(rs.getString("NOMEOLO"));
                             result.setCodiceFonte(rs.getString("CODICEFONTE"));
                             result.setDescCausaChiusuraOlo(rs.getString("DESCCAUSACHIUSURAOLO"));
                             result.setClassificazioneTecnica(rs.getString("CLASSIFICAZIONE_TECNICA"));
                             result.setCompetenzaChiusura(rs.getString("COMPETENZA_CHIUSURA"));
                             result.setAnnoChiusura(rs.getString("ANNO_CHIUSURA"));
                             result.setMeseChiusura(rs.getString("MESE_CHIUSURA"));
                             result.setRiscontratiAutorip(rs.getString("RISCONTRATI_AUTORIPR"));
                             result.setRemotoOnField(rs.getString("REMOTO_ON_FIELD"));
                             result.setCodiceImpresa(rs.getString("CODICE_IMPRESA"));
                             result.setDescrizioneImpresa(rs.getString("DESCRIZIONE_IMPRESA"));
                             result.setAddCircuitInfo(rs.getString("ADDR_CIRCUITINFO"));
                             result.setAddrCust(rs.getString("ADDR_CUST"));
                             result.setLocationDesc(rs.getString("LOCATIONDESC"));
                             result.setTechAssigned(rs.getString("TECHASSIGNED"));
                             result.setDataCreazioneWr(rs.getString("DATA_CREAZIONE_WR"));
                             result.setCompCandaDateTime(rs.getString("COMPCANDATETIME"));
                             result.setTypology("STAG_ASS");
                             result.setStatoErrore(rs.getString("STATOERRORE"));
                            result.setCodeErrrore(rs.getString("CODE_ERRORE"));
                            result.setDescrizioneErrore(rs.getString("DESCRIPTION"));
                             
                             
                              results.add(result);
                     } 
                     
                                         
                   
               }catch(SQLException e){
                   System.out.println (e.getMessage());
                   e.printStackTrace();
                   closeConnection();
               }  finally{
                     closeConnection();
                 }
                 
            return results;

    }
      
      public Vector<ResultRefuseIav> getAssuranceQuery(String startDate, String endDate, String code,String serviziIav,String operatoreIav) throws SQLException,
                                                                              RemoteException {
        try{
          
          conn = getConnection(dsName);
          
          startDate = startDate +  " 00:00:00";
          endDate = endDate +  " 00:00:00";
          
          Vector<ResultRefuseIav> resultqueryDistinctOk = new Vector<ResultRefuseIav>();
          
          Vector<ResultRefuseIav> resultqueryDistinctKo = new Vector<ResultRefuseIav>();
          
          String innerCode="";
          String whereCode="";
          
          String whereCodeOpe="";
          String whereCodeSer="";
          
              if(code!=null){
                  innerCode=" INNER JOIN I5_5IAV_TIPI_FLUSSO TIF ON TIF.ID_FLUSSO = ASSM.ID_FLUSSO";
                  whereCode=" AND ASSM.ID_FLUSSO=(SELECT ID_FLUSSO FROM I5_5IAV_TIPI_FLUSSO TP WHERE TP.TIPO_FLUSSO='"+code+"') ";
                  } 
                  
                  
              if(serviziIav!=null){
                  whereCodeSer=" AND ASSM.SERVIZIO_IAV='"+serviziIav+"' ";
                  } 
                  
              if(operatoreIav!=null){
                  whereCodeOpe=" AND ASSM.CODE_GEST='"+operatoreIav+"' ";
                  } 
          
              String queryDistinctOk = "SELECT DISTINCT ASSM.NOME_FILE FROM " +tableName +" ASSM"
                  + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = ASSM.NOME_FILE "+innerCode
                  + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                  + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe;
                    
              String queryDistinctKo = "SELECT DISTINCT ASSM.NOME_FILE FROM " + tableName_err +  " ASSM"
                  + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = ASSM.NOME_FILE "+innerCode
                  + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                  + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe;
              
          ps = conn.prepareStatement(queryDistinctOk);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
                    ResultRefuseIav result =  new ResultRefuseIav();
                    
                    String nameFile = rs.getString("NOME_FILE");

                    result.setNameFile(nameFile != null ? nameFile : "");
                    result.setNameFlow(nameFile.replace(".csv", " "));//partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                    
                    resultqueryDistinctOk.add(result);
            } 
            
            
              ps = conn.prepareStatement(queryDistinctKo);
              
              rs = ps.executeQuery();
              
              while(rs.next()) {
                        ResultRefuseIav result =  new ResultRefuseIav();
                        
                        String nameFile = rs.getString("NOME_FILE");                    
                       

                        result.setNameFile(nameFile != null ? nameFile : "");
                        result.setNameFlow(nameFile.replace(".csv", " "));     
                        
                        resultqueryDistinctKo.add(result);
                } 
          
              String countQueryOk = "SELECT COUNT(*) FROM " + tableName + " ASSM"
                  + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = ASSM.NOME_FILE "+innerCode
                  + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                  + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe
                  + " AND ASSM.NOME_FILE = ";
              
              String countQueryKo = "SELECT COUNT(*) FROM " + tableName_err + " ASSM"
                  + " INNER JOIN  I5_5IAV_FILE_INPUT FINPUT ON FINPUT.NOME_FILE = ASSM.NOME_FILE "+innerCode
                  + " WHERE TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
                  + " TO_DATE( SUBSTR(FINPUT.DATA_ACQUISIZIONE, 1 , INSTR(FINPUT.DATA_ACQUISIZIONE, '_')-1), 'YYYYMMDD') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"+whereCode+whereCodeSer+whereCodeOpe
                  + " AND ASSM.NOME_FILE = ";
          
          return buildResultSet( resultqueryDistinctOk, resultqueryDistinctKo,countQueryOk,countQueryKo);
          
          
          }catch(SQLException e){
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
          }  finally{
                closeConnection();
            }
            
         return null;
      }
      
      public Vector<ResultRefuseIav> buildResultSet(Vector<ResultRefuseIav> resultsOk, Vector<ResultRefuseIav> resultsKo, String queryCountOk, String queryCountKo) throws SQLException,
                                                                                  RemoteException {
                                                                                         
          Vector<ResultRefuseIav> result =  resultsOk.size() > 0 ? resultsOk : resultsKo;     
                                                                                  
          for(int i = 0; i < result.size(); i++){
              
              ResultRefuseIav tmpResult = result.get(i);
              
              String _queryCountOk = "";
              String _queryCountKo = "";
              
              _queryCountOk = queryCountOk + "  '" + tmpResult.getNameFile() + "' ";
            
             _queryCountKo = queryCountKo + "  '" + tmpResult.getNameFile() + "' ";
              
              System.out.println(_queryCountKo);
              
              tmpResult.setCountOK( getCountFromQuery(_queryCountOk).toString() );
              tmpResult.setCountKO(getCountFromQuery(_queryCountKo).toString());
              
          }
          
          return result;
      }
      
      public Integer getCountFromQuery(String query) throws SQLException,
                                                              RemoteException {
            Integer tot = 0;                                                  
                                                              
          try{
              
              conn = getConnection(dsName);
              
              ps = conn.prepareStatement(query);
              
              rs = ps.executeQuery();
              
              while(rs.next()) {
                tot = rs.getInt(1);
              }
                        
          }catch(SQLException e){
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
          }  finally{
                closeConnection();
            }
            
            return tot;
      }
    


    
    public ValorPathModel getInfoFromType(String type)throws RemoteException,
                                                      SQLException{
                                                      
        ValorPathModel result = new ValorPathModel();
        
        try{
            
            conn = getConnection(dsName);
            
            String query =queryAnagraficaBatch +  " WHERE D.TIPO_FUNZ = '" + type + "'";
            
            
            System.out.println("QUERY: " +  query);
            
            ps = conn.prepareStatement(query);
                        
            rs = ps.executeQuery();
            
            rs.next();
                        
            result.setCode( rs.getString("TIPO_FUNZ") ) ;
            result.setDescr(rs.getString("DESC_FUNZ"));
            result.setExtFile(rs.getString("ESTENSIONE_FILE"));
            result.setExtFileStorico(rs.getString("ESTENSIONE_FILE_STORICO"));
            result.setPathZip(rs.getString("PATH_FILE_ZIP"));
            result.setPathStorico(rs.getString("PATH_REPORT_STORICI"));
            
        }catch(SQLException e){
                System.out.println (e.getMessage());
                e.printStackTrace();
                closeConnection();
            }  finally{
                  closeConnection();
              }
              
              return result;
    }

  public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                  RemoteException,
                                                  SQLException {
        
        Vector<TypeFlussoIav> listOrdiniAcqiIav = new Vector<TypeFlussoIav>();

        try{
        
            conn = getConnection(dsName);
            ps = conn.prepareStatement(queryGetAllFlusso);
            rs = ps.executeQuery();
            while(rs.next()) {
                    TypeFlussoIav acquistiIav =  new TypeFlussoIav();
                    acquistiIav.setType(rs.getString("TIPO_FLUSSO"));
                    acquistiIav.setDescr(rs.getString("DESCRIPTION"));              
                    listOrdiniAcqiIav.add(acquistiIav);
            } 
            
        }catch(SQLException e){
	
        System.out.println (e.getMessage());
        e.printStackTrace();
        closeConnection();
       throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_TIPI_FLUSSO","getListaFlussi","I5_1CONTR",StaticContext.FindExceptionType(e));    
        } finally{
            closeConnection();
        }
    
	return listOrdiniAcqiIav;
  }  
  
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
            Vector<TypeFlussoIav> listServiziIAV = new Vector<TypeFlussoIav>();

            try{
            
                conn = getConnection(dsName);
                ps = conn.prepareStatement(queryGetAllServizi);
                rs = ps.executeQuery();
                while(rs.next()) {
                        TypeFlussoIav listServiziIAVarr =  new TypeFlussoIav();
                        listServiziIAVarr.setType(rs.getString("CODE_SERVIZIO"));
                        listServiziIAVarr.setDescr(rs.getString("DESCRIZIONE_SERVIZIO"));              
                        listServiziIAV.add(listServiziIAVarr);
                } 
                
            }catch(SQLException e){
            
            System.out.println (e.getMessage());
            e.printStackTrace();
            closeConnection();
           throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_SERVIZI","getListaServizi","",StaticContext.FindExceptionType(e));    
            } finally{
                closeConnection();
            }
        
            return listServiziIAV;
      } 
      
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
            Vector<TypeFlussoIav> listOperatoriIAV = new Vector<TypeFlussoIav>();

            try{
            
                conn = getConnection(dsName);
                ps = conn.prepareStatement(queryGetAllOperatori);
                rs = ps.executeQuery();
                while(rs.next()) {
                        TypeFlussoIav listOperatoriIAVarr =  new TypeFlussoIav();
                        listOperatoriIAVarr.setType(rs.getString("CODE_GEST"));
                        listOperatoriIAVarr.setDescr(rs.getString("DESCRIZIONE_OLO"));              
                        listOperatoriIAV.add(listOperatoriIAVarr);
                } 
                
            }catch(SQLException e){
            
            System.out.println (e.getMessage());
            e.printStackTrace();
            closeConnection();
           throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_TRASCOD_OPERATORE","getListaOperatore","",StaticContext.FindExceptionType(e));    
            } finally{
                closeConnection();
            }
        
            return listOperatoriIAV;
      }
      
    public String getPathJPUB2Download() throws SQLException,
                                                                            RemoteException {
        String result = "";

        String queryOpeWithInput="SELECT PATH FROM J2_DOWNLOAD_PARAM WHERE CODICE_FUNZIONE='DOWNLOAD_JPUB2'";
           
        System.out.println(queryOpeWithInput);
        
         try{
           
           conn = getConnection(dsName);               
           ps = conn.prepareStatement(queryOpeWithInput);          
           rs = ps.executeQuery();            

           while(rs.next()) {
                result = rs.getString("PATH");
           }
           
            System.out.println(result);

           }catch(SQLException e){
               System.out.println (e.getMessage());
               e.printStackTrace();
               closeConnection();
           }  finally{
                 closeConnection();
             }
        
        return result;                                                        
    }
  
  
  private void closeConnection() throws SQLException {
      try{
          if (rs != null){
                    rs.close();
                  }
            ps.close();
          conn.close();
      }catch (SQLException e){
          
      }
  }

}
