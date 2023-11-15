package com.repository;

import com.model.PeriodModel;
import com.model.ValorPathModel;

import com.utl.AbstractClassicEJB;

import java.rmi.RemoteException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.Vector;

import javax.ejb.SessionBean;

public class ReportRepository extends AbstractClassicEJB implements SessionBean{
    
    private Connection conn=null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs=null;
    
    private static final String constValorizzazione = "V";
    private static final String constRepricing = "R";
    
    private static final String queryAnagraficaBatch = "SELECT D.DESC_FUNZ, D.TIPO_FUNZ, D.PATH_REPORT, D.PATH_REPORT_STORICI, D.ESTENSIONE_FILE, D.ESTENSIONE_FILE_STORICO, D.PATH_FILE_ZIP" + 
    " FROM i5_6sys_report_download D";
    
    private static final String queryAnagraficaFileValorizzazione = queryAnagraficaBatch + " WHERE D.TIPO_FUNZ = '" + constValorizzazione + "'";
    
    private static final String queryAnagraficaFileRepricing = queryAnagraficaBatch + " WHERE D.TIPO_FUNZ = '" + constRepricing + "'";

    
    public ValorPathModel getInfoFromType(String type)throws RemoteException,
                                                      SQLException{
                                                      
        ValorPathModel result = new ValorPathModel();
        
        try{
            
            conn = getConnection(dsName);
            
            String query = "";
            
            if(constValorizzazione.equals(type)){
                query = queryAnagraficaFileValorizzazione;
            }else {
                query = queryAnagraficaFileRepricing;
            }
            
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
            result.setPathReport(rs.getString("PATH_REPORT"));
            
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
