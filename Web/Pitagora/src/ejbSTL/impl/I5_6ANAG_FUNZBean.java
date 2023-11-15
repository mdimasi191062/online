package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;
import com.ejbSTL.I5_6ANAG_FUNZ_ROW;
public class I5_6ANAG_FUNZBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private String LoadStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZLoad(?) }";
  private String findAllStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZFindAll(?) }";
  private String findByPKStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZFindByPrimaryKey(?) }";
  private String StoreStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZStore(?,?,?,?) }";
  private String CreateStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZCreate(?,?,?,?) }";
  private String removeStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZremove(?) }";  
  
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
  public Vector FindAll(String pCODE_FUNZ) throws  RemoteException,CustomException
  {

    I5_6ANAG_FUNZ_ROW riga = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Vector recs = new Vector();
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,pCODE_FUNZ);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      { 
        riga =  new I5_6ANAG_FUNZ_ROW();
        riga.setCODE_FUNZ(rs.getString("CODE_FUNZ"));
        riga.setDESC_FUNZ(rs.getString("DESC_FUNZ"));        
        riga.setTIPO_FUNZ(rs.getString("TIPO_FUNZ"));
        riga.setFLAG_SYS(rs.getString("FLAG_SYS"));
        recs.add(riga);      
      } 
      rs.close();
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","FindAll","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));      
    } 
    finally 
    {
      try 
      {
         if(rs!=null)
         rs.close();
	       cs.close();
      } 
      catch (Exception e){
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","FindAll","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));      
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","FindAll","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));          
      }
    }
    return recs;
  }

  public I5_6ANAG_FUNZ_ROW loadFunz(String primaryKey) throws  RemoteException,CustomException
  {
    I5_6ANAG_FUNZ_ROW riga = null;
    CallableStatement cs = null;
    ResultSet rs =null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LoadStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2, primaryKey);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
      boolean found = rs.next();
      if (found) 
      {
        riga =  new I5_6ANAG_FUNZ_ROW();
        riga.setCODE_FUNZ(rs.getString("CODE_FUNZ"));
        riga.setDESC_FUNZ(rs.getString("DESC_FUNZ"));        
        riga.setTIPO_FUNZ(rs.getString("TIPO_FUNZ"));
        riga.setFLAG_SYS(rs.getString("FLAG_SYS"));
      }
    } 
    catch(Exception e)
    {   
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","loadFunz","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));          
    }finally {
      try {
	       cs.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
        }
      try {
	       conn.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
      }}
      return riga;
  }
  
 public void updateFunz(String CODE_FUNZ, String newDESC_FUNZ, String newTIPO_FUNZ,String newFLAG_SYS) throws  RemoteException,CustomException
  {
    CallableStatement cs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(StoreStatement);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,CODE_FUNZ);
      cs.setString(3,newDESC_FUNZ);
      cs.setString(4,newTIPO_FUNZ);
      cs.setString(5,newFLAG_SYS);
      cs.execute();
    } 
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","updateFunz","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));              
    }finally {
      try {
	       cs.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
        }
      try {
	       conn.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
      }}
}
 public String creaFunz(String newCODE_FUNZ, String newDESC_FUNZ, String newTIPO_FUNZ,String newFLAG_SYS)  throws RemoteException, CustomException
  {
    CallableStatement cs = null;
    int ret;
    String a = null;
     try 
    {  
      
			conn = getConnection(dsName);
      cs = conn.prepareCall(CreateStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,newCODE_FUNZ);
      cs.setString(3,newDESC_FUNZ);
      cs.setString(4,newTIPO_FUNZ);
      cs.setString(5,newFLAG_SYS);      
      cs.execute();
      ret = cs.getInt(1); // da testare per riuscita
      if(ret==0)
          a = "chiave duplicata";    
      conn.close();
    }
    catch(Exception e)
    {
        e.printStackTrace();
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","creaFunz","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));         
    }finally {
      try {
	       cs.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
        }
      try {
	       conn.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
      }}
   return a;
  }

 public String DeleteFunz(String codice) throws RemoteException,CustomException
  {
    /*questo metodo restituisce null se tutto va bene e il messaggio customizzato
      in caso di impossibilità di cancellazione
    */
    CallableStatement cs = null;
    String ret = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(removeStatement);
      cs.registerOutParameter(1,OracleTypes.VARCHAR);
      cs.setString(2,codice);
      cs.execute();
      ret = cs.getString(1);
      if(ret.equals(codice))
        ret = null;
    } 
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella anagrafica funzionalità","DeleteFunz","I5_6ANAG_FUNZBean",StaticContext.FindExceptionType(e));
    } 
     finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return ret;
}
  
}