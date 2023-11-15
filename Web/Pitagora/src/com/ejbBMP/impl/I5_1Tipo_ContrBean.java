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
import com.ejbBMP.*;
import com.utl.StaticContext;

public class I5_1Tipo_ContrBean extends AbstractSequenceBean implements EntityBean 
{

  private static final String findByPKStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1Tipo_ContrLoad(?,?) }";
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1Tipo_ContrFindAll(?) }";
  private I5_1Tipo_ContrPK primaryKey;
  private String Desc_Tipo_Contr;

  public EntityContext entityContext;
  private CallableStatement cs = null;
  
  public Collection ejbFindAll(int bSelezione) throws FinderException, RemoteException
  {
  

    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setInt(2, bSelezione);
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        String a = rs.getString("Code_Tipo_Contr");
        String b = rs.getString("Flag_Sys");
        primaryKey = new I5_1Tipo_ContrPK(a,b);
       	recs.add(primaryKey);
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
	       ps.close();
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



  public I5_1Tipo_ContrPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

  public I5_1Tipo_ContrPK ejbFindByPrimaryKey(I5_1Tipo_ContrPK primaryKey)
  {
    return primaryKey;
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    try 
    {

      primaryKey = (I5_1Tipo_ContrPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey.getCode_Tipo_Contr());
      cs.setString(3, primaryKey.getFlag_Sys());
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
      
      boolean found = rs.next();
      if (found) 
      {
        Desc_Tipo_Contr=rs.getString("Desc_Tipo_Contr");
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
  
  public String getDesc_Tipo_Contr()  {
    return(Desc_Tipo_Contr);
  }
  public void setDesc_Tipo_Contr(String newDesc_Tipo_Contr)  {
    Desc_Tipo_Contr=newDesc_Tipo_Contr;
  }
}