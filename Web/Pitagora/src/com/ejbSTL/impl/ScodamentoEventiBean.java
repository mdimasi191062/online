package com.ejbSTL.impl;

import com.utl.AbstractClassicEJB;
import com.utl.AbstractEJBTypes;
import com.utl.CustomException;
import com.utl.DBMessage;
import com.utl.DB_ScodamentoEventi;

import com.utl.DB_Gestori;
import com.utl.DB_PreOfferte;
import com.utl.StaticContext;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class ScodamentoEventiBean extends AbstractClassicEJB implements SessionBean
{
  private SessionContext _context;

  public void ejbCreate()
  {
  }

  public void setSessionContext(SessionContext context) throws EJBException
  {
    _context = context;
  }

  public void ejbRemove() throws EJBException
  {
  }

  public void ejbActivate() throws EJBException
  {
  }

  public void ejbPassivate() throws EJBException
  {
  }
  
  public Vector getScodamentoEventi() throws CustomException, RemoteException {
    
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getScodamentoEventi";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_ScodamentoEventi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                  
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreScodamentoEventi",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }    
  }
  

 
  
  public String aggScodamentoEventi(DB_ScodamentoEventi ScodamentoEventi) throws CustomException, RemoteException {
    
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PACKAGE_SPECIAL_ONLINE + ".aggScodamentoEventi";
    String lstr_StoredProcedureName_error = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ScodamentoEventi.getCOD_LOTTO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,  ScodamentoEventi.getDATA_FINE()},
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "aggiorna_gestore",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
    }
  
  }
  
  
  
  public Vector getPreScodamentoEventi_codLotto(String codeAliquota)throws CustomException, RemoteException{
    try{

      String lstr_StoredProcedure = StaticContext.PACKAGE_SPECIAL_ONLINE + ".getpreScodamentoEventi_codLotto";

      String[][] larr_CallSP ={
          {lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeAliquota}
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_ScodamentoEventi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreScodamentoEventi_codLotto",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }



 

}
