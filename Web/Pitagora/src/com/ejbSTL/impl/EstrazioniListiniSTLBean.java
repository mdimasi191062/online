package com.ejbSTL.impl;

import com.utl.AbstractClassicEJB;

import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;

import com.utl.StaticContext;

import java.rmi.RemoteException;

import java.sql.PreparedStatement;

import java.util.Vector;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class EstrazioniListiniSTLBean extends AbstractSessionCommonBean implements SessionBean 
{
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
  
  
  public void insertRisorse(Vector risorse) throws CustomException, RemoteException
  {
    PreparedStatement ps=null;
    
    try
    {
     conn = getConnection(dsName);
     ps=conn.prepareStatement("truncate table I5_6ESTRAZIONI_LISTINI_TEMP");
     ps.execute();
     
     ps=conn.prepareStatement("insert into I5_6ESTRAZIONI_LISTINI_TEMP values (?)");
    
    for(int i=0;i<risorse.size();i++)
    {
        ps.setString(1,risorse.get(i).toString());
        ps.execute();
    }
    conn.commit();

    }
    catch(Exception lexc_Exception)
    {
    throw new CustomException(lexc_Exception.toString(),
                    "",
                  "getAccountRepricing",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
    finally
    {
    try{
      ps.close();
    }catch(Exception ignoreme){}
    try{
      conn.close();
      }catch(Exception ignoreme){}
    }
  }
}
