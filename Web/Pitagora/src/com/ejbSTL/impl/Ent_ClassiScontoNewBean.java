package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.CustomException;

public class Ent_ClassiScontoNewBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getAnagrafica()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CLASSISCONTO_NEW + "getAnagraficaClassiDiSconto";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_ClasseScontoNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAnagrafica",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getClassiDiSconto()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CLASSISCONTO_NEW + "getClassiDiSconto";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_ClasseScontoNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getClassiDiSconto",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  private String createXML(Vector lvct_Ret){

      DB_ClasseScontoNew lcls_Obj = null;
      String Ret = "";
      String lstr_CodeObj = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_ClasseScontoNew)lvct_Ret.get(i);
        lstr_CodeObj = lcls_Obj.getCODE_CLAS_SCONTO();
        
        Ret += "<CLASSESCONTO ID=\"" + lstr_CodeObj + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_CLAS_SCONTO()) + "</DESC>";
        while (lstr_CodeObj.equals(lcls_Obj.getCODE_CLAS_SCONTO()))
        {
          Ret += "<DETTAGLIO>";
          Ret += "<PR>" + lcls_Obj.getCODE_PR_CLAS_SCONTO() + "</PR>";
          Ret += "<IMP_MIN>" + lcls_Obj.getIMPT_MIN_SPESA() + "</IMP_MIN>";
          Ret += "<IMP_MAX>" + lcls_Obj.getIMPT_MAX_SPESA() + "</IMP_MAX>";
          Ret += "<DATA_INIZIO_VAL>" + lcls_Obj.getDATA_INIZIO_VALID() + "</DATA_INIZIO_VAL>";
          Ret += "<DATA_FINE_VAL>" + lcls_Obj.getDATA_FINE_VALID() + "</DATA_FINE_VAL>";
          Ret += "</DETTAGLIO>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Obj = (DB_ClasseScontoNew)lvct_Ret.get(i);
        }
        i--;
        Ret += "</CLASSESCONTO>";
      }
      return Ret;
  }

  public String getClassiDiScontoXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getClassiDiSconto();
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getClassiDiScontoXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }
}