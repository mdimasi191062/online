package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class Ent_RegoleTariffeBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getAnagraficaRegoleTariffe()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_REGOLE_TARIFFE + "getAnagraficaRegoleTariffe";
      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};
      Vector lcls_return =  this.callSP(larr_CallSP,DB_RegolaTariffa.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAnagraficaRegoleTariffe",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getRegoleTariffa(int Code_Tariffa,int tipoTariffa)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure ="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "getRegoleTariffa";
      } else{
      lstr_StoredProcedure = StaticContext.PKG_TARIFFE_NEW + "getRegoleTariffa";
      }
 
      //System.out.println("lstr_StoredProcedure "+lstr_StoredProcedure);
      String[][] larr_CallSP ={{lstr_StoredProcedure},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Code_Tariffa)}
              };
      //System.out.println("larr_CallSP "+larr_CallSP.length);
      Vector lcls_return =  this.callSP(larr_CallSP,DB_RegolaTariffa.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getRegoleTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public void insertRegoleTariffa(int Code_Regola,int Code_Tariffa,int Code_Pr_Tariffa,String Param ,int tipoTariffa)throws CustomException, RemoteException{

    try{
      String lstr_StoredProcedure ="";
      // TARIFFE_VERIFICA
      if (tipoTariffa != 0 ) {
        lstr_StoredProcedure = StaticContext.PKG_TARIFFE_VERIFICA + "insertRegolaTariffa";
      } else{
        lstr_StoredProcedure = StaticContext.PKG_REGOLE_TARIFFE + "insertRegolaTariffa";
      }

 

      String[][] larr_CallSP ={{lstr_StoredProcedure},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Code_Regola)},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Code_Tariffa)},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Code_Pr_Tariffa)} ,
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,Param}              
              };

      this.callSP(larr_CallSP,DB_RegolaTariffa.class);
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "insertRegoleTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public DB_RegolaTariffa getDescRegolaTariffa(int Code_Regola)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_REGOLE_TARIFFE + "getDescRegolaTariffa";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Code_Regola)}
              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_RegolaTariffa.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return (DB_RegolaTariffa)lvct_Return.get(0);
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getDescRegolaTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getStoricoRegoleTariffa(int CodeTariffa,String DataCreazione)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_REGOLE_TARIFFE + "getStoricoRegolaTariffa";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER,String.valueOf(CodeTariffa)},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,DataCreazione}
              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_RegolaTariffa.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getStoricoRegoleTariffa",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

}
