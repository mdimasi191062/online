package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public class Ent_TipoRelazioniBean extends AbstractClassicEJB implements SessionBean 
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

  public Vector getAccountXGruppiAccount( int intCodeRelazione, int intCodeAccount  ) throws CustomException, RemoteException {

    try{

      String lstr_StoredProcedure = StaticContext.PKG_RELAZIONI + "getAccountXGruppiAccount";
      
      String[][] larr_CallSP =
                  {{lstr_StoredProcedure},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(intCodeRelazione)},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(intCodeAccount)}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AccountNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAccountXGruppiAccount",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public  Vector getGruppiAccount( int intCodeRelazione  )  throws CustomException, RemoteException{
    try{
    Vector lvct_Return = getGruppiAccount ( intCodeRelazione,"");
    return lvct_Return;
   }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getGruppiAccount",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public  Vector getGruppiAccount( int intCodeRelazione ,String strDescGruppo )  throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_RELAZIONI + "getGruppiAccount";
      
      String[][] larr_CallSP =
                  {{lstr_StoredProcedure},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(intCodeRelazione)},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDescGruppo}
                                      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AccountNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getGruppiAccount",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getRelazioni()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_RELAZIONI + "getRelazioni";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_TipoRelazioni.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getRelazioni",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getRelazioniXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getRelazioni();
      DB_TipoRelazioni lcls_TipoRelazione = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_TipoRelazione = (DB_TipoRelazioni)lvct_Ret.get(i);
        Ret += "<RELAZIONE ID=\"" + lcls_TipoRelazione.getCODE_TIPO_RELAZIONE() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_TipoRelazione.getDESC_TIPO_RELAZIONE()) + "</DESC></RELAZIONE>";
       
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getRelazioniXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

 public int eliminaAccountDalGruppo( String strCodeAccount, String strCodeGruppo, int intCodeRelazione ) 
  throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_RELAZIONI + "eliminaAccountDalGruppo";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeAccount},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeGruppo},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(intCodeRelazione)}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"eliminaAccountDalGruppo",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


 public int inserisciAccountInGruppo( String strCodeAccount, String strCodeGruppo, int intCodeRelazione , String strDataInizio, String strDataFine, String strAccountPadre ) 
  throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_RELAZIONI + "inserisciAccountInGruppo";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeAccount},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeGruppo},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(intCodeRelazione)},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataInizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataFine},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strAccountPadre}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"inserisciElabBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAccount ( String strDescAccount,String strCodeAccount)
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_RELAZIONI + "getaccountdesc_gruppiTar";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDescAccount},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeAccount}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountdesc",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAccount (  )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_RELAZIONI + "getAccount";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_Account.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
}