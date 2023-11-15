package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import oracle.jdbc.OracleTypes;
import com.utl.*;
import java.util.*;
import java.rmi.RemoteException;
import java.sql.*;
import java.math.BigDecimal;

public class I5_6DETT_ALL_DBejbBean  extends AbstractSessionCommonBean implements SessionBean 
{
  private String LeggiTestata   = "{? = call " + StaticContext.PACKAGE_COMMON + ".I5_6TEST_ALL_DBfindAll() }";  
  private String LeggiLastElab  = "{? = call " + StaticContext.PACKAGE_COMMON + ".I5_6TEST_ALL_DBfindLast(?) }";    
  private String LeggiLastElabRunning  = "{? = call " + StaticContext.PACKAGE_COMMON + ".I5_6TEST_ALL_DBfindLastRunning() }";      
  private String LeggiDettaglio = "{? = call " + StaticContext.PACKAGE_COMMON + ".I5_6DETT_ALL_DBfindAll(?) }";

  
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

  public Vector findAllTestata() throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    ResultSet rs =null;
    I5_6TEST_ALL_DB_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiTestata);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_6TEST_ALL_DB_ROW();
        row.setCODE_TEST_ALL(rs.getString("CODE_TEST_ALL"));
        row.setDATA_ELAB(rs.getString("DATA_ELABORAZIONE"));
        row.setSTATO_ELAB(rs.getString("STATO_ELAB"));
        recs.add(row);
      } 
      rs.close();
    } 
    catch (SQLException e) 
    {
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          

    } 
    finally
        {
          try
          {
            if (rs != null){
              rs.close();
            }
            cs.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
          try
          {
            conn.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
        }

    return recs;
}


public I5_6TEST_ALL_DB_ROW loadLastRunning() throws RemoteException,CustomException
  {
 
    CallableStatement cs = null;
    I5_6TEST_ALL_DB_ROW row = null;
    ResultSet rs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiLastElabRunning);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while(rs.next())
			{
        row =  new I5_6TEST_ALL_DB_ROW();
        row.setDATA_ELAB(rs.getString("DATA_ELAB"));        
        row.setSTATO_ELAB(rs.getString("CODE_STATO_BATCH")); 
        row.setDESC_STATO_ELAB(rs.getString("desc_STATO_BATCH")); 
      }  
        rs.close();
        conn.close();
      } 
    catch (SQLException e) 
    {
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          

    } 
    finally
        {
          try
          {
            if (rs != null){
              rs.close();
            }
            cs.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
          try
          {
            conn.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
        }
    return row;
}

  public I5_6TEST_ALL_DB_ROW loadTesto(java.util.Date DataLancio) throws RemoteException,CustomException
  {
 
    CallableStatement cs = null;
    I5_6TEST_ALL_DB_ROW row = null;
    ResultSet rs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiLastElab);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setDate(2, new java.sql.Date(DataLancio.getTime()));
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while(rs.next())
			{
        row =  new I5_6TEST_ALL_DB_ROW();
        row.setDATA_ELAB(rs.getString("DATA_ELAB"));        
        row.setSTATO_ELAB(rs.getString("CODE_STATO_BATCH")); 
        row.setDESC_STATO_ELAB(rs.getString("desc_STATO_BATCH")); 
      }  
        rs.close();
        conn.close();
      } 
    catch (SQLException e) 
    {
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          

    } 
    finally
        {
          try
          {
            if (rs != null){
              rs.close();
            }
            cs.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
          try
          {
            conn.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
        }
    return row;
}

 public Vector findAllDettaglio(String CODE_TEST_ALL) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_6DETT_ALL_DB_ROW row = null;
    ResultSet rs = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiDettaglio);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,CODE_TEST_ALL);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_6DETT_ALL_DB_ROW();
        row.setCODE_DETT_ALL(rs.getString("CODE_DETT_ALL"));
        row.setCODE_TEST_ALL(rs.getString("CODE_TEST_ALL"));
        row.setNOME_TABELLA_BILL(rs.getString("NOME_TABELLA_BILL"));        
        row.setTIPO_FLAG_REFRESH(rs.getString("TIPO_FLAG_REFRESH"));
        row.setTEXT_MSG_ERR(rs.getString("TEXT_MSG_ERR"));                
        recs.add(row);
      } 
      rs.close();
    } 
    catch (SQLException e) 
    {
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          

    } 
    finally
        {
          try
          {
            if (rs != null){
              rs.close();
            }
            cs.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
          try
          {
            conn.close();
          } catch(Exception e)
          {
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6TEST_ALL_DB","loadTesto","I5_6DETT_ALL_DBejb",StaticContext.FindExceptionType(e));          
          }
        }
    return recs;
  }

}