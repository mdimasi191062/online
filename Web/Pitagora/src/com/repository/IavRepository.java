package com.repository;

import com.model.AccountModel;
import com.model.IavModel;

import com.model.PeriodModel;

import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class IavRepository extends AbstractClassicEJB implements SessionBean {
    private Connection conn=null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs=null;
    
    private static final String queryGeAllFlussiIAV = "SELECT TC.CODE_TIPO_CONTR, TC.DESC_TIPO_CONTR FROM I5_1TIPO_CONTR TC WHERE TC.FLAG_SYS = 'S' ";  
    private static final String queryGetAllAccountFromCodeTipoContr = "SELECT AC.CODE_ACCOUNT, AC.DESC_ACCOUNT, CON.CODE_TIPO_CONTR " + 
    "FROM I5_1CONTR CON " + 
    "INNER JOIN I5_1ACCOUNT_X_CONTR AXC ON AXC.CODE_CONTR = CON.CODE_CONTR " + 
    "INNER JOIN I5_1ACCOUNT AC ON AC.CODE_ACCOUNT = AXC.CODE_ACCOUNT " + 
    "WHERE CON.CODE_TIPO_CONTR = ";
    private static final String orderByGetAllAccountFromCodeTipoContr = " ORDER BY AC.DESC_ACCOUNT ";
    
    private static final String queryGetAllPeriod = "SELECT  a.CODE_CICLO, a.DATA_INIZIO_CICLO, a.DATA_FINE_CICLO, a.DESCRIZIONE_CICLO  " + 
    "                FROM anagrafica_cicli a " + 
    "               WHERE a.data_inizio_ciclo IN ( " + 
    "                        SELECT DISTINCT (data_inizio_ciclo_fatrz) " + 
    "                                   FROM i5_2param_valoriz_sp " + 
    "                                  WHERE code_elab IS NOT NULL " + 
    "                                    AND flag_sys = 'S' " + 
    "                                    AND data_inizio_ciclo_fatrz IS NOT NULL " + 
    "                                    AND data_fine_ciclo_fatrz IS NOT NULL) " + 
    "                 AND data_inizio_ciclo > TO_DATE ('31/12/2002', 'dd/mm/yyyy') " + 
    "            ORDER BY a.data_inizio_ciclo DESC ";
    
    
    public Vector<PeriodModel> getAllPeriod() throws RemoteException,
                                                      SQLException{
                                                      
        Vector<PeriodModel> result = new Vector<PeriodModel>();
        
        try{
            
            conn = getConnection(dsName);
            
            ps = conn.prepareStatement(queryGetAllPeriod);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                PeriodModel periodModel = new PeriodModel();
                periodModel.setCode( rs.getString("CODE_CICLO") );
                periodModel.setDateStart( rs.getString("DATA_INIZIO_CICLO") );
                periodModel.setDateEnd(rs.getString("DATA_FINE_CICLO"));
                periodModel.setDescr(rs.getString("DESCRIZIONE_CICLO"));
                result.add(periodModel);
            }
            
        }catch(SQLException e){
                System.out.println (e.getMessage());
                e.printStackTrace();
                closeConnection();
            }  finally{
                  closeConnection();
              }
              
              return result;
    }
    
    
    public Vector<AccountModel> getAllAccount(String codeTipoContr) throws RemoteException,
                                                      SQLException {
                                                      
        Vector<AccountModel> result = new Vector<AccountModel>();                                     
        
        try{
            
            conn = getConnection(dsName);
            
            ps = conn.prepareStatement(queryGetAllAccountFromCodeTipoContr + codeTipoContr +
                                     orderByGetAllAccountFromCodeTipoContr);
            
            rs = ps.executeQuery();
            
            while(rs.next()){
                AccountModel acm = new AccountModel();
                acm.setCodeAccount( rs.getString("CODE_ACCOUNT") );
                acm.setCodeTipoContr(rs.getString("CODE_TIPO_CONTR"));
                acm.setDescAccount(rs.getString("DESC_ACCOUNT"));
                result.add(acm);
            }
            
        }catch(SQLException e){
                System.out.println (e.getMessage());
                e.printStackTrace();
                closeConnection();
            }  finally{
                  closeConnection();
              }
              
          return result;    
                                                      
    }
                                            
    
    public Vector<IavModel> getAllServiceIav() throws RemoteException,
                                                      SQLException {
                                                      
        Vector<IavModel> result = new Vector<IavModel>();
        
        try{    
          
          conn = getConnection(dsName);
                    
            ps = conn.prepareStatement(queryGeAllFlussiIAV);
            
            rs = ps.executeQuery();
            
            while(rs.next()) {
                IavModel data = new IavModel();
                String descTipoContr = rs.getString("DESC_TIPO_CONTR");
                if(descTipoContr.contains("_I")){
                    String finalDesc = descTipoContr.replace("_I"," ");
                    data.setCodeTipoContr( rs.getString("CODE_TIPO_CONTR") );              
                    data.setDescrTipoContr(finalDesc);
                    result.add(data);
                }
                
            }
            
          
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
            System.out.println("ERR IavRepository: " + e.getMessage());
        }
    }
    
}
