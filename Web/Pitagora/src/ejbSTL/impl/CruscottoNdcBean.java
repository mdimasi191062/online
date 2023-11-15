package com.ejbSTL.impl;

import com.utl.AbstractClassicEJB;
import com.utl.AbstractEJBTypes;
import com.utl.AbstractSessionCommonBean;

import com.utl.CustomException;
import com.utl.DB_AliquotaIva;
import com.utl.DB_CruscottoNdc;
import com.utl.StaticContext;

import java.rmi.RemoteException;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Collection;
import java.util.Vector;

import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import oracle.jdbc.OracleTypes;

public class CruscottoNdcBean extends AbstractClassicEJB implements SessionBean
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

  public Vector findAll( String FiltroDATA_INIZIO_CICLO_FATRZ, String FiltroDATA_FINE_CICLO_FATRZ, String FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT, String FiltroRIFERITO_FATTURA, String FiltroCODE_GEST, String FiltroCODE_ACCOUNT) throws FinderException, RemoteException,CustomException
  {
  
    FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT = ( ("-1").equals(FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT) ) ? null : FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT;
    FiltroRIFERITO_FATTURA = ( ("-1").equals(FiltroRIFERITO_FATTURA) ) ? null : FiltroRIFERITO_FATTURA;
    
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_CLASSIC + ".I5_2CruscottoFindAll";
      System.out.println(lstr_StoredProcedure);
      
      String[][] larr_CallSP =
                  {
                   {lstr_StoredProcedure},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroDATA_INIZIO_CICLO_FATRZ},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroDATA_FINE_CICLO_FATRZ},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroRIFERITO_FATTURA},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroCODE_GEST},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroCODE_ACCOUNT},
                  };
                   
      Vector lcls_return =  this.callSP(larr_CallSP,DB_CruscottoNdc.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "I5_2CruscottoFindAll",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }  
  
  
  }
  
  public Vector findAll_cla( String FiltroDATA_INIZIO_CICLO_FATRZ, String FiltroDATA_FINE_CICLO_FATRZ, String FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT, String FiltroRIFERITO_FATTURA, String FiltroCODE_GEST, String FiltroCODE_ACCOUNT) throws FinderException, RemoteException,CustomException
  {
  
    FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT = ( ("-1").equals(FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT) ) ? null : FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT;
    FiltroRIFERITO_FATTURA = ( ("-1").equals(FiltroRIFERITO_FATTURA) ) ? null : FiltroRIFERITO_FATTURA;
    
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_CLASSIC + ".I5_2CruscottoFindAll_cla";
      System.out.println(lstr_StoredProcedure);
      
      String[][] larr_CallSP =
                  {
                   {lstr_StoredProcedure},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroDATA_INIZIO_CICLO_FATRZ},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroDATA_FINE_CICLO_FATRZ},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroRIFERITO_FATTURA},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroCODE_GEST},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, FiltroCODE_ACCOUNT},
                  };
                   
      Vector lcls_return =  this.callSP(larr_CallSP,DB_CruscottoNdc.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "I5_2CruscottoFindAll_cla",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }  
  
  
  }

  
}
