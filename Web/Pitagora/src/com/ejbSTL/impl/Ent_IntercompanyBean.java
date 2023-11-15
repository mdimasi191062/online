package com.ejbSTL.impl;

import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;

import com.utl.DB_Account;
import com.utl.DB_CodiceProgetto;
import com.utl.DB_Intercompany;
import com.utl.DB_Servizio;
import com.utl.StaticContext;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.text.SimpleDateFormat;

import java.util.Vector;

import javax.ejb.SessionBean;

import oracle.jdbc.OracleTypes;

public class Ent_IntercompanyBean extends AbstractSessionCommonBean implements SessionBean {
    
    int NO_SERVIZIO_LOGICO = -9; //Il valore sta ad indicare la NON presenza del servizio logico per codice progetto
    int NO_ACCOUNT = -9; //Il valore sta ad indicare la NON presenza dell account per codice progetto

    //public Vector getCodeProgettoTable(int codeServizioLogico, String codeProgetto, int codeAccount) throws CustomException, RemoteException {
    public Vector getIntercompany() throws CustomException, RemoteException {
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        
        try
        {
//          Vector lvct_codiceProgetto = new Vector();
          Vector lvct_Intercompany = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getIntercompany()}");
          
          call.registerOutParameter(1, OracleTypes.CURSOR);
          
         
          call.execute();
        
          lrs_Rset = (ResultSet)call.getObject(1);
        
          while (lrs_Rset.next())
          {
            DB_Intercompany lobj_intercompany = new DB_Intercompany();
            
            lobj_intercompany.setCodiceCliente(lrs_Rset.getString(1)); 
            
            lobj_intercompany.setDenominazione(lrs_Rset.getString(2));
            
            lvct_Intercompany.addElement(lobj_intercompany);
          }
          
          return lvct_Intercompany;
        } catch (Exception lexc_Exception) {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getIntercompany", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally {
          try
          {
            lrs_Rset.close();
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "getIntercompany", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }


    public Vector<StoredProcedureResult> insertIntercompany( String codeCliente, String denominazione ) throws CustomException, RemoteException                                                      
    {
        Connection dbConnection = null;
        CallableStatement call = null;   
        Vector vec = new Vector<StoredProcedureResult>();
        
        try
        {
            javax.naming.InitialContext ic = new javax.naming.InitialContext();
            javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
            dbConnection = dataSource.getConnection();
            dbConnection.setAutoCommit(false);  
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.INSERT_INTERCOMPANY(?, ?, ?, ?)}"); 
        
            call.setString( 1, codeCliente );
            call.setString( 2, denominazione );
            
            call.registerOutParameter( 3, OracleTypes.NUMBER );
            call.registerOutParameter( 4, OracleTypes.VARCHAR );
            
            call.execute();
            
            StoredProcedureResult result = new StoredProcedureResult();
            
            result.setErroreSql(call.getInt(3));
            result.setErroreMsg(call.getString(4));
            
            vec.add(result);
              
            if( result.getErroreSql() !=0 ){
                dbConnection.rollback();
                return vec;
            }
        
            dbConnection.commit();
            return vec;
        } 
        catch (Exception lexc_Exception)
        {
           try {
                dbConnection.rollback();
           } catch (SQLException e) {
                    throw new CustomException(lexc_Exception.toString(), "", 
                                             "insertIntercompany", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "insertIntercompany", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "insertIntercompany", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
      }

    public Vector<StoredProcedureResult> eliminaIntercompany( String codeCliente )throws CustomException, RemoteException{
    
        Connection dbConnection = null;
        CallableStatement call = null;   
        Vector vec = new Vector<StoredProcedureResult>();
        StoredProcedureResult result = new StoredProcedureResult();
        try
        {
            javax.naming.InitialContext ic = new javax.naming.InitialContext();
            javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
            dbConnection = dataSource.getConnection();
            dbConnection.setAutoCommit(false);  
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.DELETE_INTERCOMPANY( ?, ?, ? )}");
          
            call.setString( 1, codeCliente);
            
            call.registerOutParameter(2, OracleTypes.NUMBER);
            call.registerOutParameter(3, OracleTypes.VARCHAR);
            
            call.execute();
            
            result.setErroreSql(call.getInt(2));
            result.setErroreMsg(call.getString(3));
            
            vec.add(result);
              
            if(result.getErroreSql() != 0){
                dbConnection.rollback();
                return vec;
            }
        
            dbConnection.commit();
            return vec;
        } 
        catch (Exception lexc_Exception)
        {
           try {
                    dbConnection.rollback();
           } catch (SQLException e) {
                    throw new CustomException(lexc_Exception.toString(), "", 
                                             "eliminaIntercompany", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "eliminaIntercompany", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "eliminaIntercompany", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
}
