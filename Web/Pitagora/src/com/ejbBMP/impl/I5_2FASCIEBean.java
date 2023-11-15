package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import java.util.*;
import java.rmi.*;
import javax.ejb.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import com.utl.*;
import oracle.jdbc.OracleTypes;
import java.text.DateFormat;
import com.ejbBMP.*;

public class I5_2FASCIEBean extends AbstractEntityCommonBean implements EntityBean 
{
  private I5_2FASCIEPK primaryKey;
  private String DESC_FASCIA;
  private int VALO_LIM_MAX;
  private int VALO_LIM_MIN;
  private java.util.Date DATA_INIZIO_VALID;
      //Stringhe Select 
  private static final String findByPKStatement ="{? = call PKG_BILL_CLA.I5_2FASCIALoad(?,?) }";
  private static final String findAllByCodeFascia ="{? = call PKG_BILL_CLA.I5_2FASCIAAllByCodeFascia(?) }";  
  private static final String findAllStatement ="{? = call PKG_BILL_CLA.I5_2FASCIAFindAll(?) }";
  private static final String InsertStatement ="{? = call PKG_BILL_CLA.I5_2FASCIACreate(?,?,?,?,?,?) }";
  private static final String DeleteStatement ="{? = call PKG_BILL_CLA.I5_2FASCIARemove(?,?) }";
  private static final String controlloTariffe ="{? = call PKG_BILL_CLA.I5_2FASCIAAssociazioneTariffe(?) }";
  private CallableStatement cs = null;
  public EntityContext entityContext;

  public com.ejbBMP.I5_2FASCIEPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }
  
  public I5_2FASCIEPK ejbCreate(I5_2FASCIEPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, String txtValoreMinimo, String txtValoreMassimo) throws RemoteException, CreateException
  {
    CallableStatement cs = null;
    try 
    {        
			conn = getConnection(dsName);
      cs = conn.prepareCall(InsertStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,newPrimaryKey.getCode_fascia());
      cs.setString(3,newPrimaryKey.getCode_pr_fascia());
      cs.setString(4,newDataInizio);
      cs.setString(5,txtDescrizioneIntervallo);
      cs.setString(6,txtValoreMinimo);
      cs.setString(7,txtValoreMassimo);
      cs.execute();    
    }
    catch(Throwable ex)
    {
      ex.printStackTrace();
      throw new CreateException(ex.getMessage());
    }
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }
    return newPrimaryKey;
  }

  public void ejbPostCreate(I5_2FASCIEPK newPrimaryKey, String newDataInizio, String txtDescrizioneIntervallo, String txtValoreMinimo, String txtValoreMassimo)
  {
  }
  
  public com.ejbBMP.I5_2FASCIEPK ejbFindByPrimaryKey(com.ejbBMP.I5_2FASCIEPK primaryKey)
  {
    return primaryKey;
  }

  public void ejbActivate()
  {
  }
  public void ejbLoad()
  {
    ResultSet rs = null; 
    try 
    {
      primaryKey = (com.ejbBMP.I5_2FASCIEPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey.getCode_fascia());
      cs.setString(3, primaryKey.getCode_pr_fascia());
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);           
      boolean found = rs.next();
      if (found) 
      {
        DESC_FASCIA=rs.getString("DESC_FASCIA");
        VALO_LIM_MAX=rs.getInt("VALO_LIM_MAX");
        VALO_LIM_MIN=rs.getInt("VALO_LIM_MIN");
        DATA_INIZIO_VALID=rs.getDate("DATA_INIZIO_VALID");
      }    
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
      //throw new Exception(ex.getMessage());
    }
    finally 
    {
      try 
      {
         if (rs != null){
          rs.close();
         }
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
    try 
    {
      primaryKey = (com.ejbBMP.I5_2FASCIEPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(DeleteStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, primaryKey.getCode_fascia());
      cs.setString(3, primaryKey.getCode_pr_fascia());
      cs.execute();    
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
    }
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }


  }

  public void ejbStore()
  {
  }

  public Collection ejbFindAll() throws FinderException, RemoteException,CustomException
  {

    ResultSet rs = null;
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        primaryKey.setCode_fascia(rs.getString("CODE_FASCIA"));
        primaryKey.setCode_pr_fascia(rs.getString("CODE_PR_FASCIA"));
       	recs.add(primaryKey);
      } 
    }
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2FASCIE","ejbFindAll","I5_2FASCIE",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
         if (rs != null){
          rs.close();
         }      
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }
    return recs;
  }

  public Collection ejbFindAll(String FiltroCODE_FASCIA) throws FinderException, RemoteException,CustomException
  {
  
    ResultSet rs = null;
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_FASCIA);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        String a = rs.getString("CODE_FASCIA");
        String b = rs.getString("CODE_PR_FASCIA");
        primaryKey = new I5_2FASCIEPK(a,b);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2FASCIE","ejbFindAll","I5_2FASCIE",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
         if (rs != null){
          rs.close();
         }
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }
    return recs;
  }

  public Collection ejbFindAllByCodeFascia(String FiltroCODE_FASCIA) throws FinderException, RemoteException,CustomException
  {
  
    ResultSet rs = null;
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllByCodeFascia);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_FASCIA);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        String a = rs.getString("CODE_FASCIA");
        String b = rs.getString("CODE_PR_FASCIA");
        primaryKey = new I5_2FASCIEPK(a,b);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2FASCIE","ejbFindAllByCodeFascia","I5_2FASCIE",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
         if (rs != null){
          rs.close();
         }
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }
    return recs;
  }

  public void setEntityContext(EntityContext ctx)
  {
    this.entityContext = ctx;
  }

  public void unsetEntityContext()
  {
    this.entityContext = null;
  }
  public int AssociazioneTariffe()  throws RemoteException,CustomException{

   int iRisposta=0;

   try 
    {

      primaryKey = (com.ejbBMP.I5_2FASCIEPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(controlloTariffe);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, primaryKey.getCode_fascia());
      cs.execute();  
      iRisposta = cs.getInt(1);      
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2FASCIE","ejbFindAll","I5_2FASCIE",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e){
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
      }
    }
    return iRisposta;
  
  }
  public String getDESC_FASCIA()  {
    return(DESC_FASCIA);
  }
  public void setDESC_FASCIA(String newDESC_FASCIA)  {
    DESC_FASCIA=newDESC_FASCIA;
  }
  public int getVALO_LIM_MAX()  {
    return(VALO_LIM_MAX);
  }
  public void setVALO_LIM_MAX(int newVALO_LIM_MAX)  {
    VALO_LIM_MAX=newVALO_LIM_MAX;
  }
  public int getVALO_LIM_MIN()  {
    return(VALO_LIM_MIN);
  }
  public void setVALO_LIM_MIN(int newVALO_LIM_MIN)  {
    VALO_LIM_MIN=newVALO_LIM_MIN;
  }
  public java.util.Date getDATA_INIZIO_VALID()  {
    return(DATA_INIZIO_VALID);
  }
  public void setDATA_INIZIO_VALID(java.util.Date newDATA_INIZIO_VALID)  {
    DATA_INIZIO_VALID=newDATA_INIZIO_VALID;
  }
}