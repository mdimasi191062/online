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
import com.utl.*;

public class I5_2Elab_BatchBean extends AbstractEntityCommonBean implements EntityBean 
{

  public EntityContext entityContext;

  private I5_2Elab_BatchPK primaryKey;
  private String Data_ora_inizio_elab_batch;
  private String Data_ora_fine_elab_batch;
  private String Valo_nr_ps_elab;
  private String Desc_Stato_Batch;  
  private CallableStatement cs = null;
  private static final String findByPKStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2Elab_BatchLoad(?,?) }";;
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2Elab_BatchfindAll(?) }";;
  private static final String findAllSARStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2ELAB_BATCHfindAll_SAR(?) }";;
  private static final String findAllCPMStatement="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2ELAB_BATCHfindAll_CPM(?,?) }";;  

  public I5_2Elab_BatchPK ejbCreate()
  {
    return null;
  }

  public void ejbPostCreate()
  {
  }

  public I5_2Elab_BatchPK ejbFindByPrimaryKey(I5_2Elab_BatchPK primaryKey)
  {
    return primaryKey;
  }

  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    ResultSet rs  =null;
    try 
    {
      primaryKey = (I5_2Elab_BatchPK) entityContext.getPrimaryKey();
      conn = getConnection(dsName);      
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey.getcode_elab());
      cs.setString(3, primaryKey.getFlag_sys());
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);            
      boolean found = rs.next();
      if (found) 
      { 
        Data_ora_inizio_elab_batch=rs.getString("Data_ora_inizio_elab_batch");
        Data_ora_fine_elab_batch=rs.getString("Data_ora_fine_elab_batch");
        Valo_nr_ps_elab=rs.getString("Valo_nr_ps_elab");
        Desc_Stato_Batch=rs.getString("Desc_Stato_Batch");        
      }     
    } 
    catch(Throwable ex)
    {
      ex.printStackTrace();
      //throw new Exception(ex.getMessage());
    }
    finally {
      try {
         if (rs != null){
           rs.close();
         }
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
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

  public Collection ejbFindAll(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException,CustomException
  {
    String code_elab = null;
    String flag_sys = null;
    Vector recs = new Vector();
    ResultSet rs=null;
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
        code_elab = rs.getString("code_elab");
        flag_sys = rs.getString("flag_sys");
        primaryKey = new I5_2Elab_BatchPK(code_elab,flag_sys);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2Elab_Batch","ejbFindAll","I5_2Elab_Batch",StaticContext.FindExceptionType(e));                            
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

  public Collection ejbFindAll_CPM(java.util.Date DataInizioCiclo,java.util.Date DataFineCiclo) throws FinderException, RemoteException,CustomException
  {
    String code_elab = null;
    String flag_sys = null;
    Vector recs = new Vector();
    ResultSet rs = null;
    try 
    {
    
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllCPMStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setDate(2, new java.sql.Date(DataInizioCiclo.getTime()));      
      cs.setDate(3, new java.sql.Date(DataFineCiclo.getTime()));            
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        code_elab = rs.getString("code_elab");
        flag_sys = rs.getString("flag_sys");
        primaryKey = new I5_2Elab_BatchPK(code_elab,flag_sys);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2Elab_Batch","ejbFindAll","I5_2Elab_Batch",StaticContext.FindExceptionType(e));                            
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


  public Collection ejbFindAllSar(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException,CustomException
  {
    String code_elab = null;
    String flag_sys = null;
    Vector recs = new Vector();
    ResultSet rs = null;
    try 
    {    
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllSARStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR); 
      cs.setString(2, FiltroCODE_TIPO_CONTR);       
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
        code_elab = rs.getString("code_elab");
        flag_sys = rs.getString("flag_sys");
        primaryKey = new I5_2Elab_BatchPK(code_elab,flag_sys);
       	recs.add(primaryKey);
      } 
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2Elab_Batch","ejbFindAllSar","I5_2Elab_Batch",StaticContext.FindExceptionType(e));                            
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

  public String getData_ora_inizio_elab_batch()  throws RemoteException{
    return(Data_ora_inizio_elab_batch);  
  }
  public void setData_ora_inizio_elab_batch(String newData_ora_inizio_elab_batch)  throws RemoteException{
    Data_ora_inizio_elab_batch=newData_ora_inizio_elab_batch;
  }
  public String getData_ora_fine_elab_batch()  throws RemoteException{
   return(Data_ora_fine_elab_batch);  
  }
  public void setData_ora_fine_elab_batch(String newData_ora_fine_elab_batch)  throws RemoteException{
    Data_ora_fine_elab_batch=newData_ora_fine_elab_batch;
  }
  public String getValo_nr_ps_elab()  throws RemoteException{
    return(Valo_nr_ps_elab);  
  }
  public void setValo_nr_ps_elab(String newValo_nr_ps_elab)  throws RemoteException{
    Valo_nr_ps_elab=newValo_nr_ps_elab;
  }
  public String getDesc_Stato_Batch()  throws RemoteException{
    return(Desc_Stato_Batch);  
  }
  public void setDesc_Stato_Batch(String newDesc_Stato_Batch)  throws RemoteException{  
    Desc_Stato_Batch=newDesc_Stato_Batch;
  }
}