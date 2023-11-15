package com.ejbSTL.impl;
import com.utl.*;
import javax.sql.*;
import javax.naming.*;
import javax.ejb.*;
import java.util.*;
import java.rmi.*;
import oracle.jdbc.OracleTypes;
import java.sql.*;

public class ISTATBean extends AbstractSessionCommonBean implements SessionBean 
{
  private String LeggiIndici = "{? = call " + StaticContext.PACKAGE_SPECIAL +".ISTATFindall(?) }";
  private String AggTariffeXsito ="{? = call " + StaticContext.PACKAGE_SPECIAL +".AggTariffaXsito(?,?,?) }";
  private String InsTabIstat="{? = call " + StaticContext.PACKAGE_SPECIAL +".InsTabIstat(?,?) }";
  private static final String CHECKBATCHStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC +".CHECK_BATCH() }";
  private static final String CHECKTIPOFLAGStatement ="{? = call " + StaticContext.PACKAGE_SPECIAL +".Check_Tipo_Flag(?) }";
  private  String DelTabIstat ="{? = call " + StaticContext.PACKAGE_SPECIAL +".I5_1ISTATremove(?) }";
  private  String DelTariffeXsito ="{? = call " + StaticContext.PACKAGE_SPECIAL +".I5_2TARIFFA_X_SITOremove(?) }";
  
  public void ejbActivate()
  {
      System.out.println("activate");
  }

  public void ejbPassivate()
  {
      System.out.println("passivato");
  }

  public Vector ElencoIndici(String sAnno) throws java.rmi.RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector theVector = new Vector();
    ResultSet rs = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiIndici);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,sAnno);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {  
        IndiceIstat indice_istat= new IndiceIstat();
        indice_istat.setAnno(rs.getString(1));
        indice_istat.setIndice(new Float(rs.getFloat(2)));
        theVector.addElement(indice_istat);
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","ElencoIndici","I5_1ISTAT",StaticContext.FindExceptionType(e));    
    } finally {
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
    return theVector;
  }
  
  public void AggTariffePerSito(String newANNO, Float newIndice_Istat, String pCode_Utente)  throws RemoteException, CreateException,CustomException
  {
    CallableStatement cs = null;
    try 
    {    
			conn = getConnection(dsName);
      cs = conn.prepareCall(AggTariffeXsito);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,newANNO);
      cs.setDouble(3,newIndice_Istat.doubleValue());
      cs.setString(4,pCode_Utente);    
      cs.execute();
      conn.close();
    }
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","AggTariffePerSito","I5_1ISTAT",StaticContext.FindExceptionType(e));    
    } finally {
      try {
         cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
  }

 public void InsTabellaIstat(String newANNO, Float newIndice_Istat)  throws RemoteException, CreateException,CustomException
  {
    CallableStatement cs = null;
    try 
    {        
			conn = getConnection(dsName);
      cs = conn.prepareCall(InsTabIstat);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,newANNO);
      cs.setDouble(3,newIndice_Istat.doubleValue());
      cs.execute();
      conn.close();
    }
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","InsTabellaIstat","I5_1ISTAT",StaticContext.FindExceptionType(e));    
    } finally {
      try {
         cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
  }

 public void ejbCreate()
  {
  }

  public int checkBatch() throws RemoteException,CustomException
	{    
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(CHECKBATCHStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.execute();
      ret = cs.getInt(1);
		} 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","checkBatch","I5_1ISTAT",StaticContext.FindExceptionType(e));    
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
			}
		}
		return ret;
	}



 public void RemoveIstat(String pAnno) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    try     
    {     
      conn = getConnection(dsName);
      cs = conn.prepareCall(DelTabIstat);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,pAnno);
      cs.execute();
      conn.close();
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","RemoveIstat","I5_1ISTAT",StaticContext.FindExceptionType(e));    
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e){	
      }
			try
			{
				conn.close();
			} catch(Exception e){
			}
		}  
  }


 public void RemoveTariffaXSito(String pAnno) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    try     
    {     
      conn = getConnection(dsName);
      cs = conn.prepareCall(DelTariffeXsito);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,pAnno);
      cs.execute();
      conn.close();
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","RemoveIstat","I5_1ISTAT",StaticContext.FindExceptionType(e));    
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e){	
      }
			try
			{
				conn.close();
			} catch(Exception e){
			}
		}  
  }



public int checkTipoFlag(String pAnno) throws RemoteException,CustomException
	{
    
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(CHECKTIPOFLAGStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.setString(2,pAnno);
      cs.execute();
      ret = cs.getInt(1);
		} 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ISTAT","checkTipoFlag","I5_1ISTAT",StaticContext.FindExceptionType(e));    
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e){	
      }
			try
			{
				conn.close();
			} catch(Exception e){
			}
		}  
		return ret;
	}
}