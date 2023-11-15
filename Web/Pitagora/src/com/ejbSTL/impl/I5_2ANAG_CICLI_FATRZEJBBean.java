package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class I5_2ANAG_CICLI_FATRZEJBBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private String CreaCiclo        = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ANAG_CICLI_FATRZEJBCreate(?,?) }";
  private String AggiornaCiclo    = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ANAG_CICLI_FATRZEJBStore(?,?,?) }";
  private String CancellaCiclo    = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ANAG_CICLI_FATRZEJBRemove(?) }";
  private String CaricaCiclo      = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ANAG_CICLI_FATRZEJBLoad(?) }";
  private String LeggiCiclo       = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ANAG_CICLI_FATRZEJBFindall(?,?) }";
  private String strControlloAccount = "{? = call " + StaticContext.PACKAGE_CLASSIC +".I5_2ANAG_CICLI_FATRZ_ConAcc(?) }";  
  

  public void creaCiclo(String desc_ciclo, int giorni_ciclo) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    try
    {
      
      conn = getConnection(dsName);
      cs = conn.prepareCall(CreaCiclo);
      cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
      cs.setString(2,desc_ciclo);
      cs.setInt(3,giorni_ciclo);
      cs.execute();
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2ANAG_CICLI_FATRZ","ejbCreate","I5_2ANAG_CICLI_FATRZ",StaticContext.FindExceptionType(e));                            
    }
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e){ System.out.println(e.getMessage());
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){ System.out.println(e.getMessage());
      }
    }
  }


  public Vector findAll(java.util.Date data_ricerca_da, java.util.Date data_ricerca_a) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;
    I5_2ANAG_CICLI_FATRZ_ROW riga;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiCiclo);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      if (data_ricerca_da==null){
        cs.setDate(2,null);      
      }else{
        cs.setDate(2,new java.sql.Date(data_ricerca_da.getTime()));
      }
      if (data_ricerca_a==null){
        cs.setDate(3,null);      
      }else{
        cs.setDate(3,new java.sql.Date(data_ricerca_a.getTime()));
      }
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
        riga = new I5_2ANAG_CICLI_FATRZ_ROW();
        riga.setCODE_CICLO_FATRZ(rs.getString("CODE_CICLO_FATRZ"));
        riga.setDESC_CICLO_FATRZ(rs.getString("DESC_CICLO_FATRZ"));
        riga.setVALO_GG_INIZIO_CICLO(rs.getInt("VALO_GG_INIZIO_CICLO"));
        riga.setDATA_CREAZ_CICLO(rs.getDate("DATA_CREAZ_CICLO"));
        Vectorpk.add(riga);
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di inserimento alla tabella I5_2ANAG_CICLI_FATRZ","ejbFindAll","I5_2ANAG_CICLI_FATRZ",StaticContext.FindExceptionType(e));                            
    } 
    finally {
      try {
         if (rs != null){
           rs.close();
         }
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return Vectorpk;
  }


  public I5_2ANAG_CICLI_FATRZ_ROW loadCiclo(String primaryKey) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_2ANAG_CICLI_FATRZ_ROW riga=null;
    
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaCiclo);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,primaryKey);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (found) 
      {
        riga = new I5_2ANAG_CICLI_FATRZ_ROW();
        riga.setCODE_CICLO_FATRZ(rs.getString("CODE_CICLO_FATRZ"));
        riga.setDESC_CICLO_FATRZ(rs.getString("DESC_CICLO_FATRZ"));
        riga.setVALO_GG_INIZIO_CICLO(rs.getInt("VALO_GG_INIZIO_CICLO"));
        riga.setDATA_CREAZ_CICLO(rs.getDate("DATA_CREAZ_CICLO"));
      }
      cs = conn.prepareCall(strControlloAccount);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,primaryKey);
      cs.execute();      
    } 
   catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di inserimento alla tabella I5_2ANAG_CICLI_FATRZ","loadCiclo","I5_2ANAG_CICLI_FATRZ",StaticContext.FindExceptionType(e));                            
    } 
    finally {
      try {
         if (rs != null){
           rs.close();
         }
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return riga;
  }

  public void removeCiclo(String primaryKey) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CancellaCiclo);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,primaryKey);
      cs.executeUpdate();
    } 
   catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di inserimento alla tabella I5_2ANAG_CICLI_FATRZ","removeCiclo","I5_2ANAG_CICLI_FATRZ",StaticContext.FindExceptionType(e));                            
    } 
    finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
  }

  public void updateCiclo(I5_2ANAG_CICLI_FATRZ_ROW riga)  throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(AggiornaCiclo);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,riga.getCODE_CICLO_FATRZ());
      cs.setString(3,riga.getDESC_CICLO_FATRZ());
      cs.setInt(4,riga.getVALO_GG_INIZIO_CICLO());
      cs.executeUpdate();
    } 
   catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di inserimento alla tabella I5_2ANAG_CICLI_FATRZ","updateCiclo","I5_2ANAG_CICLI_FATRZ",StaticContext.FindExceptionType(e));                            
    } 
    finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }  
  }

  public int controlloAccount(String primaryKey) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    ResultSet rs=null;
    int ControlloAccount;
    
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(strControlloAccount);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,primaryKey);
      cs.execute();      
      ControlloAccount = cs.getInt(1);          
    } 
   catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di inserimento alla tabella I5_2ANAG_CICLI_FATRZ","controlloAccount","I5_2ANAG_CICLI_FATRZ",StaticContext.FindExceptionType(e));                            
    } 
    finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return ControlloAccount;
  }



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
}