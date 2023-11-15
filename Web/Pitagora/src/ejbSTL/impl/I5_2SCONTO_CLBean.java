package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import oracle.jdbc.OracleTypes;
import com.utl.*;
import java.util.*;
import java.rmi.RemoteException;
import java.sql.*;
import java.math.BigDecimal;

public class I5_2SCONTO_CLBean  extends AbstractSessionCommonBean implements SessionBean 
{
  private String CreaSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2SCONTOEJBCreate(?,?,?,?) }";
  private String AggiornaSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2SCONTOEJBStore(?,?,?,?) }";
  private String CancellaSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2SCONTOEJBRemove(?) }";
  private String CaricaSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2SCONTOEJBLoad(?) }";
  private String LeggiSconto = "{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2SCONTOEJBFindall(?) }";
  private String CheckCodeScontoStatement = "{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2SCONTOEJBCheckCodeSconto(?) }";
  
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
  public void insertSconto(String desc_sconto, Integer perc_sconto, java.math.BigDecimal decremento,String code_utente) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    try 
      {
        conn = getConnection(dsName);
        cs = conn.prepareCall(CreaSconto);
        cs.registerOutParameter(1,OracleTypes.VARCHAR) ;
        cs.setString(2,desc_sconto);
        if (perc_sconto==null)
        {
          cs.setNull(3,Types.INTEGER);
        }
        else
        {
          cs.setInt(3,perc_sconto.intValue());
        }
        if (decremento==null)
        {
          cs.setNull(4,Types.DECIMAL);
        }
        else
        {
          cs.setBigDecimal(4,decremento);
        }
        if (code_utente==null)
        {
          cs.setNull(5,Types.VARCHAR);
        }
        else
        {
          cs.setString(5,code_utente);
        }      
        cs.execute();
      }
      catch (SQLException e) 
      {
        System.out.println(e.getMessage());
        throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2SCONTO_CL","insertSconto","I5_2SCONTO_CL",StaticContext.FindExceptionType(e));
      }finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
  }

  public Vector findAll(String strDescSconto) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_2SCONTO_CL_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiSconto);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      if (strDescSconto==null)
      {
        cs.setNull(2,Types.VARCHAR);
      }
      else
      {
        cs.setString(2,strDescSconto);
      }
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_2SCONTO_CL_ROW();
        row.setCodeSconto(rs.getString("CODE_SCONTO"));
        row.setDescSconto(rs.getString("DESC_SCONTO"));
        if(rs.getObject(8)!=null)
        {
          BigDecimal appo = (BigDecimal) rs.getObject(8);
          row.setDecremento(appo);
        }
        if(rs.getObject(7)!=null)
        {
          BigDecimal appo = (BigDecimal) rs.getObject(7);
          row.setPercSconto(new Integer(appo.intValue()));
        }
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2SCONTO_CL","findAll","I5_2SCONTO_CL",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }


  public I5_2SCONTO_CL_ROW loadSconto(String CodeSconto) throws RemoteException,CustomException
  {

    CallableStatement cs = null;
    I5_2SCONTO_CL_ROW row = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CaricaSconto);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,CodeSconto);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      boolean found = rs.next();
      if (found) 
      {
        row =  new I5_2SCONTO_CL_ROW();
        row.setCodeSconto(rs.getString("CODE_SCONTO"));
        row.setDescSconto(rs.getString("DESC_SCONTO"));
        if(rs.getObject(8)!=null)
        {
          BigDecimal appo = (BigDecimal) rs.getObject(8);
          row.setDecremento(appo);
        }
        if(rs.getObject(7)!=null)
        {
          BigDecimal appo = (BigDecimal) rs.getObject(7);
          row.setPercSconto(new Integer(appo.intValue()));
        }
      }
      rs.close();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2SCONTO_CL","loadSconto","I5_2SCONTO_CL",StaticContext.FindExceptionType(e));
    }finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return row;
  }

  public void removeSconto(String CodeSconto)  throws RemoteException,CustomException
  {
    CallableStatement cs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CancellaSconto);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,CodeSconto);
      cs.execute();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2SCONTO_CL","removeSconto","I5_2SCONTO_CL",StaticContext.FindExceptionType(e));
    }finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
  }


  public void saveSconto(String codesconto,String descsconto,Integer percsconto,java.math.BigDecimal decremento) throws RemoteException,CustomException
  {
    CallableStatement cs = null;

    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(AggiornaSconto);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,codesconto);
      cs.setString(3,descsconto);
      if (percsconto==null)
      {
        cs.setNull(4,Types.INTEGER);
      }
      else
      {
        cs.setInt(4,percsconto.intValue());
      }
      if (decremento==null)
      {
        cs.setNull(5,Types.DECIMAL);
      }
      else
      {
        cs.setBigDecimal(5,decremento);
      }
      cs.execute();
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2SCONTO_CL","saveSconto","I5_2SCONTO_CL",StaticContext.FindExceptionType(e));
    }finally {
      try {
	       cs.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
 
  }



  public int CheckCodeSconto(String CodeSconto) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    int ret=0;
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(CheckCodeScontoStatement);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setString(2,CodeSconto);
      cs.execute();
      ret = cs.getInt(1);
      conn.close();     
    } 
    catch (SQLException e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2SCONTO_CL","CheckCodeSconto","I5_2SCONTO_CL",StaticContext.FindExceptionType(e));
    }finally {
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