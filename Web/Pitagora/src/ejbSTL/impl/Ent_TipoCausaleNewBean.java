package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public class Ent_TipoCausaleNewBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getTipiCausale()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_TIPICAUSALE_NEW + "getTipoCausale";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TipoCausaleNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getTipiCausale",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getTipiCausaleXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getTipiCausale();
      DB_TipoCausaleNew lcls_TipoCausale = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_TipoCausale = (DB_TipoCausaleNew)lvct_Ret.get(i);
        Ret += "<TIPO_CAUSALE ID=\"" + lcls_TipoCausale.getCODE_TIPO_CAUSALE() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_TipoCausale.getDESC_TIPO_CAUSALE()) + "</DESC></TIPO_CAUSALE>";
       
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getTipiCausaleXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

}