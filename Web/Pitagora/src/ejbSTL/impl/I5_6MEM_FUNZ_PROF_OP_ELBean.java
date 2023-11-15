package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import oracle.jdbc.OracleTypes;
import com.utl.StaticContext;
import com.utl.AbstractSequenceBean;
import java.util.*;
import com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL_ROW;
import com.ejbSTL.I5_6PROF_UTENTE_ROW;
import com.ejbSTL.I5_6ANAG_FUNZ_ROW;
import com.ejbSTL.I5_6OP_ELEM_ROW;
import java.rmi.RemoteException;
import java.sql.*;
import com.utl.*;

public class I5_6MEM_FUNZ_PROF_OP_ELBean  extends AbstractSessionCommonBean implements SessionBean 
{
  private String CreaAssociazione = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6MEM_F_P_Ocreate(?,?,?) }";
  private String ModificaAssociazione = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6MEM_F_P_Omodify(?,?,?,?,?,?) }";  
  private String CancellaAssociazione = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6MEM_F_P_Oremove(?,?,?) }";
  private String CaricaAssociazione = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6MEM_FUNZ_PROF_OP_ELEJBLoad(?,?,?) }";
  private String LeggiAssociazione = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6MEM_F_P_OfindAll(?,?,?) }";
  private String LeggiProfili = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6PROF_UTENTEfAll() }";  
  private String LeggiFunzioni = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_FUNZfindAll() }";  
  private String LeggiOperazioni = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6OP_ELEMfindAll() }";  
  
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
  public String insertAssociazione(String CODE_PROF_UTENTE, String CODE_FUNZ, String CODE_OP_ELEM) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    String ret=null;
    try 
    {
        conn = getConnection(dsName);
        cs = conn.prepareCall(CreaAssociazione);
        cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
        cs.setString(2,CODE_PROF_UTENTE);
        cs.setString(3,CODE_FUNZ);
        cs.setString(4,CODE_OP_ELEM);
        cs.execute();
        ret = cs.getString(1); 
		} 
    catch(Exception e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","insertAssociazione","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));      
		} 
    finally
		{
			try
			{
				conn.close();
			} 
      catch(Exception e)
			{
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","insertAssociazione","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));      
  		}      
		}
    return ret;
  }

  public Vector findAllAssociazione(String CODE_PROF_UTENTE, String CODE_FUNZ, String CODE_OP_ELEM) throws CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_6MEM_FUNZ_PROF_OP_EL_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiAssociazione);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      if (CODE_PROF_UTENTE==null)
      {
        cs.setNull(2,Types.VARCHAR);
      }
      else
      {
        cs.setString(2,CODE_PROF_UTENTE);
      }
      if (CODE_FUNZ==null)
      {
        cs.setNull(3,Types.VARCHAR);
      }
      else
      {
        cs.setString(3,CODE_FUNZ);
      }
      if (CODE_OP_ELEM==null)
      {
        cs.setNull(4,Types.VARCHAR);
      }
      else
      {
        cs.setString(4,CODE_OP_ELEM);
      }      
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_6MEM_FUNZ_PROF_OP_EL_ROW();
        row.setCODE_PROF_UTENTE(rs.getString("CODE_PROF_UTENTE"));
        row.setCODE_FUNZ(rs.getString("CODE_FUNZ"));
        row.setCODE_OP_ELEM(rs.getString("CODE_OP_ELEM"));        
        row.setDESC_OP_ELEM(rs.getString("DESC_OP_ELEM"));        
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllAssociazione","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));      
    } 
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e) 
      { 
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllAssociazione","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e) 
      {
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllAssociazione","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
      }
    }
    return recs;
  }

  public Vector findAllProfili() throws CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_6PROF_UTENTE_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiProfili);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_6PROF_UTENTE_ROW();
        row.setCODE_PROF_UTENTE(rs.getString("CODE_PROF_UTENTE"));
        row.setDESC_PROF_UTENTE(rs.getString("DESC_PROF_UTENTE"));        
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllProfili","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllProfili","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
        }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }

  public Vector findAllFunzioni() throws CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_6ANAG_FUNZ_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiFunzioni);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_6ANAG_FUNZ_ROW();
        row.setCODE_FUNZ(rs.getString("CODE_FUNZ"));
        row.setDESC_FUNZ(rs.getString("DESC_FUNZ"));        
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllFunzioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } 
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllFunzioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
      }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }
  

  public Vector findAllOperazioni() throws CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_6OP_ELEM_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiOperazioni);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_6OP_ELEM_ROW();
        row.setCODE_OP_ELEM(rs.getString("CODE_OP_ELEM"));
        row.setDESC_OP_ELEM(rs.getString("DESC_OP_ELEM"));        
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } 
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
      }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }

  public void removeAssociazione(String CODE_PROF_UTENTE, String CODE_FUNZ, String CODE_OP_ELEM) throws RemoteException , CustomException
  {
    CallableStatement cs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CancellaAssociazione);
      cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
      cs.setString(2,CODE_PROF_UTENTE);
      cs.setString(3,CODE_FUNZ);      
      cs.setString(4,CODE_OP_ELEM);            
      cs.execute();
      conn.close();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    } 
    catch(Exception e)
    {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    }
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
      }
      try 
      {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
}
 public String modifyAssociazione(String oldCODE_PROF_UTENTE, 
                                String oldCODE_FUNZ, 
                                String oldCODE_OP_ELEM,
                                String newCODE_PROF_UTENTE, 
                                String newCODE_FUNZ, 
                                String newCODE_OP_ELEM) throws RemoteException , CustomException
  {
    CallableStatement cs = null;
    String ret=null;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(ModificaAssociazione);
      cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
      cs.setString(2,oldCODE_PROF_UTENTE);
      cs.setString(3,oldCODE_FUNZ);      
      cs.setString(4,oldCODE_OP_ELEM);            
      cs.setString(5,newCODE_PROF_UTENTE);
      cs.setString(6,newCODE_FUNZ);      
      cs.setString(7,newCODE_OP_ELEM);                  
      cs.execute();
      ret = cs.getString(1);       
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    } 
    catch(Exception e)
    {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
    }
    finally 
    {
      try 
      {
	       cs.close();
      } 
      catch (Exception e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_6MEM_FUNZ_PROF_OP_EL","findAllOperazioni","I5_6MEM_FUNZ_PROF_OP_ELBean",StaticContext.FindExceptionType(e));
      }
      try 
      {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return ret;
  }
}