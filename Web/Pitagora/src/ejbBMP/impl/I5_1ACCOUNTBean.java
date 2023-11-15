package com.ejbBMP.impl;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import com.ejbBMP.I5_1ACCOUNTPK;
import java.util.*;
import java.rmi.*;
import javax.ejb.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import com.utl.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class I5_1ACCOUNTBean extends AbstractEntityCommonBean implements EntityBean 
{
  public EntityContext entityContext;
  private String Desc_Account;
  private I5_1ACCOUNTPK primaryKey;
  private static final String findByPKStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1ACCOUNTLoad(?,?,?) }";
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1ACCOUNTfindAll(?) }";
  private static final String findAllStatement_CPM ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1ACCOUNTfindAll_CPM(?,?) }";  
  private static final String findAllStatement_CPM_anomali ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1ACCOUNTfindAll_CPM_anomali(?,?) }";      
  private static final String findAllStatement_SAR ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1ACCOUNTfindAll_SAR(?,?,?) }";    
  private static final String ver_Batch_CPM ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_1ACCOUNT_ver_Batch_CPM(?,?,?,?) }";    
  private CallableStatement cs = null;
  private int ControlloBatch;
  
  public Collection ejbFindAll(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException,CustomException
  {
    ResultSet rs=null;
    Vector recs = new Vector();
    try 
    {
    
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_TIPO_CONTR);      
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        

        String a = rs.getString("code_account");
        String b = rs.getString("flag_sys");
        primaryKey = new I5_1ACCOUNTPK(a,b);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ACCOUNT","FindAll","I5_1ACCOUNT",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
         if (rs!=null){ 
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

  public Collection ejbFindAll_CPM(String FiltroCODE_TIPO_CONTR,java.util.Date DataInizale) throws FinderException, RemoteException,CustomException
  {

    Vector recs = new Vector();
    ResultSet rs = null;
    try 
    {
    
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement_CPM);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_TIPO_CONTR);    
      cs.setDate(3,new java.sql.Date(DataInizale.getTime()));
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        

        String a = rs.getString("code_account");
        String b = rs.getString("flag_sys");
        primaryKey = new I5_1ACCOUNTPK(a,b);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ACCOUNT","ejbFindAll_CPM","I5_1ACCOUNT",StaticContext.FindExceptionType(e));                            
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

 public Collection ejbFindAll_CPM_anomali(String FiltroCODE_TIPO_CONTR,java.util.Date DataInizale) throws FinderException, RemoteException,CustomException
  {
    ResultSet rs = null;
    Vector recs = new Vector();
    try 
    {
    
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement_CPM_anomali);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_TIPO_CONTR);    
      cs.setDate(3,new java.sql.Date(DataInizale.getTime()));
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        

        String a = rs.getString("code_account");
        String b = rs.getString("flag_sys");
        primaryKey = new I5_1ACCOUNTPK(a,b);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ACCOUNT","ejbFindAll_CPM_anomali","I5_1ACCOUNT",StaticContext.FindExceptionType(e));                            
    } 
    finally 
    {
      try 
      {
        if (rs!=null){
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

  public Collection ejbFindAll_SAR(String FiltroCODE_TIPO_CONTR,String Anno,String Mese) throws FinderException, RemoteException,CustomException
  {
    ResultSet rs=null;
    Vector recs = new Vector();
    try 
    {
    
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement_SAR);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_TIPO_CONTR);    
      cs.setString(3,Anno);    
      cs.setString(4,Mese);          
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        

        String a = rs.getString("code_account");
        String b = rs.getString("flag_sys");
        primaryKey = new I5_1ACCOUNTPK(a,b);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ACCOUNT","ejbFindAll_SAR","I5_1ACCOUNT",StaticContext.FindExceptionType(e));                            
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


  public I5_1ACCOUNTPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

  public I5_1ACCOUNTPK ejbFindByPrimaryKey(I5_1ACCOUNTPK primaryKey) 
  {
    CallableStatement cs = null;
    try
    {
      conn = getConnection(dsName);      
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey.getCode_account());
      cs.setString(3, primaryKey.getFlag_sys());
      cs.registerOutParameter(4, OracleTypes.NUMBER);      
      cs.execute();  
      cs.close();
      conn.close();
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
      //throw new Exception(ex.getMessage());
    }
    return primaryKey;
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    ResultSet rs=null;
    try 
    {
      primaryKey = (I5_1ACCOUNTPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);      
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey.getCode_account());
      cs.setString(3, primaryKey.getFlag_sys());
      cs.registerOutParameter(4, OracleTypes.NUMBER);      
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
      
      boolean found = rs.next();
      if (found) 
      { 
        Desc_Account=rs.getString("Desc_Account");
        ControlloBatch=cs.getInt(4);      
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
  public String getDesc_Account()  throws RemoteException{
    return(Desc_Account);
  }
  public void setDesc_Account(String newDesc_Account)  throws RemoteException{
    Desc_Account=newDesc_Account;
  }  
  public int getControlloBatch()  throws RemoteException{
    return(ControlloBatch);
  }  
  public int getControlloBatch_CPM(java.util.Date DataInizale,java.util.Date DataFinale) throws RemoteException,CustomException{
    int ritorno;
    try 
    {
      primaryKey = (I5_1ACCOUNTPK) entityContext.getPrimaryKey();
    
      conn = getConnection(dsName);
      cs = conn.prepareCall(ver_Batch_CPM);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,primaryKey.getCode_account());      
      cs.setString(3,primaryKey.getFlag_sys());            
      cs.setDate(4,new java.sql.Date(DataInizale.getTime()));
      cs.setDate(5,new java.sql.Date(DataFinale.getTime()));      
      cs.execute();  
      ritorno= cs.getInt(1);
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ACCOUNT","getControlloBatch_CPM","I5_1ACCOUNT",StaticContext.FindExceptionType(e));                            
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
    return ritorno;
  }  
    

}