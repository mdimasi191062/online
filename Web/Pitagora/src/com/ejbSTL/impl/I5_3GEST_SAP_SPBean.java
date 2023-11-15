package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import oracle.jdbc.OracleTypes;
import com.utl.StaticContext;
import com.utl.AbstractSequenceBean;
import java.util.*;
import com.ejbSTL.I5_3GEST_SAP_SP_ROW;


import java.rmi.RemoteException;
import java.sql.*;
import com.utl.*;

public class I5_3GEST_SAP_SPBean  extends AbstractSessionCommonBean implements SessionBean 
{
  private final String PKG_NAME = "PKG_BILL_SPE";
  private String findAllGestSap = "{? = call " + PKG_NAME +".GET_RESULTSET_GEST_SAP_SP() }";
  private String insertGestSap  = "{? = call " + PKG_NAME +".I5_3GEST_SAP_SPIns(?,?,?,?) }";  
  private String checkGestSap  = "{? = call " + PKG_NAME +".checkGestSap(?,?,?,?) }";  
  private String find = "{? = call PKG_UTILITY.GET_RESULTSET_GEST_SAP_SP_ONE(?,?,?) }";
  private String modify = "{? = call PKG_UTILITY.MODIF_GEST_SAP_SP_ONE(?,?,?,?) }";
  
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
  
  public Vector findAll() throws CustomException
  {

    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_3GEST_SAP_SP_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(findAllGestSap);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_3GEST_SAP_SP_ROW();
        row.setCODE_GEST_SAP(rs.getString("CODE_GEST_SAP"));
        row.setCODE_GEST(rs.getString("CODE_GEST"));     
        row.setNOME_RAG_SOC_GEST(rs.getString("NOME_RAG_SOC_GEST")); 
        row.setDATA_INIZIO_VALID(rs.getString("DATA_INIZIO_VALID"));
        row.setDATA_FINE_VALID(rs.getString("DATA_FINE_VALID"));
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","findAll","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","findAll","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
        }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }


  public Vector findOne(String gestSap, String gest, String descGest) throws CustomException
  {

    CallableStatement cs = null;
    Vector recs = new Vector();
    I5_3GEST_SAP_SP_ROW row = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(find);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,gestSap);
      cs.setString(3,gest);  
      cs.setString(4,descGest);  
      cs.execute();
      ResultSet rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      { 
        row =  new I5_3GEST_SAP_SP_ROW();
        row.setCODE_GEST_SAP(rs.getString("CODE_GEST_SAP"));
        row.setCODE_GEST(rs.getString("CODE_GEST"));     
        row.setNOME_RAG_SOC_GEST(rs.getString("NOME_RAG_SOC_GEST"));     
        row.setDATA_INIZIO_VALID(rs.getString("DATA_INIZIO_VALID"));
        row.setDATA_FINE_VALID(rs.getString("DATA_FINE_VALID"));
        recs.add(row);
      } 
      rs.close();
    } 
    catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","findAll","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {
              System.out.println(e.getMessage());
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","findAll","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
        }
      try {
	       conn.close();
      } catch (Exception e) {System.out.println(e.getMessage());}
    }
    return recs;
  }

    public Boolean modifyGestoreSap(I5_3GEST_SAP_SP_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(modify);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setString(2,row.getCODE_GEST_SAP());
          cs.setString(3,row.getCODE_GEST());      
          cs.setString(4,row.getDATA_INIZIO_VALID());            
          cs.setString(5,row.getDATA_FINE_VALID());

          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","update","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
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
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","update","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }

        if (ret != 1){
            return false;
        }
        
        return true;
    }

    public Boolean insertGestoreSap(I5_3GEST_SAP_SP_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(insertGestSap);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setString(2,row.getCODE_GEST_SAP());
          cs.setString(3,row.getCODE_GEST());      
          cs.setString(4,row.getDATA_INIZIO_VALID());            
          cs.setString(5,row.getDATA_FINE_VALID());

          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","insert","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
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
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","insert","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }

        if (ret != 1){
            return false;
        }
        
        return true;
    }

    public Boolean checkGestoreSap(I5_3GEST_SAP_SP_ROW row) throws CustomException {
        
        CallableStatement cs = null;
        Integer ret=1;
        try 
        {
          conn = getConnection(dsName);
          
          cs = conn.prepareCall(checkGestSap);
          cs.registerOutParameter(1,Types.INTEGER) ;
          cs.setString(2,row.getCODE_GEST_SAP());
          cs.setString(3,row.getCODE_GEST());      
          cs.setString(4,row.getDATA_INIZIO_VALID());            
          cs.setString(5,row.getDATA_FINE_VALID());

          cs.execute();
          ret = cs.getInt(1);       
        } 
        catch(Exception e)
        {
            System.out.println(e.getMessage());
            throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","insert","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
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
              throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_SAP_SP","insert","I5_3GEST_SAP_SPBean",StaticContext.FindExceptionType(e));
          }
          try 
          {
                   conn.close();
          } catch (Exception e) {System.out.println(e.getMessage());}
        }

        if (ret > 0){
            return false;
        }
        
        return true;
    }
 
}
  
