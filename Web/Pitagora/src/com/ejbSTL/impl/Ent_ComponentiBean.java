package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.CustomException;

public class Ent_ComponentiBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getComponenti(int Prodotto)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_COMPONENTI + "getComponenti";

      String[][] larr_CallSP ={{lstr_StoredProcedure}, 
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Prodotto)},
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Componente.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                 
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getComponenti(" + Prodotto + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }  
}