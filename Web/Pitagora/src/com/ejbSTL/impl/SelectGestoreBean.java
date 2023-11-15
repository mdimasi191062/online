package com.ejbSTL.impl;

import com.utl.AbstractClassicEJB;
import com.utl.AbstractEJBTypes;
import com.utl.CustomException;

import com.utl.DB_CruscottoNdc;
import com.utl.DB_Gestore;
import com.utl.StaticContext;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class SelectGestoreBean extends AbstractClassicEJB implements SessionBean
{
  private SessionContext _context;

  public void ejbCreate()
  {
  }

  public void setSessionContext(SessionContext context) throws EJBException
  {
    _context = context;
  }

  public void ejbRemove() throws EJBException
  {
  }

  public void ejbActivate() throws EJBException
  {
  }

  public void ejbPassivate() throws EJBException
  {
  }
  
  public Vector findGest( String codGest, String codAccount, String descAccount ) throws FinderException, RemoteException,CustomException {
  
    codGest = ( (" ").equals(codGest) ) ? null : codGest;

    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_CLASSIC + ".SelectGestore";
      System.out.println(lstr_StoredProcedure);
      System.out.println("CODE_GESTORE: " + codGest);
      
      String[][] larr_CallSP =
                  {
                   {lstr_StoredProcedure},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codAccount},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descAccount}
                  };
                   
      Vector lcls_return =  this.callSP(larr_CallSP,DB_Gestore.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "SelectGestore",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }  
  
  }
  

  public Vector findGest_cla( String codGest, String codAccount, String descAccount ) throws FinderException, RemoteException,CustomException {
  
    codGest = ( (" ").equals(codGest) ) ? null : codGest;

    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_CLASSIC + ".SelectGestore_cla";
      System.out.println(lstr_StoredProcedure);
      System.out.println("CODE_GESTORE: " + codGest);
      
      String[][] larr_CallSP =
                  {
                   {lstr_StoredProcedure},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codGest},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codAccount},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descAccount}
                  };
                   
      Vector lcls_return =  this.callSP(larr_CallSP,DB_Gestore.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "SelectGestore_cla",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }  
  
  }
  
}
