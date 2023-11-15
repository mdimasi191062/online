package com.ejbSTL.impl;

import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;

import com.utl.DB_Account;
import com.utl.DB_AreeRaccolta;
import com.utl.DB_ListinoOpereSpeciali;
import com.utl.DB_PromoAree;
import com.utl.DB_Servizio;
import com.utl.StaticContext;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.Vector;

import javax.ejb.SessionBean;

import oracle.jdbc.OracleTypes;

public class Ent_PromoAreeBean extends AbstractSessionCommonBean implements SessionBean {
    
    public Vector getAreeRaccoltaAccount(String codeAccount, String codeAreaRaccolta) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_PromoAree = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getAreeRaccoltaAccount(?,?)}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.setString(2, codeAccount);
          call.setString(3, codeAreaRaccolta);

          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_PromoAree lobj_PromoAree = new DB_PromoAree(); 
            lobj_PromoAree.setDescAccount(lrs_Rset.getString(1));
            lobj_PromoAree.setDescArea(lrs_Rset.getString(2));
           // lobj_PromoAree.setCodeAccount(lrs_Rset.getString(3));
            lobj_PromoAree.setCodeArea(lrs_Rset.getString(4));
            lobj_PromoAree.setIdPromoAree(lrs_Rset.getString(3)+"-"+lrs_Rset.getString(4));
 
            lvct_PromoAree.addElement(lobj_PromoAree);
          }
          return lvct_PromoAree;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getAreeRaccoltaAccount", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            lrs_Rset.close();
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "getAreeRaccoltaAccount", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }

    public Vector getServizi() throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Servizi = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getServizi()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          

          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_Servizio lobj_Servizio = new DB_Servizio(); 
            lobj_Servizio.setCODE_SERVIZIO(lrs_Rset.getString(1));
            lobj_Servizio.setDESC_SERVIZIO(lrs_Rset.getString(2));
            lvct_Servizi.addElement(lobj_Servizio);
          }
          return lvct_Servizi;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getServizi", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            lrs_Rset.close();
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "getServizi", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    public Vector getAreeRaccolta()throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_AreeRaccolta = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getAreeRaccolta()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);         

          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_AreeRaccolta lobj_AreeRaccolta = new DB_AreeRaccolta(); 
            lobj_AreeRaccolta.setCODE_AREERACCOLTA(lrs_Rset.getString(1));
            lobj_AreeRaccolta.setDESC_AREERACCOLTA(lrs_Rset.getString(2));
            lvct_AreeRaccolta.addElement(lobj_AreeRaccolta);
          }
          return lvct_AreeRaccolta;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getAreeRaccolta", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            lrs_Rset.close();
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "getAreeRaccolta", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }

    public Vector getAccountByCodeTipoContr(String codeTipoContr) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Accounts = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getAccountByCodeTipoContr(?)}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.setString(2, codeTipoContr);
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_Account lobj_Account = new DB_Account(); 
            lobj_Account.setCODE_ACCOUNT(lrs_Rset.getString(1));
            lobj_Account.setDESC_ACCOUNT(lrs_Rset.getString(2));
            lvct_Accounts.addElement(lobj_Account);
          }
          return lvct_Accounts;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getAccountByCodeTipoContr", 
                                    this.getClass().getName(), 
                                    StaticContext.FindExceptionType(lexc_Exception));
        } finally
        {
          try
          {
            lrs_Rset.close();
            call.close();
            dbConnection.close();
          } catch (Exception lexc_Exception)
          {
            throw new CustomException(lexc_Exception.toString(), "", 
                                      "getAccountByCodeTipoContr", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    
    public Vector<StoredProcedureResult> insertAreaRaccoltaAccount(String codeUtente,String codeArea) throws CustomException, RemoteException                                                      
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.INSERT_AREERACCOLTA_ACCOUNT(?, ?,?,?)}");
          
            call.setString( 1, codeUtente);
            call.setString( 2,codeArea );
            call.registerOutParameter(3, OracleTypes.NUMBER);
            call.registerOutParameter(4, OracleTypes.VARCHAR);
            call.execute();
            StoredProcedureResult result = new StoredProcedureResult();
            result.setErroreSql(call.getInt(3));
            result.setErroreMsg(call.getString(4));
            vec.add(result);
              
            if(result.getErroreSql()!=0){
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
                                             "insertAreaRaccoltaAccount", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "insertAreaRaccoltaAccount", 
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
                                      "insertAreaRaccoltaAccount", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
      }
    
    public Vector<StoredProcedureResult> insertAllAreaRaccoltaAccount(String codeUtente) throws CustomException, RemoteException                                                      
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.INSERT_ALL_AREERAC_ACC(?,?,?)}");
          
            call.setString( 1, codeUtente);
        //    call.setString( 2,codeArea );
            call.registerOutParameter(2, OracleTypes.NUMBER);
            call.registerOutParameter(3, OracleTypes.VARCHAR);
            call.execute();
            StoredProcedureResult result = new StoredProcedureResult();
            result.setErroreSql(call.getInt(2));
            result.setErroreMsg(call.getString(3));
            vec.add(result);
              
            if(result.getErroreSql()!=0){
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
                                             "insertAllAreaRaccoltaAccount", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "insertAllAreaRaccoltaAccount", 
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
                                      "insertAllAreaRaccoltaAccount", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
      }
    
      
    public Vector<StoredProcedureResult> eliminaAreaRaccoltaAccount(String codeUtente,String codeArea)throws CustomException, RemoteException{
    
        Connection dbConnection = null;
        CallableStatement call = null;   
        Vector vec = new Vector<StoredProcedureResult>();
        try
        {
            javax.naming.InitialContext ic = new javax.naming.InitialContext();
            javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
            dbConnection = dataSource.getConnection();
            dbConnection.setAutoCommit(false);  
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.DELETE_AREERACCOLTA_ACCOUNT(?, ?,?,?)}");
          
            call.setString( 1, codeUtente);
            call.setString( 2,codeArea );
            call.registerOutParameter(3, OracleTypes.NUMBER);
            call.registerOutParameter(4, OracleTypes.VARCHAR);
            call.execute();
            StoredProcedureResult result = new StoredProcedureResult();
            result.setErroreSql(call.getInt(3));
            result.setErroreMsg(call.getString(4));
            vec.add(result);
              
            if(result.getErroreSql()!=0){
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
                                             "eliminaAreaRaccoltaAccount", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "eliminaAreaRaccoltaAccount", 
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
                                      "eliminaAreaRaccoltaAccount", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    
    }

}
