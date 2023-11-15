package com.ejbSTL.impl;

import com.utl.CausaleElem;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;
import java.sql.*;

import oracle.jdbc.OracleCallableStatement;

public class Ctr_RepdecommBean extends AbstractClassicEJB implements SessionBean 
{

  public static final java.lang.String PACKAGE_REPDECOMM = "PKG_REPDECOMM";
  
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

  public Vector getlistaFile() throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PACKAGE_REPDECOMM + ".getlistaFile";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, I5_5DECO_ACCESSI_NOW_JPUB.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getlistaFile",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
    
  public Vector getlistaFileByFilter(String strlistaOAO,String istatComune)throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_REPDECOMM + ".getlistaFileByFilter";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,strlistaOAO},
                     {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,istatComune}
                        };

        Vector lcls_return =  this.callSP(larr_CallSP,I5_5DECO_ACCESSI_NOW_JPUB.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
              
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getlistaFileByFilter",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }
  
  
    public Vector getlistaOAO()throws CustomException, RemoteException{

      try{

        String lstr_StoredProcedure = PACKAGE_REPDECOMM + ".getlistaOAO";

        String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                      AbstractEJBTypes.TYPE_VECTOR}};

        Vector lcls_return =  this.callSP(larr_CallSP,I5_5DECO_ACCESSI_NOW_JPUB.class);
        Vector lvct_Return = (Vector)lcls_return.get(0);
        
            
        return lvct_Return;
        
      }
      catch(Exception lexc_Exception){
      
        throw new CustomException(lexc_Exception.toString(),
                        "",
                      "getlistaOAO",
                      this.getClass().getName(),
                      StaticContext.FindExceptionType(lexc_Exception));
      }
      
    }


}
