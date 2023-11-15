package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class Ent_DownloadParamBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private String strDownloadParam = "{? = call " + StaticContext.PKG_DOWNLOAD +" GET_DOWNLOAD_PARAM(?) }";

  
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
  public DB_DownloadParam getDownloadParam(String codiceFunzione) throws  RemoteException,CustomException
  {
    DB_DownloadParam riga = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Vector recs = new Vector();
    int contaRighe = 0;
    
    try 
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(strDownloadParam);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,codiceFunzione);
      cs.execute();  
      rs = (ResultSet)cs.getObject(1);      
    
      while (rs.next()) 
      { 
        riga =  new DB_DownloadParam();
        riga.setCODICE_FUNZIONE(rs.getString("CODICE_FUNZIONE"));
        riga.setPATH(rs.getString("PATH"));        
        riga.setNAME_FINDER(rs.getString("NAME_FINDER"));
        riga.setFLAG_SYS(rs.getString("FLAG_SYS"));
        
        contaRighe++;
      } 
      
      rs.close();
    }
    catch (Exception e) 
    {
      System.out.println(e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","strDownloadParam","Ent_DownloadParamBean",StaticContext.FindExceptionType(e));      
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
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","strDownloadParam","Ent_DownloadParamBean",StaticContext.FindExceptionType(e));      
      }
      try 
      {
	       conn.close();
      } 
      catch (Exception e){
        throw new CustomException(e.toString(),"Errore di accesso alla tabella delle funzionalità","strDownloadParam","Ent_DownloadParamBean",StaticContext.FindExceptionType(e));          
      }
    }
    if (contaRighe > 1)
    {
      throw new CustomException("Too many rows returned","Errore di accesso alla tabella delle funzionalità","strDownloadParam","Ent_DownloadParamBean","SqlException");                
    }
    return riga;
  }
  
}