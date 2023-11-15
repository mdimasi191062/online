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

public class I5_3GEST_TLGBean extends AbstractSequenceBean  implements EntityBean 
{
  private String Code_gest;
  private String Nome_rag_soc_gest;
  private String primaryKey;
    //Stringhe Select 
  private static final String findByPKStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_3GEST_TLCLoad(?) }";
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_3GEST_TLCFindAll(?) }";
  private CallableStatement cs = null;
  public EntityContext entityContext;

  public void ejbLoad()
  {
    try 
    {

      primaryKey = (String) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey);
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
      
      boolean found = rs.next();
      if (found) 
      {
        Code_gest=primaryKey;
        Nome_rag_soc_gest=rs.getString("Nome_rag_soc_gest");
      }
      else
      {
      }
      rs.close();
      conn.close();
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
      //throw new Exception(ex.getMessage());
    }
  }

  public Collection ejbFindAll(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException
  {
  

    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_TIPO_CONTR);
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        Code_gest = rs.getString("Code_gest");
       	recs.add(Code_gest);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new FinderException(e.getMessage());
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
    return recs;
  }

  public String ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

  public String ejbFindByPrimaryKey(String primaryKey)
  {
    return primaryKey;
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

  public String getCode_gest()  {
    return(Code_gest);
  }
  public void setCode_gest(String newCode_gest)  {
    Code_gest=newCode_gest;
  }
  public String getNome_rag_soc_gest()  {
    return(Nome_rag_soc_gest);
  }
  public void setNome_rag_soc_gest(String newNome_rag_soc_gest)  {
    Nome_rag_soc_gest=newNome_rag_soc_gest;
  }
  
}