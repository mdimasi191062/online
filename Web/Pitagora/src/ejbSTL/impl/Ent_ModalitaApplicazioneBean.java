package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public class Ent_ModalitaApplicazioneBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getModalitaApplicazione()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_MODALITAAPPLICAZIONE_NEW + "getModalitaApplicazione";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_ModalitaApplicazione.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getModalitaApplicazione",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getModalitaApplicazioneXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getModalitaApplicazione();
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getModalitaApplicazioneXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  private String createXML(Vector lvct_Ret){

      DB_ModalitaApplicazione lcls_Obj = null;
      String Ret = "";
      String lstr_Code = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_ModalitaApplicazione)lvct_Ret.get(i);
        lstr_Code = lcls_Obj.getCODE_MODAL_APPL_TARIFFA();
        
        Ret += "<MODALITAAPPLICAZIONE ID=\"" + lstr_Code + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_MODAL_APPL_TARIFFA()) + "</DESC>";
        Ret += "</MODALITAAPPLICAZIONE>";
      }
      return Ret;
  }

}