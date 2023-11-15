package com.ejbSTL.impl;

import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;

import com.utl.DB_Account;
import com.utl.DB_AreeRaccolta;
import com.utl.DB_ListinoOpereSpeciali;
import com.utl.DB_PromoAree;
import com.utl.DB_PromoProgetto;
import com.utl.DB_Servizio;
import com.utl.PromozioniElem;
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

public class Ent_PromoProgettoBean extends AbstractSessionCommonBean implements SessionBean {
    
    public Vector getCodeProgettoAccount(String codeAccount, String codeProgetto, String codeServizio) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_promoProgetto = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getCodeProgettoAccount(?,?,?)}");
           
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.setString(2, codeAccount);
          call.setString(3, codeProgetto);
          call.setString(4, codeServizio);
          
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          
          while (lrs_Rset.next())
          {
            DB_PromoProgetto lobj_promoProgetto = new DB_PromoProgetto();
            lobj_promoProgetto.setCodeAccount(lrs_Rset.getString(1));
            lobj_promoProgetto.setCodeAccountDesc(lrs_Rset.getString(2));
            lobj_promoProgetto.setCodeProgetto(lrs_Rset.getString(3));
            
            lvct_promoProgetto.addElement(lobj_promoProgetto);
          }
          
          return lvct_promoProgetto;
        } catch (Exception lexc_Exception) {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getCodeProgettoAccount", 
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
                                      "getCodeProgettoAccount", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }

    public Vector getCodeProgettoAccountNew(String codeAccount, String codeProgetto, String codeServizio,String codePromozione) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_promoProgetto = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();
    ////PASSSSSSS
           call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getCodeProgettoAccountNew(?,?,?,?)}");  
           
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.setString(2, codeAccount);
          call.setString(3, codeProgetto);
          call.setString(4, codeServizio);
          call.setString(5, codePromozione);
          
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          
          while (lrs_Rset.next())
          {
            DB_PromoProgetto lobj_promoProgetto = new DB_PromoProgetto();
            lobj_promoProgetto.setCodeAccount(lrs_Rset.getString(1));
            lobj_promoProgetto.setCodeAccountDesc(lrs_Rset.getString(2));
            lobj_promoProgetto.setCodeProgetto(lrs_Rset.getString(3));
            lobj_promoProgetto.setCodePromozione(lrs_Rset.getString(4));
            lobj_promoProgetto.setDataInizio(lrs_Rset.getString(5));
            lobj_promoProgetto.setDataFine(lrs_Rset.getString(6));
              
            lvct_promoProgetto.addElement(lobj_promoProgetto);
          }
          
          return lvct_promoProgetto;
        } catch (Exception lexc_Exception) {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getCodeProgettoAccountNew", 
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
                                      "getCodeProgettoAccountNew", 
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

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getServiziProgetto()}");
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
                                    "getServiziProgetto", 
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
                                      "getServiziProgetto", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }

    public Vector getPromozioni() throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Servizi = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getPromozioni()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          
          while (lrs_Rset.next())
          {
            PromozioniElem lobj_Servizio = new PromozioniElem(); 
            lobj_Servizio.setCodePromozione(lrs_Rset.getString(1));
            lobj_Servizio.setDescPromozione(lrs_Rset.getString(2));
            lvct_Servizi.addElement(lobj_Servizio);
          }
          
          return lvct_Servizi;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getPromozioni", 
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
                                      "getPromozioni", 
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

    public Vector<StoredProcedureResult> insertPromozioneProgetto(String codeAccount,String codeProgetto) throws CustomException, RemoteException                                                      
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.INSERT_PROMOZIONI_PROGETTO(?, ?, ?, ?, ?, ?, ?)}");
          
            call.setString( 1, codeAccount);
            call.setString( 2, codeProgetto.toUpperCase() );
            call.setString( 3, "62" );//code_promozione FISSO a 62
            call.setString( 4,"01/01/2000" ); //data_inizio FISSA AL  01/01/2000
            call.setString( 5,"31/12/2999" );//data_fine FISSA AL 31/12/2999
            
            call.registerOutParameter(6, OracleTypes.NUMBER);
            call.registerOutParameter(7, OracleTypes.VARCHAR);
            
            call.execute();
            
            StoredProcedureResult result = new StoredProcedureResult();
            result.setErroreSql(call.getInt(6));
            result.setErroreMsg(call.getString(7));
            
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
                                             "insertPromozioneProgetto", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "insertPromozioneProgetto", 
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
                                      "insertPromozioneProgetto", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
      }


    public Vector<StoredProcedureResult> insertPromozioneProgettoNew(String codeAccount,String codeProgetto, String codePromozione, String dataIni, String dataFin) throws CustomException, RemoteException                                                      
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.INSERT_PROMOZIONI_PROGETTO_NEW(?, ?, ?, ?, ?, ?, ?)}");
          
            call.setString( 1, codeAccount);
            call.setString( 2, codeProgetto.toUpperCase() );
            call.setString( 3, codePromozione ); 
            call.setString( 4, dataIni );  
            call.setString( 5, dataFin ); 
            
            call.registerOutParameter(6, OracleTypes.NUMBER);
            call.registerOutParameter(7, OracleTypes.VARCHAR);
            
            call.execute();
            
            StoredProcedureResult result = new StoredProcedureResult();
            result.setErroreSql(call.getInt(6));
            result.setErroreMsg(call.getString(7));
            
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
                                             "insertPromozioneProgettoNew", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "insertPromozioneProgettoNew", 
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
                                      "insertPromozioneProgettoNew", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
      }



    public Vector<StoredProcedureResult> eliminaPromozioneProgetto(String codeAccount,String codeProgetto)throws CustomException, RemoteException{
    
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.DELETE_PROMOZIONI_PROGETTO(?, ?, ?, ?)}");
          
            call.setString( 1, codeAccount);
            call.setString( 2,codeProgetto );
            call.registerOutParameter(3, OracleTypes.NUMBER);
            call.registerOutParameter(4, OracleTypes.VARCHAR);
            call.execute();
            
            result.setErroreSql(call.getInt(3));
            result.setErroreMsg(call.getString(4));
            
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
                                             "eliminaPromozioneProgetto", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "eliminaPromozioneProgetto", 
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
                                      "eliminaPromozioneProgetto", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    
    public Vector<StoredProcedureResult> eliminaPromozioneProgettoNew(String codeAccount,String codeProgetto, String codePromozione)throws CustomException, RemoteException{
    
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.DELETE_PROMOZIONI_PROGETTO_NEW(?, ?, ?, ?, ?)}");
          
            call.setString( 1, codeAccount);
            call.setString( 2,codeProgetto );
            call.setString( 3,codePromozione );
            call.registerOutParameter(4, OracleTypes.NUMBER);
            call.registerOutParameter(5, OracleTypes.VARCHAR);
            call.execute();
            
            result.setErroreSql(call.getInt(4));
            result.setErroreMsg(call.getString(5));
            
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
                                             "eliminaPromozioneProgettoNew", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "eliminaPromozioneProgettoNew", 
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
                                      "eliminaPromozioneProgettoNew", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
}
