package com.ejbSTL.impl;

import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;

import com.utl.DB_Account;
import com.utl.DB_CodiceProgetto;
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

public class Ent_CodiceProgettoBean extends AbstractSessionCommonBean implements SessionBean {
    
    int NO_SERVIZIO_LOGICO = -9; //Il valore sta ad indicare la NON presenza del servizio logico per codice progetto
    int NO_ACCOUNT = -9; //Il valore sta ad indicare la NON presenza dell account per codice progetto

    public Vector getCodeProgettoTable(int codeServizioLogico, String codeProgetto, int codeAccount) throws CustomException, RemoteException {
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        
        try
        {
          Vector lvct_codiceProgetto = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getCodeProgettoTable(?, ?, ?)}");
          
          call.registerOutParameter(1, OracleTypes.CURSOR);
          
          if ( codeServizioLogico == NO_SERVIZIO_LOGICO ) {
              call.setInt(2, 0);
          } else {
              call.setInt(2, codeServizioLogico);    
          }
          
          if ( codeAccount ==  NO_ACCOUNT ){
              call.setInt(4, 0);  
          } else {
              call.setInt(4, codeAccount);  
          }
            
          call.setString(3, codeProgetto);
          
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          
          SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
          
          while (lrs_Rset.next())
          {
            DB_CodiceProgetto lobj_codiceProgetto = new DB_CodiceProgetto();
            
            if ( lrs_Rset.getInt(1) == 0 ){
                lobj_codiceProgetto.setCodeAccountStr(" ");
            } else {
                lobj_codiceProgetto.setCodeAccountStr(Integer.toString(lrs_Rset.getInt(1)));
            }
            
            lobj_codiceProgetto.setCodeAccountDesc(lrs_Rset.getString(2)); 
            
            lobj_codiceProgetto.setTipologia(lrs_Rset.getString(3));
            lobj_codiceProgetto.setCodeServizioLogicoDesc(lrs_Rset.getString(4));
            lobj_codiceProgetto.setCodeProgetto(lrs_Rset.getString(5));
            lobj_codiceProgetto.setDataDiRiferimento(sdf.format(lrs_Rset.getDate("dataDiRiferimento")));
            
            lvct_codiceProgetto.addElement(lobj_codiceProgetto);
          }
          
          return lvct_codiceProgetto;
        } catch (Exception lexc_Exception) {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getCodeProgettoTable", 
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
                                      "getCodeProgettoTable", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }

    public Vector getServiziLogici() throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Servizi = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getServiziLogiciCodiceProgetto()}");
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
                                    "getServiziLogici", 
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
                                      "getServiziLogici", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }

    public Vector getAccountByCodeServizioLogico(String codeServizioLogico) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        int servizioLogicoInt = 0;
        
        try
        {
          Vector lvct_Accounts = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getAccountByCodeServizioLogico(?)}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          
          if ( codeServizioLogico.length() > 0 ){
            servizioLogicoInt = Integer.parseInt(codeServizioLogico);
          }
          
          call.setInt(2, servizioLogicoInt );
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
                                    "getAccountByCodeServizioLogico", 
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
                                      "getAccountByCodeServizioLogico", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    public Vector<StoredProcedureResult> insertCodiceProgetto( int codeServizioLogico, int codeAccount, int tipologia, String codeProgetto, String dataDiRiferimento ) throws CustomException, RemoteException                                                      
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.INSERT_CODICE_PROGETTO(?, ?, ?, ?, ?, ?, ?)}"); //TODO MODIFICARE INSERT CON PARAMETRO NUOVO TIPOLOGIA!!!!!
        
            call.setInt( 1, codeServizioLogico );
            call.setInt( 2, codeAccount );    
            call.setInt( 3, tipologia );
            call.setString( 4, codeProgetto.toUpperCase() );
            call.setString( 5, dataDiRiferimento );
            
            call.registerOutParameter( 6, OracleTypes.NUMBER );
            call.registerOutParameter( 7, OracleTypes.VARCHAR );
            
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
                                             "insertCodiceProgetto", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "insertCodiceProgetto", 
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
                                      "insertCodiceProgetto", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
      }

    public Vector<StoredProcedureResult> eliminaCodiceProgetto( String codeProgetto )throws CustomException, RemoteException{
    
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
            
            call = dbConnection.prepareCall("{call PKG_BILL_SPE_ONLINE.DELETE_CODICE_PROGETTO( ?, ?, ? )}");
          
            call.setString( 1, codeProgetto);
            
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
                                             "eliminaCodiceProgetto", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "eliminaCodiceProgetto", 
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
                                      "eliminaCodiceProgetto", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    
    public Vector getAnagraficaTipologia() throws CustomException, RemoteException {
    
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        
        try
        {
          Vector lvct_Tipologia = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_BILL_SPE_ONLINE.getAnagraficaTipologia()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          
          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          
          while (lrs_Rset.next())
          {
            DB_Servizio lobj_Tipologia = new DB_Servizio(); 
            
            lobj_Tipologia.setCODE_SERVIZIO(lrs_Rset.getString(1));
            lobj_Tipologia.setDESC_SERVIZIO(lrs_Rset.getString(2));
            
            lvct_Tipologia.addElement(lobj_Tipologia);
          }
          
          return lvct_Tipologia;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getAnagraficaTipologia", 
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
                                      "getAnagraficaTipologia", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
}
