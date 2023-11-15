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

public class I5_2PARAM_VALORIZZABean extends AbstractSequenceBean implements EntityBean 
{
  private String CODE_PARAM;
  private String DATA_CONCAT;
  private Float VALO_EURIBOR = null;
  private java.util.Date DATA_INIZIO_CICLO_FATRZ;
  private java.util.Date DATA_FINE_CICLO_FATRZ;
  private Integer ControllaValid=new Integer(0);

      //Stringhe Select 
  private static final String findByPKStatement ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZLoad(?) }";
  private static final String findAllStatement ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZFindAll(?,?) }";
  private static final String InsertStatement ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZCreate(?,?,?,?) }";
  private static final String DeleteStatement ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZRemove(?) }";
  private static final String ControllaCrea ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZcontrollaIns(?) }";
  private static final String ControllaAggiorna ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZcontrollaAgg(?) }";  
  private static final String ControllaElaborazione ="{? = call PKG_DOVERE.I5_2PARAM_VALORIZcontrollaElab() }";
  private CallableStatement cs = null;  
  public EntityContext entityContext;

  public String ejbCreate()
  {
    return null;
  }
  public void ejbPostCreate()
  {
  }  
  public String ejbCreate(String CODE_PARAM,String VALO_EURIBOR,String DATA_INIZIO_CICLO_FATRZ,String DATA_FINE_CICLO_FATRZ) throws RemoteException, CreateException
  {
  {
    try 
    {        
			conn = getConnection(dsName);
      cs = conn.prepareCall(InsertStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,CODE_PARAM);
      cs.setString(3,VALO_EURIBOR);
      cs.setString(4,DATA_INIZIO_CICLO_FATRZ);      
      cs.setString(5,DATA_FINE_CICLO_FATRZ);            
      cs.execute();
      conn.close();
    }
    catch(Throwable ex)
    {
      ex.printStackTrace();
      throw new CreateException(ex.getMessage());
    }
    return CODE_PARAM;
  }
  }  
  public void ejbPostCreate(String CODE_PARAM, String VALO_EURIBOR,String DATA_INIZIO_CICLO_FATRZ,String DATA_FINE_CICLO_FATRZ) throws RemoteException, CreateException
  {
  }  

  //Controlla che i periodi non siano congelati
  public int controllaIns(String CODE_PARAM)  throws RemoteException{
   int iRisposta=0;
   try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(ControllaCrea);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, CODE_PARAM);      
      cs.execute();  
      iRisposta = cs.getInt(1);      
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new RemoteException(e.getMessage());
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
  //Controlla che la riga da modificare non sia stata congelata
  public int controllaAgg(String CODE_PARAM)  throws RemoteException{
   int iRisposta=0;
   try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(ControllaAggiorna);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2, CODE_PARAM);      
      cs.execute();  
      iRisposta = cs.getInt(1);      
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new RemoteException(e.getMessage());
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
  // Controlla che nessuna procedura batch sia in esecuzione
  public int controllaElab()  throws RemoteException{
   int jRisposta=0;
   try 
    {
       conn = getConnection(dsName);
      cs = conn.prepareCall(ControllaElaborazione);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
//      cs.setString(2, CODE_PARAM);
      cs.execute();  
      jRisposta = cs.getInt(1);      
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new RemoteException(e.getMessage());
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
    return jRisposta;
  
  }
  
  public Collection ejbFindAll(String DATA_INIZIO_CICLO_FATRZ,String DATA_FINE_CICLO_FATRZ) throws FinderException, RemoteException
  {
  
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,DATA_INIZIO_CICLO_FATRZ);      
      cs.setString(3,DATA_FINE_CICLO_FATRZ);            
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      {        
       	recs.add(rs.getString("CODE_PARAM"));
      } 
    }
    catch (SQLException e) 
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
  public String ejbFindByPrimaryKey(String primaryKey) throws FinderException
  {
    try 
    {
 
      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey);
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
      
      boolean found = rs.next();
      if (found) 
      {
        CODE_PARAM=primaryKey;
        DATA_CONCAT=rs.getString("DATA_CONCAT"); 
        VALO_EURIBOR = new Float(rs.getFloat("VALO_EURIBOR"));        
        DATA_INIZIO_CICLO_FATRZ=rs.getDate("DATA_INIZIO_CICLO_FATRZ");
        DATA_FINE_CICLO_FATRZ=rs.getDate("DATA_FINE_CICLO_FATRZ");
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
     throw new FinderException(ex.getMessage());
    }
    return primaryKey;
  }


  public void ejbActivate()
  {
  }

  public void ejbLoad()
  {
    try 
    {

      String primaryKey = (String) entityContext.getPrimaryKey();

      conn = getConnection(dsName);
      cs = conn.prepareCall(findByPKStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey);
      cs.execute();  
      ResultSet rs = (ResultSet)cs.getObject(1);      
      
      boolean found = rs.next();
      if (found) 
      {
        CODE_PARAM=primaryKey;
        DATA_CONCAT=rs.getString("DATA_CONCAT");
        VALO_EURIBOR = new Float(rs.getFloat("VALO_EURIBOR"));        
        DATA_FINE_CICLO_FATRZ=rs.getDate("DATA_FINE_CICLO_FATRZ");
        DATA_INIZIO_CICLO_FATRZ=rs.getDate("DATA_INIZIO_CICLO_FATRZ");
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
  public String getCODE_PARAM()  {
  return(CODE_PARAM);
  }
  public void setCODE_PARAM(String CODE_PARAM)  {
    CODE_PARAM=CODE_PARAM;
  }
  public String getDATA_CONCAT()  {
  return(DATA_CONCAT);
  }
  public void setDATA_CONCAT(String newDATA_CONCAT)  {
    DATA_CONCAT=newDATA_CONCAT;
  }  
  public Float getVALO_EURIBOR()  {
    return(VALO_EURIBOR);
  }
  public void setVALO_EURIBOR(Float newVALO_EURIBOR)  {
    VALO_EURIBOR=newVALO_EURIBOR;
  }
  public java.util.Date getDATA_INIZIO_CICLO_FATRZ()  {
    return(DATA_INIZIO_CICLO_FATRZ);
  }
  public void setDATA_INIZIO_CICLO_FATRZ(java.util.Date newDATA_INIZIO_CICLO_FATRZ)  {
    DATA_INIZIO_CICLO_FATRZ=newDATA_INIZIO_CICLO_FATRZ;
  }
  public java.util.Date getDATA_FINE_CICLO_FATRZ()  {
    return(DATA_FINE_CICLO_FATRZ);
  }
  public void setDATA_FINE_CICLO_FATRZ(java.util.Date newDATA_FINE_CICLO_FATRZ)  {
    DATA_FINE_CICLO_FATRZ=newDATA_FINE_CICLO_FATRZ;
  }
  public Integer getControllaValid()  {
    return(ControllaValid);
  }
}
