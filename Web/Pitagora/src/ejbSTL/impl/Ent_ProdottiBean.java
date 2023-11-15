package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.utl.*;
import java.util.Vector;
import java.rmi.RemoteException;
import java.net.*;

public class Ent_ProdottiBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getProdotti()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_PRODOTTI + "getProdotti";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Prodotto.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getProdotti",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  private String createXML(Vector lvct_Ret){

      DB_Prodotto lcls_Prodotto = null;
      String Ret = "";
      String lstr_CodePro = "";
      
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Prodotto = (DB_Prodotto)lvct_Ret.get(i);
        lstr_CodePro = lcls_Prodotto.getCODE_PRODOTTO();

        Ret += "<PRODOTTO ID=\"" + lstr_CodePro + "\">";
        Ret += "<DESC>" +  Utility.encodeXML(lcls_Prodotto.getDESC_PRODOTTO()) + "</DESC>";
        
        while (lstr_CodePro.equals(lcls_Prodotto.getCODE_PRODOTTO()))
        {
          Ret += "<PAR>";
          Ret += "<SERVIZIO>" + lcls_Prodotto.getCODE_SERVIZIO() + "</SERVIZIO>";
          Ret += "<OFFERTA>" + lcls_Prodotto.getCODE_OFFERTA() + "</OFFERTA>";
          Ret += "</PAR>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Prodotto = (DB_Prodotto)lvct_Ret.get(i);
        }
        i--;
        Ret += "</PRODOTTO>";
      }

      return Ret;
  }

  public String getProdottiXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getProdotti();
      return createXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getProdottiXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

 
}