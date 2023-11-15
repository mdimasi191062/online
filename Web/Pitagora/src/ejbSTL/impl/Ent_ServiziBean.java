package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;


public class Ent_ServiziBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getServizi()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_SERVIZI + "getServizi";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Servizio.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getServizi",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getServiziXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getServizi();
      DB_Servizio lcls_Servizio = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_Servizio = (DB_Servizio)lvct_Ret.get(i);
        Ret += "<SERVIZIO ID=\"" + lcls_Servizio.getCODE_SERVIZIO() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Servizio.getDESC_SERVIZIO()) + "</DESC></SERVIZIO>";
       
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getServiziXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

}