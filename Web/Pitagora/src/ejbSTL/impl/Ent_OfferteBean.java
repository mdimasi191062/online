package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;


public class Ent_OfferteBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getOfferte()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_OFFERTE + "getOfferte";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Offerta.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOfferte",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  private String createXML(Vector lvct_Ret){

      DB_Offerta lcls_Offerta = null;
      String Ret = "";
      String lstr_CodeOff = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Offerta = (DB_Offerta)lvct_Ret.get(i);
        lstr_CodeOff = lcls_Offerta.getCODE_OFFERTA();
        
        Ret += "<OFFERTA ID=\"" + lstr_CodeOff + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Offerta.getDESC_OFFERTA()) + "</DESC>";
        while (lstr_CodeOff.equals(lcls_Offerta.getCODE_OFFERTA()))
        {
          Ret += "<SERVIZIO>" + lcls_Offerta.getCODE_SERVIZIO() + "</SERVIZIO>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Offerta = (DB_Offerta)lvct_Ret.get(i);
        }
        i--;
        Ret += "</OFFERTA>";
      }
      return Ret;
  }

  public String getOfferteXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getOfferte();
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOfferteXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

    public Vector getOfferte(int Servizio,int Prodotto)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_OFFERTE + "getOfferte";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Servizio)},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Prodotto)},
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Offerta.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOfferte(" + Servizio + "," + Prodotto + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getOfferteXml(int Servizio,int Prodotto)throws CustomException, RemoteException{
    try{
    
      Vector lvct_Ret = getOfferte(Servizio,Prodotto);
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getOfferteXml(" + Servizio + "," + Prodotto + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

}