package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;

public class Ent_FasceNewBean extends AbstractClassicEJB implements SessionBean 
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

      String lstr_StoredProcedure = StaticContext.PKG_FASCE_NEW + "getAnagraficaFasce";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_FasciaNew.class);
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

  public Vector getFasce()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_FASCE_NEW + "getFasce";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_FasciaNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getFasce",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  private String createXML(Vector lvct_Ret){

      DB_FasciaNew lcls_Obj = null;
      String Ret = "";
      String lstr_CodeObj = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_FasciaNew)lvct_Ret.get(i);
        lstr_CodeObj = lcls_Obj.getCODE_FASCIA();
        
        Ret += "<FASCIA ID=\"" + lstr_CodeObj + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_FASCIA()) + "</DESC>";
        Ret += "<CODE_UM>" + lcls_Obj.getCODE_UNITA_DI_MISURA() + "</CODE_UM>";
        Ret += "<DESC_UM>" + Utility.encodeXML(lcls_Obj.getDESC_UNITA_MISURA()) + "</DESC_UM>";
        while (lstr_CodeObj.equals(lcls_Obj.getCODE_FASCIA()))
        {
          Ret += "<DETTAGLIO>";
          Ret += "<PR>" + lcls_Obj.getCODE_PR_FASCIA() + "</PR>";
          Ret += "<VAL_MIN>" + lcls_Obj.getVALO_LIM_MIN() + "</VAL_MIN>";
          Ret += "<VAL_MAX>" + lcls_Obj.getVALO_LIM_MAX() + "</VAL_MAX>";
          Ret += "<DATA_INIZIO_VAL>" + lcls_Obj.getDATA_INIZIO_VALID() + "</DATA_INIZIO_VAL>";
          Ret += "<DATA_FINE_VAL>" + lcls_Obj.getDATA_FINE_VALID() + "</DATA_FINE_VAL>";
          Ret += "</DETTAGLIO>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Obj = (DB_FasciaNew)lvct_Ret.get(i);
        }
        i--;
        Ret += "</FASCIA>";
      }
      return Ret;
  }

  public String getFasceXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getFasce();
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getFasceXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

    public Vector getUnitaDiMisura()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_FASCE_NEW + "getUnitaDiMisura";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_UnitaMisura.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getUnitaDiMisura",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

}