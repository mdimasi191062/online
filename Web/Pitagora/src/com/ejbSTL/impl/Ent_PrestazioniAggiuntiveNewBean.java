package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class Ent_PrestazioniAggiuntiveNewBean extends AbstractClassicEJB implements SessionBean 
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

   public Vector getPrestAggComponente(int Componente)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_PRESTAZIONIAGGIUNTIVE_NEW + "getPrestAggComponente";

      String[][] larr_CallSP ={{lstr_StoredProcedure}, 
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Componente)},
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PrestazioneAggiuntiva.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                 
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPrestAggComponente(" + Componente + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }  

  public Vector getPrestAggProdotto(int Prodotto)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_PRESTAZIONIAGGIUNTIVE_NEW + "getPrestAggProdotto";

      String[][] larr_CallSP ={{lstr_StoredProcedure}, 
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Prodotto)},
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PrestazioneAggiuntiva.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                 
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPrestAggProdotto(" + Prodotto + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }  
}