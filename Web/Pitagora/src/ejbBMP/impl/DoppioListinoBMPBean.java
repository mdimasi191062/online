package com.ejbBMP.impl;

import java.util.*;
import java.rmi.*;
import java.sql.*;

import javax.ejb.*;
import javax.naming.*;

import oracle.jdbc.*;
import oracle.sql.*;

import com.ejbBMP.DoppioListinoBMPPK;
import com.utl.*;


public class DoppioListinoBMPBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private DoppioListinoBMPPK pk;

  private boolean enableStore=false;
  

  public DoppioListinoBMPPK ejbCreate()
  throws CreateException, RemoteException 
  {
   //System.out.println("ejbCreate>>");
    pk= new DoppioListinoBMPPK();
    return pk;
  }


  public void ejbPostCreate()
  {
    
  }

 public DoppioListinoBMPPK ejbFindByPrimaryKey(DoppioListinoBMPPK primaryKey)
  {
    return primaryKey;
  }
  public DoppioListinoBMPPK ejbFindNrgListiniSP(String account) throws FinderException, RemoteException
  {

  
  DoppioListinoBMPPK pk = new DoppioListinoBMPPK();
  
  //Connection conn=null;  

  try
    {
    /*  InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(DBConnection.DATA_SOURCE); 
      conn   = dataSource.getConnection(); 
*/
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".DOCUM_FATT_SP_VER_ES_2_LIS (?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setLst(cs.getInt(2));  

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
  public DoppioListinoBMPPK ejbFindNrgListiniXDSL(String account) throws FinderException, RemoteException
  {

  
  DoppioListinoBMPPK pk = new DoppioListinoBMPPK();
  
  //Connection conn=null;  

  try
    {
    /*  InitialContext ic  = new javax.naming.InitialContext(); 
      javax.sql.DataSource dataSource = (javax.sql.DataSource)ic.lookup(DBConnection.DATA_SOURCE); 
      conn   = dataSource.getConnection(); 
*/
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".DOCUM_FATT_XDSL_VER_ES_2_LIS (?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.registerOutParameter(2,Types.INTEGER);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setLst(cs.getInt(2));  
      
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

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_ACC_2_LIS_ULL (?,?,?,?)}");

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
              pk = new DoppioListinoBMPPK();

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

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_ACC_2_LIS_XDSL (?,?,?,?)}");

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
              pk = new DoppioListinoBMPPK();

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

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_DOC_NC_ULL (?,?,?,?)}");

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
              pk = new DoppioListinoBMPPK();

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

  public Collection ejbFindAccountLstRPC(String codeElab) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
      
			conn = getConnection(dsName);

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_DOC_RPC (?,?,?,?)}");

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
              pk = new DoppioListinoBMPPK();

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

      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LST_NO_DOC_NC_XDSL (?,?,?,?)}");

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
              pk = new DoppioListinoBMPPK();

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
  
  public DoppioListinoBMPPK ejbFindCodeParam(String account) throws FinderException, RemoteException
  {

  
  DoppioListinoBMPPK pk = new DoppioListinoBMPPK();
  
   try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LEGGI_COD_X_ACC (?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,account);
      cs.registerOutParameter(2,Types.VARCHAR);
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      pk.setCodeParam(cs.getString(2));  

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
    public DoppioListinoBMPPK ejbFindCodeParamNC(String Account,String CodeBatch) throws FinderException, RemoteException
  {

  
  DoppioListinoBMPPK pk = new DoppioListinoBMPPK();
  
   try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_LEGGI_X_ACC_FUNZ (?,?,?,?,?)}");
      //OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call PKG_BILL_SPE_ALB.PARAM_VALO_LEGGI_X_ACC_FUNZ (?,?,?,?,?)}");

       // Impostazione types I/O
      cs.setString(1,Account);
      cs.setString(2,CodeBatch);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      pk.setCodeParam(cs.getString(3));  

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
    public String getAccount()
  {
      pk = (DoppioListinoBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getAccount();
  }

  public void setAccount(String code)
  {
    
		pk = (DoppioListinoBMPPK) ctx.getPrimaryKey();
		pk.setAccount (code);
   
  }
   public String getCodeParam()
  {
      pk = (DoppioListinoBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null; 
      else
        return pk.getCodeParam();
  }

  public void setCodeParam(String code)
  {
    
		pk = (DoppioListinoBMPPK) ctx.getPrimaryKey();
		pk.setCodeParam (code);
   
  }

  public int getLst()
  {
      pk = (DoppioListinoBMPPK) ctx.getPrimaryKey();
      if (pk==null) return 0; 
      else
        return pk.getLst();
  }

  public void setLst(int nrgLst)
  {
    
		pk = (DoppioListinoBMPPK) ctx.getPrimaryKey();
		pk.setLst (nrgLst);
   
  }
 
  }