package com.ejbSTL.impl;

import com.utl.*;

import java.rmi.*;

import java.sql.*;

import java.text.*;

import java.util.*;

import javax.ejb.*;

import oracle.jdbc.*;


public class Ent_ListinoOpereSpecialiBean extends AbstractSessionCommonBean implements SessionBean
{

  public Vector getListinoOpereSpeciali(String pstr_CodeTipoContr) throws CustomException, RemoteException
  {
    Connection dbConnection = null;
    ResultSet lrs_Rset = null;
    CallableStatement call = null;
    try
    {
      Vector lvct_ListinoOpereSpeciali = new Vector();
      javax.naming.InitialContext ic = new javax.naming.InitialContext();
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
      dbConnection = dataSource.getConnection();

      call = dbConnection.prepareCall("{? = call PKG_OPERE_SPECIALI.getListinoOpereSpeciali(?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.setString(2, pstr_CodeTipoContr);
      call.execute();

      lrs_Rset = (ResultSet)call.getObject(1);
      while (lrs_Rset.next())
      {
        DB_ListinoOpereSpeciali lobj_ListinoOpereSpeciali = new DB_ListinoOpereSpeciali();
        lobj_ListinoOpereSpeciali.setDescListinoApplicato(lrs_Rset.getString(1));
        lvct_ListinoOpereSpeciali.addElement(lobj_ListinoOpereSpeciali);
      }
      return lvct_ListinoOpereSpeciali;
    } catch (Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(), "", 
                                "getListinoOpereSpeciali", 
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
                                  "getListinoOpereSpeciali", 
                                  this.getClass().getName(), 
                                  StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  }

  public Vector<TariffaOpereSpeciali> getTariffeByListino(String listino, String pstr_CodeTipoContr, String vuota) throws CustomException, RemoteException
  {
    Connection dbConnection = null;
    ResultSet lrs_Rset = null;
    CallableStatement call = null;
    try
    {
      Vector<TariffaOpereSpeciali> lvct_ListinoOpereSpeciali = new Vector();
      javax.naming.InitialContext ic = new javax.naming.InitialContext();
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
      dbConnection = dataSource.getConnection();

      call = dbConnection.prepareCall("{? = call PKG_OPERE_SPECIALI.getTariffeByListino(?,?,?)}");
      call.registerOutParameter(1, OracleTypes.CURSOR);
      call.setString(2, listino);
      call.setString(3, pstr_CodeTipoContr);
      call.setString(4, vuota);
      call.execute();

      lrs_Rset = (ResultSet)call.getObject(1);
      while (lrs_Rset.next())
      {
        TariffaOpereSpeciali tariffa = new TariffaOpereSpeciali();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        if(!"Y".equalsIgnoreCase(vuota))
        {
          tariffa.setDataInizioTariffa(sdf.format(lrs_Rset.getDate("DATA_INIZIO_TARIFFA")));
          tariffa.setDataFineTariffa((lrs_Rset.getDate("DATA_FINE_TARIFFA")== null) ? "" : sdf.format(lrs_Rset.getDate("DATA_FINE_TARIFFA")));
        }
        tariffa.setDescTariffa(lrs_Rset.getString("DESC_TARIFFA").trim());
        tariffa.setIdVoce(lrs_Rset.getInt("ID_VOCE"));
        tariffa.setImpTariffa(lrs_Rset.getDouble("IMPT_TARIFFA"));
        tariffa.setUnitaMisura(lrs_Rset.getString("UNITA_MISURA"));
        tariffa.setCodeTariffa(lrs_Rset.getString("CODE_TARIFFA"));
        tariffa.setCodePrTariffa(lrs_Rset.getString("CODE_PR_TARIFFA"));
        tariffa.setDescEsSP(lrs_Rset.getString("DESC_ES_PS"));
        lvct_ListinoOpereSpeciali.addElement(tariffa);
      }
      return lvct_ListinoOpereSpeciali;
    } catch (Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(), "", 
                                "getTariffeByListino", 
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
                                  "getTariffeByListino", 
                                  this.getClass().getName(), 
                                  StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  }
  
  public boolean checkListinoExsists(String listino, String pstr_CodeTipoContr) throws CustomException, RemoteException
  {
    Vector<TariffaOpereSpeciali> lvct_ListinoOpereSpeciali = getTariffeByListino(listino, pstr_CodeTipoContr,"N");
    return lvct_ListinoOpereSpeciali.size() > 0;
  }
  
  public void checkAndUpdateListino(String oldListinoDescr, String pstr_CodeTipoContr, String newListinoDescr, Vector<String> tariffaDescr) throws CustomException, RemoteException
  {
    boolean exists = checkListinoExsists(newListinoDescr, pstr_CodeTipoContr);
    if(exists)
    {
      throw new CustomException("Esiste un listino con la stessa descrizione", "Esiste un listino con la stessa descrizione", 
                                "checkAndUpdateListino", 
                                this.getClass().getName(), 
                                "CustomException");
    }
    updateListino(oldListinoDescr, newListinoDescr, tariffaDescr);
  }
  
  public void updateListino(String oldListinoDescr, String newListinoDescr, Vector<String> tariffaDescr) throws CustomException, RemoteException
  {
    Connection dbConnection = null;
    CallableStatement call = null;
    try
    {
      javax.naming.InitialContext ic = new javax.naming.InitialContext();
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
      dbConnection = dataSource.getConnection();
      call = dbConnection.prepareCall("{? = call PKG_OPERE_SPECIALI.updateListino(?,?,?,?)}");
      for(int i=0; i<tariffaDescr.size(); i++)
      {
        call.registerOutParameter(1, OracleTypes.NUMBER);
        call.setString(2, oldListinoDescr);
        call.setString(3, newListinoDescr);
        call.setString(4, tariffaDescr.get(i));
        call.setInt(5, i + 1);
        call.execute();
      }
    } catch (Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(), "", 
                                "updateListino", 
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
                                  "updateListino", 
                                  this.getClass().getName(), 
                                  StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  }
  
  
  public Vector<StoredProcedureResult> insertTariffa(String codeUtente, String dataInizioTariffa, String descListinoApplicato,List<TariffaOpereSpecialiPar> jsonObj) throws CustomException, RemoteException                                                      
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
        for (int i =0; i<jsonObj.size();i++)
        {             
         // TariffaOpereSpecialiPar jsonObj = googleJson.fromJson(jo.get(i), TariffaOpereSpecialiPar.class);
          //colonna0:"idVoce", colonna1:"descEsSP", colonna2:"impTariffa", colonna3:"descTariffa", colonna4:"unitaMisura"
          int idVoce = Integer.valueOf(jsonObj.get(i).getColonna0());
          String imptTariffa = jsonObj.get(i).getColonna2();
          String descTariffa = jsonObj.get(i).getColonna3();
         // String codeUnitaMisura = jsonObj.get(i).getColonna4();     
     
      call = dbConnection.prepareCall("{call PKG_OPERE_SPECIALI.INSERT_TARIFFA_OS(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
      
      call.setString( 1, codeUtente);
      call.setInt( 2,idVoce );
      call.setString( 3, dataInizioTariffa );
      call.setString( 4, descTariffa );
      call.setString( 5, imptTariffa );
      //call.setString( 6, codeUnitaMisura );
      call.setString( 6, null ); 
      call.setString( 7, descListinoApplicato );
      call.registerOutParameter(8, OracleTypes.NUMBER);
      call.registerOutParameter(9, OracleTypes.VARCHAR);
      call.execute();
      StoredProcedureResult result = new StoredProcedureResult();
      result.setErroreSql(call.getInt(8));
      result.setErroreMsg(call.getString(9));
      vec.add(result);
          if(result.getErroreSql()!=0){
            dbConnection.rollback();
      return vec;
          }
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
                                "insertTariffa", 
                                this.getClass().getName(), 
                                StaticContext.FindExceptionType(lexc_Exception));
        }
        throw new CustomException(lexc_Exception.toString(), "", 
                                  "insertTariffa", 
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
                                  "insertTariffa", 
                                  this.getClass().getName(), 
                                  StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  }
      
  /*  public Vector<StoredProcedureResult> insertTariffa(String codeUtente, int idVoce, String dataInizioTariffa, String descTariffa, String imptTariffa, String codeUnitaMisura, String descListinoApplicato) throws CustomException, RemoteException                                                      
  {
    Connection dbConnection = null;
    CallableStatement call = null;
    
    try
    {
      javax.naming.InitialContext ic = new javax.naming.InitialContext();
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
      dbConnection = dataSource.getConnection();
      call = dbConnection.prepareCall("{call PKG_OPERE_SPECIALI.INSERT_TARIFFA_OS(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
      
      call.setString( 1, codeUtente);
      call.setInt( 2,idVoce );
      call.setString( 3, dataInizioTariffa );
      call.setString( 4, descTariffa );
      call.setString( 5, imptTariffa );
      //call.setString( 6, codeUnitaMisura );
      call.setString( 6, null ); 
      call.setString( 7, descListinoApplicato );
      call.registerOutParameter(8, OracleTypes.NUMBER);
      call.registerOutParameter(9, OracleTypes.VARCHAR);
      call.execute();
      StoredProcedureResult result = new StoredProcedureResult();
      result.setErroreSql(call.getInt(8));
      result.setErroreMsg(call.getString(9));
      Vector vec = new Vector<StoredProcedureResult>();
      vec.add(result);
      return vec;
      
    } catch (Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(), "", 
                                "insertTariffa", 
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
                                  "insertTariffa", 
                                  this.getClass().getName(), 
                                  StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  }*/
  public Vector<StoredProcedureResult> eliminaListino(String nomeListino) throws CustomException, RemoteException
  {
    Connection dbConnection = null;
    CallableStatement call = null;
    
    try
    {
      javax.naming.InitialContext ic = new javax.naming.InitialContext();
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(StaticContext.DSNAME);
      dbConnection = dataSource.getConnection();
      call = dbConnection.prepareCall("{call PKG_OPERE_SPECIALI.ELIMINA_LISTINO_OS(?, ?, ?)}");
      
      call.setString( 1, nomeListino);
      call.registerOutParameter(2, OracleTypes.NUMBER);
      call.registerOutParameter(3, OracleTypes.VARCHAR);
      call.execute();
      StoredProcedureResult result = new StoredProcedureResult();
      result.setErroreSql(call.getInt(2));
      result.setErroreMsg(call.getString(3));
      Vector vec = new Vector<StoredProcedureResult>();
      vec.add(result);
      return vec;
      
    } catch (Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(), "", 
                                "eliminaListino", 
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
                                  "eliminaListino", 
                                  this.getClass().getName(), 
                                  StaticContext.FindExceptionType(lexc_Exception));
      }
    }
  }
}
