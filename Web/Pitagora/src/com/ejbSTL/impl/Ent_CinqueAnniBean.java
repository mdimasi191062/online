package com.ejbSTL.impl;

import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;
import com.utl.DB_Account;
import com.utl.DB_DataDa;
import com.utl.DB_InventProd;
import com.utl.DB_Istanza;
import com.utl.DB_Prodotto;
import com.utl.DB_PromoAree;
import com.utl.DB_Servizio;
import com.utl.DB_WarningValori;
import com.utl.StaticContext;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;

import java.sql.SQLException;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Vector;

import javax.ejb.SessionBean;

import oracle.jdbc.OracleTypes;

public class Ent_CinqueAnniBean  extends AbstractSessionCommonBean implements SessionBean {
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

          call = dbConnection.prepareCall("{? = call PKG_CINQUE_ANNI.getServizi()}");
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
    public Vector getRisorse() throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Prodotti = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_CINQUE_ANNI.getRisorse()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          

          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_Istanza lobj_Prodotto = new DB_Istanza(); 
            lobj_Prodotto.setCODE_ISTANZA(lrs_Rset.getString(1));
            lobj_Prodotto.setDESC_ISTANZA(lrs_Rset.getString(1));
            lvct_Prodotti.addElement(lobj_Prodotto);
          }
          return lvct_Prodotti;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getRisorse", 
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
                                      "getRisorse", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    public Vector getDataDa() throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_DataDa = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_CINQUE_ANNI.getDataDa()}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          

          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
            DB_DataDa lobj_DataDa = new DB_DataDa(); 
            lobj_DataDa.setCODE_DATADA(lrs_Rset.getString(1));
            lobj_DataDa.setDESC_DATADA(lrs_Rset.getString(1));
            lvct_DataDa.addElement(lobj_DataDa);
          }
          return lvct_DataDa;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getDataDa", 
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
                                      "getDataDa", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }
    public Vector getAccountByCodeServizio(String codeServizio) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        try
        {
          Vector lvct_Accounts = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_CINQUE_ANNI.getAccountByCodeServizio(?)}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.setString(2, codeServizio);
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
                                    "getAccountByCodeServizio", 
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
                                      "getAccountByCodeServizio", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }    
    public Vector getWarningValori(String codeAccount, String dataDa, String risorsa) throws CustomException, RemoteException{
        
        Connection dbConnection = null;
        ResultSet lrs_Rset = null;
        CallableStatement call = null;
        DateFormat format= new SimpleDateFormat("dd/MM/yy");
        java.util.Date date=null;
        Date sqlDate=null;
        try
        {
          if(codeAccount==""){
           codeAccount =null;
          }
          /*if(dataDa!=""){
           date = format.parse(dataDa);
           sqlDate = new java.sql.Date(date.getTime());
           
          }*/
           if(risorsa==""){
            risorsa =null;
           }
          Vector lvct_cinqueAnni = new Vector();
          javax.naming.InitialContext ic = new javax.naming.InitialContext();
          javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
          dbConnection = dataSource.getConnection();

          call = dbConnection.prepareCall("{? = call PKG_CINQUE_ANNI.getWarningValori(?,?,?)}");
          call.registerOutParameter(1, OracleTypes.CURSOR);
          call.setString(2, codeAccount);
          call.setString(3, dataDa);
          call.setString(4, risorsa);

          call.execute();

          lrs_Rset = (ResultSet)call.getObject(1);
          while (lrs_Rset.next())
          {
              /* STATO,CODE_RIGA,CODE_OGG_FATRZ,DATA_DA,IMPORTO,CODE_ISTANZA,IVA,FLAG_FC_IVA,NR_FATTURA_SD*/

            DB_WarningValori lobj_WarningValori = new DB_WarningValori(); 
            lobj_WarningValori.setSTATO(lrs_Rset.getString(1));
            lobj_WarningValori.setCODE_RIGA(lrs_Rset.getString(2));
            lobj_WarningValori.setCODE_OGG_FATRZ(lrs_Rset.getString(3)+"-"+lrs_Rset.getString(4));
            lobj_WarningValori.setDATA_DA(lrs_Rset.getString(5));
            lobj_WarningValori.setDATA_A(lrs_Rset.getString(6));
            lobj_WarningValori.setIMPORTO(lrs_Rset.getString(7));
            lobj_WarningValori.setCODE_ISTANZA(lrs_Rset.getString(8));
            lobj_WarningValori.setIVA(lrs_Rset.getString(9));
            lobj_WarningValori.setFLAG_FC_IVA(lrs_Rset.getString(10));
            lobj_WarningValori.setDESC_CLASSE_OGG_FATRZ(lrs_Rset.getString(11));
//DOR - Add -            
            lobj_WarningValori.setFATT_NDC(setValueFattureNdc(lrs_Rset.getString(12)));
            lobj_WarningValori.setCODE_ACCOUNT(lrs_Rset.getString(13));
            
            lvct_cinqueAnni.addElement(lobj_WarningValori);
          }
          return lvct_cinqueAnni;
        } catch (Exception lexc_Exception)
        {
          throw new CustomException(lexc_Exception.toString(), "", 
                                    "getWarningValori", 
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
                                      "getWarningValori", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    }    
    public Vector<StoredProcedureResult> updateCinqueAnni(String codeRiga,int status)throws CustomException, RemoteException{
    
        Connection dbConnection = null;
        CallableStatement call = null;   
        Vector vec = new Vector<StoredProcedureResult>();
        try
        {
            javax.naming.InitialContext ic = new javax.naming.InitialContext();
            javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
            dbConnection = dataSource.getConnection();
            dbConnection.setAutoCommit(false);  
            
            call = dbConnection.prepareCall("{call PKG_CINQUE_ANNI.updateCinqueAnni(?, ?,?,?)}");
          
            call.setInt( 1, Integer.parseInt(codeRiga));
            call.setInt( 2,status );
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
                                             "updateCinqueAnni", 
                                             this.getClass().getName(), 
                                             StaticContext.FindExceptionType(lexc_Exception));
            }
           throw new CustomException(lexc_Exception.toString(), "", 
                                    "updateCinqueAnni", 
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
                                      "updateCinqueAnni", 
                                      this.getClass().getName(), 
                                      StaticContext.FindExceptionType(lexc_Exception));
          }
        }
    
    }
    public String setValueFattureNdc(String fattNdc){
        if (fattNdc.compareTo("F") == 0){
          return  fattNdc += "T";
        } else {
          return  fattNdc += "C";
        }
    }
}
