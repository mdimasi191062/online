package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public class Ent_OggettoFatturazioneNewBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getOggettiFatturazione(int CodeServizio)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_OGGETTIFATTURAZIONE_NEW + "getOggettiFatturazione";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                        {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                        {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(CodeServizio)}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_OggettoFatturazioneNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOggettiFatturazione(" + String.valueOf(CodeServizio) + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getOggettiFatturazioneXml(int CodeServizio)throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getOggettiFatturazione(CodeServizio);
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOggettiFatturazioneXml(" + String.valueOf(CodeServizio) + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  private String createXML(Vector lvct_Ret){

      DB_OggettoFatturazioneNew lcls_Obj = null;
      String Ret = "";
      String lstr_Code = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Obj = (DB_OggettoFatturazioneNew)lvct_Ret.get(i);
        lstr_Code = lcls_Obj.getCODE_OGGETTO_FATRZ();
        
        Ret += "<OGGETTOFATT ID=\"" + lstr_Code + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Obj.getDESC_OGGETTO_FATRZ()) + "</DESC>";
        Ret += "</OGGETTOFATT>";
      }
      return Ret;
  }
}