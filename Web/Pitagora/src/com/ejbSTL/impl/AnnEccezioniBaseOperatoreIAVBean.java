package com.ejbSTL.impl;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.ResultEccezioniIav;

import com.ejbSTL.TypeFlussoIav;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.*;

import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

import java.text.DateFormat;
import java.text.SimpleDateFormat;


import javax.swing.JOptionPane;

public class AnnEccezioniBaseOperatoreIAVBean extends AbstractClassicEJB implements SessionBean 
{

    private Connection conn=null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs=null;
    
    private static final String queryGetAllFlusso = "SELECT TP.ID_FLUSSO, TP.TIPO_FLUSSO, TP.DESCRIPTION FROM I5_5IAV_TIPI_FLUSSO TP WHERE TP.AMBITO != 'Error' ";  
    private static final String queryGetFluxFromCode = "SELECT TP.DESCRIPTION FROM I5_5IAV_TIPI_FLUSSO TP WHERE TP.TIPO_FLUSSO = ";  
    
    private static final String queryGetAllServizi = "SELECT DISTINCT S.CODE_SERVIZIO, S.DESCRIZIONE_SERVIZIO FROM I5_5IAV_SERVIZI S ORDER BY lpad(S.CODE_SERVIZIO,4) ASC "; 
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
  
    
    
    public Vector<ResultEccezioniIav> getTableFromFluxCodeOpe(String operatoreIav, String serviziIav, String ambitoIav, Boolean regoleCess) throws SQLException,
                                                                                 RemoteException {
        
        Vector<ResultEccezioniIav> result = new Vector<ResultEccezioniIav>();

        String queryBaseOpe="SELECT ID_REGOLA,DATA_RIFERIMENTO_DA,DATA_RIFERIMENTO_A,DATA_INIZIO_VAL,DATA_FINE_VAL,DESCRIZIONE_UTENTE,(SELECT C.DESCRIZIONE_SERVIZIO FROM I5_5IAV_SERVIZI C WHERE C.CODE_SERVIZIO = A.SERVIZIO_IAV AND ROWNUM<= 1 AND C.DESCRIZIONE_SERVIZIO LIKE '%'||A.AMBITO||'%') AS DESCR_SERVIZIO_IAV,NOMEOLO,AMBITO FROM I5_5IAV_ECC_VAL_OPERATORI A ";
        
        String queryBaseOpeWhere2="";
        String queryBaseOpeWhere1="";
        String queryBaseOpeWhere3="";
        
        String queryBaseOpeWhere4="";
        
        if(!serviziIav.contains("TUTTI")){
            queryBaseOpeWhere2=" AND (A.SERVIZIO_IAV = '"+serviziIav+"' OR A.SERVIZIO_IAV = 'TUTTI')";
            if (serviziIav.equals(""))
                queryBaseOpeWhere2="";
        }
        
        if(!operatoreIav.contains("TUTTI")){
            queryBaseOpeWhere1=" AND NOMEOLO LIKE '%"+operatoreIav+"%'";
            if (operatoreIav.equals(""))
                queryBaseOpeWhere1="";
        }
        
        if(!ambitoIav.contains("TUTTI")){
            queryBaseOpeWhere3=" AND AMBITO LIKE '%"+ambitoIav+"%'";
            if (ambitoIav.equals(""))
                queryBaseOpeWhere3="";
        }
        
        if(regoleCess==false){
            queryBaseOpeWhere4=" AND (DATA_FINE_VAL >trunc(sysdate) OR DATA_FINE_VAL is null)";
        }else{
                queryBaseOpeWhere4="";
        }
        
        if(queryBaseOpeWhere1=="" && queryBaseOpeWhere2=="" && queryBaseOpeWhere3=="" && queryBaseOpeWhere4=="")
            queryBaseOpe=queryBaseOpe;
        else
            queryBaseOpe=queryBaseOpe+"WHERE";
            
        String queryOpeWithInput=queryBaseOpe+queryBaseOpeWhere1+queryBaseOpeWhere2+queryBaseOpeWhere3+queryBaseOpeWhere4;
        
        if (queryOpeWithInput.contains("WHERE AND")) {
            queryOpeWithInput=queryOpeWithInput.replace("WHERE AND", "WHERE");
        }
        
        System.out.println(queryOpeWithInput);
        
         try{
           
           conn = getConnection(dsName);               
           ps = conn.prepareStatement(queryOpeWithInput);          
           rs = ps.executeQuery();            
           
               DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
           
           
               while (rs!=null && rs.next()) 
               {  
                   ResultEccezioniIav resultEccezioniIav = new ResultEccezioniIav();
                   String dataRifDa = dateFormat.format(rs.getDate("DATA_RIFERIMENTO_DA"));
                   String dataRifA = rs.getDate("DATA_RIFERIMENTO_A")== null ? " " : dateFormat.format(rs.getDate("DATA_RIFERIMENTO_A"));
                   String dataInizioVal = dateFormat.format(rs.getDate("DATA_INIZIO_VAL"));
                   String dataFineVal = rs.getDate("DATA_FINE_VAL")== null ? " " : dateFormat.format(rs.getDate("DATA_FINE_VAL"));
                   String descUtente = rs.getString("DESCRIZIONE_UTENTE");
                   String codice = rs.getString("ID_REGOLA");
                   
                   String servizio = rs.getString("DESCR_SERVIZIO_IAV");
                   String nomeolo = rs.getString("NOMEOLO");
                   String ambito = rs.getString("AMBITO");
                   
                   if(nomeolo==null) nomeolo="";
                   if(ambito==null) ambito="";
                   if(servizio==null) servizio="";
                  
                   resultEccezioniIav.setDataInizioVal(dataInizioVal);
                   resultEccezioniIav.setDataFineVal(dataFineVal);
                   resultEccezioniIav.setDataRifDa(dataRifDa);
                   resultEccezioniIav.setDataRifA(dataRifA);
                   resultEccezioniIav.setDescUtente(descUtente);
                   resultEccezioniIav.setCodice(codice);
                   
                   resultEccezioniIav.setNomeOlo(nomeolo);
                   resultEccezioniIav.setServizioIav(servizio);
                   resultEccezioniIav.setAmbito(ambito);
                   
                   result.add(resultEccezioniIav);                  
               }  
           
           
           }catch(SQLException e){
               System.out.println (e.getMessage());
               e.printStackTrace();
               closeConnection();
           }  finally{
                 closeConnection();
             }
        
        System.out.println(result.size());
        
        return result;
    } 
        
  
  public Vector<ResultRefuseIav> getTableFromFluxCode(String code, String startDate, String endDate, String area) throws SQLException,
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
            
      if(area.equals("STAG")){
          if(code.equals("ASS_MEN")){
              tableName = "I5_5IAV_ASS_MEN";
              tableName_err = tableName + "_ERR";
              result = getAssuranceQuery(startDate, endDate);
          } else if (code.equals("ASS_TRI")){
              tableName = "I5_5IAV_ASS_TRI";
              tableName_err = tableName + "_ERR";
              result = getAssuranceQuery(startDate, endDate);
          }else if (code.equals( "IFV_BTS")){
              tableName = "I5_5IAV_PROV_BTS";
              tableName_err = tableName + "_ERR";
              result = getProvisioningQuery(startDate, endDate);
          }else if (code.equals("IFV_ULL")){
              tableName = "I5_5IAV_PROV_ULL";
              tableName_err = tableName + "_ERR";
              result = getProvisioningQuery(startDate, endDate);
          }else {
              tableName = "I5_5IAV_PROV_WLR";
              tableName_err = tableName + "_ERR";
              result = getProvisioningQuery(startDate, endDate);
          }
      } else {
          if(code.equals("ASS_MEN")){
              tableName = "I5_5ITFR_FAT_IAV_ASS";
              tableName_err = tableName + "_ERR";
              result = getAssuranceQuery(startDate, endDate);
          } else if (code.equals("ASS_TRI")){
              tableName = "I5_5ITFR_FAT_IAV_ASS";
              tableName_err = tableName + "_ERR";
              result = getAssuranceQuery(startDate, endDate);
          }else if (code.equals( "IFV_BTS")){
              tableName = "I5_5ITFR_FAT_IAV_PROV";
              tableName_err = tableName + "_ERR";
              result = getProvisioningQuery(startDate, endDate);
          }else if (code.equals("IFV_ULL")){
              tableName = "I5_5ITFR_FAT_IAV_PROV";
              tableName_err = tableName + "_ERR";
              result = getProvisioningQuery(startDate, endDate);
          }else {
              tableName = "I5_5ITFR_FAT_IAV_PROV";
              tableName_err = tableName + "_ERR";
              result = getProvisioningQuery(startDate, endDate);
          }
      }
      
      
      return result;
  }
  
  public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
                                                          
        String name = "";
                                                          
      try{
        
        conn = getConnection(dsName);
        
        String concatQuery = "'"+ code + "'";
        
        System.out.println(queryGetFluxFromCode + concatQuery);
        
          ps = conn.prepareStatement(queryGetFluxFromCode + concatQuery);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
            name = rs.getString(1);
          }
        
      }catch(SQLException e){
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
          }  finally{
                closeConnection();
            }
            
            return name;
  }
  
    
    public Vector<ResultRefuseIav> getProvisioningQuery(String startDate, String endDate) throws SQLException,
                                                                            RemoteException {
        try{
          
          conn = getConnection(dsName);
          
          startDate =  startDate + " 00:00:00";
          endDate = endDate + " 00:00:00";
          
          Vector<ResultRefuseIav> resultqueryDistinctOk = new Vector<ResultRefuseIav>();
          
          Vector<ResultRefuseIav> resultqueryDistinctKo = new Vector<ResultRefuseIav>();
          
          String queryDistinctOk = "SELECT DISTINCT PROV.NOME_FILE FROM " +tableName +" PROV"
          + " WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
                    
          String queryDistinctKo = "SELECT DISTINCT PROV.NOME_FILE FROM " + tableName_err +  " PROV"
          + " WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
          
          ps = conn.prepareStatement(queryDistinctOk);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
                    ResultRefuseIav result =  new ResultRefuseIav();
                    
                    String nameFile = rs.getString("NOME_FILE");
                    String[] partsOfNameFile = null;
                    
                    if(nameFile != null){
                        partsOfNameFile = nameFile.split(".");
                    }

                    result.setNameFile(nameFile != null ? nameFile : null);
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
          + "  WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
          + " AND PROV.NOME_FILE = ";
          
          String countQueryKo = "SELECT COUNT(*) FROM " + tableName_err + " PROV"
          + "  WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
          + " AND PROV.NOME_FILE = ";
          
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
  
  public Vector<ResultRefuseIav> getAssuranceQuery(String startDate, String endDate) throws SQLException,
                                                                          RemoteException {
    try{
      
      conn = getConnection(dsName);
      
      startDate = startDate +  " 00:00:00";
      endDate = endDate +  " 00:00:00";
      
      Vector<ResultRefuseIav> resultqueryDistinctOk = new Vector<ResultRefuseIav>();
      
      Vector<ResultRefuseIav> resultqueryDistinctKo = new Vector<ResultRefuseIav>();
      
      String queryDistinctOk = "SELECT DISTINCT ASSM.NOME_FILE FROM " +tableName +" ASSM"
      + " WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
            
      String queryDistinctKo = "SELECT DISTINCT ASSM.NOME_FILE FROM " + tableName_err +  " ASSM"
      + " WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
      
      ps = conn.prepareStatement(queryDistinctOk);
      
      rs = ps.executeQuery();
      
      while(rs.next()) {
                ResultRefuseIav result =  new ResultRefuseIav();
                
                String nameFile = rs.getString("NOME_FILE");
                String[] partsOfNameFile = null;
                
                
                
                //System.out.println(partsOfNameFile[0]);

                result.setNameFile(nameFile != null ? nameFile : null);
                result.setNameFlow(nameFile.replace(".csv", " "));//partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                
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
      
      String countQueryOk = "SELECT COUNT(*) FROM " + tableName + " ASSM"
      + "  WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
      + " AND ASSM.NOME_FILE = ";
      
      String countQueryKo = "SELECT COUNT(*) FROM " + tableName_err + " ASSM"
      + "  WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
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
      for(int i = 0; i < resultsOk.size(); i++){
          
          ResultRefuseIav tmpResult = resultsOk.get(i);
          
          queryCountOk = queryCountOk + "  '" + tmpResult.getNameFile() + "' ";
          
          queryCountKo = queryCountKo + "  '" + tmpResult.getNameFile() + "' ";
          
          tmpResult.setCountOK( getCountFromQuery(queryCountOk).toString() );
          tmpResult.setCountKO(getCountFromQuery(queryCountKo).toString());
          
      }
      
      return resultsOk;
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

  public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                  RemoteException,
                                                  SQLException {
        
        Vector<TypeFlussoIav> eccOpeIav = new Vector<TypeFlussoIav>();

        try{
        
            conn = getConnection(dsName);
            ps = conn.prepareStatement(queryGetAllFlusso);
            rs = ps.executeQuery();
            while(rs.next()) {
                    TypeFlussoIav acquistiIav =  new TypeFlussoIav();
                    acquistiIav.setType(rs.getString("TIPO_FLUSSO"));
                    acquistiIav.setDescr(rs.getString("DESCRIPTION"));              
                    eccOpeIav.add(acquistiIav);
            } 
            
        }catch(SQLException e){
	
        System.out.println (e.getMessage());
        e.printStackTrace();
        closeConnection();
       throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_TIPI_FLUSSO","getListaFlussi","I5_1CONTR",StaticContext.FindExceptionType(e));    
        } finally{
            closeConnection();
        }
    
	return eccOpeIav;
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
        
    public Boolean alterExceptionOpe(String[] SelOf, String input) throws SQLException,
                                                                                 RemoteException {
        Boolean result=true;
        tableName="I5_5IAV_ECC_VAL_OPERATORI";
        /*
        if(endDate2.equals(null))
                endDate2="";
        
        String queryInsertExceOpe="INSERT INTO "+tableName+" (ID_REGOLA, DATA_RIFERIMENTO_DA, DATA_RIFERIMENTO_A, DATA_INIZIO_VAL, DATA_FINE_VAL,  AMBITO, SERVIZIO_IAV, NOMEOLO, NOTE, DESCRIZIONE_UTENTE, DATA_INS, DATA_UPD) "+" VALUES (SEQ_REG_OPE.NEXTVAL,' "+ startDate +" ',' "+ startDate2 +" ',' "+ endDate +" ',' "+ endDate2 +" ',' "+ ambitoIav +" ',' "+ serviziIav +" ',' "+ operatoreIav +" ',' "+ note +" ',' "+ motivazioneBlocco +" ',sysdate,sysdate)";
        */
        
        String stringForQuery="";
        for(int i=0;i<SelOf.length;i++){
            
            stringForQuery+=SelOf[i];
            
            if(i!=SelOf.length-1)
                stringForQuery+=",";
            
        }
        
        String queryAlterOpe="UPDATE "+tableName+" SET DATA_FINE_VAL =TO_DATE('"+input+"','dd/mm/yyyy'),  DATA_UPD=sysdate WHERE ID_REGOLA IN ("+stringForQuery+")";
        //IN (10, 20);;
        
        System.out.println(queryAlterOpe);
        
        try{
          
          conn = getConnection(dsName);                           
          Statement st = conn.createStatement();           
          st.executeUpdate(queryAlterOpe);         
        
            
        }catch(SQLException e){
        
               // JOptionPane.showMessageDialog(null, "Errore Generico!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                System.out.println (e.getMessage());
                e.printStackTrace();
                closeConnection();
                result=false;
                
            }  finally{
            
                  //JOptionPane.showMessageDialog(null, "Operazione eseguita con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
                  closeConnection();
                  
              }
       
        return result;
    }

}
