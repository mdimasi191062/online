package com.ejbBMP.impl;

import java.util.*;
import java.rmi.*;
import java.sql.*;

import javax.ejb.*;
import javax.naming.*;

import oracle.jdbc.*;
import oracle.sql.*;

import com.ejbBMP.CsvBMPPK;
import com.utl.*;


public class CsvBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private CsvBMPPK pk;

  private boolean enableStore=false;
  

  public CsvBMPPK ejbCreate()
  throws CreateException, RemoteException 
  {
    pk= new CsvBMPPK();
    return pk;
  }


  public void ejbPostCreate()
  {
    
  }

 public CsvBMPPK ejbFindByPrimaryKey(CsvBMPPK primaryKey)
  {
    return primaryKey;
  }
  public CsvBMPPK ejbFindCsvSP(String account, String cicloIni) throws FinderException, RemoteException
  {

  
  CsvBMPPK pk = new CsvBMPPK();
  
  //Connection conn=null;  

  try
    {
    /*  InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(DBConnection.DATA_SOURCE); 
      conn   = dataSource.getConnection(); 
*/
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CSV_FATTURA_SP_VER_ES (?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.setString(2,cicloIni);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setCsv(cs.getInt(3));  

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

   return  pk;
  
  }
    public CsvBMPPK ejbFindCsvSPNC(String account) throws FinderException, RemoteException
  {

  
  CsvBMPPK pk = new CsvBMPPK();
  
  //Connection conn=null;  

  try
    {
   
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CSV_NC_SP_VER_ES(?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setCsv(cs.getInt(2));  

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

   return  pk;
  
  }
  public CsvBMPPK ejbFindCsvXDSL(String account, String cicloIni) throws FinderException, RemoteException
  {

  
  CsvBMPPK pk = new CsvBMPPK();
  
  //Connection conn=null;  

  try
    {
    /*  InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(DBConnection.DATA_SOURCE); 
      conn   = dataSource.getConnection(); 
*/
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CSV_FATTURA_XDSL_VER_ES (?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.setString(2,cicloIni);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setCsv(cs.getInt(3));  

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

   return  pk;
  
  }
  public CsvBMPPK ejbFindCsvXDSLNC(String account) throws FinderException, RemoteException
  {

  
  CsvBMPPK pk = new CsvBMPPK();
  
  try
    {
  
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".CSV_NC_XDSL_ES (?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setCsv(cs.getInt(2));  

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

   return  pk;
  
  }

  public CsvBMPPK ejbFindAccountSenzaPS(String codeElab, String account) throws FinderException, RemoteException
  {
  CsvBMPPK pk = new CsvBMPPK();
  //Connection conn=null;  

  try
    {
    /*  InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(DBConnection.DATA_SOURCE); 
      conn   = dataSource.getConnection(); 
*/
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".ACCOUNT_SENZA_PS_VER_ES (?,?,?,?,?)}");
       // Impostazione types I/O
      cs.setString(1,codeElab);
      cs.setString(2,account);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setPs(cs.getInt(3)); 

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
      catch(Throwable e)
    {
      try
        {
          if (!conn.isClosed()) 
              conn.close();
        }
      catch (SQLException sqle)
        {
          sqle.printStackTrace();
          throw new RemoteException(sqle.getMessage());
        }

      e.printStackTrace();
       throw new RemoteException(e.getMessage());
    }

   return  pk;
  
  }
  public Collection ejbFindAccountLstSP(String codeFunz) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_CSV_VA_ULL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codeFunz);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new CsvBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              pk.setAccount(attr[1].stringValue());
              recs.add(pk);
          }      

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}


    return recs;
  }
 
  public Collection ejbFindAccountLstXDSL(String codeFunz) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_CSV_VA_XDSL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codeFunz);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new CsvBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              pk.setAccount(attr[1].stringValue());
              recs.add(pk);
          }      

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}


    return recs;
  }
  public Collection ejbFindAccountLstNC(String codeElab) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_CSV_NC_ULL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codeElab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new CsvBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              pk.setAccount(attr[1].stringValue());
              recs.add(pk);
          }      

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}


    return recs;
  }
 
  public Collection ejbFindAccountLstXDSLNC(String codeElab) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_CSV_NC_XDSL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,codeElab);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_ACCOUNT");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      
      cs.execute();


      // Costruisco l'array che conterrà i dati di ritorno della stored  
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_ACCOUNT",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new CsvBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
      
              pk.setAccount(attr[1].stringValue());
              recs.add(pk);
          }      

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}


    return recs;
  }
 
  
    public String getAccount()
  {
      pk = (CsvBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getAccount();
  }

  public void setAccount(String code)
  {
    
		pk = (CsvBMPPK) ctx.getPrimaryKey();
		pk.setAccount (code);
   
  }

  
      public int getCsv()
  {
      pk = (CsvBMPPK) ctx.getPrimaryKey();
      if (pk==null) return 0; 
      else
        return pk.getCsv();
  }

  public void setCsv(int nrgCsv)
  {
    
		pk = (CsvBMPPK) ctx.getPrimaryKey();
		pk.setCsv (nrgCsv);
   
  }
      public int getPs()
  {
      pk = (CsvBMPPK) ctx.getPrimaryKey();
      if (pk==null) return 0; 
      else
        return pk.getPs();
  }

  public void setPs(int nrgPs)
  {
    
		pk = (CsvBMPPK) ctx.getPrimaryKey();
		pk.setPs (nrgPs);
   
  }
  }