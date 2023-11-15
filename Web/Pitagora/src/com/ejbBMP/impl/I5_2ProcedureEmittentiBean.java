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
import com.utl.StaticContext;

public class I5_2ProcedureEmittentiBean extends AbstractSequenceBean implements EntityBean 
{
    //Variabiali private contenitore dei campi della tabella I5_2PROC_EMITT
  private String CODE_PROC_EMITT;
  private String DESC_PROC_EMITT;
  private String DESC_VALO_PROC_EMITT;
  private java.util.Date DATA_CREAZ;
  private Integer CasiParticolari=new Integer(0);
    //Stringhe Select 
  private static final String findByPKStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ProcedureEmittentiLoad(?) }";
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ProcedureEmittentiFindAll(?) }";
  private static final String InsertStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ProcedureEmittentiCreate(?,?,?) }";
  private static final String DeleteStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ProcedureEmittentiRemove(?) }";
  public EntityContext entityContext;
  private CallableStatement cs = null;

  public String ejbCreate()
  {
    return null;
  }
  public String ejbCreate(String newDESC_PROC_EMITT, String newDESC_VALO_PROC_EMITT)  throws RemoteException, CreateException
  {
    try 
    {  
      CODE_PROC_EMITT=getSequenceValue("i5q21_proc_emitt");      
			conn = getConnection(dsName);
      cs = conn.prepareCall(InsertStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,CODE_PROC_EMITT);
      cs.setString(3,newDESC_PROC_EMITT);
      cs.setString(4,newDESC_VALO_PROC_EMITT);
      cs.execute();
      CasiParticolari = new Integer(cs.getString(1));  
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
    return CODE_PROC_EMITT;
  }
  public void ejbPostCreate()
  {
  }

  public void ejbPostCreate(String newDESC_PROC_EMITT, String newDESC_VALO_PROC_EMITT)
  {
  }

  public String ejbFindByPrimaryKey(String primaryKey) throws FinderException
  {
    ResultSet rs = null;
    try 
    {
 
      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
      
      boolean found = rs.next();
      if (found) 
      {
        CODE_PROC_EMITT=primaryKey;
        DESC_PROC_EMITT=rs.getString("DESC_PROC_EMITT");
        DESC_VALO_PROC_EMITT=rs.getString("DESC_VALO_PROC_EMITT");
        DATA_CREAZ=rs.getDate("DATA_CREAZ");
      }
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
     throw new FinderException(ex.getMessage());
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
    return primaryKey;
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    ResultSet rs =null;
    try 
    {

      String primaryKey = (String) entityContext.getPrimaryKey();

      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
      boolean found = rs.next();
      if (found) 
      {
        CODE_PROC_EMITT=primaryKey;
        DESC_PROC_EMITT=rs.getString("DESC_PROC_EMITT");
        DESC_VALO_PROC_EMITT=rs.getString("DESC_VALO_PROC_EMITT");
        DATA_CREAZ=rs.getDate("DATA_CREAZ");
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

  public void ejbStore()
  {
  }

  public void setEntityContext(EntityContext ctx)
  {
    this.entityContext = ctx;
  }

  public void unsetEntityContext()
  {
    this.entityContext = null;
  }

  public Collection ejbFindAll() throws FinderException, RemoteException,CustomException
  {
    ResultSet rs =null;
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
       	recs.add(rs.getString("CODE_PROC_EMITT"));
      } 
    }
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2ProcedureEmittenti","FindAll","I5_2ProcedureEmittenti",StaticContext.FindExceptionType(e));                            
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

  public Collection ejbFindAll(String FiltroDESC_VALO_PROC_EMITT) throws FinderException, RemoteException,CustomException
  {
    ResultSet rs = null;
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroDESC_VALO_PROC_EMITT);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
       	recs.add(rs.getString("CODE_PROC_EMITT"));
      } 
    }
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2ProcedureEmittenti","FindAll","I5_2ProcedureEmittenti",StaticContext.FindExceptionType(e));                            
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

  public void ejbRemove()
  {
      try 
    {

      String primaryKey = (String) entityContext.getPrimaryKey();

      conn = getConnection(dsName);
      cs = conn.prepareCall(DeleteStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, primaryKey);
      cs.execute();
      CasiParticolari = new Integer(cs.getString(1));  
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

  
  public String getCODE_PROC_EMITT()  {
    return(CODE_PROC_EMITT);
  }
  public void setCODE_PROC_EMITT(String newCODE_PROC_EMITT)  {
    CODE_PROC_EMITT=newCODE_PROC_EMITT;
  }
  public String getDESC_PROC_EMITT() {
    return(DESC_PROC_EMITT);
  }
  public void setDESC_PROC_EMITT(String newDESC_PROC_EMITT)  {
    DESC_PROC_EMITT=newDESC_PROC_EMITT;
  }
  public String getDESC_VALO_PROC_EMITT() {
    return(DESC_VALO_PROC_EMITT);
  }
  public void setDESC_VALO_PROC_EMITT(String newDESC_VALO_PROC_EMITT) {
    DESC_VALO_PROC_EMITT=newDESC_VALO_PROC_EMITT;
  }
  public java.util.Date getDATA_CREAZ()  {
    return(DATA_CREAZ);
  }
  public void setDATA_CREAZ(java.util.Date newDATA_CREAZ) {
    DATA_CREAZ=newDATA_CREAZ;
  }
  public Integer getCasiParticolari()  {
    return(CasiParticolari);
  }
}