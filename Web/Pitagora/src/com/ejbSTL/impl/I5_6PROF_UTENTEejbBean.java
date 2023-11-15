package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;
import com.ejbSTL.I5_6PROF_UTENTE_ROW;

public class I5_6PROF_UTENTEejbBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private String createStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEcreate(?,?) }";
  private String storeStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEstore(?,?) }";
  private String loadStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEload(?) }";
  private String removeStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEremove(?) }";  
  private String findAllStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEfindall(?) }";
  private String findByPKStatement = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEfindByPK(?) }";
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
  public Vector FindAll(String codice) throws RemoteException,CustomException
  {
    I5_6PROF_UTENTE_ROW riga;
    CallableStatement cs = null;
    Vector recs = new Vector();
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      if (codice==null)
      {
        cs.setNull(2,Types.VARCHAR);
      }
      else
      {
        cs.setString(2,codice);
      }
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        riga =  new I5_6PROF_UTENTE_ROW();
        riga.setCODE_PROF_UTENTE(rs.getString(1));
        riga.setDESC_PROF_UTENTE(rs.getString(2));        
        recs.add(riga);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella dei profili utente","ejbFindAll","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));            
    } finally {
      try {
	       cs.close();
      } 
      catch (Exception e) 
      {
          System.out.println(e.getMessage());
          throw new CustomException(e.toString(),"Errore di accesso alla tabella dei profili utente","ejbFindAll","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));
      }
      try 
      {
	       conn.close();
      }
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella dei profili utente","ejbFindAll","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));
      }
    }
    return recs;


  
  }

  public String creaProfilo(String codice,String descrizione) throws RemoteException,CustomException
  {
    
    CallableStatement cs = null;
    String ret=null;
    try 
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(createStatement);
        cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
        cs.setString(2,codice);
        cs.setString(3,descrizione);
        cs.execute();
        ret = cs.getString(1); // da testare per riuscita
        if(ret.equals(codice))
          ret = null;
      }
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella dei profili utente","ejbCreate","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));
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
     
      return ret;
  }



  public I5_6PROF_UTENTE_ROW loadProfilo(String codice) throws RemoteException,CustomException
  {
    I5_6PROF_UTENTE_ROW riga = null;
    CallableStatement cs = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(loadStatement);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,codice);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
          riga = new I5_6PROF_UTENTE_ROW();
          riga.setCODE_PROF_UTENTE(rs.getString("CODE_PROF_UTENTE"));
          riga.setDESC_PROF_UTENTE(rs.getString("DESC_PROF_UTENTE"));
      } 
      rs.close();
    } 
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella dei profili utente","loadProfilo","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));            
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
        }
      try {
	       conn.close();
      } catch (Exception e) {
            System.out.println(e.getMessage());
      }
      }
      return riga;


  }


  public String updateProfilo(String codice,String descrizione) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    String ret=null;
    try 
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(storeStatement);
        cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
        cs.setString(2,codice);
        cs.setString(3,descrizione);
        cs.execute();
        ret = cs.getString(1); // da testare per riuscita
        if(ret.equals("0"))
          ret = null;
      }
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella dei profili utente","updateProfilo","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));            
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
    return ret;
  }

  public String deleteProfilo(String codice) throws RemoteException,CustomException
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
      throw new CustomException(e.toString(),"Errore di accesso alla tabella profilo utenti","deleteProfilo","I5_6PROF_UTENTEejbBean",StaticContext.FindExceptionType(e));
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